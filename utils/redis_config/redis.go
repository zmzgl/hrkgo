package redis_config

import (
	"fmt"
	"github.com/go-redis/redis/v8"
	"hrkGo/utils/global/variable"
	"time"
)

type RedisStore struct {
	Client   *redis.Client
	ExpireIn time.Duration // 验证码过期时间
}

// Set 实现设置 captcha 的方法
func (r RedisStore) Set(key string, value string) error {
	err := variable.Redis.Set(ctx, key, value, r.ExpireIn).Err()
	return err
}

// Get 实现获取 captcha 的方法
func (r RedisStore) Get(key string, clear bool) string {
	val, err := variable.Redis.Get(ctx, key).Result()
	if err != nil {
		fmt.Println(err)
		return ""
	}
	if clear {
		err := variable.Redis.Del(ctx, key).Err()
		if err != nil {
			fmt.Println(err)
			return ""
		}
	}
	return val
}

// Verify 效验 captcha 的方法
func (r RedisStore) Verify(id, answer string, clear bool) bool {
	v := RedisStore{}.Get(id, clear)
	return v == answer
}
