package redis_config

import (
	"context"
	"github.com/go-redis/redis/v8"
	"hrkGo/utils/global/my_errors"
	"hrkGo/utils/global/variable"
	"log"
)

var ctx = context.Background()

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
