package middleware

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/response"
	"strings"
)

func JWTAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.Request.Header.Get(variable.ConfigYml.GetString("token.header"))
		if authHeader == "" {
			response.TokenFail(c)
			c.Abort()
			return
		}

		// 2. 处理token格式
		token := authHeader
		if strings.HasPrefix(authHeader, "Bearer ") {
			token = strings.TrimPrefix(authHeader, "Bearer ")
		}

		// 3. 验证token
		if token == "" {
			response.TokenFail(c)
			c.Abort()
			return
		}

		// 解析 token
		tokenData, err := sys_service.ParseToken(token)
		if err != nil {
			response.TokenFail(c)
			c.Abort()
			return
		}
		// 将用户信息存储在上下文中
		c.Set("userId", tokenData.UserID)
		c.Set("tokenId", tokenData.TokenId)
		c.Next()
	}
}

// PermissionMiddleware 权限控制中间件
func PermissionMiddleware(requiredPermission string) gin.HandlerFunc {
	return func(c *gin.Context) {

		// 从 Redis 获取该用户的权限
		permissions := sys_service.GetUserData(c.Keys["tokenId"].(string))
		c.Set("User", permissions.User)
		if sys_model.IsAdmin(c.Keys["userId"].(string)) {
			c.Next()
			return
		}

		exists := contains(permissions.Perms, requiredPermission) // 返回 true

		if !exists {
			response.TokenForbidden(c)
			c.Abort()
			return
		}
		// 继续执行后续的处理
		c.Next()
	}
}

func contains(slice []string, str string) bool {
	for _, v := range slice {
		if v == str {
			return true
		}
	}
	return false
}
