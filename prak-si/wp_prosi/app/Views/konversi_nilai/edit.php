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
            <?php
            foreach ($dataMahasiswa as $rowDataMahasiswa)
            ?>
            <!-- Vertical Form -->
            <form class="row g-3" method="post" action="<?= base_url($controller . '/update//' . $rowDataMahasiswa->id); ?>">
                <div class="col-12">
                    <label for="id" class="form-label">ID</label>
                    <input type="text" class="form-control" id="id" name="id" value="<?= $rowDataMahasiswa->id; ?>" disabled>
                </div>
                <div class="col-12">
                    <label for="kode_alternatif" class="form-label">Kode Alternatif</label>
                    <input type="text" class="form-control" id="kode_alternatif" name="kode_alternatif" value="<?= $rowDataMahasiswa->kode_alternatif; ?>" disabled>
                </div>
                <?php
                $no = 0;
                foreach ($dataKriteria as $rowDataKriteria) {
                    $id_konversi = null;
                    $id_kriteria_konversi = null;
                    $no++;
                ?>
                    <div class="col-12">
                        <label for="kriteria[<?= $rowDataKriteria->id; ?>]" class="form-label">C<sub><?= $no; ?></sub> <?= $rowDataKriteria->kriteria; ?></label>
                        <select name="kriteria[<?= $rowDataKriteria->id; ?>]" id="kriteria[<?= $rowDataKriteria->id; ?>]" class="form-select">
                            <?php $found = false; ?>
                            <?php foreach ($dataKonversiNilai as $rowKonversiNilai) :  ?>
                                <?php
                                if ($rowKonversiNilai->alternatif == $rowDataMahasiswa->id && $rowKonversiNilai->kriteria_subkriteria == $rowDataKriteria->id) {
                                    $id_kriteria_konversi = "konversi[" . $rowDataKriteria->id . "]";
                                    $id_konversi = $rowKonversiNilai->id;
                                    $found = true;
                                ?>
                                    <option value="<?= $rowKonversiNilai->subkriteria; ?>"><?= $rowKonversiNilai->skot_tingkat_bobot_kriteria . " (" . $rowKonversiNilai->subkriteria_subkriteria . ")"; ?></option>
                                <?php } ?>
                            <?php endforeach; ?>
                            <?php if (!$found) { ?>
                                <option value="0">Pilih..</option>
                            <?php }; ?>
                            <?php foreach ($dataSubkriteria as $rowSubkriteria) : ?>
                                <?php if ($rowSubkriteria->kriteria == $rowDataKriteria->id) : ?>
                                    <option value="<?= $rowSubkriteria->id; ?>"><?= $rowSubkriteria->skor . " (" . $rowSubkriteria->subkriteria . ")"; ?></option>
                                <?php endif; ?>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <input type="hidden" name="<?= $id_kriteria_konversi; ?>" value="<?= $id_konversi; ?>">
                <?php }; ?>
                <div class="d-flex justify-content-between pt-3">
                    <a href="<?= base_url($controller); ?>" class="btn btn-secondary">Kembali</a>
                    <button type="submit" class="btn btn-success">Update</button>
                </div>
            </form><!-- Vertical Form -->

        </div>
    </div>
</div>