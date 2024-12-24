package cache_redis

import (
	"fmt"
	"github.com/go-redis/redis/v8"
	"hrkGo/utils/global/variable"
	redis2 "hrkGo/utils/redis"
	"time"
)

type CacheStore struct {
	Client   *redis.Client
	ExpireIn time.Duration // 验证码过期时间
}

// Set 实现设置 captcha 的方法
func (r CacheStore) Set(key string, value string) error {
	err := variable.Redis.Set(redis2.Ctx, key, value, r.ExpireIn).Err()
	return err
}

// Get 实现获取 captcha 的方法
func (r CacheStore) Get(key string, clear bool) string {
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

// Verify 效验 captcha 的方法
func (r CacheStore) Verify(id, answer string, clear bool) bool {
	v := CacheStore{}.Get(id, clear)
	return v == answer
}
