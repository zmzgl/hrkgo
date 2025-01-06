package redis

import (
	"context"
	"github.com/go-redis/redis/v8"
	"hrkGo/utils/global/my_errors"
	"hrkGo/utils/global/variable"
	"log"
	"time"
)

var Ctx = context.Background()

func CreateRedisFactory() *redis.Client {
	client := redis.NewClient(&redis.Options{
		Addr:     variable.ConfigYml.GetString("redis.host") + ":" + variable.ConfigYml.GetString("redis.port"),
		Password: variable.ConfigYml.GetString("redis.password"), // no password set
		DB:       variable.ConfigYml.GetInt("redis.db"),          // use default DB
	})
	_, err := client.Ping(context.Background()).Result()
	if err != nil {
		log.Fatal(my_errors.ErrorsRedisInitConnFail + err.Error())
		return nil
	}
	return client
}

// GetInt 实现获取 captcha 的方法
func GetInt(key string) int {
	val, err := variable.Redis.Get(Ctx, key).Int()
	if err != nil {
		return 0
	}
	return val
}

// Set 设置临时存储(带过期时间)
func Set(key string, value interface{}, expiration time.Duration) {
	variable.Redis.Set(Ctx, key, value, expiration)
}

// Del 删除
func Del(key string) {
	variable.Redis.Del(Ctx, key)
}
