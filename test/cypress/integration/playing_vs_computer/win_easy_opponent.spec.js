import { addMatchImageSnapshotCommand } from 'cypress-image-snapshot/command';
addMatchImageSnapshotCommand();

describe('Win easy opponent', function(){
  it('Opens the game', function() {
    cy.visit('/')
    cy.matchImageSnapshot('Expected Start Menu');
  })

  it('Starts a game round against an easy bot', function() {
    cy.wait(100)
    cy.get('#start-easy-btn').click()
    cy.matchImageSnapshot('Expected Empty Board');
  })
})