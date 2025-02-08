package sys_repositories

import (
	"fmt"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
)

type deptCrud struct{}

var DeptCrud = new(deptCrud)

// SelectDeptList 实现接口方法
func (m *deptCrud) SelectDeptList(req sys_model.DeptListRequest, dataScope string) ([]*sys_model.SysDept, error) {

	query := variable.GormDbMysql.Model(&sys_model.SysDept{}).Select("d.*").
		Table("sys_dept d").Where("del_flag = ?", "0")

	if req.DeptId != "" {
		query = query.Where("dept_id = ?", req.DeptId)
	}

	if req.ParentId != "" {
		query = query.Where("parent_id = ?", req.ParentId)
	}

	// 添加查询条件
	if req.DeptName != "" {
		query = query.Where("dept_name LIKE ?", "%"+req.DeptName+"%")
	}
	if req.Status != "" {
		query = query.Where("status = ?", req.Status)
	}

	// 添加数据权限控制
	if dataScope != "" {
		query = query.Where(dataScope)
	}

	var deptList []*sys_model.SysDept
	err := query.Order("parent_id, order_num").Find(&deptList).Error
	if err != nil {
		return nil, err
	}

	fmt.Println(deptList, "deptList")
	return deptList, nil
}

// HasChildByDeptId 判断是否有下级部门
func (m *deptCrud) HasChildByDeptId(deptId string) (count int64) {
	variable.GormDbMysql.Model(&sys_model.SysDept{}).Where("parent_id = ?", deptId).Count(&count)
	return count
}

// CheckDeptExistUser 判断是否有用户
func (m *deptCrud) CheckDeptExistUser(deptId string) (count int64) {
	variable.GormDbMysql.Model(&sys_model.SysUser{}).Where("dept_id = ?", deptId).Count(&count)
	return count
}
