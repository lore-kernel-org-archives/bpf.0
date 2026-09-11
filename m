Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2202BE7AB
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128523; cv=fail; b=fGNWvvJGFl2lcXbiXZ/uvSIZQUrU+mYYpVDEYzPEu09Hywo/w3RdAiOImQb2QNFVwFjKgkb43P6BtDfmO6aDu7Dc1+geFAG0uaJDuO1XMcYC39hLn5V5Wzj6uOgJAYWZREHY2YYqC0ov/vwWMUiaCSudam2OnyI0ZqTOeBRuDi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128523; c=relaxed/simple;
	bh=v9Iy5Nf+fFyidZxqsMAhSKyB4U5c1ImcXITshswxClw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9RLaC2Ui2L1TDP6b+nlML1nAERwynpyHBsK4/cm6aSWX9e54m9MlLo/UcevulaS6Z/8/oa9ZlTHCL9Coa980qi6rMmf20Lk+i3S/DdZmowAo6j5+vOFf4q3uN8UFo4T2DkCZrIjswUvme+3MMKB41Bly/78PKFL5Wcp7m9BM0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WGyp0nAi; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WGyp0nAi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLAClkgE5ku6kIGVmV+pCU0v4OxQdmr8J4AUOcO73sZ7tERsKqkx3ns+30+VVD95sxkYVMHRIk4icpoc70U+vJROjh9+qvpegjAROkZLVQHKDSdAcQIqcd4WSnnrpsEDltu8m7CPJIw3xZjt0KE98XqvIdJx6wvTDgODFJyam9+0b4VGAtynyTJlNeKp1OqtXzkIjGEO9nl2KvGhWXn/+SHzKiXdvIQrrBbZ3GksXiD4wi5uKhOMB5KnKhMrbeNqg1OWWNfpWwPSCeqiuw//N0sjy5U/FIr4wMcoHkm3mZVATPFLh6o46INMEVygKkOH4bdRjxbcy81xQ9znVdAM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wCCD1mndzE1/rCubY0JbQTQghJplfIkLhZECJUdqns=;
 b=T2BP7BunyLmU/FH2vAPnqv2PS6eewMzL9aEp2/baZQEEv1uPMMXoICUAnoDGZKXrbdnU3WoMsNCEDNaDzYH5blM2YmezNj4faq6ICATkTVfEQOj3dXKkhjdLQrqAGk5D81rN2it0ddtYJoL3jnO2m32lEOS16AkCb9MtWEVQOWsnq7X2t3AVXHqFeTnwPdAJNbNybnsLwcRbUSbJB91chj68tq+s+Rv8FzjETOBA6OsbdTkV9VH+mXTgUJs3M3FaHfVV2zviqU/6NZjHrxgw6NMdQv6Ph8H8oLYp0lV63+7cTPNuTk4pekqDbEw6+GGifJK4+qTtwPwi5ChwDCqi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wCCD1mndzE1/rCubY0JbQTQghJplfIkLhZECJUdqns=;
 b=WGyp0nAiWCZ147hyDjvXJy/U8pMKcd33oaxr+W0NbXpkceoNb/zbQ18ll8xS0zkKNc/QNcefzkDA5cJ5XqIWQY4TH/CC9qB7VqAn+RqAOBHNw0WMqfWP7sECTWjH1HeSaGX33PJXnX9Jv1//GFBH5DpfQ40pNO+/86AZEIlPYE40h6hG47pviDq3swubYTPi8mVUYGJ/V50drvCtHcKnuafOF5Py3O6I31IFn+JrqyYHxOrdIizwzEIWMyJv+OZYZD8tETgMUGel+NK4rqHRx8SfVj+Kbqcb/xKaJpQRrVWxwX64ArFyoydGS/+rUOJmLhgKXftEzin5xPx+OdiOHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB6755.apcprd06.prod.outlook.com (2603:1096:101:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:08:32 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 12:08:32 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	Fuyu Zhao <zhaofuyu@vivo.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v8 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
