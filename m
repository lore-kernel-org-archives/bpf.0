Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013024.outbound.protection.outlook.com [52.101.127.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB5041D21F;
	Mon, 24 Aug 2026 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576009; cv=fail; b=IYaJ82I4f/TRCMB9osFGX6xQnXe17DkeC1KMQnfKqU2vJsSKbKf79G3CvAHvB+X2hYCnJpUBrk8K8GxHDEIZud1PIbKHD4QGnV9p/LpObARBcpP3kZxHyV1m3PLToZAmLs6A5oSUaQ92PGFxAVIPddR8L2PPWGHDEyRlrmgCtFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576009; c=relaxed/simple;
	bh=HcEJ5TJcBEKftPm1NQSyEVCHvCG5RiTNeKMi38IeOsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tthP/D2B1y2QhiagnShLJnHUnbmKZsJSUoIMoeXbd3Sk9PoAqrg4rA+vr9mwibB6mdtzFWjhflcN61fBnwftA4rE0zE/Dfc14CiCH2jfEG+PtLRLvmReoDNGx86zUWXaQhnkz4KL/4XAijtTarKEn7VdJIEcfpmWt85r+6YK+gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JzdB+NAi; arc=fail smtp.client-ip=52.101.127.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JzdB+NAi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eueFXaOEqi+EQY/j5ddf1tUyeT39TE2GBfEpUf/VstWPf0T+NhOjdLP0onMhl0xeOalCHTdkBntSOjRqdOjCn29fQPSWECkQnc4ENulxNsd6+OyvDWWhCaXcYqp19nT+nE7v4zT6f4prUJPb3+8eqRwSJj8jWdOihlxncWpaY2TZfm0tHNgKJ2B9XPPlmeAZgoQnWLYKEvAWBn9tzGb27bMYVXYx8zEd+NfSF5jIO9wGiaxiLgUxb8EGRmHxyjWsX+yYKmCVjhcIYLUiqLKXT0KJJw5GQZifz/3WTChUCaTzBwCYvmOQo4dMjcGmePUGPcXC19f/ZJS/7HFLFnSHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTNBcVha9+HBhKVvdi8Y/2j9LT2Jj038vM06FcCD3jA=;
 b=GTegquX/PiwcaJ+qLqpZakBbh4/0KGH2fidOZO0dbGwyLwVR0e47YurFx7bez6X4ai1CZeXvQbY+NrPxllhStMxCfAs34p39n8tHLGgBljrGxndFlab78LsXHYOV5yFLcDxnZx64+B/eRcUnHn+fELWDK+pzGgzc6Aw1wHTdgMEN32ZkYT3VigvxSzjl9kG6C/7bQIN7J2Akpz9EFmSk/GonRYkrR+JmBWsRgFjSci7JJNT6jaH6KWV9TWke0QbfUX8/jfcoG4x9LpFERDwaO8S670SaGq6uRogB+y+yeDyjgDb13r8Osil23Do/HwJ/PAr/ORrYMHOPp6NoR25N8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTNBcVha9+HBhKVvdi8Y/2j9LT2Jj038vM06FcCD3jA=;
 b=JzdB+NAirWdAhls7L7EGqtdOCVMIgo2uFfLDhRzndz3olvDyHNEmcVJwzY31Ehp4a86j4tpgM2n2AV8w8sOo51rzEy4BTeB+4J7LZRbkeKTq3CoY273wvCH0D6o1tMx5izU+AE2zEliDCqjgLyOkUqpvDOwavBxaFknL7Ktf0rCGHrjpCVb30DNa0C6aCqnBoHkjHRuib8laTh0F8G+nJDdlvq53wBEG9tmVTigvG3jYlPm49g9jCDbPEUOg06M5QXRwwc2wyi4vQV6IuX1YBY/IQd2KFoNp7wf6TsKI67m3iFgQ4CqAjPMzRbFihRwFPdEeBu49PW8h9sa8a7h5tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY0PR06MB5210.apcprd06.prod.outlook.com (2603:1096:400:21c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:53:24 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:53:24 +0000
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
Subject: [PATCH bpf-next v4 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
Date: Mon, 24 Aug 2026 20:53:09 +0800
Message-Id: <20260824125310.1384-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824125310.1384-1-zhaofuyu@vivo.com>
References: <20260824125310.1384-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TY0PR06MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 2107d9ee-2be3-4b09-f1bc-08df01deaf44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|38350700014|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+gys0hJ7KB6Fjs8pOaLjqjaaUdV6e43AizONBZ9CAHqVMSxggRgAB2vx8fvgjrFkfJ0sPDtaUj1CFUuGRMtCQFCwJtL/QSoCIIbVxPn/JhEkMcg7cZgPwW8XcmMRENsnpa2uSCvywmqXeyFgDNDrO7HI27WnHqWnwXXUz+cNrp4MyRCXjzhLn4miYpCgkiIhuvWwCynFcX7q4eApvBiiZVdtSn3XIqMVh3IPlHKQDm5qrvAVMs8qVw2ZJguLVfU8LjcMcFyiEw+xmen6kJjek7pAPVANtXwlJ+UW8RCeHTYwOkyTqAfkUU3lKEcqKjjBwgWADCzFRBtwKRzCeXullW53NNOytHlnQ+Zm7Ih3jzRlVuXrtH+OnuGTQ+RL55yBaFJKQQ6FmIMFTGJNJnqMsms07nnvx1/l8uDLGHBE1R41aYHpkVCIlySv+/46L3OI0xoNu+y6fEog9yHojDeBNbb4cO5ovF34seZr2UPmSr+6Plf/WYedi+obykyPz+9Wt5UpmNnuVjPuqVBv+75lv1VBYKbvFXjmXmn5tdpij1JK0yEXplupRXuF3jX58ZVqg1/Gw+h3CY2P/34975Jc/k6mSgQyPBwVoFzFPUCAFh+YMhj6xsbY6x2uLov2MUwvrFXJ/K3PQjN7+4yVcR0Gh1YlowMdtf8UQxtI1C8/bd8sVvxZ7jeQ9wwcSAHjZixSFQDDEZDhjl3qdCLrDREJY2x2rzHz6UlGaweVDEtpwsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ioi7UdmruCUydDqQx8ThOaH5iU6y98hEivxkd06XGDbQLHjpQEvyoUd/T8VB?=
 =?us-ascii?Q?ddozZfc7RHEP4XlVIzh+5V9B3xui9+uCbX96uneq9w0pTOF1dCrPbR3Byh53?=
 =?us-ascii?Q?b45zA5gjOiYkxfqrc3E7K8Oz5JDWEQPfiLulyMmhAs8ksRDSliK8xMCK/OgW?=
 =?us-ascii?Q?Io1SCsWiUdliYEaOI3mTI8GL45Njt1tj5Ja5F0FE+3mHAZ5Ty7eSucFiIr23?=
 =?us-ascii?Q?mEDkvjbygDpnb46gzbtEcQUYepblfKjG3rslzd3qAX3VAXhCmzijBQEeu2M0?=
 =?us-ascii?Q?bDBfEeHTovSGVLSharYwuwYJU3gtf8vO0qFfwp133bGlFhrXc58XPoaTMhqa?=
 =?us-ascii?Q?xoS3ZaF7aOHCdwalZ3cS02u0arLiCerbJdP9hheA01nUXnWV8IpD2/kcrQQr?=
 =?us-ascii?Q?ybEy+MoRLk4bFpRNgaxoNWa881KTYNXsPQ/1EgHxjfGwMCwvvcvVkURZTP2b?=
 =?us-ascii?Q?DWM5XRyY9StqYTcqon6qu5diQymI/XRs2x9FXqg8Bkt39pqmjLB4g91p8rCP?=
 =?us-ascii?Q?0O7MSap63fF5L74sf5JMXZimiysK+A2ip8kE8QlCInoRYJdO09UVDf7FMlUO?=
 =?us-ascii?Q?u7MMG442vF03Q/3mE+yOrRs+xvKbiyBcs0JkkBWgRVsoHel7ykAmtHU3CYsM?=
 =?us-ascii?Q?uSBGisHB3BvME4HYYsqEpjPdcQMzd2Tuvj63GSVc1pfwrrpv2eFaxo4MWPBy?=
 =?us-ascii?Q?MkX7saebKZyZuSdE9xrw08rRfRVZ8zFEnndiiA9ZMVoUTkvs4OWH9+yMi3ht?=
 =?us-ascii?Q?Dzz22bYeR+QNZN8AlfWZliJev8mR+WT4Jyhw+i5/l8QJJaQWX1BoleZ2LytW?=
 =?us-ascii?Q?83mPc/XqsjYzAftBrx9Rqnw+PdDBcNUfwSN2KVJnfAIXXZ0IvSWOK4S7lS3b?=
 =?us-ascii?Q?pT0Yo+fBy3hgAFdFW3QPed3sus7fm6blkCYunHnhxT+YmEHcGwaYeQsJqyat?=
 =?us-ascii?Q?ct4unOPwHR+TmAAt2O2BdXGSTKjCpiU6bc6Ex1wIyq6mj2DG6c/lT6+4sg3Q?=
 =?us-ascii?Q?MDiDTsv8c7Tg5HDEJurKX1kP9BmT2lGh6Ly6Y94NneTHfMd5MpsFw2UoDZEG?=
 =?us-ascii?Q?E9DK5EUpfbib9e56hiIPSLfgAtzYswfSBnT1VcYgtU3ifObNY3R9LaK240f5?=
 =?us-ascii?Q?DJcdpCSyyEefy/AlQdvUDto5H7PjIVzZQ0qoYLlGLsrniw6VfvTId1+pIXTr?=
 =?us-ascii?Q?4L+0X5s+rYuRcutKnaWFJeCZmwpnft+xqCK5pul3aOpAZSGuwdrygzF3gPMv?=
 =?us-ascii?Q?i9Bgf2ZoXmphZly+8yrQnKnMQK/2vvjk0bw+YPyIJnJocmd7v9PCvs1PIfFt?=
 =?us-ascii?Q?g3Hh+cp03Qz2zEkHGXNv36GSlk80hZYWB8YcvvZEUICE5Xe1oPwrg/1f9dUX?=
 =?us-ascii?Q?SJTdUjbp3FhUUb5qP//z6fEMIdJw415irfAoXr0oxwisW61EmsYoLbB3pchv?=
 =?us-ascii?Q?YTJokF8yUUHOLzYuyKLZ7SDYiAaIsPiDNZf0rc+a+FIE0x7nfumQTPNobNLd?=
 =?us-ascii?Q?axCB8ucu0WdoOI+r8czQbPf2HSoqTjTBcVWRKZkiPxERpeSujTjjP4gM7uXn?=
 =?us-ascii?Q?y4bamqimkE5vlNoZ9zViEzLouJw/LjWl5xvW0TeX99zNHW0sgQ1ysq1kORvU?=
 =?us-ascii?Q?+ts+aFVNNc5TLgRI9LnWF3oT8xvR474A8p0Y2NxoCqaEgJKVVKj80BRTJYKn?=
 =?us-ascii?Q?lPcOVLCxzo1i1+NY1pVjbmJK9ru5+OcRCqntDxy5WkFEqbm43mGElrlcQb97?=
 =?us-ascii?Q?GZH1X6TvGg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2107d9ee-2be3-4b09-f1bc-08df01deaf44
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:53:24.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8WszRE9jRO6iT4/AEu/EK0BcIEHLKaqwVj3X9SsRMH6OcewW0tQvUOP+Rt3KlNIIGRjTljkvqj63pHLTNikpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5210

Add btf_module_names and nr_btf_module_names fields to
bpf_object_open_opts to support selective kernel module BTF loading.

When btf_module_names is provided, libbpf loads BTFs only for the
specified kernel modules and skips other module BTFs. If
btf_module_names is NULL, all module BTFs are loaded as before.

This avoids unnecessary module BTF loading and reduces BPF object
loading time when only a subset of kernel module BTFs is needed.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/lib/bpf/libbpf.c | 105 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  24 +++++++++-
 2 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514e4e9daa82..6f5d3213b3e5 100644
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
 
@@ -5803,6 +5806,94 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
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
+	 * Keep btf_module_names non-NULL to distinguish an empty filter from
+	 * the default behavior of loading all module BTFs.
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
+static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
+{
+	return obj->btf_module_names &&
+	       obj->nr_btf_module_names == obj->btf_module_cnt;
+}
+
 static int load_module_btfs(struct bpf_object *obj)
 {
 	struct bpf_btf_info info;
@@ -5867,6 +5958,11 @@ static int load_module_btfs(struct bpf_object *obj)
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
@@ -5891,6 +5987,9 @@ static int load_module_btfs(struct bpf_object *obj)
 			break;
 		}
 		obj->btf_module_cnt++;
+
+		if (all_needed_module_btfs_loaded(obj))
+			break;
 	}
 
 	if (err) {
@@ -8508,6 +8607,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		}
 	}
 
+	err = bpf_object_init_btf_module_names(obj, opts);
+	if (err)
+		goto out;
+
 	err = bpf_object__elf_init(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
@@ -9629,6 +9732,8 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	bpf_object_free_btf_module_names(obj);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..838602319da8 100644
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
+	 * If btf_module_names is NULL, all module BTFs are loaded,
+	 * preserving the default behavior. Otherwise, only the BTFs of
+	 * the listed modules are loaded. A non-NULL btf_module_names
+	 * with nr_btf_module_names equal to zero means that no module
+	 * BTFs are loaded.
+	 *
+	 * The list must not contain duplicate entries; otherwise
+	 * -EINVAL is returned.
+	 *
+	 * This affects:
+	 * - BPF CO-RE relocations against types defined in modules;
+	 * - BTF-based resolution of function attach targets for
+	 *   fentry/fexit/fmod_ret/freplace/LSM programs;
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

