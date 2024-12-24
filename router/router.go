package router

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"hrkGo/router/routes"
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
	r := gin.Default()

	v1 := r.Group("/api/v1")

	system := v1.Group("/system")
	routes.RegisterOverallRoutes(v1)
	routes.RegisterDeptRoutes(system)
	routes.RegisterRoleRoutes(system)
	routes.RegisterDictRoutes(system)

	// 初始化字典
	return r
}
