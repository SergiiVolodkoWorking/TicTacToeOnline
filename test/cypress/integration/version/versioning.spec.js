describe('Versioning', function() {
  it('is visible on the start page', function() {
    cy.visit('/')
    cy.get('#version').should('contain', '0.11')
  })
})