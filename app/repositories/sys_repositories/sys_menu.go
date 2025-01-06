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

// SelectMenuPermsByUserId 查询所有树状图
func (m *menuCrud) SelectMenuPermsByUserId(userId int64) ([]string, error) {
	var perms []string

	err := variable.GormDbMysql.Model(&sys_model.SysMenu{}).
		Distinct("m.perms").
		Select("sys_menu.perms").
		Joins("LEFT JOIN sys_role_menu rm ON sys_menu.menu_id = rm.menu_id").
		Joins("LEFT JOIN sys_user_role ur ON rm.role_id = ur.role_id").
		Joins("LEFT JOIN sys_role r ON r.role_id = ur.role_id").
		Where("sys_menu.status = ? AND r.status = ? AND ur.user_id = ?", "0", "0", userId).
		Find(&perms).Error

	return perms, err
}
