# raspicat_setup_scripts

[Raspberry Pi Cat](https://github.com/rt-net/raspicat_ros)用のセットアップスクリプト

`setup_raspicat.sh`はデバイスドライバ ([rt-net/RaspberryPiMouse](https://github.com/rt-net/RaspberryPiMouse)) をインストールするため、`launch_logicool_controller.sh`は[rt-net/raspicat_gamepad_controller](https://github.com/rt-net/raspicat_gamepad_controller)を起動するためのスクリプトです。

これらのスクリプトをOS起動時にサービスとして実行するための設定を`etc/systemd/system`に、インストールするためのスクリプトを`src/install.sh`に公開しています。

## Installation

```bash
cd ~/ && git clone https://github.com/rt-net/raspicat_setup_scripts.git
```

## Usage

* セットアップ用スクリプトをサービスとして登録し、自動起動を有効にする
  * ユーザ名が`pi`の場合、`setup_raspicat.sh`がサービスとして登録されます
  * ユーザ名が`ubuntu`の場合、`setup_raspicat.sh`と`launch_logicool_controller.sh`の両方がサービスとして登録されます

```bash
make install
```

* セットアップ用のサービスを削除

```bash
make uninstall
```
