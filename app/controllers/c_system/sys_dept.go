package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/middleware"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/StringUtils"
	"hrkGo/utils/response"
)

type DeptController struct {
	DeptService sys_service.DeptService
}

// SelectDeptList 部门列表
func (d DeptController) SelectDeptList(c *gin.Context) {
	var req sys_model.DeptListRequest
	if err := c.ShouldBindQuery(&req); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(req, err))
		return
	}

	list, err := d.DeptService.SelectDeptList(req, middleware.DataScopeMiddleware(c.MustGet("User"), "d", "u"))
	if err != nil {
		response.BusinessFail(c, "操作失败,请稍后再试")
		return
	}
	response.Success(c, "查询成功", list)
}

// DeleteDeptById 删除部门
func (d DeptController) DeleteDeptById(c *gin.Context) {

	deptId := c.Param("deptId")

	if d.DeptService.HasChildByDeptId(deptId) {
		response.BusinessFail(c, "存在下级部门,不允许删除")
		return
	}
	if d.DeptService.CheckDeptExistUser(deptId) {
		response.BusinessFail(c, "部门存在用户,不允许删除")
		return
	}

	if !sys_model.IsAdmin(c.Keys["userId"].(string)) && !StringUtils.IsEmptyStr(deptId) {
		if d.DeptService.CheckDeptDataScope(deptId, middleware.DataScopeMiddleware(c.MustGet("User"), "d", "u")) {
			response.BusinessFail(c, "没有权限访问部门数据！")
			return
		}
	}

	//return toAjax(deptService.deleteDeptById(deptId))
}
