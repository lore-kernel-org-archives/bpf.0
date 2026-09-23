Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81397563FD6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190742; cv=none; b=KMroJpNWBoAKe/4MDXtkb82gJLzn/VizlICH4pyx9TCL+yc2mBJO+a7dsDLQMW5j3LQjCWhCBtXksF0CSWYmxiTEDBPktMDwx+e28LdOo62qS7++Fhd3ktscnXHaTPYdU0cegGPsctP3s1NvCl4P9yocylcCoZbNUU++tt815aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190742; c=relaxed/simple;
	bh=Mk0wbobOib3p/zNteSXIxQdpVuquSNSvXNSx6gaXmDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUUYzxHGH64N/bBUVsc+dexcofdW8pOM3hbMuvDalQVuEb3M8YdUugFpjY+YvJykQhUbthwbsZffP7SshDB51yzNpnlsN0jAMVckvxWB/HyCt56azgrmZYPCzEg76cCjfut1In/tu99NhhRXP802X2rw7Hp2TBBM+KjE+re85pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crr7Yqsf; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crr7Yqsf"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so578449f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190738; x=1790795538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Es/a/Wq0+GgjT++7Xc0CaHedL81/j6oWXUiERvXTS9s=;
        b=crr7YqsfDvlfJabtcKsdibj+huHZ4LbqfVWuTOubJEGrWHSUPfVpNFLp+YGHzlV9Nj
         /rNekN8MfpiEhxtIGQBoeLVh/TWzIpbQtbVfuU5Dr59Ww3Rp9sHoEQehFYVGzwB9KO+I
         m4EAORtBTjUiVo21t0mwT7fPDjkaAzDLiTcOKzZBDEHjvXZS21FX7cToGYjloGOoEuzO
         mGUnlAxHhg3Jh8ZaZI2s5tGroQIZnu/YGjyWVbx8Q52r9Tt7IERlW5ZpZxHgH40xobIz
         +lKtlnQ247j6lJdboQbRF9PcCH6XshkcCfSUo0a2uNM3yJL4EcQuHovKgRNLEMMMHiu6
         JjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190738; x=1790795538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Es/a/Wq0+GgjT++7Xc0CaHedL81/j6oWXUiERvXTS9s=;
        b=Act2x9u2UQfX8miV7/IKoxS3liGJyWU+za6VwXglEW5ts46JYswuEk55hNK84kxKe+
         jvvNkWEVCkMEVC0nQKBZWE/0r5rltlvKewazvZkJ0iLoPQBs/cpUi17uB8bxtP1+207U
         M/HYkli9n7SzvL+um02EufqHwwjdaqDv2Dj7egR6POznQoWfOoHJ3hRZiGvUOLppRtzD
         49KXaCRaGndWGusyiRNWxWWvY4iAJf98LRJkC5cewwjVsPxJYUFDy98l5Ps6vqgmAfpH
         0YHpnIhZwX2Etafy6DHU9hHCsy4S/OGYgORhAW8jsNephTjS8zWBJU0JcsG47WVkL6lu
         FKsg==
X-Gm-Message-State: AFuF++mOya9hnz2OsM0DVoo49hiERzeF49meIFh6b6SJ+uAHTn0AORoB
	A0wny9LrzwTYrAdJSoDLyYSKWZSoRYaXIcXIfARnxrX/V9bDcIUJqSHLv6BJowOA
