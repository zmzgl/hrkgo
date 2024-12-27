package sys_model

import "time"

type Params struct {
	BeginTime string `form:"beginTime"`
	EndTime   string `form:"endTime"`
}

// DictListRequest 字典列表请求参数
type DictListRequest struct {
	DictName  string `form:"dictName"`          // 字典名称
	DictType  string `form:"dictType"`          // 字典类型
	Status    string `form:"status"`            // 状态（0正常 1停用）
	BeginTime string `form:"params[beginTime]"` // 使用 form 标签接收嵌套字段
	EndTime   string `form:"params[endTime]"`   // 使用 form 标签接收嵌套字段
	PageNum   int    `form:"pageNum"`
	PageSize  int    `form:"pageSize"`
}

type SysDictRedis struct {
	DictId     int64         `gorm:"primary_key;auto_increment;column:dict_id" json:"dictId"`          // 字典主键
	DictName   string        `gorm:"column:dict_name;size:100;default:''" json:"dictName"`             // 字典名称
	DictType   string        `gorm:"column:dict_type;size:100;default:'';uniqueIndex" json:"dictType"` // 字典类型
	Status     string        `gorm:"column:status;size:1;default:'0'" json:"status"`                   // 状态（0正常 1停用）
	CreateBy   string        `gorm:"column:create_by;size:64;default:''" json:"createBy"`              // 创建者
	CreateTime time.Time     `gorm:"column:create_time" json:"createTime"`                             // 创建时间
	UpdateBy   string        `gorm:"column:update_by;size:64;default:''" json:"updateBy"`              // 更新者
	UpdateTime time.Time     `gorm:"column:update_time" json:"updateTime"`                             // 更新时间
	Remark     string        `gorm:"column:remark;size:500" json:"remark"`                             // 备注
	Child      []SysDictData `gorm:"foreignKey:dict_type;references:dict_type" json:"child"`
}

// TableName 设置表名
func (s *SysDictRedis) TableName() string {
	return "sys_dict_type"
}

type SysDictType struct {
	DictId     int64     `gorm:"primary_key;auto_increment;column:dict_id" json:"dictId"`          // 字典主键
	DictName   string    `gorm:"column:dict_name;size:100;default:''" json:"dictName"`             // 字典名称
	DictType   string    `gorm:"column:dict_type;size:100;default:'';uniqueIndex" json:"dictType"` // 字典类型
	Status     string    `gorm:"column:status;size:1;default:'0'" json:"status"`                   // 状态（0正常 1停用）
	CreateBy   string    `gorm:"column:create_by;size:64;default:''" json:"createBy"`              // 创建者
	CreateTime time.Time `gorm:"column:create_time" json:"createTime"`                             // 创建时间
	UpdateBy   string    `gorm:"column:update_by;size:64;default:''" json:"updateBy"`              // 更新者
	UpdateTime time.Time `gorm:"column:update_time" json:"updateTime"`                             // 更新时间
	Remark     string    `gorm:"column:remark;size:500" json:"remark"`                             // 备注
}

// TableName 设置表名
func (s *SysDictType) TableName() string {
	return "sys_dict_type"
}

type SysDictData struct {
	DictCode   int64     `gorm:"primary_key;auto_increment;column:dict_code" json:"dictCode"` // 字典编码
	DictSort   int       `gorm:"column:dict_sort;default:0" json:"dictSort"`                  // 字典排序
	DictLabel  string    `gorm:"column:dict_label;size:100;default:''" json:"dictLabel"`      // 字典标签
	DictValue  string    `gorm:"column:dict_value;size:100;default:''" json:"dictValue"`      // 字典键值
	DictType   string    `gorm:"column:dict_type;size:100;default:''" json:"dictType"`        // 字典类型
	CssClass   string    `gorm:"column:css_class;size:100" json:"cssClass"`                   // 样式属性
	ListClass  string    `gorm:"column:list_class;size:100" json:"listClass"`                 // 表格回显样式
	IsDefault  string    `gorm:"column:is_default;size:1;default:'N'" json:"isDefault"`       // 是否默认（Y是 N否）
	Status     string    `gorm:"column:status;size:1;default:'0'" json:"status"`              // 状态（0正常 1停用）
	CreateBy   string    `gorm:"column:create_by;size:64;default:''" json:"createBy"`         // 创建者
	CreateTime time.Time `gorm:"column:create_time" json:"createTime"`                        // 创建时间
	UpdateBy   string    `gorm:"column:update_by;size:64;default:''" json:"updateBy"`         // 更新者
	UpdateTime time.Time `gorm:"column:update_time" json:"updateTime"`                        // 更新时间
	Remark     string    `gorm:"column:remark;size:500" json:"remark"`                        // 备注
}

// TableName 设置表名
func (s *SysDictData) TableName() string {
	return "sys_dict_data"
}
