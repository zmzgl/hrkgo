package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/global/consts"
	"hrkGo/utils/response"
)

type PostController struct {
	PostService sys_service.PostService
}

// SelectPostList 部门列表
func (d PostController) SelectPostList(c *gin.Context) {
	var req sys_model.RoleListRequest
	if err := c.ShouldBindQuery(&req); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(req, err))
		return
	}

	list, total, err := d.PostService.SelectPostList(req)
	if err != nil {

	}
	response.SuccessRow(c, consts.SUCCESS, list, total)
}
