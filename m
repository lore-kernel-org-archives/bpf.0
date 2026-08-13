Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C035C68E;
	Thu, 13 Aug 2026 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591599; cv=fail; b=d9UWqrGdpcO2Ggr6/hO55LQ8vK0aQSEDPFardPXMyMm5WOlkyRaZwh08ySYh2rV3Zn/6b8WmVRCPFKEHl9zPYzJG5EQ5S0Uzj2A3xl3Eh7GBByr9a1hmihmHlgbJU4gY/PBJFxPHPzx1LVQ720CXJ+Wvxe6QBmv2+tGeDI6NS9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591599; c=relaxed/simple;
	bh=NS0MagrRpiEmmzJdotOcxDIXeZHb40YC3vtgreCzpME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YsDzJohEjUKuyv+3EUCeFcaDgav3mRxypuqC4BwNHQRW917rPQnbPqtD0xGMwaWm/ECVhgVA/f+PbegYnzPztXilA4dotFujRdNJhJPBme7ycymV59sX3X5NrmqX1518969j9sOPf7MlX3WUmUeo8g6V2SYvovDPuw/uNYXqroo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f3v+IFKG; arc=fail smtp.client-ip=52.101.126.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f3v+IFKG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGs81zECCwYLKUbdEB25odJMbFXbCgC8YCCo1OjQl7RzUVABjlhv9R4GjajYksbsGHZqT4m3pg4h1O3bVEfwQIIR3C4iubUbf0aeuF62ykKAq9BBFERDqWicUI3k2aByYknnW/cJ33ekkGG683ZdqKF4WiJEyBssfsFwFYki/mXsURsNownas/dTj+YMytxI3ftdNoR9fsDGsXugG5XjsaCObdSChtZQfgkZWQM4dj5k153ORhEiWv8M9kggC/ryfwF2LMr9CHM1sUOWFv9yod1SoWmudPHkqJFHJpTOYuTvmDXO3S5S16NWed0FpwZKE1odeoLXRcAejVpLQGfm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=386qve2AfUrBDjt4qmJfv5yn3csqEwPqEARmCc+ZfF4=;
 b=V6Lj7MAx/EHIIJUiFA9SQwgxBYwpGd0/zksCBveuD9E5M2kGljTL+21mXQr2Hb98uozCe/jP9hNpJl1/VkRGBN886tTq1lghr3zF1p91bjfqK/vU+W1GLPH4EK8QAIlh+QdEVwtCyeKW6E8AJiHxHlSX611SgdPlm4uESs+6+/c3ltMlbhLi4HKlZp7016WpF8MaN99g4wLXuzlsdjYJrQNHqSzGMPmQaVFjQLUE6fMUNz62xkLKZeZCwepDEfEMrx5Pla+7CDZkxZ4PQwbc/5iwAI5kKbMp6mFHUggDq8tEUST9tnXy9j1utKiqFXsoXlzEWjps74tiR4rg1W5vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=386qve2AfUrBDjt4qmJfv5yn3csqEwPqEARmCc+ZfF4=;
 b=f3v+IFKGQCkzYa0sWS3fq0bmCKNDap18yVXWtrYqbWa7G+zWx6paqhms+j3ibVl6XcutWivrEMcH73YkTMJZdJK7m6C2aVHZfJN51Cwz04JjeDH7hI/eTMgtUUrJSCIcWL8ljDyp8puFP6D2qqpKRpBACrgaAL9//ShB4oQNmzJne3mhtT8euT8jbVxEbtyamKGbHXaIhEQfkXjvSTzQ3ibEifaaI2QhXOe+EYkjHu0BcpcS6smUgp31ym6XeXWBfHfC9ekxDYUOx6WoUUajGJkbYAd9QtkBEyKnkC7ZmljJcoIRO7gigdwXN4KjX88mw7smF/ZVC4Fp6KYDD4koQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB7024.apcprd06.prod.outlook.com (2603:1096:101:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:26:31 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 03:26:30 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
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
Subject: [RFC PATCH bpf-next v2 2/2] selftests/bpf: add tests for selective kmod BTF loading
Date: Thu, 13 Aug 2026 11:26:13 +0800
Message-Id: <20260813032613.2755-3-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813032613.2755-1-zhaofuyu@vivo.com>
References: <20260813032613.2755-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c34f5ed-bc1a-4074-3dd8-08def8eaaaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	G47s5VPfk4qhjAKWcES5fwgzgDEY7GzWbdMg5LMA9UUrLdM8Vwmz3HWu4rz4Vs3s7izcmA8scHMiqE+a+AZkw3NkYcJjfUw8zJ2xVJAbM2HZpf99I/4DQMn5EVgkoy/cKVCQFIX7mBKxiZnxU53q0JgMBAJNDsFdLnfnsNyVSIVP9tQ4hxOpQA3cWQDugxaIlO5diEanzaSw4WRcBzC3dQ6gapCMzW41wpxC2Z6KkCSXrhTuo5LO/OEa1A9OWYddmpKCSXQy7z1QeBodcb1C0Wa0KyS3DQOZhSSvyKFuVp8Cp6w4RdLTx74zzaOBav3UeuGUFU7jsWM8LU4fpBIoBfaXFP4cyvjDrm0K4Tz6Oeunndp/GlFEdVQkRHYouR8GDc7cvynVsUXMeDbewFruRZWNfcD97ipk1mOVDqwFrrO/Skyp2prxybd9EKRyBIMvGhMZlOZRrW35NOO8vUR9x6F5LWtHVXxYGPh8M70GWjNJ2IJiMuSBT/HQlHI2n1xcq+rzeUnjiXM4UnmKlrcwXlYKVSrN5NVjkuZqS8H9eyrtzbNHSff5jKulqiPTv1OFbAFnAatcMsqegNnA2K8JQhAw8AjT1pVdc2nlgQtLxyc+EgQ8n9qgmqbJehF4bBMUoisYg+utU45S7xNcN9DCqfRG28Rx1mhcKCU8WR1yJL6bLdheX+il/xD2rqVwwAI5sqdcMDTujtFp8oFaFr3Am6DWKyshlJv2GrZvmwBhU6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBho3Rmx/YnudhoPCFvFD8SkbkQG+BBpGgkaAx9laobR6YqDDyt0aAgGo7fE?=
 =?us-ascii?Q?NnldnHOFEvYNJFRg2Tb3ZuTGIzaljMUg3PCGV9mX6iHJOx/hjWG+8Q05UvId?=
 =?us-ascii?Q?MmAWpiCR2eYiKUQ5LlQlKYhk30qeuE/L4XsysR3tdmeCtPvpDqCaSZ1OmsxE?=
 =?us-ascii?Q?UZUEcer4i+fUwzCCUoLsIlPjdyV+iP+tINspx3I+ab3kIwqaDSpkhm7vIkW/?=
 =?us-ascii?Q?slyHus8D0jQ+TFLHrNG7Mnv52VXsvy6p/fwDv3Ku2d4bMHH3t+vOkDwldFOo?=
 =?us-ascii?Q?0nvuRpJyQybO2AmX/HGUsGCDd94xNYcM2ui1gOF8WVP9ianSvrffXyo2WU5P?=
 =?us-ascii?Q?yOgNHty66Y0G0V8VNfnOaG/oqVmks4t013zIV88BJXkLyLiKqwJYnblqjJ6G?=
 =?us-ascii?Q?bJOh99/63tJz+X50ei8i+lfuKnNYOSh3jlzRZsN0unGRFbGhJmXFB/iN8nJ6?=
 =?us-ascii?Q?f9b65ZrXM4YdKEXszI/Gw9FRR6OKxeHYH1bKKKfMzxAAygqJpuugaPTSiEtp?=
 =?us-ascii?Q?Uy3KOTO2/gjlmN/kIH3MrMGGEfVKW8cJvg/pd86Cr9wAaaiI9Qt54UAe+NRb?=
 =?us-ascii?Q?yanivLr9yPlEcNMnXJWfdLUDyaZ/RXCOeN3LF7XhyQVM4qHeyxS5/LlTllN5?=
 =?us-ascii?Q?Hl3AZpAQC397zQwh2sIB5FLOo+svDEC64ccfNREfKvJWfNbf5SkSEbjNQyvv?=
 =?us-ascii?Q?ofgnCf9TqA6woI9EPqQss4Utnt2yvT4mJk5rsIgBhQxLnyLgo8Vtj5Z1gYUQ?=
 =?us-ascii?Q?NTZFo8yIwOZwml+wdg8KAfr2HcyTJZOmt6UtFLOT8FhLaKRvNfN0ef0LCBPm?=
 =?us-ascii?Q?dyX4sQeS5XzMI2cjmjgJBRZYRQvUoi0+vmaLCpQCh0d7nLDOZPsoINebtgNC?=
 =?us-ascii?Q?SeG8UKUk0R2CVox487BY5Tr/7eTNHSI6IWNRbiZXIYFnDzGPkVfkiWC28j3h?=
 =?us-ascii?Q?BBMvXNIwzk2eTMjUICuKzmGiv5XVqGgxJ80zgtZYiQET1NIBpAi51DvaugTA?=
 =?us-ascii?Q?qDs6DR73QAnmSn9aMZrNVx7I4XtaPHrDFPhYXFP6x+8Q3Y2EdNlSsfskxrgK?=
 =?us-ascii?Q?aoKtq+4/SInoUcTbjPk4xwWR/6hdcOWrxpGmfFs3UJ/scbQ9jP6Hw9qi1v1+?=
 =?us-ascii?Q?tWdwJA+NNh9qT8Da+ReMgIXG+3c4dS9HsI6yl2RnY9YJE9d9ZXndLyozaghQ?=
 =?us-ascii?Q?sLc6i3xW1/5I/MSWMf1VtvXBfGXjwronyvb3s0+LS97uav2LeEix57++I2jp?=
 =?us-ascii?Q?O0BCuHNeJMRRgKXUgd7U/6TtVncYMVAE1VFm6Ma+vZLZBbxYpgsk5gZ7BhMD?=
 =?us-ascii?Q?TaRKVU7QgOsFW/4zfn4c8lApqO6TCEDPN5NnhWplLEo4JeW/f0N2gigY+g7Y?=
 =?us-ascii?Q?+9fy92hnXI4bstJc1lFiGDSJ+Et5tggWnNGr21SpmlnstK6f4WAMb2aWiBGx?=
 =?us-ascii?Q?esM2nVVgVU6uIgnPTCz672s6MOzaNtzzXMh0Hm0TuKDElfIMsr1KeTP9yR/K?=
 =?us-ascii?Q?rtoya2VaeQZcOp7sqwlmOP1juabYG4GqVZoF1S/IwYYqP4DJg66HfAP8XaJD?=
 =?us-ascii?Q?ugYOezW6kU5+I7m7BYa7nDkqVajs6KvuXEgioqFC24i0SU5L9aYqhFsEVOuV?=
 =?us-ascii?Q?joPTpmtCkAb/yK0qeVfo1BzIAxODfydhMSCd2XSBFeZKEbGrze32k/9V/khQ?=
 =?us-ascii?Q?ana96uhIjpFncc3MMfT9VzsvdOlrQvxDPe1tlSvivVO76Mr8A9DetPI2yIC+?=
 =?us-ascii?Q?1rvsilPjHw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c34f5ed-bc1a-4074-3dd8-08def8eaaaf2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:26:30.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ppju4qQH45/3BgOwxacs2jCxFR0cXmD8YLM/6ROe3iGC93sl13Icp12GtCEzIkeicQLGHZxfKIfBIL64N9/rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7024

