ddd=`date -u +%j`
python -c "print('{}-{}:{:0.0f}'.format(int(($ddd - 1) / 61 + 1), ($ddd - 1) % 61 + 1, (`date -u +%-H` * 3600 + `date -u +%-M` * 60 + `date -u +%-S`) / 72))"
