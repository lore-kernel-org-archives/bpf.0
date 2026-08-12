Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10A403AE0
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573178; cv=none; b=tQlMCeXWgKtr8M7GFH8vgOBXiaxfH3YiX5klUMRPNlqIWIfg+PBr7vies1rqH9jgsfEbrHHc515aDIDEpauMcQq73p2a1/P5qSDbu/W+YDTmKNoLjsAEE4i/Ujd3x8chryhsFOMxiSLNf8Q74c+jHj8ozsx+by5vGyLeTo1jA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573178; c=relaxed/simple;
	bh=KjQgHhgjcuXbNZNxYL74e4OgyTiZ6y+kCouUSWcDBZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVXC6PXYFkO+iSu5BTljn1gbCQDh23EDgoDyit03POCB9GNASPy5W6lzg9dYBSWA1mQ0QRkkTiN4AeN3glrUYqORZQ80yvP45vhSvglHUWGuFgeiQ7j59GGo8w8D0vfsF2nQX2w3DEJbhj2awq8KBcGtZzX+evwWKk2kuSkTeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtXochE2; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtXochE2"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso9264f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573175; x=1787177975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vEw42Q1xUAmMkjJlUowVBlq0YQCGgOXGszmZXp5M+4=;
        b=NtXochE2vENtCTlnI2PHG8wr5eyuYCFlMEErXsYxDDVsHPxezi11lqCunC6rcCKCzt
         bIcgr93GFA1smyQHOUuR2xVWgThCbbDoc9vxAZwIsY8oMO3k4yfORdcZ7s0KKsNd9g4W
         FyWScUA806RbtmSdKtDP4Jh+ZIjlF+nq0uKrYxUT9dZd55DW4mwBqF0wQI5nGL8Bh2Vz
         d8IBS7xURL4EalVimb7sE2sW/BkU8X0qgAA//Z9SauXLLUIJDk1GAzDADUX/fjYeopaF
         T+PcqE+EC5/wc3vFUKjIUgySgBleS7WSP8OFgHJcziLYT8xxQXjOp4UwakYrV/bfw8+J
         xdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573175; x=1787177975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2vEw42Q1xUAmMkjJlUowVBlq0YQCGgOXGszmZXp5M+4=;
        b=Lo6pxgCnB6CD7rY1aL4WZp76wIPmtHKf4EhAkqs17OnNXDdW/kJt6/kfiNB2GhBKDM
         AEEvxsYuUPuGaDyW2ljn2TOW+36YA6x6pxmuOLyrI6Kc6u3GqLPQDUIimeG01Kw2g9rV
         bqF/vbDH6QVRJcX7uLv79jCKOhPU9KKA8hQo9oZEmq0dKGLQ/jaa303JfcsK5i+HEzmO
         3I1/X0jfY6KjJlLFbJNMpQE7fvA8gzoVsg5Lrm0+J1/SRaOAoDbFnBBXHT0SmfwUpjLe
         pkKCWKUwyMujQ1cw9Cy3XtckrFilesGy8oHt+3CoxiYeVR7s2nLrUuRPbbRb+BknUdXf
         XPAQ==
X-Gm-Message-State: AOJu0YyF66kuSEcr2lXfDbFnTXKj9jnKE3qk+6mW5gCdpK48P4WRoYEz
	00RV2rPr1JBpEOMPLClUOCDGrYkXPyTW09+i9GLEvqDAR8+29vGeliVQfOWqHT7a
