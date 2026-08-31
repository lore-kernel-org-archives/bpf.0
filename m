Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A248D896
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183508; cv=fail; b=RZvyCWF1DkPixt1Y7qdBRRZyRMlbcTFxdaIXGRP9uRXrpaJaTLRahiNdxEdqvBk+UP+p6QBhjTjOH4HhLM7h0nhgRW9GJS8lU1J7jqsA/cCXrBg1PqiGyDTyyB7x39kEAcwHT2OafNOTondH0Xsy3WjoawHnQ3zFnqaupz+py7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183508; c=relaxed/simple;
	bh=ivuD32KOmhyeaAjy9T0hpIYwGsJk2JJmqXHCx4ttJMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxrfySj4K05KeAB6K/KgK1uFi5fqTAwVUHUpEJlahQ1q/DSsH8h758ebokAnLYCsjiZXCmn5lKGE3TuskD6vu7BKgQmNqcBsosflzFkCRC5g8cwoCxWAXc0SFzkhrO5QPaQpkIV5c7BTa9A5HMGcVDDwagjXc69Ym2rPLb/Z4t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N4e3qnkt; arc=fail smtp.client-ip=52.101.127.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N4e3qnkt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQZHrDFiO6SFPGqYzAau8h1d50JEngW3yOwRr6FzJj89nAmpX9+TmGLbqD0fz9B4Nq60YXWow20J9JaeINks5n1nF4EafKCxNiWHXhS7WFWsz0WlhKYnbQIcEzs9659WkUZNtYsQBKyOS7pj6nqsxLCFjRFiDd+PKTtLQ82Gj+avaFAllql18Ie0dIcOe/xZG0kd7hgC7lRHmlXtfkY8B2JbSR2fIxUp80imE+LCVyli30g55yfT6zSLDP1jPsez1P2Kb2P3m1+UAeEywWpasljco1sobHV4FHljsXEn4DkjB0nb/cc6Sqwph78mAB3Y+l7Qn3fLSm0oCMS8ZNKQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CkrW4Zn6N+2qA9/+ZEDEWymn4f8iis15sD0cUZBqNo=;
 b=CRc+OZ5uMspBSLoUbi7aFiisk3p7q4hHBvDsB5a0rztEcGN4Db02LcCi8ok0O78mUmUBptAv0eVqWE2pNBgX8L7djHqpcJ/MGuoqE+rTNJ5hBEGhzGi5oYUM8KChlqFux2NVvdChvavxu90qwfclZdfUexqKN+mLTSUot8PSSdBT/spWrWDm4MdmEftG/QFIEWwRdwkM9Flz9FT7N0obATBJRekhrjnAWjQ69x9j5pGOt9WUP/B0dBe4CWA72xXxf3ehxbqjWQPvddAxhBascbGf9L9bxEibGTnVpvDXMcH5O6DQClkJocR91bHgbkrvCUApLFD4wRmJFaoRPpBxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CkrW4Zn6N+2qA9/+ZEDEWymn4f8iis15sD0cUZBqNo=;
 b=N4e3qnktM3HXowZTDWvthbTwQgNGq9TwPDE5dE96hh5R1y04jrGu5xFLMRpvsQSeee7EZLyUQaVxZSEKeiBSKOZq2LxkLP+ziPZ/ChoRli1ZMc52RnEPv3K59arkORMjCYZgX9+vNLnsE8X1aNVoVbX3BvMhjBHRFDwfV6BD17+0p1QdODdz0aozDrUUbQQ/Ehz2atHTOsQHOdd9avnhTHHaPFvOeB4eA4J1kPaekMqYK9YzXnZpGnjvXcA3Vyvjn1umZXa58aM2lhP5ObaTnxt5siAY9JgybnwJsFz2CZgzOyHSdYg+WkTfulBTjZ+GSPOmMq5AKkudP8u7rpHvtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYNPR06MB9224.apcprd06.prod.outlook.com (2603:1096:405:3d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:38:21 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:38:21 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
Date: Mon, 31 Aug 2026 21:38:08 +0800
Message-Id: <20260831133809.1161-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831133809.1161-1-zhaofuyu@vivo.com>
References: <20260831133809.1161-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYNPR06MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 43532224-0cf7-46d4-b4db-08df07651f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WmdbyA/CZs969k2WkQzPYSYexOsACg3MNjALNbrv8hcc1z/LfYZbFTeJaIIPx6Wjl08FCyngJZNFR0UJHVcTIsylxTnHiK/vyRe+8sTVnKcWuHrWEsT9g0BHLcQ14+BRAJ0NrjDGMWHYGgj1hDmPqZxBCUQUy1OJrMnMkbyyFntDMX05yW2b0p/ACZx+JnGIN0PKctzBMqpx3fhlk6ZjL2eNiDRvGidUmCBVrYpe/hOX0UBbvPcglZHQ16XnPjbTPlUEjAcP636CHssVktpVrpN766lmqR92b7ENgAAfQLwcsXMFYn8n1d2U3EdPK3WNl6Sj59Mq1lMm2pW7G4P2mYzYKqfvhrxJ8Jer8NRrcYCX7X14PpVjUFn1GXAQinh9rzJEa5uSYrU/SsiIOwR2tOwVGmFZFOr/8qVEXLX5nzrs20pdBWbsrtg+5g0FPdXI6xPLB7yIH8epaPmzXC+TC8LgjGj2F3WpJ6DcknT3cPEAj2Fz/5R1Hxid2WoUjjm7Yr8/2XAWn6TVjvp4z5WYztQ5nS1L6GYh9h2TjPI3PAkfH+Bjfr31d49eIO8zU+J79kYjd9VWNDpJCGQ2TeE33swjPoc4t/ppCI6sDOdLilyt9J1D7+Ozl8Xbr//ynJ1D2tbxehfO96/uiY7wbMqw1JoofFl+wQ5fKf1fr+UAP2p9tVwM608qH25z5efYIiD2HtxOsvjzGyIPTwA5i59h5aeIS7/7cU+mKPj6Iv38MR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Za28DqSqmXDzOp8gsUF9cnrW3sW+1F7FNQP/qUre6BQDlx0As/VrjAvFJdyh?=
 =?us-ascii?Q?rL6H4crJYPhrlwRRsL5ocKSbSzshG8PxwLMNsUp9/FbBypZvNsQzl3mP71ed?=
 =?us-ascii?Q?LX55NuseKvfB5AZtMheMcUXyunbf5j87fRJmx4yRbuTzKmcoFskpXGoXeqIL?=
 =?us-ascii?Q?nCEOgB89MYoJAXqGA9WeIpfIQPXy9eMHzgxCTxKIRQ4j36e0+ZnHDHRA8wFY?=
 =?us-ascii?Q?7KB4kJbYLttgd/plIg2NAB/V3DzqOtD/njl7K7gUzgyJN+OJsRqntbnltXkE?=
 =?us-ascii?Q?djltFexKWONw8+Fts+49OKQlKqpLlGblvh/5p5JWyyZ1qV/KFHNqHqiIJfgF?=
 =?us-ascii?Q?O5mByagaEZMLviRfXR4I433ShTSPsmNyQoxUfMnln+2TfSmoA/t5bNwZsaiU?=
 =?us-ascii?Q?N77mIMb7YmIIY5Df6PQL/p/CfL61lAP8DPKaFBKj+THhV37OBmNdG/IBq1YC?=
 =?us-ascii?Q?v7lEeCF7P6KU83FL1aNuGX3RtTqOGXtYqCa5NYoMNDLWc5RB5IvEgcbJWzJt?=
 =?us-ascii?Q?wRlUhRU8XfGFs0RwuHXYA4iCSLmOQECf8Cpy8GoqVWK6fg0wLlKYg64/QvHB?=
 =?us-ascii?Q?qWalbg0gCAf4MaXSfqiYDjjpmOxHNDn1BLRT5cyeQcUm/HfYH71G3oH8vNXy?=
 =?us-ascii?Q?tRJZgAEbGlVR3e+pivJBTb9j+Oljm4NvqSVMBRGPBkJa97q4aBq/GKvOktvs?=
 =?us-ascii?Q?EFmrgdM3XjvoGlHJCVyqp0IcGzPFQxeNOw/AMnbMrW4LBkfq9iA+wkntB8Dc?=
 =?us-ascii?Q?UCU1Ror4A+9u2Wv7cK/nxv9JlVSBcd2ut3xqGm5IT0lxv7YnJfhW2B+zk1/L?=
 =?us-ascii?Q?AxzoGggQrTEFZTt7lEFBB68EmUSK4OouXrFm6PAXI0pR16zR+obiNhWQ8gxM?=
 =?us-ascii?Q?tsWHBv/1CBIn96rEHiHr/IC8DA8gHQOAx5Hp6eVELol4535gdDgHOTzT9O9z?=
 =?us-ascii?Q?e4JvGzJjZUw3iD1VHQF8Up9uNd0MaTVUyAVTuYE5GGdoDmn07Ff1dHvYH8g9?=
 =?us-ascii?Q?O/K3orz4KVzBo+I6ihw5abl0/XFCydIHfy+VpWN13vgdZ2Dhf75UWTY+qvJY?=
 =?us-ascii?Q?0nvTGZ1kg06TWokqDySMjWhMVpXbNvGAqQQfCCNi+4A1ZtAHM9Qp17CnXXat?=
 =?us-ascii?Q?ZQoG5z0T2wRW2XA5KW0d1QEUs/keb/G2GaiJ/2dwh0oS1kjNx8hyYS5JClcy?=
 =?us-ascii?Q?TSc1pm8bth+atU+nYh1/XxtujeUDFCgwJl1gKDpTlOMitewAEBXURFTDQRRH?=
 =?us-ascii?Q?/dGDfzFuIW0JmGhI9zX0jokyjHVs2mnkgqkI9iHizMw7mgEK6rsfq5ZGq7RB?=
 =?us-ascii?Q?8TNbsxjgTJZU5Xw1UxSItq0f9/d+yQx6MwEOSslS1e1Satze9D74FJ8p3g1X?=
 =?us-ascii?Q?ZqvjgzXF8LevfHVaKSLh3GI4/OB2cN+GBX6HsAlaDLzaHZedE+gHGs0Zsrc4?=
 =?us-ascii?Q?1g9pMF0AGDFf7P/Clu0OvDc+md/mgW9gl8ZA6PmHJcwL71u3TkZLlT9L6ZI2?=
 =?us-ascii?Q?5NM6h26RXCTGYVCcEITncEQ+ERsm+PmCRIhbZ302F9vx9DfXwlzWivDUc0GM?=
 =?us-ascii?Q?4nK4L0TYrPxFw5bycOYj/C7JQHQ2SRFZ06rC6bHxqxcfhpsRwJm7ageRo/C4?=
 =?us-ascii?Q?HC8RgTTaXNQD9nIvCMClhV9VjSNpZbpb+KSJWeukMrCQHLhTdjEW/9HDmZJz?=
 =?us-ascii?Q?Wh8OoQ9/Of//QKBMhyC5wlk6Kz4+L0h/a15Sp5ITsii3YzLdwBbLeiEWp3wd?=
 =?us-ascii?Q?unZgkur0/w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43532224-0cf7-46d4-b4db-08df07651f77
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:38:21.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZFyox3z9wH3beFqxJJ8T9kDEj1CemcyxA4maed2g/gDf+yWGI5woI/Cylfrh9D/8gOlvZRgPj4zUIKQngIiHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9224

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
 tools/lib/bpf/libbpf.c | 117 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  24 ++++++++-
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514e4e9daa82..e19d0afd2592 100644
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
 
@@ -5803,6 +5806,103 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
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
+		/*
+		 * The list is expected to be small, so a simple nested scan is
+		 * sufficient for duplicate detection.
+		 */
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
@@ -5825,6 +5925,9 @@ static int load_module_btfs(struct bpf_object *obj)
 	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
+	if (no_module_btfs_needed(obj))
+		return 0;
+
 	while (true) {
 		err = bpf_btf_get_next_id(id, &id);
 		if (err && errno == ENOENT)
@@ -5867,6 +5970,11 @@ static int load_module_btfs(struct bpf_object *obj)
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
@@ -5891,6 +5999,9 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (all_needed_module_btfs_loaded(obj))
+			break;
 	}
 
 	if (err) {
@@ -8508,6 +8619,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		}
 	}
 
+	err = bpf_object_init_btf_module_names(obj, opts);
+	if (err)
+		goto out;
+
 	err = bpf_object__elf_init(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
@@ -9629,6 +9744,8 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	bpf_object_free_btf_module_names(obj);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..1cabf7e46554 100644
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
+	 * The list must contain valid, non-empty module names and must not
+	 * contain duplicate entries; otherwise -EINVAL is returned.
+	 *
+	 * This affects:
+	 * - BPF CO-RE relocations against types defined in modules;
+	 * - BTF-based resolution of attach targets;
+	 * - module-qualified tracing multi-attach targets;
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

