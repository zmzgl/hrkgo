package sys_service

import (
	"fmt"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/redis/token_redis"
	"time"
)

var Secret = []byte(variable.ConfigYml.GetString("token.secret"))

type CustomClaims struct {
	UserID uint `json:"user_id"`
	jwt.RegisteredClaims
	TokenId string
}

var tokenStore = token_redis.TokenStore{
	Client: variable.Redis,
}

type JwtService struct {
}

func (r JwtService) GenerateTokenWithCustomClaims(userData sys_model.TokenData) (string, error) {
	tokenId := uuid.NewString()
	claims := CustomClaims{
		UserID: uint(userData.User.UserId),
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Duration(variable.ConfigYml.GetInt("token.expireTime")) * time.Minute)),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
			NotBefore: jwt.NewNumericDate(time.Now()),
			Issuer:    "api.GOHAR.com",
			Subject:   fmt.Sprintf("%d", userData.User.UserId),
			Audience:  jwt.ClaimStrings{"web-app"},
			ID:        uuid.New().String(),
		},
		TokenId: tokenId,
	}

	err := tokenStore.SetWithExpire(tokenId, userData, time.Duration(variable.ConfigYml.GetInt("token.expireTime"))*time.Minute)
	if err != nil {
		return "", err
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(Secret)
}

// ParseToken 解析token
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

// GetUserData 获取
func GetUserData(tokenString string) (tokenData sys_model.TokenData) {
	tokenData = tokenStore.Get(tokenString)
	return tokenData
}