X-Gm-Gg: AR+sD13LrLJsxtUfcwOvNoBT0QDFaKnSaBh+v3Q3fOzV20XH93HEzEq82GGEfEiACzv
	Bu/HLVOiJJEJ1UbuuBL8DvceWOiPXobyxhKi2y5ECM/Q8qPFkUubXCN+AHHyI8Assb2231rZd5x
	Iqxd/U9BgrjdX+k1647rlLYrMu4PTKMtVXk5CTeSQrVZaXHblZKZGoUfyicisN8EWLOpcOtUh/m
	Uh0ZY7WRWwv0mqcbomttLDg0N9o6kUGdKnxadVPZZjcWNe9yFCD8b4omgA15PM9dm61cs+7AT3r
	y9/9Q1+zu/SVr06oUon7WDXAeAKf3uz3n/Z2i2g0wFiUSpd3tWMstDgtEndP66pynuqSEl2KP4E
	7tbc9VLPrguMcwYZba4w7vXjlIXo12aeuBT2WQkD4UJgIx5Efyge5qDIancXsNCjbPcCl7tBUuJ
	BwjdsqmngZKXpX1dqw6J3ukVVxbfrmY5qV2q+FsW6u2prbWKeptpLQ41u3TDfe7s8yIYNGx8M/y
	bI4JtYBkMk2P+njcut2A+yxe/RoSbf5e4u75s0kBIKTVjGbI3EwGoVWNRfrqK+qEiAcyw64bsFI
	Dng9pgkYCVRvIJVaHJOoUGNrIbE=
X-Received: by 2002:a05:6000:4023:b0:481:57ef:9221 with SMTP id ffacd0b85a97d-4815a00d5bemr1443794f8f.22.1786573174773;
        Wed, 12 Aug 2026 15:19:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af19fsm982685f8f.24.2026.08.12.15.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:19:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 6/6] selftests/bpf: Test subprogram instruction statistics
Date: Thu, 13 Aug 2026 00:19:23 +0200
Message-ID: <20260812221925.3358041-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221925.3358041-1-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8094; i=memxor@gmail.com; h=from:subject; bh=KjQgHhgjcuXbNZNxYL74e4OgyTiZ6y+kCouUSWcDBZM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmwy+NI5PKj36YIa53ipH9rY18QbRg+x7X3hVvXz1YX m7/R66vo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNJXc7w38HaZf5rf92NH1hm Pj06rTJo9m7/isjSupLvdavflovYFDEybFkzreydtPm0iwUb59v2P557/MK8/wnxTe+EOQ8byUv oswEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add small verifier programs with deterministic instruction streams to
exercise per-subprogram self and inclusive instruction accounting. Use
assembly for normal call chains and straight-line callback bodies containing
only moves, calls, and returns or exits, so control-flow pruning does not make
the expected counts unstable. Pass callback arguments as explicit assembly
operands so the compiler keeps their registers live across the asm block.

Cover asynchronous callback attribution separately: main verification-root
totals include all callback exploration, while static and callback totals
remain local to their synchronous paths.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_subprog_insn_stats.c   | 223 ++++++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 5b265af3b1d5..8113fea7ba86 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -102,6 +102,7 @@
 #include "verifier_stack_arg_order.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_store_release.skel.h"
+#include "verifier_subprog_insn_stats.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subprog_topo.skel.h"
 #include "verifier_subreg.skel.h"
