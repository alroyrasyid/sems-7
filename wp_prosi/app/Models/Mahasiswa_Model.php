<?php

namespace App\Models;

use CodeIgniter\Model;

class Mahasiswa_Model extends Model
{
    protected $table = 'mahasiswa';

    function __construct()
    {
        $this->db = db_connect();
    }

    function tampil()
    {
        $query = $this->db->query("SELECT * FROM $this->table ORDER BY kode_alternatif");
        return $query->getResult();
    }

    function simpan($data)
    {
        $this->db->table($this->table)->insert($data);
        return $this->db->affectedRows() > 0;
    }

    function tampilById($id)
    {
        $query = $this->db->query("SELECT * FROM $this->table WHERE id=" . $id);
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
