Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E83F54D3;
	Wed, 26 Aug 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750093; cv=fail; b=nsMZ/jl4oJlG78lRIBoM0+pmJFFCxbocyyBFxf/wMrCFseDdzLW10KNXOm2YG8KNE0U5myEK3+MRyhkISyEDU3dd/OmdDSSh4g0IxU5ow3ZUs7t0tvx3RALiWYbjjmoehNGtJB7nD9UziW03Z3uVwVA8IlB5TeqIQw3wWg6Xr8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750093; c=relaxed/simple;
	bh=8xhh7cdALk4EW8eTFFtZdarMUWI2CSKrQfZhZ6+OSVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPD0Z5S7sAx056Xr0y1yWDXlun27XjSeowidPtsaQSYwohFJtO9AtPic2yAYAPRVgCoOlZlUN4PGuc3UYwkefpxy4zFtzh731HAyUS1o6Hjv2TEslM3DvNaMwltv4S6cOjs/kyfL0lbP4UHw1sQrFpYR44AIxnDOLonDY882AYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HkD7BlVR; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HkD7BlVR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2nOtsmHaKLcr4KvNTFTxylvJSBzOYbTozXa6bHVef61fQiIvbQjfv9dYKnqQX+FZo/5UFZ/AhrEIjuuspjYVAa0YyHLcPj7uZ51w6InPVkAfRu6o/MaKFXV+0YPWiQfwqQCNkR7Cd7Uir+AYrlmvy34iVH7pBiuAf12HWygCrg3NVvbiS+FWlTRbGwqd9DGD3EaQzPYPzHBU5hRw/MrPpSA4f7vU8mHZUTeTS9T9UShizbDPPLfErTFbO6Wm9GnO+GUXIp0blSRx0Nn1GHJ6LeZr5+nncLVw7KcLS1UZaOD/VL8+t15+47fithjA8V72eX+/EGdgV9gLwigCcCrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsZmQT3jH01/ADQY9n4c/vfWNUuC2ZZinnk1eVWjfVY=;
 b=aDcgJPrLQ+4PY6XgzUovDDBuPkjyNxywSh4/qjzcIT/IxrR8+ifiMxBBP06HF+E2mj1cC9SlyvELELd6JV85g+eLYAQUmck6ZxyUKVC+mEZT436wXDoSTowUUlIDzsqXyYxODCfUgv2yP1md5srKSqTc5D2imOrXgBTvpybKi0ayyKef4N9hwQcAi5ioMsgDR8xUBA/Hz00dPrtcM8DKjQ4PkGJw24KRYirsZ9NFp4x6zRbmr1p2xpwwkTsEbbV2c/XlQE6icZcGwQ+k9jRYH8QkYsgf6JGoST8Kdr+YUXnhPdNju3r3xpUrapV7EU+d72o1zqptaAitwsk+k2eAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsZmQT3jH01/ADQY9n4c/vfWNUuC2ZZinnk1eVWjfVY=;
 b=HkD7BlVR7SepLa06zaE7d1Oavvhh39/FTN3/MOEKomGJ9oTdgM1hBo0xkS/60P5t29KIZvXopDUTWbXv52YF7z52RVBBYBpqHYNlIYbQBmSXT8spE6Is2bQZAao1/y6Wu32hVm2Yh4zZ9FJxfUHoWzpFlZG1UvNracrnesnh3GCVkmTdLaKkxHwKIsmNoM6W+BGmmPe59HfIJyo3S2jk8luUhKpSPixsUS+n3D55gLATp2FMJCBNUiFz9TcQFSXWvHQHVqQuK6BlzFD8sQPM2Rv4fdptfa1TZY6CEUHTblgF9Di0oWxyrQFf8ub6m6vN+0TKw/9e/KQPGydFVaX+/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB5866.apcprd06.prod.outlook.com (2603:1096:101:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 13:14:45 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 13:14:45 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v5 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
Date: Wed, 26 Aug 2026 21:14:27 +0800
Message-Id: <20260826131428.302-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826131428.302-1-zhaofuyu@vivo.com>
References: <20260826131428.302-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 2990219f-687a-4184-0f84-08df0373ff8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	f2BOXn0GdOqz0Gh/JGD5Jn76Qk0heooK593gDmVSY/wW4Di0jBY6C2/VQ4EQZzYSllxqB4pChdFZxZ37YN/5Ev6FCkVLc+YNbArms50XEcsOBRS5y4ungjKAWRpX0/TzESOtSXNxA1qqrgxJNy0ppIRSJ17rv95xaz2uqr6gvy+2hZjc9Hwo660aUAfu/Hw2wZXvBymc48obEig8OTbwhkFh/LfzQOyE8qB/tliJgm81GbOw2uVUtsyi1npBnKnugenFlbO6+e8GqrpGsDg4H4+TViCMebaEqzAEbqkfMvQI/k/tD4SaRmEJPaDO1N27+s10uiHoEPok63oDjwg5UAybYAeECC9bK7lThts7nnw1BnT5jdfKtsnzSNPwLhRMlkxvFJCYL/M+KwXOx/6lHo903vNPtMQYCelXa1fMBYdz0PNdzLFg4Jp8GJHtVGgm4ggGRdMqzVe1AoSZ5t+hfYt02Dbu6KSMDYtAYs+OG9ojGq8XeDzuknhlh5+7sIL/U6gzDF3W94LOn4eUDBqBP/HXZ+1XdxO4U/9JkZ9+nfW94cWDJ+kw8Yu/17TWj2DQI5J+tIA7x1VUtLaq94aMGbm2mBrHaAjDSxecpnhKstUaIOyjfvePk/Hd1oJBfUMPqc8Uotnp28QxcLAw4XgUR9q6wlVyFiQoqN5HHVuRJgMcm+n+veubudn2pxkh9MvFKn6Z7y8QqIiEgy7pMH5uJznr8hnmTt/D4QoLd03cG3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZyXHbWkfmbnqU66qyQsNaWCAo6ZtSE0GHGiiZUdXdcUuUpFtCttEi1XN1LyH?=
 =?us-ascii?Q?gv1iTuKYy5fJmH6OEWDEmgnRDSRKpCLafYzl6S99DwdpM7UCuO8NyILNsbf5?=
 =?us-ascii?Q?CDpEEJDOkcQIEuT4Mtc5/SSq3dGRF3zk80wrEYjZryB4q7pD415Oq7Ww7Jl/?=
 =?us-ascii?Q?i/Rjdhmpdll3hfolely9C3LPbHdGaqjIbnL7YghbNtsHCbLwKYDnMnhK69Tf?=
 =?us-ascii?Q?KO8hSVG/VyUZ1lP1f6fSpgrzF58I+XOXlk0e6Hx8hAvruQk91GB3VFTCoGm5?=
 =?us-ascii?Q?Q259XC8a98UPWR5cFsNvCwV/WpM9NlgM7Oq3ueSZ7wyOY2k6UA9irbhEyIG1?=
 =?us-ascii?Q?+ecYDuAIxvsdoVTmj8Ao0qJFPN/2Ka8mCUisAo28oDFfQdYBTGzB9PrGN7Jg?=
 =?us-ascii?Q?DP1TBnsV0ARSPtFum8JcPFdKcTGZYvOB4jjmjoyjC9aca+g3HpoLAS9UnTwu?=
 =?us-ascii?Q?PXZExY5/0Zv6WmR44X7l/NHU/FStXLvycFxIiFceeyklN1pFbHX4eau5YEs8?=
 =?us-ascii?Q?R5YLcII2op+bNstbjeDwY9IwtBe5HPDfgyBJQPLEfvmgv/HBkpSrrV9fE7+5?=
 =?us-ascii?Q?UYkoBVRNbt0I1bp4RVgThszUuqN2duuHrhawzRZcji1TRC2k1uCaA80R8eYm?=
 =?us-ascii?Q?00Cjmsb8XgXl0ocU2745wa+wIoLVbDMq9dxMUIv89UIpRxiEbhfOxB1RYXf8?=
 =?us-ascii?Q?VBgYgSOQCR2PCz9TfvgLiAJAJgvJMwf32wy2ASNr29VnHbkRh//J7iN/S0vq?=
 =?us-ascii?Q?QZd5FmL5R6Db8gJLgJRFBG1tEf8iYcNaUf6cW8hifPnLxkFstXvhGWyB0LyA?=
 =?us-ascii?Q?RqQrpLM56XKHCNMvbf0Erve+SQ3o4EUmO8Fm/YhbQyyVTDV00K2DaHAZxh8O?=
 =?us-ascii?Q?seDLHanHQOg80tLvWKrCLWKvP+yZOCB3N9HuSeXa83y3i38Fb9+5EOKicdtY?=
 =?us-ascii?Q?P6f9ZbPpqnA5am7359FKUVv7v/JTk3naxpHtJt754uJ4K8KZwmtxZTzNoPPH?=
 =?us-ascii?Q?cnPO+RHS4tsmEuTEh0c2odersILd9xFEMKadiYw4+M9A2ILiiQGyHYZzSbQO?=
 =?us-ascii?Q?8Xm+uJbIcXFd/L5BlLPG5UP4G/Iyo+UvB4wHaqSsR+jWvknsujMJwUXG1rWp?=
 =?us-ascii?Q?3fF2gO+uio5pQM9/QPhaU70AvLQxtc5RLJE3PfCBqcuOIwnpTu+SLZRzqwrI?=
 =?us-ascii?Q?L1uUlqNGeAHLjf9xVZ+hxWRmmbLHDnagCXivznIlAp3F4SwlnwjKqcGghR6H?=
 =?us-ascii?Q?Y/aWLcNIz9TSJiwATtz7et9u8p4Rb7mskksYUm6MWPlqdhYfEGZiOAqLmHJv?=
 =?us-ascii?Q?PN+E1szSM9hHaEmljAxGIJZzXfGKvw3f6jVtdqXGCK8dCvSczdtQLpBh7xA8?=
 =?us-ascii?Q?2mA+e70HJbA9JN2WKxfsZmVxJ8RK7ySnsHpAFNnKgkqGPBxhcMmf8OfiZD95?=
 =?us-ascii?Q?jR+tOueCXGdy++OgEpmsA2eq/2lAkfZ6glNZUiqEEUAaA/rZi4iohWUxKOgT?=
 =?us-ascii?Q?KMm8QjXOvGL92sLI90e8M+ZA9kU35hN/ArRek+cRrMZOuoJMyKOu/x6Ks/PG?=
 =?us-ascii?Q?brnjngvzIw8M2cujoqIgbi0vqd4jjmsKwAy+1HQvzTp7n4Q0Za2Nnkm+53Fi?=
 =?us-ascii?Q?Yr08Qutd24RX8Qb3ETJqhE6z8E/F4uT8X8ButFJPC5c5MvZ2rdjkgrSMIrLh?=
 =?us-ascii?Q?TFFYHaTOvX9JzX2PuMgsXDJ0ZdeaB6bU2cllCt+TWW7jsHycMVR4V/o64Nq+?=
 =?us-ascii?Q?r8MYh5rXzg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2990219f-687a-4184-0f84-08df0373ff8e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:14:45.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmnMi60PTjVGeTf0tGe6jQboG2EWBZ+kneM3X7eFLEnu8IrknVmODBTK9ND8lat08PHzBIy0XHuIcEv90FWicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5866

Add btf_module_names and nr_btf_module_names fields to
bpf_object_open_opts to support selective kernel module BTF loading.

With btf_module_names:
- when provided, only the specified kernel module BTFs are loaded;
- when an empty list is provided, no module BTFs are loaded;
- when NULL, all module BTFs are loaded as before.

This avoids unnecessary module BTF loading and reduces BPF object
loading time when only a subset of kernel module BTFs is needed.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/lib/bpf/libbpf.c | 113 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  24 ++++++++-
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514e4e9daa82..1f061f4873b5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -779,6 +779,9 @@ struct bpf_object {
 	char *token_path;
 	int token_fd;
 
+	char **btf_module_names;
+	size_t nr_btf_module_names;
+
 	char path[];
 };
 
@@ -5803,6 +5806,99 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	return 0;
 }
 
