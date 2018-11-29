# raspicat_setup_scripts

[Raspberry Pi Cat](https://github.com/rt-net/raspicat_ros)用のセットアップスクリプト

`setup_raspicat.sh`はデバイスドライバ ([rt-net/RaspberryPiMouse](https://github.com/rt-net/RaspberryPiMouse)) をインストールするため、`launch_logicool_controller.sh`は[rt-net/raspicat_gamepad_controller](https://github.com/rt-net/raspicat_gamepad_controller)を起動するためのスクリプトです。

これらのスクリプトをOS起動時にサービスとして実行するための設定を`./etc/systemd/system`に、インストールするためのスクリプトを`install.sh`として公開しています。

## Installation

```bash
cd ~/ && git clone https://github.com/rt-net/raspicat_setup_scripts.git
```

## Usage

```bash
cd ~/raspicat_setup_scripts
make install
```