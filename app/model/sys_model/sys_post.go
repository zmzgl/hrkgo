package sys_model

import (
	"hrkGo/app/model"
	"time"
)

// PostListRequest 角色列表请求参数
type PostListRequest struct {
	model.PageInfo
}

// SysPost 岗位信息表
type SysPost struct {
	PostId     int64     `json:"postId" gorm:"primary_key;auto_increment;comment:'岗位ID'"`
	PostCode   string    `json:"postCode" gorm:"type:varchar(64);not null;comment:'岗位编码'"`
	PostName   string    `json:"postName" gorm:"type:varchar(50);not null;comment:'岗位名称'"`
	PostSort   int       `json:"postSort" gorm:"type:int(4);not null;comment:'显示顺序'"`
	Status     string    `json:"status" gorm:"type:char(1);not null;comment:'状态（0正常 1停用）'"`
	CreateBy   string    `json:"createBy" gorm:"type:varchar(64);default:'';comment:'创建者'"`
	CreateTime time.Time `json:"createTime" gorm:"type:datetime;comment:'创建时间'"`
	UpdateBy   string    `json:"updateBy" gorm:"type:varchar(64);default:'';comment:'更新者'"`
	UpdateTime time.Time `json:"updateTime" gorm:"type:datetime;comment:'更新时间'"`
	Remark     string    `json:"remark" gorm:"type:varchar(500);comment:'备注'"`
}

// TableName 设置表名
func (SysPost) TableName() string {
	return "sys_post"
}
