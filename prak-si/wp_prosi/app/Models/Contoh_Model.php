<?php

namespace App\Models;

use CodeIgniter\Model;

class Contoh_Model extends Model
{
    protected $table = 'contoh';

    function __construct()
    {
        $this->db = db_connect();
    }

    function tampil()
    {
        $query = $this->db->query("SELECT * FROM $this->table");
        return $query->getResult();
    }

    function simpan($data)
    {
        $this->db->table($this->table)->insert($data);
        return true;
    }

    function hapus($id)
    {
        $query = $this->db->query("DELETE FROM $this->table WHERE id=" . $id);
        return true;
    }

    function tampilById($id)
    {
        $query = $this->db->query("SELECT * FROM $this->table WHERE id=" . $id);
        return $query->getResult();
    }

    function updateEdit($data, $where)
    {
        $this->db->table($this->table)->update($data, $where);
    }

    function jumlah()
    {
        $query = $this->db->query("SELECT COUNT(*) AS jumlah FROM $this->table");
        return  $query->getResult();
    }
}
