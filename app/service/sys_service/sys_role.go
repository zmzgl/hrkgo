package sys_service

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
)

type RoleCurd struct {
}

// GetRoleList 获取角色列表
func (u *RoleCurd) GetRoleList(req sys_model.RoleListRequest) (list []sys_model.SysRole, total int64, err error) {
	// 构建查询条件
	db := variable.GormDbMysql.Model(&sys_model.SysRole{})

	// 名称模糊查询
	if req.RoleName != "" {
		db = db.Where("role_name LIKE ?", "%"+req.RoleName+"%")
	}
	// 状态查询
	if req.Status != "" {
		db = db.Where("status = ?", req.Status)
	}
	err = db.Count(&total).Error
	if err != nil {
		return nil, 0, err
	}

	// 查询列表
	offset := (req.PageNum - 1) * req.PageSize

	err = db.
		Offset(offset).
		Limit(req.PageSize).
		Find(&list).Error

	return list, total, err
}
