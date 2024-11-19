package controller

import (
	"github.com/gin-gonic/gin"
	"github.com/stepan41k/GinLessons/Lesson1/entity"
	"github.com/stepan41k/GinLessons/Lesson1/service"
)

type VideoController interface {
	Save(ctx *gin.Context) entity.Video
	FindAll() []entity.Video
}

type controller struct {
	service service.VideoService
}

func New(service service.VideoService) VideoController {
	return &controller {
		service: service,
	}
}

func (c *controller) FindAll() []entity.Video {
	return c.service.FindAll()
}

func (c *controller) Save(ctx *gin.Context) entity.Video {
	var video entity.Video

	ctx.BindJSON(&video)
	c.service.Save(video)

	return video
}

