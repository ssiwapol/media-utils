# film-tagger

## USAGE
1. Copy photos to directory
2. `./film-tagger.sh [OPTIONS]`

## options

```
-j [JSONFILE]   (-jsonfile)     [required]          json file with metadata 
-d [DIRECTORY]  (-directory)    [default=.]         directory that contain photos
-s [SUFFIX]     (-suffix)       [default=.jpg]      photos suffix (e.g., .jpg, .raw)
-f              (-film)         [default=false]     film processing or not
```
[json example](./example)

# video-converter

## Usage
1. Copy videos to directory
2. `./video-converter.sh [OPTIONS]`

## Options

```
-d [DIRECTORY]  (-directory)    [default=.]         directory that contain photos
-i [INPUT]      (-input)        [default=.mts]      videos input suffix (e.g., .mts, .mp4)
-o [OUTPUT]     (-output)       [default=.mp4]      videos output suffix (e.g., .mp4, .mkv)
-t [TIMESHIFT]  (-timeshift)    [default=+0]        video global timeshift (+0, +1, +7)
-c [COMPRESS]   (-compress)     [default=false]     compress video or not
```

## Supports
1. .mts -> .mp4

# gps-timestamp

## Usage
1. Copy videos to directory
2. `./gps-timestamp.sh [OPTIONS]`

## Options

```
-d [DIRECTORY]  (-directory)    [default=.]         directory that contain photos
-i [INPUT]      (-input)        [default=.mts]      file input extension (e.g., .jpg, .mp4)
-t [TIMESHIFT]  (-timeshift)    [default=+07:00]    video timezone (+00:00, +07:00)
```

## Supports
1. .jpg, .arw, .dng
2. .mp4 (xmp)

# Requirements
- jq>=1.5-1
- exiftool>=11.16
- ffmpeg>=4.2.1
- mediainfo>=18.12
