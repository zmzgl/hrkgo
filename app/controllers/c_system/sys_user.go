package c_system

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/service/sys_service"
)

type UserController struct {
	UserService sys_service.UserCurd
}

// DeptList 部门列表
func (d UserController) DeptList(c *gin.Context) {
	
}
