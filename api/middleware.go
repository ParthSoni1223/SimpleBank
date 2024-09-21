package api

import (
	"errors"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/parth/simplebank/token"
)

const(
	authorizationHeaderKey = "authorization"
	authorizationTypeBearer = "bearer"
	atuhorizationPayloadKey = "authorization_payload"
)
// not a middleware function but it will return the middleware function
func authMiddleware(tokenMaker token.Maker) gin.HandlerFunc {
	// this anonymous function is authentication middleware function
	return func(ctx *gin.Context) {
		authorizationHeader := ctx.GetHeader(authorizationHeaderKey)
		if len(authorizationHeader) == 0 {
			err := errors.New("authorization header is not provided")
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, errorResponse(err))
			return
		}

		fields := strings.Fields(authorizationHeader)
		if len(fields) < 2{
			err := errors.New("Invalid authorization header format")
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, errorResponse(err))
			return
		}

		authorizationType := strings.ToLower(fields[0])
		if authorizationType != authorizationTypeBearer
	}
}
