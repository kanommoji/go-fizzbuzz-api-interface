FROM golang:1.12 as builder
WORKDIR /module
COPY fizzbuzz /module
RUN GOOS=linux CGO_ENABLED=0 go build main.go

#multistage-build เบากว่าถึงสร้างเป็น multistate ยิ่งเล็กยิ่ง secure กว่า เพรา alpine เล็กสุด เพราะยิ่งติดตั้งโปรแกรมเยอะยิ่งมีช่องโหว่
FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /module/main .
CMD ["./main"]