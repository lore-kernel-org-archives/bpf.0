Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C9357D03;
	Thu, 13 Aug 2026 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591596; cv=fail; b=bTDvrXSbYXuZkMRwaGmwVfEZxJ23T+4RDMB2xjDRE+DvEU/Eob5OjNxaV2m4XG3y69skXgQ7XPykrHA5+Y8dB+tXkX4K3rpWd8eS0ult6hUKjRTQ9Lxtt47Aq1rgUw1Dcotsc7j9K72tBQIIVXDgPrApVahoUVajSZXd4NxEBp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591596; c=relaxed/simple;
	bh=WHgqCo7ExM9GyIuQuLw5CTdeBedTeLIqEP5N/BnQ7e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KsAb69V8uVnixIPTWPWEX58WFcTUp0hGC5xvsB65kLBrALQDVldoBgnSlRtNBYCo9dixrUUJHRuFUPIrDy2YLukStLCmO6kcVrnV6CLV99YLq6GYRvSo+nACqb3ljLRkHxD5CwwLBlP4+3OP8oDZvEXkUXvBOyOk/Xxzfy7s+Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bw56E8iK; arc=fail smtp.client-ip=52.101.126.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bw56E8iK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rt5xEtM7kz1MQAOxrTzYyA0nLC2qtq9rA/wlvimfreF2aI2ali03913Wm8WbLnE9avqpmGXlQr/FxF4gl6bBmq4ofHVDQbOjCiIYCdGMD7EybI6NkJSLcsuUqBMbb+1tbX/wvMtkBdq1bgQnNKfna/Y8QOLdlzzBpeQNwx3xAHjsuolaz8BR2aMPDgg8VoARl/ficK1XgZK3xPG2R0JnDEret2EWOmQadChF3kQOkGX/tbaIVIqjp4/Fs0hjz5FD1V3JAFrqwoff80LBUHauZjJtE7xWjbiBypFQU4qbpHVY8anRCLQ1SXBk/OsHKYqUYTxpo5mgJiOyd7jsfRsblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK7i/1g6bBAHQJdkqbVuwEIzm3vYorWxOOAmsP3l6dE=;
 b=W3aXzHuGPgtvlgJ47zKDXpetjLzGVHMyONnKsqdhP2mnma22A982jjV/XjL4t94dpHoE2jPr6DcW+LTqRt2H/K9CEFP1HMlHiqNboB5ggMrSvEPwnjQp61waJUwC7s9DD4BCvZU5YY/wSbwqNumFH0do2CdYotlA0HQZwnH7F2rdQBi8iuGLoM5E9osF3ThniQqX+qzbVXcFAuI4/imAxg5epUlxGQCgfzXjygxIgYo5TwRfyXVIf7UFYr8Lkh613qsiViDMZRvCKt5q0kIKWQY+GJSotqXMJUZWcXAoEKuHceb9P+ilTn1+lXhoZr+Up7W2r7lp4S8WyRZGEwr4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK7i/1g6bBAHQJdkqbVuwEIzm3vYorWxOOAmsP3l6dE=;
 b=bw56E8iKml+UbVXfU/h5mK7AZlFVu4Ar9RrBKHo+5GJv5H+h+OZ2N1XYBHmf2dXSNzJaxZZa2nWwydmduKfvmvvs/lJa0+4YFf2Vw3c1k5oZ46bjLoH5qKo+yVuANgSsjmBot6kmfHISMJnZIN/vOAL5hFS3yKRIxuwcrR4SrckqT88BnzPpt2PemIosC1qXl4oAP3sYmvhZI7+K+rpFwqgkUv+WjJCL/exXwM8Ba8pcrZdTJYxinEtcEPSk6wuuzvv4nMxBqT/dnNSh0kqhzNabk6IH6OluK3J0WG8AToqJygfkTuz5RwpYwwWQIiLSSyd4OjbgSbmP7ZKEYhZrTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB7024.apcprd06.prod.outlook.com (2603:1096:101:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:26:28 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 03:26:28 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	yatsenko@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel module BTF loading via .kmod_btfs section
Date: Thu, 13 Aug 2026 11:26:12 +0800
Message-Id: <20260813032613.2755-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813032613.2755-1-zhaofuyu@vivo.com>
References: <20260813032613.2755-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 879824e6-f661-4adc-44e5-08def8eaa94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	qF3It5yiZhtgbMnioXUaoQtUxwxZpPjaV7tESNOr9XNYADhtuja3i9ZeS/InZuef5CG3Qm4hWl51z/THVLF8Mg02W/gVVFpd7AND79pCk4zDBqadLH+bILM9FCK7LbWAxSdrhKUseWdRCr6jqplS/sGyXU2mGFGRMU/zpPgad6ehhRrzHGYt6XSgx4hSFPuPGqtkbnBRMYRmPXnd3Gxys9lEySmUVPENnDnuH664SwoZiLa6pDhTPua4RHPkjuRcCONurNrv2YVAyIo1Yjmh+o5EYIfsycLcf6CXWu7xPEc9xyG69Nn5+cS9vSZp1QeKYJ17xcJYiSezPoI8rra59WvdT4d+X2y/ZC+eJl3JIUBEd7X2PBDUX4pZRrKKbP+J3eAXyI+iIrn9G/kt8OLaHSVyFEyQ1GIKqXy2xHCvo1+u+z5nhAkPr+A1nrc3nvjFRXjMqL0VGS55ph/c/715pYCwHxCfdPu3ewcpK+OiAJXMsES2c2wypLpvfrgbHuhB/t7sGYb71OdAMcbRzXGticQyhSb61mqSvPJxsuRFFFLOnWRErYV0NHO57y8kcIL0EjWdDSXTMt10pwVHfLVICR2iqn17pgoxP1jfEjiNThUWfPBi4zpvm6oFoDJjVP6f74pFU8w5IORI80FE9Z9Zz10gGLU4f9gNE35GtcG0CjUPB4O5beDtUXzq9UMH4080rL/+rUxc4EDpk83XDifir2bOXFYCbSdws5x1o2WZmUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DD9xNxM/9w1eib8FdRvIrlAD1GE7/ejYxer7qUd/YcucU7qtm3Q9+bsfcHM5?=
 =?us-ascii?Q?BpH8iWLeGWFzmXnpIe3tvIZB11hHHRr7ie/n6TstXVSBceBFh/QT1KeI0QJ7?=
 =?us-ascii?Q?mTIfD+gJWq5yAYVo6nAfoIJgDw7dRHl0MxrotoIwBdp4Iqw27ofavb9NY7fY?=
 =?us-ascii?Q?79cCNjHzLFJP04RGtBLOnqLWy9cok6E9bkZ7tZ5kxXW8yiabToSCQBRC6cEQ?=
 =?us-ascii?Q?v0ZLMh8j4hwwlIBA0EvN0MoKklxKvWBQp7CAuLPpEIVPmPcXM2aBOdY8PuiI?=
 =?us-ascii?Q?T5Fq21Ov+trK2LV6IXZlQE8XWhCfpG14V5pcNZepB/2/b4yACSo0gDvNcRDz?=
 =?us-ascii?Q?h1noTPAQVXQjCNl5ycuooEtbgskB0j0JszWduJQ6wkDB0ML6xDU65CodncXt?=
 =?us-ascii?Q?AmtDcxUC+ZW7PQC0LS90u+y3naS1KdjU5p34D5ZbGyKL5XlV9dOnQfXg6NGQ?=
 =?us-ascii?Q?z05LxXb3gNWbUTDylqyiLOnqIp3TgEAbBtjwNkJ42USGyB9x/Xufwnz+C75X?=
 =?us-ascii?Q?YvU3ibImc9JdPFBoD2qzLmas6iE8nwFk9tjXQQEYbx5IJ7F4dXtHoDZtPbQW?=
 =?us-ascii?Q?tQox+uK9GfaooSxJL0vDpfynkDF8M2EpdZKrlRqeXMX9QOMUyJcN54ocVM3R?=
 =?us-ascii?Q?JoChpYxEJa7z8Zw+sdxw1GAcnA1whW44s+I+XpJPiCyuZ6iGeEOXuHxyX/GK?=
 =?us-ascii?Q?2mwy3EZOdisqOqdNdjue5GxhWbEyiBKWjAWngguWVyJ7+sXH6saf8BEj0bz6?=
 =?us-ascii?Q?Ip149PaalOF2TP1zxld7WTuzf3cS9InOl8to+b9o3F+0UBoNfKUHoM7W8LsJ?=
 =?us-ascii?Q?d5QuPZktTgUFb3vUDwyHapvnE4yIHI4RCxkin95BcoWqVsCINyWWHxbTh/G4?=
 =?us-ascii?Q?B5lZkEGRS4QbIzZUGdo+Zo0AT1WSsfkx1d0TPxWV5nEculIbkI9N58P9NNqt?=
 =?us-ascii?Q?A4gMmqxN0kOuNSthv4t19HcM4glJr335uKaTgcy6wlZVyx06GPburGyWR+G7?=
 =?us-ascii?Q?vXba//IDtiWy0Bl/7pyjFGiSFWzfyv6EFA2usCRm67GMxqK+nfoWYDNLPZgv?=
 =?us-ascii?Q?W6YhnaicNUnQHjR2t+QEiE2Wkg35IDf1YjvF8GsHgpZaObIMTcBWi+SKwQ7h?=
 =?us-ascii?Q?IPOlS7hZWa1+0EhTiGUo5befk0thNUKCuAsE0vDsvTn5EGT8ti5mTwK2elkS?=
 =?us-ascii?Q?aIwUfn41LlszVS+wJiCz6j68FO7paEbqWUkfvnXKwoEzK7xleCOHZggdvigg?=
 =?us-ascii?Q?pQjdUtiyBcgjM4yxuXZHpS6AnF6BrvwcVsyXSDtxwY6rO8ItOG8ee30Ji3JU?=
 =?us-ascii?Q?joKFxBB1haPRv+dLY8IeneyDuUSEIR8LYD7rGbtqFgGHFDuedkHHPuBIrVTg?=
 =?us-ascii?Q?Z9IJZs+RaswUIoCzIvud2NxeSQG+ApjvkWlYET4MYW/afzgBRI4WfwD05P72?=
 =?us-ascii?Q?DvRSmP7Xkuz5ilP3+Q4km3XKbS1BPfkCtQWGjiWI/lLxXjMpADddQiVt1xWw?=
 =?us-ascii?Q?NFgJLRPld4M8jFgtFw6TOzLxMKoBOhYHxzZbFMOdvd2PI9oTFIN4nDGLOqTG?=
 =?us-ascii?Q?DW9eBZo9s9PJnPkuXVW1uVL/K/ufPGQYl7AKy9L1qiiNr3IzH/xey1hEds0u?=
 =?us-ascii?Q?ojTueoGebO32uXCWV4+MFox1EfXdtEjzfu6DwtOY6ifnlX62cOpEMNVkn7oK?=
 =?us-ascii?Q?+W/nqlJhpfQZTm4XUQeRB2x09uguiKdSMmvjWIw9eBdiBfUiJBsO0naRAX/+?=
 =?us-ascii?Q?SIG3ue72CQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879824e6-f661-4adc-44e5-08def8eaa94a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:26:28.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PmmHoGspgVfuhxugs+3XsM5kdnQPy9S3ay1WBnv3zhfM6Dj1koEBe5XtR9Nz9awBUf8oOKFLdnyoAtS2zhKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7024

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
 tools/lib/bpf/libbpf.c      | 106 ++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

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
index 514e4e9daa82..9fe8a653e8b6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -548,6 +548,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define KMODS_BTFS_SEC ".kmod_btfs"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -703,6 +704,9 @@ enum bpf_object_state {
 	OBJ_LOADED,
 };
 
+/* Should match the definition in bpf_helpers.h */
+#define KMOD_NAME_LEN 64
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -779,6 +783,14 @@ struct bpf_object {
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
 
@@ -901,6 +913,75 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
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
+	if (obj->kmod_btfs) {
+		pr_warn("sec '%s': duplicate sections detected\n", sec_name);
+		return -EEXIST;
+	}
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
+	if (!obj->kmod_btfs->data) {
+		err = -ENOMEM;
+		goto err_out;
+	}
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
+				   0, NULL, NULL);
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
@@ -4034,6 +4115,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -5803,6 +5888,11 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	return 0;
 }
 
+static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
+{
+	return hashmap_find(obj->kmod_btfs->hashmap, (long)name, NULL);
+}
+
 static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
@@ -5867,6 +5957,12 @@ static int load_module_btfs(struct bpf_object *obj)
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
@@ -5891,6 +5987,10 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (obj->kmod_btfs &&
+		    obj->kmod_btfs->nr_names == obj->kmod_btfs->nr_loaded)
+			break;
 	}
 
 	if (err) {
@@ -9030,6 +9130,12 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
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