+static void bpf_object_free_btf_module_names(struct bpf_object *obj)
+{
+	size_t i;
+
+	if (!obj->btf_module_names)
+		return;
+
+	for (i = 0; i < obj->nr_btf_module_names; i++)
+		zfree(&obj->btf_module_names[i]);
+	zfree(&obj->btf_module_names);
+	obj->nr_btf_module_names = 0;
+}
+
+static int bpf_object_init_btf_module_names(struct bpf_object *obj,
+					    const struct bpf_object_open_opts *opts)
+{
+	const char **names;
+	size_t i, j, cnt;
+	int err;
+
+	names = OPTS_GET(opts, btf_module_names, NULL);
+	if (!names)
+		return 0;
+
+	cnt = OPTS_GET(opts, nr_btf_module_names, 0);
+
+	/*
+	 * Allocate one entry for an empty list to distinguish it from the
+	 * default behavior.
+	 */
+	obj->btf_module_names = calloc(cnt ?: 1,
+				       sizeof(*obj->btf_module_names));
+	if (!obj->btf_module_names)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt; i++) {
+		if (!names[i] || !names[i][0]) {
+			pr_warn("invalid kernel module BTF name at index %zu\n", i);
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		for (j = 0; j < i; j++) {
+			if (strcmp(obj->btf_module_names[j], names[i]) == 0) {
+				pr_warn("duplicate kernel module BTF name '%s'\n",
+					names[i]);
+				err = -EINVAL;
+				goto err_out;
+			}
+		}
+
+		obj->btf_module_names[i] = strdup(names[i]);
+		if (!obj->btf_module_names[i]) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		obj->nr_btf_module_names++;
+	}
+	return 0;
+
+err_out:
+	bpf_object_free_btf_module_names(obj);
+	return err;
+}
+
+static bool is_module_btf_needed(const struct bpf_object *obj, const char *name)
+{
+	size_t i;
+
+	if (!obj->btf_module_names)
+		return true;
+
+	for (i = 0; i < obj->nr_btf_module_names; i++) {
+		if (strcmp(obj->btf_module_names[i], name) == 0)
+			return true;
+	}
+
+	pr_debug("skipping module BTF '%s', not in btf_module_names\n", name);
+	return false;
+}
+
+static bool no_module_btfs_needed(const struct bpf_object *obj)
+{
+	return obj->btf_module_names && !obj->nr_btf_module_names;
+}
+
+static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
+{
+	return obj->btf_module_names &&
+	       obj->nr_btf_module_names == obj->btf_module_cnt;
+}
+
 static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
