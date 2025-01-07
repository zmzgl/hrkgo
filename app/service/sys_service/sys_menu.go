package sys_service

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/app/repositories/sys_repositories"
	"hrkGo/utils/StringUtils"
	"hrkGo/utils/global/consts"
	"strings"
)

type MenuService struct {
}

// SelectMenuList 获取菜单下拉树列表
func (m *MenuService) SelectMenuList(userId uint64) (menuList []*sys_model.SysMenu, err error) {
	// 管理员显示所有菜单信息
	if sys_model.IsAdmin(int64(userId)) {
		menuList, err = sys_repositories.MenuCrud.SelectMenuList()
	}
	return menuList, err
}

// BuildMenuTreeSelect 下拉树结构列表
func (m *MenuService) BuildMenuTreeSelect(menus []*sys_model.SysMenu) (menuList []*sys_model.SelectMenuTree) {
	menuTrees := buildMenuTree(menus)
	return menuTrees
}

// LoginSelectMenuPermsByUserId 用户权限列表
func (m *MenuService) LoginSelectMenuPermsByUserId(userId int64) (permsSet []string) {
	// 管理员拥有所有权限
	if sys_model.IsAdmin(userId) {
		permsSet = append(permsSet, "*:*:*")
	} else {
		perms, _ := sys_repositories.MenuCrud.SelectMenuPermsByUserId(userId)
		permsSet = SplitPerms(perms)
	}
	return permsSet
}

// SplitPerms 工具函数：将权限字符串切片转换为去重后的权限集合
func SplitPerms(perms []string) []string {
	// 使用 map 来去重
	permMap := make(map[string]struct{})

	// 遍历权限
	for _, perm := range perms {
		// 判断非空
		if strings.TrimSpace(perm) != "" {
			// 分割权限字符串
			splitPerms := strings.Split(perm, ",")
			// 遍历分割后的权限
			for _, p := range splitPerms {
				// 去除首尾空格并添加到 map 中
				trimmed := strings.TrimSpace(p)
				if trimmed != "" {
					permMap[trimmed] = struct{}{}
				}
			}
		}
	}

	// 将 map 转换为切片
	result := make([]string, 0, len(permMap))
	for p := range permMap {
		result = append(result, p)
	}

	return result
}

// GetMenuTreeAll 定义菜单树结构 一次性查询所有数据，然后组装树（推荐，性能更好
func (m *MenuService) GetMenuTreeAll() ([]*sys_model.MenuTree, error) {

	menus, err := sys_repositories.MenuCrud.GetMenuTreeAll()

	if err != nil {
		return nil, err
	}

	// 转换为map，方便查找
	menuMap := make(map[int64]*sys_model.MenuTree)
	var trees []*sys_model.MenuTree

	// 先转换为MenuTree对象
	for _, menu := range menus {
		menuMap[menu.MenuId] = &sys_model.MenuTree{
			SysMenu:  menu,
			Children: make([]*sys_model.MenuTree, 0),
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

// BuildMenus  拼接路由
func (m *MenuService) BuildMenus(menus []*sys_model.MenuTree) []*sys_model.RouterVo {
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
		//if StringUtils.IsNotEmpty(menu.Children) && consts.TYPE_DIR == menu.MenuType {
		//	router.AlwaysShow = true
		//	//router.setChildren(buildMenus(cMenus))
		//}
		if menu.IsFrame == "1" {
			router.Redirect = "noRedirect"
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

// buildMenuTree 构建菜单树 - 使用 MenuTree 结构
func buildMenuTree(menus []*sys_model.SysMenu) []*sys_model.SelectMenuTree {
	menuMap := make(map[uint]*sys_model.SelectMenuTree, len(menus))
	var roots []*sys_model.SelectMenuTree

	// 第一次遍历：转换为 SelectMenuTree 并建立映射关系
	for _, menu := range menus {
		tree := &sys_model.SelectMenuTree{
			TreeSelect: &sys_model.TreeSelect{
				Id:       menu.MenuId,
				Label:    menu.MenuName,
				Disabled: menu.Status == "1", // 假设状态为1时表示禁用
			},
			Children: make([]*sys_model.TreeSelect, 0),
		}
		menuMap[uint(menu.MenuId)] = tree

		// 如果是根节点
		if menu.ParentId == 0 {
			roots = append(roots, tree)
		}
	}

	// 第二次遍历：建立父子关系
	for _, menu := range menus {
		if menu.ParentId != 0 {
			if parent, exists := menuMap[uint(menu.ParentId)]; exists {
				childNode := &sys_model.TreeSelect{
					Id:       menu.MenuId,
					Label:    menu.MenuName,
					Disabled: menu.Status == "1",
				}
				parent.Children = append(parent.Children, childNode)
			}
		}
	}

	return roots
}

// ternary 使用辅助函数
func ternary(Path string) string {
	if StringUtils.IsHttp(Path) {
		return Path
	}
	return ""
}

// getComponent 判断组件类型
func getComponent(menu *sys_model.MenuTree) string {
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
func isParentView(menu *sys_model.MenuTree) bool {
	return menu.ParentId != 0 && consts.TYPE_DIR == menu.MenuType
}

// getRouteName 获取路由名称
func getRouteName(menu *sys_model.MenuTree) string {
	routerName := StringUtils.Capitalize(menu.Path)
	// 非外链并且是一级目录（类型为目录）
	if isMenuFrame(menu) {
		routerName = consts.EMPTY
	}
	return routerName
}

func getRouterPath(menu *sys_model.MenuTree) string {
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
func isMenuFrame(menu *sys_model.MenuTree) bool {
	return menu.ParentId == 0 && consts.TYPE_MENU == menu.MenuType && menu.IsFrame == consts.NO_FRAME
}

// isInnerLink 是否为内链组件
func isInnerLink(menu *sys_model.MenuTree) bool {
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
