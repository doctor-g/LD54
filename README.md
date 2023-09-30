# LD54

## Web Build

The web build is automatically created by the [the CI script](.github/workflows/deploy.yaml).

The Web build can be tested locally by using the [godot_web.py](tools/godot_web.py) script.
Go to the directory you want to serve (`build/web`) and then run the script,
for example, with this command:
```
python3 ../../tools/godot_web.py
```

Then you can visit `localhost:8000` in the browser to see the game.

The script is courtesy of [this Reddit thread](https://www.reddit.com/r/godot/comments/11kgshy/python_script_to_test_godot_4_web_exports_locally/).

