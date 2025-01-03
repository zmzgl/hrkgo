package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterOverallRoutes(r *gin.RouterGroup) {

	overController := c_system.Controller{}
	menuController := c_system.MenuController{}
	// 直接在引擎上定义路由

	r.GET("/captchaImage", overController.CaptchaImage)
	r.POST("/login", overController.Login)
	r.POST("/wxLogin", overController.WxLogin)

	authRouter := r.Use(middleware.JWTAuth())
	{
		authRouter.GET("/getInfo", overController.Info)
		authRouter.GET("/getRouters", menuController.GetRouters)

	}

}