Date: Fri, 11 Sep 2026 20:08:19 +0800
Message-Id: <20260911120820.46900-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911120820.46900-1-zhaofuyu@vivo.com>
References: <20260911120820.46900-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEYPR06MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c7b0c2-0baf-4aa3-0130-08df0ffd65cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|52116014|6133799003|18002099003|22082099003|56012099006|3023799007|11063799006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	MBE10fLZkalNPJy7tkKLYASYvQnjGT7jZW0Vurg35DjBNBLIVZiNmdXLtB8tx9SBepSCjqq5Trt8m3o3OyV5sjrOWsdRtcETVDFyBxgG+K1re+GAJbgmt1cRvQT2lJ9y/1gx1ikfBxzVih3pK/dC1Hwu+hTDYRMb0Odj49v6i0O/yQfnEgnPhskeejQyDSDls7TJHrFPWvpzc+5+j8aTHpKg1u0uMpiRtq99FVmf7oQayEBxOgD8osHD8x0/4zTA+YZtPP6A7Srb5Npu1WAz6yk+emcMRpd5n5pZWt2s4Ju+qh2LBLGNnCbputiLjQxKOd8sCjvYfBofHLxDXVfggviRbp9CbNVgQRpI0WejxXVoeXkw74XseTDbouA5BakZjrX4KSy6HoUH9T+opet9vHu1/JjFUYIUF5kK6HrNjdZhf24hW6ywthtcq7PEJPc66nkUPemlfbleO8zRtZhCuXlAavWhnMN3RBLv0euWNH0Ns8qMLf/hrY5k7qo4yA+o8/PVJkqu22yPR+izkwv7pP178sIWgAVZh2SazUogYNB3UcDM3AKcShRWIjXXA6T+1cbZeelqLvRRVDS5J3VKJxmgQ9aV7iKnk2fnVW/h3rBxRyYfdbHvA6R3VnE9o5i9lXyKM1p7x9EvPWog8Z6wvH4x4WXlqfVB8C48bpXSoKzuuIeDyb5j/DUJMyb6xyKl79AMXtAGlcoCcgsCASBa6mqdaHkPRMGHjRY0E6jMJsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(52116014)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCRXg97dpKJfZzQjTv69Qc50BQYkx4SNMMCsh3qiuWqnjey/t3eJs4yt73VP?=
 =?us-ascii?Q?4fsK1T835paP7RttWd0jLQmqXCOI2F1j6iWypnK7ED84aCslUE+4ejNVfUdx?=
 =?us-ascii?Q?aVI9Tlxh393xWjpQg0a+1Q1D+2SDd3LjLUaYbfJtLPCJnoYB/KZqlF+BK+Bj?=
 =?us-ascii?Q?ffp1JKXtgRcyOuKliid5RGSKH4vJSBIjbEngkbmaazgtu7I+9oPwpoRx/ZQu?=
 =?us-ascii?Q?EJpoL3Louud4jivU4Z04HniOzlUkF8z57zxBnPrbpgttwS0phj8VNa/WwpGu?=
 =?us-ascii?Q?llLjgXfDWbdHQYaA0Pvcyoxyyx4jc7Ilc3LqvsFBNqi0QRZOBXLFmxWURvRL?=
 =?us-ascii?Q?BXCStA+JIcExBiSPjiHb7nfZ+IhW3JvIoEMtYdadoW+CDwgkRUo5pZ9LW64J?=
 =?us-ascii?Q?CG5G+bs+KayBeXGzs+0JvDD7ZjsVCE0AXmDfCe/do3DRMzczz9la7TDZQ5Mz?=
 =?us-ascii?Q?X1Kl/aqns6v2EUQJahEH3FHdkO+kAYGX4iTIAzT36bjNOxhSD7tQhna8c4UP?=
 =?us-ascii?Q?sxHk5d+1HhhbgcV8TcJJWvtfiYK073cuIIjXpS1Yqs21bD4MBVci6jmjit5j?=
 =?us-ascii?Q?lmS/PUemgDEgFa+h1uWSDck+pfAGJp7KRzD9P6iLszwW62k2dksnzy1Yedi4?=
 =?us-ascii?Q?BOjwU+9S6uD0Nom8oc1lnLjuMNPW/Y0Obn+tH2ZyovuFCxlS9wIxhvl+2m3t?=
 =?us-ascii?Q?vvg86geCQxJcvyWRT1Ra+VReVNJ/AyU9YJODDn1E0xrGsWGZ660th8HycfSY?=
 =?us-ascii?Q?UBlCsxHYrk5HtCSwpRl2lDfKAo4LLIw7Fnev7G+3OgejLU8KuZg3izsThea+?=
 =?us-ascii?Q?hcN46k77Yk1TzA6aKNreejWTylBsavFs1zFIOa+zuQhNbnT7++xrndMzAoz3?=
 =?us-ascii?Q?BbIL5ARzXzbPD3k88exlACkhqcDqeoXGmazwwatxE8uJm/N5+JMCUC0IyXUD?=
 =?us-ascii?Q?sFK3qS+wQG+9Cl1xYAPtBREYDt9L6fp5TFDf42rK9n/UrkrC/TX059gFch70?=
 =?us-ascii?Q?0WmUbzZ/0R4UEqBrzyitwZiYJp8C4oirUTNI8hSwCr5/BN/WZiKWQFyxszuA?=
 =?us-ascii?Q?O7HRKJ9RumB742bHB6spEt7o4ixk6Av0WZDxGvsTjwooIiE28ane3K5GNFW5?=
 =?us-ascii?Q?ig1VJsesZWfHpZUNqeQhjk6wpZ6mbDyEBqnsvRElOxZdw6S6OrXdmcg2PzHR?=
 =?us-ascii?Q?xRZSUhWe1PjwbDCc0HKwufwjLGt2D4OKf35SZYtQswu+K+g/qUpCxfETQPZv?=
 =?us-ascii?Q?tP5ewtRH2qsHLeGvTCK1jNkzylML8thxQdCsbATGABUsf/WZtM5E/cRl6ByU?=
 =?us-ascii?Q?MiW1V9e8FMKWTihcY0k+nwn4tJ97NN1tPN7LM5Y/tt7F+MzyMvgwlzS+EZNw?=
 =?us-ascii?Q?zD8dCplMS82CToUgGPFqXzDVf/MDN7qY7GQrUsNMriqlgdoAbS+fka+vWKHi?=
 =?us-ascii?Q?h2h0YFemFxJhBSPpQrAJP71kcaDE94yH9+79hV7BQGTn3A8R4Kzt3HNta1r6?=
 =?us-ascii?Q?fUsBfUfuUKTlAZSJ3/fDXEzpu0dC3Prn+wlCa0jGAliH5x+w0exT5996sk9w?=
 =?us-ascii?Q?8OyQK/THA5hn4vBUphLThvzckPmZxZvmnW47yeVJuTppoI4+WvZ+pnbgNp3v?=
 =?us-ascii?Q?laQTjvjUfYs5t5eISE6fMqscQrs4+4Br3IkKHYnTBB9Zt+Wtz4GX3yE2CdJ4?=
 =?us-ascii?Q?jS6Pg5zQ+LMSVZU17dXHgsz9xkK+eRf0ET8NmLOPbek79qJD6VJ4EEJQR+Pc?=
 =?us-ascii?Q?/0X/qrLRAw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c7b0c2-0baf-4aa3-0130-08df0ffd65cf
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:08:32.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0Lz64br2952GyQ5HWixekxfgP0AFLAMhHuwPlpsSnmRoyYefeUxq+yo6t4NH8Dz45UDfjBhvEeO/CGnEPRQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6755

