Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983722;
	b=wrhnp+F2P83jdk7s9IV1GxHGugSW0Ic8+okRsOSbTVvjbTBL5h9vUVu3sGYMWjnxaSAA
	 KELbDgQdJAK735s7GkDTb0vPfnAs4DkGXboQdPfIAY75xQO5PPp/kbQUaACto6P3di4LW
	 0rAI4iwLRAdw/zHdTbKmoJU6Ow2PyxvFc6M1/VRJ5Lyhe98WYFz0HzHHz/nbp58w8JjcB
	 /B6d/YNOQ7H/I92YAx3wWQpmd6sHm1D5oIRbmZhvgigRedxwkHKOehunpdKMHzDvqm4x4
	 Hya6RHbtXEA78mlRwYWxk5rRpe2KDO4fsb7FFI0+AaQB+jpmCCEaEBydfLYakhIquTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OAE30AVSh6tID4agLrDpMuda4vbJkvqivzeCgIAqISc=;
	b=efk2y9AvTek/37v9VOu6HCFf2rxcSrh+aDWnSyMzKIut9PBfeq1NOhc6AF/8cqyempYB
	 f3BL/xZZFjN7zHws5FGbI0WAleShjM+PjDpn7KL+4tJKV3Q+ZbkvRp3w2mD1ZZMG9VxDw
	 XLd9N4kwKrQLOaIhDUsj3gJqzj3On5l2zydGd9GtkgzVo6wAFiDY8j5DgecZVPbIrH9DT
	 UBFsLcvKxJdzt2ikHvk6xlYoC9KQSuI/GI6NFAvNwIsfGjQe8nj8QNI3JV4QA1pAjAJ4V
	 088nYDXAbwE2uMmRuPxVaZwb6Qu++EfI2NywjIhWfVpXgQBGokVHIPGyh8UyQDQmKMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dEczREaN;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7008E606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7008E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dEczREaN
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so2045173a91.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983722; x=1793588522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAE30AVSh6tID4agLrDpMuda4vbJkvqivzeCgIAqISc=;
        b=dEczREaNhKDHTw8z1W+R0y82IMc7t/LiMZZ73F28Ynz9DGDubBDEnjEBxQJd7JACRR
         jvBgzEKaJvEqKYOeO3IZupXlOiFYtKFz4wvpk3M40uRUHZ/0A2QC5fSRXZp+UpC1mjRT
         XCEheGLgIDHv34nNUBQMF9eCB7FFLe9t8eD4nAeZJWhhUqkMtfcLP+jXFnLD1ImOxPpn
         wQeXfqrag6Zz8AAHfF6UFsZerpb9EL0Sez9burk7J0K7I+jYCf8irQdXUCOTsiFTI7pr
         ed+iaqluGXfcqADTtzw21/pgw2wVabEXY50vZ63JoVgtCIYvH20C9UChLYwcNIicxaqL
         mMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983722; x=1793588522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAE30AVSh6tID4agLrDpMuda4vbJkvqivzeCgIAqISc=;
        b=FbS5zzmTi6LHaP6o9QrHLVvhxZOVDGYuY5x+F92w8as5rsBGJADoCCXaZtUT4C9SBj
         +LGQ+ftvi+dn+tUT4GepVH4Z8VKXNqVXD2JnS0cS6NnW62tSOtTd4AXiqQj7OgK6639H
         AY5vekBZEGjNxZDmEdSONGinfkBHlfetiCuUUSCNpEwSbL0WdZitkVMdjaoZuEAJRJws
         fpiZ4gUFVEzL8KdnoTeATI/kLj5uepeiGvconQIkjRgqhPEsbAXAkU+MW+Ska5e49qM2
         xxuQsBSOaNIhjvZwTVDZqVvJI2xltB0pgPLDMVjOuMM6EnCgm/kGfadHoQ8Rn9MzdQba
         sDDQ==
X-Gm-Message-State: AFq9FYJ9vKFwYF7xcPMf3xPOjjV0mjWEYrrImgxHQ977PjugDC5TEFxL
	BYLchI4EZDjqH964oKHsfHLr7t2QYFyS1RKpkzSlKDgWlKviKP7HvlhXmB+uDw==
X-Gm-Gg: AYBFou3qKvujXvFiX6MrlVhKXOJ25rITnCkG+OGh7+MCVHStcUGs2r7/j70hDw4G98M
	O2e9RooAC2dbNacG6zFSRBOm3nkdzM8tUctEVO+tAMjBmYnKTTnVly+ofhq97TbSNPSakQveqTq
	dH+4qEaQpmnLOGX1se/94j5egw2SIofYV1URimbnZH9quJeykNnexU2Ph2Fix9wdzN8vM0Idgwq
	VaqFRTtdRY9P94y0p/k/7NJYvXS2hJeVoAf+AWTqLAGJFESfUoytZpXUHUuOPWcyfKNpdZ95Rij
	KU8df7DBcR/MD89nhFyQho6xFixbsUZ9v1CDregWPPrHFG/W405ttnllTPGuCxwX7omIr4QPwK5
	SLaKoScTRMSuzUWG4Ef4yW9ABxzcNemoiFeOue1AUSIgzXdiL3uvjE3Ps8DFuCRbLg/Kfkxnth8
	TwV8KHHa2sFp8uYIaPZCLJKAXs0Ubg9FXzV4yPzDgTbqSbh/o/fRW/XbBYi/XtVHhtHo4v+CGwj
	HE6cqsRXZ2cv3hqkXdQYY8MtAjsR/igc+EkTWvXGzxjzjBDbvxLGuoXkwfiwKumQch2+cdYulcs
	FNOneQxA6O3g4DvfVGL92zl8daboh8YAQO9ggDcAa6gMjMVEI79qQOxoSAnhVkbp/JGzV4GaMSS
	TQW+vxTb0J5OUr89ONvRKbf8m
