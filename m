Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C725779
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358704; cv=none; b=MteahyUaCIClfDf0EupR1/Pl04dsOK50Y8oJrz/LvQl14BTum82YjFoktVSWZruSJ6uujWLOXoNTHfdIA5w9IpBoWVINzZ9I+4duSnF5ylrg13oZ2oGSXnqczc/9hR9r0sCcxcJqXN8BjqQEBG8BLOMntf0giLHSDgFvoHjYx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358704; c=relaxed/simple;
	bh=F7RcYy3MwVHvft4uwx+epQOqLzLoq5GjyAuxsWc0KOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCIoXlQUOrO2wyzCUXNSRUbjUaORaoYktdghZRavDTKbmyYYnXqkEZb63bG+SPPbnb2vOCxI987GZRgjjAaxmwWzU6xIEKAOeJkGbJ9rlvup3hUz56FwMeIo2EYXgCq0LXsbWWCBWWTUf5PmiqwcbBadg0XysFO5azlQQLMvW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz183Aoy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz183Aoy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e034607879so24189265ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712358701; x=1712963501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUCzISepvl1VnqDwWUjTqVgIi/r5yddY9aN79IzINzI=;
        b=hz183AoyUlpqBomDW7GhP/zeGnHtmaYbq5ve3Uycoe79sPaZRA3AmD4A5R+IsecEtm
         959BFCg8mlTCxAgZqtCL/qpE7x8kKyN8nFCCavHT3YcMXYvUlSTrSn0lP211cPs0suUS
         yA09wpY1wMwtZZqhzNgPZFUvIO25rmBx+F/7zOtAy+BSfwZXs6we4dzbk/zk2mITEJFS
         dAddkxHI36cDL6adFgrA5itCJZnWCiETYk1fRyFymtrNGNEsvtwCaoJzMuVmsLzPjnI/
         uH7Z60UtcZIzc1UUjHDAs/M+KeSPKYSD3cwIXp3x8sBlDsxbtPPRwM3iJbb7Tgi1n5H+
         7J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712358701; x=1712963501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUCzISepvl1VnqDwWUjTqVgIi/r5yddY9aN79IzINzI=;
        b=Jstw6H4iWs6AVYXe8bcKklaZYlIbXAj5FgenHuk+Dg/lGV0KkfB32YgO82Z7nWGECx
         CCESn5JnzOpQofe4+ICovCDwt5vrPeaH+6jH6vhZeDevyGL23rxTWrskAf6BHLqbASy7
         O4rYTkmyDdsv/aV9VFbp1eepcMuICivY1yfC83fxna+deIxzF+TrdDVyvT3gUvNrygHU
         vD/SyGprt1Kb/jPa8QSDtdJL3AMrIS/D5GFdxA3r+DczPPhhODYfsSpNpGt4eN1OC8fl
         LeoILYEFy87X61r5vxdJ1Swm2fsweOfPdHXD0jgZf3C8/kODdXZ1u9eA3DrTE8eQK81M
         w4gg==
X-Gm-Message-State: AOJu0YzFOkVjnBTFN13ZPIZBIn6K24SlOuJu1DyGwIRZadCVUknJCNzp
	NFgSqr1CZN+Mi9XJZTGxIsTHjwPXUdDXvnff2LgiAqhMPE0uzbEfewyAWqaz
X-Google-Smtp-Source: AGHT+IGwg5NVdeVubITEPxV2um0yKe9pcfriM7OuXQL3FhYYgEa4jVxoNp8UZ9ojaMaMADErVrNs4g==
X-Received: by 2002:a17:902:ce87:b0:1e3:c327:35c0 with SMTP id f7-20020a170902ce8700b001e3c32735c0mr3350011plg.2.1712358700625;
        Fri, 05 Apr 2024 16:11:40 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b42e])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001ddc0bc5934sm2146919plf.249.2024.04.05.16.11.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Apr 2024 16:11:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	puranjay@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for atomics in bpf_arena.
Date: Fri,  5 Apr 2024 16:11:34 -0700
Message-Id: <20240405231134.17274-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
References: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add selftests for atomic instructions in bpf_arena.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/arena_atomics.c  | 186 ++++++++++++++++++
 .../selftests/bpf/progs/arena_atomics.c       | 178 +++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_atomics.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_atomics.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 0445ac38bc07..cf657fc35619 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -10,3 +10,4 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
