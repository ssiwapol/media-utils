# Build container image

```
git clone https://github.com/ssiwapol/media-utils.git
cd media-utils
docker build -t media-utils .
```

# Run
1. Copy photos/videos to directory
2. Change path to that directory
3. Run container

# Modules

### lens-tagger

```
docker run --rm -v "$(pwd):/app/tmp" media-utils lens-tagger [OPTIONS]
```

| option        | name     | default     | description             |
| :------------ | :------- | :---------- | :---------------------- |
| -j [JSONFILE] | jsonfile | config.json | json file with metadata |
| -u [USER]     | user     | 1000        | host user running task  |

[json example](./example/lens.json)

### film-tagger

```
docker run --rm -v "$(pwd):/app/tmp" media-utils film-tagger [OPTIONS]
```

| option        | name     | default     | description             |
| :------------ | :------- | :---------- | :---------------------- |
| -j [JSONFILE] | jsonfile | config.json | json file with metadata |
| -u [USER]     | user     | 1000        | host user running task  |

[json example](./example/film.json)

### gps-tagger

```
docker run --rm -v "$(pwd):/app/tmp" media-utils gps-tagger [OPTIONS]
```

| option        | name     | default     | description            |
| :------------ | :------- | :---------- | :--------------------- |
| -k [KMLFILE]  | kmlfile  | history.kml | kml file with gps data |
| -t [TIMEZONE] | timezone | +07:00      | timezone offset        |
| -u [USER]     | user     | 1000        | host user running task |

[kml example](https://www.google.com/maps/timeline)

### video-converter

```
docker run --rm -v $(pwd):/app/tmp media-utils video-converter [OPTIONS]
```

| option            | name     | default     | description            |
| :---------------- | :------- | :---------- | :--------------------- |
| -f [OUTPUTFORMAT] | format   | .mp4        | video file format      |
| -t [TIMEZONE]     | timezone | 07:00:00 AM | timezone offset        |
| -u [USER]         | user     | 1000        | host user running task |
| -c                | compress | false       | compress file or not   |
