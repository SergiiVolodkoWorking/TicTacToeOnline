describe('Versioning', function() {
  it('is visible on the start page', function() {
    cy.visit('/')
    var expected = '0.11'
    cy.get('#version').should('contain', expected)
  })
})