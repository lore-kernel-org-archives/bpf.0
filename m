Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013049.outbound.protection.outlook.com [52.101.127.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9937F8A4;
	Thu,  6 Aug 2026 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990066; cv=fail; b=MSwkbHaa38u3B4KNEri2miJibCp/QJNW7ZKz13tRxjQYb2CcsGg+hEB6sI2p9PNWPi96sZwgrgvbEkvhnZHW4q+e8cysPEfdt5+fo8FERwmQlyXgByG4R0CC7vc7nEGN+PkgYGTXzXAGX62kjsGSM5O0CKWrJs7RAdLi98nx4nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990066; c=relaxed/simple;
	bh=pDEZcHahKnVlpdOK7xzkM3xpdhSfgLb9wE0qvBlRwkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6KN02l0ZCaR/vBFwuJbARmw4w7EfvICDw/wdbLZNVjcSz8Mst+kooh6PVKv/HWTNDT6tjcojWO523ovkv5lOYdd5hEP+2kxZJnas3e97L7wAcyfZsFluAEK2XQ6KdgQaF3OEUtCJ1d47uImpzSvgA8HOaztDPKqfWBWTuImHdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cxATdiNQ; arc=fail smtp.client-ip=52.101.127.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cxATdiNQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF0NLWGhdywa3WSBq5q6JOlauTkM80EuOKL3qiQIdaG+LBM4k7u0Q9uMsRjjvJyxUhw5s17YzMUOJfgt+D7sF4013O8SX0/Cut1TX1msL0gMnKTrY1intsFJ+K5pV81kL/IYt9CIoyhuizfR+7ovslX2QQ1jvHoAPP9zEPJOb/IpU8vkWbSqrmRmsdNCsa5whGQagEtAd7uYQAF6w8gII9qtKuuJmIyZwFHyF2Bm8elps7Iy1UD/EFMGXBfnM2AmlhfFmChFk2lDBmB5tZPkYJZPML0YWvJigpCblCPNokkuTF/cQKEjy+ryz20yDyJYipb+i8sAEnOoZoi50crxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYjLuwz6vC1tbdrIZZcLM71L0K6mM4dK8twibsbMcEY=;
 b=P/9g6Ar8d5XGJ4Hx8/fvueJHcbb9Vg4PpWrNTSb0PR4ICLlJ+ml/cRjWUXvYSjCbJtva8s0L6xPodeE8daoiEEvEnPKgub7Na7BKc+N2sH+8ACrOYjUSD6eyKOTdQNyATrE7HX6rj/jOcYh1ZjkP1jKOQqxTd0ex+1XOq2d+dWrQanno3T62ovtd1cvmntVf6reSjePOf8EyERVnUT4lzaEkiytBoOazsfkfmNzPl9hkL5GU1y4Cg5UvlTglJpRx0SJ8A6y0jREIRcR8eXAd9N8sUplQroaSQUOnPDXxUQN+f7nkPpAnFxCLidGELaflPWcl50iZcLQxxfICrcONBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYjLuwz6vC1tbdrIZZcLM71L0K6mM4dK8twibsbMcEY=;
 b=cxATdiNQjbDxqWwhAuO8ULcwIeNqv3MtbaYvUQRIav5s/iRCCbckYTwCFLM945rYL5mp+5ijyiJ4tGPGFC6Y+JhLG0+gF4HcUtmTji1FTXNkNX+WRXdZxUyyDjnuHjNAQJElCIqzcEvcANemFN2LyxFDiIQ/kY7XYQXZwAHfxvau/K8kBCUhFNk1VQ+RFQDGXpNl543oKdll80IW0uCNJHFwcsPI0/GV6aKMbnuacMou7jMW/UqO+0YoEbGFnEClCTPmaFRlyh1IDJDCLALfoKou9Xxk6YdEhfp4SBGAQOuNgCHViEePFd0HZJf8iCfzg6wW+vp3UvdkXRkWlNCwVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY1PPFF38CE2865.apcprd06.prod.outlook.com (2603:1096:408::930) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 04:20:59 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 04:20:59 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: Fuyu Zhao <zhaofuyu@vivo.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH bpf-next 1/2] libbpf: support selective kernel module BTF loading via .kmod_btfs section
