import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.Year;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Scanner;

public class Query {
    private final Database database;
    private final Scanner scanner = new Scanner(System.in);

    public Query(Database database) {
        this.database = database;
    }

    public void query1() throws SQLException {
        PreparedStatement preparedStatement;

        // Query inserimento cliente
        String query = "INSERT INTO Cliente (email, passwd, nome, cognome, datadinascita, " +
                "numeroditelefono, nazionalita) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String email;

        preparedStatement = database.getConnection().prepareStatement(query);

        System.out.print("Inserisci email: ");
        email = scanner.nextLine();
        preparedStatement.setString(1, email);

        System.out.print("Inserisci password: ");
        preparedStatement.setString(2, scanner.nextLine());

        System.out.print("Inserisci nome: ");
        preparedStatement.setString(3, scanner.nextLine());

        System.out.print("Inserisci cognome: ");
        preparedStatement.setString(4, scanner.nextLine());

        System.out.print("Inserisci data di nascita (YYYY-MM-DD): ");
        preparedStatement.setDate(5, Date.valueOf(scanner.nextLine()));

        System.out.print("Inserisci numero di telefono: ");
        preparedStatement.setString(6, scanner.nextLine());

        System.out.print("Inserisci nazionalità: ");
        preparedStatement.setString(7, scanner.nextLine());

        preparedStatement.execute();
        preparedStatement.close();

        // Query inserimento tessera
        query = "INSERT INTO TesseraFedelta (Cliente, tipo, dataEmissione, dataScadenza, scontoPremium) " +
                "VALUES (?, ?, ?, ?, ?)";
        String tipo;
        Date dataEmissione;

        preparedStatement = database.getConnection().prepareStatement(query);

        preparedStatement.setString(1, email);

        System.out.print("Inserire il tipo di tessera (0 Standard, 1 Premium): ");
        if (scanner.nextInt() == 1)
            tipo = "Premium";
        else
            tipo = "Standard";
        preparedStatement.setString(2, tipo);

        // Data emissione = data corrente
        dataEmissione = new Date(System.currentTimeMillis());
        preparedStatement.setDate(3, dataEmissione);

        // La tessera scade 10 anni dopo
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(dataEmissione);
        calendar.add(Calendar.YEAR, 10);
        preparedStatement.setDate(4, new Date(calendar.getTimeInMillis()));

        if (tipo.equals("Premium")) {
            System.out.print("Inserire la quantità di sconto premium: ");
            preparedStatement.setInt(5, scanner.nextInt());
        }
        else
            preparedStatement.setInt(5, 0);

        preparedStatement.execute();
        preparedStatement.close();

        System.out.println("\n-------------- Cliente registrato --------------");
    }

