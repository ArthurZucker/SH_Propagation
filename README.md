# SH_Propagation
Projet de jeu en GODOT

# But du jeu
  Le but du jeu est de résoudre une énigme à l'aide de cartes.
  (Introduction de l'enquête : bande sonore que l'on peut trouver en scannant le QR code ou texte )
  1. On place une carte au milieu que tout le monde peut voir, on distribue 3 cartes à chaque joueur puis on forme une pioche face caché au centre de la table avec les cartes restantes.
  2. Les joueurs vont jouer chacun leur tour. Pendant son tour, le joueur à le choix entre jouer une carte face caché (défausser une carte) qu'il pense n'être pas pertinente pour l'enquête ou jouer une carte face visible qui sera partagée aux autres joueurs. À la fin de son tour, le joueur pioche une carte.
  3. Le jeu s'arrête lorsqu'il n'y a plus de carte dans la pioche et que les joueurs n'ont plus de carte en main, une fois cela, les joueurs discutent afin de répondre à 10 questions sur l'enquête (exemple: qui a tué la victime ? comment? etc..).
  4. Une fois que les participants ce sont mis d'accords pour chaque question, les réponses aux questions sont révélées.
  5. La dernière phase est la phase de scoring pour chaque carte rendu visible alors qu'elle n'était pas pertinentes pour résoudre l'enquête, le joueur perd un point. Selon le nombre de point qu'ils ont les joueurs sont classés (exemple si un joueur a plus de 18pts il est considére comme Sherlock Holmes)     

# Taches à effectuer
 - Une carte exemple de la bonne taille à faire sur blender puis rassembler photo carte recto verso avec gimp selon les dimensions que l'on a choisi
 - Un plateau de jeu à faire sur blender
 - Faire fonctionner le client et se familisariser
 - Faire le script godot
 - Mettre la bande sonore d'introduction
 - Dégager l'ensemble des tâches ainsi que la mécanique du projet   
 - Ajouter ou pas des objets blenders pour les personnages (APRÈS)

Graphique : Carte et plateau
Code : Action : Carte face visible / face caché

# Organisation du projet
 Arthur : Faire un carte modèle puis expliquer comment faire les cartes sur gimp
 Tout le monde : Faire les cartes sur gimp
 En attendant : Clément, Younes et Boudi: voir vidéo en pensant à comment adapter le code selon notre jeu (communication etc.. )  

# Format gimp :

  1. Ouvrir Gimp, ouvir l'image template
  3. Re-size le recto à ajouter (rogner) en 690x990, position (10,22)
  4. Copier  l'images coller sur l'image de taille 2048x1470
  5. Clique droit sur les image dans l'onglet à droite, add to new layer ![étapes](screen_layer.png)
  6. Resize l'image pour une width de 1024 et la mettre cote à cote
  7. Export as jpg, quality 100

## Répartition :
 -  Chacun fait 8 carte (4x8=32)

 | Image | Younes | Arthur | Clément | Boudhi |   |
 |-------|--------|--------|---------|--------|---|
 |       | 33->41       | 25->32     |42->50| 51->58    |   |
