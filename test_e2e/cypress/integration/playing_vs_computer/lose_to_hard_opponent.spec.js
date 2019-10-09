import { addMatchImageSnapshotCommand } from 'cypress-image-snapshot/command';
addMatchImageSnapshotCommand();

describe('Lose to hard opponent', function(){
  it('Opens the game', function() {
    cy.visit('/')
    cy.matchImageSnapshot('Expected Start Menu vs hard');
  })

  it('Starts a game round against a hard bot', function() {
    cy.get('#start-hard-btn').click()
    cy.wait(600)
    cy.matchImageSnapshot('Expected Empty Board vs hard');
  })

  it('Makes his first move', function() {
    cy.get('#space-1').click()
    cy.wait(600)
    cy.matchImageSnapshot('Expected First move vs hard');
  })

  it('Makes remaining moves vs hard ', function() {
    cy.get('#space-3').click()
    cy.wait(600)

    cy.get('#space-5').click()
    cy.wait(600)

    cy.matchImageSnapshot('Expected Defeat screen');
  })
})