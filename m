Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EC43DEB9
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128526; cv=fail; b=KyN2+vx71Oxf1UM/3avbT8g9qmwapu9Kso2nBeM6swHt+J8CDh2fNHzw6N7JZLGIQSG86clAU7Z3d0hN9p8ggfT2d0t9LvQjxNad4YQDMtx8Jqty0eh3VfEQlTASHIR/Tk4EFaQnWelQINwrR0LLrZvDDZkDSsqcgWomrDnX1Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128526; c=relaxed/simple;
	bh=L9fyBRdoi7TcnJhsy+4PpOC2Z8OOb7OsPc0i+q19v3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNkrrLirf6orIlCT9kij4zkOs2QudKlg+7RrZA63mCecdslOXI2yDPn3AcvqjQwHZby4+rPyKVf3nUJun0VEvq9EunaWO5BkK2G58ZdNEc98LUgU2pPmWffe5eZy9ikbaF12Plzso/4iFwd1Zv8cp4blUPmm9GBCufUjCUikYp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pi+j2nlQ; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pi+j2nlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzDkfOkZzs3+dxiJ+8E/m1kFsHhRV0t3MFbHKUw8rHG38M4xrVXIPpEhDTwXt420aHTDDXUQwAEvkSEySpLSNLf6GfN5ro+5GhMTl9mbytFiPp46iRuCcaYFB5ntS6EwUzA7KAhy82dsSRu1Zei/Sutdgst/oJZo+RwjNsJKSIsOWwAu/84JyFWthJBDznyUS+nxq9vd0I6iH/uRTRlhy6rnfDu2Fh713EyLOM342GrslVWqs5weWNPUlJMj3miX71VpdVBNPloIJlruj+27mFsflCo86eVHyExN9tk6cUn6hVIlwimijmjKlIxCgwuqzxiRLdsTc8hQWcH66UUhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36FcSznkSPYWeUpOoh6nUmQ8c/l+PsCA5wzjmdaY+KE=;
 b=pYMtIyHomLrUkwh4982EiWEDMSDRbujssPdkj5bZ0wE3J4VQIzQzVftlhzE4457Jl4nraxS3tj9cHuU1TJgLrKOWg4QJVg3s4M2A4nZaMQlLPu+AzlCoI1m6rUXu7EZkVf35QkvgDlUrUbhe+AnOruOnigfBm3rMCcflJAGAB4ds6JRdFVSYjPkXhMTPhiEPkpzDmrJPbQMRNJMDteHHPuOAQgWaZV9egvuDPhJirhCdIOGcq192NXHJzZOZzDkJhDRQIgMhyHMH1qE7BLy39Rj0X0+bGEG7t3qfJw9gs24fwIGr02eiRYXHbFSK44zx6UL5PI1kNCo7L047aXA/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36FcSznkSPYWeUpOoh6nUmQ8c/l+PsCA5wzjmdaY+KE=;
 b=pi+j2nlQ5PE7NRUC2lKNXc7IvbMAla95pgyTkKwKf/bfoPcASi+x0/SjBXk6hlseWpIigKqAnHuoN1I0U8lyA9f7/PZdFwpuieEW5iigdlswLVzwtFNPZN9w1fHBVE6gdiFlVdxK/Tx+8GmojVsq4tsfqZzeHKq1/lGxtX2/sM14XCUx0TIjx+Wo+BOy88Yw+R7SVsBAzlrxx09h8XbuPlImPA7sTIkI3Zp/W6LAaqBeOtAZcpQZPD2/nd+gopcRGpHrGlzMTXtRWNn+ou0qdqLFvUJZbisRSlVOFO2+/zy2yeq1sXGgeK9ONQ/tslAhIIehz5EHQ9SUQ/+oaDAl3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB6755.apcprd06.prod.outlook.com (2603:1096:101:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:08:39 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 12:08:39 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v8 2/2] selftests/bpf: add tests for selective module BTF loading