@@ -5825,6 +5921,9 @@ static int load_module_btfs(struct bpf_object *obj)
 	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
+	if (no_module_btfs_needed(obj))
+		return 0;
+
 	while (true) {
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
@@ -5867,6 +5966,11 @@ static int load_module_btfs(struct bpf_object *obj)
 			continue;
 		}
 
+		if (!is_module_btf_needed(obj, name)) {
+			close(fd);
+			continue;
+		}
+
 		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
 		err = libbpf_get_error(btf);
 		if (err) {
@@ -5891,6 +5995,9 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (all_needed_module_btfs_loaded(obj))
+			break;
 	}
 
 	if (err) {
@@ -8508,6 +8615,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		}
 	}
 
+	err = bpf_object_init_btf_module_names(obj, opts);
+	if (err)
+		goto out;
+
 	err = bpf_object__elf_init(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
@@ -9629,6 +9740,8 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	bpf_object_free_btf_module_names(obj);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..b8c1d98d69d8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -224,10 +224,32 @@ struct bpf_object_open_opts {
 	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
 	 */
 	const char *bpf_token_path;
+	/*
+	 * Optional list of kernel module names whose BTFs should be loaded.
+	 * nr_btf_module_names specifies the number of entries in
+	 * btf_module_names.
+	 *
+	 * With btf_module_names:
+	 * - when provided, only the BTFs of the specified modules are loaded;
+	 * - when an empty list is provided, no module BTFs are loaded;
+	 * - when NULL, all module BTFs are loaded as before.
+	 *
+	 * The list must not contain duplicate entries; otherwise -EINVAL is
+	 * returned.
+	 *
+	 * This affects:
+	 * - BPF CO-RE relocations against types defined in modules;
+	 * - BTF-based resolution of function attach targets for
+	 *   fentry/fexit/fmod_ret/freplace/LSM programs;
+	 * - struct_ops kernel type resolution;
+	 * - extern (ksym) resolution for kernel symbols defined in modules.
+	 */
+	const char **btf_module_names;
+	size_t nr_btf_module_names;
 
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field bpf_token_path
+#define bpf_object_open_opts__last_field nr_btf_module_names
 
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
-- 
2.34.1

