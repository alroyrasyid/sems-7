<div class="pagetitle">
    <h1><?= $title; ?></h1>
    <nav class=" d-flex justify-content-end">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<?= base_url(); ?>">Home</a></li>
            <li class="breadcrumb-item"><a href="<?= base_url($controller); ?>"><?= $title; ?></a></li>
            <li class="breadcrumb-item active"><?= $namePage; ?></li>
        </ol>
    </nav>
</div><!-- End Page Title -->

<div class="col-lg-6 mx-auto">

    <div class="card">
        <div class="card-body">
            <h5 class="card-title"><?= $namePage . " " . $title; ?></h5>

            <!-- Vertical Form -->
            <form class="row g-3" method="post" action="<?= base_url($controller . '/simpan'); ?>">
                <div class="col-12">
                    <label for="kriteria" class="form-label">Kriteria</label>
                    <select name="kriteria" id="kriteria" class="form-select">
                        <option>Pilih..</option>
                        <?php foreach ($dataKriteria as $data) : ?>
                            <option value="<?= $data->id; ?>"><?= $data->kriteria; ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="col-12">
                    <label for="subkriteria" class="form-label">Subriteria</label>
                    <input type="text" class="form-control" id="subkriteria" name="subkriteria">
                </div>
                <div class="col-12">
                    <label for="skor" class="form-label">Skor</label>
                    <select name="skor" id="skor" class="form-select">
                        <option>Pilih..</option>
                        <?php foreach ($dataTingkatBobotKriteria as $data) : ?>
                            <option value="<?= $data->id; ?>"><?= $data->nilai; ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="col-12">
                    <label for="keterangan" class="form-label">Keterangan</label>
                    <select name="keterangan" id="keterangan" class="form-select">
                        <option>Pilih..</option>
                        <option value="Cost">Cost</option>
                        <option value="Benefit">Benefit</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between pt-3">
                    <a href="<?= base_url($controller); ?>" class="btn btn-secondary">Kembali</a>
                    <button type="submit" class="btn btn-success">Simpan</button>
                </div>
            </form><!-- Vertical Form -->

        </div>
    </div>
</div>