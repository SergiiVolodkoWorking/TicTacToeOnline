import { addMatchImageSnapshotCommand } from 'cypress-image-snapshot/command';
addMatchImageSnapshotCommand();

describe('Win easy opponent', function(){
  before(() => {
    Cypress.config({
      viewportWidth: 1000,
      viewportHeight: 790,
    })
  })


  it('Opens the game', function() {
    cy.visit('/')
    cy.viewport(1000, 749)
    cy.matchImageSnapshot('Expected Start Menu');
  })

  it('Starts a game round against an easy bot', function() {
    cy.get('#start-easy-btn').click()
    cy.matchImageSnapshot('Expected Loading Spinner');
  })

  it('Waits few milliseconds until the round is lunched', function() {
    cy.wait(500)
    cy.matchImageSnapshot('Expected Empty Board');
  })

  it('Makes his first move', function() {
    cy.get('#space-0').click()
    cy.wait(1000)
    cy.matchImageSnapshot('Expected First move');
  })

  it('Makes remaining moves to win ', function() {
    cy.wait(1000)
    cy.get('#space-3').click()
    cy.wait(1000)

    cy.get('#space-4').click()
    cy.wait(1000)

    cy.get('#space-7').click()
    cy.wait(1000)

    cy.get('#space-8').click()
    cy.wait(1000)

    cy.matchImageSnapshot('Expected Victory screen');
  })
})