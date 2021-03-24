# esp32_embit

1. Install [esp-idf](https://docs.espressif.com/projects/esp-idf/en/v4.0/get-started/index.html#step-3-set-up-the-tools):

```
git clone -b v4.0 --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
git checkout 4c81978a3e2220674a432a588292a4c860eef27b
git submodule update --recursive
./install.sh
source ./export.sh
```

2. Clone this repo recursively:

```
git clone https://github.com/stepansnigirev/esp32_embit.git --recursive
```

3. Make:

```
make esp32
```

4. Flash:

```
make flash
```
