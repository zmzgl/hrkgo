package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
)

type MenuController struct {
	MenuService sys_service.MenuService
}

// 获取全部路由
func (m *MenuController) GetRouters(c *gin.Context) {
	trees, err := m.MenuService.GetMenuTreeAll()
	RouterVo := m.MenuService.BuildMenus(trees)
	if err != nil {

	}
	response.Success(c, "查询成功", RouterVo)
}

// TreeSelect 菜单下拉列表
func (m *MenuController) TreeSelect(c *gin.Context) {
	menus, err := m.MenuService.SelectMenuList(uint64(c.Keys["userId"].(uint)))
	if err != nil {
		response.BusinessFail(c, "查询失败，请稍后再试")
	}
	TreeSelect := m.MenuService.BuildMenuTreeSelect(menus)
	response.Success(c, "查询成功", TreeSelect)
}