Date: Thu,  6 Aug 2026 12:20:26 +0800
Message-ID: <20260806042042.3239428-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806042042.3239428-1-zhaofuyu@vivo.com>
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TY1PPFF38CE2865:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ad812a-e391-40b9-825a-08def3721e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|38350700014|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aC9YijhHuwHfClC3fi2bCBqwpBD4YDRtHjgP8H8urXdK0Nc1ZQ8kHaCqjmvnrDyg0tUzfutWy7j1HCZlC8IRg7hzoqwfnCq/AuruQ72lWOa09dGvshUdIOfRqRn7AhbKWMXfOolX5zqXAsRirPQx1ZCp10pAaX0aUdal+0znd1uEbSuwA+jwiDdmf6GOh1ECA4DX0RuV2y4PV7lf0+u4G5lxiMagWIN1ikXMUO4drPyJyabjqv/CWvc6ffaE6HCXnkCeDBBBseUMbkV+UXNSJxA4nZlS8JZE53vS6Gr46QMc0/O5P+VV4HaZXhHFowzZbQJPHGO/NVwW81q1OShlkLbiMt7vKWOySrcofWD9SnFhZsLEujp45n7lJuR828pdmPi84oUwQUk7JFrte3t2ZsYD2jdWystybfVgvPiEtbrp9yQjYKryiFFlvvfhxYrHKfUseyxWeBOpIDGxsMcc+oP+SBhqeYMIzJB1sZAi3ySa7u5A+tM2mhThRaqtVuuBiMUwxE8/M51x+/rONmN1s2mZjaaCiiXGEZj4VuCKOIASeZquytEnsq0oFDyFQGXMjW0Eji6U/IpX/YGozWTpGeMHSQTe10dlXrt3RXMULyQFMb3dqD/myjO0AW5XIVdJbSV67tk8DIMM/ZDrhqqHxOTosrb8Ty3lLncwiUOLcQHMkFu/3wpNkpjtDhlpBrsYmxLh+61T2UVwodksRmCIy1gmQQnYXrAOTkT25PIOJuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?shjhJdXaxFMosJSJC9c4v9t0/y6SUj6w4soitsXrpsw9eZyCCm5jE8w4Zggj?=
 =?us-ascii?Q?w2H4QayPbccRxh7Z2XJ6zuvxPPDf4dp+Rwbbi2hH1bPbCBrA0nmzqGHDK1gi?=
 =?us-ascii?Q?mEx+1nqv32XBpBcXNtViCzZfDiki0foAuOzIlHrGxeOtUDxzZVMWrX6ImuPD?=
 =?us-ascii?Q?fi6sd1O3A6eCosG3WA44L7PcxHRHweLXrZJHnUc5iyG5dTTSKqD4CFsbWDTQ?=
 =?us-ascii?Q?0ulPZ2WH2qM7tE514rQX458XsvSCFkG1JJ5FUApV7mbl9KPjD9ccBHnUiYAS?=
 =?us-ascii?Q?jmJT4VtPb8FzkBv7tt07GXFOJmuVcNV+d6u1/eIDws8IuogxKJKv+aEcbNwW?=
 =?us-ascii?Q?m9Z8kYTpHUyMIVBgNGmhbsTMbbHdsxMA52gO4+78kPbDqQBhfPEj5k9GluNt?=
 =?us-ascii?Q?JmyiwIB3Yv5/IuY1X5YIYIOiK3YYNTP4OaO8UBt70W+rbLJIUIeCeWSSQCmN?=
 =?us-ascii?Q?swUqV39EJC94olNKSGYN0fGQ2wlV650GrMMwN10ZXAwXunjyq0a3FZhJ6Y1c?=
 =?us-ascii?Q?sExQFwepSBfD6Q1LdAqkZkFmvnmgq4F9lt0yWFa2TRdNxWyu3MRCvVFeH8aU?=
 =?us-ascii?Q?xXPtIrDZjG7yweoX9SkhupgJH+45zKB0XCcka6KMEdhTm2ELTkKh8LPlemKa?=
 =?us-ascii?Q?Huha43LkadxwUWV+u6vcGJXnjHd8itazBPV/7D+edpWP0cr9zQ2zFZNYjuIx?=
 =?us-ascii?Q?uFLcIywGME6imHQEXNj5DKO/p8XGGwfMBIl2II9iRdT43yPpRvlWGLwBai65?=
 =?us-ascii?Q?VpLfiRsRLMgSTYdX/9PrAA24olY9YHx/78zBux8ELeK7seVwwsPlDFck4H0s?=
 =?us-ascii?Q?SGnF9wxSPOU6voHelbK/eqQ9hF/22fwIuiti28mmCQRExdkSirYy7ygtaIJi?=
 =?us-ascii?Q?QL8z+YgsScm8WuExxGirwqXgzDz69eVpBP1pr3tBkdF3o/K5GIHPtDp8BxQ8?=
 =?us-ascii?Q?1ivblnqr2isOw3D1RQqKCnjG4J3yjTltUHpvWOMXdBeyjnPY/A2VTB2d+eIt?=
 =?us-ascii?Q?D+GGQVs9OiCyscF8UiazTG2TDi9JC5XnsuTcu4WBlWX9PjTNRiwWbchpSt19?=
 =?us-ascii?Q?O/bQ2CKBLcDAKXM7PFarkEHDqQsLCUxBt8Rr3rQhA8EJcyZMyAPi0GLnqaJO?=
 =?us-ascii?Q?UInxlYhj6zo34+tYdbWPz77rUX1qFjVyKGr74a4rcjROUIqfzfJV6mJYI9BG?=
 =?us-ascii?Q?xKo7FdIERHc7QhHU4KbN4ZRccB2U7hXDn0Cklmsgg1h2/9tdnVu5BVb7fUqv?=
 =?us-ascii?Q?fdTHT2Usjomflkln1WRi2ONM0rXrEF9S1x/xTerThfnxsc6Ulouv2Q+ZglQC?=
 =?us-ascii?Q?V/UXevFNLtOtopT3n0wEQ6pwvKGqiDC82CrebqVMY+tst30W5DlmQtiYq7XJ?=
 =?us-ascii?Q?xaKnj23ef9oKnZoZZB6Pw7SmsnsZIb/oIABTAPDwvWjf1GCnyR86ZwLAfO5R?=
 =?us-ascii?Q?z+laUUigJSASHF6SHSZWOOunwzKdnvMU4RcrITrFmb1rSP5OizP0QXaVEY0I?=
 =?us-ascii?Q?/dUrmAW5Fq4hrc09LiRMMNkPd3tECvIUSjjtddA2A3/H7lG7YPBbYlEBEwz9?=
 =?us-ascii?Q?mw7m8rHkQB0IpztVfnqT4yRP5UXBVMWMCY/sUpWSjgutE0ONJt4CV+GruaUW?=
 =?us-ascii?Q?7VAKC8wFquTfX627ENP8n82t5VLGaVknZS1Txpz3L9zj2LJE/JGI0CTcsyGq?=
 =?us-ascii?Q?ZFgYDsUownr0F8jPPJeTYqHRFcCqgPhrrPViQs0cGdal7yLPKyKf1+JZ5mx4?=
 =?us-ascii?Q?T9YLYFXv0Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ad812a-e391-40b9-825a-08def3721e25
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 04:20:59.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smtLR0IN14BYdthfyye605rXFVXorxeHX/UtEJtRj6IkDtNzdhi/0jiGwk8KuWoD9rNPp9Ve1Mleb4iEvGUZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFF38CE2865

