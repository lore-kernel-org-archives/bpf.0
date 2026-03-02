Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A191425CC3
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470161; cv=none; b=THc4d6Qn36NxV/Ibgwq+zQm8QJbPRPvzNartn6j+b9sIuvHwQEPAy2SUtYwJWD5Voa5x6LibDMBy1sxWSrvWQFjxsz3nxT/uLWLmx+D7e12bM5BScNLZ6XWnkeQFfLxpygyiJtOHmihGF6FzS92UC5dWeckJvampjrKmKqjLhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470161; c=relaxed/simple;
	bh=CqVyYVe83yZ/J8/temgLe/uex1EJd6Z9u49I7+u+Tqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNAEol5Jg2MrqTuSq5GNgJBiGZZdioTTa0mIneT3bWkFv91zetCmHziFfssHNksUwtTkOMMWlUJGhvhxheA7qCZQQnLo0D7N6Nwqtcnkvb7/sAgpNGrxoyGSWfTA5l+6Qza0jFStnwWxqamXbChuGL1q0HzFq3jLRJZsIqD8dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OYjDof6y; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OYjDof6y"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622E7mIw1677322;
	Mon, 2 Mar 2026 16:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=P2vx71drpZ3Wi8z2rYYYVUzmSRlvhwfPJRBlP1kZ+Ec=; b=OYjD
	of6yIGAIo8BDpWhmV8uq6tVQ/XPF7cP6Bfv/UxUtzwhjhFpF9O2moVT5lGQPJ6Of
	1c++PtaBv0aErMdU+d04pQEKsc20UwTsl72CyHyImkhKUdjdHGZTJQbqlUCvNqiT
	NkglxBLmBwYJB4BaUumIJBeuSqoe62ynNAdiexWS1T0Zkx6fNLQM/n7er57Wdld1
	P7CMatTjeJSZqwLTeNgegTVVsEeXfE4ucOZ19h2Q3CWRCCv7hgTk0wiB1teKZBIs
	VOK3St6m3ehXKZVVrTng4G2V+mK9vS8czmgY0/qRwZpc7zst1fYlgydZBbpYD0oN
	zObInO9+uxvCJePcUw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmb5uw755-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:48:50 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 16:48:49 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for duplicate kprobe symbol handling
Date: Mon, 2 Mar 2026 11:48:46 -0500
Message-ID: <20260302164846.36713-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302164846.36713-1-andrey.grodzovsky@crowdstrike.com>
References: <20260302164846.36713-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: 6UwOm2LEeefpzVMCnnRh8OpyCPVksm9-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzOCBTYWx0ZWRfX4hwoY+nbq23o
 MD6J3beUSyVaitDjRDau1jyXRn88jzjJZQUQhMwp3K+JxIFhAkzDJ2zvBDJIochr0TqDQxKa1Vj
 yPyez/fctBP0vBJOMnF6jxHMM6DEXqXmiISuKj4V7durU+W7p5AdxmiKK1yN6Sa0J3O8wPLrfHu
 l7PbsxD+Z4d4/kDQJXh8UXLyJOYjODllS7jbjcWRGGMyk5gJt7qPesC61uCe0l7l8NyF5rpg0nz
 7mQ4DDFyvv8UwqaDVNu8Au1P3+c+8/4WHrnZsh7RYPUdQI3A4bNPWBNRaO/gAD8XexLojcnXC+X
 g572FviiHteSk51869pejGdn3LtYaD/n85gAHWMEsTo6dJa8pCbQ6q6XtZZvGC8VWWLZhFSH9ds
 gkvVPWmny3FWrMi1FX1Ssyfsz/Ms3TuQhGiQk5CAmmosaFXM0FIAJF9VhxywDF0AFNdN8FVcej8
 ZYUUHC78ZMgZZHtjYyg==
X-Authority-Analysis: v=2.4 cv=WN1yn3sR c=1 sm=1 tr=0 ts=69a5bf72 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=CWErhr8FAAAA:8 a=hnS3fS_MpbIQOffReb4A:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-ORIG-GUID: 6UwOm2LEeefpzVMCnnRh8OpyCPVksm9-
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020138

Add bpf_testmod_dup_sym.ko test module that creates a duplicate
nanosleep symbols to test kprobe attachment when a module exports
a symbol with the same name as a vmlinux symbol.

Add test_attach_probe_dup_sym() to attach_probe tests that loads
the duplicate symbol module and validates kprobe attachment across
all four attach modes: auto-attach, explicit symbol, legacy with
offset, and perf_event_open with offset.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 63 +++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      | 48 ++++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 72a9ba41f95e..2915d46c74e0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -121,7 +121,7 @@ TEST_PROGS_EXTENDED := \
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
index 000000000000..0e12f68afe3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
@@ -0,0 +1,48 @@
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
+int __x64_sys_nanosleep(void);
+noinline int __x64_sys_nanosleep(void)
+#elif defined(__s390x__)
+int __s390x_sys_nanosleep(void);
+noinline int __s390x_sys_nanosleep(void)
+#elif defined(__aarch64__)
+int __arm64_sys_nanosleep(void);
+noinline int __arm64_sys_nanosleep(void)
+#elif defined(__riscv)
+int __riscv_sys_nanosleep(void);
+noinline int __riscv_sys_nanosleep(void)
+#else
+int sys_nanosleep(void);
+noinline int sys_nanosleep(void)
+#endif
+{
+	WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called - this should never execute!\n");
+	return -EINVAL;
+}
+
+static int __init bpf_testmod_dup_sym_init(void)
+{
+	return 0;
+}
+
+static void __exit bpf_testmod_dup_sym_exit(void)
+{
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

