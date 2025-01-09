package sys_model

// SysRoleMenu 角色和菜单关联表
type SysRoleMenu struct {
	RoleID string `gorm:"column:role_id;primary_key;comment:角色ID" json:"roleId"` // 角色ID
	MenuID string `gorm:"column:menu_id;primary_key;comment:菜单ID" json:"menuId"` // 菜单ID
}

// TableName 设置表名
func (SysRoleMenu) TableName() string {
	return "sys_role_menu"
}
