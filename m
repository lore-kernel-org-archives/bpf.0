Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755492;
	b=hRzh0DMm1o6+vNtlfw1nt+4Ms66U6JbwzHgYWttS1H/OAuj3hvPpgDzTozO8YUfswY7l
	 nDiZFgOKEdvD+qwcTKySjrH4he88t7xk4e63rgvTWCRCR0cdy0mcAknAKuJ58zzwyCg2h
	 BO5SALSI4olutkunuB/Krtj+CN/TTnbUBGmMzwtAvlUQjRzJtGGaazqrcWTi+LLZVdpSb
	 PeHl4zEVGiZqiAOpg3lnpONHP1GQijZ56Tldg5jzzubeaeqhU01ja7f+HKVgizJZ3zPCA
	 DMwd0tshwAmO3sqhERt3H6e2RKtoFVy37cquxCCdk29xmoPxz5E1d06hLS9OBpHVwIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=viTzTrOrsJsF8b0V7PgYmqrVi7ZHWMLJFvwZhyFb6qQ=;
	b=kXokvRvtnq/Bol+wbNRXBK3ZVzWgIpf2iFjnFuI1KtA8s/3VcGgBZTaBKEhg9CvhkyT7
	 N2ktW8QJ8FZ1OXonJdcJok59+XBW1KeaZU8uDH1MycQ/sT8/RYmu6DWxv3A7QdXAd7ypo
	 7V4XkTy5U9ajjcAnE7VxKuRe4p/HuVef4Xidv4Eab7rDP44vOtkcWUvQx2DyxM50TOndd
	 4dQi+/VAYOM+o6M6UOeHiBkJnKMRA9VlDxtG7l9/b8wwPrK0pSYXbkkZzIYde4Zy2oNKF
	 QJ8CgOXFZUKe3eInlYxGAALiJWSLNrm3Orh6+vhDyRIp4qeBeESH9amg05UtTYG5WYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mbzwGakK;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1D606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B1D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mbzwGakK
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so1227865ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755491; x=1794360291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=viTzTrOrsJsF8b0V7PgYmqrVi7ZHWMLJFvwZhyFb6qQ=;
        b=mbzwGakKllQytbIHcFtfsiKh5TpL9GGnnLM7OvGOFaU5ls1GrWG974dLW6lGI1hl9V
         c4ZY7rvrDuOM8EvneQVqnbO+GmYqfQsNiEt84svF1/lHZm6wPiVUieonRiIKgJsg4PNt
         v/VizHi6m9XiVFeUM5j0LRJIkhC8qVWXTKTXIq5WbrZupZ+rYUZmqWsXgli5Eqp82ZEv
         iyx8phf7HflpROXEjWZr4PhkWGCmPothYwiT9vXEvUNd7gWMxjquJoBI6M/fOMkJKsCa
         ZVRow6ZZ0jGTIfAuWJ7aKIRgw3q8I7QJBzTLuztdb9X0sX8fE9AUAelVxAqufaAfvU7W
         BndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755491; x=1794360291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=viTzTrOrsJsF8b0V7PgYmqrVi7ZHWMLJFvwZhyFb6qQ=;
        b=sZddSjpjKSp58D6dN/7LoDJ3sS5RTAYdBpi3lmdNur3VaMx/mhxs2dZ3qE5Wq3UsIm
         VJsHLlhD2hvlklVuYrVrvjvnIoaAU+1UPhvi34muBV78p+ph6SE36hwtfUrUIkIlEppQ
         wx2LWYmyAKtCepCF6WNp/lfOcCHrXAIJPGVIblkDAivFWdfU24o3MrEKbaFiPobvO0hT
         ph3Y2xB+SYFENfbfp8Cc68EUf0+JpYGICC5YyzbqP4xQrUm/FgPUqD6BNSnJh4cOI7xO
         bCxo1RQwACDW8NBHvCx1vCkeKQZcDxetxz22pXmF1/M+YaanvXPB/Ai9z+phgXZy6SHf
         cDwQ==
