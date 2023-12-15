<?php

namespace App\Models;

use CodeIgniter\Model;

class KonversiNilai_Model extends Model
{
    protected $table = 'konversi_nilai';

    function __construct()
    {
        $this->db = db_connect();
    }

    function tampil()
    {
        $query = $this->db->query(
            "SELECT a.id, a.alternatif, a.subkriteria, d.id AS id_mahasiswa, d.kode_alternatif AS alternatif_mahasiswa, b.id AS id_subkriteria, b.kriteria AS kriteria_subkriteria, b.subkriteria AS subkriteria_subkriteria, b.skor AS skor_subkriteria, c.nilai AS skot_tingkat_bobot_kriteria
        FROM $this->table a
        JOIN mahasiswa d ON a.alternatif = d.id
        JOIN subkriteria b ON a.subkriteria = b.id
        JOIN tingkat_bobot_kriteria c ON b.skor = c.id
        ORDER BY alternatif_mahasiswa
        "
        );
        return $query->getResult();
    }

    function simpan($data)
    {
        $this->db->table($this->table)->insert($data);
        return $this->db->affectedRows() > 0;
    }

    function updateEdit($data, $where)
    {
        $this->db->table($this->table)->update($data, $where);
        return $this->db->affectedRows() > 0;
    }

    function jumlah()
    {
        $query = $this->db->query("SELECT COUNT(*) AS jumlah FROM $this->table");
        return  $query->getRowArray();
    }
}
