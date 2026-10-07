# ESP32 MQTT Tic-Tac-Toe

A networked Tic-Tac-Toe project that connects a C application running on a computer with an ESP32 microcontroller using MQTT messaging over Wi-Fi.

The project explores systems programming, publish/subscribe communication, asynchronous callbacks, embedded GPIO control, and hardware/software integration.

## Architecture

```text
+----------------------+       +-------------------+       +----------------------+
| C Application        | <---> |   MQTT Broker     | <---> | ESP32                |
| (PC / Linux)         |       |   broker.emqx.io  |       | Wi-Fi + GPIO / LEDs  |
+----------------------+       +-------------------+       +----------------------+
```

Both the desktop application and ESP32 communicate through the MQTT topic `esp32/led`. The C side uses the Eclipse Paho MQTT C client, while the ESP32 uses `PubSubClient`.

## Features

- Tic-Tac-Toe game logic implemented in C
- MQTT publish/subscribe communication between a PC and ESP32
- Callback-based handling of incoming MQTT messages
- ESP32 Wi-Fi connectivity and MQTT subscription
- GPIO control of multiple LEDs from received messages
- Standalone C publisher and subscriber programs for testing MQTT communication
- Bash scripts for launching and coordinating application modes
- Makefile-based C build workflow

## Technologies

- **C**
- **ESP32 / Arduino**
- **MQTT**
- **Eclipse Paho MQTT C**
- **PubSubClient**
- **Wi-Fi**
- **Linux / Bash**
- **Make**

## Repository Structure

```text
.
├── broker/
│   └── broker.ino       # ESP32 Wi-Fi, MQTT, and GPIO logic
├── src/
│   ├── tictactoe.c      # Main Tic-Tac-Toe application with MQTT integration
│   ├── npc.c            # Alternate game application
│   ├── pcbroker.c       # MQTT publisher test program
│   └── subtest.c        # MQTT subscriber/callback test program
├── daemon.sh            # Monitors subscriber output and launches NPC logic
├── npc.sh               # Selects game mode based on input/idle state
└── Makefile             # C build configuration
```

## How It Works

### Desktop Application

The main application implements a command-line Tic-Tac-Toe game in C. It maintains the board state, validates moves, detects wins and ties, and connects to an MQTT broker using the Eclipse Paho MQTT C library.

The application registers an MQTT callback to receive messages from the shared topic.

### MQTT Communication

The system uses a public EMQX MQTT broker:

```text
broker.emqx.io:1883
```

The project communicates through:

```text
esp32/led
```

The included publisher and subscriber test programs were used to verify message delivery and callback behavior independently of the full game.

### ESP32

The ESP32 connects to Wi-Fi and the MQTT broker, subscribes to the same MQTT topic, and processes incoming messages through a callback.

Specific messages are mapped to GPIO outputs, allowing MQTT events to control LEDs connected to the ESP32.

## Requirements

### Desktop

- GCC
- GNU Make
- Eclipse Paho MQTT C client library
- Linux or another environment capable of compiling the Paho C client

### Embedded Hardware

- ESP32 development board
- Arduino-compatible ESP32 toolchain
- PubSubClient library
- Wi-Fi connection
- LEDs and appropriate supporting hardware for the GPIO outputs

## Building the C Application

After installing the Eclipse Paho MQTT C library, clone the repository and run:

```bash
git clone https://github.com/justFreds/SystemsProgramming-Final.git
cd SystemsProgramming-Final
make
```

The Makefile links against `paho-mqtt3c`.

> **Note:** If the repository is renamed, update the clone URL and directory name above.

## ESP32 Setup

1. Open `broker/broker.ino` in the Arduino IDE or another ESP32-compatible environment.
2. Configure your Wi-Fi credentials locally.
3. Install the `PubSubClient` library if it is not already available.
4. Connect the LEDs/components to the GPIO pins defined in the sketch.
5. Compile and upload the sketch to the ESP32.
6. Open the serial monitor to observe Wi-Fi and MQTT connection status and received messages.

Do not commit real Wi-Fi credentials to the repository.

## Concepts Demonstrated

This project was built as a systems programming project and demonstrates:

- C application development
- Embedded programming
- Network communication using MQTT
- Publish/subscribe architecture
- Asynchronous callback handling
- Hardware/software integration
- GPIO control
- Linux shell scripting
- Build automation with Make
- Debugging communication across multiple system components

## Possible Improvements

- Move MQTT broker/topic settings into configuration
- Add more robust input validation and error handling
- Replace the public broker with a locally hosted or authenticated MQTT broker
- Add automated tests for game logic
- Improve reconnection handling between the ESP32 and broker
- Expand the hardware interface beyond LED-based output
