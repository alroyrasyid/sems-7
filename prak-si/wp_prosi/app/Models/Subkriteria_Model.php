<?php

namespace App\Models;

use CodeIgniter\Model;

class Subkriteria_Model extends Model
{
    protected $table = 'subkriteria';

    function __construct()
    {
        $this->db = db_connect();
    }

    function tampil()
    {
        $query = $this->db->query(
            "SELECT a.id, a.kriteria, a.subkriteria, a.skor, a.keterangan, b.id AS id_kriteria, b.kriteria AS kriteria_kriteria, b.bobot AS bobot_kriteria, c.id AS id_tingkat_bobot_kriteria, c.nilai AS nilai_tingkat_bobot_kriteria
        FROM $this->table a
        JOIN kriteria b ON a.kriteria = b.id
        JOIN tingkat_bobot_kriteria c ON a.skor = c.id
        ORDER BY a.kriteria, c.nilai
        "
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
            "SELECT a.id, a.kriteria, a.subkriteria, a.skor, a.keterangan, b.id AS id_kriteria, b.kriteria AS kriteria_kriteria, b.bobot AS bobot_kriteria, c.id AS id_tingkat_bobot_kriteria, c.nilai AS nilai_tingkat_bobot_kriteria
        FROM $this->table a
        JOIN kriteria b ON a.kriteria = b.id
        JOIN tingkat_bobot_kriteria c ON a.skor = c.id
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
        return  $query->getResult();
    }
}
