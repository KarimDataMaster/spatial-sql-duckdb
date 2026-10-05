# Начало работы

Если вы впервые настраиваете Python, DuckDB и Jupyter на Windows, начните с
пошагового урока **[Рабочее окружение на Windows](setup/windows-jupyter.md)**.
В нём разобран единый маршрут: Python, виртуальное окружение `venv`, установка
пакетов через `pip` и запуск классического Jupyter Notebook.

## Что понадобится

- Git;
- DuckDB CLI или клиент с поддержкой DuckDB;
- редактор кода;
- Python 3.11+ — только для локального просмотра сайта курса.

## Подготовка DuckDB

Откройте DuckDB и выполните:

```sql
INSTALL spatial;
LOAD spatial;

SELECT extension_name, loaded
FROM duckdb_extensions()
WHERE extension_name = 'spatial';
```

Установка требует доступа к сети только при первом скачивании расширения.
В следующих сессиях достаточно команды `LOAD spatial`.

## Проверка пространственного SQL

```sql
LOAD spatial;

SELECT
    ST_AsText(ST_Point(37.6176, 55.7558)) AS moscow_point;
```

Ожидаемый результат — `POINT (37.6176 55.7558)`.

## Работа с репозиторием

```powershell
git clone https://github.com/KarimDataMaster/spatial-sql-duckdb.git
cd spatial-sql-duckdb
```

SQL-файлы выполняйте из корня проекта, чтобы относительные пути к данным
оставались одинаковыми у всех участников.

## Локальный просмотр сайта

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements-docs.txt
mkdocs serve
```

Перейдите на <http://127.0.0.1:8000>. Сервер автоматически обновит страницу
после сохранения Markdown-файла.
