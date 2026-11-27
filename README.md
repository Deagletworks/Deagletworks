
<img width="1200" height="653" alt="716933339-b976fe0f-8fd5-42eb-9bce-640d5d6b018a" src="https://github.com/user-attachments/assets/0168faed-f69a-4acd-9f5d-8d57f4e69c16" />


## 有料サービスについてのご紹介 🔮
　当社はCrystal-ARKが研究開発した「量子セキュリテイーAIプロセッサ」の研究開発事業の促進支援をしております。
その普及推進における一般顧客向けサービス事業のご紹介記事です。

(現在特許出願中、AMD-Vivado・FPGA-IP　最適推奨`xc7a35tcpg236-1 (Artix-7)`サービスのみ受付）

この「量子セキュリテイーAIプロセッサ」は既存の家電やIT製品のサブプロセッサとして簡単に追加接続して使えます。
しかも、これによりランサムウエア攻撃や暗号盗聴などが完全に防衛保護できます。またAI演算も自動で実行します。
勿論従来のマイコン・CPU・GPU・TPUでのAI演算との置き換えも可能です。極めて低電力でほぼゼロに近く、特別なプログラムやOSは必要ありません。

詳しくは下記の詳細記事、Crystal-Ark-White-Material のREADME.mdをお読みください。

# QPU-ARK デザインセンター：受託IP提供サービス案内書
**（URLバインド型・物理層セキュリティ＆16元数演算デジタルIPコア）**

## 1. サービス概要
QPU-ARK デザインセンターでは、次世代物理層セキュリティ（1ナノ秒クロック遮断防衛核）および16元数（Sedenion）・アンプリチューヘドロン幾何学演算を純粋デジタル論理回路として実装した**『QPU-ARK デジタルIPコア』**を、貴社指定のFPGAまたはASICプロセス向けにカスタマイズし、**ブラックボックスIPパッケージ（暗号化ネットリスト / ハードマクロ）**としてデータ納品いたします。（但し、ここで製作提供致しますQPU-ARKコアデバイスは通常のデジタル製品です。完全な量子AI製品の開発製造には、別途製造契約NDAと当社が仲介する製造企業との製造量産契約が必要となります。）

### 提供IPコアの特長
* **特殊プロセス不要の純粋デジタル論理（CMOS / FPGA完全互換）**: 外部HBMメモリや特殊デバイスを必要とせず、既存の標準FPGA評価ボードやCMOS ASICへそのまま統合可能です。
* **1ナノ秒（1クロック）物理層防衛核**: ソフトウェアの監視やOS起動を待たず、不正パルスやハザード検知時に1クロック未満でマスタークロックを物理遮断（フリーズ）します。
* **URLバインド＆パスワードレス認証（`qpu_url_bound_guard` 標準搭載）**: 貴社サービスのエンドポイントURLおよび契約コードをハードウェア内部へ直接バインドすることで、ID・パスワード不要の物理層ゼロトラスト認証（4W証明トークン出力）を実現します。
* **低遅延ホストバス統合**: AXI4-Lite / PCIe ブリッジ経由で、既存CPUを軽量I/Oコントローラとして活かしながら重い演算とセキュリティをオフロードします。

---

## 2. 納品パッケージ構成（ソースコード非開示・ブラックボックス形式）
知財保護およびセキュリティ担保のため、RTLソースコード自体は非開示とし、貴社の設計ツール（Vivado / Quartus / Design Compiler等）へそのまま組み込める以下のパッケージ一式をオンライン納品いたします。

1. **暗号化ネットリスト（IEEE 1735準拠 `.dcp` / `.edf`）** または **ASIC用ハードマクロ（`.gds` / `.lef` / `.lib`）**
2. **ブラックボックス・ポート定義ファイル（スタブVerilog `.v`）**
3. **タイミング制約テンプレート（`.sdc` / `.xdc`）および MMIOレジスタ仕様書**


### 今後の対応予定EDA環境・ターゲットデバイス一覧（Support-Planning  EDA Tools & Targets）

当デザインセンターでは、業界標準のEDAフローに完全準拠したブラックボックスIPパッケージを生成・納品いたします。貴社の既存設計環境を変更することなく、そのまま統合いただけます。

| ターゲット区分 | 対応EDAツール / プロセス | 納品データ形式（ソースコード非開示） | 主な対象デバイス・用途 |
| :--- | :--- | :--- | :--- |
| **FPGA 標準フロー**<br>（最速評価・量産向け） | **AMD Vivado Design Suite**<br>（Standard / Enterprise 互換） | 暗号化チェックポイント（`.dcp`）<br>＋ ブラックボックススタブ（`.v`）＋ `.xdc` | 最適Artix-7 / 他Zynq UltraScale+ / Kintex / Alveo PCIeアクセラレータカード等 |
| **FPGA マルチベンダー**<br>（個別案件対応） | **Altera Quartus Prime**<br>**Lattice Radiant / Diamond** | IEEE 1735 暗号化ネットリスト（`.edf` / `.qxp`）<br>＋ 制約テンプレート（`.sdc`） | Agilex / Stratix / 超低電力エッジFPGA（CrossLink-NX等） |
| **ASIC ハードマクロ**<br>（カスタムSoC量産向け） | **OpenLane / 標準CMOSフロー**<br>（28nm / 16nm / 7nm 等） | 配置配線済みハードマクロ（`.gds` / `.lef`）<br>＋ タイミングライブラリ（`.lib`） | 専用AIセキュリティチップ、車載ECU、スマートデバイス向けSoC |

---

## 3. ご契約〜評価・量産までの4ステップ（完全オンライン・データ納品フロー）

実機ボードの貸し出し手続きや輸送コストは一切不要です。貴社がお持ちのFPGA評価環境にて最短数日で実機ベンチマークを開始いただけます。

| ステップ | 実施内容 | 貴社にご用意いただく情報 |
| :--- | :--- | :--- |
| **Step 1：NDA締結・要件ヒアリング** | 秘密保持契約（NDA）を締結し、ターゲット環境とインターフェース要件を確認いたします。 | ① ターゲットFPGA型番（またはASICプロセス）<br>② 目標動作クロック・バス仕様（AXI4等） |
| **Step 2：試作・評価用IPの生成と納品** | 貴社専用にパラメータ焼き込みを行った**「評価用暗号化ネットリスト（試作・デバッグコードバインド版）」**をデータ納品いたします。 | ① 接続先エンドポイントURL<br>② 評価用FPGAボードのデバイスDNA（64bit）<br>※評価版には動作確認用のショット回数上限が設定されます。 |
| **Step 3：貴社環境での実機評価** | 貴社保有のFPGAボードへ焼き付けていただき、実機での演算性能・消費電力・1ns遮断動作をご評価いただきます（オンラインQ&Aサポート付）。 | 貴社ラボ内での実機テスト実施 |
| **Step 4：量産ライセンス契約・本番納品** | 本採用決定後、受託設計料（NRE）および量産ロイヤリティ契約を締結し、回数制限を解除した**「量産用IPパッケージ（量産コードバインド版）」**を納品いたします。 | 量産用エンドポイントURL・量産契約コード |

---
## 4. お問い合わせ・お申し込み窓口
* **本サービスでは受託および契約について、当方にて適切と判断した場合のみ、ご連絡対応いたします。
* **不適当と判断される場合には、ご回答含め一切の対応を致しませんので、予めご了解ください。
* **事業主体**: Crystal-ARK（QPU-ARK 研究開発デザインセンター事業部）
* **連絡先**: `kujiraairplane@gmail.com`
* **参考リファレンス仕様（公開ポータル）**: https://github.com/Deagletworks/Crystal-Ark-White-Material



############################################################################################

『QPU-ARK IPパッケージ生成用 技術要件・ライセンスパラメータ用のご提出シート』について

# QPU-ARK デザインセンター：IPパッケージ生成用 技術要件・ライセンスパラメータ提出シート
**（NDA締結済・試作評価版 / 量産版 共通ビルド依頼フォーム）**

本シートは、貴社専用の暗号化ネットリスト（IEEE 1735準拠 `.dcp` / `.edf`）またはASICハードマクロ（`.gds` / `.lef`）を生成するため、ハードウェア物理層へ焼き込む固有識別パラメータをご指定いただくためのフォームです。
※ご記入いただいた内容に基づきビルドしたIPは、指定されたURL（URI）・契約コード・デバイス環境でのみ動作いたします。

---

### 1. ご依頼者・契約情報（基本情報）
* **貴社名・部署名**： `[ 例：株式会社〇〇 半導体開発部 ]`
* **ご担当者名・連絡先メール**： `[ 例：山田 太郎 / taro.yamada@example.co.jp ]`
* **NDA締結日・管理番号**： `[ 例：2026年11月25日 / NDA-2026-001 ]`
* **ご希望のビルド種別**（該当する方に `[x]` をご記入ください）：
  * `[ ]` **試作・評価用ビルド**（指定デバイスDNAロック ＋ 評価用ショット回数制限付き）
  * `[ ]` **量産用ビルド**（本契約締結後・回数制限解除版）

---

### 2. ハードウェアターゲット・インターフェース仕様
* **ターゲットデバイス種別**： `[ FPGA / ASIC ]`
* **具体的な型番 または プロセスノード**：
  * （FPGAの場合の例：最適推奨`xc7a35tcpg236-1 (Artix-7)` 等）
  * （ASICの場合の例：`TSMC 28nm HPC+`、`16nm FinFET` 等）
  * **ご記入欄**： `[                                        ]`
* **ご希望のホストバスインターフェース**：
  * `[ ]` AXI4-Lite / AXI4-Stream 標準ブリッジ（32-bit / 64-bit）
  * `[ ]` PCIe Gen4 / Gen5 エンドポイント直結モード
  * `[ ]` ネイティブ・ダイレクトポート（カスタムバス直結）
* **目標動作クロック周波数**： `[ 例：500 MHz / 1.0 GHz ]`

---

### 3. URLバインド・ライセンス識別パラメータ（必須）
本IPの「Where（どこで）」および「How（どのように）」をハードウェア物理層で認証するための識別情報をご記入ください。

#### ① 接続先エンドポイントURL または 正規化URI（128-bitハッシュ生成元）
* **【パターンA：クラウド / 社内DNS環境の場合】**
  FQDN（完全修飾ドメイン名）を含む絶対URLをご記入ください。
  （ブラウザ開発者ツール `F12` の Networkタブ、または `nslookup` で確認可能です）
  * 例：`https://example.co.jp`
* **【パターンB：外部遮断・オフラインラボ環境（ローカルIP / PC直結）の場合】**
  以下のフォーマットで一意の正規化URIをご指定ください（PCのターミナルで `hostname` を実行して確認可能です）。
  * フォーマット：`qpu://<貴社ドメイン>/<デバッグPCホスト名>/<部署またはプロジェクト名>`
  * 例：`qpu://example.co.jp/WORKSTATION-EDALAB04/soc-team`

* **★ ご指定のURL / 正規化URI（完全一致文字列）**：
  `[                                                            ]`

#### ② 契約・用途区分コード（`How` パラメータ用）
* **対象プロジェクト / 製品名称**： `[ 例：次世代エッジAIアクセラレータ試作機 ]`
* **ご希望のIPバージョン**： `[ 例：Ver 2.0 (16'h0200) ]`
  ※実際の `EXPECTED_HOW_CODE（32-bit）` は、上記情報とNDA契約番号に基づき当デザインセンターにて採番・発行し、納品書に記載いたします。

---

### 4. 評価用ターゲットボード固有ID（試作・評価用ビルドの場合のみ必須）
複製および契約外デバイスへの無断転用を防止するため、評価にご使用になるFPGAボード1枚の**固有デバイスDNA（64-bit Hex）**をご記入ください。

* **64-bit デバイスDNA（16進数16桁）**： `64'h[ ____ _ ____ _ ____ _ ____ ]`
  * ※AMD (Xilinx) Vivado での確認方法：Hardware Manager でターゲットFPGAへ接続後、Tcl Console にて `get_property REGISTER.EFUSE.FUSE_DNA [current_hw_device]` を実行すると16進数文字列が表示されます。

---
## ５. ライセンスプラン・料金体系目安（Licensing & Pricing Overview）

当デザインセンターでは、初期検証のハードルを抑えた「試作・評価プラン」から、量産規模に応じた「単一URL量産プラン」「ロイヤリティフリー買切りプラン」まで、貴社の開発フェーズに合わせた3つのライセンス体系をご用意しております。

| プラン区分 | 基本契約料（イニシャル・NRE） | 量産ライセンス料金 | ライセンス範囲・技術仕様（`qpu_url_bound_guard` 制御） |
| :--- | :--- | :--- | :--- |
| **1. 試作・評価プラン**<br>（Evaluation / PoC） | **30万円〜**（税別）<br>※カスタムビルド実費のみ | **なし**<br>（商用量産不可） | ・指定された**評価用FPGAボード1枚（64-bit DNAロック）**および**1評価URL**に限定。<br>・動作確認用ショット回数上限（例：1,000万回）および評価期間（最大90日）を設定。<br>・暗号化ネットリスト（`.dcp` / `.edf`）によるオンラインデータ納品。 |
| **2. 標準・量産基本プラン**<br>（Single-URL Production） | **150万円 〜 300万円**（税別 / FPGA）<br>**300万円 〜 500万円**（税別 / ASIC） | **単価 20円 〜 100円 / 個**<br>（出荷数量に応じた段階料率） | ・契約した**単一のエンドポイントURL（または正規化URI）**および**単一製品ライン**での商用量産を許諾。<br>・回数制限を解除した本番用暗号化ネットリストまたはASICハードマクロ（`.gds` / `.lef`）を納品。<br>・新バージョン・別URL追加時のリビルド発行は別途優待価格にて対応。 |
| **3. ロイヤリティフリー買切り**<br>（Multi-URL / Buyout） | **500万円 〜 1,500万円**（税別）<br>※対象製品シリーズ規模による | **0円（ロイヤリティ免除）** | ・同一企業内の指定製品シリーズ（複数URLバインド可）における**数量無制限の量産**を許諾。<br>・出荷数量の定期報告や監査手続きが不要な一括買取型ライセンス。 |

※上記金額は標準的な構成に基づく目安です。ターゲットデバイス規模・バス仕様・カスタマイズ要件に応じて個別にお見積りいたします。
### 【特別規定】会社法上の「大会社」およびグローバル巨大企業に対する特別ライセンス条件

日本の会社法第2条第6号に定める**「大会社」（最終事業年度に係る貸借対照表に資本金として計上した額が5億円以上、または負債の部に計上した額の合計額が200億円以上である株式会社）**、ならびにこれに準ずる規模のグローバル企業・法人エンティティが本IPパッケージ（暗号化ネットリスト・ハードマクロ・設計技術）を商業利用・導入する場合は、上記の標準料金プランに加え、またはこれに代わる特別条件として、技術リファレンス（[Crystal-Ark-White-Material](https://github.com/Deagletworks/Crystal-Ark-White-Material)）に定める以下の規定が適用されます。

* **「てんさいクリエーター育成」資金の拠出義務（Condition A 準拠）**：
  * 次世代のハードウェア・ソフトウェア・科学技術を担う若手エンジニアおよび独立系クリエイターを育成するための**「てんさいギーク育成資金」**として、指定のKindle書籍（『シリウス・シュメール・サーガ』シリーズ等）**100万冊購入相当額**（または同等の育成資金拠出）を、Deagletworks（`kujiraairplane@gmail.com`）へ入金・拠出(実際にkindleを介してご購入並びに、社員への配布）を行う義務を負うものとします。
  * 本特別条件に基づく契約および資金拠出の確認をもって、大会社向けの専用ライセンスコード（`EXPECTED_HOW_CODE`）および量産用ハードマクロパッケージを発行いたします。

### 【学術・若手支援規定】学生・一般ユーザー・公的研究機関向けの無償・優遇利用条件

資金力のない個人ユーザー、高専生・大学生・大学院生、および非営利の若手研究者に対しては、次世代の「てんさいギーク育成」の理念に基づき、**基本契約料およびライセンス料を無償（0円）または特別優遇条件**にて試作・研究用IPパッケージ（暗号化ネットリスト）を提供いたします。

* **適用条件（公的証明・委任状の提出義務）**：
  * 本優遇規定の適用を希望される場合は、**所属する大学（指導教員・学部長等）、高等専門学校、または公的機関・自治体等からの「委任状」「研究推薦状」または「所属証明書」**の提出を必須条件といたします。
  * 用途は**「非営利の学術研究・教育・プロトタイプ実証実験」**に限定され、商用製品への組み込みや第三者への再配布は不可となります（市販・事業化へ移行する際は、別途標準プランまたはスタートアップ向け特別プランへ移行いただきます）。
  * 提出書類および評価ボードのデバイスDNA・識別URIをご送付いただければ、学術研究用の専用ライセンスコード（`EXPECTED_HOW_CODE`）を発行いたします。


### ６. ご返送先・お問い合わせ
ご記入後、下記窓口までメールにてご返送ください。受領後、通常10〜20営業日程度にて、暗号化IPパッケージ（`.dcp` / `.edf` ＋ ブラックボックススタブファイル）を、確認のご連絡後当社基準にて適切と判断できる場合のみ、セキュアリンクにて納品いたします。
但し原則として、
* **本サービスでは受託および契約について、当方にて適切と判断した場合のみ、ご連絡対応いたします。
* **不適当と判断される場合には、ご回答含め一切の対応を致しませんので、予めご了解ください。

* **事業主体**: Crystal-ARK（QPU-ARK 研究開発デザインセンター事業部）
* **連絡先**: `kujiraairplane@gmail.com`


【ご参考】顧客送付用：『御見積書 兼 IPライセンス条件提示書（完成版雛形）』概要__- 御見積金額・プラン....pdf
<!--
**Deagletworks/Deagletworks** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.

Here are some ideas to get you started:

- 🔭 I’m currently working on ...
- 🌱 I’m currently learning ...
- 👯 I’m looking to collaborate on ...
- 🤔 I’m looking for help with ...
- 💬 Ask me about ...
- 📫 How to reach me: ...
- 😄 Pronouns: ...
- ⚡ Fun fact: ...
-->

# Deagletworks QPU-ARK Encrypted IP Package - Integration Guide

本パッケージには、お客様のターゲットデバイスおよびエンドポイント環境にバインドされた暗号化済みRTL IPコア（Design Checkpoint: `.dcp`）が含まれています。

---

## 1. 同梱ファイル一覧

* `<Package_ID>_locked.dcp` : 暗号化・合成済みIPコア本体（IEEE 1735準拠）
* `<Package_ID>_blackbox_stub.v` : トップ階層インスタンス化・ピン配置確認用ブラックボックススタブ
* `LICENSE_RECEIPT.txt` : 契約条件・バインド情報（Device DNA / Endpoint URL Hash / How Code）証明書
* `README.md` : 本ドキュメント

---

## 2. 動作・ビルド必須要件（重要）

統合ビルド時の「Valid license not found」や復号エラーを防ぐため、以下の環境要件を必ず満たしてください。

1. **Vivado バージョン要件**
   * **AMD Vivado 2026.1 以降** を使用してください。（2026.0以前の旧バージョンでは暗号化スキームの互換性により復号エラーが発生します）
2. **ターゲットデバイスおよびライセンス要件**
   * 本IPは `LICENSE_RECEIPT.txt` に記載された `Target FPGA Part` 向けにビルドされています。
   * お客様の Vivado 環境において、当該ターゲットデバイスをサポートする有効なライセンス（WebPACK / Standard Edition、または該当デバイスの商用・評価版ライセンス）が認識されている必要があります。
   * 環境変数 `XILINX_LICENSE_FILE` に有効な `.lic` ファイルのパス（またはライセンスサーバーの `port@host`）が設定されていることを事前にご確認ください。

---

## 3. SoCトップ階層への統合手順

### Step 1: モジュールのインスタンス化
同梱の `*_blackbox_stub.v` を参照し、お客様のトップデザイン（またはブロックデザイン）に `qpu_system_amplituhedron_integrated_top` をインスタンス化してください。

> **注意:** `*_blackbox_stub.v` はポート定義確認用です。実際の合成・配置配線（Implementation）時には、このスタブファイルではなく **`*_locked.dcp`** のみをプロジェクトに読み込ませてください（両方読み込むとモジュール重複エラーになります）。

### Step 2: 拘束パラメータ・認証信号の接続
本IPはハードウェアレベルでの不正利用防止機構（URL / Device DNA / How Code ガード）を内蔵しています。評価版（EVAL）ビルドの場合は、必ず `LICENSE_RECEIPT.txt` に記載されたターゲットFPGAの実機（一致する Device DNA）上で動作させてください。

### Step 3: Vivado でのインテグレーション実行（Tcl例）
```tcl
# 1. 顧客側トップRTLおよび制約ファイルの読み込み
read_verilog ./src/your_soc_top.v
read_xdc     ./constraints/your_constraints.xdc

# 2. 暗号化DCPの読み込み（スタブ.vは読み込まないこと）
read_checkpoint ./ip/QPU_ARK_ClientA_Alpha_EVAL_xxxxxxxx_locked.dcp

# 3. 合成および配置配線
synth_design -top your_soc_top -part <Target_FPGA_Part>
opt_design
place_design
route_design

## 4. トラブルシューティング
●ERROR: Vivado Design Suite cannot be launched because a valid license was not found.
○Vivadoのライセンスマネージャー（XLCM）または環境変数 XILINX_LICENSE_FILE のパス設定を確認してください。また、WebPACK対象外の大型FPGA（Zynq UltraScale+ MPSoCの一部等）を使用している場合は、対象のライセンスシートが有効かご確認ください。
●ERROR: [Vivado 12-13638] Failed to decrypt... / 復号エラー
○Vivado のバージョンが 2026.1 未満である可能性があります。ツールバージョンをアップグレードして再試行してください。
●実機動作時に guard_locked_status が解除されない（出力が固定される）
○LICENSE_RECEIPT.txt に記載された Target Device DNA、Bound Endpoint URL（SHA-256上位128bitハッシュ）、および Contract How Code のレジスタ設定値が完全に一致しているかご確認ください。


## 🔌 Artix-7（`xc7a35tcpg236-1`）1チップ統合・汎用I/Oラッパー実装事例
**（顧客側でのSPI/GPIO直結およびピン制約テンプレート `.xdc` リファレンス）**

当デザインセンターから納品される暗号化IPコア（`qpu_system_amplituhedron_integrated_top_locked.dcp`）は、普及型FPGA **AMD Artix-7（`xc7a35tcpg236-1`：Basys 3 / Cmod A7 等の標準パッケージ）** の論理リソースのわずか数％で動作します。

そのため、空いているLUT・I/Oリソースにお客様側のシステムに合わせた **汎用I/Oラッパー（SPIスレーブ / 並列GPIO / UART等）** を外付けするだけで、外部メモリや追加マイコン不要の**「完全1チップ・セキュリティ＆AIコプロセッサ（およびeSIM代行モジュール）」**として即座に製品へ組み込むことが可能です。

以下に、顧客側トップ階層でのラッパー接続例（Verilog）およびピン制約テンプレート（`.xdc`）のリファレンスを公開いたします。

---

### 1. 顧客側トップ階層・汎用I/Oラッパー実装例（`customer_artix7_1chip_top.v`）

本リファレンスは、ホストマイコンやスマホSoCから標準的な **4線式SPI（`SCLK`, `CS_N`, `MOSI`, `MISO`）** および **制御GPIO** で `QPU-ARK` 暗号化コアをダイレクト駆動し、結果を返す1チップ統合例です。

```verilog
`timescale 1ns / 1ps

module customer_artix7_1chip_top (
    input  wire        board_clk_100mhz,
    input  wire        ext_rst_n,
    input  wire        spi_sclk,
    input  wire        spi_cs_n,
    input  wire        spi_mosi,
    output wire        spi_miso,
    output wire        status_led_done,
    output wire        status_led_hazard
);

    reg  [23:0] spi_rx_shift;
    reg  [23:0] spi_tx_shift;
    reg  [4:0]  spi_bit_cnt;
    reg         shot_trigger_pulse;

    wire [7:0]  w_simplex_vol;
    wire [15:0] w_twist_amp;
    wire        w_shot_complete;
    wire        w_detok_valid;

    always @(posedge spi_sclk or posedge spi_cs_n) begin
        if (spi_cs_n) begin
            spi_bit_cnt        <= 5'd0;
            shot_trigger_pulse <= 1'b0;
        end else begin
            spi_rx_shift <= {spi_rx_shift[22:0], spi_mosi};
            if (spi_bit_cnt == 5'd23) begin
                spi_bit_cnt        <= 5'd0;
                shot_trigger_pulse <= 1'b1;
            end else begin
                spi_bit_cnt        <= spi_bit_cnt + 1'b1;
                shot_trigger_pulse <= 1'b0;
            end
        end
    end

    always @(negedge spi_sclk or posedge spi_cs_n) begin
        if (spi_cs_n) begin
            spi_tx_shift <= {w_simplex_vol, w_twist_amp};
        end else begin
            spi_tx_shift <= {spi_tx_shift[22:0], 1'b0};
        end
    end

    assign spi_miso = spi_tx_shift[23];

    qpu_system_amplituhedron_integrated_top u_qpu_ark_core (
        .clk                 (board_clk_100mhz),
        .rst_n               (ext_rst_n),
        .start_shot          (shot_trigger_pulse),
        .agora_hazard_pulse  (1'b0),
        .flash_atc_wave_m    (spi_rx_shift[3:0]),
        .flash_atc_wave_ui   (spi_rx_shift[7:4]),
        .flash_atc_wave_ej   (spi_rx_shift[11:8]),
        .flash_atc_wave_ek   (spi_rx_shift[15:12]),
        .vcsel_x_scan_en     (),
        .matrix_x_addr       (),
        .matrix_y_addr       (),
        .amplituhedron_vol   (w_simplex_vol),
        .twist_string_amp    (w_twist_amp),
        .active_sedenion_out (),
        .qpu_shot_complete   (w_shot_complete),
        .ca_detok_ack        (1'b1),
        .ca_detok_req        (),
        .ca_simplex_vol_tok  (),
        .ca_twist_amp_tok    (),
        .ca_detok_valid      (w_detok_valid)
    );

    assign status_led_done   = w_detok_valid;
    assign status_led_hazard = (spi_rx_shift[3:0] ^ spi_rx_shift[11:8]) == 4'b1111;

endmodule
```

---

### 2. Artix-7（`xc7a35tcpg236-1`）標準ピン制約テンプレート（`artix7_cpg236_reference.xdc`）

`xc7a35tcpg236-1`（CPG236パッケージ / Digilent Basys 3互換ピン配置）へそのまま焼き込む際のタイミング＆物理ピン制約テンプレートです。お客様のカスタム基板のピン番号に合わせて `PACKAGE_PIN` を書き換えるだけで即時実装できます。

```tcl
## 1. システムマスタークロック制約（100MHz標準発振器入力 -> 500MHz/1GHz内部PLL逓倍対応）
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports board_clk_100mhz]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports board_clk_100mhz]

## 2. リセット信号（アクティブ・ロー）
set_property -dict { PACKAGE_PIN U18  IOSTANDARD LVCMOS33 } [get_ports ext_rst_n]

## 3. ホストMCU / スマホSoC 接続用 4線式SPIインターフェース（Pmod JA 互換ピン）
set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports spi_sclk]
set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports spi_cs_n]
set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports spi_mosi]
set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports spi_miso]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets spi_sclk_IBUF]

## 4. 動作ステータス確認用出力ピン（演算完了 / 1ns防衛核ハザード検知）
set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports status_led_done]
set_property -dict { PACKAGE_PIN E19  IOSTANDARD LVCMOS33 } [get_ports status_led_hazard]

## 5. 1ns防衛核（動的クロックゲーティング）用タイミング例外設定
set_false_path -from [get_ports ext_rst_n]
```

---

### 3. 顧客側エンジニアのメリット（セルフインテグレーション）
* **ホスト側の負担ゼロ：** スマホのメインCPUや家電のマイコンからは、わずか24ビットのSPI通信（4本の信号線）を送るだけで、16元数位相の投入から1ナノ秒防衛核の判定、演算結果の取得まで1チップで完結します。
* **ビットストリームの即時生成：** お客様のVivadoプロジェクトに、上記2ファイルと納品された `*_locked.dcp` を追加して「Generate Bitstream」を押すだけで、実機書き込み用 `.bit` ファイルが完成します。




Copyright (c) 2026 Deagletworks. All Rights Reserved.
