package middleware

import (
	"fmt"
	"hrkGo/app/model/sys_model"
	"strings"
)

const (
	// 数据权限类型常量
	DataScopeAll          = "1" // 全部数据权限
	DataScopeCustom       = "2" // 自定数据权限
	DataScopeDept         = "3" // 部门数据权限
	DataScopeDeptAndChild = "4" // 部门及以下数据权限
	DataScopeSelf         = "5" // 仅本人数据权限
)

// DataScope 数据权限结构体
type DataScope struct {
	DeptAlias string
	UserAlias string
}

// DataScopeMiddleware 数据权限中间件
func DataScopeMiddleware(userString interface{}, deptAlias string, userAlias string) string {
	loginUser, _ := userString.(*sys_model.SysUserInfo)

	// 如果是超级管理员，则不过滤数据
	if sys_model.IsAdmin(loginUser.UserId) {
		return ""
	}

	// 方法2：使用简短声明
	scope := DataScope{
		DeptAlias: deptAlias,
		UserAlias: userAlias,
	}

	// 构建数据权限SQL
	dataScopeSql := buildDataScopeSql(loginUser, scope)

	fmt.Println(dataScopeSql)
	return dataScopeSql

}

// buildDataScopeSql 构建数据权限SQL
func buildDataScopeSql(user *sys_model.SysUserInfo, scope DataScope) string {
	var conditions []string
	var sqlBuilder strings.Builder

	for _, role := range user.Roles {
		if role.Status != "0" { // 角色被禁用
			continue
		}

		switch role.DataScope {
		case DataScopeAll:
			return "" // 全部数据权限，无需添加过滤条件

		case DataScopeCustom:
			conditions = append(conditions,
				fmt.Sprintf("%s.dept_id IN (SELECT dept_id FROM sys_role_dept WHERE role_id = %s)",
					scope.DeptAlias, role.RoleId))

		case DataScopeDept:
			conditions = append(conditions,
				fmt.Sprintf("%s.dept_id = %d", scope.DeptAlias, user.DeptId))

		case DataScopeDeptAndChild:
			conditions = append(conditions,
				fmt.Sprintf("%s.dept_id IN (SELECT dept_id FROM sys_dept WHERE dept_id = %s OR find_in_set(%s, ancestors))",
					scope.DeptAlias, user.DeptId, user.DeptId))

		case DataScopeSelf:
			if scope.UserAlias != "" {
				conditions = append(conditions,
					fmt.Sprintf("%s.user_id = %s", scope.UserAlias, user.UserId))
			} else {
				conditions = append(conditions,
					fmt.Sprintf("%s.dept_id = 0", scope.DeptAlias))
			}
		}
	}

	// 如果没有任何权限，则限制不能查看任何数据
	if len(conditions) == 0 {
		return fmt.Sprintf(" AND %s.dept_id = 0", scope.DeptAlias)
	}

	sqlBuilder.WriteString(strings.Join(conditions, " OR "))

	return sqlBuilder.String()
}
