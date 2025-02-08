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
		authRouter := dept.Use(middleware.JWTAuth())
		//.Use(middleware.DataScopeMiddleware())
		{

			authRouter.Use(middleware.PermissionMiddleware("system:dept:query")).GET("/list", DeptController.SelectDeptList)
			authRouter.Use(middleware.PermissionMiddleware("system:dept:remove")).DELETE("/:deptId", DeptController.DeleteDeptById)
		}
	}
}
