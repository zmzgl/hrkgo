package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
)

type DeptController struct {
	DeptService sys_service.DeptService
}

// SelectDeptList 部门列表
func (d DeptController) SelectDeptList(c *gin.Context) {
	var req sys_model.SysDept
	if err := c.ShouldBindQuery(&req); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(req, err))
		return
	}

	list, err := d.DeptService.SelectDeptList(req)
	if err != nil {

	}
	response.Success(c, "查询成功", list)
}
