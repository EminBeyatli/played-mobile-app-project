#  played

**played** is a mobile app for logging, rating, and reviewing the games you play, in the spirit of Letterboxd. Keep track of what you've played, build a wishlist, write reviews, and follow friends to see what they're playing.


---

##  Contributors

| Name | GitHub 
|---|---|---|
| Bensu Kocatepe | [@username](https://github.com/username)
| Muhammed Emin Beyatlı | [@username](https://github.com/username)
| Alperen İlhan İpçi | [@username](https://github.com/username) 
| Demirhan Demir | [@username](https://github.com/username)

<!-- For an individual submission, list yourself as the sole author. -->

##  Figma Links

The editable design work is kept in Figma. View access is granted to the instructor.

| Deliverable | Link |
|---|---|
| Wireframes | [Open in Figma](PASTE_WIREFRAMES_LINK) |
| Mockups | [Open in Figma](PASTE_MOCKUPS_LINK) |
| Interactive prototype | [Open prototype](PASTE_PROTOTYPE_LINK) |

##  Submission Documents

| Document | File |
|---|---|
| Design justification | [docs/design-justification.pdf](docs/design-justification.pdf) |
| User flow | [docs/user-flow.pdf](docs/user-flow.pdf) |
| Architecture and protocols | [docs/architecture-and-protocols.pdf](docs/architecture-and-protocols.pdf) |

##  Features

- **Authentication:** welcome splash screen, login, and sign up (username, email, password, confirm password, terms and conditions).
- **Home:** horizontally scrollable *Trending Games* and *Reviews from Friends*.
- **Search:** search for games and see your *Recently Searched* list.
- **Game Detail:** poster, release year, platform, score, official description, and user reviews.
- **Log a Game:** mark as played, like, or add to wishlist, give a 1–5 star rating, and write a review.
- **Profile:** profile picture, username, played game and review counts, *Favorite Games* (5), and *Played Recently* (8).
- **Social:** followers and following lists, plus friends' reviews on the home page.
- **Bottom navigation (HUD):** Home, Search, and Profile tabs; the active tab's icon is highlighted.

##  Screens

| Screen | Description |
|---|---|
| Welcome | Shows the "played" title, then moves to Login after a short delay |
| Login | Username and password fields, submit button, link to Sign Up |
| Sign Up | Username, email, password, confirm password, terms checkbox, submit |
| Home | Trending games and reviews from friends |
| Search | Search bar and recently searched games |
| Game Detail | Game info, Log button, user reviews |
| Log | Played / Like / Wishlist, star rating, add review |
| Profile | Stats, favorite games, recently played, links to sub-pages |
| Games | Played, Wishlist, and Likes tabs |
| Followers / Following | Lists of mutual users |
| Reviews | The user's reviews with poster and rating |

<!-- Optional: add screenshots, e.g. ![Home](docs/screenshots/home.png) -->

##  Architecture

The app follows the **MVVM (Model–View–ViewModel)** pattern.

- **Model:** data classes (`User`, `Game`, `Log`, `Review`) and repositories (`AuthRepository`, `GameRepository`, `LogRepository`, `UserRepository`).
- **View:** the screens listed above. They only display data and forward user actions.
- **ViewModel:** holds screen state and calls repositories (`AuthViewModel`, `HomeViewModel`, `SearchViewModel`, `GameDetailViewModel`, `LogViewModel`, `ProfileViewModel`).

### Protocols and Interfaces

| Protocol / Interface | Purpose |
|---|---|
| HTTPS | Encrypted communication with the server |
| REST API (JSON) | Login, sign up, games, logs, reviews, follow data |
| Token-based auth (JWT) | Keeps the user signed in and identifies requests |
| Game database API (e.g., RAWG / IGDB) | Posters, release years, platforms, scores, descriptions |
| Secure / local storage | Stores the auth token and caches recent searches |
| Image caching | Smooth scrolling for posters and avatars |

See the full details in [Architecture and protocols](docs/architecture-and-protocols.pdf).

##  Repository Structure

```
played/
├── docs/
│   ├── design-justification.pdf
│   ├── user-flow.pdf
│   ├── architecture-and-protocols.pdf
│   └── screenshots/          # optional supporting material
└── README.md
```

##  License

This project was created for educational purposes.
