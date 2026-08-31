Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EC441021
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183510; cv=fail; b=m+F6GBQ8aDfCCpzDr05Lk8KxqEA/dI12geR9RisNvKPiyBLVWS0jXeu+yilTIfPRapHKM8nmAMS4yOdEiGb/54/wUit87eI4MBgwkk4rfqS9IpHtN7w1hM6yA1FKRLFGXIUV0O1sXUjvh3wHzTpruFwL8hnjy64ywPSSZh6VGlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183510; c=relaxed/simple;
	bh=eutBkAyG6gxgIQVlH9a4dof94dZyws2vLYbBlgE8bYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1fLeWLY5GIfbbLlOQviJlojkG3NIdyPv+JW5KpV/3yBupilAFQxUUWk4vZOgzhstM4NE1Lx4WKuQ05/9WCYmzRkAD6/lq1yklTWzEiwINxxIgzrTJMln2nC+R62v5eDBpbevgFUrYRm03BZXGV4Gtzvuv0w6NNTo2/1UF1fSDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GCpG2KnJ; arc=fail smtp.client-ip=52.101.127.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GCpG2KnJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQLqA4SQ7L2Q8RKryawsPLwNIWi2lIoYDo0i5xs/uo4z0yyRyiZvyCJSlHyzMO6qcANJhpQ69wQBI3R4EIq4Q/D88UkeYHbnRjqNlqJ5lQ0EXm+1SkvaZTUhmFWXF5i5Xj8+RJj0mm3zQbpnZRtyldeRBQkWBiSVu7M+532blrO5MbJRC8zksQ0QF5Cyqe1iQmsVgN7faPxuWFnm/nOV3n2Xn8mNFseFoN1yYYYV7XmBUWxAIoUC2k3RuKaPBPjRMDpC0+TbDMo5d5GSQB0mv3zazo6Lll/ktx/XrSUSzfVG3HzfRPin6s7cCXIYTrZ5/5W1ZtCN7iOYWTD4/VFCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7vkcHBSGYbVEPLOOsDIqcOxhCVwvbdeSnLmGxfOlVQ=;
 b=wcRfws5VUdFo9kg3/Z4eX2jXN6SMwv7hjskUSrdCYOUVeGwnRl6suwLKkvHluQwTAxefVpgGwwZgmZ5C6/VPLV6sCkmRM5xn6geIymVglxtQQzcXylsle1pIMtaFKXP3HGAEyefZjDOpSOAdGSIePikxl3xW/NYkZq+KbdWV/8b+oGiT33FFVjJwS6dEJK7L8Iy3d7BZQESrGWgcU7XKv5RZJG9V+7ZY5PPLYUMz8jkHY5XFWFIkqPhNIxNt2Gm5vZ3IM0vousbo96CjQkuZwoC1ToTY9vYxTwZWpTSwTofdTNjnoBNbs3HaHuJPIVucKY70H+7v2lO1MdbDBc182w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7vkcHBSGYbVEPLOOsDIqcOxhCVwvbdeSnLmGxfOlVQ=;
 b=GCpG2KnJ8a1QHjYwRVpnPwy3tfHKqqTjRyR8Iv75G7PnpyC1iPGJJ4fdGa0Arbk47B+Yg3PJzXHcz0VXoOSaGiUhb1x7WQZHz1dm8WnomTiBNVw2qrY5iYQT+aNbTr+DSo+mbmEnpUPeKUXYj6F4lbrZObS/PCCm64Tl3e5sqxvPpKhkHFXIaMVXZXUlZj8OMMPMlAcxTFJwK8fAJ9b4woJpuZ3vCntc+6vE6AxzHTF0Izig0+DruKEFdYql/OOD2V+rI1AxQuS/WCfwqkVqFXR+l0YImsGHZrJDq7OQFf/MFBZCxPgn8HcziNlF6PmR08g3nvjGdaydUGVvDmk5xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TYNPR06MB9224.apcprd06.prod.outlook.com (2603:1096:405:3d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:38:22 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:38:22 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com,
	Fuyu Zhao <zhaofuyu@vivo.com>
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: add tests for selective module BTF loading
Date: Mon, 31 Aug 2026 21:38:09 +0800
Message-Id: <20260831133809.1161-3-zhaofuyu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6b9eda2-f425-44ce-3dcb-08df07652033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|23010399003|10067099003|56012099006|11063799006|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+u8d2KIBltiP0BGs7i20CUUN/fPlgt3hlIQSno0S5P2sd2egPRl5WF3HpIhbv6KDWpnbhmHnuhHvfmtxcPfFgWb/P+nBg0y3QAB7WfM0aZ/7szVxpddIu5h3tw1gXfMw5cMb+w6m93zjLfybLV9jLCue2/Qfq2gg/8FfG9ZDaekAws564nMypkH2oTlyG1s5joaZyb2yDFdqiVUIFhBJz3jRVcVmxc6bNsTIrxWexrSrQ+owdPDRtnCZtLWytkgGRrvXFRA4rUJp2V8ih6yPJOr72PKUdIoqYmSL6+QJBrvpoB39yBWHeCyCzNMovuSJhGUeeAF+O5i05Rm5zkH4r4Vn4uIOhnkgAlzzA2ppYhz2oPbUFbDlOWsakQ+idjxgyslRM4VBCKl36L67yHugr/dxfixLHidkFCFIs4KlHVu04i+9MuJH0MqH6u57tPJsWCoVxEKXZARI7vBwVjqaKkbEZZqzN0u2lWQnNTyKD1OK40q5RlLHBakI8v+BfmUu3ip6PKMbnqO1tn1HJg715UbnuW4crE+I0Gu7w8Bxz/aecLpK0HJrMkw/bQjrCio1sHKogXeI3IsvnYjyfXDle9VVKG8WA8kp39kI/HTbxaroozPkIPETl0X4KggeC9PDbDP4lRO8iVJQswyfFacuwSEjCjkp6UKz5Fnjg3pnz+T2Cst9e62IJcLOOeK9hmPZPFZizXaDP6gCO7qpAJLD9zaFrX/djmh5jt0/fsB0Ypg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ns7PEhLRtUME+/+xKExnHcDV0aj7dGXxoEsLb78ZtXL3ommrY7prRa1y6Itd?=
 =?us-ascii?Q?6KgrGoT0Xii2DhlzbjVIjStIQkbqR426zDI6Ql4bjxkEXZ6EKC1C563nDiJ9?=
 =?us-ascii?Q?NHQX2JczKJbw0vHnVnYzdI25LKxEjySPDNYlSjI7jbVee9f/LpaqNglJhf8h?=
 =?us-ascii?Q?rbTvDQ5UqZiors3qOBlQ4RFXTPhTP9VD0zOAW21eJJPTBF8bXNz4dVaDaZEF?=
 =?us-ascii?Q?tucG5hH2b9vykM923Bwzp2G00qKyZIPIoBNonaZVJkpbNulO1sPsHP1eOx+i?=
 =?us-ascii?Q?E2YbbmaqW0bTZFSXEJZbQYE1ZHaEi3VOP1+7FSJgnAQOjClpwxNm5AMvFLB1?=
 =?us-ascii?Q?9QUC2u3Sv7MFawyKoHBTzDJjY/OP3kFvyx/NWa1sBdr+IDo+1P/Lx5NR1p6B?=
 =?us-ascii?Q?wMo6EkWMArZL7I/4K6zdf2DYKt9NQtp5DSb0YiLc7pYPKCrQc9fHWqSGdk04?=
 =?us-ascii?Q?coijHHV7vVqjlQ7PgCl553ur0EI6DemG74uRpLWY8PnCELhBBZL4oBfEKQ/L?=
 =?us-ascii?Q?UySJphkZlOzJneW7eavneEyYMLnn5CuuhJvO9nj/D3g5fzMYX03M2Y+ztzVT?=
 =?us-ascii?Q?Z/VxSHDsh1Auj/TjvJ+H7Mr2tV4l7oWD06I465Oz78M0b4/7bfXUZ/HkdyJF?=
 =?us-ascii?Q?we5pwqX1KzOLsn5x3Jny+dpx8qpT+NTXNkg1YJ1c7akAe6hijBIUwPxft2NR?=
 =?us-ascii?Q?0fs76i59BN2z73/pU8n/b9I1kB41DIap+OZboqp/vtOlkBesGlkGeul+CpBi?=
 =?us-ascii?Q?aKLgM0eHb6m4izNhrNDGPHYXtRkqRfEQBENU3cpakLzdhG1Ckan7rA4vNfeH?=
 =?us-ascii?Q?hA9KvW7QhKT7xvxiAa/Z7RFWCqV52LPOwUihEmEf66+1GL2g3HoU7jn31XZ5?=
 =?us-ascii?Q?tZ7mX6xqyc0If21P/H+VFkPt4HBPlnCmh7CPXFGY2yhWeeAMOIi4z4Yths2A?=
 =?us-ascii?Q?+jt65rt1/OoNXvVys3YX6hwetEmLAFmS1tZrULTKm7eoY43vks3/0fQtmGa0?=
 =?us-ascii?Q?kVuizP+syua44Y8uaa0UPKJp9KA1z6FgsROi0YcanWE0Ko5n8f03AC3lLdfX?=
 =?us-ascii?Q?5m8imv+qC9YzMcvElMpgFUiWCIcfbEJc4eihdpItNjRYItKkYH8Dk/TSL5wz?=
 =?us-ascii?Q?aWJKx84XHGfT9nNod41pxIJaTWcNaJbDTmmnuG149fKiNvU+BAZaCZLMzpAT?=
 =?us-ascii?Q?B7fgKu62Q9sMf7ZZKFBGolCHTLOmScKAskh9BFxVAJQjV0uipbwU0ELwbenI?=
 =?us-ascii?Q?LZMkw76XAcqv7ArD64qlPnAda3C1+RRZzGZXpfmNFlgOK29L9fNzCwuZrtQg?=
 =?us-ascii?Q?UrGFIHqeEhDRIppQTYF67H2YH09frPDMf/JkjXMroVnjS4XI5YXtSnSifZaX?=
 =?us-ascii?Q?sKo+pgNRaMhFmQmzpedRCS4wlgVmrkc/haHTpXYNycfgX9iACJ60OUzLhKyw?=
 =?us-ascii?Q?srFAMkaD7GOAocbPiYG0qTqQzm8NC8Rh/pfU2widmfZ9rc/YfOUMwOqubMg3?=
 =?us-ascii?Q?vwk03tas2V1SnMr4I8iL0f+t3P3j6OwbPv1680rIBpFSZ5Oj60jFOrX6+vrN?=
 =?us-ascii?Q?aUnG0bOe84MPl1H3WcXvNdMSI5hO6A42rvplJntwXe1yUfJS8DgbqqRcHJbO?=
 =?us-ascii?Q?U/6tE1AyZ7hPAPSpzBvGnDb4vbQm8fPAZuB5wghUyvNwP0E9aXZiHGgIVlkG?=
 =?us-ascii?Q?yeKWEsz6aSZgsEoVBHAcsNXJX81cwmG4ArPsVEL/RLpGvlQMZw+1py24G3Kw?=
 =?us-ascii?Q?eXVGMfpwaw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b9eda2-f425-44ce-3dcb-08df07652033
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:38:22.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF3jBrnIIhmuxzp2DUiDxODAKzNbPvIfoJLrpPyVb0T9U/n4KGT30lYNhRgcqNzjI+ze83B+fwsGJfeBWWqo1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9224

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
 .../bpf/prog_tests/btf_module_names.c         | 162 ++++++++++++++++++
 .../selftests/bpf/progs/btf_module_names.c    |  13 ++
 2 files changed, 175 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_names.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_names.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
new file mode 100644
index 000000000000..68f4a8d73560
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_module_names.skel.h"
+
+static void btf_module_names_load(void)
+{
+	struct btf_module_names *skel = NULL;
+	int ret;
+	const char *mod_names[] = { "bpf_testmod" };
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
+	const char *mod_names[] = { "module_nonexist" };
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
+	const char *mod_names[] = { NULL };
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		/* Non-NULL pointer with zero entries represents an empty list. */
+		.btf_module_names = mod_names,
+		.nr_btf_module_names = 0,
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
+	struct btf *vmlinux_btf = NULL;
+	struct btf *module_btf = NULL;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (libbpf_get_error(vmlinux_btf)) {
+		test__skip();
+		return;
+	}
+
+	/* Ensure bpf_testmod BTF is available. */
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (libbpf_get_error(module_btf)) {
+		btf__free(vmlinux_btf);
+		test__skip();
+		return;
+	}
+
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
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

