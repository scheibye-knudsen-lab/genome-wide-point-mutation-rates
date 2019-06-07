bcftools mpileup -Ou -f ../scripts/mm10.fa ~/mount/Alignment/Plus_Lmna/Plus_Lmna.bam -I -q 30 -Q 30 | bcftools filter -i 'DP>39' -Ou | bcftools call -m -Ou -A | bcftools filter -i 'GT="0/0"' -Ob -o Plus_Lmna.bcf.gz &
bcftools mpileup -Ou -f ../scripts/mm10.fa ~/mount/Alignment/Plus_Lmna_H2O2/Plus_Lmna_H2O2.bam -I -q 30 -Q 30 | bcftools filter -i 'DP>39' -Ou | bcftools call -m -Ou -A | bcftools filter -i 'GT!="./."' -Ob -o Plus_Lmna_H2O2.bcf.gz &
bcftools mpileup -Ou -f ../scripts/mm10.fa ~/mount/Alignment/Minus_Lmna/Minus_Lmna.bam -I -q 30 -Q 30 | bcftools filter -i 'DP>39' -Ou | bcftools call -m -Ou -A | bcftools filter -i 'GT="0/0"' -Ob -o Minus_Lmna.bcf.gz &
bcftools mpileup -Ou -f ../scripts/mm10.fa ~/mount/Alignment/Minus_Lmna_H2O2/Minus_Lmna_H2O2.bam -I -q 30 -Q 30 | bcftools filter -i 'DP>39' -Ou | bcftools call -m -Ou -A | bcftools filter -i 'GT!="./."' -Ob -o Minus_Lmna_H2O2.bcf.gz &

bcftools stats Plus_Lmna.bcf.gz > Plus_Lmna.stats &
bcftools stats Plus_Lmna_H2O2.bcf.gz > Plus_Lmna_H2O2.stats &
bcftools stats Minus_Lmna.bcf.gz > Minus_Lmna.stats &
bcftools stats Minus_Lmna_H2O2.bcf.gz > Minus_Lmna_H2O2.stats &

bcftools index Plus_Lmna.bcf.gz &
bcftools index Plus_Lmna_H2O2.bcf.gz &
bcftools index Minus_Lmna.bcf.gz &
bcftools index Minus_Lmna_H2O2.bcf.gz &

bcftools isec -p Plus_Lmna_Plus_Lmna_H2O2.isec Plus_Lmna.bcf.gz Plus_Lmna_H2O2.bcf.gz -Ob &
bcftools isec -p Minus_Lmna_Minus_Lmna_H2O2.isec Minus_Lmna.bcf.gz Minus_Lmna_H2O2.bcf.gz -Ob &

bcftools stats Plus_Lmna_Plus_Lmna_H2O2.isec/0002.bcf > Plus_Lmna_Plus_Lmna_H2O2.isec/Plus_Lmna.stats &
bcftools stats Plus_Lmna_Plus_Lmna_H2O2.isec/0003.bcf > Plus_Lmna_Plus_Lmna_H2O2.isec/Plus_Lmna_H2O2.stats &
bcftools stats Minus_Lmna_Minus_Lmna_H2O2.isec/0002.bcf > Minus_Lmna_Minus_Lmna_H2O2.isec/Minus_Lmna.stats &
bcftools stats Minus_Lmna_Minus_Lmna_H2O2.isec/0003.bcf > Minus_Lmna_Minus_Lmna_H2O2.isec/Minus_Lmna_H2O2.stats &

bcftools view Plus_Lmna_Plus_Lmna_H2O2.isec/0003.bcf | cut -f1,2 > Plus_Lmna_Plus_Lmna_H2O2.pos &
bcftools view Minus_Lmna_Minus_Lmna_H2O2.isec/0003.bcf | cut -f1,2 > Minus_Lmna_Minus_Lmna_H2O2.pos &

cat Plus_Lmna_Plus_Lmna_H2O2.pos | awk 'BEGIN {srand()} !/^$/ { if (rand() <= .01) print $0}' > Plus_Lmna_Plus_Lmna_H2O2_001.pos &
cat Minus_Lmna_Minus_Lmna_H2O2.pos | awk 'BEGIN {srand()} !/^$/ { if (rand() <= .01) print $0}' > Minus_Lmna_Minus_Lmna_H2O2_001.pos &

samtools mpileup -f ../scripts/mm10.fa ~/mount/Alignment/Plus_Lmna/Plus_Lmna.bam -l Plus_Lmna_Plus_Lmna_H2O2_001.pos -s > Plus_Lmna.mpileup &
samtools mpileup -f ../scripts/mm10.fa ~/mount/Alignment/Plus_Lmna_H2O2/Plus_Lmna_H2O2.bam -l Plus_Lmna_Plus_Lmna_H2O2_001.pos -s > Plus_Lmna_H2O2.mpileup &
samtools mpileup -f ../scripts/mm10.fa ~/mount/Alignment/Minus_Lmna/Minus_Lmna.bam -l Minus_Lmna_Minus_Lmna_H2O2_001.pos -s > Minus_Lmna.mpileup &
samtools mpileup -f ../scripts/mm10.fa ~/mount/Alignment/Minus_Lmna_H2O2/Minus_Lmna_H2O2.bam -l Minus_Lmna_Minus_Lmna_H2O2_001.pos -s > Minus_Lmna_H2O2.mpileup &

python3 clean_mpileup.py Plus_Lmna.mpileup &
python3 clean_mpileup.py Plus_Lmna_H2O2.mpileup &
python3 clean_mpileup.py Minus_Lmna.mpileup &
python3 clean_mpileup.py Minus_Lmna_H2O2.mpileup &

python3 calculate_allele_frequencies.py Plus_Lmna.mpileup.clean &
python3 calculate_allele_frequencies.py Plus_Lmna_H2O2.mpileup.clean &
python3 calculate_allele_frequencies.py Minus_Lmna.mpileup.clean &
python3 calculate_allele_frequencies.py Minus_Lmna_H2O2.mpileup.clean &

cut -f1,2,3,9,10,11,12 Plus_Lmna.010.mpileup.clean.freqs > Plus_Lmna.010.mpileup.clean.freqs.cut &
cut -f1,2,3,9,10,11,12 Plus_Lmna_H2O2.010.mpileup.clean.freqs > Plus_Lmna_H2O2.010.mpileup.clean.freqs.cut &
cut -f1,2,3,9,10,11,12 Minus_Lmna.010.mpileup.clean.freqs > Minus_Lmna.010.mpileup.clean.freqs.cut &
cut -f1,2,3,9,10,11,12 Minus_Lmna_H2O2.010.mpileup.clean.freqs > Minus_Lmna_H2O2.010.mpileup.clean.freqs.cut &
