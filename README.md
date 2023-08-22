# README

## Database Backup

```bash
# backup
pg_dump cms_development > cms_development.sql
# restore
psql -d cms_development -f cms_development.sql
```