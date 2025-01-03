package token_redis

import (
	"encoding/json"
	"fmt"
	"github.com/go-redis/redis/v8"
	"hrkGo/utils/global/variable"
	redis2 "hrkGo/utils/redis"
	"time"
)

type TokenStore struct {
	Client *redis.Client
}

// SetWithExpire 设置临时存储(带过期时间)
func (d *TokenStore) SetWithExpire(key string, value interface{}, expiration time.Duration) error {
	jsonData, err := json.Marshal(value)
	if err != nil {
		return fmt.Errorf("marshal dict failed: %v", err)
	}
	jsonString := string(jsonData)
	return d.Client.Set(redis2.Ctx, "login_tokens:"+key, jsonString, expiration).Err()
}

// Get 实现获取 captcha 的方法
func (d *TokenStore) Get(key string, clear bool) string {
	val, err := variable.Redis.Get(redis2.Ctx, key).Result()
	if err != nil {
		fmt.Println(err)
		return ""
	}
	if clear {
		err := variable.Redis.Del(redis2.Ctx, key).Err()
		if err != nil {
			fmt.Println(err)
			return ""
		}
	}
	return val
}
