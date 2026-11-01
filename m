Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502361;
	b=jXOIBR2jZW4l5GE3WgFqJWiOFyOpnVTDJqW30SEsA05aHjJ41/N8e34ObxAC8XamGAHQ
	 m6n9Yxx8H1WI92rwuffQt6pzG7wFPQhZhkQsBmBJRvcay2YiypV7wTr4+RzX99qiusa0N
	 7lzqnR/uH7Osvzj33ImiKGenT1uThggC5h7Gm3DxesgCv3shFykUOyUmvlU21c1alv3jR
	 0QJBax63/dPC9uRIEmcskoeK+Dg7NkjIy7jfy5sfNyyNVmqT9kwzj2pUHgbZbmd8Cl9HN
	 w764K3tmz5B9kCd5Q/6DX8IHwSBBPiNn9CfbOe2TIhiSPGTkQ7YTU2cKiKxJ5I1cZXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q+g1SoJk0IMG5iDATITlmaPSh0Vf7kHVgVcxNLVDi10=;
	b=DTYxZzdBgfkbdJpt6QrggY0Wtr1xCXWMdX4K7KhNvG4+2vLbzx5Afx5YB8FP1eFvMiWf
	 J7awMhw0ldmPPBWBhnyTDgdSxRyw4VXVBy7MAjgEooueo190aYNXZogjkoTlT47KOeybl
	 GKC+/Ko/fDxAJ0RdrX/TtZGUgKYPxcwh4pY+lPE7QP5uMzLDyAO+yh/prtvgQQjhJMI2E
	 PHV4gxmpbPOljTsAeEdbJoW53MmGNwT4je/7W/F3a4tLiIjA9fsQUkdx86uYzVWTQkPam
	 zdfqvbnbrclhAegtbtWgoZ7wdB5wWycH5kFf4HSU5beo8ESD97nCcTYJ+5jEzPmOLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deaSll+Q;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC4606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01BC4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deaSll+Q
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab938dc83so760398a12.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502360; x=1794107160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+g1SoJk0IMG5iDATITlmaPSh0Vf7kHVgVcxNLVDi10=;
        b=deaSll+QQwG5/gBEvDhcIZu1WalL3zcN2/tUSpiw0s5gzdTST8eqoGtsD2BHvVOdVN
         GeJSBQPE2d+CNhp+jqMtcK/1Qi376Ml075AvqU3n8F2fIy7jHshUERfZtDAFWXj3i5QL
         FSV3XEC+FrH6GESpH8y5tz8OCHdy89ewTncGUMcMaE6BpeyQ9YoNebjBKUAAHifmqzaa
         Eh5Zj21qfGbhK2SlqCbGtDLzvlNCJw+eXywlOXhLuHoVppWPaqhMEbRc2OHJcXRCrS2E
         bAYFAlpeM/w6WrUcRexoxS7u8q7CNqvT71+yYa0iA/sc7m5gP6vEvhREywSrXZftGuLg
         5pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502360; x=1794107160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+g1SoJk0IMG5iDATITlmaPSh0Vf7kHVgVcxNLVDi10=;
        b=cxu4CKHj1XXys6zNG3/6sun6p6csf1FvyWKAzAEvUay74r3rKkFGqD9wls584bhLYi
         eLO6u80IJTk39z3DnZqp8JO4KWN6/eNcfUojm/saFRM62SUXD+4wzCkueatWLU6fAptB
         MId1oebalmRUjwtWgoW95WT5/pA2B54BWBHJuFghyCDkcwMk4e1O37vBPYCKg+xNIi1t
         7Ye9dxGShJnqgQXJPhOxZnD0nfYPWTGRV+FzhDks+O792tSvRxiXoEctBT79JL+9Ykij
         tZ7jBpNMXOzxiTE+9VcQ3I1pHHAXOTSmM5FpiL28ptZh3RFNGzWvqNS5y4EvPXV0UsZ1
         j49A==
X-Gm-Message-State: AFq9FYJRStWoYHSxhSj8xKCZ1Ccq+FC/QVLMNuxzj8/fTQuXfdq3J10v
	5hzIH97Cei676+kutkRVMPOEsy/2uU2JBtYRahZTritFR6xcVnqSG8sjl0eXuA==
X-Gm-Gg: AYBFou0LSbFkrS7P7SjW8b18tyX5zzE0VzOzcoBAr/9IFPoCAVQWTq7vHP2EuHQlGqP
	vwj/qN9Uxoett6HupErHDJLbpKwr3Gzpmt8yIoEnCjXYNAppJ1Y8lz8rxyWzy4usPV0m1eueT/s
	OD2XagG0tL6ghBWR+1ikQilj/QR+a+o72TS9nJswzIYTUmEOzvq7C0g7bGfBKEAS+0LMQpmBUus
	u92yHCpOXw0XEeOMpnV4Ng6TElksUDw7dXoYgYQ5lO81qvoSZRzQ73NVcPwqj8ZZ0CcCXshAu1x
	wP6vRmby0ZlhoH9k7wQM9WL4Tq+vXeoXQhbtkD30t1+ftT3yagBfpd6gAivGa168yMnqHMA9P7Y
	ccrfjZuNslAkCAb/W+odagp2Y5PXmXoUFaYu96H6yjB97Cgk4z0pJbsw8zBLJtIeZNHKkVFy+4R
	M657KwKs9jtxqGaRBzhKD8jeBl4fV6RgsWzWneTqrKMBJltJcIfj2Qs7Il1KA3crxc7qTSk0/lo
	XiKBwikyKPPkXX520878D1pSbxdgEXZZJCJXNGQrK9TK5cjW4jnSrkLJdaP5dFkFnyk6CMXgXrj
	l8tqEOj99PlrljDOSx1fGeIHElSp1N8EQZmu19wLw4gTSsZt/ueikxguVhTehEjurBJlBwru+Kb
	vPAIl8r/F03G40Pg0h2CssIigSg/NKSU7mn4A7QIIrIPjDH/HwJ/JtvgDLVzN0OUP3qWSarfsVg
	==
X-Received: by 2002:a05:6a21:6f0d:b0:3e8:b7fd:628f with SMTP id adf61e73a8af0-3e928c8d3d8mr5493453637.22.1793502360179;
        Sat, 31 Oct 2026 20:06:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096d3827sm2001929a12.12.2026.10.31.20.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 08/14] bpf: Introduce bpf register BPF_REG_ARENA_SP
Date: Sun,  1 Nov 2026 03:05:04 +0000
Message-ID: <20261101030511.1578690-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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
 .../selftests/bpf/progs/verifier_sdiv.c       | 64 +++++++++----------
 6 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 904ac8613098..f5387d12c448 100644
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
index e6593febbc35..43a8000aad3a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1367,7 +1367,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
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
index faf9eec0a63e..fb1180dae308 100644
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