    public void query2() throws SQLException {
        PreparedStatement statementStruttura, statementTipo = null;
        String queryStruttura = "INSERT INTO StrutturaRicettiva (annoDiIscrizione, nome, citta, via, cap) " +
                "VALUES (?, ?, ?, ?, ?)";
        String queryTipo;
        char tipo;
        int StrutturaRicettiva;

        statementStruttura = database.getConnection().prepareStatement(queryStruttura);

        System.out.println("-------------- Inserisci Struttura --------------");

        // Richiesta informazioni struttura ricettiva
        statementStruttura.setInt(1, Year.now().getValue());

        System.out.print("Inserire il nome: ");
        statementStruttura.setString(2, scanner.nextLine());

        System.out.print("Inserire la città: ");
        statementStruttura.setString(3, scanner.nextLine());

        System.out.print("Inserire la via: ");
        statementStruttura.setString(4, scanner.nextLine());

        System.out.print("Inserire il cap: ");
        statementStruttura.setString(5, scanner.nextLine());

        // Ottenimento ultima struttura inserita
        Statement statement;
        ResultSet resultSet;

        statement = database.getConnection().createStatement();
        resultSet = statement.executeQuery("SELECT MAX(codiceStruttura) as Max FROM StrutturaRicettiva");

        resultSet.next();
        StrutturaRicettiva = resultSet.getInt("Max") + 1;
        statement.close();

        // Richiesta di tipologia
        System.out.println("\n1. Hotel\n2. Ostello\n3. Appartamento\n");
        System.out.print("Quale tipo di struttura ricettiva si desidera registrare?: ");
        tipo = scanner.nextLine().charAt(0);

        switch (tipo) {
            case '1' -> {
                queryTipo = "INSERT INTO Hotel VALUES (?)";
                statementTipo = database.getConnection().prepareStatement(queryTipo);

                statementTipo.setInt(1, StrutturaRicettiva);
            }

            case '2' -> {
                queryTipo = "INSERT INTO Ostello (StrutturaRicettiva, prezzoNottePostoLetto, postiLettoTotali) " +
                        "VALUES(?, ?, ?)";
                statementTipo = database.getConnection().prepareStatement(queryTipo);

                statementTipo.setInt(1, StrutturaRicettiva);

                System.out.print("Inserire il prezzo a notte per posto letto: ");
                statementStruttura.setFloat(2, scanner.nextFloat());

                System.out.print("Inserire i posti letto totali: ");
                statementStruttura.setInt(3, scanner.nextInt());
            }

            case '3' -> {
                queryTipo = "INSERT INTO Appartamento (StrutturaRicettiva, prezzoNotte, postiLetto, metriQuadri, vani) " +
                        "VALUES (?, ?, ?, ?, ?)";
                statementTipo = database.getConnection().prepareStatement(queryTipo);

                statementTipo.setInt(1, StrutturaRicettiva);

                System.out.print("Inserire il prezzo a notte: ");
                statementStruttura.setFloat(2, scanner.nextFloat());

                System.out.print("Inserire i posti letto totali: ");
                statementStruttura.setInt(3, scanner.nextInt());

                System.out.print("Inserire i metri quadri: ");
                statementStruttura.setInt(4, scanner.nextInt());

                System.out.print("Inserire i vani quadri: ");
                statementStruttura.setInt(5, scanner.nextInt());
            }

            default -> System.out.println("Codice struttura non coretto");
        }

        if (statementTipo != null) {
            statementStruttura.execute();
            statementStruttura.close();
            statementTipo.execute();
            statementTipo.close();

            System.out.println("-------------- Struttura Registrata --------------");
        }
        else {
            statementStruttura.close();
        }

        if (tipo == '1') {
            inserimentoStanza(StrutturaRicettiva);
        }
    }

    private void inserimentoStanza(int Hotel) throws SQLException {
        String queryTipoStanza = "INSERT INTO TipoStanza (tipologia, prezzoNotte, postiLetto, stanzePerTipologia, " +
                "Hotel) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement statementStanza = database.getConnection().prepareStatement(queryTipoStanza);


        System.out.print("\n-------------- Inserisci dati Tipi Stanza --------------\n");

        do {
            System.out.print("Inserisci nome tipologia: ");
            statementStanza.setString(1, scanner.nextLine());

            System.out.print("Inserisci prezzo a notte: ");
            statementStanza.setFloat(2, Float.parseFloat(scanner.nextLine()));

            System.out.print("Inserisci numero di posti letto: ");
            statementStanza.setInt(3, Integer.parseInt(scanner.nextLine()));

            System.out.print("Inserisci il numero di stanza di questa tipologia: ");
            statementStanza.setInt(4, Integer.parseInt(scanner.nextLine()));
            System.out.println(" ");

            statementStanza.setInt(5, Hotel);

            statementStanza.execute();

            System.out.print("Continuare? (1 = si, 0 = no): ");
        } while (scanner.nextLine().charAt(0) == '1');

        System.out.println("\n-------------- Stanze registrate -------------- ");

        statementStanza.close();
    }

