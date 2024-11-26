Feature: Traitement sur le code de parrainage

  #En tant que parrain, l'utilisateur génère un code de parrainage
 # en vue de parrainer une ou plusieurs nouveaux utilisateurs et bénéficie de récompenses

  Scenario: Génération du code de parrainage _ Cas passant
    Given L'utilisateur est authentifié sur le site de desbugs.com,
    And  et sur son profil utilisateur
    When L'utilisateur génère un code de parrainage
    |Code           |Date          |Validite          |
    | XXX-XXX-XXX   |jj/mm/aaaa    |  True or False   |

    Then le code de parrainage est affiché sous format alphanumérique
    And Ce message s'affiche "Code valide 24h"




   Scenario:Erreur lors de la génération du code de parrainage _ Cas non passant
     Given L'utilisateur est authentifié sur le site de desbugs.com,
     And  et sur son profil utilisateur
     When L'utilisateur génère un code de parrainage
       |Code           |Date          |Validite          |
       | XXX-XXX-XXX   |jj/mm/aaaa    |  True or False   |
     Then le code de parrainage ne s'affiche pas
     And Ce message s'affiche "Erreur lors de la création du code "