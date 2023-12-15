<?php

namespace App\Libraries;

class Flasher
{
    public static function success($message)
    {
        session()->setFlashdata('header_success', $message);
    }

    public static function error($message)
    {
        session()->setFlashdata('header_error', $message);
    }
}
