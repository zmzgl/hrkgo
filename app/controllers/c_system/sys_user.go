package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
)

type UserController struct {
	UserService sys_service.UserService
	DeptService sys_service.DeptService
}

// DeptTree 部门列表
func (d UserController) DeptTree(c *gin.Context) {
	var req sys_model.DeptListRequest
	depts, err := d.DeptService.SelectDeptList(req)
	if err != nil {
		response.BusinessFail(c, "查询失败，请稍后再试")
	}
	TreeSelect := d.DeptService.BuildDeptTree(depts)
	response.Success(c, "查询成功", TreeSelect)

}
