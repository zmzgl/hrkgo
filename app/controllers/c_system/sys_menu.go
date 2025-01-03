package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
)

type MenuController struct {
	MenuService sys_service.MenuCurd
}

func (m *MenuController) GetRouters(c *gin.Context) {
	trees, err := m.MenuService.GetMenuTreeAll()

	RouterVo := m.MenuService.BuildMenus(trees)

	if err != nil {

	}
	response.Success(c, "查询成功", RouterVo)
}

func (m *MenuController) DeptTree(c *gin.Context) {
	//menus, err := m.MenuService.SelectMenuList(uint64(c.Keys["userId"].(uint)))
	//if err != nil {
	//
	//}
	//response.Success(c, "查询成功", menuService.buildMenuTreeSelect(menus))

}