Date: Fri, 11 Sep 2026 20:08:20 +0800
Message-Id: <20260911120820.46900-3-zhaofuyu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2406fa6e-27b3-41f1-74ad-08df0ffd66a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|52116014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	b8NYlUDAhcmDoYX2CgrcjZbsezeNv0nPg3mJk+G2zouEY/GrcvGiw4e7W68tkCleQdLLcOUU056E/Y1VeBaSwDHPNkRk2bIz1TYMaHt7gAkLboc1ztGpeudl2CjjnDFcpeem/2zW87f3fxJp1tuoLn7bRWKWQl324THwm94xNMCIkJNMzGWL6v/rNb7Wj0u6zrXiFti1zxzft4AUrLyFi6O5lbLMAIm/qydCMOhNVQv3YNHICO6PkzBMPrq8QtKhVBFbc72Nd6eDvLeSL1dOT8rieC9eKhgwvV/BXzGsdoN1gIaiBzzCWorjYo02gjiabnEQn5xf+UxU1L5BxRHnAt0vC8rx1EDePYuGsWrY+eW17WTyHtZzCBgF8LuECb1Bkqkd3GJ/6sooUlvJwvksRpHgBi5uOPt6hZaqc6o/G3B1KEkiwjOwbnrMZY8qlaCl3zkJkCJZ/qzDuzzijPhgZjyQpgquq8FXA7Z1GjYIeze6nMwvCQq71MEnpnFRdtTpMKtF82BlDckmajl3q+7QztKKQH3WqFUVkk6X+1yDX9/jKVrshScPTBFqMue38f/5pOp7T8XmIDyqih3IkusatOj+9Hbz1LJa86VBdKL3Q27awcCPHgELPXns8CrYeHNoVtfWvtCmWxkjiSsSkfFsTJqAWlROUQB5FW+kFUJgZ/Qd1qdyGuNBNO+8vN67tCdpZYI8eDPxJ9fKhFOmxhOkUBYgg4oePsWSM5i9N4AmNjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(52116014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3v2q+9upnJEMaiF+19LXTy7pE6OtF/BJ6CiYG4zL+c8pLF/zHfTSlDw+l6+f?=
 =?us-ascii?Q?JdtA2jYCzhCeuJu0EctGxJNKifehsbXOREsdr26PNYl/2e8pznykTYFSHWub?=
 =?us-ascii?Q?BsQlqRin2sK2hz6mHwVqrnIRS7IlVySBHLItyF+LfDCm4mzRqROdOVo91Y90?=
 =?us-ascii?Q?/6lDiY/1in9Phc7X0WtmqzmILxk5TCq9imgEaECw378MYLgJ6C5bv8RuQu0E?=
 =?us-ascii?Q?ZDKHiaeBKT0k9DBJVCvajM/j+n8TSB5w/8vteLEf/AmfGjurX3C7YflrUHty?=
 =?us-ascii?Q?D2qj9gdU6pj+z2YJ3PGbSzrbeuVL1/J3wttfgUp2u084TPznGsGkzYwOlSJJ?=
 =?us-ascii?Q?0LqvvKbnx/rBGtbUkjnt3irxmpsIZ8lQpbyxFs4W/1OR0fsnl9EqNLF8HXTN?=
 =?us-ascii?Q?eVSbMmW+YblaY+eh+E27cQ9pziiHFw87h/xR7uhn6h1mBXdoO9F6RwQJ4JKp?=
 =?us-ascii?Q?+dB8QupjEQ3L5BgWd9fbcaflD7W6tlvnf59cWCRt7mvv3Kh46/g++UKINY6W?=
 =?us-ascii?Q?4RCl2qyIeMzASapAO/w6MttqXVgSW9pIyppSQVp8dYN52vWPx6AmW3/03row?=
 =?us-ascii?Q?zvVQxyJrhHUz3edXZyXrpZo5HkegICECQHG6VQQO2XK1Gc15qmuK0rBdw0X4?=
 =?us-ascii?Q?+kFUq9Wsdh6SffvthoM6DNr24dUJfaFrpqnjYEAbcFv1BynhUXbQupKwAbe4?=
 =?us-ascii?Q?M59cncEBxjB0vnbzHMFz8qQ7mfmbM9zLx/7r0q0W6Pz5lWJhFOsHRQgjbeIc?=
 =?us-ascii?Q?3xBXjLsy7m1qBWPRhEVH5vsvxJbDGx89ccTgyAFVfYCg0DcjxtCT2z+cENau?=
 =?us-ascii?Q?XkB8BH+run+zpCtTeE2UjFzIUVxJMH9Ihs6UdGdz7xBu5DIIZ8awzF71NTZK?=
 =?us-ascii?Q?I9C33h5z/t6Z2HuSPzCiO+pOA7AxMpSvykUICOTNMJRBc+OrhjB0geLNpgVU?=
 =?us-ascii?Q?zKrjQ6CMAI/SpY1oar1LiFmzTdHEI8Z9D6lQljkip5LcTbke5HzkB1mAmgzT?=
 =?us-ascii?Q?969dLP165Dxk8vEc/IXUnqJq4L5e4YL7iUWcx4synnuzvkY91kMO5Jp/BhIX?=
 =?us-ascii?Q?kzZGYglbQ+0cytOshfhpckzeKWuE0u1/ujE4Quzr765kItHBKLT5SLtrfRfT?=
 =?us-ascii?Q?PQdManEwrEi1Z1u9HFbE/bwbR9Q+JMgfKJ/ehl6SoQpbrY3rlhALplmAQ4uC?=
 =?us-ascii?Q?N/5HkZ+RkUeed2ExT9U1gqOvd5pSfgiJGN9iGyXDY3epVSIAo3Cd0bp70zhN?=
 =?us-ascii?Q?XiFb5jOzf3HOD+Nx4H6s/79Hp2O5ovLAgKk8HIZ4TYpcPDjtYVlo3LSBKwpS?=
 =?us-ascii?Q?enOy7mMMUxvOb1zRvG0Jmp8JkjgFBO6pGRY0Un2qEbjgGtV91LUBXi6OOR+T?=
 =?us-ascii?Q?rYXTkSuAqalf7HNpwRhRgWoJlZpSWs9reqnJZTWwLWDRsMoTgRdD05WLns47?=
 =?us-ascii?Q?8Zos46pNUWbIsORemPh3NX10IzrnHwOuIkMw8A5nJPbbyH2ApXQ4XxM5hjMt?=
 =?us-ascii?Q?Su0wRzsdC4ybaxIFWYVXwSNfM5+WJW/HI7pEAIrfS7mnJNnPINSce8pWkvKS?=
 =?us-ascii?Q?PlOpq6x+Vo0EHinxIfGBROnzmKYguVXmOfSWO7fr3fdE3fuAu77oKaxStONc?=
 =?us-ascii?Q?NY28xzgITLfuo/nj+tIT5l1yXmBkwjSqV6BvF5w74ddYIz3i8NdbuzGtHs7+?=
 =?us-ascii?Q?IDZdFkX2Rrio1jkORcLonKEZxVc+uXllHun4gdrBoxeCSIkEcoEEtTb5FN3x?=
 =?us-ascii?Q?qSYzNYp6Uw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2406fa6e-27b3-41f1-74ad-08df0ffd66a5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:08:33.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDPHnLTNmIhTFvfAUlvkZDRRiNneA5sfJIau1iw4M0Ud8ZuYE3iYQBwOGHVEb+ArscV182vynoj9HgyoXAd/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6755

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
 .../bpf/prog_tests/btf_module_allowlist.c     | 159 ++++++++++++++++++
 .../bpf/progs/btf_module_allowlist.c          |  13 ++
 2 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_allowlist.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
new file mode 100644
index 000000000000..04a2acc508f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
@@ -0,0 +1,159 @@
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
+ * An empty allowlist skips all module BTFs, so loading should fail.
+ */
+static void btf_module_allowlist_empty(void)
+{
+	const char *mod_list[] = { NULL };
+
+	test_load_with_list(mod_list, 0, -ESRCH);
+}
+
+/*
+ * bpf_testmod is not in the allowlist, so its BTF should not be loaded.
+ */
+static void btf_module_allowlist_skip(void)
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
+static void test_invalid_input(const char **list, int count,
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

