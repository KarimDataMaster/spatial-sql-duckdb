# Рабочее окружение на Windows: DuckDB + Python + Jupyter Notebook

Этот урок проведёт вас от пустого компьютера до работающего Jupyter Notebook
с DuckDB и расширением Spatial. Предыдущий опыт с Python не требуется.

В конце урока у вас будет:

- установленный Python 3.13;
- отдельное виртуальное окружение `.venv` для курса;
- классический Jupyter Notebook, открывающий `.ipynb` в браузере;
- DuckDB, доступный из Python;
- установленное расширение `spatial`;
- проверочный notebook, выполняющийся сверху вниз без ошибок.

На настройку обычно требуется 20–40 минут. Первый запуск требует интернета:
нужно скачать Python-пакеты и расширение DuckDB Spatial.

## 1. Что мы будем делать

В уроке используется один последовательный способ установки:

1. Установить Python 3.13.
2. Создать виртуальное окружение `.venv`.
3. Активировать окружение.
4. Установить Jupyter Notebook, DuckDB и остальные пакеты через `pip`.
5. Зарегистрировать отдельный kernel курса.
6. Запустить Jupyter Notebook и выполнить проверку.

Все команды установки выполняются в **PowerShell**, а не в ячейке Jupyter.

## 2. Что означают новые слова

**PowerShell** — командная строка Windows. В ней мы будем вводить команды
установки и запускать Jupyter Notebook.

**Python** — язык программирования, из которого мы будем обращаться к DuckDB.

**pip** — стандартная программа для установки Python-пакетов.

**Пакет** — устанавливаемое дополнение для Python. `duckdb`, `notebook` и
`pandas` — пакеты.

**Виртуальное окружение** — изолированная папка `.venv` с Python-пакетами
конкретного проекта. Пакеты курса не будут вмешиваться в другие проекты.

**Jupyter Notebook** — программа, которая запускает локальный сервер и
открывает в браузере документы `.ipynb`. Код выполняется по отдельным ячейкам
на вашем компьютере.

**Kernel** — конкретный Python, выполняющий ячейки notebook. Если выбран не
тот kernel, пакет может быть установлен, но `import duckdb` не сработает.

**DuckDB** — встраиваемая аналитическая база данных. Отдельный сервер,
регистрация и пароль не нужны: база работает внутри Python.

## 3. Откройте PowerShell

1. Нажмите клавишу ++win++.
2. Введите `PowerShell`.
3. Откройте **Windows PowerShell** или **PowerShell**.

Права администратора для обычной установки не нужны. Приглашение выглядит
примерно так:

```text
PS C:\Users\student>
```

Вводите команды после символа `>`. Само приглашение копировать не нужно.

## 4. Проверьте Git и получите курс

### 4.1. Проверьте Git

```powershell
git --version
```

