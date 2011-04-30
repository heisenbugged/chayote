class InvoiceRate < Rate
  referenced_in :invoice
  referenced_in :user
end