# Dashboard Dealer Lima 3

Proyecto limpio para Vercel + Supabase. La web pública muestra el último reporte publicado y `/admin` permite que un usuario autenticado cargue los Excel diarios.

## Instalación

1. Crea un proyecto Supabase y ejecuta `supabase.sql` en **SQL Editor**.
2. Crea cada usuario administrador en **Authentication > Users** con el correo técnico `USUARIO@bitel-lima3.invalid`, marca **Auto Confirm User** y asigna una contraseña. En la web solo escribirán `USUARIO` y su contraseña.
3. Edita `supabase-config.js` y coloca el Project URL y la clave **anon public**. Nunca uses `service_role`.
4. Crea un repositorio GitHub con esta carpeta y publícalo en Vercel.

## Operación diaria

1. Abre `/admin` e inicia sesión.
2. Sube los archivos `.xlsx` o `.xls` de QLIK, POST N, Register y Referidos.
3. Revisa la vista previa y pulsa **Guardar y publicar**.

Los Excel originales se guardan en el bucket privado `reportes-excel`. El navegador solo publica el resultado consolidado y la web pública siempre consulta la última versión.

Después de crear cada usuario, copia su UUID de Authentication y autorízalo:

```sql
insert into public.dashboard_admins (user_id) values ('UUID_DEL_USUARIO');
```
