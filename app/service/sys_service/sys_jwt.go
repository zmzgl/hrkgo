package sys_service

import (
	"fmt"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
	"time"
)

var Secret = []byte(variable.ConfigYml.GetString("jwt.secret"))

type CustomClaims struct {
	UserID uint `json:"user_id"`
	jwt.RegisteredClaims
}

type JwtCurd struct {
}

func (r JwtCurd) GenerateTokenWithCustomClaims(user *sys_model.SysUser) (string, error) {
	claims := CustomClaims{
		UserID: uint(user.UserId),
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(24 * time.Hour)),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
			NotBefore: jwt.NewNumericDate(time.Now()),
			Issuer:    "api.GOHAR.com",
			Subject:   fmt.Sprintf("%d", user.UserId),
			Audience:  jwt.ClaimStrings{"web-app"},
			ID:        uuid.New().String(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(Secret)
}

// 解析 JWT token
func ParseToken(tokenString string) (*CustomClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &CustomClaims{}, func(token *jwt.Token) (interface{}, error) {
		return Secret, nil
	})

	if err != nil {
		return nil, err
	}

	if claims, ok := token.Claims.(*CustomClaims); ok && token.Valid {
		return claims, nil
	}

	return nil, err
}
