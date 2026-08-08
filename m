Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EB4B04BB
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170373; cv=none; b=NUT4as5elImjIbANoeQNhb1qcMA+tB7M5RUpf8GMLNGHDs2yOWtD/7P9nzoe8CYB6Q9ukZXC6+V4NyYt+bW9cpBGRYYKlK2c2bTrhF02wnrs0JkiawFLLO8aGRgoGLQPnA0otQLrzJvlczSgv/qa3mage36PAYf6YE27ym7/rZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170373; c=relaxed/simple;
	bh=yREv7YVpUaX75daS/VM0OnB3IjzQs4qIbe9Dm4ww0Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smPgzp8x/tyakG+QknMYhIOljU3J2AXIpLMHFiNN0k+6u99gMooogKgw4/Sn/jgT+OnmKWt01V2NpXrqelCiqeKTn2Qkz3+9OK2P5io/yJVj0TGAQh5jEKZjtO06RXknAW5zUKpUojb39Ym60OJBqrPprk27GwXPOq53SLsUoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5tOOMnn; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5tOOMnn"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4700bd8aed1so10841f8f.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170370; x=1786775170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZru2eXO1yIth/SPLoNpVDS38lOoGs+oJNk/8X02EcE=;
        b=I5tOOMnneADUvhogUE7MCfsL6D22Ye1U4IH08Ljl4xnxQDcXQvkb2JTJhgPJzAou2w
         zFa4C3KqnuQXYydG7SYaFpcHckKiOyCJR3X5hriby/4IiLVZ9A5r75Hqlb4TEkq/lZF7
         iwvGkR6e4RAq+19z60ec4olIO7YUt1GR1E3tu9SGO7NRIJQ93xR3S+IVw2pEKCok0X8l
         kiNRjHDYOHl9tfENaBTRAOuVGhujanftZRCEEwEHaJD31KhQxhQo5Mx87e15LkbSRnP2
         ieWmZ3FA1U509Pr3mu4GMAiNcjg9XDYcY409vnCur88bXEfFDU0Gah7zi9iTexeeP67r
         oxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170370; x=1786775170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZru2eXO1yIth/SPLoNpVDS38lOoGs+oJNk/8X02EcE=;
        b=AWghAUJhRe/6MotmUrD6Ql64xDbdj6nmeksw93bHk7/jVObp/mGmIJOhmlxSKZwxQ8
         BvPzhNOuuvRZ+YKfUapq7NzOKVMByn3QdDLz/8+grvjdn8hPnv6Y/KoWRTcaIjgIKTWe
         XIdeZwqKouufTfFEfNEEFim9RI28vHU7Z0T8woQGZ4nhmJLjj2SjF2lOURUVkgpi4Yxh
         5lvmSZxh0Q/A/fcRzyigIWoqESRHPXKYqcauqvM/6GXSksRj21Ws9VfuD+QJBh46HIUj
         d3U869hD6zToTuIAgEzEYqQOWsNRB9qDvqW95JQFBmwGsH7Tou8MKXLVKwvA0w300afs
         DPyA==
X-Gm-Message-State: AOJu0Ywqa8pfBnQVVBDEnHc6F3iVjIikTt0ivF0AHLk1IwiqMKaWvnT6
	3zyjIbSdbZDn7z+JZFLwKIfKCmTy+6wXdw8gK+SW4I95cZAHmlbtde9xiFcffitzeMU=
X-Gm-Gg: AR+sD132OyORGQRYkf0oUKf2/QInmdVzk1CpLNPgxBN1T/rBgncsP+sqOA9SD8smCQT
	SuxGuA7cAwcyVSzKmgp65un+9oObaGodO29UBYubQm4JYiGr/Jgm3q6+hg2oQjZonNFu8m3k3LA
	kpGIT8eW4aBLo3EEY9iFzW8cBagyx36pJrYG09QnJdatgmDpMJALCtI1ASWkBhtVD/XtSMb5IKR
	scxlBEdghYEr3xArxRwav0bXbR+59Mtd4JQIZIjG34VLI1sKc8T8QXKmLMUbK/ka6yKndtI2BVZ
	ZTuxFpLci/AJTuC4G7qSuHol1Y10G5EP89DM4hGln5R2lhOz5zW8+9yIGVoOfItBOwe5OAc4DSp
	AoR3WgvuSF0CZQIH9AQzWC3l5m/br0lelTtAccOaUR42ea1FzJngSS4WhY6LYFhFyNNg3WH11hY
	5BHDk8e/TcsRVuCc41TRazt/fu4rElZpeQ95NH2Uz2MzrWeleOL1p3+e91VbDQPinh0YvGV1Usv
	+IAayG5JnlOJ7xUn//q0TSS8XdABRCAHZDwELIcQNtmRXboagZhq3AXCZDknXMiCEeUNU0t3Lw1
	sbaeoCZ7jFiL8MPMTqmyn9CNYYw=
X-Received: by 2002:a05:6000:41ed:b0:47f:9158:5924 with SMTP id ffacd0b85a97d-4813194f0aamr4824852f8f.9.1786170369921;
        Fri, 07 Aug 2026 23:26:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm12447859f8f.28.2026.08.07.23.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 6/6] selftests/bpf: Test subprogram instruction statistics
Date: Sat,  8 Aug 2026 08:25:58 +0200
Message-ID: <20260808062601.1070988-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808062601.1070988-1-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8101; i=memxor@gmail.com; h=from:subject; bh=yREv7YVpUaX75daS/VM0OnB3IjzQs4qIbe9Dm4ww0Vk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavs9G1JbcmSJ3JxpybOYWcu+rP6kuXepQs2z3jgpvHjW 9K9Fc+0OkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRPE5GhvvHmlveHe1K+7Yh 4O3RTzGftV8tErzDv8D238IQ+/Rd3IwM/yxFPmvMPa/+O5cl1PHivH179BZNfHExbcvDOxP7bXN b5VgB
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_subprog_insn_stats.c   | 228 ++++++++++++++++++
 2 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b79bafca68f7..19d03f6d6525 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -100,6 +100,7 @@
 #include "verifier_stack_arg_order.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_store_release.skel.h"
+#include "verifier_subprog_insn_stats.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subprog_topo.skel.h"
 #include "verifier_subreg.skel.h"
@@ -255,6 +256,7 @@ void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg); }
 void test_verifier_stack_arg_order(void)      { RUN(verifier_stack_arg_order); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_store_release(void)        { RUN(verifier_store_release); }
+void test_verifier_subprog_insn_stats(void)   { RUN(verifier_subprog_insn_stats); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subprog_topo(void)        { RUN(verifier_subprog_topo); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
new file mode 100644
index 000000000000..cbf83ee9f8f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
@@ -0,0 +1,228 @@
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
+__msg("subprog {{[0-9]+}} (stats_async_schedule) static insns_self 7 "
+      "insns_total 7 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_leaf) static insns_self 2 "
+      "insns_total 2 stack 0")
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
+__msg("subprog {{[0-9]+}} (stats_async_nested_schedule) static insns_self 7 "
+      "insns_total 7 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_outer) static insns_self 7 "
+      "insns_total 7 stack 0")
+__msg("subprog {{[0-9]+}} (stats_async_nested_leaf) static insns_self 2 "
+      "insns_total 2 stack 0")
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