+arena_atomics
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index f4a2f66a683d..c34adf39eeb2 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -6,3 +6,4 @@ stacktrace_build_id                      # compare_map_keys stackid_hmap vs. sta
 verifier_iterating_callbacks
 verifier_arena                           # JIT does not support arena
 arena_htab                               # JIT does not support arena
+arena_atomics
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
new file mode 100644
index 000000000000..0807a48a58ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "arena_atomics.skel.h"
+
+static void test_add(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.add);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->add64_value, 3, "add64_value");
+	ASSERT_EQ(skel->arena->add64_result, 1, "add64_result");
+
+	ASSERT_EQ(skel->arena->add32_value, 3, "add32_value");
+	ASSERT_EQ(skel->arena->add32_result, 1, "add32_result");
+
+	ASSERT_EQ(skel->arena->add_stack_value_copy, 3, "add_stack_value");
+	ASSERT_EQ(skel->arena->add_stack_result, 1, "add_stack_result");
+
+	ASSERT_EQ(skel->arena->add_noreturn_value, 3, "add_noreturn_value");
+}
+
+static void test_sub(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.sub);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->sub64_value, -1, "sub64_value");
+	ASSERT_EQ(skel->arena->sub64_result, 1, "sub64_result");
+
+	ASSERT_EQ(skel->arena->sub32_value, -1, "sub32_value");
+	ASSERT_EQ(skel->arena->sub32_result, 1, "sub32_result");
+
+	ASSERT_EQ(skel->arena->sub_stack_value_copy, -1, "sub_stack_value");
+	ASSERT_EQ(skel->arena->sub_stack_result, 1, "sub_stack_result");
+
+	ASSERT_EQ(skel->arena->sub_noreturn_value, -1, "sub_noreturn_value");
+}
+
+static void test_and(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.and);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->and64_value, 0x010ull << 32, "and64_value");
+	ASSERT_EQ(skel->arena->and32_value, 0x010, "and32_value");
+}
+
+static void test_or(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.or);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->or64_value, 0x111ull << 32, "or64_value");
+	ASSERT_EQ(skel->arena->or32_value, 0x111, "or32_value");
+}
+
+static void test_xor(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.xor);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->xor64_value, 0x101ull << 32, "xor64_value");
+	ASSERT_EQ(skel->arena->xor32_value, 0x101, "xor32_value");
+}
+
+static void test_cmpxchg(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.cmpxchg);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->cmpxchg64_value, 2, "cmpxchg64_value");
+	ASSERT_EQ(skel->arena->cmpxchg64_result_fail, 1, "cmpxchg_result_fail");
+	ASSERT_EQ(skel->arena->cmpxchg64_result_succeed, 1, "cmpxchg_result_succeed");
+
+	ASSERT_EQ(skel->arena->cmpxchg32_value, 2, "lcmpxchg32_value");
+	ASSERT_EQ(skel->arena->cmpxchg32_result_fail, 1, "cmpxchg_result_fail");
+	ASSERT_EQ(skel->arena->cmpxchg32_result_succeed, 1, "cmpxchg_result_succeed");
+}
+
+static void test_xchg(struct arena_atomics *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* No need to attach it, just run it directly */
+	prog_fd = bpf_program__fd(skel->progs.xchg);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	ASSERT_EQ(skel->arena->xchg64_value, 2, "xchg64_value");
+	ASSERT_EQ(skel->arena->xchg64_result, 1, "xchg64_result");
+
+	ASSERT_EQ(skel->arena->xchg32_value, 2, "xchg32_value");
+	ASSERT_EQ(skel->arena->xchg32_result, 1, "xchg32_result");
+}
+
+void test_arena_atomics(void)
+{
+	struct arena_atomics *skel;
+	int err;
+
+	skel = arena_atomics__open();
+	if (!ASSERT_OK_PTR(skel, "arena atomics skeleton open"))
+		return;
+
+	if (skel->data->skip_tests) {
+		printf("%s:SKIP:no ENABLE_ATOMICS_TESTS or no addr_space_cast support in clang",
+		       __func__);
+		test__skip();
+		goto cleanup;
+	}
+	err = arena_atomics__load(skel);
+	if (!ASSERT_OK(err, "arena atomics skeleton load"))
+		return;
+	skel->bss->pid = getpid();
+
+	if (test__start_subtest("add"))
+		test_add(skel);
+	if (test__start_subtest("sub"))
+		test_sub(skel);
+	if (test__start_subtest("and"))
+		test_and(skel);
+	if (test__start_subtest("or"))
+		test_or(skel);
+	if (test__start_subtest("xor"))
+		test_xor(skel);
+	if (test__start_subtest("cmpxchg"))
+		test_cmpxchg(skel);
+	if (test__start_subtest("xchg"))
+		test_xchg(skel);
+
+cleanup:
+	arena_atomics__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
new file mode 100644
index 000000000000..55f10563208d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 10); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
+__u32 pid = 0;
+
+#undef __arena
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+#define __arena __attribute__((address_space(1)))
+#else
+#define __arena SEC(".addr_space.1")
+#endif
+
+__u64 __arena add64_value = 1;
+__u64 __arena add64_result = 0;
+__u32 __arena add32_value = 1;
+__u32 __arena add32_result = 0;
+__u64 __arena add_stack_value_copy = 0;
+__u64 __arena add_stack_result = 0;
+__u64 __arena add_noreturn_value = 1;
+
+SEC("raw_tp/sys_enter")
+int add(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+	__u64 add_stack_value = 1;
+
+	add64_result = __sync_fetch_and_add(&add64_value, 2);
+	add32_result = __sync_fetch_and_add(&add32_value, 2);
+	add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
+	add_stack_value_copy = add_stack_value;
+	__sync_fetch_and_add(&add_noreturn_value, 2);
+#endif
+
+	return 0;
+}
+
+__s64 __arena sub64_value = 1;
+__s64 __arena sub64_result = 0;
+__s32 __arena sub32_value = 1;
+__s32 __arena sub32_result = 0;
+__s64 __arena sub_stack_value_copy = 0;
+__s64 __arena sub_stack_result = 0;
+__s64 __arena sub_noreturn_value = 1;
+
+SEC("raw_tp/sys_enter")
+int sub(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+	__u64 sub_stack_value = 1;
+
+	sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
+	sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
+	sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
+	sub_stack_value_copy = sub_stack_value;
+	__sync_fetch_and_sub(&sub_noreturn_value, 2);
+#endif
+
+	return 0;
+}
+
+__u64 __arena and64_value = (0x110ull << 32);
+__u32 __arena and32_value = 0x110;
+
+SEC("raw_tp/sys_enter")
+int and(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+
+	__sync_fetch_and_and(&and64_value, 0x011ull << 32);
+	__sync_fetch_and_and(&and32_value, 0x011);
+#endif
+
+	return 0;
+}
+
+__u32 __arena or32_value = 0x110;
+__u64 __arena or64_value = (0x110ull << 32);
+
+SEC("raw_tp/sys_enter")
+int or(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+	__sync_fetch_and_or(&or64_value, 0x011ull << 32);
+	__sync_fetch_and_or(&or32_value, 0x011);
+#endif
+
+	return 0;
+}
+
+__u64 __arena xor64_value = (0x110ull << 32);
+__u32 __arena xor32_value = 0x110;
+
+SEC("raw_tp/sys_enter")
+int xor(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+	__sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
+	__sync_fetch_and_xor(&xor32_value, 0x011);
+#endif
+
+	return 0;
+}
+
+__u32 __arena cmpxchg32_value = 1;
+__u32 __arena cmpxchg32_result_fail = 0;
+__u32 __arena cmpxchg32_result_succeed = 0;
+__u64 __arena cmpxchg64_value = 1;
+__u64 __arena cmpxchg64_result_fail = 0;
+__u64 __arena cmpxchg64_result_succeed = 0;
+
+SEC("raw_tp/sys_enter")
+int cmpxchg(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+	cmpxchg64_result_fail = __sync_val_compare_and_swap(&cmpxchg64_value, 0, 3);
+	cmpxchg64_result_succeed = __sync_val_compare_and_swap(&cmpxchg64_value, 1, 2);
+
+	cmpxchg32_result_fail = __sync_val_compare_and_swap(&cmpxchg32_value, 0, 3);
+	cmpxchg32_result_succeed = __sync_val_compare_and_swap(&cmpxchg32_value, 1, 2);
+#endif
+
+	return 0;
+}
+
+__u64 __arena xchg64_value = 1;
+__u64 __arena xchg64_result = 0;
+__u32 __arena xchg32_value = 1;
+__u32 __arena xchg32_result = 0;
+
+SEC("raw_tp/sys_enter")
+int xchg(const void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+#ifdef ENABLE_ATOMICS_TESTS
+	__u64 val64 = 2;
+	__u32 val32 = 2;
+
+	xchg64_result = __sync_lock_test_and_set(&xchg64_value, val64);
+	xchg32_result = __sync_lock_test_and_set(&xchg32_value, val32);
+#endif
+
+	return 0;
+}
-- 
2.43.0

