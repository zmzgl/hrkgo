package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterDeptRoutes(r *gin.RouterGroup) {
	DeptController := c_system.DeptController{}
	dept := r.Group("/dept")
	{
		authRouter := dept.Group("").Use(middleware.JWTAuth())
		{
			authRouter.GET("/list", DeptController.DeptList)
		}
	}
}
