package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
)

type DeptController struct {
	DeptService sys_service.DeptCurd
}

// DeptList 部门列表
func (d DeptController) DeptList(c *gin.Context) {
	var req sys_model.DeptListRequest
	if err := c.ShouldBindQuery(&req); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(req, err))
		return
	}

	list, err := d.DeptService.GeDeptList(req)
	if err != nil {

	}
	response.Success(c, "查询成功", list)
}
