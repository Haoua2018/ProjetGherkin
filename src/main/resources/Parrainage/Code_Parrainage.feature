Feature: Traitement sur le code de parrainage

  #En tant que parrain, l'utilisateur génère un code de parrainage
 # en vue de parrainer une ou plusieurs nouveaux utilisateurs et bénéficie de récompenses

  Scenario: Génération du code de parrainage _ Cas passant
    Given L'utilisateur <Parrain> est authentifié sur le site de desbugs.com,
    And  et sur son profil utilisateur
    When L'utilisateur génère un code de parrainage
      |Parrain           |Code           |Date          |Validite          | Perime              |
      |parrain@zenity.fr | XXX-XXX-XXX   |jj/mm/aaaa    |  True or False   |  True or False      |

    Then le code de parrainage <Code> est affiché
    And Ce message s'affiche "Ce code est valide 24h"




   Scenario:Echec lors de la génération du code de parrainage _ Cas non passant
     Given L'utilisateur <Parrain> est authentifié sur le site de desbugs.com,
     And  et sur son profil utilisateur
     When L'utilisateur génère un code de parrainage
     |Parrain             |Code           |Date          |Validite          | Perime              |
     | parrain@zenity.fr  | XXX-XXX-XXX   |jj/mm/aaaa    |  True or False   | True or False      |
     Then le code de parrainage ne s'affiche pas
     And Ce message s'affiche "Echec lors de la création du code "