X-Received: by 2002:a17:90b:2252:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3adeaea178fmr5106307a91.43.1792983721638;
        Sun, 25 Oct 2026 20:02:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm6439148a91.12.2026.10.25.20.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 23/81] bpf: Introduce bpf register BPF_REG_ARENA_SP
Date: Mon, 26 Oct 2026 02:58:44 +0000
Message-ID: <20261026025943.404450-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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
 .../selftests/bpf/progs/verifier_sdiv.c       | 64 +++++++++----------
 6 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 98254742ae37..f57916e95b94 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -60,8 +60,9 @@ struct ctl_table_header;
 
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
index 472efced9e40..94ee44ad88f7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1368,7 +1368,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
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
index e0c389102db9..5cd503e87df9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -913,13 +913,13 @@ __xlated("...")
 __xlated("4: r0 = &(void __percpu *)(r0)")
 __xlated("...")
 /* may_goto expansion starts */
-__xlated("6: r12 = *(u64 *)(r10 -24)")
-__xlated("7: if r12 == 0x0 goto pc+6")
-__xlated("8: r12 -= 1")
-__xlated("9: if r12 != 0x0 goto pc+2")
-__xlated("10: r12 = -24")
+__xlated("6: r13 = *(u64 *)(r10 -24)")
+__xlated("7: if r13 == 0x0 goto pc+6")
+__xlated("8: r13 -= 1")
+__xlated("9: if r13 != 0x0 goto pc+2")
+__xlated("10: r13 = -24")
 __xlated("11: call unknown")
-__xlated("12: *(u64 *)(r10 -24) = r12")
+__xlated("12: *(u64 *)(r10 -24) = r13")
 /* may_goto expansion ends */
 __xlated("13: *(u64 *)(r10 -8) = r1")
 __xlated("14: exit")
@@ -954,13 +954,13 @@ __xlated("1: *(u64 *)(r10 -16) =")
 __xlated("2: r1 = 1")
 __xlated("3: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
-__xlated("4: r12 = *(u64 *)(r10 -24)")
-__xlated("5: if r12 == 0x0 goto pc+6")
-__xlated("6: r12 -= 1")
-__xlated("7: if r12 != 0x0 goto pc+2")
-__xlated("8: r12 = -24")
+__xlated("4: r13 = *(u64 *)(r10 -24)")
+__xlated("5: if r13 == 0x0 goto pc+6")
+__xlated("6: r13 -= 1")
+__xlated("7: if r13 != 0x0 goto pc+2")
+__xlated("8: r13 = -24")
 __xlated("9: call unknown")
-__xlated("10: *(u64 *)(r10 -24) = r12")
+__xlated("10: *(u64 *)(r10 -24) = r13")
 /* may_goto expansion ends */
 __xlated("11: *(u64 *)(r10 -8) = r1")
 __xlated("12: exit")
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 6fe602c8c7f3..49753e89cce9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -89,13 +89,13 @@ __arch_riscv64
 __arch_loongarch
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
-__xlated("2: r12 = *(u64 *)(r10 -16)")
-__xlated("3: if r12 == 0x0 goto pc+6")
-__xlated("4: r12 -= 1")
-__xlated("5: if r12 != 0x0 goto pc+2")
-__xlated("6: r12 = -16")
+__xlated("2: r13 = *(u64 *)(r10 -16)")
+__xlated("3: if r13 == 0x0 goto pc+6")
+__xlated("4: r13 -= 1")
+__xlated("5: if r13 != 0x0 goto pc+2")
+__xlated("6: r13 = -16")
 __xlated("7: call unknown")
-__xlated("8: *(u64 *)(r10 -16) = r12")
+__xlated("8: *(u64 *)(r10 -16) = r13")
 __xlated("9: r0 = 1")
 __xlated("10: r0 = 2")
 __xlated("11: exit")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index d6cbe1e27fd6..0efbfa726764 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -778,10 +778,10 @@ __arch_x86_64
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
@@ -812,10 +812,10 @@ __success __retval(-5)
 __arch_x86_64
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
@@ -890,10 +890,10 @@ __arch_x86_64
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
@@ -925,10 +925,10 @@ __arch_x86_64
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
@@ -1004,10 +1004,10 @@ __arch_x86_64
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
@@ -1034,10 +1034,10 @@ __arch_x86_64
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
@@ -1108,10 +1108,10 @@ __arch_x86_64
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
@@ -1140,10 +1140,10 @@ __arch_x86_64
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

