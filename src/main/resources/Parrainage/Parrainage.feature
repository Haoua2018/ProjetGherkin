Feature: Traitement sur le parrainage

  #En tant que parrainé, l'utilisateur utilise un code de parrainage
 # et en tant que parrain, l'utilisateur parraine une ou plusieurs nouveaux utilisateurs
 # et bénéficie de récompenses
Background: Parrainage
  Given L'utilisateur <X> est sur la page d'inscription de desbugs.com,
  And  avec sélection du compte type utilisateur et un code de parrainage
|X
|michellejean@zenity.com|
|jeanmichelle@zenity.com|

  Scenario Outline: Parrainage réussit avec Code valide et non périmé  _ Cas passant
       When L'utilisateur saisit un code de parrainage <Code> valide <Validite>et non périmé <Perime>

     |         Code   |Date          |Validite     |  Perime              |
     | XXX-XXX-XXX    |jj/mm/aaaa    |  True       |      False           |
     | XXX-XXX-XXX     |jj/mm/aaaa    |  True       |      False            |
    Then le code de parrainage <Code> est affiché
    And Ce message s'affiche "Parrainage validé,votre code promotionnel est xxx-xxxx"
Examples:
   |         Code   |Date          |Validite     |  Perime              |
   | 025-DCV-65X    |26/11/2024    |  True       |      False           |
   | X36-MBO-580     |25/11/2024    |  True       |      False

   # ************************************************

 Scenario Outline:Echec de parrainage avec Code périmé _ Cas non passant

     When L'utilisateur saisit un code de parrainage <Code> périmé <Perime>
        |Code           |Date          |Validite          |Perime              |
        | XXX-XXX-XXX   |jj/mm/aaaa    |    True          |True                 |
        | XXX-XXX-XXX   |jj/mm/aaaa    |  False           |  True
     #Date antérieure à date du jour, plus que 24h
     Then le code de parrainage s'affiche
     And Ce message s'affiche "Echec lors du parrainage, attention code périmé"

   Examples:
     |         Code   |Date          |Validite     |  Perime              |
     | 025-DC9-65X    |22/11/2024    |  True       |      True            |
     | X36-MBN-580     |25/10/2024    |  True       |      True           |


  Scenario Outline:Echec de parrainage avec Code non valide _ Cas non passant

    When L'utilisateur saisit un code de parrainage <Code> non valide <Validite>
      |X                      |Code           |Date          |Validite          |Perime              |
      |jeanmichelle@zenity.com| XXX-XXX-XXX   |jj/mm/aaaa    |    False         |False         |
      |michellejean@zenity.com| XXX-XXX-XXX   |jj/mm/aaaa    |  False            |  True
# le format du Code est soit numérique ou chaine de caractères ou erreur de saisie
    Then le code de parrainage s'affiche
    And Ce message s'affiche "Echec lors du parrainage, attention code incorrect"

    Examples:
      |         Code    |Date           |Validite     |  Perime              |
      | 025-561-650     |26/11/2024    |  False       |      False           |
      | XPO-MBN-TRE     |25/10/2024    |  False       |      True            |
      |25-MNO-65M       | 25/08/2024   |  False        |   True                  |
      |185-Y-PMI?OPM    |26/11/2024    |  False        |  False                  |