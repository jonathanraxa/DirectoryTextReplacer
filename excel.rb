require 'roo'

#xlsx = Roo::Spreadsheet.open('./test.xls')
xlsx = Roo::Excelx.new("./test.xls")

# Use the extension option if the extension is ambiguous.
#xlsx = Roo::Spreadsheet.open('./test', extension: :xlsx)

xlsx.info
# => Returns 