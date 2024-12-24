package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
)

type DictController struct {
	DictService sys_service.DictCurd
}

// DictList 字典列表
func (d DictController) DictList(c *gin.Context) {
	//
	//list, err := d.DictService.GetAllDictWithData()
	//if err != nil {
	//}
	response.Success(c, "查询成功", nil)
}
