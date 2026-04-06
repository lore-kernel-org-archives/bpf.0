Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD62396593;
	Mon,  6 Apr 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504535; cv=none; b=N+zj012uJ1oOJRTKaqnoCj9lU/+kO6gcttjb67QnUWYIwYues/68eIKPX/areXhfIGVO6EriF3MjvGfDxE/wcUAsF+nVU4L/rsIvpZGLQt58Nuaix9sKwe6SIDJhoscr8UTtdEf8jOYTS8FIrK/teTIyHYHLJnyjEaNWgRhC97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504535; c=relaxed/simple;
	bh=0Ms61pnC2sFLJKN1U4YtyLlNwKvTQDfUnpsBuhHpKkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTXjCwhVnzQ5+nvxuH5LPdtW2XlDvculxooxhmiPY+57YVWPYR8Mnd32XQXrURm0irjrU6L5ug7Fa+8FhVaXwOxE2opPXwbqb2u9PXdVtMGOLTqUj1glTEFEG+5SE5tKxJrb2G9u0eVc1Eiz9YkYXykEObdqADZ4NhS19yztQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cOP72Rjb; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cOP72Rjb"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636GUoOc640908;
	Mon, 6 Apr 2026 19:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=lQ9sKD5uXcXmFJrPuxK5nVPWBygGLM7uXdcbr7DE/xE=; b=cOP7
	2RjbzwS6SiFHvLC/lhvXIZkYrKfwJ8Id4FvmPqayV8YZjGkwK8sofmOsgcOBpZqR
	Y9p0Zl8F2lAOiCeT2Vehc9K2bNC5rcmGUmSst3h37YTabcm6gii7vfHKadaFNWS+
	I9p/aXiTKJxpbtQ2DKrSwalcYVPtefAKBdJx84MdnmTRnASMuqk+f4Vp9MytYdR/
	YbFPPvH3x5fmPe3KJbhcZkJ8ILfUtoqNx3OKHMsuJsI8PjU8qz2IeEP3bo8zPrFW
	FBQU9opr3j4HLz1Q7L2W1DjAsLkgXvKGGcRiCGbOtsx1gnI7uZi5/lqDhlvrcC2C
	ic0J+DVA5Qe0iwo5gg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4dbdewqjmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 19:32:03 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 6 Apr 2026 19:32:01 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <ihor.solodrai@linux.dev>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v5 2/2] selftests/bpf: Add tests for duplicate kprobe symbol handling
Date: Mon, 6 Apr 2026 15:31:58 -0400
Message-ID: <20260406193158.754498-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
References: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=ZdoQ98VA c=1 sm=1 tr=0 ts=69d40a33 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22
 a=pl6vuDidAAAA:8 a=hnS3fS_MpbIQOffReb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fzIDAaplwd-vT1-CPUgGhKPYvDMhRQVu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE5MSBTYWx0ZWRfX1CSQGFw+m9ll
 16Xp+S3Lfezmwu2iTi18VtsaPXRrJrykM7g4uFEHg8u7e2L0S9Kt3Fm5mDLHtxSTEYnVB5B1s1D
 DUQE3N+EjtH/nk5lYU+9Tl/D+wUkd50HnJBWJ5+GaLnl33CyCGqIFo+rgyUjHjAToUlIEQN6NR/
 u0rEj7GFjn6L1Vs7tMgAAjo+PtNNodYFzpSI8N40Cv7Mg81ehYW0KxR9YoX8aMYHAeMl/FdHEi1
 FoEvFH6Ny1gAfpkQm9LbJ5dDbF32Bgs/QPOFWI33m8ArgDHoKXN+V9zpcGyi8aeH+ANnI92zcu+
 CzEiItD1SaFJK26PFv/gFbkh8/2wZJ1vPujHfnJ560CtRV4Z/zVnXIK6L4M0QDXiuwixj0X8I33
 5M+/kRPJcDeV/r+dXLE8XsFPZNBQ8BQwfgpeq/kj4MP8RFR2DLbisX6ToE0UcHcE0KmNxMM5GXC
 6PAUcGFEnuCTVXOFqGQ==
X-Proofpoint-GUID: fzIDAaplwd-vT1-CPUgGhKPYvDMhRQVu
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11751
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060191

Add bpf_testmod_dup_sym.ko test module that creates a duplicate
nanosleep symbol to test kprobe attachment when a module exports
a symbol with the same name as a vmlinux symbol.

Add test_attach_probe_dup_sym() to attach_probe tests that loads
the duplicate symbol module and validates kprobe attachment succeeds
across all four attach modes: default, legacy, perf_event_open, and
link — relying on the kernel fix to vmlinux-prefer unqualified symbol
resolution.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 63 +++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      | 48 ++++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..cceb3fcc97a2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -121,7 +121,7 @@ TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_testmod_dup_sym.ko
 TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 12a841afda68..04b177ee3adf 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -4,6 +4,7 @@
 #include "test_attach_probe_manual.skel.h"
 #include "test_attach_probe.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "testing_helpers.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
@@ -197,6 +198,59 @@ static void test_attach_kprobe_legacy_by_addr_reject(void)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* Test kprobe attachment with duplicate symbols.
+ * This test loads bpf_testmod_dup_sym.ko which creates a duplicate
+ * __x64_sys_nanosleep symbol. The kernel fix should prefer the vmlinux
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
@@ -559,6 +613,15 @@ void test_attach_probe(void)
 	if (test__start_subtest("kprobe-legacy-by-addr-reject"))
 		test_attach_kprobe_legacy_by_addr_reject();
 
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

