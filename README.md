# CareferTaskEPL

Hi,

To add a match as favorite, long press on the match.

Architecture: 
- I used a layered architecture where business logic, presentation logic, view and data access are separated.
- Dependencies are mostly on protocols instead of concrete implementations which makes the code reusable and maintainable, 
as you can inject different providers, such as one for coredata instead of moya provider or you can inject a mock provider for unit testing.
- I also used the composition root pattern where depenecy injection happens at the start point of the app.
- I used different objects that speak the language each layer should be concerned with, 
which helps make each layer as dumb of its surroundings as possiple, and I used an adapter protocol to map between the 3 objects.