X-Gm-Message-State: APuU4Z/Lhht/jYTVvYc0+9z4MOUsO74zlwnBwgm5fsf0v8n+Lm0zPV3B
	ONh+lHVZ45205cj5+f/juVNxD/Oerw+rG3i0wLaejWROd4yABHhtf/6g8m+qnA==
X-Gm-Gg: AYBFou3oSZgQk8rKzMjRjUmMQFatcxr1/vaDZB68T+zwyuaJIUjo7QHNfB7WFiCm7cx
	nLgi5jwNh0KCAme1Yj4ZJxuPZfSQ6HRofYnjxqI3ZjQBIuZT16GurmuyKl6WKia3R69ijb/vhZV
	zqL4oGNJ4mSWtC86v0Y5YVznzmm4HoXe9kCfAkwAcC1lgN1/wGFF1o+fWs4V5kGH817yOifpW72
	UIGrc/SSzQbtpdS0oRfmtz0WWUu6UIAHPpcncxZ77zJlTXSU1ij4PQGLpSD2/xHKK+MAABfbHu1
	2EkZiDFZ3rsJTkly6ym2NJRPBYMoqTRwxVAwVo/uLl5kiQfOMf9tYtQHzdTSzrOe4PmADKdQx5a
	WVaPb84N96XDxxiFJ6PMxd0yWavjLLYvbPMC8CKQQATYF5ZLlDDzShCPRRpdz+MYhqoWkCWq1Vn
	xEPsS0I+JwwnqDSghbodtb/auWVjuo2ti/E//o8nn+V0LtZ4sK5cJR0OT1G9ec6+1ghqus/fYAZ
	d6QsWfjBsUbl5bIScliozMVbBsf3u9G0HP30k0UXhRPiQ1hktABdBmErBkKvJw9uFCjAH2ru5Ar
	/k49uzOdvAYLBPYTTTvBjedPJU1wp4E6iPZAHSg8+ryAz07r+Udbx9RxfjxZtPjWRlAzDzESCxw
	wDvZsOgRlN7Exvxw+A5izGWP49auKHUKTYuBgglxbjLQkllOWRFhRGd0+9+Aiq0xWXWv1JDkPFR
	8=
X-Received: by 2002:a17:902:ce8d:b0:2e6:13b1:e196 with SMTP id d9443c01a7336-2eb36524f63mr120106385ad.74.1793755490883;
        Tue, 03 Nov 2026 17:24:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08bd518csm795745ad.10.2026.11.03.17.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 08/14] bpf: Introduce bpf register BPF_REG_ARENA_SP
Date: Wed,  4 Nov 2026 01:23:54 +0000
Message-ID: <20261104012401.1354861-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A Rust function that gets &T does not know where T is. T can be on the
heap, a static, or a local variable of the caller. The same insn accesses
all three. The heap and the statics of a Rust prog are in arena. Thus a
local variable whose address is taken must be in arena too, and the prog
needs a second stack there.

Each function must find the end of this stack. The places for the stack
pointer that were tried:

  stack pointer in         what is wrong with it
  -----------------------  ----------------------------------------------
  a per-cpu variable       A second run on the same cpu moves it, and the
                           first run can continue before the second ends.
  bpf_run_ctx              Load, add and store in each function.
  a hidden argument        It takes an argument register and a callee
                           saved register. BTF does not match the code.
  r9, reserved             The verifier changes too, and the prog has one
                           register less.
  a new register           It costs verifier code and a register in each
                           JIT. This series.

Introduce BPF_REG_ARENA_SP, r12, the stack pointer of the stack in arena.
BPF_REG_AX stays the last register and becomes r13:

  register            before    after
  ----------------    ------    -----
  BPF_REG_PARAMS      r11       r11
  BPF_REG_ARENA_SP              r12
  BPF_REG_AX          r12       r13

This patch only reserves the number. The verifier continues to reject insns
with r12.