Add btf_module_allowlist and btf_module_allowlist_cnt fields to
bpf_object_open_opts to limit which kernel module BTFs libbpf is
allowed to load.

When the option is not specified, the existing behavior remains
unchanged. An explicitly specified empty allowlist prevents libbpf from
consulting any kernel module BTFs.

The allowlist limits which kernel module BTFs libbpf will consult
wherever module BTF might be needed.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/lib/bpf/libbpf.c | 72 +++++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h | 16 +++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c036e8a91ed8..4ab7ddc3b4cc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -751,6 +751,8 @@ struct bpf_object {
 	bool btf_modules_loaded;
 	size_t btf_module_cnt;
 	size_t btf_module_cap;
+	char **btf_module_allowlist;
+	int btf_module_allowlist_cnt;
 
 	/* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_LOAD commands */
 	char *log_buf;
@@ -5851,6 +5853,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	return 0;
 }
 
+static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
+{
+	int i;
+
+	if (obj->btf_module_allowlist_cnt < 0)
+		return true;
+
+	for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
+		if (strcmp(obj->btf_module_allowlist[i], name) == 0)
+			return true;
+	}
+
+	return false;
+}
+
 static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
@@ -5873,6 +5890,9 @@ static int load_module_btfs(struct bpf_object *obj)
 	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
