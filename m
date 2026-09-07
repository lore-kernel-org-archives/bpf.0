Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17F5221E8
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799992; cv=none; b=ePjbHs1+bkF6vVkGiJa6ZRhWxc0+4NBVqeX6UoefLcnAjUToToDWWRLXYChMjSTCEgzp23TCj7J4IxbLCqI/BCLtVp3Nu8xEzc1B2pl6WrZBJ6wYlhs7r0Fo/MYx1icxxTaZFevGigCotckE7AJW/Xsb9LI9Mj0SmzDWQz+m3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799992; c=relaxed/simple;
	bh=hUiRfb4pPtGSt1XRoYIWNSwJicLgvBYrE8+iFiVEXj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxPfps3iFECIVihDr2KGyGVMTuPW47F49X1fmEnKliwzMAJELA60qhJoTPJIReUqmgsDtFTSKtIhd7mtnmMAkGULOCpuYJjFzSDhJ8AoG0tRj+A/VwuD/Wd8IrQd/hZvrclJNCUo+ljsfpvjVHkOgAPnVnxop+WjPZ+9IcHEsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk+dNN1c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk+dNN1c"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso35741115e9.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799988; x=1789404788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiDantY2ppJjyfqauG6RKR7rX8GZTmilPQrscV/V7A4=;
        b=Vk+dNN1cRSI1T20TmfDCeWcN2d2r54IPfCqatLuE3s5m+ogZPBGx27OQYy7G5RFo+F
         3FLJoZsvfgEFEE/o0He6cT09e0lvkE5hN6s/4kaibIaVDrKLQ5E5/0AJ/kisfhSDNe6B
         OoWvK+nFTV0Wm6o2qDDhu7H60Y9vMb1+szG/cOQ+9IQEwR9ATENM2Wx+tCXW1PLmsYcS
         uuNnR8ixtvQkLCvnfG+fFmHf2wM833Bx8eB+BvcFK/tUxXo4CiY+igA0drs0sISKvvDW
         WQU/0GwwJHw3pxaShURzAjX2/Yt6J4X2JATrTtBdErrxfHH6fQ1PM97ZszgRj2BF0dSD
         Ofwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799988; x=1789404788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wiDantY2ppJjyfqauG6RKR7rX8GZTmilPQrscV/V7A4=;
        b=eHMjsLmowjVQxhoAIH80wE7dvo9hQANWsm1iL62vHNSJ1HPhDtfTcrm/8hNsKWkMIV
         RGDJua3Lu2uoMKehUPOINievf2tXYag4z4VbNRvBz+P9lYY3wjCwfAXFyqbsQJyYxnUG
         b+I9KZHdrDzdhI+ngbWz+I6paYtIt9QKytyALPj/8ww64caXKSm1CtbOhbXwBS1lZQ5k
         mwXzn168xvSD8o4fkr/AZTFooUxa1wfv53CTmMaOgNfp/JHDRGoFVHJi3j2+Ts6JKhsc
         kG3ScE54nB1L9AI5/RBp/cb2krJ6ReP109Rjho5WwxQAgsxQqBbXvHH4cGMKQZ/9ulmS
         6OlQ==
X-Gm-Message-State: AFuF++nSGf2GSGrDG3bxlxQQg5KnDPJ/F97qjdXfLcBUaxgQo43YlWAF
	UZCuYdiVw5vW0k5P2+nS77c/ZUy/zPEpcT0f5mQQ6yKGysXIoJWMLf1VM1MxVDjmHHQ=
X-Gm-Gg: AYBFou0dhMMhiyKZKSnN/yq2T1knYzwISWODUuIy21nsZAZ9JuWoM5nFvnFCeLd101D
	i6Wx0WuSCx8uVh7+0AaMmC6OZG+fQH/tUiv3IQYla5ZMEFp6O5X5YMKvZtuUmjjbuibHPk6+YE5
	gYqVO/PEOPMIp/Oe3XaNKNBKA1zY63L1Y5MWgg5fyQunxDVoLf0MS9zNswnLrLFI1g6g+fqDYiB
	nOJJlnb7xe5tQ3r8SIHUSZm4zfBV6VbDvuBPaRXruUJ94oBR1NXeW87WHE/Gh3zPGAnTLF/ILTW
	DzSjbGn48V2qbQ1HlINgG0xGdYmsYjFtkJ+jF2M719UXpxhqzK0NykHP1uNa6SfcH6XYhYL7GGz
	6Lyih4dHqzk5Ekrgn8Y/WG2FQZ49GkMgVQdAnSoFRf4GLKATv/l3lmu7KLsv19XVAXiMcGZSi7X
	Jz7wLPBbrjCMjv6WEAosFNep08l2zg7S5D0pYj3sbteoIK2PqvuEeTspYRLgNmcxPVJWGcfbhrR
	A==