    public void query3() throws SQLException {
        PreparedStatement verificaCliente;
        ResultSet resultSet;
        String email;

        System.out.println("-------------- Prenotazione di una struttura --------------");
        System.out.print("Inserire l'email: ");
        email = scanner.nextLine();

        verificaCliente = database.getConnection().prepareStatement("SELECT numeroPrenotazioniAttive FROM Cliente " +
                "WHERE email = ?");
        verificaCliente.setString(1, email);
        resultSet = verificaCliente.executeQuery();

        if (!resultSet.next())
            System.out.println("Il cliente non è presente nel database");
        else if (resultSet.getInt("numeroPrenotazioniAttive") == 2)
            System.out.println("Il cliente ha già due prenotazioni attive");
        else {
            Statement agenzieDiViaggio;
            char sel;

            verificaCliente.close();

            System.out.println("\n-------------- Inserisci date prenotazione --------------");
            System.out.print("Data check-in (YYYY-MM-DD): ");
            String dataCheckIn = scanner.nextLine();
            System.out.print("Data check-out (YYYY-MM-DD): ");
            String dataCheckOut = scanner.nextLine();

            agenzieDiViaggio = database.getConnection().createStatement();
            resultSet = agenzieDiViaggio.executeQuery("SELECT * FROM AgenziaDiViaggio");

            System.out.println("\n-------------- Agenzie di viaggio disponibili --------------");

            int risultati;
            for (risultati = 1; resultSet.next(); risultati++) {
                System.out.printf("(%d):\tCodice Agenzia: %d\t%s\n", risultati, resultSet.getInt("codiceAgenzia"),
                        resultSet.getString("nome"));
            }

            agenzieDiViaggio.close();

            risultati -= 1;
            System.out.print("\nSelezionare il codice di una delle " + risultati + " agenzie di viaggio: ");
            String selAgenzia = scanner.nextLine();
            int codiceAgenzia = Integer.parseInt(selAgenzia);

            if (codiceAgenzia <= 0) {
                System.out.println("Codice agenzia non corretto");
                return;
            }

            System.out.print("""
                    
                    1. Appartamento
                    2. Ostello
                    3. Hotel
                    
                    Quale struttura ricettiva vuoi prenotare?:\s""");

            sel = scanner.nextLine().charAt(0);

            PreparedStatement preparedStatement;
            String fileQuery = null, queryPrezzo = null, queryInsert = null;
            StringBuilder queryStruttura = new StringBuilder();

            switch (sel) {
                case '1' ->  {
                    fileQuery = "query/query3_appartamenti.sql";
                    queryInsert = "INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, durataSoggiorno, prezzoTotale, numeroOspiti, Cliente, notaCliente, Appartamento, AgenziaDiViaggio) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    queryPrezzo = "SELECT prezzoNotte AS Prezzo FROM Appartamento " +
                            "WHERE StrutturaRicettiva = ?";
                }
                case '2' ->  {
                    fileQuery = "query/query3_ostelli.sql";
                    queryInsert = "INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, durataSoggiorno, prezzoTotale, numeroOspiti, Cliente, notaCliente, Ostello, AgenziaDiViaggio) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    queryPrezzo = "SELECT prezzoNottePostoLetto AS Prezzo FROM Ostello " +
                            "WHERE StrutturaRicettiva = ?";
                }
                case '3' -> fileQuery = "query/query3_hotel.sql";
                default -> System.out.println("Codice struttura non coretto");
            }
            
            if (fileQuery == null)
                return;

            try (BufferedReader bufferedReader = new BufferedReader(new FileReader(fileQuery))) {
                String line = bufferedReader.readLine();
                while (line != null) {
                    queryStruttura.append(line);
                    line = bufferedReader.readLine();
                }
            } catch (IOException e) {
                System.out.println("File query non trovato");
            }

            preparedStatement = database.getConnection().prepareStatement(String.valueOf(queryStruttura));

            for (int i = 1; i <= 6; i++ ) {
                if (i % 2 == 0)
                    preparedStatement.setDate(i, Date.valueOf(dataCheckOut));
                else
                    preparedStatement.setDate(i, Date.valueOf(dataCheckIn));
            }

            resultSet = preparedStatement.executeQuery();

            if (resultSet == null) {
                System.out.println("Non è possibile prenotare nelle date inserite per le strutture selezionate");
                return;
            }

            System.out.println("\n-------------- Strutture disponibili --------------");

            for (risultati = 1; resultSet.next(); risultati++) {
                System.out.printf("(%d):\tCodice Struttura: %d\t%d\t%s\t%s\t%s\t%s\n", risultati, resultSet.getInt("codiceStruttura"),
                        resultSet.getInt("annoDiIscrizione"), resultSet.getString("nome"),
                        resultSet.getString("citta"), resultSet.getString("via"),
                        resultSet.getString("cap"));
            }

            preparedStatement.close();

            risultati -= 1;
            System.out.print("\nSelezionare il codice di una delle " + risultati + " Strutture: ");
            String selStruttura = scanner.nextLine();
            int codiceStruttura = Integer.parseInt(selStruttura);

            if (codiceStruttura <= 0) {
                System.out.println("Codice struttura non corretto");
                return;
            }

            if (sel == '3') {
                prenotaStanza(codiceStruttura, codiceAgenzia, email, dataCheckIn, dataCheckOut);
                return;
            }

            preparedStatement = database.getConnection().prepareStatement(queryInsert);

            preparedStatement.setDate(1, Date.valueOf(dataCheckIn));
            preparedStatement.setDate(2, Date.valueOf(dataCheckOut));

            int durataSoggiorno = (int) ChronoUnit.DAYS.between(LocalDate.parse(dataCheckIn), LocalDate.parse(dataCheckOut));
            preparedStatement.setInt(3, durataSoggiorno);

            System.out.print("Inserire il numero di ospiti: ");
            int numeroOspiti = scanner.nextInt(); scanner.nextLine();
            preparedStatement.setInt(5, numeroOspiti);

            // Calcolo del prezzo della prenotazione
            float prezzoTotale;
            PreparedStatement calcoloPrezzo;

            calcoloPrezzo = database.getConnection().prepareStatement(queryPrezzo);
            calcoloPrezzo.setInt(1, codiceStruttura);
            resultSet = calcoloPrezzo.executeQuery();

            resultSet.next();
            prezzoTotale = (resultSet.getFloat("Prezzo") * numeroOspiti) * durataSoggiorno;
            calcoloPrezzo.close();

            PreparedStatement statementSconto;
            ResultSet resultSetSconto;
            String querySconto = "SELECT IFNULL(scontoPremium, 0) AS scontoPremium " +
                    "FROM TesseraFedelta " +
                    "WHERE Cliente = ?";
            statementSconto = database.getConnection().prepareStatement(querySconto);
            statementSconto.setString(1, email);
            resultSetSconto = statementSconto.executeQuery();
            resultSetSconto.next();

            float sconto = resultSetSconto.getFloat("scontoPremium");

            if (sconto == 0)
                preparedStatement.setFloat(4, prezzoTotale);
            else {
                prezzoTotale = prezzoTotale - ((prezzoTotale * sconto) / 100);
                preparedStatement.setFloat(4, prezzoTotale);
            }

            statementSconto.close();
            // ------------------------------------------

            preparedStatement.setString(6, email);

            System.out.print("Inserire eventuali note: ");
            preparedStatement.setString(7, scanner.nextLine());

            preparedStatement.setInt(8, codiceStruttura);

            preparedStatement.setInt(9, codiceAgenzia);

            System.out.println("Il costo della prenotazione è di €" + prezzoTotale);

            preparedStatement.execute();
            preparedStatement.close();

            System.out.println("\n-------------- Prenotazione effettuata --------------");

            incrementoNumeroPrenotazioni(email);
        }
    }

