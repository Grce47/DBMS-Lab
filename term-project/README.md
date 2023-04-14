# Metric Reporting

## Contributors

- Grace Sharma
- Umang Singla
- Vineet Amol Pippal
- Mradul Agrawal
- Subhajyoti Halder

## Instruction

- **Create virtual environment**

```bash
sudo pip install virtualenv      # This may already be installed
virtualenv .env                  # Create a virtual environment
```

- **Install Dependencies from** requirements.txt **file**

```bash
pip install -r requirements.txt   # All neccessary library will be downloaded
```

- **Reset pg_stat_statements**

```bash
SELECT pg_stat_statements_reset();
```

- **Task**

1. Execution time: The total time taken to execute the query, including time spent waiting on locks or I/O.
2. CPU time: The amount of CPU time used to execute the query.
3. Memory usage: The amount of memory used by the query, including shared buffers and work memory.
4. Rows returned: The number of rows returned by the query.
5. Block I/O time: The amount of time spent performing block I/O operations (reading from or writing to
   disk) during the execution of the query.
6. Disk usage: The amount of disk space used by the query, including temporary files created during
   execution.
7. Lock time: The amount of time the query spent waiting on locks.
8. Parse and plan time: The amount of time spent parsing and planning the query, including optimization
   and generating the execution plan.
9. Number of executions: The number of times the query has been executed.
   10.Calls and rows per call: The average number of calls and rows returned per call for the query.
   11.Statement text: The text of the SQL statement being executed.
