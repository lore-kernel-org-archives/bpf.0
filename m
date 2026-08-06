Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013004.outbound.protection.outlook.com [52.101.127.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884A3016FB;
	Thu,  6 Aug 2026 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990074; cv=fail; b=dtLWunNfjLPVjeCJjBAAeylSVjK216EAP3zqbMY4AI/8RyZZFBAazBxG7s39+e5xOHoLq1CXAJwGpt/EaQyrkzcsB7jg5dj9Yriu04qg7dmJ0BpNSewRJ0+Pgjeh42dztuCclQPPar5VFCL8alRZkQ5mP75r1+LInZMh/zHy6co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990074; c=relaxed/simple;
	bh=cD4WE61J+wl5LGna6akH1Il6yO33U+dAhvUTnDyW8aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peznr02O85MHXfFSx3OuyAEp/TTGlILih3D02yFZ9VuCPkZ/OdrmJ/4OqZmOCvCLJuLDmRXG9bXbYshaWxGDANSFhvqzA5I830n9zB7cFMS6AVdr7xLizYkVA1JT8WJ0dYOITdelDnNNcUi6rxwRqdgPnGWlAhRF5P+vUiiiZvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DVRQSSIA; arc=fail smtp.client-ip=52.101.127.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DVRQSSIA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvPuXeLcNZWoNJ+V6yeFCUgisKWm9snDkW2FfEqn1pIN9IYcYV6cZs0DAL18mBLb2dFIBxq6QN1rhYkH81uP8yz0QyIR8gM6TZklxqyMc+CCmutPi97vKqAG5m6jUBnkSJ+QZoYy+kI8iU6Fa2wBW7Mp+7i08kKJyeIpx3pViYD9jdUq64K83H/quTMbTGJ752y33w2pHAU3iZZEQcWgy55I1WorgKylj6p+LmeCmlDb0yuZ3ALW59BAsIFJOx7LLOEoazV8HeFzzp84J75NXceHn0s/2FfI/90OCSDbPd9T+6NqAXMpcwN9QQK6rkNchgpSXcvngVmD8pzmwtYkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYPk1yDmoj+LXORkOZjH8UVO6PsrE0P1pUEkiGHiq/A=;
 b=B1rCi8NI0f/tzebjglCKmTTchml41jsgNPToFNmcdoCgTIb7ktJEbLsHwAH0xATKRaYyAViFN9GN4RnNo2dB2Dmc6Al1IdErD1Ti7J0ht8UO0UeC3M5PD9B8TuIknzho/I0flEB3sdBbwNsTxrjFJGOVDWHt1S0Ra/jpx4PozfxGxjmp+SRuokiFqUyG/w2h1q12oU7XpeOO08jNBjpIQaPnGCnueFy7ymbc5/pbc2Ya27JIrmj7vRvLPcySnjk96vNIyrnq+bMoxg7NKK7INiRwpYolhZMjIHvIWKHsxWMZKEeS9wbNwSaTDmtqPyV1cmVjI1FBLjylafuf0ndntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYPk1yDmoj+LXORkOZjH8UVO6PsrE0P1pUEkiGHiq/A=;
 b=DVRQSSIAwM9G04+mUSnlGJKzS2ok1054sTNFHbxaWpv1Fqn8Vx+Sfz0MhNZ+K+iUHiKVBFcRoRoJAxbpUq28VTVjGdFk1dQGIz3krjmoWy1zeZn9PVp8qZQhAPlLOO++zb6K32htZ6WaOemIi7jiLVkeCh3hYMsoM3oS/tKbI5pZPNdfj4cUIL8Nvy+lnBOYGrBNiwKEsA0GREQfJc9kPVEIW1wAkqOZJNhta64s5llvgc/AMk74foFCMgXmducv9zl6TUJMwsxpVF22h6n5evKA+L4o7A6aZexOEQE2R3JmZurvxsFpZBWRC0VQflvPHe6BXbCWoBCLwjl3iCWwqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by TY1PPFF38CE2865.apcprd06.prod.outlook.com (2603:1096:408::930) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 04:21:10 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 04:21:09 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: bpf@vger.kernel.org
Cc: Fuyu Zhao <zhaofuyu@vivo.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: add tests for selective kmod BTF loading
Date: Thu,  6 Aug 2026 12:20:27 +0800
Message-ID: <20260806042042.3239428-3-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806042042.3239428-1-zhaofuyu@vivo.com>
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|TY1PPFF38CE2865:EE_
X-MS-Office365-Filtering-Correlation-Id: d28b513c-3d6e-490f-8bf1-08def3722462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|38350700014|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o5fyrAcb+pXM5WPfDOCPWYNyapTCnevDa/NO81l7ldO+6dyDWPJrDymYMFX+mOkwBpmwhUgXuDE6KfcAAT0U1Tf7TAyf6R5Sdo/AUOVWV0m98DlhNvh4v9UmOxVsYxUumBaNk/RfcHWGeoATwliQ/FgYIZBrfCoa+D8qvYgT1tK7p2aJEzuPFgoCA7zkOCc78sbpYeB9hHysaxbvwm50IrEsuDNTXYMc23skPOHCpjJKnCPuSPxsbhvgyIFodYfHrbAzEZZ0oGl4JmP7Tp9zK7NuBbml1O75xXCuoAHZtKvbhteuWKw87hiMoxced1w39/Po1fV5M+i8w8c+jd89ErpRmol4vKUjSzCiAsN/v0Hr+vUur3coISNTS1jd/VTL36iiTpYqCOYGXM8VSkJg/WETsrBzA4EjcoUpsCxKkLXVobx4jBX76d8cVSW0TK+7gPcS70yh+Mav50jhy3/nV6kNN0WsCwmtK+4TwNrh9rjaQz2hUCzdUooKVf28KQdzeUbBG6zFE/v6qE5vHm7PKZFAMQCWc4nQ69naWqe/FkpP6BvoJihy7aagL46fpNhnry0oeEr2LlafqFTjN6REtNVX4aZObwDFDOP2jEiBJjE7yJjn8O1vgpnL3C/U5XwIvPZK/oc8T2wQGeBncqN4t1JJzn/ZzxwWUp+6E9/GmestF053MGHqr+CCY5uBrjeiQzVLFNkRk+Q7wYSYT3Q6OcqvfiwjKOJ2pSkFxuhC+HI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0zHhXePLAWkU+yKsHCH8KYVT+zGjYKJOLCrnqX3szlwJu/1O+dDHN4V9r4j1?=
 =?us-ascii?Q?jU3NFDmCyWPniDzbhWsavB+ezqg2PIcjW7sygKH7AABPdjPaNF8iS0mhOz+l?=
 =?us-ascii?Q?ZknRVQNiEf+StC1lzPvRJienVze+lBMClYsNpXBK3o6AzdTSZ2XYb/2vY3bG?=
 =?us-ascii?Q?QH36UfU6Ep7tTj3R+VnBI2fH+7F6MxuajO7EAFFy81jxTMLZNtEKF7pMM7q6?=
 =?us-ascii?Q?gYtqKsSK9GcMzuPYjG/0AOBM2jVZBW431x6Wn2d107atAwFD7Vbo+WYzYTPF?=
 =?us-ascii?Q?tzmUSP2pB6lLOqzik2U3ZnigK8ns5m56SQnznPaNy+BvIrt2q4EUD5rXhrGq?=
 =?us-ascii?Q?j04j6PhWxAakk6S8DRZe0sMohNCo/oK6F0BnHab4rgnW4b9FA2gYAv+yZl3C?=
 =?us-ascii?Q?aRlMQpGd/FUpya4d7vkJgcZQfIqwY3Ri9BLgnmPkmdP8D7eo5aOYGFhpL78+?=
 =?us-ascii?Q?ffjaqQZ24wfx4iJuWezaSjSKT74MyYi9JYr6XcsF3Fxe6dPsqUpWM+QHbckU?=
 =?us-ascii?Q?TgKOIm64oM7vfGiAOs2H2FEVU0NNkVMQWbZZgEzEtlt0stp9tpZy89+8wzBK?=
 =?us-ascii?Q?P5jZa0rzvYm6B1BfOTfZVufg/EMtlOa3Wb7VQf7TbraiH69CdscnQPBSpXFT?=
 =?us-ascii?Q?4ioE3h/QUsqAUwwe/wzFHXoLUpfpbxSkdhkISGMkJG1+18Cjn8MGt2NGggS4?=
 =?us-ascii?Q?dI9y8S8FwJqXWDnLuhRwMnHq8DDZdSFxIkaAuUD0lwMdW8S76Lgej67SEfWW?=
 =?us-ascii?Q?KUS8kJ/sWVv6KRveN11WL5F4kLcJ303ve90mLbh0QpGzmvZqBEqNLJ/2x7AO?=
 =?us-ascii?Q?QrTH05dqW0Ql9CEACorMzFlEg8KSxGRt0DhdizcFSW6Z6AUbySrjS0eSmJjc?=
 =?us-ascii?Q?VZNYLW0AhR3WkHIWuN1i1WQI/VjVj3S0XlQF506H4QqNXspVbcPfShNDePSA?=
 =?us-ascii?Q?Ozn//Ur5eyWOOi0iwJqzwHdpgl77E6jHp74Cy10JPfX1+23L3rfGNYBbDHl1?=
 =?us-ascii?Q?4fH9XRiGFGtAS2jnvFHUBBPvs//aHFml/PH/CCxJ4nPI+uv0UVMZZxqp8SI+?=
 =?us-ascii?Q?J/ghClMWV1Pu6kKY8O3PPvBuxvn7qfTghcQHFieSmdMbXVGfBsSi8ld4D2cd?=
 =?us-ascii?Q?6yK/39Y800/lw2M+Q3i5HIVS0u7WwVjrABMnXmCxT0IZ4IyputDtGGl+XN/7?=
 =?us-ascii?Q?srgz40Il3YmJAHrLsRPi7MOU0ZUIOjeQycwfQ649P90qV+78njLhcwpLeeof?=
 =?us-ascii?Q?TTg1H2t8iM4/vgvZdujle+2LnTEL8S8eQ0MfyM+0wJ8EJTTK653XHkzyS1vS?=
 =?us-ascii?Q?H7RDTc0o8v0d+U/8IIGsdRY0V6+pA+jlP79tVaUJqbPdv5v7lcgNlk6i4ZeZ?=
 =?us-ascii?Q?EVwAtsVm7JeVnY6ejDqnB8FqqD5snbQo4dV5UEIrJal85Tt3Xsmg9bvvXxLw?=
 =?us-ascii?Q?IsvCyCYXGY+MYPQJ6enKgfIZWmtfR3xvsjXoqY0kX0L2u8/G6++i7TddA1az?=
 =?us-ascii?Q?Lpxu8XgkswqqzBabyxM6n9Q/4Z52S1u1VDHQ+gCVJgwi7q99oNUmXKS02ufP?=
 =?us-ascii?Q?4CvEde2HnV4MDjyOMaEq9f6grbSJDiNWgy+bNbRHlu2Z4c8ZYWI+irMa4cI1?=
 =?us-ascii?Q?TaUkGIbAqPZlrvj/kAdg/AYE5JeNAes7z5yNB4unjv8mTh3yQYRZD0cqUKWs?=
 =?us-ascii?Q?OUMkXUfq9jDtaTymDGbm8i+yG59cvQ0mG1+jyQciwCHYjEB1YQzkjo0dL7Ye?=
 =?us-ascii?Q?Q0PHJjj39w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28b513c-3d6e-490f-8bf1-08def3722462
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 04:21:09.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7Tlttxxl9EyD+ChVLSCUfq7CLQNdIYQNSmPMdqP1LwzJ8K86ozuJNVyJ6Cc1dIi/1Uw5tNdPzmTp9pYTRAxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFF38CE2865

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
 .../selftests/bpf/prog_tests/kmod_btfs.c      | 47 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kmod_btfs.c | 14 ++++++
 .../selftests/bpf/progs/kmod_btfs_mix.c       | 15 ++++++
 .../selftests/bpf/progs/kmod_btfs_nonexist.c  | 17 +++++++
 4 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
new file mode 100644
index 000000000000..0608f2809223
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
@@ -0,0 +1,47 @@
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
index 000000000000..431e3273821b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
@@ -0,0 +1,17 @@
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
+/* This should fail to load, because .kmod_btfs does not contain
+ * the needed module 'bpf_testmod'.
+ */
+DEFINE_KMOD_BTFS(_needed_kmods) = { "module_nonexist" };
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

