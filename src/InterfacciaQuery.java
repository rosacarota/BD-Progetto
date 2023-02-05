import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.util.Scanner;

public class InterfacciaQuery {
    private Database database;
    private Query query;
    private final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws SQLException, ClassNotFoundException, FileNotFoundException {
        InterfacciaQuery interfacciaQuery = new InterfacciaQuery();

        interfacciaQuery.connessione();
        interfacciaQuery.dashboard();
        interfacciaQuery.database.close();

        System.out.println("-------------- Connessione terminata --------------");
    }

    private void connessione() throws SQLException, ClassNotFoundException {
        System.out.println("-------------- Connessione al database --------------");

        System.out.print("Inserire il nome del database: ");
        String databaseName = scanner.nextLine();
        System.out.print("Inserire nome utente: ");
        String username = scanner.nextLine();
        System.out.print("Inserire password: ");
        String password = scanner.nextLine();

        database = new Database(databaseName, username, password);
        query = new Query(database);

        database.connect();
    }

    private void dashboard() throws SQLException, FileNotFoundException {
        int sel;

        while (true) {
            System.out.println("\n-------------- Interfaccia query --------------");
            System.out.println("""
                    1. Esegui query 1 (Registrazione cliente)
                    2. Esegui query 2 (Registrazione struttura ricettiva)
                    3. Esegui query 3 (Prenotazione di una struttura ricettiva)
                    4. Esegui query 4 (Aggiornamento a tessera premium)
                    5. Esegui query 5 (Visualizzazione strutture ricettive per città)
                    6. Esegui query 6 (Visualizzazione strutture ricettive disponibili per il periodo indicato)
                    7. Esegui query 7 (Visualizzazione strutture ricettive disponibili per il periodo indicato con prezzo minore di €50)
                    8. Esegui query 8 (Visualizzazione del numero di prenotazioni effettuate da tutti i clienti nell'ultimo mese)
                    9. Esegui query 9 (Visualizzazione dei migliori 10 clienti premium che abbiano effettuato il maggior numero di prenotazioni
                                         nelle diverse strutture ricettive)
                    10. Esegui query 10 (Visualizzazione degli ostelli per i quali non è stata mai registrata una prenotazione di più di 7 giorni)
                    11. Esegui query 11 (Visualizzazione delle strutture ricettive che hanno una distanza di 10km specifica da un punto di interesse)
                    12. Esegui query 12 (Visualizzazione della somma degli incassi ottenuti dalle strutture ricettive registrate
                                         sulla piattaforma)
                    13. Esegui query 13 (Stampa dei dati dei clienti che hanno prenotato solo appartamenti e ostelli)
                    14. Esegui query 14 (Stampa di un report che mostri i dati delle agenzie di viaggio compreso il numero
                                         totale di prenotazioni effettuate)
                    15. Esegui query 15 (Stampa di un report che mostri i dati delle strutture ricettive per una specifica città e
                                         che hanno ricevuto meno di 3 prenotazioni)
                    16. Esegui query 16 (Stampa di un report che mostri i dati delle prenotazioni che ancora non sono state
                                         effettuate ed il costo di ognuna di esse)
                    0. Esci
                    """);

            System.out.print("Selezione: ");
            sel = scanner.nextInt();

            System.out.println();

            switch (sel) {
                case 1 -> query.query1();
                case 2 -> query.query2();
                case 3 -> query.query3();
                case 4 -> query.query4();
                case 5 -> query.query5();
                case 6 -> query.query6_7(false);
                case 7 -> query.query6_7(true);
                case 8 -> query.query8();
                case 9 -> query.query9();
                case 10 -> query.query10();
                case 11 -> query.query11();
                case 12 -> query.query12();
                case 13 -> query.query13();
                case 14 -> query.query14();
                case 15 -> query.query15();
                case 16 -> query.query16();
                case 0 -> {
                    return;
                }
                default -> System.out.println("Nessuna query è associata al numero " + sel);
            }
        }
    }
}