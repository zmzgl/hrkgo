package sys_model

import "time"

// SysUser 用户信息表
type SysUser struct {
	UserId      int64     `json:"userId" gorm:"primary_key;column:user_id;auto_increment;comment:'用户ID'"`
	DeptId      int64     `json:"deptId" gorm:"column:dept_id;comment:'部门ID'"`
	OpenId      string    `json:"OpenId" gorm:"column:open_id;comment:'微信openid'"`
	UserName    string    `json:"userName" gorm:"column:user_name;not null;comment:'用户账号'"`
	NickName    string    `json:"nickName" gorm:"column:nick_name;not null;comment:'用户昵称'"`
	UserType    string    `json:"userType" gorm:"column:user_type;default:'00';comment:'用户类型（00系统用户）'"`
	Email       string    `json:"email" gorm:"column:email;default:'';comment:'用户邮箱'"`
	Phonenumber string    `json:"phonenumber" gorm:"column:phonenumber;default:'';comment:'手机号码'"`
	Sex         string    `json:"sex" gorm:"column:sex;default:'0';comment:'用户性别（0男 1女 2未知）'"`
	Avatar      string    `json:"avatar" gorm:"column:avatar;default:'';comment:'头像地址'"`
	Password    string    `json:"password" gorm:"column:password;default:'';comment:'密码'"`
	Status      string    `json:"status" gorm:"column:status;default:'0';comment:'帐号状态（0正常 1停用）'"`
	DelFlag     string    `json:"delFlag" gorm:"column:del_flag;default:'0';comment:'删除标志（0代表存在 2代表删除）'"`
	LoginIp     string    `json:"loginIp" gorm:"column:login_ip;default:'';comment:'最后登录IP'"`
	LoginDate   time.Time `json:"loginDate" gorm:"column:login_date;comment:'最后登录时间'"`
	CreateBy    string    `json:"createBy" gorm:"column:create_by;default:'';comment:'创建者'"`
	CreateTime  time.Time `json:"createTime" gorm:"column:create_time;comment:'创建时间'"`
	UpdateBy    string    `json:"updateBy" gorm:"column:update_by;default:'';comment:'更新者'"`
	UpdateTime  time.Time `json:"updateTime" gorm:"column:update_time;comment:'更新时间'"`
	Remark      string    `json:"remark" gorm:"column:remark;comment:'备注'"`
}

// TableName 设置表名
func (SysUser) TableName() string {
	return "sys_user"
}

// SysUser 用户信息表
type SysUserInfo struct {
	UserId      int64     `json:"userId" gorm:"primary_key;column:user_id;auto_increment;comment:'用户ID'"`
	DeptId      int64     `json:"deptId" gorm:"column:dept_id;comment:'部门ID'"`
	UserName    string    `json:"userName" gorm:"column:user_name;not null;comment:'用户账号'"`
	NickName    string    `json:"nickName" gorm:"column:nick_name;not null;comment:'用户昵称'"`
	UserType    string    `json:"userType" gorm:"column:user_type;default:'00';comment:'用户类型（00系统用户）'"`
	Email       string    `json:"email" gorm:"column:email;default:'';comment:'用户邮箱'"`
	Phonenumber string    `json:"phonenumber" gorm:"column:phonenumber;default:'';comment:'手机号码'"`
	Sex         string    `json:"sex" gorm:"column:sex;default:'0';comment:'用户性别（0男 1女 2未知）'"`
	Avatar      string    `json:"avatar" gorm:"column:avatar;default:'';comment:'头像地址'"`
	Password    string    `json:"password" gorm:"column:password;default:'';comment:'密码'"`
	Status      string    `json:"status" gorm:"column:status;default:'0';comment:'帐号状态（0正常 1停用）'"`
	DelFlag     string    `json:"delFlag" gorm:"column:del_flag;default:'0';comment:'删除标志（0代表存在 2代表删除）'"`
	LoginIp     string    `json:"loginIp" gorm:"column:login_ip;default:'';comment:'最后登录IP'"`
	LoginDate   time.Time `json:"loginDate" gorm:"column:login_date;comment:'最后登录时间'"`
	CreateBy    string    `json:"createBy" gorm:"column:create_by;default:'';comment:'创建者'"`
	CreateTime  time.Time `json:"createTime" gorm:"column:create_time;comment:'创建时间'"`
	UpdateBy    string    `json:"updateBy" gorm:"column:update_by;default:'';comment:'更新者'"`
	UpdateTime  time.Time `json:"updateTime" gorm:"column:update_time;comment:'更新时间'"`
	Remark      string    `json:"remark" gorm:"column:remark;comment:'备注'"`
	Dept        SysDept   `json:"dept"`
	Roles       []SysRole `json:"roles" gorm:"many2many:sys_user_role;joinForeignKey:user_id;joinReferences:role_id"`
}

// TableName 设置表名
func (SysUserInfo) TableName() string {
	return "sys_user"
}

// IsAdmin 判断是不是超管
func IsAdmin(userID int64) bool {
	return userID == 1
}
