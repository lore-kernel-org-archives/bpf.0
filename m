Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07051428475;
	Wed, 19 Aug 2026 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130289; cv=fail; b=T4018BX4wuPd7Ft7993DZrcVIJ6zt9vfL063HJbdNT8kY7noTCkU2nfTGAsdChTuvl0MY51HNzHEWO7MRBU3952BqJRMVhfie89o7WCt/+S6l73ja2cjb8vnRMDTU6UJ8znbtggf5AYjV81jL1Cab/3Giv2/bP3pH8N1uydQBs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130289; c=relaxed/simple;
	bh=eZrHk83Ttqgtf35ZtzvkbTTRY3vm94CCHNN9t+yawr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFj/74pCJUxGNAYLqIzpVh2/q1egbcGVY8mgIFplwQaNctLEonaOMD7y6GYRtc0w9hZldassgDjose6cr9VAmQA4tqa+VuxnJ2XlHEam2T40ahg1aHaac+b3FhCys7k+Y48eOOK2X7MFS8nqmoDxbkIY8tn6bxg+nxseUQa+WYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H7vNGb+/; arc=fail smtp.client-ip=52.101.127.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H7vNGb+/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdouEJNTBm5RcTehFQMb/p9AOxUJiGlizMzLeW/KrNFRPKaWNQhUinluE9TRs8ZeCMgiHeFHxoZFZ7nZxE79zWuz5QmI0cSBLArAicMkvaOoOgbK4AaebJQcMHonoYRBARzK7owBJBXOpxe+40lw2lZrX54MAimqA8D9LyTaogQ8IG4uHmX7+rj+Fnpq3Ji3QBeRWQmUdwTDB+jIv2XcOOE9hQ0jUAQh2Zbn701zM7bGAbV811RVMhPHFICCoGKptRyGviQtyAaxFh06/ejSl8XE9FmdKTJmd23S07z+jFtMqyB1n/ADV9GVqx+Ljnn20KYNuCECrPHtPWJWt7gBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro3FGc4c0t5OvDRuR0pJRLGeYHb/9D4HPvaJYHB83Bk=;
 b=XdVfOy3PH4NpisejmFD82b3MRzsAEYa+ASwyO99HFuL8HCFqBdihlC0dWYFB4ys2C70YSSxb3VaMkAC+hXxxlPa8VM4FdGhSu9v62McNarHpm1rTFM2m2ouxg4JPv9A33dyWa19sjtjUIMdYwoopdl6msSkH89Lz+mBmn/FYehs8eaqHRPv/ojmB0j6vrj6mdRMw05Lxs9NCZWRZFp7yiunejxS+qPH1A2/EuWwq4OZd394/SXnCLZs4me4z5n69w3jFXw7cwZgrouZDTHzUTK2f+yQ7i1czVbktt0F8PVe3lGnxfOI4OAve93BMXT6AbXKIm5MavtQDUOtMJnuPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro3FGc4c0t5OvDRuR0pJRLGeYHb/9D4HPvaJYHB83Bk=;
 b=H7vNGb+/XdBe+KO8Dl/9TC88ByP0Xy7jBSVM3ZqmsGG85bpTpAHjspGW0b1C4HYtwk2saQKQ0nGAtptW4baj0c7nsgGXZwlOmeUliThhni1nfnNcQ9HxxvsI6OAYdOAvXY+ogByMRvcvW9b1/8J51TrY+rPESeONx3PSsy7JR43DacxFx2cDrQlDfJVRVMOorOggvskE/6Eyx/1zdPXMQ0qZoZUy89ukAb6tnMe57nwHfkrKTv1jDgh+QCG0bdfyyo9REpiU8+u8Cc1zhehNRzAjAMos72DDk3C2GRN1K1r7zH/sZl2Oyy2ivC7EcndoE1orsPQM++MBuyWsz07/ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:04:43 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:04:43 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Cc: andrii@kernel.org,
	ast@kernel.org,
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
Subject: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
Date: Wed, 19 Aug 2026 17:04:25 +0800
Message-Id: <20260819090426.267-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819090426.267-1-zhaofuyu@vivo.com>
References: <20260819090426.267-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI6PR06MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 148927aa-126d-432a-f2ea-08defdd0e8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|52116014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Tzhsqg3cmrTsZRHw9ATy+7zaepdxm7drQn778kbYu6WaVpDEmPjwcOI2qkQnLPRFJGdhjlLM6IRrDTmmJN/ltkbWFXEjv4ra+35Fe51HMG1SpIVVRA/HbQ3Pigg4yBjpjQhBYxWBfUYDsOoMUjIXq6N1KYvfLLP+rpwAn7i7G/TofFGpDEKw/SNs55gKKfgOZj19is6Uufnhr+YtSRq6QntfgL0Rof+W52oULqR63mUwEDY07cGoKTdSLHH3QfedgGuQFFOEeq3/k9Po9q+dJGCcJcey66x/d60Bz0FkPh3kbbcnroGQczF40DXeeHpocRt9gMeMFrRCGAdLZsHhaaTYASlbHjAgkmaO51SH3fn5ZbbE/QAUQyUQDrqlmTiLFmr27hklMYfwo3FllzQlbNSrsEuHPe1biJn8A6ljjBSbBE8PkD76VskFfyY6FIFDWTKuXnTPggpDkT8C9doJGfnTslZ+csRWRXs4CGrN8UKtiuPl2u9KLdRF6FSBTwGDrp9KLqA4Sc8/iiEnTW/VwS0+N3zqnqnJVYCvJV1zk/q0wqrjVfm5Cd7mDf+JXQjejAN0NZL9LvB5INNgxiHLdnB33bxp2HlqAHH1TBwmF2gmkmBivVUXkirziV1VqT7aI2TMuKfzPg/XizTVQspx0fPNQMFAqBls6EH8JGuB/1+B+uNiZ3XnEoUT+YntY9A2BqvoyduUFu39zbTuiQjI06RwaosvjlR8obWequUVKkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(52116014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xjBQP1w1WMWulDssG6RTzYk2gpPJwk7ijPtywvrm9nhHeGA236mEX9B1Exj?=
 =?us-ascii?Q?GUTgyRqdvFtzaPvdACrL0y1lgXo2ybzdqTBrt35YE3q4tZ/ZqtQoYi0plVre?=
 =?us-ascii?Q?1OyRc+XG796xx9nTZ8W7xDTMtomMK/g6NQh2WdahWRFrobHsRzfV5UkNuvCa?=
 =?us-ascii?Q?oqGfleWxtYho27MryUIhm7kdIqafoVUYWoxtl1B04ownYmq8b0tBlXiJAacI?=
 =?us-ascii?Q?CWGAJ9u3vReSKHHSCLXmzmVoe4cxGn8ip65DiUBwTRpt1sphk3pGOlAz6BBE?=
 =?us-ascii?Q?DGUBGOcqfdLHSMTLZ5M6qZ5tv39Hc5UzzpUkdJxyl/kt5fbVgoh0ccfYdPLV?=
 =?us-ascii?Q?9Va5uRtCNA9ynJBoQLttSsEj2qWhvp4mCkbCDZTohDnmA0jUX9lpG8c7xXt/?=
 =?us-ascii?Q?Dnq05Mw1r+xYWm2WJyanFe7JpIMsD5NDvUxBRC+sV9ApWhjmPjEvdRFG65sj?=
 =?us-ascii?Q?VLvLZ8+GxsWibf5DHxgnoqj9e0pIXwYUhoEiCaURssS1B0ea+P8wapgByh4S?=
 =?us-ascii?Q?bu6uxdX1byX3iChnnKWdLaCoctt9xMOpOv5m9Ff8Ac/k5QebkKhPFOmiT4mQ?=
 =?us-ascii?Q?qqwXhZ8vIdJ0GNdc1LZUAFH6BDcEW2Yp7+52d30mtO7Du1xSQC17axqGDFel?=
 =?us-ascii?Q?Xi0eaCOCHoB/40PIzfp8uANo5yQcFuqYUk9kHHp1D3uFD0/fveNwQcqKIEG3?=
 =?us-ascii?Q?6U7TPZXxPuMBZAkFxN3+EPVpL/DKpu6HCwS6Wy63YpK1III/Jvlrvl4kHd+p?=
 =?us-ascii?Q?yvmqxDg0C3/9dJNGkBzJ3vOD5F0r0cr4s5aQWw8LCt2o4BQaEqT7BucN10h+?=
 =?us-ascii?Q?eGItjuHc1rM9KMKuCOe5SeppT3/mvU0mRfJrHF8DYQZmgTiCfHr9QrsGLZZx?=
 =?us-ascii?Q?FvREdcnUuRp3s9WCOxnWD2MDZkxXB0+maFNTSMZkbWkeljf+spWcpyL8vAPf?=
 =?us-ascii?Q?svcBFoDWENnwI9t/ts0C1xHvBy40fiafPp4qjnsYARdkomotshEGQY7RP52q?=
 =?us-ascii?Q?3Cc/9rPOYNmx8IBWtKhLqsEdDFkdjkkEvZQM8RyITwY3VKtuE2mwL6bJUOwx?=
 =?us-ascii?Q?3IW2X5e4m0/HKS+XBBpzAay8T16GbX0v4A+5wpgnIFY+ORkE1DDTGS+2wHeb?=
 =?us-ascii?Q?hP3hK1nJ34AanxpyJ3Pz6kKlfM1ra7tQhge/1n5f1Vj/Dw43RIvUuqnre5nd?=
 =?us-ascii?Q?6uNtaUFHP/hZ2JwTRMxslvyFhqU3ut3+QKHhLdvqAFbGNnSGu3IeHTd7kk1i?=
 =?us-ascii?Q?VbJw/oKMR57cPbpS0DIfiHr3l5XoLEMlQR4lujf5J6NPO3yH8EGk7i5V5qgr?=
 =?us-ascii?Q?Hm8Hak48s8JddVtnRsohBlhw+07P7d/CrhrqpTef0dSu1PvshOaaSPm8Fl+8?=
 =?us-ascii?Q?lZdhR+V1EPKCHOW31EqaSMvPPpiN6v3kK/I6MxJ5PDy3gDYLgYpKPLXRwXnK?=
 =?us-ascii?Q?Wz2f2cmHAfQOk8SLBxQ3EHwLFEdiH7vjnXe+ngZv2CfWa1ck9bEl6hdafdZo?=
 =?us-ascii?Q?nKQ5AJ77AsJ/ixzf6LRS4p3rlqmuOVijyDp71/IbQWChnfW/vG84rWKk7Omh?=
 =?us-ascii?Q?tYLuAY5cEnvidTHcZDF+YVGQi+b/KJD+bb6+A6E9csx+UhX0kEe/u4XEucOy?=
 =?us-ascii?Q?oprS6RkCpLZZFCc9ZBs6h++YQMKE1W6rCVhFoSFdTN/fbql0pijtlax8zGp5?=
 =?us-ascii?Q?yrFUzZJPfcLC0iJ3rFoBBnKmlazkbsNfBkCpIBO5PFI8gR+dDNEaHQuoCKyx?=
 =?us-ascii?Q?UMSaA2Qqew=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148927aa-126d-432a-f2ea-08defdd0e8d8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:04:43.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBc9htrCkE9Hmwp/f6pOd/ZexaTpgnoBsJsuU8VW03RgPPCYclJ1Wj8bUBZvMAHf194pVJveCQR0+eElKXeicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165

Add kmod_btf_names and kmod_btf_names_cnt fields to
bpf_object_open_opts to support selective kernel module BTF loading.

When kmod_btf_names is provided, libbpf only loads BTFs for the
specified kernel modules and skips other module BTFs during iteration,
speeding up BPF object loading by avoiding unnecessary module BTF
loading.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/lib/bpf/libbpf.c | 133 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  16 ++++-
 2 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514e4e9daa82..37934ca49dd7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -779,6 +779,13 @@ struct bpf_object {
 	char *token_path;
 	int token_fd;
 
+	/* kernel module BTFs to load, as specified via bpf_object_open_opts */
+	struct {
+		char **names;
+		size_t nr_names;
+		struct hashmap *names_map;
+	} *kmod_btfs;
+
 	char path[];
 };
 
@@ -5803,6 +5810,121 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	return 0;
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
+static void bpf_object__free_kmod_btfs(struct bpf_object *obj)
+{
+	size_t i;
+
+	if (!obj->kmod_btfs)
+		return;
+
+	if (obj->kmod_btfs->names) {
+		for (i = 0; i < obj->kmod_btfs->nr_names; i++)
+			zfree(&obj->kmod_btfs->names[i]);
+		zfree(&obj->kmod_btfs->names);
+	}
+	hashmap__free(obj->kmod_btfs->names_map);
+	zfree(&obj->kmod_btfs);
+}
+
+static int bpf_object__init_kmod_btfs(struct bpf_object *obj,
+				      const struct bpf_object_open_opts *opts)
+{
+	const char **kmod_btf_names;
+	size_t i, kmod_btf_names_cnt;
+	int err;
+
+	kmod_btf_names = OPTS_GET(opts, kmod_btf_names, NULL);
+	if (!kmod_btf_names)
+		return 0;
+
+	kmod_btf_names_cnt = OPTS_GET(opts, kmod_btf_names_cnt, 0);
+	if (!kmod_btf_names_cnt) {
+		pr_warn("kmod_btf_names_cnt must be set when kmod_btf_names is provided\n");
+		return -EINVAL;
+	}
+
+	obj->kmod_btfs = calloc(1, sizeof(*obj->kmod_btfs));
+	if (!obj->kmod_btfs)
+		return -ENOMEM;
+
+	obj->kmod_btfs->names = calloc(kmod_btf_names_cnt, sizeof(char *));
+	if (!obj->kmod_btfs->names) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	obj->kmod_btfs->names_map = hashmap__new(mod_name_hash_fn,
+						 mod_name_equal_fn, NULL);
+	if (IS_ERR(obj->kmod_btfs->names_map)) {
+		err = PTR_ERR(obj->kmod_btfs->names_map);
+		obj->kmod_btfs->names_map = NULL;
+		goto err_out;
+	}
+
+	for (i = 0; i < kmod_btf_names_cnt; i++) {
+		size_t idx = obj->kmod_btfs->nr_names;
+
+		if (!kmod_btf_names[i] || !kmod_btf_names[i][0]) {
+			pr_warn("invalid kernel module BTF name at index %zu\n", i);
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		obj->kmod_btfs->names[idx] = strdup(kmod_btf_names[i]);
+		if (!obj->kmod_btfs->names[idx]) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		err = hashmap__add(obj->kmod_btfs->names_map,
+				   obj->kmod_btfs->names[idx], 0);
+		if (err) {
+			zfree(&obj->kmod_btfs->names[idx]);
+			if (err == -EEXIST) {
+				pr_warn("duplicate kmod BTF name '%s' ignored\n",
+					kmod_btf_names[i]);
+				continue;
+			}
+			goto err_out;
+		}
+		obj->kmod_btfs->nr_names++;
+	}
+	return 0;
+
+err_out:
+	bpf_object__free_kmod_btfs(obj);
+	return err;
+}
+
+static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
+{
+	if (!obj->kmod_btfs || !obj->kmod_btfs->names_map)
+		return true;
+
+	if (hashmap__find(obj->kmod_btfs->names_map, name, NULL))
+		return true;
+
+	pr_debug("skipping module BTF '%s', not in kmod_btf_names\n", name);
+	return false;
+}
+
+static bool all_needed_kmod_btfs_loaded(const struct bpf_object *obj)
+{
+	return obj->kmod_btfs &&
+	       obj->kmod_btfs->nr_names > 0 &&
+	       obj->kmod_btfs->nr_names == obj->btf_module_cnt;
+}
+
 static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
@@ -5867,6 +5989,11 @@ static int load_module_btfs(struct bpf_object *obj)
 			continue;
 		}
 
+		if (!is_kmod_btf_needed(obj, name)) {
+			close(fd);
+			continue;
+		}
+
 		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
 		err = libbpf_get_error(btf);
 		if (err) {
@@ -5891,6 +6018,9 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (all_needed_kmod_btfs_loaded(obj))
+			break;
 	}
 
 	if (err) {
@@ -8515,6 +8645,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	err = err ? : bpf_object__init_maps(obj, opts);
 	err = err ? : bpf_object_init_progs(obj, opts);
 	err = err ? : bpf_object__collect_relos(obj);
+	err = err ? : bpf_object__init_kmod_btfs(obj, opts);
 	if (err)
 		goto out;
 
@@ -9629,6 +9760,8 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	bpf_object__free_kmod_btfs(obj);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..2f8ff6d2d3df 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -224,10 +224,24 @@ struct bpf_object_open_opts {
 	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
 	 */
 	const char *bpf_token_path;
+	/*
+	 * Optional list of kernel module names whose BTFs should be loaded.
+	 * kmod_btf_names_cnt specifies the number of entries in
+	 * kmod_btf_names.
+	 *
+	 * If kmod_btf_names is NULL, all module BTFs are loaded, preserving
+	 * the default behavior. Otherwise, only the specified module BTFs
+	 * are loaded.
+	 *
+	 * kmod_btf_names_cnt must be non-zero when kmod_btf_names is
+	 * non-NULL; otherwise -EINVAL is returned.
+	 */
+	const char **kmod_btf_names;
+	size_t kmod_btf_names_cnt;
 
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field bpf_token_path
+#define bpf_object_open_opts__last_field kmod_btf_names_cnt
 
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
-- 
2.34.1

