package main

import (
	"github.com/gin-gonic/gin"
	"github.com/stepan41k/GinLessons/Lesson1/controller"
	"github.com/stepan41k/GinLessons/Lesson1/service"
)

var (
	videService service.VideoService = service.New()
	videController controller.VideoController = controller.New(videService)
)

func main() {
	server := gin.Default()

	server.GET("/videos", func(ctx *gin.Context) {
		ctx.JSON(200, videController.FindAll())
	})

	server.POST("/videos/", func(ctx *gin.Context) {
		ctx.JSON(200, videController.Save(ctx))
	})

	server.Run(":8080")
}