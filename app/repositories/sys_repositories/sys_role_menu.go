package sys_repositories

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
)

// romeMenuCrud 实现 romeMenuCrud 接口
type romeMenuCrud struct{}

var RomeMenuCrud = new(romeMenuCrud)

// CheckMenuExistRole 查询有没有子菜单
func (m *romeMenuCrud) CheckMenuExistRole(menuId string) (count int64) {
	variable.GormDbMysql.Model(&sys_model.SysRoleMenu{}).Where("menu_id = ?", menuId).Count(&count)
	return count
}