+	if (obj->btf_module_allowlist_cnt == 0)
+		return 0;
+
 	while (true) {
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
@@ -5915,6 +5935,11 @@ static int load_module_btfs(struct bpf_object *obj)
 			continue;
 		}
 
+		if (!is_btf_mod_allowed(obj, name)) {
+			close(fd);
+			continue;
+		}
+
 		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
 		err = libbpf_get_error(btf);
 		if (err) {
@@ -5939,6 +5964,9 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
+			break;
 	}
 
 	if (err) {
@@ -8481,8 +8509,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 					  const struct bpf_object_open_opts *opts)
 {
 	const char *kconfig, *btf_tmp_path, *token_path;
+	const char **mod_allow;
+	int mod_allow_cnt;
 	struct bpf_object *obj;
-	int err;
+	int err, i, j;
 	char *log_buf;
 	size_t log_size;
 	__u32 log_level;
@@ -8525,6 +8555,22 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	if (token_path && strlen(token_path) >= PATH_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	mod_allow = OPTS_GET(opts, btf_module_allowlist, NULL);
+	mod_allow_cnt = OPTS_GET(opts, btf_module_allowlist_cnt, 0);
+
+	if ((!mod_allow && mod_allow_cnt > 0) || mod_allow_cnt < 0)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < mod_allow_cnt; i++) {
+		if (!mod_allow[i] || !mod_allow[i][0])
+			return ERR_PTR(-EINVAL);
+
+		for (j = 0; j < i; j++) {
+			if (strcmp(mod_allow[i], mod_allow[j]) == 0)
+				return ERR_PTR(-EINVAL);
+		}
+	}
+
 	obj = bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
 	if (IS_ERR(obj))
 		return obj;
@@ -8563,6 +8609,25 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		}
 	}
 
+	obj->btf_module_allowlist_cnt = mod_allow ? mod_allow_cnt : -1;
+	if (obj->btf_module_allowlist_cnt > 0) {
+		obj->btf_module_allowlist = calloc(obj->btf_module_allowlist_cnt,
+						   sizeof(*obj->btf_module_allowlist));
+		if (!obj->btf_module_allowlist) {
+			obj->btf_module_allowlist_cnt = 0;
+			err = -ENOMEM;
+			goto out;
+		}
+
+		for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
+			obj->btf_module_allowlist[i] = strdup(mod_allow[i]);
+			if (!obj->btf_module_allowlist[i]) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
 	err = bpf_object__elf_init(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
@@ -9626,6 +9691,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 void bpf_object__close(struct bpf_object *obj)
 {
 	size_t i;
+	int j;
 
 	if (IS_ERR_OR_NULL(obj))
 		return;
@@ -9684,6 +9750,10 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	for (j = 0; j < obj->btf_module_allowlist_cnt; j++)
+		zfree(&obj->btf_module_allowlist[j]);
+	zfree(&obj->btf_module_allowlist);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..b1602c769f3d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -224,10 +224,24 @@ struct bpf_object_open_opts {
 	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
 	 */
 	const char *bpf_token_path;
+	/*
+	 * Optional allowlist of kernel module names whose BTFs libbpf is
+	 * allowed to load. The allowlist limits which kernel module BTFs libbpf
+	 * will consult wherever module BTF might be needed.
+	 *
+	 * When the option is not specified, the existing behavior remains
+	 * unchanged. An explicitly specified empty list prevents libbpf from
+	 * consulting any kernel module BTFs.
+	 *
+	 * The list must contain valid, non-empty module names and must not
+	 * contain duplicate entries; otherwise -EINVAL is returned.
+	 */
+	const char **btf_module_allowlist;
+	int btf_module_allowlist_cnt;
 
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field bpf_token_path
+#define bpf_object_open_opts__last_field btf_module_allowlist_cnt
 
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
-- 
2.34.1