X-Received: by 2002:a05:600c:3e06:b0:49d:99:1d98 with SMTP id 5b1f17b1804b1-49d00991db1mr173226525e9.9.1788799987801;
        Mon, 07 Sep 2026 09:53:07 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:53:07 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH bpf-next v5 5/7] selftests/bpf: Cover trusted-or-null BTF pointer reads
Date: Mon,  7 Sep 2026 19:52:18 +0300
Message-ID: <20260907165220.52431-6-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
References: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update verifier tests that expected an unchecked trusted-or-null BTF
pointer dereference to fail. Cover scalar reads and chained reads through
BTF and memory pointers. Add a runtime test which verifies that non-NULL
reads return the field value and NULL reads return zero.

Verify that pointer arithmetic, stores, atomic RMW operations, and
BPF_LOAD_ACQ accesses remain prohibited. Assert that a BTF pointer
derived from an unchecked trusted-or-null load is PTR_UNTRUSTED. Verify
that attempting to NULL-check the derived pointer remains rejected and
that it cannot be passed to a kfunc requiring an RCU pointer. Keep the
existing NULL-check tests to verify that an explicit check of the original
pointer recovers normal trusted pointer behavior.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       |  6 +-
 .../prog_tests/test_struct_ops_maybe_null.c   | 13 ++--
 .../bpf/prog_tests/tp_btf_nullable.c          | 28 +++++++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 78 +++++++++++++++++--
 .../bpf/progs/test_tp_btf_nullable.c          | 45 ++++++++++-
 .../bpf/progs/test_tp_btf_nullable_runtime.c  | 35 +++++++++
 .../selftests/bpf/progs/verifier_lsm.c        | 18 ++++-
 .../selftests/bpf/progs/verifier_vfs_accept.c | 14 ++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 14 ----
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
 .../sched_ext/maybe_null_fail_dsp.bpf.c       |  5 +-
 11 files changed, 221 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable_runtime.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index c69080ca14f5..99a16a1add70 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -39,10 +39,10 @@ static void test_btf_id_or_null(void)
 	struct bpf_iter_test_kern3 *skel;
 
 	skel = bpf_iter_test_kern3__open_and_load();
-	if (!ASSERT_ERR_PTR(skel, "bpf_iter_test_kern3__open_and_load")) {
-		bpf_iter_test_kern3__destroy(skel);
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_test_kern3__open_and_load"))
 		return;
-	}
+
+	bpf_iter_test_kern3__destroy(skel);
 }
 
 static void do_dummy_read_opts(struct bpf_program *prog, struct bpf_iter_attach_opts *opts)
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
index 01dc2613c8a5..45af6f00ad90 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
@@ -19,15 +19,16 @@ static void maybe_null(void)
 	struct_ops_maybe_null__destroy(skel);
 }
 
-/* Test that the verifier rejects a program that access a nullable pointer
- * without a check beforehand.
+/*
+ * Test that the verifier accepts a fault-protected read through a nullable
+ * trusted pointer without an explicit NULL check.
  */
