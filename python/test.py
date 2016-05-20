import mysql.connector
config = {
  'user': 'gatuser',
  'password': 'gatuser',
  'host': '10.8.7.63',
  'database': 'gatmgr2',
  'raise_on_warnings': True,
  'use_pure': False,
}
    
cnx = mysql.connector.connect(**config)

try:
   cursor = cnx.cursor()
   cursor.execute("""
      SELECT CURRENT_DATE()
   """)
   result = cursor.fetchall()
   print result
finally:
    cnx.close()