Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741F335BBB
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455410; cv=none; b=eAE4nZ7l83moa3sYs8FWksHbhnD3mu0z6kR2iXHHS0V/rfRaWkMlrpfrJQC9ZPy0lvpwY4ogNo/KCJdCj/q2YKCdI4ZPi3oFd/DjvbYDJGxV+q441ycHsD3DCmDnUUKrUKG1jhy98xbwjBiY6ni7QoZAtpZXFwRvXWUPjXs8W6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455410; c=relaxed/simple;
	bh=AQsGU16d8TO5ZuJplx90/9s1OfVfFVbIWsKECsIQzuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQyDtE88P1CUqKLuhBgsQr34bJrW6BzW0kdmJzp01sKkNqXpoBW7u+SbUjwgwA7P85LZjM/0psqIPzyKxpbSy44tne9cBrmXYepG3yUD1fqYtqVl3LxLIgxgKB6nIj0J1PymyaQC+9+jL87Y0S4Ut0ffJCJ+aUMXXOwrqnkvCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=J7L5mE+L; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="J7L5mE+L"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IKB7981471198;
	Wed, 18 Feb 2026 22:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=YDoR84C7H6d9llRoAMI0+st2V/phuC5uB48I55M8cVA=; b=J7L5
	mE+LZR+zO2V0Tms5qSg0a0zqEA+YF1ZLMsr0cnebyFPBONbadxT8bQrFnUEMccU+
	CGxRpl1MGJGTF+a6sdfMEWN2px9acPHvSVUL31SM2N0PjfmTPVVan1tyb2QyGy1a
	rhPOr5CPIPl5g3igWGXFmjyN3m47fa4WoQQp0zyzE77u10/F/zhltvad7EmhgzdH
	W0Il5Jiqb8cVhtzvfJSxuJbfwDvz2ZmH5PG+EYa7WFlP1n2Iele9E+RgPHJ/GDnm
	mSZSV3OVHOfJU8ECqj0JeSwQnsY4rVhlLkJK32Km1xoY7YOHZO1LnVgQBJmex4ME
	J4lz4JJoQIJ3hOgzvw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cd0tavxbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 22:56:21 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 22:56:20 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add tests for duplicate kprobe symbol handling
Date: Wed, 18 Feb 2026 17:56:17 -0500
Message-ID: <20260218225617.354858-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: brtXEC8bacZVhzpGSCSZxgpex3Ofwejw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE5OCBTYWx0ZWRfX74ebF7s1X0Gu
 aFMTwZm+zGGB51/70a8iwvkCo+vNxeZoDp0b5FtG8jXxQ6LcGMWLjGCAeUVh8kP8m2N8B3q6TKN
 GPuETa9qt8pN87ogMHZ25yay0iqo85wRrizhswVTvkdx8Lu2y/F/seSU7vOD5zknOfSTWdUmk6Z
 W2px5bgzR/nqZJqi0NUGODnugkOVcxWT3hJwo8pSAKH79xH8eoKpsyjP2HAR6GQy4PcoTqj5uGl
 1FybB2RDa1vcA9JA5n+hwmxm/dcs0x81ODDITVDTjUMaUxO7dTKYUO+ZC0vj7BAotuSla9EAfog
 DzxAWBmwUrhozHSu3SZ19lqD5pUREXAGO+r5HjDC7vPkRIfU3sd9c2bo8ie3KDFKBR56AQ5lhoc
 VpnbBqAqvbd+BDw2884y0Uat01zXOXGnaeIRpAVs19duw24atm5pCxwmTQ9uOeaWVpNTVJkV0CS
 4YKuzQBjwBNiKhjRsbA==
X-Authority-Analysis: v=2.4 cv=Malhep/f c=1 sm=1 tr=0 ts=69964395 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pl6vuDidAAAA:8
 a=hnS3fS_MpbIQOffReb4A:9
X-Proofpoint-GUID: brtXEC8bacZVhzpGSCSZxgpex3Ofwejw
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11705
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180198

Add tests for kprobe attachment with duplicate symbols to validate
the libbpf fallback using absolute kernel addresses from kallsyms.

- Add bpf_testmod_dup_sym.ko test module creating a duplicate
  syscall wrapper symbol for vmlinux symbol preference testing
- Register module in test and kmod Makefiles
- Add test_attach_probe_dup_sym() with subtests covering all
  kprobe attachment modes (default, legacy, perf, link)