    private void prenotaStanza(int codiceStruttura, int codiceAgenzia, String email, String dataCheckIn, String dataCheckOut) throws SQLException {
        StringBuilder queryStanze = new StringBuilder();
        PreparedStatement preparedStatement;
        ResultSet resultSet;

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader("query/query3_dispstanze.sql"))) {
            String line = bufferedReader.readLine();
            while (line != null) {
                queryStanze.append(line);
                line = bufferedReader.readLine();
            }
        } catch (IOException e) {
            System.out.println("File query non trovato");
        }

        preparedStatement = database.getConnection().prepareStatement(String.valueOf(queryStanze));

        for (int i = 1; i <= 6; i++ ) {
            if (i % 2 == 0)
                preparedStatement.setDate(i, Date.valueOf(dataCheckOut));
            else
                preparedStatement.setDate(i, Date.valueOf(dataCheckIn));
        }

        preparedStatement.setInt(7, codiceStruttura);

        resultSet = preparedStatement.executeQuery();

        System.out.println("\n-------------- Tipi stanza disponibili --------------");

        int risultati;
        for (risultati = 1; resultSet.next(); risultati++) {
            System.out.printf("(%d):\tCodice Tipologia: %d\t%s\t%d\t%d\t%d\n", risultati, resultSet.getInt("codiceTipologia"),
                    resultSet.getString("tipologia"), resultSet.getInt("prezzoNotte"),
                    resultSet.getInt("postiLetto"), resultSet.getInt("stanzePerTipologia"));
        }

        preparedStatement.close();

        risultati -= 1;
        System.out.print("\nSelezionare il codice tipologia di uno dei " + risultati + " Tipi stanza: ");
        String selTipologia = scanner.nextLine();
        int codiceTipologia = Integer.parseInt(selTipologia);

        if (codiceStruttura <= 0) {
            System.out.println("Codice tipologia non corretto");
            return;
        }

        preparedStatement = database.getConnection().prepareStatement("INSERT INTO Prenotazione (dataCheckIn, " +
                "dataCheckOut, durataSoggiorno, prezzoTotale, numeroOspiti, Cliente, notaCliente, TipoStanza, " +
                "StanzePrenotate, AgenziaDiViaggio) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        String queryPrezzo = "SELECT prezzoNotte AS Prezzo FROM TipoStanza " +
                "WHERE codiceTipologia = ?";

        preparedStatement.setDate(1, Date.valueOf(dataCheckIn));
        preparedStatement.setDate(2, Date.valueOf(dataCheckOut));

        int durataSoggiorno = (int) ChronoUnit.DAYS.between(LocalDate.parse(dataCheckIn), LocalDate.parse(dataCheckOut));
        preparedStatement.setInt(3, durataSoggiorno);

        System.out.print("Inserire il numero di ospiti: ");
        int numeroOspiti = scanner.nextInt(); scanner.nextLine();
        preparedStatement.setInt(5, numeroOspiti);

        // Calcolo del prezzo della prenotazione
        float prezzoTotale;
        PreparedStatement calcoloPrezzo;

        calcoloPrezzo = database.getConnection().prepareStatement(queryPrezzo);
        calcoloPrezzo.setInt(1, codiceTipologia);
        resultSet = calcoloPrezzo.executeQuery();

        resultSet.next();
        prezzoTotale = (resultSet.getFloat("Prezzo") * numeroOspiti) * durataSoggiorno;
        calcoloPrezzo.close();
        PreparedStatement statementSconto;
        ResultSet resultSetSconto;
        String querySconto = "SELECT IFNULL(scontoPremium, 0) AS scontoPremium " +
                "FROM TesseraFedelta " +
                "WHERE Cliente = ?";
        statementSconto = database.getConnection().prepareStatement(querySconto);
        statementSconto.setString(1, email);
        resultSetSconto = statementSconto.executeQuery();
        resultSetSconto.next();

        float sconto = resultSetSconto.getFloat("scontoPremium");
        if (sconto == 0)
            preparedStatement.setFloat(4, prezzoTotale);
        else {
            prezzoTotale = prezzoTotale - ((prezzoTotale * sconto) / 100);
            preparedStatement.setFloat(4, prezzoTotale);
        }

        statementSconto.close();
        // ------------------------------------------

        preparedStatement.setString(6, email);

        System.out.print("Inserire eventuali note: ");
        preparedStatement.setString(7, scanner.nextLine());

        preparedStatement.setInt(8, codiceTipologia);

        System.out.print("Inserire il numero di stanze da prenotare: ");
        preparedStatement.setInt(9, scanner.nextInt());

        preparedStatement.setInt(10, codiceAgenzia);

        System.out.println("Il costo della prenotazione è di €" + prezzoTotale);

        preparedStatement.execute();
        preparedStatement.close();

        System.out.println("\n-------------- Prenotazione effettuata --------------");

        incrementoNumeroPrenotazioni(email);
    }

    private void incrementoNumeroPrenotazioni(String email) throws SQLException {
        String query = "UPDATE Cliente " +
                "SET numeroPrenotazioniAttive = numeroPrenotazioniAttive +1, numeroPrenotazioni = numeroPrenotazioni + 1 " +
                "WHERE email = ?";

        PreparedStatement preparedStatement = database.getConnection().prepareStatement(query);
        preparedStatement.setString(1, email);
        preparedStatement.execute();

        preparedStatement.close();
    }

    public void query4() throws SQLException {
        PreparedStatement statementEmail;
        ResultSet resultSet;
        String email;

        System.out.println("-------------- Aggiornamento a tessera premium --------------");
        System.out.print("Inserire l'email del cliente: ");
        email = scanner.nextLine();

        statementEmail = database.getConnection().prepareStatement("SELECT email FROM Cliente " +
                "WHERE email = ?");
        statementEmail.setString(1, email);
        resultSet = statementEmail.executeQuery();

        if (!resultSet.next())
            System.out.println("Il cliente non è presente nel database");
        else {
            PreparedStatement statementPremium;

            statementPremium = database.getConnection().prepareStatement("SELECT tipo " +
                    "FROM TesseraFedelta WHERE Cliente = ?");
            statementPremium.setString(1, email);
            resultSet = statementPremium.executeQuery();

            resultSet.next();
            String tipo = resultSet.getString("tipo");

            if (tipo.equals("Premium"))
                System.out.println("Il cliente è già premium");
            else if (tipo.equals("Standard")) {
                PreparedStatement updatePremium = database.getConnection().prepareStatement("UPDATE " +
                        "TesseraFedelta SET tipo = ?, scontoPremium = ? WHERE Cliente = ?");

                updatePremium.setString(1, "Premium");

                System.out.print("Inserire lo sconto da assegnare: ");
                updatePremium.setInt(2, scanner.nextInt());

                updatePremium.setString(3, email);

                updatePremium.execute();
                updatePremium.close();

                System.out.println("\n-------------- Aggiornamento effettuato --------------");
            }

            statementPremium.close();
        }

        statementEmail.close();
    }

    public void query5() throws SQLException {
        Statement statement;
        ResultSet resultSet;
        String query = "SELECT * FROM StrutturaRicettiva ORDER BY citta";

        statement = database.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++)
            System.out.printf("(%d):\t%d\t%d\t%s\t%s\t%s\t%s\n", i, resultSet.getInt("codiceStruttura"),
                    resultSet.getInt("annoDiIscrizione"), resultSet.getString("nome"),
                    resultSet.getString("citta"), resultSet.getString("via"), resultSet.getString("cap"));

        statement.close();
    }

    public void query6_7(boolean minoreDi50) throws SQLException, FileNotFoundException {
        PreparedStatement preparedStatement;
        ResultSet resultSet;
        StringBuilder query = new StringBuilder();
        FileReader fileReader;

        if (!minoreDi50)
            fileReader = new FileReader("query/query6.sql");
        else
            fileReader = new FileReader("query/query7.sql");

        try (BufferedReader bufferedReader = new BufferedReader(fileReader)) {
            String line = bufferedReader.readLine();
            while (line != null) {
                query.append(line);
                line = bufferedReader.readLine();
            }
        } catch (IOException e) {
            System.out.println("File query non trovato");
        }

        String dataInizio, dataFine;
        System.out.println("-------------- Inserisci data di inizio e data di fine --------------");
        System.out.print("Data inizio (YYYY-MM-DD): ");
        dataInizio = scanner.nextLine();
        System.out.print("Data fine (YYYY-MM-DD): ");
        dataFine = scanner.nextLine();

        preparedStatement = database.getConnection().prepareStatement(String.valueOf(query));

        for (int i = 1; i <= 18; i++) {
            if (i % 2 == 0)
                preparedStatement.setString(i, dataFine);
            else
                preparedStatement.setString(i, dataInizio);
        }

        resultSet = preparedStatement.executeQuery();

        System.out.println("\n-------------- Strutture disponibili --------------");

        for (int i = 1; resultSet.next(); i++)
            System.out.printf("(%d):\t%d\t%d\t%s\t%s\t%s\t%s\n", i, resultSet.getInt("codiceStruttura"),
                    resultSet.getInt("annoDiIscrizione"), resultSet.getString("nome"),
                    resultSet.getString("citta"), resultSet.getString("via"), resultSet.getString("cap"));

        preparedStatement.close();
    }

    public void query8() throws SQLException {
        String query =  "SELECT Cliente, COUNT(Cliente) AS TotaliPrenotazioni " +
                        "FROM Prenotazione " +
                        "WHERE dataCheckIn BETWEEN (DATE_SUB(CURDATE(), INTERVAL 30 DAY)) AND CURDATE() " +
                        "GROUP BY Cliente";

        Statement statement = database.getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d): %s\tNumero prenotazioni: %s\n", i, resultSet.getString("Cliente"),
                              resultSet.getString("TotaliPrenotazioni")) ;
        }

        statement.close();
    }

    public void query9() throws SQLException {
        Statement statement;
        ResultSet resultSet;
        StringBuilder query = new StringBuilder();

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader("query/query9.sql"))) {
            String line = bufferedReader.readLine();
            while (line != null) {
                query.append(line);
                line = bufferedReader.readLine();
            }
        } catch (IOException e) {
            System.out.println("File query non trovato");
        }

        statement = database.getConnection().createStatement();

        resultSet = statement.executeQuery(String.valueOf(query));

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %s\t%s\t%s\t%s\t%s\t%s\tPrenotazioni totali: %d\n", i, resultSet.getString("email"),
                    resultSet.getString("nome"), resultSet.getString("cognome"), resultSet.getDate("dataDiNascita"),
                    resultSet.getString("numeroDiTelefono"), resultSet.getString("nazionalita"),
                    resultSet.getInt("PrenotazioniTotali"));
        }

        statement.close();
    }

    public void query10() throws SQLException {
        String query = "SELECT DISTINCT codiceStruttura, annoDiIscrizione, nome, citta, via, cap " +
                "FROM Prenotazione, Ostello " +
                "JOIN StrutturaRicettiva ON Ostello.StrutturaRicettiva = StrutturaRicettiva.codiceStruttura " +
                "WHERE durataSoggiorno < 7 " +
                "AND Prenotazione.Ostello = Ostello.StrutturaRicettiva";
        Statement statement;
        ResultSet resultSet;

        statement = database.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %d\t%d\t%s\t%s\t%s\t%s\n", i, resultSet.getInt("codiceStruttura"),
                    resultSet.getInt("annoDiIscrizione"),
                    resultSet.getString("nome"), resultSet.getString("citta"),
                    resultSet.getString("via"), resultSet.getString("cap"));
        }

        statement.close();
    }

    public void query11() throws SQLException {
        String query = "SELECT PDI.nome AS PuntoDiInteresse, km AS DistanzaInKm, codiceStruttura, " +
                "annoDiIscrizione, SR.nome, SR.citta, SR.via, SR.cap " +
                "FROM StrutturaRicettiva AS SR " +
                "JOIN Distanza D ON SR.codiceStruttura = D.StrutturaRicettiva " +
                "JOIN PuntoDiInteresse PDI ON D.PuntoDiInteresse = PDI.codicePuntoDiInteresse " +
                "WHERE PDI.nome LIKE ? AND km <= 10";
        PreparedStatement preparedStatement;
        ResultSet resultSet;

        preparedStatement = database.getConnection().prepareStatement(query);

        String nomePunto;
        System.out.print("Inserire il nome del punto di interesse: ");
        nomePunto = scanner.nextLine();
        nomePunto = "%" + nomePunto + "%";
        preparedStatement.setString(1, nomePunto);

        resultSet = preparedStatement.executeQuery();

        System.out.println("\n-------------- Strutture distanti meno di 10km dal punto indicato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %s\t%d\t%d\t%d\t%s\t%s\t%s\t%s\n", i, resultSet.getString("PuntoDiInteresse"),
                    resultSet.getInt("DistanzaInKm"), resultSet.getInt("codiceStruttura"),
                    resultSet.getInt("annoDiIscrizione"), resultSet.getString("nome"),
                    resultSet.getString("citta"), resultSet.getString("via"), resultSet.getString("cap"));
        }

        preparedStatement.close();
    }

    public void query12() throws SQLException {
        Statement statement;
        ResultSet resultSet;
        StringBuilder query = new StringBuilder();

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader("query/query12.sql"))) {
            String line = bufferedReader.readLine();
            while (line != null) {
                query.append(line);
                line = bufferedReader.readLine();
            }
        } catch (IOException e) {
            System.out.println("File query non trovato");
        }

        statement = database.getConnection().createStatement();

        resultSet = statement.executeQuery(String.valueOf(query));

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %d\t%d\t%s\t%s\t%s\t%s\tIncasso totale: %d\n", i, resultSet.getInt("codiceStruttura"),
                    resultSet.getInt("annoDiIscrizione"),
                    resultSet.getString("nome"), resultSet.getString("citta"),
                    resultSet.getString("via"), resultSet.getString("cap"), resultSet.getInt("IncassoTotale"));
        }

        statement.close();
    }

    public void query13() throws SQLException {
        String query = "SELECT email, nome, cognome, dataDiNascita, numeroDiTelefono, nazionalita, " +
                "numeroPrenotazioni, numeroPrenotazioniAttive " +
                "FROM Cliente " +
                "JOIN Prenotazione ON Cliente.email = Prenotazione.Cliente " +
                "WHERE TipoStanza IS NULL";

        Statement statement;
        ResultSet resultSet;

        statement = database.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %s\t%s\t%s\t%s\t%s\t%s\t%d\t%d\n", i, resultSet.getString("email"),
                    resultSet.getString("nome"), resultSet.getString("cognome"), resultSet.getDate("dataDiNascita"),
                    resultSet.getString("numeroDiTelefono"),resultSet.getString("nazionalita"),
                    resultSet.getInt("numeroPrenotazioni"), resultSet.getInt("numeroPrenotazioniAttive"));
        }

        statement.close();
    }

    public void query14() throws SQLException {
        String query = "SELECT COUNT(AgenziaDiViaggio) AS PrenotazioniTotali, codiceAgenzia, nome " +
                "FROM Prenotazione " +
                "RIGHT JOIN AgenziaDiViaggio ON Prenotazione.AgenziaDiViaggio = AgenziaDiViaggio.codiceAgenzia " +
                "GROUP BY codiceAgenzia";

        Statement statement;
        ResultSet resultSet;

        statement = database.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %s\t%d\tPrenotazioni totali: %s\n", i, resultSet.getString("nome"),
                    resultSet.getInt("codiceAgenzia"), resultSet.getString("PrenotazioniTotali"));
        }

        statement.close();
    }

    public void query15() throws SQLException {
        PreparedStatement preparedStatement;
        ResultSet resultSet;
        StringBuilder query = new StringBuilder();

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader("query/query15.sql"))) {
            String line = bufferedReader.readLine();
            while (line != null) {
                query.append(line);
                line = bufferedReader.readLine();
            }
        } catch (IOException e) {
            System.out.println("File query non trovato");
        }

        preparedStatement = database.getConnection().prepareStatement(String.valueOf(query));

        System.out.print("Inserire la città per la quale effettuare la ricerca: ");
        preparedStatement.setString(1, scanner.nextLine());

        resultSet = preparedStatement.executeQuery();

        System.out.println("\n-------------- Strutture trovate --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %d\t%d\t%s\t%s\t%s\t%s\n", i, resultSet.getInt("codiceStruttura"),
                    resultSet.getInt("annoDiIscrizione"),
                    resultSet.getString("nome"), resultSet.getString("citta"),
                    resultSet.getString("via"), resultSet.getString("cap"));
        }

        preparedStatement.close();
    }

    public void query16() throws SQLException {
        String query =  "SELECT Cliente, dataCheckIn, dataCheckOut, numeroOspiti, durataSoggiorno, prezzoTotale " +
                "FROM Prenotazione " +
                "WHERE CURRENT_DATE < dataCheckIn";

        Statement statement;
        ResultSet resultSet;

        statement = database.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        System.out.println("-------------- Risultato --------------");

        for (int i = 1; resultSet.next(); i++) {
            System.out.printf("(%d) %s\t%s\t%s\t%d\t%d\tCosto: %.2f\n", i, resultSet.getString("Cliente"),
                    resultSet.getDate("dataCheckIn"), resultSet.getDate("dataCheckOut"),
                    resultSet.getInt("numeroOspiti"), resultSet.getInt("durataSoggiorno"),
                    resultSet.getFloat("prezzoTotale"));
        }

        statement.close();
    }
}
