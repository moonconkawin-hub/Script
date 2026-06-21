name: Generate Daily Key

on:
  schedule:
    - cron: '0 0 * * *'
  workflow_dispatch:

permissions:
  contents: write

jobs:
  update-key:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Create Files If Not Exist
        run: |
          if [ ! -f Key ]; then
            touch Key
          fi

          if [ ! -f used_keys.txt ]; then
            touch used_keys.txt
          fi

      - name: Generate Unique Daily Key
        run: |
          echo "กำลังสร้างคีย์ใหม่..."

          while true
          do
            RANDOM_STR=$(head /dev/urandom | tr -dc A-Z0-9 | head -c 12)
            NEW_KEY="MOONCONHUB-${RANDOM_STR}"

            echo "ลองสุ่มคีย์: $NEW_KEY"

            if grep -qx "$NEW_KEY" used_keys.txt; then
              echo "คีย์นี้เคยใช้แล้ว สุ่มใหม่..."
            else
              echo "คีย์นี้ยังไม่เคยใช้ ใช้งานได้"
              break
            fi
          done

          echo -n "$NEW_KEY" > Key
          echo "$NEW_KEY" >> used_keys.txt

          echo "สร้างคีย์สำเร็จ"
          echo "คีย์วันนี้คือ: $NEW_KEY"

      - name: Commit And Push
        run: |
          git config --global user.name "github-actions[bot]"
          git config --global user.email "github-actions[bot]@users.noreply.github.com"

          git add Key used_keys.txt

          git commit -m "Generate new daily key" || echo "ไม่มีไฟล์เปลี่ยนแปลง"
          git push
