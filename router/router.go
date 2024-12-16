package router

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/cSystem"
	"hrkGo/app/middleware"
	"hrkGo/utils/global/variable"
	"net/http"
)

// 优雅重启/停止服务器
func RunServer() {

	//2加载gin路由
	r := InitRouter()

	srv := &http.Server{
		Addr:    variable.ConfigYml.GetString("HttpServer.Web.Port"),
		Handler: r,
	}

	if err := srv.ListenAndServe(); err != nil {
		fmt.Printf("Error starting server: %s\n", err)
	}
}

// 路由初始化
func InitRouter() *gin.Engine {
	//初始化路由
	router := gin.Default()

	////根据配置进行设置跨域
	//if variable.ConfigYml.GetBool("HttpServer.AllowCrossDomain") {

	router.Use(middleware.Cors())
	//}

	router.GET("/", func(c *gin.Context) {
		c.String(200, "Hello_world")
	})

	router.GET("/captchaImage", cSystem.CaptchaImage)
	return router
}