X-Gm-Gg: AYBFou3r2MV6QPcWDCCqhg8Y4VvOlmzA+OWOlLGGI6ZaGdswQykjsRXHBFB7nRJQDMY
	E6GBf8daznN8yVPvTmRcyYI2rk41n9kLRcPtcV6e7EXSF7jiF90m47CfiU3ItJvcu3eP/mkbY0G
	pUBjeDk70baYk6lY3atQcmEK8w60TMwriFtNjxlZhTz0jtcaDwmak0xwqKXe4ZKJyNyVkW5a/wD
	2+U6YuMls2VoEnaq0kiuMS0ZVouoajROjUF7hGoY3wF1ywZoeedipNgLvEl9uKoa7mY2krVUO9E
	swTROKnyIfWn7ixVRs2q0b3CkLOVJ/6lfZCeoHWG/pdu55kBQJ4hIuGPPSsGbJFC9jiQxQ6nR1p
	LmIv9Hps9OjHiJD04Zr38W8nC0EvkSpdCWHhrJSu+DM9G0XxHYmLB1mstGWnjgxYYz1O+tMu4eU
	89CykSfRueL7Le3PNM6L9vdItghKtsY2X2Lwv25H4InCPYb5efVHSddx8s52WEaKtn9RCsH9wD5
	uSiQHjzdq8mfipiZHQ6vMFoQ54gZyTV3WIx0OPt23RL+xRKcjNU9TVH1CmwW5Voo7TQRlXBnBbk
	JTw9L9Eg/ox9K+FetlBcS6AzBm7vuFNtYKcL4w==
X-Received: by 2002:a05:6000:2307:b0:487:342:d148 with SMTP id ffacd0b85a97d-488716f6a5bmr180327f8f.38.1790190737512;
        Wed, 23 Sep 2026 12:12:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm8821253f8f.2.2026.09.23.12.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 18/18] selftests/bpf: Test the 2 KiB stack budget
Date: Wed, 23 Sep 2026 21:11:25 +0200
Message-ID: <20260923191139.2816206-19-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19665; i=memxor@gmail.com; h=from:subject; bh=Mk0wbobOib3p/zNteSXIxQdpVuquSNSvXNSx6gaXmDE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4s9lwpEi+Qs2MVda3PlRx12Xu/+r8uKbTRdCCiqe/ lt18FpoRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYivp3hf/mxwvpbIs0ey4Rn h8/O2F3z6mK3bHbgPn7zzZNlJme33WX4pyRT0PCFab1OnP2N2zJxP3awJa0Pdk5a+Pdb773n/eb /mAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add tests for the stack budget of JITs with large stack support: a
single 2 KiB frame, with and without may_goto, four 512-byte frames
that fit the budget and five that do not, a 512-byte frame calling a
1536-byte static subprog, global subprog or bpf_loop() callback and the
same with eight bytes too many, variable offset writes reaching exactly
the budget and past it, a tail call made from a 1 KiB frame, and two
2 KiB frames on a private stack, where each frame gets the whole budget.
A program with a 2 KiB frame is checked to be rejected wherever the
budget is 512 bytes.

Two tests run such programs: a tail call made from a subprog with a
1536-byte frame under a 240-byte caller into a program with a 2 KiB
frame, and a struct_ops program on a private stack calling a subprog
when both frames are 2 KiB.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/struct_ops_private_stack.c |  31 ++
 .../selftests/bpf/prog_tests/tailcalls.c      |  42 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/struct_ops_private_stack_large.c    |  51 +++
 .../bpf/progs/tailcall_large_stack.c          |  62 +++
 .../bpf/progs/verifier_large_stack.c          | 377 ++++++++++++++++++
 6 files changed, 565 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_large_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_large_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index 98db9bafa44b..2b3ec2b79091 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -4,6 +4,7 @@
 #include "struct_ops_private_stack.skel.h"
 #include "struct_ops_private_stack_fail.skel.h"
 #include "struct_ops_private_stack_recur.skel.h"
+#include "struct_ops_private_stack_large.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
 static void test_private_stack(void)
@@ -78,6 +79,34 @@ static void test_private_stack_recur(void)
 	struct_ops_private_stack_recur__destroy(skel);
 }
 
