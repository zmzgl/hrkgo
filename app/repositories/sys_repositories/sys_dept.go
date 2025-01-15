package sys_repositories

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
)

type deptCrud struct{}

var DeptCrud = new(deptCrud)

// SelectDeptList 实现接口方法
func (m *deptCrud) SelectDeptList(req sys_model.SysDept) ([]*sys_model.SysDept, error) {
	query := variable.GormDbMysql.Model(&sys_model.SysDept{}).Where("del_flag = ?", "0")

	// 添加查询条件
	if req.DeptName != "" {
		query = query.Where("dept_name LIKE ?", "%"+req.DeptName+"%")
	}
	if req.Status != "" {
		query = query.Where("status = ?", req.Status)
	}

	var depts []*sys_model.SysDept
	err := query.Order("parent_id, order_num").Find(&depts).Error
	if err != nil {
		return nil, err
	}
	return depts, nil
}
