package sys_model

import (
	"time"
)

// SysDept 部门表
type SysDept struct {
	DeptId     string    `gorm:"primaryKey;column:dept_id;autoIncrement" json:"deptId"`                        // 部门id
	ParentId   string    `gorm:"column:parent_id;default:0" json:"parentId"`                                   // 父部门id
	Ancestors  string    `gorm:"column:ancestors;type:varchar(50);default:''" json:"ancestors"`                // 祖级列表
	DeptName   string    `gorm:"column:dept_name;type:varchar(30);default:''" json:"deptName" form:"deptName"` // 部门名称
	OrderNum   int       `gorm:"column:order_num;default:0" json:"orderNum"`                                   // 显示顺序
	Leader     string    `gorm:"column:leader;type:varchar(20)" json:"leader"`                                 // 负责人
	Phone      string    `gorm:"column:phone;type:varchar(11)" json:"phone"`                                   // 联系电话
	Email      string    `gorm:"column:email;type:varchar(50)" json:"email"`                                   // 邮箱
	Status     string    `gorm:"column:status;type:char(1);default:'0'" json:"status" form:"status"`           // 部门状态（0正常 1停用）
	DelFlag    string    `gorm:"column:del_flag;type:char(1);default:'0'" json:"delFlag"`                      // 删除标志（0代表存在 2代表删除）
	CreateBy   string    `gorm:"column:create_by;type:varchar(64);default:''" json:"createBy"`                 // 创建者
	CreateTime time.Time `gorm:"column:create_time" json:"createTime"`                                         // 创建时间
	UpdateBy   string    `gorm:"column:update_by;type:varchar(64);default:''" json:"updateBy"`                 // 更新者
	UpdateTime time.Time `gorm:"column:update_time" json:"updateTime"`                                         // 更新时间
}

// TableName 设置表名
func (SysDept) TableName() string {
	return "sys_dept" // 返回实际的表名
}
