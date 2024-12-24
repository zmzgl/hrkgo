package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
)

type RoleController struct {
	RoleService sys_service.RoleCurd
}

func (r *RoleController) GetRoleList(c *gin.Context) {
	var req sys_model.RoleListRequest
	if err := c.ShouldBindQuery(&req); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(req, err))
		return
	}

	list, total, err := r.RoleService.GetRoleList(req)
	if err != nil {

	}
	response.SuccessRow(c, "查询成功", list, total)
}