+/* Two frames of 2 KiB each on the private stack */
+static void test_private_stack_large(void)
+{
+	struct struct_ops_private_stack_large *skel;
+	struct bpf_link *link;
+
+	if (!is_large_stack_supported()) {
+		test__skip();
+		return;
+	}
+
+	skel = struct_ops_private_stack_large__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_large__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->val, 100 + 30 + 12, "val");
+
+	bpf_link__destroy(link);
+cleanup:
+	struct_ops_private_stack_large__destroy(skel);
+}
+
 static void __test_struct_ops_private_stack(void)
 {
 	if (test__start_subtest("private_stack"))
@@ -86,6 +115,8 @@ static void __test_struct_ops_private_stack(void)
 		test_private_stack_fail();
 	if (test__start_subtest("private_stack_recur"))
 		test_private_stack_recur();
+	if (test__start_subtest("private_stack_large"))
+		test_private_stack_large();
 }
 #else
 static void __test_struct_ops_private_stack(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index c5c9d6c359bb..c5e3f198ca7f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -9,6 +9,7 @@
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
 #include "tailcall_cgrp_storage_owner.skel.h"
+#include "tailcall_large_stack.skel.h"
 #include "tailcall_cgrp_storage_no_storage.skel.h"
 #include "tailcall_cgrp_storage.skel.h"
 #include "tailcall_sleepable.skel.h"
@@ -1953,6 +1954,45 @@ static void test_tailcall_bpf2bpf_fexit_links(void)
 	tailcall_bpf2bpf2__destroy(skel_tc);
 }
 
+/*
+ * test_tailcall_large_stack runs a tail call made from a subprog with a 1536
+ * byte frame, under a 240-byte caller, into a program with a 2 KiB frame:
+ *
+ * entry (240) --call-> subprog_tail (1536) --tailcall-> classifier_0 (2048)
+ */
+static void test_tailcall_large_stack(void)
+{
+	struct tailcall_large_stack *skel;
+	int err, prog_fd, map_fd, key = 0;
+	char buff[128] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	if (!is_large_stack_supported()) {
+		test__skip();
+		return;
+	}
+
+	skel = tailcall_large_stack__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tailcall_large_stack__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.classifier_0);
+	map_fd = bpf_map__fd(skel->maps.jmp_table);
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.entry), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 42 + 7, "retval");
+out:
+	tailcall_large_stack__destroy(skel);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -2022,4 +2062,6 @@ void test_tailcalls(void)
 	test_tailcall_callback();
 	if (test__start_subtest("tailcall_bpf2bpf_fexit_links"))
 		test_tailcall_bpf2bpf_fexit_links();
+	if (test__start_subtest("tailcall_large_stack"))
+		test_tailcall_large_stack();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4f1e1c1cd5ab..ced8a2f1c89c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -59,6 +59,7 @@
 #include "verifier_kfunc_uninit.skel.h"
 #include "verifier_kfunc_uninit_multi.skel.h"
 #include "verifier_ld_ind.skel.h"
+#include "verifier_large_stack.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_linked_scalars.skel.h"
@@ -229,6 +230,7 @@ void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit)
 void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_multi); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
