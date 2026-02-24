Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C3182B7
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953856; cv=none; b=Nu2Hf1qK8YM7JfyGUHO+W8e5srgO+48TakLTIAf5a8V6OQZ3YVmfsfpJHGZ3XYj1+M/78YG+AGfSi6dfX4jIECZrLbT+fJvE888Nu8D28NC4Gb09DpM114tmWFHCk8Nx9ZNMRbOfknY95o/9CZPMpMFgLicSKb36emY3JctM/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953856; c=relaxed/simple;
	bh=zUh4cvK9M/gh3mBNNW5vQ6T5lK+3pP35RwR5kh/Cx8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNpAcrOe8d1sM5FbrqBVnQgXsXsBOcL8YAG7jNR/aHtdRegeSGZKS57fyxSBOLnG4qikcqCjZxIPeZ/BwHGwC6sL/gAv1iXAc2LjKCl3ok114wCkIPfA3fPIm4EzfzOWSpS5fXl3zcQmWNy7aWVuzq0eMDT9eUChwJ0d75L3uvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=y0Vp9k1K; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="y0Vp9k1K"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OFqX2O912091;
	Tue, 24 Feb 2026 17:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=nP23szXDaOFiUesoxntsRHOYnRgrBzXHGa5VtS4dbXw=; b=y0Vp
	9k1KQIhqo08sTGTj8YTmzyZCj7/xGh/AMckbZVFjPDDhutIcjIpRUdZwVV7uvTMk
	otS/1vntxqv7HtvWwmoT7JfvQ/AwlYHthvUs5gK0mCBkAOKCAU3hSaaVkR+oIRfw
	Hy3sVeVSJL8h/PwzOt+raApUPr58+yYIWHUKk+l0zb72M861xaSXkme+jFnjEcJ0
	kn+VpD0okoJ6+Umt4SWKqshaaeoXBHTXp6ulxt6vxXn0GZOZRxg7dFb0fjXVKAs3
	VYYhpZ4bRfJ5y+0RC3Qrl/iFtsv2lVR8OatJBXmcE6DozVUmOWgcdAAx5UY4gCIb
	Ljq7KvZ4XtnTPa1Kag==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cftgxjva4-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 17:23:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 17:23:43 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v2 2/2] selftests/bpf: Add tests for duplicate kprobe symbol handling
Date: Tue, 24 Feb 2026 12:23:40 -0500
Message-ID: <20260224172340.1704618-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
References: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0NSBTYWx0ZWRfX2nSoJ1OZR50/
 ne2MXSn57JLIPnxYFNoVhVHWyQiMVOc4ab71mzBwHl6ZVypsU+zmaPyS8zyrXNdi+AJy0oHj/sy
 nEHO/6ml+xU12OpXJ5g+SN6HI5ancXb5Jgi6uvbmtodK+Vl8WztERTIVvx6gNbsdyO1ufdyLVUn
 xFAKqlhU9ZQyOMorI6K+5Ai8SvMS93rpiqq8z57GMSA2M7Vl9snvOVn6KNuwIT4vCK7JTMS/eDG
 9KlmM+oIPKUhpGj0TB8EkKrBE9106kkMr3CUvNMTQP9PeXj3sxeZ98TXIPGiAqkOUlo7RBu18CX
 RC+O3RPWeP/XQXhxOHAi/ggCbvNE6x6gNKc+T08DMczj6t9dwGJx5lW7O8R19FGtFOeUqnT7uBG
 bdjQXyGnmMvKw/0G/KNl4WrKv1Fr+pjVELkyXzjvLrgqxedv9imgJWgraGhec59u/nEzUIRF1ag
 labj6fkTM9kvORan2Tw==
X-Proofpoint-ORIG-GUID: PYPDIHflrvtz31IBoVITUjY4TRYZUSm1
X-Authority-Analysis: v=2.4 cv=S+XUAYsP c=1 sm=1 tr=0 ts=699ddea4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=pl6vuDidAAAA:8
 a=hnS3fS_MpbIQOffReb4A:9
X-Proofpoint-GUID: PYPDIHflrvtz31IBoVITUjY4TRYZUSm1
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11711
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240145

Add test_attach_probe_dup_sym() which loads bpf_testmod_dup_sym.ko to
create a duplicate symbol scenario, then verifies kprobe and kretprobe
attachment succeeds across default, legacy, perf_event, and link modes.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 63 +++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      | 50 +++++++++++++++
 4 files changed, 115 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6776158f1f3e..fe9671268c6f 100644
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
index 000000000000..c6a5a32799e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
@@ -0,0 +1,50 @@
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

