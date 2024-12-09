## WebP Optimizer

### This project contains:

- A solution for optimizing images in the following formats: GIF, JPG, PNG, SVG.
- A solution for converting images in formats GIF, JPG, PNG to WebP format.

### How it works?

- You place a directory with your images in the directory `./images`.
- You run the optimization script.
- The script recursively traverses all directories in the `./images` directory.
- The script creates a directory `./originals` in each directory and places the originals there.
- Upon subsequent runs, files that already exist in `./originals` are not processed.
- The script optimizes all types of images in the source directory.
- The script creates a version of the images in WebP format.

### Before optimization

- Build the image for the Docker container: `source dev/build`
- Copy the directory with your images to the project directory: `./images`

### Optimization

- `source dev/process`

### After optimization

- Transfer the directory with processed images back to your project

<hr>

## Оптимизатор WebP

### Этот проект содержит:

- Решение для оптимизации изображений формата: GIF, JPG, PNG, SVG.
- Решение для перевода изображений формата GIF, JPG, PNG в формат WebP

### Как это работает?

- Вы помещаете каталог с вашими изображениями в каталог `./images`.
- Вы запускаете скрипт оптимизации.
- Скрипт рекурсивно проходит все каталоги в каталоге `./images`.
- Скрипт в каждом каталоге создает каталог `./originals` и помещает туда оригиналы.
- При повторном запуске файлы, которые уже есть в `./originals` не обрабатываются.
- Скрипт оптимизирует все типы изображений в исходном каталоге.
- Скрипт создает версию изображений в формате `webp`.

### До оптимизации

- Нужно сбилдить образ для докер контейнера `make build`
- Скопировать каталог с вашими изображениями в каталог проекта `./images`

### Оптимизация

- `make optimize`
- `make pdf2images`
- `make resize`

### После оптимизации

- Каталог с обработанными изображениями перенести обратно в ваш проект

### License

MIT
