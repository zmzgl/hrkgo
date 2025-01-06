package middleware

import (
	"github.com/gin-gonic/gin"
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
		claims, err := sys_service.ParseToken(token)
		if err != nil {
			response.TokenFail(c)
			c.Abort()
			return
		}
		// 将用户信息存储在上下文中
		c.Set("userId", claims.UserID)
		c.Set("tokenId", claims)
		c.Next()
	}
}
