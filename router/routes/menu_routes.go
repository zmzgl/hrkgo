package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterMenuRoutes(r *gin.RouterGroup) {
	MenuController := c_system.MenuController{}
	user := r.Group("/menu")
	{
		authRouter := user.Use(middleware.JWTAuth())
		{
			authRouter.GET("/treeselect", MenuController.DeptTree)
		}
	}
}