Add test cases to verify the new ".kmod_btfs" section logic in libbpf.
The added test cases cover three main scenarios:

  - Valid module: targeting an existing kernel module BTF to ensure
    successful loading.
  - Non-existent module: targeting a fake or missing module, verifying
    that the process results in an expected failure.
  - Duplicates and unneeded: providing a mix of repeated and extra
    module names to ensure the parsing logic remains robust.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 .../selftests/bpf/prog_tests/kmod_btfs.c      | 52 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kmod_btfs.c | 14 +++++
 .../selftests/bpf/progs/kmod_btfs_mix.c       | 15 ++++++
 .../selftests/bpf/progs/kmod_btfs_nonexist.c  | 18 +++++++
 4 files changed, 99 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
new file mode 100644
index 000000000000..d875fcce6681
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "kmod_btfs.skel.h"
+#include "kmod_btfs_nonexist.skel.h"
+#include "kmod_btfs_mix.skel.h"
+
+static void kmod_btfs_pass(void)
+{
+	struct kmod_btfs *kmod_btfs_skel;
+
+	kmod_btfs_skel = kmod_btfs__open_and_load();
+	if (!ASSERT_OK_PTR(kmod_btfs_skel, "kmod_btfs__open_and_load"))
+		return;
+
+	kmod_btfs__destroy(kmod_btfs_skel);
+}
+
+static void kmod_btfs_nonexist(void)
+{
+	struct kmod_btfs_nonexist *kmod_btfs_nonexist_skel;
+
+	kmod_btfs_nonexist_skel = kmod_btfs_nonexist__open_and_load();
+	ASSERT_NULL(kmod_btfs_nonexist_skel, "kmod_btfs_nonexist__open_and_load");
+}
+
+static void kmod_btfs_mix(void)
+{
+	struct kmod_btfs_mix *kmod_btfs_mix_skel;
+
+	kmod_btfs_mix_skel = kmod_btfs_mix__open_and_load();
+	if (!ASSERT_OK_PTR(kmod_btfs_mix_skel, "kmod_btfs_mix__open_and_load"))
+		return;
+
+	kmod_btfs_mix__destroy(kmod_btfs_mix_skel);
+}
+
+void test_kmod_btfs(void)
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
+	if (test__start_subtest("kmod_btfs_mix"))
+		kmod_btfs_mix();
+}
diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs.c b/tools/testing/selftests/bpf/progs/kmod_btfs.c
new file mode 100644
index 000000000000..8b986bc2e9ff
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kmod_btfs.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("fexit/bpf_testmod_loop_test")
+int test_kmod_btfs(void *ctx)
+{
+	return 0;
+}
+
+DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod" };
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c b/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
new file mode 100644
index 000000000000..f445cf56ab16
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("fexit/bpf_testmod_loop_test")
+int test_kmod_btfs_mix(void *ctx)
+{
+	return 0;
+}
+
+/* mix of duplicated and unneeded modules */
+DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod", "bpf_testmod", "bpf_test_no_cfi" };
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c b/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
new file mode 100644
index 000000000000..1638361e5732
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("fexit/bpf_testmod_loop_test")
+int test_kmod_btfs_nonexist(void *ctx)
+{
+	return 0;
+}
+
+/*
+ * This should fail to load, because .kmod_btfs does not contain
+ * the needed module 'bpf_testmod'.
+ */
+DEFINE_KMOD_BTFS(_needed_kmods) = { "module_nonexist" };
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