BPF_REG_AX is visible in xlated insns. Adjust the selftests that match it
there.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/filter.h                        |  5 +-
 kernel/bpf/core.c                             |  3 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 14 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 24 +++----
 .../selftests/bpf/progs/verifier_may_goto_1.c | 12 ++--
 .../selftests/bpf/progs/verifier_patch_list.c |  6 +-
 .../selftests/bpf/progs/verifier_sdiv.c       | 64 +++++++++----------
 7 files changed, 65 insertions(+), 63 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index e9f619deb2a8..abc759ad14a6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -61,8 +61,9 @@ struct ctl_table_header;
 
 /* Kernel hidden auxiliary/helper register. */
 #define BPF_REG_PARAMS		MAX_BPF_REG
-#define BPF_REG_AX		(MAX_BPF_REG + 1)
-#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
+#define BPF_REG_ARENA_SP	(MAX_BPF_REG + 1)
+#define BPF_REG_AX		(MAX_BPF_REG + 2)
+#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 3)
 #define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG
 
 /* unused opcode to mark special call to bpf_tail_call() helper */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dcaf9cf13ce9..06d6d45b1c0e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1578,7 +1578,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 	u32 imm_rnd = get_random_u32();
 	int off;
 
-	BUILD_BUG_ON(BPF_REG_PARAMS + 2 != MAX_BPF_JIT_REG);
+	BUILD_BUG_ON(BPF_REG_PARAMS + 3 != MAX_BPF_JIT_REG);
+	BUILD_BUG_ON(BPF_REG_ARENA_SP + 2 != MAX_BPF_JIT_REG);
 	BUILD_BUG_ON(BPF_REG_AX + 1 != MAX_BPF_JIT_REG);
 
 	/* Constraints on AX register:
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 2c3124092b73..2d0bb771626d 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -69,19 +69,19 @@ static struct test_case test_cases[] = {
 #if defined(__x86_64__) || defined(__aarch64__)
 	{
 		N(SCHED_CLS, struct __sk_buff, tstamp),
-		.read  = "r12 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "if w12 & 0x4 goto pc+1;"
+		.read  = "r13 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
+			 "if w13 & 0x4 goto pc+1;"
 			 "goto pc+4;"
-			 "if w12 & 0x3 goto pc+1;"
+			 "if w13 & 0x3 goto pc+1;"
 			 "goto pc+2;"
 			 "$dst = 0;"
 			 "goto pc+1;"
 			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
-		.write = "r12 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "if w12 & 0x4 goto pc+1;"
+		.write = "r13 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
+			 "if w13 & 0x4 goto pc+1;"
 			 "goto pc+2;"
-			 "w12 &= -4;"
-			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r12;"
+			 "w13 &= -4;"
+			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r13;"
 			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
 	},
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index d908298b9fc7..314652a0006d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -915,13 +915,13 @@ __xlated("...")
 /* may_goto expansion starts, r0 and r1 are live */
 __xlated("10: r2 = ")
 __xlated("12: r2 = &(void __percpu *)(r2)")
-__xlated("13: r12 = *(u64 *)(r2 +0)")
-__xlated("14: if r12 == 0x0 goto pc+6")
-__xlated("15: r12 -= 1")
-__xlated("16: if r12 != 0x0 goto pc+2")
-__xlated("17: r12 = r2")
+__xlated("13: r13 = *(u64 *)(r2 +0)")
+__xlated("14: if r13 == 0x0 goto pc+6")
+__xlated("15: r13 -= 1")
+__xlated("16: if r13 != 0x0 goto pc+2")
+__xlated("17: r13 = r2")
 __xlated("18: call unknown")
-__xlated("19: *(u64 *)(r2 +0) = r12")
+__xlated("19: *(u64 *)(r2 +0) = r13")
 /* may_goto expansion ends */
 __xlated("20: *(u64 *)(r10 -8) = r1")
 __xlated("21: exit")
@@ -958,13 +958,13 @@ __xlated("7: call bpf_get_smp_processor_id")
 /* may_goto expansion starts, r0 and r1 are live */
 __xlated("8: r2 = ")
 __xlated("10: r2 = &(void __percpu *)(r2)")
