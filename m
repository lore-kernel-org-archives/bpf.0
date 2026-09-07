Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013053.outbound.protection.outlook.com [52.101.127.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D39383C8D
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759548; cv=fail; b=Tl2fwY+0IlEnrexVLAoaP/DUdZ8rn+l/zFUzu7So6+vvSDcfdVjt/WvuyHLVji8jRNQp7NVWZTcR2AWSx05bNf3CTBTrfLxDqu0zPGgQiLc5pEESqUaQjTtYCnO5onCyMwIuivReItNsxmQe0VLPZNKawfimRiyFuMNSHlyasNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759548; c=relaxed/simple;
	bh=AHBny4aCPsF2o9VWCYW7f/HRyqWRdOIm/ZdQmNIFnuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ar1NgjQUz3QDCvL7PCteEr6GNUmEJiHh6fzgUr7dk76gBJdGYlg4jJjzDUu95YRl5dPyv2wennwwwZT4OZbwDIhsKQGI1DZev6MP3kYz61TbjFvweFABp3BW0KDdDboEnzpot+q2DtScQXrvKQictC3DzG/JQSbkKxJiVLOCzW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ezskV77f; arc=fail smtp.client-ip=52.101.127.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ezskV77f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uulZCADCJQJR/SI21NE6TmKHOi6p7QK+c4UfbfQwZnDlG8q8WsSfnXaHyqIKs1GmFATPwCMXbLJx7O5u6qk+ui0hVbF+w9bB4xicu1I8yQ3oce+bdZ/V3ExwtC9Ga1SRcvsQvPoKwBdBn20Cm8mEsS3Q/Vx3sXvUZ/bdIFCkaTgV8iRYNOFSwa03oJ9npKuNzjncVqtFgbdMxPdvv3xHiYuevUAg34W/ce4jtUvmizd9ELRQPCNojv2JLvClBfPiNWE0Qoj+v7LUgHEKPUlJOdCz7hH9ll9yeyL+UIE6FXcn/80Vl3NxMEjA1OnEt4FmObx0WsileVIrESLJ3oryMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSbBo6bK80F1uPpLjqUKmrYrxRPK3/mJR/nGCZF+HwM=;
 b=Zjc3+GLtKF3mq+jVeYx+6xBRJ8b7x0cZHFMYeEOHJIg7859kh/xokdIe7quXY/Tnx0umymAzz+P614W8qu4NGVqIrhec5vg8GW6c45s623wX6irOEFiJ/Mg3aP5psx0xXDV5aIZtQJWHag2l6AJK0Nx4lks95rGm+2rM5glKLb56jlAC+xEd2pd6WIBTF+xi8we8elWz2ML8W7MKvqU72AmfTUFY2U9TzaC7IRwXlZG6XqaLbURtOt5VkRGs39ge5+qh6kWCYhVXeHGfxJP5ylp3pRi/l95GltnIxgc5DgRHHqjhNX6rc3yqQ4dIOpYKNNmORZyxVFh7gjaWKAA74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSbBo6bK80F1uPpLjqUKmrYrxRPK3/mJR/nGCZF+HwM=;
 b=ezskV77fTXbzzjDE73kFOmvZh9170hAdxoQz12YLFCMD0BnqHTx4U79/l/j/HktrCeDxFg73egEpaektGLpwjRcgwf9m7LTKJJYjR4SsnEoHTBdnwrz3nMDU1vZw66U9VCBRssdFhfufCW/rCHg+LleBOV+dBHYfJXiuVC3HUQu3MqLJy/SF9pEwbfdphG93441RQpLKUxVih6CLGam/HrVx0BB3TwPFa0RB5KbXhSs0ztWfKmgj9AJtbp/9mlTgPK9RU9WFKIaHH2/hG/kqWlsof8Ychi4/lavuMJ/dEhxUWMbVpBEl5ezFh1qphlnMTHD7kWYqz/V0hFnxM8D0eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYZPR06MB6913.apcprd06.prod.outlook.com (2603:1096:405:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 05:39:00 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 05:39:00 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v7 2/2] selftests/bpf: add tests for selective module BTF loading
Date: Mon,  7 Sep 2026 13:38:47 +0800
Message-Id: <20260907053847.1115-3-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907053847.1115-1-zhaofuyu@vivo.com>
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TYZPR06MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 116dacae-795b-4318-537a-08df0ca251dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	8Kxjw8qLymtkVTjyC7OREfLdlWu8FPFk156te4dV5jlmZKlWIDARumqXXd6MNteXRwSkz6StmZjWE1Hh7LLmrlv6BqHcsTsOJM5q5t20lU80cJRDZ/MsqswJVWRRf6ceSKb+3rPoyU9IKMlnwXwqNTI8KfSGlsx7fkMEBGtb1+E57UoqpgWqR3bsmq3nfXHl6yDTiIsLZMswoFfhLZ+zr2TYYHEmQIDo5DW3m3XGDJra53oB8T+A7lIi/ptoPMmcWLH3zv8puRkbR8mYmsuyegThKLpvnwm4iTW7836Fo2Lp6a4xf0IaqxZzYHU/py1jZruQ8TJTcl9N2d4P7NbHS61GZh98M5se9ku1rdEBXWoKMlpOqRxhHKKn6X+SQyUUd/KwaWDaubHdv/YeE2g5Tk4FdSwAhUBTRLG8JLAvHQyvu4Z5fumRQMCj8YarB4kAkqos5f++UMifd1Zqgl5uSAkpUXx49xz7vpVbH/373Eyv6mHcynZxLy5Ms3NLKSvBhAagIPoVeeTxV7dUfZ2q8KaCqkxTuo/V40zLMTzlBY4R7U4uAOxtf43Z6KxCYZADni7nmrWaJSMi2zHJJDXGlzh64CN8CMQS6p36s/qAnbL9wB4IiruYLnpvVf3BdNkttC2cZYTlzJ2uNfsbLoaPB3Ak5KvHhnGwtUoB+YRLAC/+jAuzS77KrDiNGiqMDrIvtAeNOHzPNSsPylWnLmvR86O1U1S7zyBjCq+3H6t33eY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5KoddaF5EcqCpVF7rmL5i4VPirN576FQUOGUGawTsu4uUjhsWANSCH2rEvUC?=
 =?us-ascii?Q?2V/MQIoycP4bNUSHHbqiNiBlYbphxU1763dvq3YAqYOVCJ0wyyrfDbyf9JT9?=
 =?us-ascii?Q?v3PuY5XL7eWtBMh5zGO7ZBdmtmd6UpFz8gnAfouYQOw279sPFMqKpELvRv+K?=
 =?us-ascii?Q?hgQMDW1EuHWrZhbELt/dI4dulRC1joZzTVpQyQOIU4naJLBjxq7fHrYXgH8G?=
 =?us-ascii?Q?pNDqiJOxJy6aLfFJvsVOIsJ52hvLlz6zYBrLfafxJlP5V4j8oE66Twss+lH3?=
 =?us-ascii?Q?yivRs/1B1BZm6/ZdNpYI4MdKInSMRcidUmRrPIEouMAC6TXRmuReAOspSZFp?=
 =?us-ascii?Q?v8IIEHVXsg3V8UijqeX/mF0K7jYQYiVoAIH8u7xsaEWKn+kCzvn7S+UkRbag?=
 =?us-ascii?Q?blT6VBI0HRScn2GUNVisEtT+7dEAc2LI6aTkNmwakuy+AyBwBPOct2u1cAlQ?=
 =?us-ascii?Q?AeF+O4BYyLUgAoNEyXD/K+f8nQzyusWXWunEtX7AAg8K0aEpfv3VKwVPaYQC?=
 =?us-ascii?Q?KTG+5xT9knZBeVpwAL5lcgHmu2uDF2+oSUkPtht4DaPGyvmF9lISBqax7r8b?=
 =?us-ascii?Q?IohSd4TSFekD9INgvLbWvdZK8mVyNgpWAC0dcSUIGrkCqLs6w0xvx8mK6+4/?=
 =?us-ascii?Q?MJ+HI2HFAPHdWunPZNlHvK0roYPNmYlGmosdQ1L3QbAsKIHJWFZ1bIku/bh3?=
 =?us-ascii?Q?Zly6ztOjRu0Lr/qz4kwU6HvGVQfer3vBGCVX0+86hSFmplrvlAU14Cw08zKp?=
 =?us-ascii?Q?wf+QxPFZlLIDM/i8ZXKrApA7CiBewMTEgaNgyKKMYUWdPmrm48dvFKIAiHwq?=
 =?us-ascii?Q?yTnnPSBugOrf5JKcBL5o0sZ61qfSW97HJNIqEnHXDvgtXURgdR4i7Q9wzR5L?=
 =?us-ascii?Q?3gzUXvbq+h6DUS4kT2nxCgqyesXB+2SOE2+RwvXCNZ8bPe9Ix1yht4uatwFO?=
 =?us-ascii?Q?cfTl1u1+bJnhPUyhnyDpKJTcpuwYSZTjAT1X4OBUxkWM8yulJo/bP9H5k5wd?=
 =?us-ascii?Q?Qz0ZqMzamZWOL40rzFHmvQhV9BP09XfHc8yrkbNwO1U0ZCpioVLncmlCYeKz?=
 =?us-ascii?Q?uTBG9OY9OWRYZrThPg2Uj2uF1hPu2/5VqqJdXk/UiVFVzhym8gS3Awlx2Qw1?=
 =?us-ascii?Q?9VaKClP2vVJdcZlZrDNCndoaLnPXIfx0Ji+VEFCfEbfSPurCdTgPEhtS6l6s?=
 =?us-ascii?Q?s580/M/8VwLBhtc2/czsOwbUW6gTJKR7OT5g79N56gpJIO9wy0D1uGwRQZcN?=
 =?us-ascii?Q?eYdjawRRCqDAajk4rej6X7VoPXuBxxvV6Hfl7ndSUqsebeQF2yHnnqRBoKzr?=
 =?us-ascii?Q?iMnToxoL7BEN2UGxqpGIXlkxqwb8KUxnBOTnwxd72QCs5ufp5agKcZqDvxzD?=
 =?us-ascii?Q?TJWLLCZIBpQsv41Cm0cuG3WMMn/xhaDtGawOW2Y6JncUGKsCkOXSPD6dAis8?=
 =?us-ascii?Q?AWwFc2ypdv13PwuBdnxhaL7c4EjJGHzW9zQQLZ6VUwfDlnJkz1v0/vQ6sXr9?=
 =?us-ascii?Q?8Pz3CYl3IhkiJe9WKCfLtdedY2VFKBDSqz8XKAXBNuwvJIy3+p2bGdTQLZ8v?=
 =?us-ascii?Q?qBARUEe6ME7S3zZmqqN/WkCPKcpE7iwJdavfvEjwFGLM7e23ER3XOigsXXT0?=
 =?us-ascii?Q?OzycBkzYl9lTM06iX73YBJOeYA34TGwMExZxENhABs02ezjzMY4KmGwMgSB6?=
 =?us-ascii?Q?RLIyArHcqXepy8qOd8EV7v29SLYYg3bm5yTDaDXQaf3Vbbj43DGKa/kfWvLm?=
 =?us-ascii?Q?MXNisqrUQg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116dacae-795b-4318-537a-08df0ca251dc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 05:39:00.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sx82NE6XXYNGf/VeuH9LROJthm/QFlsP5JZf1uyMuAvMpQCgk07HmYKsAz7wm0fHa/nSSSBs2iKUv63V8JrYIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6913

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
 .../bpf/prog_tests/btf_module_allowlist.c     | 155 ++++++++++++++++++
 .../bpf/progs/btf_module_allowlist.c          |  13 ++
 2 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_allowlist.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
new file mode 100644
index 000000000000..fb1b9ffb6c7a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_module_allowlist.skel.h"
+
+static void test_load_with_list(const char **list, int count, int expected_ret)
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
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+
+	skel = btf_module_allowlist__open();
+	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open"))
+		return;
+
+	ret = btf_module_allowlist__load(skel);
+	ASSERT_OK(ret, "btf_module_allowlist__load");
+
+	btf_module_allowlist__destroy(skel);
+	skel = NULL;
+
+	skel = btf_module_allowlist__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open_opts"))
+		return;
+
+	ret = btf_module_allowlist__load(skel);
+	ASSERT_OK(ret, "btf_module_allowlist__load opts");
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
+ * bpf_testmod is not in the allowlist, so loading should fail.
+ */
+static void btf_module_allowlist_skip(void)
+{
+	const char *mod_list[] = { "module_nonexist" };
+
+	test_load_with_list(mod_list, 1, -ESRCH);
+}
+
+/*
+ * An empty allowlist skips all module BTFs, so loading should fail.
+ */
+static void btf_module_allowlist_empty(void)
+{
+	const char *mod_list[] = { NULL };
+
+	test_load_with_list(mod_list, 0, -ESRCH);
+}
+
+static void test_invalid_input(const char **list, int count,
+			       const char *test_name)
+{
+	struct btf_module_allowlist *skel;
+	char assert_name[64];
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_allowlist = list,
+		.btf_module_allowlist_cnt = count,
+	);
+
+	snprintf(assert_name, sizeof(assert_name), "%s: open_opts", test_name);
+	skel = btf_module_allowlist__open_opts(&opts);
+	if (!ASSERT_NULL(skel, assert_name)) {
+		btf_module_allowlist__destroy(skel);
+		return;
+	}
+	snprintf(assert_name, sizeof(assert_name), "%s: open_opts err", test_name);
+	ASSERT_EQ(errno, EINVAL, assert_name);
+}
+
+static void btf_module_allowlist_invalid(void)
+{
+	const char *names[] = { NULL };
+	const char *empty_names[] = { "" };
+	const char *duplicate_names[] = { "bpf_testmod", "bpf_testmod" };
+
+	test_invalid_input(NULL, 1, "null_list");
+	test_invalid_input(NULL, -1, "negative_count");
+	test_invalid_input(names, 1, "null_name");
+	test_invalid_input(empty_names, 1, "empty_name");
+	test_invalid_input(duplicate_names, 2, "duplicate_name");
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
+	if (libbpf_get_error(vmlinux_btf)) {
+		printf("%s:SKIP: vmlinux_btf is not available\n", __func__);
+		test__skip();
+		return;
+	}
+
+	/* Ensure bpf_testmod BTF is available. */
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (libbpf_get_error(module_btf)) {
+		printf("%s:SKIP: bpf_testmod's BTF is not available\n", __func__);
+		btf__free(vmlinux_btf);
+		test__skip();
+		return;
+	}
+
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+
+	if (test__start_subtest("default"))
+		btf_module_allowlist_default();
+
+	if (test__start_subtest("allowlist"))
+		btf_module_allowlist_allow();
+
+	if (test__start_subtest("skip_unlisted"))
+		btf_module_allowlist_skip();
+
+	if (test__start_subtest("emptylist"))
+		btf_module_allowlist_empty();
+
+	if (test__start_subtest("invalid_input"))
+		btf_module_allowlist_invalid();
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