@@ -262,6 +263,7 @@ void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg); }
 void test_verifier_stack_arg_order(void)      { RUN(verifier_stack_arg_order); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_store_release(void)        { RUN(verifier_store_release); }
+void test_verifier_subprog_insn_stats(void)   { RUN(verifier_subprog_insn_stats); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subprog_topo(void)        { RUN(verifier_subprog_topo); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
new file mode 100644
index 000000000000..8f6082fdb5c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct timer_value {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct timer_value);
+} timer_map SEC(".maps");
+
+SEC("?raw_tp")
+__success __log_level(4)
+__msg("subprog 0 (stats_main_only) main insns_self 2 insns_total 2 stack 0")
+__msg("processed 2 insns")
+__naked int stats_main_only(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static int stats_chain_leaf(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static int stats_chain_parent(void)
+{
+	asm volatile (
+		"call stats_chain_leaf;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * self: 2 + 2 + 2 = 6
+ * totals: leaf 2, parent 2 + 2 = 4, main 2 + 4 = 6
+ */
+__msg("subprog 0 (stats_static_chain) main insns_self 2 insns_total 6 stack 0")
+__msg("subprog {{[0-9]+}} (stats_chain_parent) static insns_self 2 insns_total 4 stack 0")
+__msg("subprog {{[0-9]+}} (stats_chain_leaf) static insns_self 2 insns_total 2 stack 0")
+__msg("processed 6 insns")
+__naked int stats_static_chain(void)
+{
+	asm volatile (
+		"call stats_chain_parent;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static int stats_shared_leaf(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+int stats_global_root(void)
+{
+	asm volatile (
+		"call stats_shared_leaf;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * stats_shared_leaf is explored once under each independent root.
+ * self: main 3 + leaf 4 + global 2 = 9
+ * root totals: main 5 + global 4 = 9
+ */
+__msg("subprog 0 (stats_shared_roots) main insns_self 3 insns_total 5 stack 0")
+__msg("subprog {{[0-9]+}} (stats_shared_leaf) static insns_self 4 insns_total 4 stack 0")
+__msg("subprog {{[0-9]+}} (stats_global_root) global insns_self 2 insns_total 4 stack 0")
+__msg("processed 9 insns")
+__naked int stats_shared_roots(void)
+{
+	asm volatile (
+		"call stats_shared_leaf;"
+		"call stats_global_root;"
+		"exit;"
+	);
+}
+
+__noinline __used
+static int stats_async_leaf(void *map, __u32 *key, struct bpf_timer *timer)
+{
+	return 0;
+}
+
+__noinline __used
+static __u64 stats_async_schedule(struct bpf_map *map, __u32 *key,
+				  struct timer_value *value, void *ctx)
+{
+	asm volatile (
+		"r1 = %[timer];"
+		"r2 = %[stats_async_leaf];"
+		"call %[bpf_timer_set_callback];"
+		:
+		: [timer] "r" (value),
+		  __imm_ptr(stats_async_leaf),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_common
+	);
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * self: 9 + 7 + 2 = 18
+ * totals: leaf 2, scheduler 7, main root 18
+ */
+__msg("subprog 0 (stats_async_direct) main insns_self 9 insns_total 18 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_schedule) static insns_self 7 insns_total 7 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_leaf) static insns_self 2 insns_total 2 stack 0")
+__msg("processed 18 insns")
+__naked int stats_async_direct(void)
+{
+	asm volatile (
+		"r1 = %[timer_map] ll;"
+		"r2 = %[stats_async_schedule];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_for_each_map_elem];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(timer_map),
+		  __imm_ptr(stats_async_schedule),
+		  __imm(bpf_for_each_map_elem)
+		: __clobber_common
+	);
+}
+
+__noinline __used
+static int stats_async_nested_leaf(void *map, __u32 *key, struct bpf_timer *timer)
+{
+	return 0;
+}
+
+__noinline __used
+static int stats_async_outer(void *map, __u32 *key, struct bpf_timer *timer)
+{
+	asm volatile (
+		"r1 = %[timer];"
+		"r2 = %[stats_async_nested_leaf];"
+		"call %[bpf_timer_set_callback];"
+		:
+		: [timer] "r" (timer),
+		  __imm_ptr(stats_async_nested_leaf),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_common
+	);
+	return 0;
+}
+
+__noinline __used
+static __u64 stats_async_nested_schedule(struct bpf_map *map, __u32 *key,
+					 struct timer_value *value, void *ctx)
+{
+	asm volatile (
+		"r1 = %[timer];"
+		"r2 = %[stats_async_outer];"
+		"call %[bpf_timer_set_callback];"
+		:
+		: [timer] "r" (value),
+		  __imm_ptr(stats_async_outer),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_common
+	);
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(4)
+/*
+ * self: 9 + 7 + 7 + 2 = 25
+ * totals: leaf 2, outer 7, scheduler 7, main root 25
+ */
+__msg("subprog 0 (stats_async_nested) main insns_self 9 insns_total 25 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_nested_schedule) static insns_self 7 insns_total 7 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_outer) static insns_self 7 insns_total 7 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_nested_leaf) static insns_self 2 insns_total 2 stack 0")
+__msg("processed 25 insns")
+__naked int stats_async_nested(void)
+{
+	asm volatile (
+		"r1 = %[timer_map] ll;"
+		"r2 = %[stats_async_nested_schedule];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_for_each_map_elem];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(timer_map),
+		  __imm_ptr(stats_async_nested_schedule),
+		  __imm(bpf_for_each_map_elem)
+		: __clobber_common
+	);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