-static void maybe_null_fail(void)
+static void maybe_null_no_check(void)
 {
 	struct struct_ops_maybe_null_fail *skel;
 
 	skel = struct_ops_maybe_null_fail__open_and_load();
-	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+	if (!ASSERT_OK_PTR(skel, "struct_ops_maybe_null_fail__open_and_load"))
 		return;
 
 	struct_ops_maybe_null_fail__destroy(skel);
@@ -41,6 +42,6 @@ void test_struct_ops_maybe_null(void)
 	 */
 	if (test__start_subtest("maybe_null"))
 		maybe_null();
-	if (test__start_subtest("maybe_null_fail"))
-		maybe_null_fail();
+	if (test__start_subtest("maybe_null_no_check"))
+		maybe_null_no_check();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c b/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
index accc42e01f8a..825fe7a92d74 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
@@ -2,6 +2,31 @@
 
 #include <test_progs.h>
 #include "test_tp_btf_nullable.skel.h"
+#include "test_tp_btf_nullable_runtime.skel.h"
+
+static void test_nullable_runtime(void)
+{
+	struct test_tp_btf_nullable_runtime *skel;
+
+	skel = test_tp_btf_nullable_runtime__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	skel->bss->monitored_tid = sys_gettid();
+
+	if (!ASSERT_OK(test_tp_btf_nullable_runtime__attach(skel), "attach"))
+		goto out;
+
+	if (!ASSERT_OK(trigger_module_test_read(2), "trigger"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->calls, 2, "calls");
+	ASSERT_EQ(skel->bss->nonnull_len, 2, "nonnull_len");
+	ASSERT_EQ(skel->bss->null_len, 0, "null_len");
+
+out:
+	test_tp_btf_nullable_runtime__destroy(skel);
+}
 
 void test_tp_btf_nullable(void)
 {
@@ -11,4 +36,7 @@ void test_tp_btf_nullable(void)
 	}
 
 	RUN_TESTS(test_tp_btf_nullable);
+
+	if (test__start_subtest("runtime"))
+		test_nullable_runtime();
 }
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
index 725d73c9ffe1..163124793d0a 100644
--- a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -2,22 +2,34 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 
 #include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
-/* Ensure module parameter has PTR_MAYBE_NULL */
+extern struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+/*
+ * Ensure the module tracepoint argument is trusted-or-NULL while allowing
+ * a fault-protected read without an explicit NULL check.
+ */
 SEC("tp_btf/bpf_testmod_test_raw_tp_null_tp")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+__success __log_level(2)
+__msg("R1=trusted_ptr_or_null_sk_buff")
 int test_raw_tp_null_bpf_testmod_test_raw_tp_null_arg_1(void *ctx) {
     asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
     return 0;
 }
 
-/* Check NULL marking */
+/*
+ * Ensure sched_pi_setprio's second argument is trusted-or-NULL while allowing
+ * a fault-protected read without an explicit NULL check.
+ */
 SEC("tp_btf/sched_pi_setprio")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+__success __log_level(2)
+__msg("R1=trusted_ptr_or_null_task_struct")
 int test_raw_tp_null_sched_pi_setprio_arg_2(void *ctx) {
     asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
     return 0;
@@ -60,7 +72,8 @@ int test_tp_btf_signal_deliver_info_no_deref(void *ctx)
 }
 
 SEC("tp_btf/sched_process_wait")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+__success __log_level(2)
+__msg("R1=trusted_ptr_or_null_pid")
 int test_raw_tp_null_sched_process_wait_arg_1(void *ctx)
 {
 	asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u32 *)(r1 +0);" ::: __clobber_all);
@@ -75,3 +88,58 @@ int test_raw_tp_null_sched_process_wait_arg_1_checked(void *ctx)
 		     "r1 = *(u32 *)(r1 +0);" ::: __clobber_all);
 	return 0;
 }
