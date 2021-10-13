[
  {
    "environment": [
            {
                "name": "bucketName",
                "value": "${s3_bucket}"
            }
    ],
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 80
        }
      ],
      "image": "${reverse_proxy_image}",
      "memory": 512,
      "cpu" : 512,
      "dependsOn": [
        {
          "containerName": "app",
          "condition": "START"
        },
        {
          "containerName": "api",
          "condition": "START"
        }
      ],
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${log_group}", 
            "awslogs-region": "${region}",
            "awslogs-stream-prefix": "${prefix}"
          }
      },
      "links": ["app:app", "api:api"],
      "essential": true,
      "hostname": "reverse-proxy",
      "name": "reverse-proxy"
    },
   {
    "environment": [
        {
            "name": "bucketName",
            "value": "${s3_bucket}"
        }
    ],
      "portMappings": [
        {
          "hostPort": 5000,
          "protocol": "tcp",
          "containerPort": 5000
        }
      ],
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${log_group}", 
            "awslogs-region": "${region}",
            "awslogs-stream-prefix": "${prefix}"
          }
      },
      "image": "${backend_image}",
      "memory": 512,
      "cpu" : 512,
      "essential": true,
      "name": "api"
    },
    {
      "environment": [
            {
                "name": "bucketName",
                "value": "${s3_bucket}"
            }
      ],
      "portMappings": [
        {
          "hostPort": 3000,
          "protocol": "tcp",
          "containerPort": 3000
        }
      ],
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${log_group}", 
            "awslogs-region": "${region}",
            "awslogs-stream-prefix": "${prefix}"
          }
      },
      "image": "${frontend_image}",
      "memory": 512,
      "cpu" : 512,
      "dependsOn": [
        {
          "containerName": "api",
          "condition": "START"
        }
      ],
      "essential": true,
      "hostname": "app",
      "name": "app"
    }
]

