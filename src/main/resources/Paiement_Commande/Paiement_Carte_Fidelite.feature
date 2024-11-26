Feature: Validation de commande avec paiement par carte de fidélité
  En tant que client authentifié, l'utilisateur passe une commande
  et effectue un paiement par carte de fidélité

  Background: Paiement par carte de fidélité
    Given L'utilisateur authentifié passe une commande
    And   Choisit le moyen de paiement par carte de fidélité

  Scenario: Paiement par carte de fidélité _ Cas passant

    When L'utilisateur fournit la carte de fidélité  <FID>
    # les caractéristiques DE LA CARTE de fidélité
      | cagnote| nom carte    |id compte              |
      | 520    | Jean michelle|jeanmichelle@zenity.com|
    Then  le paiement est validé

  # les caractéristiques  Commande
      |Statut|numero_commande|Date_commande|Stock_produit|montant_commande
      |  vide| cmd456        |26/11/2024   | 582         |500
    # montant_commande - cagnote >= 0
    And le message de confirmation s'affiche " commande facturé"
    And commande validée et statut de la commande devient "Facturé_FID"





  Scenario: Paiement par carte de fidélité _Cagnote vide_ Cas non passant

    When L'utilisateur fournit la carte de fidélité
   # les caractéristiques DE LA CARTE de fidélité
      | cagnote| nom carte             |id compte |
      |0       |  Jean michelle        | jeanmichelle@zenity.com         |
    And  et la cagnotte est vide <FID>
    Then Le paiement en échec

  # les caractéristiques  Commande
      |Statut|numero_commande|Date_commande|Stock_produit|montant_commande
      |  vide| cmd456        |26/11/2024   | 582         |500
    # montant_commande > cagnote
    And le message d'erreur indiquant le paiement en échec
    And Annulation de la commande et le statut ne change pas


  Scenario: Paiement par carte de fidélité _Cagnote insuffisant_ Cas non passant

    When L'utilisateur fournit la carte de fidélité
   # les caractéristiques DE LA CARTE de fidélité
      | cagnote | nom carte             |id compte |
      |50       |  Jean michelle        | jeanmichelle@zenity.com         |
    And  et la cagnotte est insuffisante <FID>
      |montant_commande=500|
    Then Le paiement se poursuit avec un second moyen de paiement
    But Aucun autre choix de paiement supplémentaire
    And Annulation de la commande et le statut ne change pas