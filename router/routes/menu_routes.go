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
			authRouter.GET("/treeselect", MenuController.TreeSelect)
			authRouter.Use(middleware.PermissionMiddleware("system:menu:query")).GET("/list", MenuController.SelectMenuList)
			authRouter.Use(middleware.PermissionMiddleware("system:menu:query")).GET("/:menuId", MenuController.SelectMenuById)
			authRouter.Use(middleware.PermissionMiddleware("system:menu:add")).POST("", MenuController.InsertMenu)
			authRouter.Use(middleware.PermissionMiddleware("system:menu:edit")).PUT("", MenuController.UpdateMenu)
			authRouter.Use(middleware.PermissionMiddleware("system:menu:remove")).DELETE("/:menuId", MenuController.DeleteMenuById)

		}
	}
}