+
+SEC("tp_btf/sched_pi_setprio")
+__failure __log_level(2)
+__msg("R1=untrusted_ptr_task_struct")
+__msg("R1 must be a rcu pointer")
+int BPF_PROG(trusted_or_null_walk_is_untrusted, struct task_struct *task,
+	     struct task_struct *pi_task)
+{
+	struct task_struct *parent, *acquired;
+
+	parent = pi_task->real_parent;
+	acquired = bpf_task_acquire(parent);
+	if (acquired)
+		bpf_task_release(acquired);
+	return 0;
+}
+
+SEC("tp_btf/sched_pi_setprio")
+__failure __msg("R1 must be a rcu pointer")
+int BPF_PROG(derived_ptr_null_check_does_not_restore_trust,
+	     struct task_struct *task, struct task_struct *pi_task)
+{
+	struct task_struct *parent, *acquired;
+
+	parent = pi_task->real_parent;
+	if (!parent)
+		return 0;
+
+	acquired = bpf_task_acquire(parent);
+	if (acquired)
+		bpf_task_release(acquired);
+
+	return 0;
+}
+
+/*
+ * In contrast, checking the original trusted-or-NULL pointer removes
+ * PTR_MAYBE_NULL while retaining PTR_TRUSTED.
+ */
+SEC("tp_btf/sched_pi_setprio")
+__success
+int BPF_PROG(original_ptr_null_check_retains_trust,
+	     struct task_struct *task, struct task_struct *pi_task)
+{
+	struct task_struct *acquired;
+
+	if (!pi_task)
+		return 0;
+
+	acquired = bpf_task_acquire(pi_task);
+	if (acquired)
+		bpf_task_release(acquired);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
index cf0547a613ff..b7914224ba19 100644
--- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
@@ -7,7 +7,7 @@
 #include "bpf_misc.h"
 
 SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+__success
 int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_ctx *nullable_ctx)
 {
 	return nullable_ctx->len;
@@ -21,4 +21,47 @@ int BPF_PROG(handle_tp_btf_nullable_bare2, struct bpf_testmod_test_read_ctx *nul
 	return 0;
 }
 
+SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
+__success
+int BPF_PROG(handle_tp_btf_nullable_mem, struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	return nullable_ctx->buf[0];
+}
+
+SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
+__failure __msg("pointer arithmetic on trusted_ptr_or_null_ prohibited")
+int BPF_PROG(handle_tp_btf_nullable_arith, struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	asm volatile("%[ctx] += 1" : [ctx] "+r"(nullable_ctx));
+	return nullable_ctx->len;
+}
+
+SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
+__failure __msg("invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(handle_tp_btf_nullable_atomic_rmw,
+	     struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	asm volatile ("r1 = %[ctx];"
+		      "w2 = 1;"
+		      "lock *(u32 *)(r1 + %[len]) += w2;"
+		      :
+		      : [ctx] "r"(nullable_ctx),
+			__imm_const(len,
+				    offsetof(struct bpf_testmod_test_read_ctx,
+					     len))
+		      : "r1", "r2", "memory");
+	return 0;
+}
+
+#ifdef __BPF_FEATURE_LOAD_ACQ_STORE_REL
+SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
+__failure
+__msg("BPF_ATOMIC loads from R{{[0-9]+}} trusted_ptr_or_null_")
+int BPF_PROG(handle_tp_btf_nullable_load_acquire,
+	     struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	return __atomic_load_n(&nullable_ctx->len, __ATOMIC_ACQUIRE);
+}
+#endif
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable_runtime.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable_runtime.c
new file mode 100644
index 000000000000..5c9c7f94040d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable_runtime.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int monitored_tid;
+int calls;
+__u64 nonnull_len;
+__u64 null_len;
+
+SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
+int BPF_PROG(handle_nullable_runtime,
+	     struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	__u32 tid = bpf_get_current_pid_tgid();
+	__u64 len;
+	int call;
+
+	if (tid != monitored_tid)
+		return 0;
+
+	len = nullable_ctx->len;
+	call = calls++;
+
+	if (call == 0)
+		nonnull_len = len;
+	else if (call == 1)
+		null_len = len;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index c724bf389f5c..fac133d90f5e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -162,13 +162,13 @@ __naked int disabled_hook_test3(void *ctx)
 
 SEC("lsm/mmap_file")
 __description("not null checking nullable pointer in bpf_lsm_mmap_file")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+__success
 int BPF_PROG(no_null_check, struct file *file)
 {
-	struct inode *inode;
+	ino_t ino;
 
-	inode = file->f_inode;
-	__sink(inode);
+	ino = file->f_inode->i_ino;
+	__sink(ino);
 
 	return 0;
 }
@@ -188,6 +188,16 @@ int BPF_PROG(null_check, struct file *file)
 	return 0;
 }
 
+SEC("lsm/mmap_file")
+__description("store through trusted-or-null file is rejected")
+__failure
+__msg("R{{[0-9]+}} invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(store_through_trusted_or_null_file, struct file *file)
+{
+	file->f_flags = 0;
+	return 0;
+}
+
 SEC("lsm_cgroup/file_open")
 __description("sleepable lsm_cgroup program is rejected")
 __failure __msg("Program of this type cannot be sleepable")
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 55398c04290a..17c1542cc7e1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -100,4 +100,18 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 	return 0;
 }
 
+SEC("lsm.s/inode_rename")
+__success __log_level(2)
+__msg("R{{[0-9]+}}=trusted_ptr_or_null_inode")
+int BPF_PROG(inode_rename_no_null_check, struct inode *old_dir,
+	     struct dentry *old_dentry, struct inode *new_dir,
+	     struct dentry *new_dentry, unsigned int flags)
+{
+	ino_t ino = new_dentry->d_inode->i_ino;
+
+	if (ino == 0)
+		return -EACCES;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 8f0c45421f89..2a0813258183 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -159,18 +159,4 @@ int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
 	return 0;
 }
 
-SEC("lsm.s/inode_rename")
-__failure __msg("invalid mem access 'trusted_ptr_or_null_'")
-int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
-	     struct inode *new_dir, struct dentry *new_dentry,
-	     unsigned int flags)
-{
-	struct inode *inode = new_dentry->d_inode;
-	ino_t ino;
-
-	ino = inode->i_ino;
-	if (ino == 0)
-		return -EACCES;
-	return 0;
-}
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f798bbbb4d13..2ba6a83d243f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -702,6 +702,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	if (bpf_testmod_loop_test(101) > 100)
 		trace_bpf_testmod_test_read(current, &ctx);
 
+	trace_bpf_testmod_test_nullable_bare_tp(&ctx);
 	trace_bpf_testmod_test_nullable_bare_tp(NULL);
 
 	/* Magic number to enable writable tp */
diff --git a/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c b/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
index ec724d7b33d1..ecaa36355cae 100644
--- a/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
+++ b/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
@@ -7,14 +7,13 @@
 
 char _license[] SEC("license") = "GPL";
 
-u64 vtime_test;
-
 void BPF_STRUCT_OPS(maybe_null_running, struct task_struct *p)
 {}
 
 void BPF_STRUCT_OPS(maybe_null_fail_dispatch, s32 cpu, struct task_struct *p)
 {
-	vtime_test = p->scx.dsq_vtime;
+	/* Pointer arithmetic on a trusted-or-NULL pointer must be rejected. */
+	asm volatile("%[p] += 0" : [p] "+r"(p));
 }
 
 SEC(".struct_ops.link")
-- 
2.55.0