-__xlated("11: r12 = *(u64 *)(r2 +0)")
-__xlated("12: if r12 == 0x0 goto pc+6")
-__xlated("13: r12 -= 1")
-__xlated("14: if r12 != 0x0 goto pc+2")
-__xlated("15: r12 = r2")
+__xlated("11: r13 = *(u64 *)(r2 +0)")
+__xlated("12: if r13 == 0x0 goto pc+6")
+__xlated("13: r13 -= 1")
+__xlated("14: if r13 != 0x0 goto pc+2")
+__xlated("15: r13 = r2")
 __xlated("16: call unknown")
-__xlated("17: *(u64 *)(r2 +0) = r12")
+__xlated("17: *(u64 *)(r2 +0) = r13")
 /* may_goto expansion ends */
 __xlated("18: *(u64 *)(r10 -8) = r1")
 __xlated("19: exit")
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 20152a15ca36..8d231fb2a317 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -97,13 +97,13 @@ __xlated("5: *(u64 *)(r0 +16) = 0")
 /* may_goto, r0 is dead */
 __xlated("6: r0 = ")
 __xlated("8: r0 = &(void __percpu *)(r0)")
-__xlated("9: r12 = *(u64 *)(r0 +0)")
-__xlated("10: if r12 == 0x0 goto pc+6")
-__xlated("11: r12 -= 1")
-__xlated("12: if r12 != 0x0 goto pc+2")
-__xlated("13: r12 = r0")
+__xlated("9: r13 = *(u64 *)(r0 +0)")
+__xlated("10: if r13 == 0x0 goto pc+6")
+__xlated("11: r13 -= 1")
+__xlated("12: if r13 != 0x0 goto pc+2")
+__xlated("13: r13 = r0")
 __xlated("14: call unknown")
-__xlated("15: *(u64 *)(r0 +0) = r12")
+__xlated("15: *(u64 *)(r0 +0) = r13")
 __xlated("16: r0 = 1")
 __xlated("17: r0 = 2")
 __xlated("18: exit")
diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index 581b75b7b5c5..5e8166bb79cc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -103,8 +103,8 @@ __xlated("10: goto pc+1")
 __xlated("11: r0 /= r1")
 __xlated("12: r2 = ")
 __xlated("14: r2 = &(void __percpu *)(r2)")
-__xlated("15: r12 = *(u64 *)(r2 +0)")
-__xlated("16: if r12 == 0x0 goto pc+9")
+__xlated("15: r13 = *(u64 *)(r2 +0)")
+__xlated("16: if r13 == 0x0 goto pc+9")
 __xlated("...")
 __xlated("22: if r1 != 0x0 goto pc+2")
 __xlated("23: w0 ^= w0")
@@ -220,7 +220,7 @@ __arch_arm64
 __success
 __xlated("12: if r6 != 0x0 goto pc-3")
 __xlated("...")
