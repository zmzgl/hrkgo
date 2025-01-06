package sys_service

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/app/repositories/sys_repositories"
)

type DeptCurd struct {
}

// GeDeptList 获取部门树
func (u *DeptCurd) GeDeptList(req sys_model.DeptListRequest) ([]*sys_model.SysDept, error) {
	depts, err := sys_repositories.DeptCrud.GeDeptList(req)
	return depts, err
}
