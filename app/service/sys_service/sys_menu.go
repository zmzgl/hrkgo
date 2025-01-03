package sys_service

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/StringUtils"
	"hrkGo/utils/global/consts"
	"hrkGo/utils/global/variable"
	"strings"
)

type MenuCurd struct {
}

// MenuTree 定义菜单树结构
type MenuTree struct {
	*sys_model.SysMenu
	Children []*MenuTree `json:"children"`
}

// GetMenuTreeAll 定义菜单树结构 一次性查询所有数据，然后组装树（推荐，性能更好
func (m *MenuCurd) GetMenuTreeAll() ([]*MenuTree, error) {
	var menus []*sys_model.SysMenu

	// 一次性查询所有菜单
	err := variable.GormDbMysql.Where("status = '0' and menu_type != ?", "F").
		Order("order_num").
		Find(&menus).Error
	if err != nil {
		return nil, err
	}

	// 转换为map，方便查找
	menuMap := make(map[int64]*MenuTree)
	var trees []*MenuTree

	// 先转换为MenuTree对象
	for _, menu := range menus {
		menuMap[menu.MenuId] = &MenuTree{
			SysMenu:  menu,
			Children: make([]*MenuTree, 0),
		}
	}

	// 组装树
	for _, menu := range menus {
		tree := menuMap[menu.MenuId]
		if menu.ParentId == 0 {
			// 根节点
			trees = append(trees, tree)
		} else {
			// 非根节点
			if parent, ok := menuMap[menu.ParentId]; ok {
				parent.Children = append(parent.Children, tree)
			}
		}
	}

	return trees, nil
}

// SelectMenuList
func (m *MenuCurd) SelectMenuList(userId uint64) ([]*sys_model.RouterVo, error) {
	//List<SysMenu> menuList = nil;
	//// 管理员显示所有菜单信息
	//if sys_model.IsAdmin(int64(userId)) {
	//	menuList = menuMapper.selectMenuList(menu);
	//}
	//else
	//{
	//	menu.getParams().put("userId", userId);
	//	menuList = menuMapper.selectMenuListByUserId(menu);
	//}
	//return menuList;
	return nil, nil
}

func (m *MenuCurd) BuildMenus(menus []*MenuTree) []*sys_model.RouterVo {
	routers := make([]*sys_model.RouterVo, 0)
	for _, menu := range menus {
		router := &sys_model.RouterVo{}
		router.Hidden = menu.Visible == "1"

		// 设置路由基本信息
		router.Name = getRouteName(menu)
		router.MenuType = menu.MenuType
		router.Path = getRouterPath(menu)
		router.Query = menu.Query
		router.Component = getComponent(menu)

		// 设置 Meta 信息
		router.Meta = sys_model.MetaVo{
			Title:   menu.MenuName,
			Icon:    menu.Icon,
			NoCache: menu.IsCache == 1,
			Link:    ternary(menu.Path),
		}
		if StringUtils.IsNotEmpty(menu.Children) && consts.TYPE_DIR == menu.MenuType {
			router.AlwaysShow = true
			router.Redirect = "noRedirect"
			//router.setChildren(buildMenus(cMenus))
		}

		// 处理子菜单
		if len(menu.Children) > 0 {
			if menu.MenuType == "M" && len(menu.Children) == 1 {
				router.AlwaysShow = false
			} else {
				router.AlwaysShow = true
			}

			// 递归处理子菜单
			children := m.BuildMenus(menu.Children)
			if len(children) > 0 {
				router.Children = children // 直接赋值所有子菜单
			}
		}

		routers = append(routers, router)
	}
	return routers
}

// ternary 使用辅助函数
func ternary(Path string) string {
	if StringUtils.IsHttp(Path) {
		return Path
	}
	return ""
}

func getComponent(menu *MenuTree) string {
	component := consts.LAYOUT
	if StringUtils.IsBlank(menu.Component) {
		component = menu.Component
	} else if StringUtils.IsEmptyStr(menu.Component) && menu.ParentId != 0 && isInnerLink(menu) {
		component = consts.INNER_LINK
	} else if StringUtils.IsEmptyStr(menu.Component) && isParentView(menu) {
		component = consts.PARENT_VIEW
	}

	return component
}

// isParentView 是否为parent_view组件
func isParentView(menu *MenuTree) bool {
	return menu.ParentId != 0 && consts.TYPE_DIR == menu.MenuType
}

// getRouteName 获取路由名称
func getRouteName(menu *MenuTree) string {
	routerName := StringUtils.Capitalize(menu.Path)
	// 非外链并且是一级目录（类型为目录）
	if isMenuFrame(menu) {
		routerName = consts.EMPTY
	}
	return routerName
}

func getRouterPath(menu *MenuTree) string {
	routerPath := menu.Path
	// 内链打开外网方式
	if menu.ParentId != 0 && isInnerLink(menu) {
		routerPath = innerLinkReplaceEach(routerPath)
	}
	// 非外链并且是一级目录（类型为目录）
	if 0 == menu.ParentId && consts.TYPE_DIR == menu.MenuType && consts.NO_FRAME == menu.IsFrame {
		routerPath = "/" + menu.Path
	} else if isMenuFrame(menu) {
		// 非外链并且是一级目录（类型为菜单）
		routerPath = "/"
	}
	return routerPath
}

// isMenuFrame 是否为菜单内部跳转
func isMenuFrame(menu *MenuTree) bool {
	return menu.ParentId == 0 && consts.TYPE_MENU == menu.MenuType && menu.IsFrame == consts.NO_FRAME
}

// isInnerLink 是否为内链组件
func isInnerLink(menu *MenuTree) bool {
	return menu.IsFrame == consts.NO_FRAME && StringUtils.IsHttp(menu.Path)
}

// isInnerLink 内链域名特殊字符替换 return 替换后的内链域名
func innerLinkReplaceEach(path string) string {
	return strings.NewReplacer(
		"http://", "",
		"https://", "",
		"www.", "",
		".", "/",
		":", "/",
	).Replace(path)
}
