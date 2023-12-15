<?php

namespace App\Models;

use CodeIgniter\Model;

class Kriteria_Model extends Model
{
    protected $table = 'kriteria';

    function __construct()
    {
        $this->db = db_connect();
    }

    function tampil()
    {
        $query = $this->db->query(
            "SELECT a.id, a.timestamp, a.kriteria, a.bobot, a.keterangan, b.nilai AS nilai_bobot 
        FROM $this->table a
        JOIN tingkat_bobot_kriteria b
        ON a.bobot = b.id
        ORDER BY timestamp"
        );
        return $query->getResult();
    }

    function simpan($data)
    {
        $this->db->table($this->table)->insert($data);
        return $this->db->affectedRows() > 0;
    }

    function tampilById($id)
    {
        $query = $this->db->query(
            "SELECT a.id, a.kriteria, a.bobot, b.id AS id_bobot, b.nilai AS nilai_bobot 
        FROM $this->table a
        LEFT JOIN tingkat_bobot_kriteria b
        ON a.bobot = b.id
        WHERE a.id=" . $id
        );
        return $query->getResult();
    }

    function updateEdit($data, $where)
    {
        $this->db->table($this->table)->update($data, $where);
        return $this->db->affectedRows() > 0;
    }

    function hapus($id)
    {
        $this->db->query("DELETE FROM $this->table WHERE id=" . $id);
        return $this->db->affectedRows() > 0;
    }

    function jumlah()
    {
        $query = $this->db->query("SELECT COUNT(*) AS jumlah FROM $this->table");
        return  $query->getRowArray();
    }
}
