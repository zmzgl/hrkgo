package middleware

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/service/sys_service"
	"hrkGo/utils/response"
	"strings"
)

const (
	TokenType = "bearer"
)

func JWTAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.Request.Header.Get("Authorization")
		if authHeader == "" {
			response.TokenFail(c)
			c.Abort()
			return
		}
		// 检查 Bearer token
		parts := strings.SplitN(authHeader, " ", 2)
		if !(len(parts) == 2 && parts[0] == "Bearer") {
			response.TokenFail(c)
			c.Abort()
			return
		}
		// 解析 token
		claims, err := sys_service.ParseToken(parts[1])
		if err != nil {
			response.TokenFail(c)
			c.Abort()
			return
		}
		// 将用户信息存储在上下文中
		c.Set("token", parts)
		c.Set("id", claims.UserID)
		c.Next()
	}
}
