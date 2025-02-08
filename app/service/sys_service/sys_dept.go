package sys_service

import (
	"fmt"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/repositories/sys_repositories"
	"hrkGo/utils/StringUtils"
)

type DeptService struct {
}

// SelectDeptList 获取部门树
func (u *DeptService) SelectDeptList(req sys_model.DeptListRequest, dataScope string) ([]*sys_model.SysDept, error) {

	deptList, err := sys_repositories.DeptCrud.SelectDeptList(req, dataScope)
	return deptList, err
}

// HasChildByDeptId 查询是否有下级
func (u *DeptService) HasChildByDeptId(deptId string) (isHasChild bool) {
	result := sys_repositories.DeptCrud.HasChildByDeptId(deptId)
	return result > 0
}

// CheckDeptExistUser 部门是否有用户
func (u *DeptService) CheckDeptExistUser(deptId string) (isHasChild bool) {
	result := sys_repositories.DeptCrud.CheckDeptExistUser(deptId)
	return result > 0
}

// CheckDeptDataScope 校验部门是否有数据权限
func (u *DeptService) CheckDeptDataScope(deptId string, dataScope string) (isHasChild bool) {
	var dept sys_model.DeptListRequest
	dept.DeptId = deptId
	deptList, _ := sys_repositories.DeptCrud.SelectDeptList(dept, dataScope)
	fmt.Println("StringUtils.IsNotEmpty(deptList)", deptList, StringUtils.IsNotEmpty(deptList))
	return StringUtils.IsNotEmpty(deptList)
}

// BuildDeptTree 获取部门树
func (u *DeptService) BuildDeptTree(deptList []*sys_model.SysDept) []*sys_model.TreeSelect {
	// 创建 map 用于快速查找
	deptMap := make(map[string]*sys_model.TreeSelect)
	var rootNodes []*sys_model.TreeSelect

	// 第一次遍历：创建所有节点
	for _, dept := range deptList {
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
