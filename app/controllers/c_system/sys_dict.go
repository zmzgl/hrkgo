package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
	"net/http"
)

type DictController struct {
	DictService sys_service.DictCurd
}

// DictList 字典列表
func (d DictController) DictList(c *gin.Context) {
	var req sys_model.DictListRequest

	// 将查询参数绑定到结构体
	if err := c.ShouldBindQuery(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	list, total, err := d.DictService.GetDictList(req)
	if err != nil {

	}
	response.SuccessRow(c, "查询成功", list, total)
}

// RefreshCache 字典列表
func (d DictController) RefreshCache(c *gin.Context) {

	err := d.DictService.RefreshCache()
	if err != nil {
	}
	response.Success(c, "刷新成功", nil)
}
