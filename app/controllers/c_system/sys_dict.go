package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/global/consts"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/response"
	"strconv"
	"strings"
	"time"
)

type DictController struct {
	DictService sys_service.DictCurd
}

// DictList 字典列表
func (d DictController) DictList(c *gin.Context) {
	var req sys_model.DictListRequest

	// 将查询参数绑定到结构体
	if err := c.ShouldBindQuery(&req); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(req, err))
		return
	}

	list, total, err := d.DictService.GetDictList(req)
	if err != nil {
		response.BusinessFail(c, consts.SQLERROR)
		return
	}
	response.SuccessRow(c, consts.SUCCESS, list, total)
}

// SelectDictDataById 根据字典id查询字典数据信息
func (d DictController) SelectDictDataById(c *gin.Context) {
	dictId := c.Param("dictId")
	dict, err := d.DictService.SelectDictDataById(dictId)
	if err != nil {
		response.BusinessFail(c, consts.SQLERROR)
		return
	}
	response.Success(c, "刷新成功", dict)
}

// InsertDictData 新增字典类型
func (d DictController) InsertDictData(c *gin.Context) {
	var form sys_model.DictTypeRequest

	if err := c.ShouldBindJSON(&form); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(form, err))
		return
	}

	dict := &sys_model.SysDictType{
		DictId:     variable.SnowFlake.GetIdStr(),
		DictName:   form.DictName,
		DictType:   form.DictType,
		Status:     form.Status,
		Remark:     form.Remark,
		CreateBy:   strconv.FormatUint(uint64(c.Keys["id"].(uint)), 10),
		CreateTime: time.Now(),
		UpdateBy:   "",
		UpdateTime: nil,
	}

	err := d.DictService.InsertDictData(dict)
	if err != nil {
		switch err.Error() {
		case "字典名称或字典类型已存在":
			response.BusinessFail(c, "字典名称或字典类型已存在,请修改后重试")
		default:
			response.BusinessFail(c, "创建失败,请重试")
		}
		return
	}
	response.SuccessNil(c, "新增成功")
}

// UpdateDictData 修改字典类型
func (d DictController) UpdateDictData(c *gin.Context) {
	var form sys_model.DictTypeRequest

	if err := c.ShouldBindJSON(&form); err != nil {
		response.ValidateFail(c, response.GetErrorMsg(form, err))
		return
	}

	dict := &sys_model.SysDictType{
		DictId:     variable.SnowFlake.GetIdStr(),
		DictName:   form.DictName,
		DictType:   form.DictType,
		Status:     form.Status,
		Remark:     form.Remark,
		CreateBy:   strconv.FormatUint(uint64(c.Keys["id"].(uint)), 10),
		CreateTime: time.Now(),
		UpdateBy:   "",
		UpdateTime: nil,
	}

	err := d.DictService.InsertDictData(dict)
	if err != nil {
		switch err.Error() {
		case "字典名称或字典类型已存在":
			response.BusinessFail(c, "字典名称或字典类型已存在,请修改后重试")
		default:
			response.BusinessFail(c, "创建失败,请重试")
		}
		return
	}
	response.SuccessNil(c, "新增成功")
}

// DeleteDictDataByIds 新增字典类型
func (d DictController) DeleteDictDataByIds(c *gin.Context) {
	// 获取路径参数
	ids := c.Param("dictIds") // "1,2,3,4,5"
	// 分割字符串为切片
	idStrings := strings.Split(ids, ",") // []string{"1", "2", "3", "4", "5"}

	// 转换为 int64 切片
	idList := make([]int64, 0, len(idStrings))
	for _, idStr := range idStrings {
		id, err := strconv.ParseInt(idStr, 10, 64)
		if err != nil {
			response.BusinessFail(c, "请检查传入参数是否正确")
			return
		}
		idList = append(idList, id)
	}
	err := d.DictService.DeleteDictDataByIds(idList)
	if err != nil {
		response.BusinessFail(c, "删除失败,请重试")
		return
	}
	response.SuccessNil(c, "删除成功")
}

// SelectDictDataByType 根据字典类型查询字典数据信息
func (d DictController) SelectDictDataByType(c *gin.Context) {
	dictType := c.Param("dictType")
	dict, err := d.DictService.SelectDictDataByType(dictType)
	if err != nil {
		response.BusinessFail(c, consts.SQLERROR)
		return
	}
	response.Success(c, consts.SUCCESS, dict)
}

// RefreshCache 字典列表
func (d DictController) RefreshCache(c *gin.Context) {

	err := d.DictService.RefreshCache()
	if err != nil {
		response.BusinessFail(c, consts.SQLERROR)
		return
	}
	response.SuccessNil(c, consts.SUCCESS)
}
