Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6133033CD
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187939; cv=none; b=GKa9UGN3i6UH7k6kEi4GoQdTYNo7i7dnJwNZY4V79XZdFiYE2SinGRpXMQxDhzHpBhk7iTbqTw7JcVZeZIFLmK8U8Kz4r19vPNQGEjjlxItb16hOXi4M6fohOX4vzO1qJ3+OC7jO42WJlyUGTkIydjke3+Uj2gjva2sfO7umxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187939; c=relaxed/simple;
	bh=5hwLoaBJ+QJvnXZpfeaS0R6/kkVq/PFVKbEfp3i9Oec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blI5VqGk9eobPZFQ1n1yWNaVAyJ33DAB10e+FkQrgBF2sWioN6kbpDYHah8OPFIsuQxTJQD4qn1eCCx7JxQkFtg8oykCQ/qknQ8isSwU7FyHd/0qzYLwhw99S8il85EZrccALlOTaUm9UA7lXsDbb7QY229kxMEU29qTiNXyZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AyZHuK9P; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AyZHuK9P"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b884cb1e717so290676066b.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187935; x=1769792735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNGmXsvEyzoxbfrFja73yYXiOVaeDAL7lcwzNuQX+XI=;
        b=AyZHuK9PMgD7vrCPlVvK5VAKba4TzC7c4i3KOM1KrcfV+G1x3/MBdOL+O7dcA4ReyK
         HLNie8lINTG/lOS7isBq2w3RSJdOUzHH4fANrSeXHiPz5jUDpKNKPADQSSiQd+WigWWE
         xPV/ZdiHp/LPvxFfEiWJr1NlAeoyGUq+FfHMimBMRQxTW4PiiPWZvRZ7XPTXdQ7Ob++v
         xDpaQl2bs7ijU0sjWKhXIBxyv6flJDwZ28IMz3AWUtRt9xiWtFED8BHrQW9K8UnaG+JZ
         XHH3F357xqWHKx1kXLZR8abgNtfwquxVx0rCyLZa0SVDDyZ6DkvYZsnmw2YyHkS2xNEj
         jPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187935; x=1769792735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RNGmXsvEyzoxbfrFja73yYXiOVaeDAL7lcwzNuQX+XI=;
        b=qSEjqIeOHlxszEXaI4+5GQfm+QUuaVZzt8diAWDnOLBUe7Xm3KeDD6NcVJGyb8mtqx
         uS2N4oeHE6h+ISp3oOdMwQJrSo5DyRqVTOh0/jjZ5hNOLDNlOsGC67VSFQwhaQmhm9rz
         ncw8j9kV+hdYnuZnZAkrGIx4zaSLQN1Mmm0vkBKxeTISKqoWPI0zj1LtccobGYF1NZg/
         ZvT3YKE3QSt53KDbJfiyKYi0g0nDGhyuGgGT2ilyybjn0cwNmpcrPFZMWrYekDxKp1hY
         xjWujL9GLvZ9L1Mh6h5wwae0FpUHPjTPmV5cUs8Z5mTNHdeo4KyAoqRZpiMXrobMAS6B
         lUgw==
X-Gm-Message-State: AOJu0YxlDV7n+q7XWByiTTxTRgzJWO99vzBtxM2gjpqRHlYYB27xeMZS
	AqUXdygxBxohKT9DGhg/iLM86xcPmgboFWiTaWdDdX7ZHOiUFT/UzqXD2N88rQakE0g=
X-Gm-Gg: AZuq6aJHvU4wfIh6bCYXI2z0A2PQTUxfmJ1trRKwUgh73BQxntBV1+G1eWepMc7ZGKY
	T5wMwgL76VjO+tHX8Shp5dC8XanI7/VIMJlsYdWbPlNj+HDUe7zGhLHIBzNc2vdfT/4caL+a78w
	xDrbfgncI1Tp2V+XkLZ85F08S+iqMsiVnV/8sR5UIfCQZRqUJAi61Oy7vT9Im73BNIVRNVHwrWL
	Ac6sEepuL6yn2WXpjtPFf3AeCo6RIhwLt3VtW9FNPtW5QPbCbu7OkRAogZRO4msd6UeHxaHnNfl
	fakg98VY/T+0BzYnMShCP5ayKf5X6hDlS8fyPV5S9wzXuSgHIea/5EMa7ZtYXrW9BU+uqdY2lvi
	osjXPFyJZ+OrMw4l1ZuYYV74TpsYS6oM3Cz7JSYP4iy2TI6rZV7wFV6rQqSjQVh4WxCMlmO+Wat
	K6C9OmoKBapvyjXOzOBw+BzpWtR7Snuu4VCaThWhTspIAGsRXsfGw=