Нормальный результат выглядит как `git version 2.x.x`. Если команда не
найдена, установите [Git for Windows](https://git-scm.com/download/win),
закройте PowerShell и откройте его снова.

### 4.2. Клонируйте репозиторий

Если репозиторий ещё не клонирован:

```powershell
cd $HOME
New-Item -ItemType Directory -Force -Path courses | Out-Null
cd courses
git clone https://github.com/KarimDataMaster/spatial-sql-duckdb.git
cd spatial-sql-duckdb
```

Если репозиторий уже есть, перейдите в него. Например:

```powershell
cd "$HOME\courses\spatial-sql-duckdb"
```

Проверьте текущую папку и её содержимое:

```powershell
Get-Location
Get-ChildItem
```

Среди файлов должны быть `README.md` и `requirements-course.txt`, а также
папки `docs`, `notebooks` и `sql`.

!!! important
    Все следующие команды выполняйте из корня `spatial-sql-duckdb`.

## 5. Установите Python 3.13

Сначала проверьте, есть ли подходящий Python:

```powershell
py -3.13 --version
```

Если показана версия `Python 3.13.x`, переходите к следующему разделу.

Если команда `py` или версия 3.13 не найдена, установите официальный Python
Install Manager:

```powershell
winget install 9NQ7512CXL7T -e --accept-package-agreements --accept-source-agreements
```

После установки:

1. Закройте PowerShell.
2. Откройте PowerShell заново.
3. Выполните:

```powershell
py install 3.13
py -3.13 --version
```

Ожидается строка `Python 3.13.x`.

Если WinGet недоступен, скачайте Python Install Manager с
[python.org](https://www.python.org/downloads/), установите его и снова
откройте PowerShell.

## 6. Создайте виртуальное окружение

Убедитесь, что находитесь в корне репозитория:

```powershell
Get-Location
Test-Path .\requirements-course.txt
```

Вторая команда должна вернуть `True`.

Создайте окружение:

```powershell
py -3.13 -m venv .venv
```

Команда создаст локальную папку `.venv`. Она не попадёт в Git.

## 7. Активируйте окружение

```powershell
.\.venv\Scripts\Activate.ps1
```

В начале приглашения должно появиться `(.venv)`:

```text
(.venv) PS C:\...\spatial-sql-duckdb>
```

Это важный признак: следующие пакеты будут установлены в окружение проекта,
а не глобально в Windows.

Если PowerShell сообщает, что выполнение сценариев запрещено, разрешите его
только для текущего окна и повторите активацию:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\.venv\Scripts\Activate.ps1
```

Настройка `-Scope Process` исчезнет после закрытия окна PowerShell.

Проверьте активный Python:

```powershell
python --version
python -c "import sys; print(sys.executable)"
```

Версия должна начинаться с `3.13`, а путь — заканчиваться на
`spatial-sql-duckdb\.venv\Scripts\python.exe`.

## 8. Установите Jupyter Notebook и DuckDB

Сначала обновите `pip`, затем установите пакеты курса:

```powershell
python -m pip install --upgrade pip
python -m pip install -r requirements-course.txt
```

Мы используем `python -m pip`, а не просто `pip`: так пакет гарантированно
устанавливается именно в активное окружение.

Файл `requirements-course.txt` устанавливает:

- `notebook` — классический Jupyter Notebook;
- `ipykernel` — Python-kernel для выполнения ячеек;
- `duckdb` — Python-клиент DuckDB;
- `pandas` и `pyarrow` — работу с таблицами;
- `matplotlib` — построение графиков.

Проверьте Jupyter Notebook:

```powershell
python -m notebook --version
```

Проверьте DuckDB:

```powershell
python -c "import duckdb; print(duckdb.__version__)"
```

Обе команды должны вывести номера версий без traceback и красного текста.

Если появилась ошибка `No module named notebook`, убедитесь, что в начале
строки есть `(.venv)`, и повторите:

```powershell
python -m pip install -r requirements-course.txt
```

## 9. Зарегистрируйте kernel курса

```powershell
python -m ipykernel install --user --name spatial-sql-duckdb --display-name "Python (spatial-sql-duckdb)"
```

`--name` — внутреннее имя, а `--display-name` — название, которое будет
показано в меню Jupyter.

Этот шаг нужен, чтобы Jupyter выполнял ячейки именно в `.venv` курса.

## 10. Запустите Jupyter Notebook

```powershell
jupyter notebook
```

Не закрывайте PowerShell, пока работает Jupyter. Обычно браузер автоматически
откроет `http://localhost:8888/tree`.

Если браузер не открылся, найдите в PowerShell полный адрес вида
`http://localhost:8888/tree?token=...`, скопируйте его и вставьте в браузер.
Не отправляйте этот token другим людям.

На странице Jupyter:

1. Откройте папку `notebooks`.
2. Нажмите `00_environment_check.ipynb`.
3. Откройте **Kernel → Change Kernel**.
4. Выберите **Python (spatial-sql-duckdb)**.

## 11. Выполните проверочный notebook

Выберите **Run → Run All Cells** или последовательно запускайте ячейки кнопкой
**Run**. Ниже объясняется, что они проверяют.

### 11.1. Python и рабочая папка

```python
import platform
import sys
from pathlib import Path

print("Python:", sys.version)
print("Исполняемый файл:", sys.executable)
print("Windows:", platform.platform())
print("Рабочая папка:", Path.cwd())
```

`sys.executable` должен содержать
`spatial-sql-duckdb\.venv\Scripts\python.exe`. Рабочая папка должна быть
корнем репозитория.

### 11.2. Python-пакеты

```python
import duckdb
import pandas as pd

print("DuckDB:", duckdb.__version__)
print("pandas:", pd.__version__)
```

Если импорты прошли, notebook использует окружение курса.

### 11.3. DuckDB Spatial

```python
con = duckdb.connect(":memory:")
con.execute("INSTALL spatial")
con.execute("LOAD spatial")

con.sql("""
    SELECT extension_name, installed, loaded
    FROM duckdb_extensions()
    WHERE extension_name = 'spatial'
""").df()
```

У `spatial` значения `installed` и `loaded` должны быть `True`. При первом
запуске `INSTALL` скачивает расширение и кеширует его в профиле пользователя.
`LOAD` подключает расширение к текущему соединению.

### 11.4. Первый пространственный запрос

```python
cities = con.sql("""
    WITH cities(city, longitude, latitude) AS (
        VALUES
            ('Moscow', 37.6176, 55.7558),
            ('Kazan', 49.1064, 55.7961)
    )
    SELECT
        city,
        longitude,
        latitude,
        ST_AsText(ST_Point(longitude, latitude)) AS geometry_wkt
    FROM cities
""").df()

cities
```

Ожидаются две строки и значения вроде `POINT (37.6176 55.7558)`.

### 11.5. Файловая база

```python
database_path = Path("data/processed/course.duckdb")
database_path.parent.mkdir(parents=True, exist_ok=True)

file_con = duckdb.connect(str(database_path))
file_con.execute("CREATE OR REPLACE TABLE cities AS SELECT * FROM cities")
rows = file_con.sql("SELECT count(*) AS row_count FROM cities").df()
file_con.close()
con.close()

print("База:", database_path.resolve())
rows
```

Ожидаемый `row_count` — `2`. Файл базы находится в `data/processed` и
игнорируется Git.

## 12. Завершите работу правильно

1. Сохраните notebook сочетанием ++ctrl+s++.
2. Закройте notebook или остановите kernel через меню **Kernel**.
3. В PowerShell нажмите ++ctrl+c++, чтобы остановить сервер Jupyter.
4. Выполните `deactivate` или закройте PowerShell.

## 13. Как запускать Jupyter в следующий раз

Откройте PowerShell и выполните:

```powershell
cd "$HOME\courses\spatial-sql-duckdb"
.\.venv\Scripts\Activate.ps1
jupyter notebook
```

Повторно устанавливать Python и пакеты не нужно.

## 14. Как установить новый пакет

Остановите Jupyter, активируйте окружение и установите пакет:

```powershell
.\.venv\Scripts\Activate.ps1
python -m pip install ИМЯ_ПАКЕТА
```

После проверки добавьте пакет и ограничение версии в
`requirements-course.txt`, чтобы другие участники могли повторить окружение.

Не используйте `!pip install` в случайной ячейке: легко установить пакет не в
то окружение и получить notebook, который невозможно повторить.

## 15. Частые проблемы

### `py`, `python` или `git` не является командой

Закройте все окна PowerShell и откройте новое: установщик мог изменить `PATH`.
Затем повторите команду проверки.

### PowerShell запрещает `Activate.ps1`

Разрешите сценарий только в текущем окне:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### `No module named notebook`

Активируйте окружение и повторите установку:

```powershell
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements-course.txt
```

### `No module named duckdb`

В notebook выполните:

```python
import sys
print(sys.executable)
```

Если путь не содержит `.venv`, выберите
**Kernel → Change Kernel → Python (spatial-sql-duckdb)**. Если kernel отсутствует,
повторите раздел 9 и обновите страницу.

### Ошибка при `INSTALL spatial`

Первый `INSTALL` требует доступа к серверу расширений DuckDB. Проверьте
интернет, VPN, proxy и корпоративный firewall. Не скачивайте бинарный файл с
неофициального сайта.

### `Catalog Error` при вызове функции `ST_*`

В текущем соединении не загружено расширение:

```python
con.execute("LOAD spatial")
```

### Jupyter не открыл браузер

В PowerShell найдите URL с `token=...`, скопируйте его полностью и откройте
вручную. Если порт `8888` занят, Jupyter может выбрать `8889` — это нормально.

### Команда выполняется не из папки проекта

```powershell
Get-Location
Test-Path .\requirements-course.txt
```

Вторая команда должна вернуть `True`.

## 16. Как полностью пересоздать окружение

Остановите Jupyter и деактивируйте окружение:

```powershell
deactivate
```

Убедитесь, что находитесь в корне именно этого репозитория:

```powershell
Get-Location
Test-Path .\.venv
```

Удалите только локальную `.venv` проекта:

```powershell
Remove-Item -Recurse -Force -LiteralPath .\.venv
```

Затем повторите разделы 6–9. Notebooks, SQL и данные не удаляются.

## 17. Контрольный список

Окружение готово, если все пункты выполнены:

- [ ] `git --version` работает;
- [ ] `py -3.13 --version` показывает Python 3.13;
- [ ] после активации в PowerShell видно `(.venv)`;
- [ ] `sys.executable` указывает на `.venv\Scripts\python.exe`;
- [ ] `python -m notebook --version` работает;
- [ ] Jupyter Notebook открывается в браузере;
- [ ] выбран kernel **Python (spatial-sql-duckdb)**;
- [ ] `import duckdb` выполняется без ошибки;
- [ ] `spatial` имеет `installed = True` и `loaded = True`;
- [ ] запрос создаёт точки Москвы и Казани;
- [ ] `00_environment_check.ipynb` выполняется сверху вниз без ошибки.

После этого переходите к **[модулю 0](../modules/00-introduction.md)**.

## Официальные материалы

- [Python на Windows](https://docs.python.org/3/using/windows.html)
- [Установка Jupyter](https://jupyter.org/install)
- [DuckDB Python API](https://duckdb.org/docs/stable/clients/python/overview)
- [DuckDB в Jupyter](https://duckdb.org/docs/current/guides/python/jupyter)
- [Расширения DuckDB](https://duckdb.org/docs/current/extensions/installing_extensions)
