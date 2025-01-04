package sys_repositories

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
)

// MenuCrud 实现 IMenuCrud 接口
type menuCrud struct{}

var MenuCrud = new(menuCrud)

// SelectMenuList 实现接口方法
func (m *menuCrud) SelectMenuList() ([]*sys_model.SysMenu, error) {
	var menuList []*sys_model.SysMenu
	err := variable.GormDbMysql.Model(&sys_model.SysMenu{}).Find(&menuList).Error
	return menuList, err
}

// GetMenuTreeAll 查询所有树状图
func (m *menuCrud) GetMenuTreeAll() ([]*sys_model.SysMenu, error) {
	var menus []*sys_model.SysMenu
	// 一次性查询所有菜单
	err := variable.GormDbMysql.Where("status = '0' and menu_type != ?", "F").
		Order("order_num").
		Find(&menus).Error
	return menus, err
}