- Validate kprobe attaches to vmlinux symbol by checking
  kprobe_res and kretprobe_res counters

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 63 +++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      | 45 +++++++++++++
 4 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..3d20a4d1d404 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -117,7 +117,7 @@ TEST_PROGS_EXTENDED := \
 	test_bpftool.py
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_testmod_dup_sym.ko
 TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9e77e5da7097..75c22af2f1b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -4,6 +4,7 @@
 #include "test_attach_probe_manual.skel.h"
 #include "test_attach_probe.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "testing_helpers.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
@@ -123,6 +124,59 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* Test kprobe attachment with duplicate symbols.
+ * This test loads bpf_testmod_dup_sym.ko which creates a duplicate
+ * __x64_sys_nanosleep symbol. The libbpf fix should prefer the vmlinux
+ * symbol over the module symbol when attaching kprobes.
+ */
+static void test_attach_probe_dup_sym(enum probe_attach_mode attach_mode)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	struct bpf_link *kprobe_link, *kretprobe_link;
+	struct test_attach_probe_manual *skel;
+	int err;
+
+	/* Load module with duplicate symbol */
+	err = load_module("bpf_testmod_dup_sym.ko", false);
+	if (!ASSERT_OK(err, "load_bpf_testmod_dup_sym")) {
+		test__skip();
+		return;
+	}
+
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_dup_sym_open_and_load"))
+		goto unload_module;
+
+	/* manual-attach kprobe/kretprobe with duplicate symbol present */
+	kprobe_opts.attach_mode = attach_mode;
+	kprobe_opts.retprobe = false;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						      SYS_NANOSLEEP_KPROBE_NAME,
+						      &kprobe_opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_dup_sym"))
+		goto cleanup;
+	skel->links.handle_kprobe = kprobe_link;
+
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 SYS_NANOSLEEP_KPROBE_NAME,
+							 &kprobe_opts);
+	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_dup_sym"))
+		goto cleanup;
+	skel->links.handle_kretprobe = kretprobe_link;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_dup_sym_res");
+	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_dup_sym_res");
+
+cleanup:
+	test_attach_probe_manual__destroy(skel);
+unload_module:
+	unload_module("bpf_testmod_dup_sym", false);
+}
+
 /* attach uprobe/uretprobe long event name testings */
 static void test_attach_uprobe_long_event_name(void)
 {
@@ -417,6 +471,15 @@ void test_attach_probe(void)
 	if (test__start_subtest("manual-link"))
 		test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
 
+	if (test__start_subtest("dup-sym-default"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_DEFAULT);
+	if (test__start_subtest("dup-sym-legacy"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LEGACY);
+	if (test__start_subtest("dup-sym-perf"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_PERF);
+	if (test__start_subtest("dup-sym-link"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LINK);
+
 	if (test__start_subtest("auto"))
 		test_attach_probe_auto(skel);
 	if (test__start_subtest("kprobe-sleepable"))
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..938c462a103b 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -8,7 +8,7 @@ Q = @
 endif
 
 MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_testmod_dup_sym.ko
 
 $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
new file mode 100644
index 000000000000..98b3e085ae90
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 CrowdStrike */
+/* Test module for duplicate kprobe symbol handling */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+/* Duplicate symbol to test kprobe attachment with duplicate symbols.
+ * This creates a duplicate of the syscall wrapper used in attach_probe tests.
+ * The libbpf fix should handle this by preferring the vmlinux symbol.
+ * This function should NEVER be called - kprobes should attach to vmlinux version.
+ */
+#ifdef __x86_64__
+noinline int __x64_sys_nanosleep(void)
+#elif defined(__s390x__)
+noinline int __s390x_sys_nanosleep(void)
+#elif defined(__aarch64__)
+noinline int __arm64_sys_nanosleep(void)
+#elif defined(__riscv)
+noinline int __riscv_sys_nanosleep(void)
+#else
+noinline int sys_nanosleep(void)
+#endif
+{
+	WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called - this should never execute!\n");
+	return -EINVAL;
+}
+
+static int __init bpf_testmod_dup_sym_init(void)
+{
+	pr_info("bpf_testmod_dup_sym: loaded (duplicate symbol test module)\n");
+	return 0;
+}
+
+static void __exit bpf_testmod_dup_sym_exit(void)
+{
+	pr_info("bpf_testmod_dup_sym: unloaded\n");
+}
+
+module_init(bpf_testmod_dup_sym_init);
+module_exit(bpf_testmod_dup_sym_exit);
+
+MODULE_AUTHOR("Andrey Grodzovsky");
+MODULE_DESCRIPTION("BPF selftest duplicate symbol module");
+MODULE_LICENSE("GPL");
-- 
2.34.1