Add support for a new ELF section ".kmod_btfs" that allows BPF programs
to declare which kernel modules need BTF loading. This avoids loading
all module BTFs and speeds up program load when only a subset of modules
is needed.

Specifically, this patch introduces two internal functions:
  - bpf_object__collect_kmod_btf_names(): parses the ".kmod_btfs"
    section and collects the declared module names.
  - is_kmod_btf_needed(): determines whether a given module's BTF
    should be loaded, allowing libbpf to skip unneeded modules.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/lib/bpf/bpf_helpers.h |  14 +++++
 tools/lib/bpf/libbpf.c      | 112 ++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9d160b5b9c0e..171ea055cd32 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -188,6 +188,20 @@ enum libbpf_tristate {
 	TRI_MODULE = 2,
 };
 
+/* Helper typedef for declaring kernel module names that need BTF loading.
+ *
+ * Usage: define an array in the ".kmod_btfs" ELF section to specify
+ * which modules need BTF loading:
+ *
+ *   DEFINE_KMOD_BTFS(_needed_kmods)= { "module1", "module2", ... };
+ *
+ * This avoids unnecessary BTF loading and speeds up the BPF program
+ * load process.
+ */
+#define KMOD_NAME_LEN 64
+#define DEFINE_KMOD_BTFS(name) \
+	SEC(".kmod_btfs") char name[][KMOD_NAME_LEN]
+
 #define __kconfig __attribute__((section(".kconfig")))
 #define __ksym __attribute__((section(".ksyms")))
 #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514e4e9daa82..5cefe82e4a67 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -548,6 +548,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define KMODS_BTFS_SEC ".kmod_btfs"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -703,6 +704,12 @@ enum bpf_object_state {
 	OBJ_LOADED,
 };
 
+/* Should match typedef in bpf_helpers.h */
+#define KMOD_NAME_LEN 64
+
+#define KMODS_BTF_UNLOADED 0UL
+#define KMODS_BTF_LOADED   1UL
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -779,6 +786,14 @@ struct bpf_object {
 	char *token_path;
 	int token_fd;
 
+	/* kernel module BTFs to load, declared in ".kmod_btfs" ELF section */
+	struct {
+		char (*data)[KMOD_NAME_LEN];
+		size_t nr_names;
+		size_t nr_loaded;
+		struct hashmap *hashmap;
+	} *kmod_btfs;
+
 	char path[];
 };
 
