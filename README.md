# Imposter Games

![_e5b62fc6-820f-4ac9-b3d0-797bd720c81d](https://github.com/pranjalchaplot/ImposterSyndrome/assets/52233809/42123911-9d0b-456e-91de-8535de1f9d09)


Imposter Games is a fun and engaging multiplayer game application that revolves around the popular "imposter" trope. Inspired by games like "Among Us," Imposter Games offers multiple game modes where players try to identify the imposter among them. The app is built using Flutter, making it cross-platform and easily accessible on both iOS and Android devices.

## Table of Contents
- [Game Overview](#game-overview)
- [Game Modes](#game-modes)
  - [Who's the Imposter](#whos-the-imposter)
  - [Guess the Spotify Song](#guess-the-spotify-song)
- [Features](#features)
- [Installation](#installation)
- [How to Play](#how-to-play)
  - [Game Setup](#game-setup)
  - [Gameplay](#gameplay)
  - [Winning the Game](#winning-the-game)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## Game Overview

Imposter Games is designed to be a lightweight, real-life-esque multiplayer game that you can enjoy with friends and family. The core idea is simple: one player is the imposter, and the rest are trying to identify who it is before it's too late. The app includes different game modes, each providing a unique twist on the imposter theme.

## Game Modes

### Who's the Imposter

In this mode, players are given a city and place, with one player receiving an imposter card. The imposter must blend in while others try to identify them.

### Guess the Spotify Song

In this mode, players take turns guessing whose Spotify song is playing. One player picks a song, and the others try to guess the owner.

## Features

- **Multiplayer Gameplay:** Play with friends and family in real-time.
- **Multiple Game Modes:** Enjoy different types of imposter-themed games.
- **Customizable Settings:** Set the number of players, round length, and game categories.
- **Cross-Platform:** Built with Flutter, making it available on both iOS and Android.

## Installation

To run Imposter Games locally, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/imposter_games.git
   ```
2. **Navigate to the project directory:**
   ```bash
   cd imposter_games
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run the app:**
   ```bash
   flutter run
   ```

## How to Play

### Game Setup

1. **Create a Lobby:** One player (the host) creates a lobby and sets the game category (places, celebrities, movies) and round length (30 seconds, 1 minute, 2 minutes).
2. **Share the Lobby Code:** The host shares the lobby code with other players.
3. **Join the Lobby:** Players join the lobby using the shared code.

### Gameplay

1. **Card Distribution:** Each player receives a card on their screen, which they can flip to see their item. One player gets the imposter card.
2. **Round Start:** A timer starts when the last card is flipped. Players write one word describing their item in the group chat.
3. **Discussion:** Players describe their item verbally (if on a call) or via chat. The imposter tries to blend in.

### Winning the Game

- **Vote:** After the round, players vote on who they think the imposter is.
- **Elimination:** The player with the majority votes is eliminated. They can choose to reveal if they were the imposter.
- **Next Round:** If the imposter is not eliminated, a message "Imposter is still among us" appears, and the next round starts.
- **Game End:** The game continues until the imposter is eliminated or only two players remain (one being the imposter).

## Screenshots

<!-- Add screenshots of your app here -->
<!-- ![Screenshot 1](screenshots/screenshot1.png) -->
<!-- ![Screenshot 2](screenshots/screenshot2.png) -->

## Contributing

We welcome contributions to Imposter Games! To contribute, follow these steps:

1. **Fork the repository.**
2. **Create a new branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes and commit them:**
   ```bash
   git commit -m 'Add some feature'
   ```
4. **Push to the branch:**
   ```bash
   git push origin feature/your-feature-name
   ```
5. **Create a pull request.**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