X-Received: by 2002:a17:907:3e90:b0:b84:3fab:4251 with SMTP id a640c23a62f3a-b885a3b69c5mr334177766b.15.1769187935481;
        Fri, 23 Jan 2026 09:05:35 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b4184absm134763966b.27.2026.01.23.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:34 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 23 Jan 2026 18:05:20 +0100
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Remove tests for
 prologue/epilogue with kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-3-0e50db4d4663@cloudflare.com>
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailer: b4 0.15-dev-07fe9

Remove pro_epilogue_with_kfunc test program and its supporting code in
bpf_testmod. This test exercised calling kfuncs from prologue and epilogue,
which is no longer supported after the switch to direct helper calls.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
 .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ---------------------
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------------
 3 files changed, 182 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 5d3c00a08a88..509883e6823a 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -6,7 +6,6 @@
 #include "epilogue_tailcall.skel.h"
 #include "pro_epilogue_goto_start.skel.h"
 #include "epilogue_exit.skel.h"
-#include "pro_epilogue_with_kfunc.skel.h"
 
 struct st_ops_args {
 	__u64 a;
@@ -56,7 +55,6 @@ void test_pro_epilogue(void)
 	RUN_TESTS(pro_epilogue);
 	RUN_TESTS(pro_epilogue_goto_start);
 	RUN_TESTS(epilogue_exit);
-	RUN_TESTS(pro_epilogue_with_kfunc);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c b/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
deleted file mode 100644
index a5a8f08ac8fb..000000000000
--- a/tools/testing/selftests/bpf/progs/pro_epilogue_with_kfunc.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
-
-#include <vmlinux.h>
-#include <bpf/bpf_tracing.h>
-#include "bpf_misc.h"
-#include "../test_kmods/bpf_testmod.h"
-#include "../test_kmods/bpf_testmod_kfunc.h"
-
-char _license[] SEC("license") = "GPL";
-
-void __kfunc_btf_root(void)
-{
-	bpf_kfunc_st_ops_inc10(NULL);
-}
-
-static __noinline __used int subprog(struct st_ops_args *args)
-{
-	args->a += 1;
-	return args->a;
-}
-
-__success
-/* prologue */
-__xlated("0: r8 = r1")
-__xlated("1: r1 = 0")
-__xlated("2: call kernel-function")
-__xlated("3: if r0 != 0x0 goto pc+5")
-__xlated("4: r6 = *(u64 *)(r8 +0)")
-__xlated("5: r7 = *(u64 *)(r6 +0)")
-__xlated("6: r7 += 1000")
-__xlated("7: *(u64 *)(r6 +0) = r7")
-__xlated("8: goto pc+2")
-__xlated("9: r1 = r0")
-__xlated("10: call kernel-function")
-__xlated("11: r1 = r8")
-/* save __u64 *ctx to stack */
-__xlated("12: *(u64 *)(r10 -8) = r1")
-/* main prog */
-__xlated("13: r1 = *(u64 *)(r1 +0)")
-__xlated("14: r6 = r1")
-__xlated("15: call kernel-function")
-__xlated("16: r1 = r6")
-__xlated("17: call pc+")
-/* epilogue */
-__xlated("18: r1 = 0")
-__xlated("19: r6 = 0")
-__xlated("20: call kernel-function")
-__xlated("21: if r0 != 0x0 goto pc+6")
-__xlated("22: r1 = *(u64 *)(r10 -8)")
-__xlated("23: r1 = *(u64 *)(r1 +0)")
-__xlated("24: r6 = *(u64 *)(r1 +0)")
-__xlated("25: r6 += 10000")
-__xlated("26: *(u64 *)(r1 +0) = r6")
-__xlated("27: goto pc+2")
-__xlated("28: r1 = r0")
-__xlated("29: call kernel-function")
-__xlated("30: r0 = r6")
-__xlated("31: r0 *= 2")
-__xlated("32: exit")
-SEC("struct_ops/test_pro_epilogue")
-__naked int test_kfunc_pro_epilogue(void)
-{
-	asm volatile (
-	"r1 = *(u64 *)(r1 +0);"
-	"r6 = r1;"
-	"call %[bpf_kfunc_st_ops_inc10];"
-	"r1 = r6;"
-	"call subprog;"
-	"exit;"
-	:
-	: __imm(bpf_kfunc_st_ops_inc10)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__retval(22022) /* (PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
-int syscall_pro_epilogue(void *ctx)
-{
-	struct st_ops_args args = {};
-
-	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
-}
-
-SEC(".struct_ops.link")
-struct bpf_testmod_st_ops pro_epilogue_with_kfunc = {
-	.test_pro_epilogue = (void *)test_kfunc_pro_epilogue,
-};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 77a81fa8ec6a..5d611f186f23 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1429,85 +1429,6 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 	return 0;
 }
 
-static int bpf_cgroup_from_id_id;
-static int bpf_cgroup_release_id;
-
-static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct_write,
-					  const struct bpf_prog *prog)
-{
-	struct bpf_insn *insn = insn_buf;
-
-	/* r8 = r1; // r8 will be "u64 *ctx".
-	 * r1 = 0;
-	 * r0 = bpf_cgroup_from_id(r1);
-	 * if r0 != 0 goto pc+5;
-	 * r6 = r8[0]; // r6 will be "struct st_ops *args".
-	 * r7 = r6->a;
-	 * r7 += 1000;
-	 * r6->a = r7;
-	 * goto pc+2;
-	 * r1 = r0;
-	 * bpf_cgroup_release(r1);
-	 * r1 = r8;
-	 */
-	*insn++ = BPF_MOV64_REG(BPF_REG_8, BPF_REG_1);
-	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
-	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 5);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_8, 0);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_6, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 1000);
-	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_7, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
-	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
-	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
-	*insn++ = prog->insnsi[0];
-
-	return insn - insn_buf;
-}
-
-static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
-					  s16 ctx_stack_off)
-{
-	struct bpf_insn *insn = insn_buf;
-
-	/* r1 = 0;
-	 * r6 = 0;
-	 * r0 = bpf_cgroup_from_id(r1);
-	 * if r0 != 0 goto pc+6;
-	 * r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
-	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
-	 * r6 = r1->a;
-	 * r6 += 10000;
-	 * r1->a = r6;
-	 * goto pc+2
-	 * r1 = r0;
-	 * bpf_cgroup_release(r1);
-	 * r0 = r6;
-	 * r0 *= 2;
-	 * BPF_EXIT;
-	 */
-	*insn++ = BPF_MOV64_IMM(BPF_REG_1, 0);
-	*insn++ = BPF_MOV64_IMM(BPF_REG_6, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_from_id_id);
-	*insn++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 6);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 10000);
-	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, offsetof(struct st_ops_args, a));
-	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
-	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
-	*insn++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
-	*insn++ = BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, 2);
-	*insn++ = BPF_EXIT_INSN();
-
-	return insn - insn_buf;
-}
-
-#define KFUNC_PRO_EPI_PREFIX "test_kfunc_"
 static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 			       const struct bpf_prog *prog)
 {
@@ -1517,9 +1438,6 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
-	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
-		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
-
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;
 	 * r7 += 1000;
@@ -1543,9 +1461,6 @@ static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog
 	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
 		return 0;
 
-	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
-		return st_ops_gen_epilogue_with_kfunc(insn_buf, prog, ctx_stack_off);
-
 	/* r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
 	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
 	 * r6 = r1->a;
@@ -1616,13 +1531,6 @@ static void st_ops_unreg(void *kdata, struct bpf_link *link)
 
 static int st_ops_init(struct btf *btf)
 {
-	struct btf *kfunc_btf;
-
-	bpf_cgroup_from_id_id = bpf_find_btf_id("bpf_cgroup_from_id", BTF_KIND_FUNC, &kfunc_btf);
-	bpf_cgroup_release_id = bpf_find_btf_id("bpf_cgroup_release", BTF_KIND_FUNC, &kfunc_btf);
-	if (bpf_cgroup_from_id_id < 0 || bpf_cgroup_release_id < 0)
-		return -EINVAL;
-
 	return 0;
 }
 

-- 
2.43.0