@@ -901,6 +916,68 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	return -ENOMEM;
 }
 
+static size_t mod_name_hash_fn(long key, void *ctx)
+{
+	return str_hash((char *)key);
+}
+
+static bool mod_name_equal_fn(long key1, long key2, void *ctx)
+{
+	return strcmp((char *)key1, (char *)key2) == 0;
+}
+
+static int
+bpf_object__collect_kmod_btf_names(struct bpf_object *obj, Elf_Data *sec_data,
+				   const char *sec_name)
+{
+	int module_cnt, i, err = 0;
+
+	if (sec_data->d_size % KMOD_NAME_LEN != 0) {
+		pr_warn("sec '%s': size %zu should be multiple of %d\n",
+			sec_name, sec_data->d_size, KMOD_NAME_LEN);
+		return -EINVAL;
+	}
+
+	module_cnt = sec_data->d_size / KMOD_NAME_LEN;
+	obj->kmod_btfs = calloc(1, sizeof(*obj->kmod_btfs));
+	if (!obj->kmod_btfs)
+		return -ENOMEM;
+
+	obj->kmod_btfs->data = calloc(module_cnt, KMOD_NAME_LEN);
+	if (!obj->kmod_btfs->data)
+		goto err_out;
+	memcpy(obj->kmod_btfs->data, sec_data->d_buf, sec_data->d_size);
+
+	obj->kmod_btfs->hashmap = hashmap__new(mod_name_hash_fn,
+					       mod_name_equal_fn, NULL);
+	if (IS_ERR(obj->kmod_btfs->hashmap)) {
+		err = PTR_ERR(obj->kmod_btfs->hashmap);
+		goto err_out;
+	}
+
+	for (i = 0; i < module_cnt; i++) {
+		obj->kmod_btfs->data[i][KMOD_NAME_LEN - 1] = '\0';
+		if (hashmap__find(obj->kmod_btfs->hashmap,
+				  obj->kmod_btfs->data[i], NULL)) {
+			pr_warn("sec '%s': ignored duplicate module '%s'\n",
+				sec_name, obj->kmod_btfs->data[i]);
+			continue;
+		}
+		err = hashmap__set(obj->kmod_btfs->hashmap, obj->kmod_btfs->data[i],
+				   KMODS_BTF_UNLOADED, NULL, NULL);
+		if (err)
+			goto err_out;
+		obj->kmod_btfs->nr_names++;
+	}
+	return 0;
+
+err_out:
+	hashmap__free(obj->kmod_btfs->hashmap);
+	zfree(&obj->kmod_btfs->data);
+	zfree(&obj->kmod_btfs);
+	return err;
+}
+
 static int
 bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 			 const char *sec_name, int sec_idx)
@@ -4034,6 +4111,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				memcpy(obj->jumptables_data, data->d_buf, data->d_size);
 				obj->jumptables_data_sz = data->d_size;
 				obj->efile.jumptables_data_shndx = idx;
+			} else if (strcmp(name, KMODS_BTFS_SEC) == 0) {
+				err = bpf_object__collect_kmod_btf_names(obj, data, name);
+				if (err)
+					return err;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -5803,6 +5884,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	return 0;
 }
 
+static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
+{
+	uintptr_t val;
+
+	if (!hashmap__find(obj->kmod_btfs->hashmap, name, &val))
+		return false;
+
+	if (val == KMODS_BTF_LOADED)
+		return false;
+
+	hashmap__set(obj->kmod_btfs->hashmap, name, KMODS_BTF_LOADED, NULL, NULL);
+	obj->kmod_btfs->nr_loaded++;
+	return true;
+}
+
 static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
@@ -5867,6 +5963,12 @@ static int load_module_btfs(struct bpf_object *obj)
 			continue;
 		}
 
+		if (obj->kmod_btfs && obj->kmod_btfs->hashmap &&
+		    !is_kmod_btf_needed(obj, name)) {
+			close(fd);
+			continue;
+		}
+
 		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
 		err = libbpf_get_error(btf);
 		if (err) {
@@ -5891,6 +5993,10 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (obj->kmod_btfs &&
+		    obj->kmod_btfs->nr_names == obj->kmod_btfs->nr_loaded)
+			break;
 	}
 
 	if (err) {
@@ -9030,6 +9136,12 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
 	/* clean up vmlinux BTF */
 	btf__free(obj->btf_vmlinux);
 	obj->btf_vmlinux = NULL;
+
+	if (obj->kmod_btfs) {
+		hashmap__free(obj->kmod_btfs->hashmap);
+		zfree(&obj->kmod_btfs->data);
+		zfree(&obj->kmod_btfs);
+	}
 }
 
 static void bpf_object_post_load_cleanup(struct bpf_object *obj)
-- 
2.34.1

