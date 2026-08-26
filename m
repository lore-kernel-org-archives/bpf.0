Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9B423E8F;
	Wed, 26 Aug 2026 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750100; cv=fail; b=W0OsjX4Dua4C+pOT4qaqfdKwwuFIANLH9YT8qVQJMPzbXdiNWacSg2yfJlvYXCtIIdCefJtkHOiClEf/4i1Dr6bwzn6CnebW+Fj2NvUn1LYuvFfCrk0I1gvANK1zWWZX2KzqtPfUmyi1pge6ZEapukwvx+PlAT3etuxrmDyKdvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750100; c=relaxed/simple;
	bh=u6pAL8JE8cdhKjIP0p1tOt58jClTDVkbZqAkGgLUPSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvJkqMsQ2vJoxjEVisP86In0Xg/a6wRZFQ3sghM3Pi1vzAutnllhBJAqbL8RI30N65JWWJ3DIwaiMCN2h53WpjN0UpLhNNb4tQINIevWpIaK/tVu2l7/eBL/69iemzvONgprt0bEq+Y/1oFoR5Sg5XitV8Uo75a8aEFf+zACD/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MBUsXA4g; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MBUsXA4g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh+Y+CNTRBZzAcgPm4q0px2RdkHmZYs/DKxpBbE6e/jd23yjQzCPafgM5aynAPA0xOOyCtEbm0UfOItEj829S2nGzH0uicMFSFd4pPQmVIF7J7L0ZqyJyLpkZDYLb6CkjHGN3SduqQJ7mkVcFINoYd5QlPZSbdBVFgE3pFdW9IJKGzlesh1hi2Cfx2mhhAbxO6l82tF30eOXTS+hWS3k3nhnX9xrJJqq+QG/6NfmVqsoG7kVGuDdIj6o+I1aR34bPw+q1oAc6w7bPXybCtjgPQuN1aRvX6du5hike9YtgTX9GdflaPtamfg7+5NICUrUPCX4OfsNIgV2xm0w+eZeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1sJ0fbczbAWA/jc8wEUkFYp/SMO92pgFtSiBMpEVtA=;
 b=BFPs35J7Ye4ilefXKKakVmhqx3OHE39HMsNnDeS+Pl+vRImg29Ze2/p+nCVLFQmxYeAwiKwLrFDDTIrfSXDjQe2qyEpPlQaI5sXaAr/2Wzh04heWSfFmpoNoOGzFjPGd1FdBwbTAIlAeM5CI7Qx2mdoPNwP3u0wUWGVRXCLoW07XlSr6G8GBaY74E/dkg9LCE1BVuy3FsCXi0VocIrdukMMfujZZpgrfD4jRP+LyMNAVBQYQZs4QBlngRGLRhuJRLUAH3q4w2LxtWVLwLCt7mx6Oq0hfv3kkCzD37chkMrMYe73TXYda3EVwTB6z4QVYEpfKSLUft/u9IiNUoUYsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1sJ0fbczbAWA/jc8wEUkFYp/SMO92pgFtSiBMpEVtA=;
 b=MBUsXA4glPlWtBzcFtGIXixaQfxyGhx15HfbtG1HmNIc/RVZwYTrPFMnOMDAmP7qDnifcDN/JhijHC49K4l4W003SuLTbBEsRuueTJ2ovCZY8DFzU9Ou/LFRRLD4VRIzLYPIHUk+pF8nQ73+zqZNco9QGg81d1qPyIb9GKy7ARNqdcp0WdeJpDqa5MFVWiQizYO7V8m8R6aO5ZeIAN0kVfwx2Jp3bsX7zpozq60gnMHLX6tl/yz1cxI8Zozn0AVFFLw+ZaidFDD0wFTQO10eHG0fumkrbfgPT1Ibo7+NlR+aWn9I0gqjG2U7BMkC765kKi8O6iFlSDUsCSQB5gnYHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEYPR06MB5866.apcprd06.prod.outlook.com (2603:1096:101:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 13:14:48 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 13:14:48 +0000
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: add tests for selective module BTF loading
Date: Wed, 26 Aug 2026 21:14:28 +0800
Message-Id: <20260826131428.302-3-zhaofuyu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d3ce9a3-c3a7-4354-56ed-08df0374014b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	iVk5TR0KanZjvjIWvIbsXl4LyfRCrlAGQJFmil9zWXSnt31iSyuh9vajdxnpe9F5pNUQDPhlwbnzxInWv2gIeZLZmpr7679tKWw6C5LwF6OdOZKjBCD6AGrRBymXy/QKEeASnSyVqmdK86WgbEvsU0JFUK+hWO5+rd6PgCrJyhqDrACBDuWodxUYhbHXRH1lMZMzW0HzTGGEI+pxf36zp4AxOzW2oYrWnfPnywZ/ngVcINnDLLS3bmowNXgXARuw+5rONbXfgSIFC6X38sCXwk9S7OPZEamfAFXfLsXruw3XiRB6/AJc99ckE6lxu1u5hUIqAXpjY7WPOOlzmfqYRafKA6BMKZ2RkxSjKSt8ab5888s0Kim6Oes7isH9cMYvU1oJT2eFIcjVN+0S2dQUoEGG7w0hPaCROwFH4+3BzntEkjxnm0wht/Pnxqc0xyt2TIE6JMBjKZ1s5oc47e3B02S3MrCj1GVznuVPBIXOzjQp7yK3uMayyfd9QIT840zDW+8Z22k/8dzXcGmKmt7n7MUQIn2eFIFhohRpxl3z/UiC2UG0eUGuJdmHcQ1eXC38P1hpqQ+xSqZaqPUCuZqvJVOQFNRysbAJPwp5fN+4bw3CbkTP2+6Alcd7atHq38UtThIKsbu6JcjHpGOGNVuYzMGGDYT87jMGPVyqN/ef2V1ADHP+oQlJXEdPV1f91rGYUMytjK5w/qEwa33y8mr2OoVn43AdsPIPJHS0lOizdps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jHYFe/rzrphBRhG/U+Xt5uA85h30dNQkjoHyHSRpNNEXs+tE2lgNfNdgBvTE?=
 =?us-ascii?Q?LU30yXbYMKaeGcQibktB8NyjXFCGgCDblO5V0I0O9re32Eq9nltTZjERnis4?=
 =?us-ascii?Q?m+Gp9ynhGej0tMiLJq9Y69ykMDlVf7CJCvaiI4l5vYwo0B5gY17UwCRSUtRo?=
 =?us-ascii?Q?jF+KD0SkgdXWq3lpReBOxk8D/xpV0WHJ/DpmA+JNMQLSp0kW+bg5TNVeaTuS?=
 =?us-ascii?Q?Rr2TetUAvwB/Dyx9UTV9vZxRbTnvMNP2YWOXvEE2VzMCLomekX9m+G7G9KG+?=
 =?us-ascii?Q?JptBhXpw43vGv02JBxZ/xcmC2tjp9bLbCycShQPCePwbbAFAtxJfM/hKCkO9?=
 =?us-ascii?Q?AOQer7pgJTiy8rdi/erlfEzy7jCo3qy48AY14Px+Nha+MiDmRJkX9go0gbCX?=
 =?us-ascii?Q?5nN5zemXzgAGgWqY887iUK8wyJrWrREGiWb82gUbUJZ8u5ir08hXevs8OOum?=
 =?us-ascii?Q?NYHWQ2L3UTe4dxK6iCZWhTG/QQ5UBmX+/9hTHa31uCgO0zD4pw+6Msynbb4z?=
 =?us-ascii?Q?L+zqPeGFt2Kj64PU96+uopvdme9FufuyKRAt7ME95L6W0KcLtIMWvU+ux8ON?=
 =?us-ascii?Q?WjslKEUeryfAUZ4Ci2GWNnGSFJL+qQP0zyEjPTdrnD5OIuA3MJBIPUZvDkap?=
 =?us-ascii?Q?yFdLpA5dvvRoP/NeiGdo9GqgL6br4U3Se6CJKXe4rh6tsl+O+Fk6tBzgY3TK?=
 =?us-ascii?Q?D+V8+r0kXU8OX0xwZHT1cvdWa+BoFfQaG23fWmq99ChpefluHVNv2oCqHc6w?=
 =?us-ascii?Q?jlwbxOJA0JFux/ewD2DlS+5WrbNYpL7SzbToPahGC9u/KSrLnUiR7GjVsbdQ?=
 =?us-ascii?Q?TjDPnv1xxkLOc3TdT41bsr/nzACUPJnErPfzGEzwlnHrgEbYAMgzl1/OIQ1L?=
 =?us-ascii?Q?ll8MPIRs6zm4/jd3GuLlPnl26L1kotQU9AMmsM7yMQZI/VxigcgKYp7gUZtq?=
 =?us-ascii?Q?8OKNtDlMHNNKfSN1Bl9HUS6337FYRGbQDTQxjQ20zLuLRPsWe7fydslRHgR/?=
 =?us-ascii?Q?utm4FnYg/k9o3u/WQwZzR/DfPYqzjRs3KNaXUuprTMR179e4oqZYgreJBfra?=
 =?us-ascii?Q?wEUavbAF69Cksc49NMQTgvyN2HMb03Es7pquv7EDRUbk7VV2ETIDt8HSgBw6?=
 =?us-ascii?Q?dKgYqvThiG93VnqV61cymqsX7cEuj8xYjBaI5g3MpZDb4rsLp0gE9nUU4LgG?=
 =?us-ascii?Q?vtebYNglMRZmZODB8bDU0jGCjRNGhJb1r9C8/Kvo0qJDzZcU+yRX9+dtOXQ2?=
 =?us-ascii?Q?Y7N09HYw7lyGDkeBOPqEOjRL+y7QUbMESU1aZ1+iG7Xo4V3BSsTUEINllwrr?=
 =?us-ascii?Q?5122bpZ7GqV+zVTjqAFBf9fLzI3GuLbBVr+02fo91yVJKH/ss5LMCkvdnd4h?=
 =?us-ascii?Q?QiqKKnzOBKOvbgdifgD0G7CLtP6pjJJndDadP/5LnRJhpo8m6iRgbwCA+I0p?=
 =?us-ascii?Q?TuMmpbsB+ilmsFH4kvt/E/jRE/PiJ/YvdZ7ENEBU49JLpUZA71F23sMPW4Ih?=
 =?us-ascii?Q?1vowzcD16B0TNmE4pLAdI067pXlaC//SGAsEq7c01oN7Gg8epvcLi6mls6Ku?=
 =?us-ascii?Q?g/RdHNvpFqY+rZx3J2rbZqhX1O0Yvydruk2tlFfbAXBm4hCGFMZ47i9eCaA0?=
 =?us-ascii?Q?li/Tyb0dQZoPzK1ImhR+efYUXr9HVM5ZQfemp/wMb0mxHQa0ZLgjW56YFWZ2?=
 =?us-ascii?Q?AE9nTauzyGxm+Nwwh4hpu22jBdfc2dw35pfrImF979OepIwJPw72lJqjU/lb?=
 =?us-ascii?Q?QeZYK6132g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3ce9a3-c3a7-4354-56ed-08df0374014b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:14:48.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbIr7cyxHPa2y+e/7OzMT6H14NXsI++mCBMaYNDci7E5t44E5FT56q9xfBXybW3r+vBhhsVpvDLZZlO5rBJgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5866

Add selftests covering selective kernel module BTF loading through
bpf_object_open_opts.

The tests verify that:
- the existing behavior is preserved when btf_module_names is not
  specified, and loading succeeds when the required module BTF is
  specified;
- a required module BTF is skipped when the module is not specified in
  btf_module_names;
- an empty btf_module_names list skips loading all module BTFs;
- invalid module BTF name lists are rejected.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 .../bpf/prog_tests/btf_module_names.c         | 139 ++++++++++++++++++
 .../selftests/bpf/progs/btf_module_names.c    |  13 ++
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_names.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
new file mode 100644
index 000000000000..3dc72bef014c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
@@ -0,0 +1,139 @@
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
+	/* Verify backward compatibility. */
+	skel = btf_module_names__open_opts(NULL);
+	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts default"))
+		goto out;
+
+	ret = btf_module_names__load(skel);
+	ASSERT_OK(ret, "btf_module_names__load default");
+
+	btf_module_names__destroy(skel);
+	skel = NULL;
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
+	ASSERT_EQ(ret, -ESRCH, "btf_module_names__load");
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
+	static const char *mod_names[] = { "" };
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
+	ASSERT_EQ(ret, -ESRCH, "btf_module_names__load empty");
+
+out:
+	btf_module_names__destroy(skel);
+}
+
+static void btf_module_names_invalid(void)
+{
+	struct btf_module_names *skel = NULL;
+	const char *names[] = { NULL };
+	const char *empty_names[] = { "" };
+	const char *duplicate_names[] = {
+		"bpf_testmod", "bpf_testmod",
+	};
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.btf_module_names = names,
+		.nr_btf_module_names = 1,
+	);
+
+	skel = btf_module_names__open_opts(&opts);
+	ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
+		  "btf_module_names__open_opts null");
+	btf_module_names__destroy(skel);
+
+	opts.btf_module_names = empty_names;
+	skel = btf_module_names__open_opts(&opts);
+	ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
+		  "btf_module_names__open_opts empty");
+	btf_module_names__destroy(skel);
+
+	opts.btf_module_names = duplicate_names;
+	opts.nr_btf_module_names = 2;
+	skel = btf_module_names__open_opts(&opts);
+	ASSERT_EQ(libbpf_get_error(skel), -EINVAL,
+		  "btf_module_names__open_opts duplicate name");
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
+
+	if (test__start_subtest("btf_module_names_invalid"))
+		btf_module_names_invalid();
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