-__xlated("32783: if r12 != 0x0 goto pc+1")
+__xlated("32783: if r13 != 0x0 goto pc+1")
 __xlated("32784: gotol pc-32773")
 __naked void patch_list_may_goto_gotol(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 4ac92335da91..02e2065c9669 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -779,10 +779,10 @@ __arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r3 = -1")
 __xlated("3: r4 = r2")
-__xlated("4: r12 = r3")
-__xlated("5: r12 += 1")
-__xlated("6: if r12 > 0x1 goto pc+4")
-__xlated("7: if r12 == 0x0 goto pc+1")
+__xlated("4: r13 = r3")
+__xlated("5: r13 += 1")
+__xlated("6: if r13 > 0x1 goto pc+4")
+__xlated("7: if r13 == 0x0 goto pc+1")
 __xlated("8: r2 = 0")
 __xlated("9: r2 = -r2")
 __xlated("10: goto pc+1")
@@ -814,10 +814,10 @@ __arch_x86_64
 __arch_loongarch
 __xlated("0: r2 = 5")
 __xlated("1: r3 = -1")
-__xlated("2: r12 = r3")
-__xlated("3: r12 += 1")
-__xlated("4: if r12 > 0x1 goto pc+4")
-__xlated("5: if r12 == 0x0 goto pc+1")
+__xlated("2: r13 = r3")
+__xlated("3: r13 += 1")
+__xlated("4: if r13 > 0x1 goto pc+4")
+__xlated("5: if r13 == 0x0 goto pc+1")
 __xlated("6: r2 = 0")
 __xlated("7: r2 = -r2")
 __xlated("8: goto pc+1")
@@ -895,10 +895,10 @@ __arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
-__xlated("3: r12 = r3")
-__xlated("4: w12 += 1")
-__xlated("5: if w12 > 0x1 goto pc+4")
-__xlated("6: if w12 == 0x0 goto pc+1")
+__xlated("3: r13 = r3")
+__xlated("4: w13 += 1")
+__xlated("5: if w13 > 0x1 goto pc+4")
+__xlated("6: if w13 == 0x0 goto pc+1")
 __xlated("7: w2 = 0")
 __xlated("8: w2 = -w2")
 __xlated("9: goto pc+1")
@@ -931,10 +931,10 @@ __arch_loongarch
 __xlated("0: w2 = -5")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
-__xlated("3: r12 = r3")
-__xlated("4: w12 += 1")
-__xlated("5: if w12 > 0x1 goto pc+4")
-__xlated("6: if w12 == 0x0 goto pc+1")
+__xlated("3: r13 = r3")
+__xlated("4: w13 += 1")
+__xlated("5: if w13 > 0x1 goto pc+4")
+__xlated("6: if w13 == 0x0 goto pc+1")
 __xlated("7: w2 = 0")
 __xlated("8: w2 = -w2")
 __xlated("9: goto pc+1")
@@ -1013,10 +1013,10 @@ __arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r3 = -1")
 __xlated("3: r4 = r2")
-__xlated("4: r12 = r3")
-__xlated("5: r12 += 1")
-__xlated("6: if r12 > 0x1 goto pc+3")
-__xlated("7: if r12 == 0x1 goto pc+3")
+__xlated("4: r13 = r3")
+__xlated("5: r13 += 1")
+__xlated("6: if r13 > 0x1 goto pc+3")
+__xlated("7: if r13 == 0x1 goto pc+3")
 __xlated("8: w2 = 0")
 __xlated("9: goto pc+1")
 __xlated("10: r2 s%= r3")
@@ -1044,10 +1044,10 @@ __arch_loongarch
 __xlated("0: r2 = 5")
 __xlated("1: r3 = -1")
 __xlated("2: r4 = r2")
-__xlated("3: r12 = r3")
-__xlated("4: r12 += 1")
-__xlated("5: if r12 > 0x1 goto pc+3")
-__xlated("6: if r12 == 0x1 goto pc+3")
+__xlated("3: r13 = r3")
+__xlated("4: r13 += 1")
+__xlated("5: if r13 > 0x1 goto pc+3")
+__xlated("6: if r13 == 0x1 goto pc+3")
 __xlated("7: w2 = 0")
 __xlated("8: goto pc+1")
 __xlated("9: r2 s%= r3")
@@ -1121,10 +1121,10 @@ __arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
-__xlated("3: r12 = r3")
-__xlated("4: w12 += 1")
-__xlated("5: if w12 > 0x1 goto pc+3")
-__xlated("6: if w12 == 0x1 goto pc+4")
+__xlated("3: r13 = r3")
+__xlated("4: w13 += 1")
+__xlated("5: if w13 > 0x1 goto pc+3")
+__xlated("6: if w13 == 0x1 goto pc+4")
 __xlated("7: w2 = 0")
 __xlated("8: goto pc+1")
 __xlated("9: w2 s%= w3")
@@ -1154,10 +1154,10 @@ __arch_loongarch
 __xlated("0: w2 = -5")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
-__xlated("3: r12 = r3")
-__xlated("4: w12 += 1")
-__xlated("5: if w12 > 0x1 goto pc+3")
-__xlated("6: if w12 == 0x1 goto pc+4")
+__xlated("3: r13 = r3")
+__xlated("4: w13 += 1")
+__xlated("5: if w13 > 0x1 goto pc+3")
+__xlated("6: if w13 == 0x1 goto pc+4")
 __xlated("7: w2 = 0")
 __xlated("8: goto pc+1")
 __xlated("9: w2 s%= w3")
-- 
2.55.0

