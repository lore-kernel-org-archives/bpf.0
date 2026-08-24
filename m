Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013024.outbound.protection.outlook.com [52.101.127.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257CC41D620;
	Mon, 24 Aug 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576012; cv=fail; b=Exlb0+tdZJ0Z+5p//uU680DP1aDtzf8dp/y2in6hw55tZh+wYNm5uTXP+w/m2v+D9roPeDYWzsAlBvyNW74xwnb1nI00mOQ2GsdUJlT61Xqb2HwU3205/OBf1ehd4T+VQnex0sJtxZZwd8euTOMzRzJHe+AgrYFZWVwk4fX8nkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576012; c=relaxed/simple;
	bh=LarpLlmF4es104wPvzOccfDKVBvrMXImwk6smviLfKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIs32luvPBQM1NufBJhL7vgTTA/uZ0oATOJzF8o6me4FLZFlBe0Fxrmsr2oMDGczaWiT+3Jl9Vx/ygm8pOVWreEMVycCFmoxR3RPuO9bmwEy5EEpsa4yg9zpYLr/bfKDhCvPImDisy10mM6A15vVA5SwGwn4gN+aeJ9l4PIPIFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pLXuGU6V; arc=fail smtp.client-ip=52.101.127.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pLXuGU6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp4kFTFWl3MWvNk1GnMIxdwTqCaP5KLZjDmcG4Kfx369KFuvy6kdakEkmv+kwSpm/kqs6vbT2wVqEQfAuRr723eo2ERX0oN0YxNs3Xz+tdd17qx80ewEll0GOJs3ZU8TwwBgUt7aoEnAeItnQEF5ED8re8oVbUyrBFNOwHFD7XfCNgt5H0IpXBm9o0DSCKgcpqVqw/xsQtONYw5bULmgEgM2ro/fq97ZpZfwFtDfOQFZc5UawhvP7S3plv7ZnC3QaIT5lTnhDnJ4b9ECdLXBu7ErbgvF7pEnrhruqn/lN63xwLMv2Jj86pQ0q/V8M8mwYmEgkgZ6HdO1b3rQFokORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vmTSIlMw0fnEg/GK9ejkjSBtJzN8Yh3Tm99EIyDnoY=;
 b=t7CXwmCrv3S1b4RpsEPLbTpekvAB5HoS+0f0BBd9ouZzZJ+gdbwLriXobOs/U6ZWTpTyDhIBC/ubJ+2vd95ijtITPvFU8/sBCJ+GEHS4VO7gFUKt8adaeYix9xv88fH0nWetsxkRhyNymkzTDUqkEHsYUEBwMOAyKG41BqZlhq7Zgjbhw1NurBEY4sR0fb2VeUBRiQdUUY+kF5j37DturwkyVlMUUWgsl/6Tq68sHnf/+9V1TIF5u39S3FxaUo4mJvC5+goemRNo0e2WieCWdrwcXHS3YLhHKnN3snj2yxhY7fGL1+5PvOamoF0qwhXXz3Ry5KEq0oWtv0hpenOYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vmTSIlMw0fnEg/GK9ejkjSBtJzN8Yh3Tm99EIyDnoY=;
 b=pLXuGU6VmYw2i+2mEcCLP0UohVwhSXSmmpTu6FPN6/qUGp9ePDpgOjEsAvDvYQFTIzRnxjoClRIZkkH7zqr9Y2vRCXJE3cNJxGtlI5wdyKj5VxWXRxB717SG3p0nj3laYuQHodPUaUBse1PncSXYqx18cMj7Z6z5UF3/BTnc1zd788bNGq3wkkSzHXrT79NM4d+z7b9hclgYivggA86w77GQLuLR66hZrzKAmz/hQMwjw/73MUq8idAvW4uxqud/3ptCA80exg7+7GvHYVLP0Ur9YekcwhW9pqG0uZke7v8g3ttCJ/CaBGMTyimmmXiyauVfiM7tsiwRB6aJayifoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY0PR06MB5210.apcprd06.prod.outlook.com (2603:1096:400:21c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:53:28 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:53:28 +0000
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: add tests for selective module BTF loading
Date: Mon, 24 Aug 2026 20:53:10 +0800
Message-Id: <20260824125310.1384-3-zhaofuyu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b93f69e1-c5ea-45f4-03c4-08df01deb160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|38350700014|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	TFTFsmB5Z9eWWBBdWtz4uHtpShxKaABSymihaLpef0yR1IRHOLzdRy4Ttr36ldEwyTxkvC4SZi1f4Ik5FYaHkmNlpTx7V+VMtu4kiMp5xyz+kBHmaOoBmPQAcpWjZ5aw8UNcwDTktrBUOd/RHAu5Z0l8hzsnZKByisH7RdjGSdG7j2BfqBd70kpNOl7F6DxiDMxKevb6zI96/Rhe+lEkfUEOTY1eRZfCNr6/NaZMqGPUeocbLpfj54NZHiRspuuQ7mkU1akcZVz5s7kSpNRqzhAecIaDbwySipjQncCuOxXBCp7KdSoIeWuvzeWYgURoNRZX9CW5Yrb05EaOqdEBeSxzF7O9Hicn777dWW8Xpr40korq31BZTzWkx8hny6viNOImOJzSYv5/v7+SCca7kGqY+TScPjldaPyyf4Sa9MIM6WU6Z9Eh3P5AP+IHkYNyDVG4U23MxltMO4pZEYO3hIC9mixcr9vWM3dXG/+kyjMGlawta9vXpcJdSQxRGZRYVMJLQ4FRYR+zd86t/Mqq3HkPslKqXPJSMxkjDlyOX0/6MLqIFEVtRkXX1QpfRKj5nTSo1ebLNkha6ptgDv1v9/w/riKvrLitoD6kSgukWbQn7f1LNiUDFj2LgaETBCl1BQRBo5h6vpJete9kyyJXi0uTz5/Reo/aTOo2z2JBIwR5UAU1oZsGXNLXk/S9gPEPcBcCsZxv9+EXbo14VMSuSemAzv0mz1KdHpZ+0rqjP+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ttZif+13lS6/rzu2Rs81QmpX9iP5n7neO2w1hTxfjzm9olu4TUYfW/tjtrt?=
 =?us-ascii?Q?khvm6uxlVJIOeGhTe5cgRFsgPxv2GsRyCAQKXPdaxJVqFH3STlFvPoL8D4pF?=
 =?us-ascii?Q?ZdbvVjVJMA90KQkmJXkW5/Phlzo5uWcNlTC0wwlE3XeXvW4OaTKdoIjNhPmG?=
 =?us-ascii?Q?ogMUBik1z4DOv+vupfwU1UMkBaA8rpX4nMRfYW2oHH71ixxzt8XMFqYl3qaq?=
 =?us-ascii?Q?GKdB+LaVw5A2R/JYF7pOspYFvj7LNApVuOedWmSN/5+NFJ64ja0Q4EoRPyay?=
 =?us-ascii?Q?Pfpqlq5pDKs7b0fAoTA2+ui8PYzxsUCFJRvZ6c682DeG2Gnk/DZFve82ML3N?=
 =?us-ascii?Q?GJiUvMRZ7u7pZZF63tX2hPKSV3Mo3i/kWbyma1dxROJFrZa1xshSxClGJeDC?=
 =?us-ascii?Q?ymlqU7/AKDicMFD++m6ztjtIuWXDjEna9dfBtdUPRxqJbbwrNGxFmmam8U5J?=
 =?us-ascii?Q?5zUIIY0NAeOZHlKp+oXfXwEbIl8OSK3NNbVr6I/zT96S+boUCdgKQm42A9VW?=
 =?us-ascii?Q?Uw1T54355qvZ17P+6oMLKFeEnsjZq2mYvU6S2/BHiQaktiRQ0lGuO3QGbyrz?=
 =?us-ascii?Q?ZMkVDspEbR7n15vnpJaWsHXgZRPWX+zRQLpkdMKz9kezeCggAVdZ6Ffz3jG8?=
 =?us-ascii?Q?zFjWXdTcyYKEmnKBCe5Mc7fJZIRPbg6O5Y8OUd0dozd9ju/PDpVKaHWlMfSk?=
 =?us-ascii?Q?zsLG+e4jU2NzrmNtCfhyjJht/c7TXivSDJYFg13FX14kBPG3DwhzZ5Uuqayv?=
 =?us-ascii?Q?XvgtNrcnNZwks3bpYsUAXLr9xJO0O5buW2YrvqlvpQm2EKt5doj29D4FZMKa?=
 =?us-ascii?Q?aw1KdIARX0WPzm+Sj/9Z34PwevekPhuMPWlaL7ymk0VygzNh20eEOcvzYVhw?=
 =?us-ascii?Q?a8LUXBrW7pJL4UbJsvUH+6fVkw8SIETHruIkUg4wajdmnL946x5Ii1eObG28?=
 =?us-ascii?Q?pebZoN2oGrBd4bzeX1BFFmZuaUaZZXUk+8RmbnfyqaC5Y8pGweCni9fUrr5E?=
 =?us-ascii?Q?2glgv75HBhWgwbguHdKKaYGd2nw7jhFvUoC3IIhvCuqZO/79KKFfjQ7IjzMs?=
 =?us-ascii?Q?zqQWhsAFJtqLn4dEDGdP2tYsRDuHOZl0+z6gwJPP1oAqX3joUZbJ2DU8TWxS?=
 =?us-ascii?Q?rYv4LKvUVFTZ5jTLyg303glWvm5J7BNXvRjuGPrdSk/lUDF3zmBvfagiHCio?=
 =?us-ascii?Q?qEdawkX9suk9bnYRCxxCzEA4WnW/E7XemdlpyjRQp0M5Z3QUlg3lpYqLl/9Q?=
 =?us-ascii?Q?45e1UPWd3OTGb5KB9kQrEkHu8fe3Il4ZOUsIozG6cvZcMJwSrSTQi5lBqyAj?=
 =?us-ascii?Q?/1MkNnLpz7Yv7cf/Ufw6FmmqglhYbJc7+QOpxA9DmWV4ZnFOYpjy2+7oVqrC?=
 =?us-ascii?Q?Ch3iJeY2o9/JeENh6/TQ5RfXV75Z0gNUS2Bf9BBVkAaO3CCm/r/Q1zhDZDF3?=
 =?us-ascii?Q?Afl/waMGO7KMYggcAOXovSuIAZoIHZmyME6PZYlWiRn5/OLH4XPOzWYj/Qfr?=
 =?us-ascii?Q?+81vagytCIhUh3C//PkalaCdrRs752hd+ZwXteYIB1EZzf5v6uKILwX7UMkO?=
 =?us-ascii?Q?Gl0cN8i4WS/WLf5mu1DwuTydFF3alkv7cuw8WV35v+G9RgXJlJd6WfSqlGck?=
 =?us-ascii?Q?QJy8otj2ehF+uC6v8PRndZKLQY33zpSw6XMSuCpwexYzCMGuygt+X8qarmgG?=
 =?us-ascii?Q?xF1qIK3ZfhjAdiHaQqL3zSCSD/cfzLvwup/bn72uNf7FXajASXdPqj+O52EP?=
 =?us-ascii?Q?EYCz5mtOTg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93f69e1-c5ea-45f4-03c4-08df01deb160
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:53:28.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wSxRys+qruqe0AWokzw+b5zbPUE/RUbKnAz959sipGWcNQmAdlzMSOONGqofUHPKztQ2yQ6z8Ns7rn9I26DBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5210

Add selftests covering selective kernel module BTF loading through
bpf_object_open_opts.

The tests verify that loading succeeds when the required module BTF is
requested, fails when only an unrelated module BTF is requested, and
skips loading all module BTFs when an empty module BTF name list is
provided.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 .../bpf/prog_tests/btf_module_names.c         | 93 +++++++++++++++++++
 .../selftests/bpf/progs/btf_module_names.c    | 13 +++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_names.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
new file mode 100644
index 000000000000..d5674cad0017
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "btf_module_names.skel.h"
+
+static void btf_module_names_load(void)
+{
+	struct btf_module_names *skel = NULL;
+	int ret;
+	static const char *mod_names[] = { "bpf_testmod" };
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_names = mod_names,
+		.nr_btf_module_names = 1,
+	);
+
+	skel = btf_module_names__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
+		goto out;
+
+	ret = btf_module_names__load(skel);
+	ASSERT_OK(ret, "btf_module_names__load");
+out:
+	btf_module_names__destroy(skel);
+}
+
+/*
+ * Verify that an unrequested module BTF is skipped. The BPF program
+ * requires the BTF of bpf_testmod, but bpf_testmod is not specified in
+ * btf_module_names, so its BTF is skipped and the BPF program fails to load.
+ */
+static void btf_module_names_skip(void)
+{
+	struct btf_module_names *skel = NULL;
+	int ret;
+	static const char *mod_names[] = { "module_nonexist" };
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_names = mod_names,
+		.nr_btf_module_names = 1,
+	);
+
+	skel = btf_module_names__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
+		goto out;
+
+	ret = btf_module_names__load(skel);
+	ASSERT_ERR(ret, "btf_module_names__load");
+
+out:
+	btf_module_names__destroy(skel);
+}
+
+/*
+ * Verify that an empty filter skips loading all module BTFs. The BPF
+ * program requires bpf_testmod BTF, so it fails to load.
+ */
+static void btf_module_names_empty(void)
+{
+	struct btf_module_names *skel = NULL;
+	int ret;
+	static const char *mod_names[] = { "foo" };
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_names = mod_names,
+	);
+
+	skel = btf_module_names__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts empty"))
+		goto out;
+
+	ret = btf_module_names__load(skel);
+	ASSERT_ERR(ret, "btf_module_names__load empty");
+
+out:
+	btf_module_names__destroy(skel);
+}
+
+void test_btf_module_names(void)
+{
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("btf_module_names_load"))
+		btf_module_names_load();
+
+	if (test__start_subtest("btf_module_names_skip"))
+		btf_module_names_skip();
+
+	if (test__start_subtest("btf_module_names_empty"))
+		btf_module_names_empty();
+}
diff --git a/tools/testing/selftests/bpf/progs/btf_module_names.c b/tools/testing/selftests/bpf/progs/btf_module_names.c
new file mode 100644
index 000000000000..232adc0f33f6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_module_names.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("fentry/bpf_testmod_loop_test")
+int BPF_PROG(test_btf_module_names)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

