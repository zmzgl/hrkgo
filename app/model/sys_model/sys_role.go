package sys_model

import (
	"time"
)

// RoleListRequest 角色列表请求参数
type RoleListRequest struct {
	RoleName string `form:"roleName"`
	Status   string `form:"status" `
	RoleKey  string `form:"roleKey"`
	PageNum  int    `form:"pageNum"`
	PageSize int    `form:"pageSize"`
}

// SysRole 角色信息表
type SysRole struct {
	RoleId            int64      `json:"roleId" gorm:"primary_key;column:role_id;comment:角色ID"`
	RoleName          string     `json:"roleName" gorm:"column:role_name;comment:角色名称"`
	RoleKey           string     `json:"roleKey" gorm:"column:role_key;comment:角色权限字符串"`
	RoleSort          int        `json:"roleSort" gorm:"column:role_sort;comment:显示顺序"`
	DataScope         string     `json:"dataScope" gorm:"column:data_scope;default:1;comment:数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）"`
	MenuCheckStrictly bool       `json:"menuCheckStrictly" gorm:"column:menu_check_strictly;default:1;comment:菜单树选择项是否关联显示"`
	DeptCheckStrictly bool       `json:"deptCheckStrictly" gorm:"column:dept_check_strictly;default:1;comment:部门树选择项是否关联显示"`
	Status            string     `json:"status" gorm:"column:status;comment:角色状态（0正常 1停用）"`
	DelFlag           string     `json:"delFlag" gorm:"column:del_flag;default:0;comment:删除标志（0代表存在 2代表删除）"`
	CreateBy          string     `json:"createBy" gorm:"column:create_by;comment:创建者"`
	CreateTime        *time.Time `json:"createTime" gorm:"column:create_time;comment:创建时间;type:datetime;"`
	UpdateBy          string     `json:"updateBy" gorm:"column:update_by;comment:更新者"`
	UpdateTime        *time.Time `json:"updateTime" gorm:"column:update_time;comment:更新时间;type:datetime;"`
	Remark            string     `json:"remark" gorm:"column:remark;comment:备注"`
}

// TableName 指定表名
func (SysRole) TableName() string {
	return "sys_role"
}
