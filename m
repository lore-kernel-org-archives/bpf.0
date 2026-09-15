Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012001.outbound.protection.outlook.com [40.107.75.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FB39C637
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476086; cv=fail; b=pR1OQJ23jZTP0cmJRIyZXWMKZdqvUEWDY4Y3Pg9PI35Zxh0wXtTbtH0XayinY6OmoM+SzcivGtoksfoLLmvHW/ovapgl3InYTp7lAOEghg5wEQYP2mNg9/mK71FGmIHXZy8775YS0lwISzf6xKE3v3FJ41Q5JG5fFom+7GO6O+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476086; c=relaxed/simple;
	bh=CeZugNhXmrdDjdC8SRJMI9GgyyHGPq588vKOqso+hes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vv4qPe6+RKIwGTkxZqX+m9R5rXJB1mwI9d2NAhYrRtbJ+bFtpq2ENkdrf50yBQWv7obD91t9gzxhWYA+flFF/B8QDRRFsiRyQW+joIXKUpJ32YoNQ8OHASAGGpIwfV6sriAWM4JT5n706SK68XSgmIAsPapi0XuQnAtcc/9eJbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oeU+MGoP; arc=fail smtp.client-ip=40.107.75.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oeU+MGoP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6o8KVtvH2AVxyZc+PHMDsZT53tIKYfDJtiN+RFxvV1a7Mnz6N7cdSL6xRgsSJ9t/+UtYy6udsaxFcx1LsqGFyewXpkb6TERk3dU4CDiVOXqIGCuqirV48hYAZmanbBfFbIGVOpRMH9iiA67RY/MMf6IS5Zg84eLaZMxKI9PTHxeJgu7eV1B8pzYMLcMboLdzf+8Z6vRYFiUdkEM9t2soVrCvyHxKCjy+LvcUXUdvg5f9iHV+IlRP6pysDueUhVa9bjsB3npPnyWrXknTb+0+7J9Vy4nEEsPuvrSYlJuDDtW4IHDb2lBLmRGZ97NUheluPQ4DY73ZJWS4ocFgGnFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7zWZNkCmV57FVeBAo0Zm/el2p4X8bSX5FhaBdXye04=;
 b=cFGmtHHhrA0UAr3aH6zCFSOu00NCjB5FyNiI97WkNE/lw8rt3TdNsbextR42wz4Rj5xztIXmx5xD/hzsaiXEUZhAoy8zYKOm68alEp/8Sxl8MiHzLao2lFdQ9ggZ6tKN4aDWYpgQaYEc/4EP+zGHAiW+Ur7p67qvFkkcaxsor6gQ/Eqs57r4yGjEML4p+Z1dSnK7DSN+qSUjGv9U9nP9XPCuY+/To4sBmHMuAZNX8qUes8wECBUfn5m+FMDN9EXG/OzsmWL1ZE2Kd9X8G6feW/IWXX59rXiJmlHDYlxeUR/cwf6yI3/Z2hcULBYPOk9V2vwvLwXORqvGM375FAmhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7zWZNkCmV57FVeBAo0Zm/el2p4X8bSX5FhaBdXye04=;
 b=oeU+MGoPmNP2Hv6QcRNEE4H8CVO2X4nS8RKRw2qPZOoUIPGuXT2eZUiI0XFF8GlF1JNJQXqConNMULDOyFk+nx2hwuTbnz1ULbH9ZWljde3wec32vt75RyoT/eXzs7Nus0id4CCevt9Occ7yc2FScEUm0U1z4jN7JBUvHvvtLLjeEWriRqF1oM3g/fcRqPjwBaT5Ay6ultVmIQY+szOJoodMr7OnstfFQQKi2Fg7sGc/0GoleQWxN5ozCBZcNwCJx4aCfhmyQm9JqNKebxV+b2tHbECau5AzoORw2hsx1l9qJIpxBjzGCW3X9N6HNEd7WEG6t8Y17JNKUiY3KJn52A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYNPR06MB8829.apcprd06.prod.outlook.com (2603:1096:405:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:41:19 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:41:19 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v9 2/2] selftests/bpf: add tests for selective module BTF loading
Date: Tue, 15 Sep 2026 20:41:04 +0800
Message-Id: <20260915124104.77287-3-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915124104.77287-1-zhaofuyu@vivo.com>
References: <20260915124104.77287-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYNPR06MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6a7c91-e229-417a-0b97-08df1326a3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|23010399003|6133799003|56012099006|11063799006|22082099003|10067099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	XzIPSc++6cEy9pEhl0F3jnev9NVyoVQnYfu4jUT/Dkr1jHl5tYuDFbiR0beOH4nVSokGsyRqaBL4byw3yKCRhGQMzI7JYKPOrJcqqf+7u/9jpurM817QQJ2RR+Vj+Isb3w/8WM+yYIG9OP9B/2oXk5OEq/kH51lzQE3HLfGMa3E1VTordRyVDKKp3wxXfzXZqXF4mtemnV1MrIVxDVPbVdpUR1grYnwMvvB9I3Z+vp3IF3AXuGf1ABi9srcTWIBerxD7Xy0C8qAAEGG/QKVS+fCnNgOgh1SJcF/RoSc3VAM5lIiXw9riF55HL/uDXXnsBvbFl4lyLcntI3yYpV5pa12dhrsKXbW1/b8ZL4Ft30/SeuhGJsjb/vE8J/tdrP4tbekdgOhFwm1PcQrUecGQmSa4Zk4OcecpsA3lmc3aeTqOF7J/fyYgyJ6gjctV2EgDFneyYneSLeBRvuRPCKuCLotgHD/PW7YrZuCQwyQz3M5OmNmJaFE1PVMCI+QypetpJIkLQm/6y0xUJ1ymyUnsTatrjiLVpEoFSDycvYMr8RZeB4wQ7K90CTU5KqVZB5go9ctcQel3Sl/pArOcnzxMNwLPqi7w6eM+6a8O4NBz7Veel5ei83RfI5cDasQM2xYK/jCHPnTXxN5bbweSm/7xY8AatLIKGfhlaEWTkl6AdxnjTctgZWmhHoNbNmrNvM5Vz29hwBoChCBXRRZ22+Um+p2Phq+8UB2guoyM1rEI8Vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(22082099003)(10067099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?us8r2YrgAkoo1Nd01q9wde1j6KaKcWvj+X1hC8H2IETWdNSb9GBZBOY042wb?=
 =?us-ascii?Q?6mJaRQMLnY7RCb0sJs+Dvr8hou82EdbawVIB1larEr5cLnGBmRB7wsLOqEnT?=
 =?us-ascii?Q?Nh6R7QaYiCcX4I1Js6Dk+yqrmQ2VCOSXGsjTdKJfqta0wwBSlLh/e/sqCT1w?=
 =?us-ascii?Q?7fTYZJ25R73LXbnu32NczcEA6RROZKCuXPin0HwicRrhvMih6+xNUl5+3ySx?=
 =?us-ascii?Q?0JqHnEmSBjZKBEIsxzRyUSEJXqBmRPEbE2CZY+9fu19JbsrPxQ+yRsbfgczo?=
 =?us-ascii?Q?lWC8TCmZoGnO0W1kMIe/XwNxvfNwWVsVEq/dbU8bmVdNfv9rsw4B76nvTM8J?=
 =?us-ascii?Q?V/UrATt8XPb1wztDb49pQOfkjGjwv5Uss8402Ko8Atsw/TTuFQrF1okz7zcQ?=
 =?us-ascii?Q?N5DooB1B+IzMCFR+R/RxZxRWZicyg45T97IpeVGFpx3E+LWzbLZWFnDFzIQP?=
 =?us-ascii?Q?/drrrgsnraEJF7Z04PDZS6uWw/FWFDbbM1vOsn1MYtZb1CmTBgk+UKkAkaEy?=
 =?us-ascii?Q?r968AsagXF/Po/ov8dlhlf2TVXqkJ49qgutdsCf455nUORZ/j/mMlA8VL3uJ?=
 =?us-ascii?Q?+FL0tBO7a3mzS8XbUIZm0cx9DOzU+YqAY7SRgoc0rDtA2OVxbnwMIY8JRE8a?=
 =?us-ascii?Q?vhe9k7xek1yEewcjIFoPDtRB8+NgRYn9AdMpe/LAkc+7XXhW12kBr5xU2qsD?=
 =?us-ascii?Q?69b5A66+z0Wgsjv2vCoNmyGhgA/4YcCdIWy0P4//Rs8N8dlCKBxRUeutTNdj?=
 =?us-ascii?Q?iCYDvPEhX+PUdQ5VzPBOdTG2eDbPgwVF+xNenCssc4EJz6DLYQO/H7hUsItR?=
 =?us-ascii?Q?LQppqVgQV9fDIeKNr48orjKt3B6J1v8YTRYHatVn31lU2S/6JQ9UIgEuo/h7?=
 =?us-ascii?Q?ac9Hq+UPSP68KAjlksu4G9YpHvspv+B3zY2GzMoof1h6U1KX3JJljh7AgVTj?=
 =?us-ascii?Q?Jt5Xe+B5gGfNNLSyRiKn9bRr6i3jkPRM83lFBSwSiISigeXwLxXxEuf6r5n2?=
 =?us-ascii?Q?d00RQhlCWhdDXZwvsdVtKdMzCZCrsxgTSadMBFUeXd2tM82ebDXIgykNJx6J?=
 =?us-ascii?Q?Bz8MHQKLiQjy6FdIOvJAKOrNQo5k+QOSzvcEYPHtba9u6zljNIDBwauPWbPi?=
 =?us-ascii?Q?yjYFrJTwJklQ4m9hEIlEhgBIIqW77gRRG9HBHY4z/KtPbkcxyENgYahC+gxR?=
 =?us-ascii?Q?PogeCdeDaByBm9axVkQ2GP2rm5RpOF6Pgkg6TJI3nJDpMYj59Gj8xj9I1bph?=
 =?us-ascii?Q?7+n9au6/0ZKfhNHl1HHUxX3lLwab+X2hqzFfVb864Mvvu4w5q2wad7TlsYSa?=
 =?us-ascii?Q?G57bAu1CGO2b5k2TBb5hEAQ56hcOiUw/0hIM9tbXWzCysGd1+hsTQKQ4goGl?=
 =?us-ascii?Q?svTdJeVFkBswbKd/Iu2BFwVO8Ih9w3OxcKPVY30YXZVWg6/Nw7HpZxK3h1WA?=
 =?us-ascii?Q?P1ZXJ4iDOZD3X8e+btLtqmkEFHMkAvlHmMbvJhvY0u7Kvs1YKXM8HppdTz0C?=
 =?us-ascii?Q?yaDiaVFUi8WQ4IKhgVZmfXd+sDiGQ4U1AXvkn75Hcjy1ZTruKvRld9hwLsYa?=
 =?us-ascii?Q?bPT60HPws26hWl1OPgYiIjhq/2DMyllZ3TK2n/9qY2elUi6ohjQbnk1yQw3b?=
 =?us-ascii?Q?DKtASwAH80IfNUSlnpMxeJmdN04/b3fuDlhKmSBjf0qKRfGaEBTKce5fuRoD?=
 =?us-ascii?Q?3x/h1c2T12SpyCvTGhWwNMWvGy5edy8ocvshKElibEkwemOKsz0VhMRDNPad?=
 =?us-ascii?Q?juUuHKifog=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6a7c91-e229-417a-0b97-08df1326a3c2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:41:18.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcNG5BrADNp9eiZ0D4jz4DWYmDfZikub6ihKLwOnfDXK3GNZd0jWnBXJlj2qi8z6qudXlcFCf716CvrAXjWxmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8829

Add selftests covering selective kernel module BTF loading through
bpf_object_open_opts.

The tests verify that:
- the existing behavior is preserved when the allowlist is not
  specified;
- loading succeeds when the required module BTF is specified in the
  allowlist;
- module BTFs not in the allowlist are skipped;
- an empty allowlist skips loading all module BTFs;
- invalid allowlist and module name inputs are rejected.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 .../bpf/prog_tests/btf_module_allowlist.c     | 162 ++++++++++++++++++
 .../bpf/progs/btf_module_allowlist.c          |  13 ++
 2 files changed, 175 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_allowlist.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
new file mode 100644
index 000000000000..3189133ee58b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_module_allowlist.skel.h"
+
+static void test_load_with_list(const char **list, size_t count,
+				int expected_ret)
+{
+	struct btf_module_allowlist *skel;
+	int ret;
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_allowlist = list,
+		.btf_module_allowlist_cnt = count,
+	);
+
+	skel = btf_module_allowlist__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open_opts"))
+		return;
+
+	ret = btf_module_allowlist__load(skel);
+	ASSERT_EQ(ret, expected_ret, "btf_module_allowlist__load");
+
+	btf_module_allowlist__destroy(skel);
+}
+
+static void btf_module_allowlist_default(void)
+{
+	struct btf_module_allowlist *skel;
+	int ret;
+
+	skel = btf_module_allowlist__open();
+	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open"))
+		return;
+
+	ret = btf_module_allowlist__load(skel);
+	ASSERT_OK(ret, "btf_module_allowlist__load");
+
+	btf_module_allowlist__destroy(skel);
+}
+
+static void btf_module_allowlist_allow(void)
+{
+	const char *mod_list[] = { "bpf_testmod" };
+
+	test_load_with_list(mod_list, 1, 0);
+}
+
+/*
+ * A non-NULL allowlist with a count of 0 explicitly disables module BTFs.
+ * The pointer must be non-NULL to distinguish this from an unspecified
+ * allowlist.
+ */
+static void btf_module_allowlist_emptylist(void)
+{
+	const char *mod_list[] = { NULL };
+
+	test_load_with_list(mod_list, 0, -ESRCH);
+}
+
+/*
+ * bpf_testmod is not in the allowlist, so its BTF should not be loaded.
+ */
+static void btf_module_allowlist_skipunlisted(void)
+{
+	const char *mod_list[] = { "module_nonexist" };
+	struct btf_module_allowlist *skel;
+	int ret;
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_allowlist = mod_list,
+		.btf_module_allowlist_cnt = 1,
+	);
+
+	skel = btf_module_allowlist__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open_opts"))
+		return;
+
+	ret = bpf_program__set_attach_target(skel->progs.test_btf_module_allowlist, 0,
+					     "bpf_testmod:bpf_testmod_fentry_test1");
+	ASSERT_EQ(ret, -ESRCH, "bpf_program__set_attach_target");
+	btf_module_allowlist__destroy(skel);
+}
+
+static void test_invalid_input(const char **list, size_t count,
+			       const char *test_name)
+{
+	struct btf_module_allowlist *skel;
+	char assert_name[64];
+	int err;
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_allowlist = list,
+		.btf_module_allowlist_cnt = count,
+	);
+
+	snprintf(assert_name, sizeof(assert_name), "%s: open_opts", test_name);
+	skel = btf_module_allowlist__open_opts(&opts);
+	err = errno;
+	if (!ASSERT_NULL(skel, assert_name)) {
+		btf_module_allowlist__destroy(skel);
+		return;
+	}
+	snprintf(assert_name, sizeof(assert_name), "%s: open_opts err", test_name);
+	ASSERT_EQ(err, EINVAL, assert_name);
+}
+
+static void btf_module_allowlist_invalidinput(void)
+{
+	const char *names[] = { NULL };
+	const char *empty_names[] = { "" };
+	const char *duplicate_names[] = { "bpf_testmod", "bpf_testmod" };
+
+	test_invalid_input(NULL, 1, "null_list");
+	test_invalid_input(names, 1, "null_name");
+	test_invalid_input(empty_names, 1, "empty_name");
+	test_invalid_input(duplicate_names, 2, "duplicate_name");
+	test_invalid_input(names, (size_t)SSIZE_MAX + 1, "large_count");
+}
+
+void test_btf_module_allowlist(void)
+{
+	struct btf *vmlinux_btf = NULL;
+	struct btf *module_btf = NULL;
+
+	if (!env.has_testmod) {
+		printf("%s:SKIP: bpf_testmod is not available\n", __func__);
+		test__skip();
+		return;
+	}
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!vmlinux_btf) {
+		printf("%s:SKIP: vmlinux_btf is not available\n", __func__);
+		test__skip();
+		return;
+	}
+
+	/* Ensure bpf_testmod BTF is available. */
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!module_btf) {
+		printf("%s:SKIP: bpf_testmod's BTF is not available\n", __func__);
+		btf__free(vmlinux_btf);
+		test__skip();
+		return;
+	}
+
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+
+	if (test__start_subtest("btf_module_allowlist_default"))
+		btf_module_allowlist_default();
+
+	if (test__start_subtest("btf_module_allowlist_allow"))
+		btf_module_allowlist_allow();
+
+	if (test__start_subtest("btf_module_allowlist_skipunlisted"))
+		btf_module_allowlist_skipunlisted();
+
+	if (test__start_subtest("btf_module_allowlist_emptylist"))
+		btf_module_allowlist_emptylist();
+
+	if (test__start_subtest("btf_module_allowlist_invalidinput"))
+		btf_module_allowlist_invalidinput();
+}
diff --git a/tools/testing/selftests/bpf/progs/btf_module_allowlist.c b/tools/testing/selftests/bpf/progs/btf_module_allowlist.c
new file mode 100644
index 000000000000..bb3c38bee77d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_module_allowlist.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("fentry/bpf_testmod_loop_test")
+int BPF_PROG(test_btf_module_allowlist)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