+void test_verifier_large_stack(void)          { RUN(verifier_large_stack); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
new file mode 100644
index 000000000000..94a25a2cff6e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+long val;
+
+/* On a private stack every frame gets the whole 2 KiB budget. */
+__used __naked
+static long frame_2048_leaf(void)
+{
+	asm volatile ("					\
+	r1 = 30;					\
+	*(u64 *)(r10 - 2048) = r1;			\
+	r1 = 12;					\
+	*(u64 *)(r10 - 8) = r1;				\
+	r0 = *(u64 *)(r10 - 2048);			\
+	r1 = *(u64 *)(r10 - 8);				\
+	r0 += r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* test_1 is the member bpf_testmod requests a private stack for */
+SEC("struct_ops")
+__naked int test_1(void)
+{
+	asm volatile ("					\
+	r1 = 100;					\
+	*(u64 *)(r10 - 2048) = r1;			\
+	call frame_2048_leaf;				\
+	r1 = *(u64 *)(r10 - 2048);			\
+	r0 += r1;					\
+	r1 = %[val] ll;					\
+	*(u64 *)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(val)
+	: __clobber_all);
+}
+
+SEC(".struct_ops")
+struct bpf_testmod_ops3 testmod_1 = {
+	.test_1 = (void *)test_1,
+};
diff --git a/tools/testing/selftests/bpf/progs/tailcall_large_stack.c b/tools/testing/selftests/bpf/progs/tailcall_large_stack.c
new file mode 100644
index 000000000000..977197dac5d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_large_stack.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+/* The tail call target sets up a 2 KiB frame of its own and uses both of its ends. */
+SEC("tc")
+__naked int classifier_0(void)
+{
+	asm volatile ("					\
+	r1 = 42;					\
+	*(u64 *)(r10 - 2048) = r1;			\
+	r1 = 7;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	r0 = *(u64 *)(r10 - 2048);			\
+	r1 = *(u64 *)(r10 - 8);				\
+	r0 += r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * The frame of the subprog doing the tail call is unwound by it, so it may be
+ * large; only the frames of its callers stay behind and are limited to 256
+ * bytes in total. Returns 1 when the tail call falls through.
+ */
+__used __naked
+static int subprog_tail(void)
+{
+	asm volatile ("					\
+	r2 = 1;						\
+	*(u64 *)(r10 - 1536) = r2;			\
+	r2 = %[jmp_table] ll;				\
+	r3 = 0;						\
+	call %[bpf_tail_call];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+SEC("tc")
+__naked int entry(void)
+{
+	asm volatile ("					\
+	r2 = 2;						\
+	*(u64 *)(r10 - 240) = r2;			\
+	call subprog_tail;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
new file mode 100644
index 000000000000..2d4c81a3f0cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * Programs may use MAX_BPF_STACK_JIT (2 KiB) of stack on JITs that support
+ * large stacks, combined over a call chain, with no separate limit on a
+ * single frame. Interpreted programs and other JITs keep 512 bytes.
+ */
+
+SEC("socket")
+__description("single frame of 2048 bytes")
+__load_if_large_stack()
+__success __success_unpriv __retval(42)
+__naked void single_frame_2048(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2048;					\
+	r0 = 42;					\
+	*(u64*)(r1 + 0) = r0;				\
+	r0 = *(u64*)(r1 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("single frame of 2048 bytes without large stack support")
+__load_if_no_large_stack()
+__failure __msg("invalid write to stack R1 off=-2048 size=8")
+__naked void single_frame_2048_no_large_stack(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2048;					\
+	r0 = 42;					\
+	*(u64*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_leaf(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_depth_2(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_leaf;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_depth_3(void)
+{
+	asm volatile ("					\
+	r1 = 3;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_depth_2;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_512_depth_4(void)
+{
+	asm volatile ("					\
+	r1 = 4;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_depth_3;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("four frames of 512 bytes fit the 2 KiB budget")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void four_frames_of_512(void)
+{
+	asm volatile ("					\
+	call frame_512_depth_4;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("five frames of 512 bytes exceed the 2 KiB budget")
+__load_if_large_stack()
+__failure __msg("combined stack size of 5 calls is 2560. Too large")
+__naked void five_frames_of_512(void)
+{
+	asm volatile ("					\
+	r1 = 5;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_512_depth_4;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void frame_1536_leaf(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 1536) = r1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("512-byte frame calling a 1536-byte frame")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void uneven_frames_fit(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call frame_1536_leaf;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("520-byte frame calling a 1536-byte frame")
+__load_if_large_stack()
+__failure __msg("combined stack size of 2 calls is 2064. Too large")
+__naked void uneven_frames_exceed(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 520) = r1;			\
+	call frame_1536_leaf;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_MAY_GOTO
+/* may_goto adds its counter below the frame; a JIT does not hold that against the budget */
+SEC("socket")
+__description("frame of 2048 bytes with may_goto")
+__load_if_large_stack()
+__success __retval(42)
+__naked void frame_2048_with_may_goto(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -2048;					\
+	r0 = 42;					\
+	*(u32*)(r1 + 0) = r0;				\
+	may_goto l0_%=;					\
+	r2 = 100;					\
+	l0_%=:						\
+	exit;						\
+"	::: __clobber_all);
+}
+#endif
+
+SEC("socket")
+__description("variable offset write reaching 2048 bytes deep")
+__load_if_large_stack()
+__success
+__naked void var_off_write_to_2048(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 8;					\
+	r2 = r10;					\
+	r2 += -2048;					\
+	r2 += r0;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("variable offset write reaching 2056 bytes deep")
+__load_if_large_stack()
+__failure __msg("invalid variable-offset write to stack R2")
+__naked void var_off_write_to_2056(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 8;					\
+	r2 = r10;					\
+	r2 += -2056;					\
+	r2 += r0;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Each frame of a private stack gets the whole budget. */
+__used __naked
+static void priv_stack_frame_2048(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 2048) = r1;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("kprobe")
+__description("private stack: two frames of 2048 bytes")
+__load_if_large_stack()
+__arch_x86_64
+__arch_arm64
+__success __log_level(4)
+__msg("stack depth max 2048")
+__msg("subprog 0 (private_stack_two_frames) main {{.*}} stack 2048")
+__msg("subprog 1 (priv_stack_frame_2048) static {{.*}} stack 2048")
+__naked void private_stack_two_frames(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 2048) = r1;			\
+	call priv_stack_frame_2048;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+/*
+ * A tail call unwinds the frame of the program doing it, so a large main
+ * frame is fine; the 256-byte rule only concerns the frames of callers of a
+ * subprog that tail calls.
+ */
+SEC("tc")
+__description("tail call from a 1 KiB frame")
+__load_if_large_stack()
+__success
+__naked void tail_call_from_large_frame(void)
+{
+	asm volatile ("					\
+	r2 = 42;					\
+	*(u64 *)(r10 - 1024) = r2;			\
+	r2 = %[jmp_table] ll;				\
+	r3 = 0;						\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+/* Global subprogs are verified on their own but share the call chain budget. */
+__used __naked int global_frame_1536(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 1536) = r1;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("512-byte frame calling a 1536-byte global subprog")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void global_subprog_fits(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	call global_frame_1536;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("520-byte frame calling a 1536-byte global subprog")
+__load_if_large_stack()
+__failure __msg("combined stack size of 2 calls is 2064. Too large")
+__naked void global_subprog_exceeds(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 520) = r1;			\
+	call global_frame_1536;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Callback frames are part of the chain of the helper that calls them. */
+static __naked int loop_cb_1536(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 1536) = r1;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("512-byte frame with a 1536-byte bpf_loop callback")
+__load_if_large_stack()
+__success __log_level(4) __msg("stack depth max 2048")
+__naked void loop_callback_fits(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 512) = r1;			\
+	r1 = 1;						\
+	r2 = %[loop_cb_1536];				\
+	r3 = 0;						\
+	r4 = 0;						\
+	call %[bpf_loop];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_ptr(loop_cb_1536),
+	  __imm(bpf_loop)
+	: __clobber_common);
+}
+
+SEC("socket")
+__description("520-byte frame with a 1536-byte bpf_loop callback")
+__load_if_large_stack()
+__failure __msg("combined stack size of 2 calls is 2064. Too large")
+__naked void loop_callback_exceeds(void)
+{
+	asm volatile ("					\
+	r1 = 2;						\
+	*(u64 *)(r10 - 520) = r1;			\
+	r1 = 1;						\
+	r2 = %[loop_cb_1536];				\
+	r3 = 0;						\
+	r4 = 0;						\
+	call %[bpf_loop];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_ptr(loop_cb_1536),
+	  __imm(bpf_loop)
+	: __clobber_common);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

