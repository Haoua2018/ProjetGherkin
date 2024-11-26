Feature: Validation de commande avec paiement par carte bancaire
  En tant que client authentifié, l'utilisateur passe une commande
  et effectue un paiement par carte bancaire

  Background: Paiement par carte bancair
    Given L'utilisateur authentifié passe une commande
    And   Choisit le moyen de paiement par carte bancaire

Scenario: Paiement par carte bancaire _ Cas passant
 When L'utilisateur fournit les données de la carte bancaire <CB>
 # les caractéristiques DE LA CARTE Bancaire
  |numero carte       | nom carte      | date_validite|Solvable|
  |4551-5698-7874-9812| Benedicte Diego| 25/05/2030    | True      |
  Then  le paiement est validé
  |Retour_banque = OK|
  And le message de confirmation s'affiche " commande facturé"
  # les caractéristiques  Commande
    |Statut|numero_commande|Date_commande|Stock_produit|montant_commande
    |      |               |             |             ||
  And le statut de la commande devient "Facturé"



  Scenario: Echec Paiement par carte bancaire _Carte périmé_ Cas non passant
    When L'utilisateur fournit une carte bancaire périmé <CB>
    # les caractéristiques DE LA CARTE Bancaire
      |numero carte       | nom carte       | date_validite|Solvable|
      |4551-5698-7874-9812| Benedicte Diego| 25/05/2010    | False      |
    Then Le paiement en échec
      |Retour_banque = KO|
    And le message d'erreur indiquant le paiement en échec
    And Annulation de la commande et le statut ne change pas

  #date_validite inférieur à l'année en cours



  Scenario: Echec Paiement par carte bancaire _numéro Carte incorrect_ Cas non passant
    Given L'utilisateur authentifié passe une commande
    And   Choisit le moyen de paiement par carte bancaire
    When L'utilisateur fournit un numéro de carte bancaire incorrecte <CB>
     # les caractéristiques DE LA CARTE Bancaire
      |numero carte       | nom carte      | date_validite | Solvable|
      |8551-5698-7874-9812| Benedicte Diego| 25/05/2030    | True      |
    Then Le paiement en échec
      |Retour_banque = KO|
    And le message d'erreur indiquant le paiement en échec
    And Annulation de la commandeet le statut ne change pas



  Scenario: Echec Paiement par carte bancaire _nom Carte incorrect_ Cas non passant

    When L'utilisateur fournit un nom incorrecte de la carte bancaire  <CB>
    # les caractéristiques DE LA CARTE Bancaire
      |numero carte       |   nom carte     | date_validite |Solvable|
      |8551-5698-7874-9812|  Diego Benedicte| 25/05/2030    | True      |
    Then Le paiement en échec
      |Retour_banque = KO|
    And le message d'erreur indiquant le paiement en échec
    And Annulation de la commande



  Scenario: Echec Paiement par carte bancaire _non solvable_ Cas non passant

    When L'utilisateur fournit une carte bancaire non solvable <CB>
    # les caractéristiques DE LA CARTE Bancaire
      |numero carte| nom carte| date_validite|Solvable|

    Then Le paiement en échec
      |Retour_banque = KO|
    And le message d'erreur indiquant le paiement en échec
    And Annulation de la commande



  Scenario: Echec commande par carte bancaire _annulation paiement _ Cas non passant
     When L'utilisateur fournit une carte bancaire <CB>
    # les caractéristiques DE LA CARTE Bancaire
      |numero carte| nom carte| date_validite|Solvable|
    Then paiement est annulé
      |Retour_banque = KO|
    And le message d'erreur indiquant le paiement en échec
    And Annulation de la commande