import { addMatchImageSnapshotCommand } from 'cypress-image-snapshot/command';
addMatchImageSnapshotCommand();

describe('Win easy opponent', function(){
  it('Opens the game', function() {
    cy.visit('/')
    cy.matchImageSnapshot('Expected Start Menu');
  })

  it('Starts a game round against an easy bot', function() {
    cy.wait(10)
    cy.get('#start-easy-btn').click()
    cy.matchImageSnapshot('Expected Loading Spinner');
  })

  it('Waits few milliseconds until the round is lunched', function() {
    cy.wait(500)
    cy.matchImageSnapshot('Expected Empty Board');
  })
  it('Makes his first move', function() {
    cy.wait(10)
    cy.get('#space-4').click()
    cy.wait(1000)
    cy.matchImageSnapshot('Expected First move');
  })

})