Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43934429CC8;
	Wed, 19 Aug 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130291; cv=fail; b=D7cdcpuA+MPy9RqeHCc9E67oebRts/Y5EV6IAaRJVlIVZy04L3KdcUwEnuULKu47HSepTH998chG1nJnLgyIhcHzNqYjqVvbwd5I0E7Cw2cdJ7BHRmrgfuUCDxivxqwyMG4nSTmaOx3Ze80oKAd+f87zjZ0sN45S0GgKAV2SzDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130291; c=relaxed/simple;
	bh=5HqsWh+LYVr0EeV/JPEmL6+2PWBj7RTbvLe5f+Xy0sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPro25IORYrep6RpUZcLJuReaPCLor1YI7ejDlYKcpipdwp/oUMzTRcdick0setDRbJoOn+G9MyNmHIttjHkN4xbAmD8Z5D1obheLeKZgEOkIZTLSY2nGKZITkWWfvrfCpizuZW5+cOv4sC31184w/Gjvz4/YYCmQujLdWH+d1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ofvpSlxw; arc=fail smtp.client-ip=52.101.127.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ofvpSlxw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWsNx9pphBEccrTahMQYktzPWUE+AjaLIJGwX80GTf/2CRQ6TEY1igVezz6qiJxs6j4uNcpJXZ3NQoIgr5Zi+9i1dFXUENP1AFJ4z7MlLoRHJWBOFfGgirazFNok5pYxcNIxITbuvhORxjTdHJ+IOvExr4/RmOeEdl7BlO6TNeYb17p/uG3kbdAhAdoec7axUGRDGNoVpjrQsNcs60+gk5/k3ztcMMT25JA7LGaeMTNye01Mdfu0unuTEg2TcMCIZcZX3xh000exSkvGnVmbnzRmE6wNw7rVIIzXJbIP3CXdnaa31UNhNzIbz3wP/zR1FoseTpUZHk+1bMNqeEErjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vS0L1K/sQfJhZmaRoIw4gsBhCSUdswH0GiQF9NsCvo=;
 b=i6IKNqSb0HZXWgAg1NJlixmslbB3d8cFRFNarVLoh1YTa4/8CQq+2VimWfQurOKbXeGRabGZNpjmAHPVLkRFtua8vMAJuTaO5V5RNkoPFmoXduzksBJUX9DsN0mr48aGRwO8MO6PyT3nvLNGTFqDd7t/1SDdTW5WIoHx/ihhg5eNlc1RFNoEepao7Zq3J1ulWtwz5Va18W2xRGpfTnnQcu75Sxn5t1FqnSihY2C780xqd+O5HnsZtGtx21iD0GwrSWtEIYnXb0NSmO8IUwTkGe6Ri69cU6VwXyFfN3iLduzalMTlapuZwcJYYUATUzB/ybHfZ1Me7vVpqSkKHUXYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vS0L1K/sQfJhZmaRoIw4gsBhCSUdswH0GiQF9NsCvo=;
 b=ofvpSlxwkfEE5SPcJUaQKL66SzzJw0UHbhcOa6PCyPHF0k8jjSows/WQgwBTR1pQQ9Wx3d0YtE0xenqU/9X60ZIJ93ByJbZoVu+frFRT3dk5Rd1CtqjWviK+WwnqEEhnXVX+juLnEDzPup3bqMXca9ms5dFB0c1UGGB3gqzawkxyhDTgWq77uV+aAzRDOirRTOWoMwO6SXmspK+utkZ3gqapkg0LhUjzjmdDu/GVl6ETdqDC0J1+AzxDEfcclkDTepH3RRVheEwRY1H597KpZQXmNLmznf4sFJYDYMgJKlT8iATm1MeKKb8QczYAV8uA7SLWJvHuuGRg02d+Mrd+jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:04:47 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:04:47 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
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
Subject: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for selective kmod BTF loading
Date: Wed, 19 Aug 2026 17:04:26 +0800
Message-Id: <20260819090426.267-3-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819090426.267-1-zhaofuyu@vivo.com>
References: <20260819090426.267-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI6PR06MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: c63e4959-5cdf-4a67-d2aa-08defdd0eaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|52116014|11063799006|56012099006|10067099003|6133799003|18002099003|3023799007|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	a2zdc12fox8eL11GeLzP2PydSZ+MzUASbn2LZSYuTIEWdQc68aXZgo0UqhvWnmyit7G8+mAXvjf/R3m6r2gkO4SkAY8qzYhmnw+q9pt+QkfqRvplJ6FdWanrUWa/sdPgPDzfNCN4fcPAsrYWdhGa0LB7qJLfEW9fM0LS0VJzpzs3GZ3r25C6oPuOv0krWI89aghi3jThxvoCNvLFh28NIk8As8fEY8fFS2fWRyEZpMmLPxjm1AMNOkiFvnfKCxO+XskxnSGY24pxtxDgqAE2OeZtkvD/pNBc4SBApzzgCpGdBSwkkzceua5xSZ1uJDXlFH/5jhOka7SPu4PRXtcM7ZVzU1d7hgW3jb6zL62oKZmT5aQmz/Ghab3znyWh9bz3XIFzqIIH0fNkDh5MV5ehLTj5LsgYGkutBOi32dQlXiLKUtCAIi354k0cLHmVf6UiY+weHRCcDL1Ljx0DliBayeGxJrH8wpnQ83dyjyhOYDg2chONjj1O53t1YkrgtzqfLI7dmGGK8rfZnhEOP9IiMmRudViFLICetwtD0WyupD1IXqPMtX4AUS++SKni/EMjVLsCUdNSRVNIKr1zFTBLicDL6pCYNJNoEu8/WISxgtrLQvo1Q5e19aufJ7roGMy1/6waD+AQVYiqyKmws6CAfA3LLaAcoa2V6bTM+Ofa7mtwKsWWupemFFqOej+pRvhDEO2k1ml99H89kDvWrXzl2OBfg/2BgNBFRbDCWkf/yxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(52116014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63VesfdmJuvhv/sdFfa2sljXG/5sFpQW/wu6LUJwKws2eKkdEJtbvKCztzxf?=
 =?us-ascii?Q?cUcp00NKlP70lx4eiyZoTNavk8e8eJIgDR2PeKHXCzkedF05JuSwTEYxWNSx?=
 =?us-ascii?Q?oXvPE74W5SF1htV1sLqYs46+23Zmyi9KcGD6OmTVWwPT9ykYMNELhfucIa8x?=
 =?us-ascii?Q?FhYS7aHa34JwTq8lHErnwZLXbqBb85Z5r07Ipo1AfcMd6M/kaL25Mcm4pCUs?=
 =?us-ascii?Q?+iqDmDwei6CB05s0x4kpXt+oMCOtELJr00byFu9suMAknVqX1skIPWzIQPX9?=
 =?us-ascii?Q?g4TRHkyCY3FlBXoM+bIHIsEXq4MqEdXMaBE7c0Zf9A2+t3Z+MpYBHQwhy8ac?=
 =?us-ascii?Q?YpEzrZq+XM4EWjBip0JrydpygrqR+PvFCvIjUNEdxMVfbCN3jPRYX+G4dm63?=
 =?us-ascii?Q?AF6tm0UtJVMuGsl/Isf1K9/nQ4nBmJRHMSIsZqB21X6t1obSgvqaGDnrqttu?=
 =?us-ascii?Q?M2b7NPjfFEP87j5dHH16WkX8lVxlpuMOhss0O76QXhjNgaMnh73S/2890Maq?=
 =?us-ascii?Q?D/p/+e1lRKRxcvKjGDccqDQvvJ2djMulQ1Z+qTCZnMG+F1BG6cpidiSBkPes?=
 =?us-ascii?Q?KQ0jSruVZTklu3GxjQ+iNcLj/yH0g48SoDFtWvLeGVpZwo+8YCpNvv9fqtzJ?=
 =?us-ascii?Q?pZmjATN6lGYT134CWGn7OxdyZzanLd77J9f3avxRny2SoPd6oOx40fefa3d5?=
 =?us-ascii?Q?re9vg6Nny8OhqmCcpBl15IXt6KvDH8hrMT+HBHxQHk8JKqX5p65TJvPGumTN?=
 =?us-ascii?Q?nYH4pgYxJ1u8Xnpuv8GJPClzuHS9w3sDOK5ADqchhTgKTG7nqFzDY0Rqnxj7?=
 =?us-ascii?Q?sx7KKZQmtk3fv+sEvuQvgAreeZ24aZ5GWs5TL35b1984Lx/rASJ04krX8j6R?=
 =?us-ascii?Q?Rmg6cOtDpffEnnbc3mdplQA4yDWr8rMZep7zGkAO77eNT2L+EJRlc7WAl2sS?=
 =?us-ascii?Q?VvHv60n+PT7jnwGHSmZCxk+VGL0J0ixCsbn4mGND1zPozlYCPr+5zbShs40U?=
 =?us-ascii?Q?/CM+I43DscxJL/t4X/qkHNXsdyex+SgQKdBrNoj8s//l76sSNZwKcaMvatRg?=
 =?us-ascii?Q?P4N6ISfa6cytVLjnXwz/mqc8g1R7Pucz+B5/mRp8VL0IAFI6vA7WjqVDOJvy?=
 =?us-ascii?Q?vMskZZjCpfEOKS0SHhDecuHP+sdOrGmsvHvJWWDC90OixS48adgoSDcCaVhw?=
 =?us-ascii?Q?NLR6gDjQl9kJJGXnu5kx8ZZ1j7+VoVigOpfdUGDiOLAM0rrMwLz2lcfbPxA9?=
 =?us-ascii?Q?d0h60PF+E/qac6R9VNVYG1PlbKGzXlRNCMn+MK7gtDtftICnaOOxjdV+XgxZ?=
 =?us-ascii?Q?BNa/xfL5wC9o1kPcfST3wlPId58637f2RBKS5ANzeogcWpMVc2rLS9ExKkUO?=
 =?us-ascii?Q?o/n33DuTwK2Z5dy71qWPuLxBhEHbS50LWmSJO817t7J7qyqFWXKCJixql3Fw?=
 =?us-ascii?Q?UXJbeqgJH3vt8hE11/WlXtZHAXbaEhx2hj6oKEa+0A30t/u95ZYXmOpAhTwG?=
 =?us-ascii?Q?qfr38cLsnTuJptBuOe/3wEiNqH4gh1mjD+hulNBcamoRxNmEuDWdj44vDTNE?=
 =?us-ascii?Q?Z/D0IRPLjAJcC2U/9xCBh4owPOm97MlAXwzFoU5lgzV5vQ7fOY6c5cTzCFfj?=
 =?us-ascii?Q?0LBGvC2t7Xd9EvvKOVUdeKa8fJCwXPCZlQWqfr6/oRL64Jg0De5LgkR4cLl5?=
 =?us-ascii?Q?uIWuPUnt+FEU0BUllK1uH80WzOJkFVueNFuzDXIYDA8snmcdWtdfLAbeXjfu?=
 =?us-ascii?Q?7NSZ4fYN5A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63e4959-5cdf-4a67-d2aa-08defdd0eaea
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:04:47.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM/mjeIDJrwN9JWE9rRtXUYQu2xBH1QxdEMYQwzOSD+xauFCjUHZbvHmfAuQVv2qhtjNdSSWxckiuQBlFRwkoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165

The added test cases cover the following scenarios:

  - Valid module: ensure loading succeeds when the required module BTF is
    specified.
  - Non-existent module: ensure loading fails when only a non-existent
    module is specified and the required module BTF is unavailable.
  - Duplicate module names: ensure duplicate entries are ignored.
  - Unneeded module: ensure a loaded module whose BTF is not requested is
    skipped.
  - Missing count: ensure opening fails when kmod_btf_names is provided
    without kmod_btf_names_cnt.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 .../selftests/bpf/prog_tests/kmod_btfs.c      | 196 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/kmod_btfs.c |  13 ++
 2 files changed, 209 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
new file mode 100644
index 000000000000..61d2845a731f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "kmod_btfs.skel.h"
+
+static bool btf_skipped;
+static bool dup_ignored;
+
+static const char btf_skip_fmt[] =
+	"libbpf: skipping module BTF '%s', not in kmod_btf_names\n";
+static const char dup_ignore_fmt[] =
+	"libbpf: duplicate kmod BTF name '%s' ignored\n";
+
+static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
+			   va_list args)
+{
+	if (!strcmp(fmt, btf_skip_fmt)) {
+		if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
+			btf_skipped = true;
+	} else if (!strcmp(fmt, dup_ignore_fmt)) {
+		if (!strcmp(va_arg(args, char *), "bpf_testmod"))
+			dup_ignored = true;
+	}
+
+	return 0;
+}
+
+static void kmod_btfs_pass(void)
+{
+	struct kmod_btfs *skel = NULL;
+	int ret;
+	static const char *kmods[] = { "bpf_testmod" };
+
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.kmod_btf_names = kmods,
+		.kmod_btf_names_cnt = 1,
+	);
+
+	skel = kmod_btfs__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "kmod_btfs__open_opts"))
+		goto out;
+
+	ret = kmod_btfs__load(skel);
+	ASSERT_OK(ret, "kmod_btfs__load");
+out:
+	kmod_btfs__destroy(skel);
+}
+
+static void kmod_btfs_nonexist(void)
+{
+	struct kmod_btfs *skel = NULL;
+	int ret;
+	static const char *nonexist_kmods[] = { "module_nonexist" };
+
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.kmod_btf_names = nonexist_kmods,
+		.kmod_btf_names_cnt = 1,
+	);
+
+	/*
+	 * Only "module_nonexist" is requested; since it does not exist in
+	 * the kernel, no module BTF gets loaded. The BPF program then
+	 * fails to load because the real needed module's BTF is unavailable.
+	 */
+	skel = kmod_btfs__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "kmod_btfs__open_opts"))
+		goto out;
+
+	ret = kmod_btfs__load(skel);
+	ASSERT_ERR(ret, "kmod_btfs__load");
+
+out:
+	kmod_btfs__destroy(skel);
+}
+
+static void kmod_btfs_dup(void)
+{
+	struct kmod_btfs *skel = NULL;
+	libbpf_print_fn_t old_print_cb;
+	int ret;
+	static const char *dup_kmods[] = { "bpf_testmod", "bpf_testmod" };
+
+	/* duplicate entry on purpose: libbpf should dedupe it with a warning */
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.kmod_btf_names = dup_kmods,
+		.kmod_btf_names_cnt = 2,
+	);
+
+	dup_ignored = false;
+	old_print_cb = libbpf_set_print(libbpf_print_cb);
+
+	skel = kmod_btfs__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "kmod_btfs__open_opts"))
+		goto out;
+
+	ASSERT_TRUE(dup_ignored, "dup_ignored");
+
+	ret = kmod_btfs__load(skel);
+	ASSERT_OK(ret, "kmod_btfs__load");
+
+	kmod_btfs__destroy(skel);
+out:
+	libbpf_set_print(old_print_cb);
+}
+
+static void kmod_btfs_skip(void)
+{
+	struct kmod_btfs *skel = NULL;
+	libbpf_print_fn_t old_print_cb;
+	bool testmod_unloaded = false;
+	int ret;
+	static const char *kmods[] = { "bpf_testmod" };
+
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.kmod_btf_names = kmods,
+		.kmod_btf_names_cnt = 1,
+	);
+
+	btf_skipped = false;
+	old_print_cb = libbpf_set_print(libbpf_print_cb);
+
+	/*
+	 * Reload bpf_testmod after bpf_test_no_cfi to ensure the unneeded
+	 * module's BTF is enumerated first and skipped.
+	 */
+	if (!ASSERT_OK(unload_bpf_testmod(false), "unload bpf_testmod"))
+		goto cleanup_print;
+	testmod_unloaded = true;
+
+	if (!ASSERT_OK(load_module("bpf_test_no_cfi.ko", false),
+		       "load unneeded bpf_test_no_cfi module"))
+		goto cleanup_print;
+	if (!ASSERT_OK(load_bpf_testmod(false), "restore bpf_testmod"))
+		goto cleanup_module;
+	testmod_unloaded = false;
+
+	skel = kmod_btfs__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "kmod_btfs__open_opts"))
+		goto cleanup_module;
+
+	ret = kmod_btfs__load(skel);
+	if (!ASSERT_OK(ret, "kmod_btfs__load"))
+		goto cleanup_skel;
+
+	ASSERT_TRUE(btf_skipped, "btf_skipped");
+
+cleanup_skel:
+	kmod_btfs__destroy(skel);
+cleanup_module:
+	ASSERT_OK(unload_module("bpf_test_no_cfi", false),
+		  "unload unneeded bpf_test_no_cfi module");
+cleanup_print:
+	if (testmod_unloaded)
+		ASSERT_OK(load_bpf_testmod(false),
+			  "restore bpf_testmod on error path");
+	libbpf_set_print(old_print_cb);
+}
+
+static void kmod_btfs_no_cnt(void)
+{
+	struct kmod_btfs *skel = NULL;
+	static const char *kmods[] = { "bpf_testmod" };
+
+	/*
+	 * kmod_btf_names set but kmod_btf_names_cnt not set:
+	 * open must fail with -EINVAL.
+	 */
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.kmod_btf_names = kmods,
+	);
+
+	skel = kmod_btfs__open_opts(&opts);
+	ASSERT_NULL(skel, "kmod_btfs__open_opts without kmod_btf_names_cnt");
+}
+
+void serial_test_kmod_btfs(void)
+{
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("kmod_btfs_pass"))
+		kmod_btfs_pass();
+
+	if (test__start_subtest("kmod_btfs_nonexist"))
+		kmod_btfs_nonexist();
+
+	if (test__start_subtest("kmod_btfs_dup"))
+		kmod_btfs_dup();
+
+	if (test__start_subtest("kmod_btfs_skip"))
+		kmod_btfs_skip();
+
+	if (test__start_subtest("kmod_btfs_no_cnt"))
+		kmod_btfs_no_cnt();
+}
diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs.c b/tools/testing/selftests/bpf/progs/kmod_btfs.c
new file mode 100644
index 000000000000..b96860d60e0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kmod_btfs.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("fentry/bpf_testmod_loop_test")
+int BPF_PROG(test_kmod_btfs)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

