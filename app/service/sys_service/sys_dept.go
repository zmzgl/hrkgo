package sys_service

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/app/repositories/sys_repositories"
)

type DeptService struct {
}

// SelectDeptList 获取部门树
func (u *DeptService) SelectDeptList(req sys_model.DeptListRequest) ([]*sys_model.SysDept, error) {
	depts, err := sys_repositories.DeptCrud.SelectDeptList(req)
	return depts, err
}

// BuildDeptTree 获取部门树
func (u *DeptService) BuildDeptTree(depts []*sys_model.SysDept) []*sys_model.TreeSelect {
	// 创建 map 用于快速查找
	deptMap := make(map[string]*sys_model.TreeSelect)
	var rootNodes []*sys_model.TreeSelect

	// 第一次遍历：创建所有节点
	for _, dept := range depts {
		node := &sys_model.TreeSelect{
			Id:       dept.DeptId,
			Label:    dept.DeptName,
			Disabled: dept.Status == "1",
			Children: make([]*sys_model.TreeSelect, 0),
		}
		deptMap[dept.DeptId] = node

		// 如果是根节点，加入 rootNodes
		if dept.ParentId == "0" {
			rootNodes = append(rootNodes, node)
			continue
		}

		// 将当前节点添加到父节点的 children 中
		if parent, exists := deptMap[dept.ParentId]; exists {
			parent.Children = append(parent.Children, node)
		}
	}

	return rootNodes
}
