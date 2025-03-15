# cerb-base

The `cerb-base` directory builds the base image from the official `php:fpm` versioned image along with Cerb's required PHP extensions.

Building this image first drastically speeds up the build times of versioned Cerb images.

Build the base image for your target platforms:

```bash
docker build -t cerb:base-8.3-fpm --platform=linux/arm64,linux/amd64 .
```

This image only needs to be rebuilt when updating the OS, PHP, or extension versions.

Most people do not need to build this image locally.