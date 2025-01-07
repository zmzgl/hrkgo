package token_redis

import (
	"encoding/json"
	"fmt"
	"github.com/go-redis/redis/v8"
	"hrkGo/app/model/sys_model"
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

// Get 实现获取 TokenData
func (d *TokenStore) Get(key string) (person sys_model.TokenData) {
	val, _ := variable.Redis.Get(redis2.Ctx, "login_tokens:"+key).Result()
	// 准备一个 Person 结构体变量来接收数据
	// 将 JSON 转换为结构体
	_ = json.Unmarshal([]byte(val), &person)
	return person
}
