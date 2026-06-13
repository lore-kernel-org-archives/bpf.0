Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518B2F7EFD
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781374082; cv=none; b=JAlL1HY/KZVIQQXBxUdXC3HybfOOI7kOQPRJp2SazmBoDWHrZusqMZGEweyL8WPb2cdXRG+Y90Rp91V7ajw8hvCPoKjpgSlwWTt91IvIm376w9kQ1/KLqrnaR/rvt2VDLaCDhUs777Nqjw7rfUkuRceD5j9BZ/ug+1mCV5r5IMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781374082; c=relaxed/simple;
	bh=BYaGvUsJv01rSSlIQ/YrvR8DRHcLbloeqMAPWz8yiSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJqfmuUTlRBwJIRiRN3PUthLyBiOvjQ5u0ukxi5q9J9Cv9I4QExvA5v931Ka0lGIbvV6BRl6+XKmjHhvHWst9Edccd2VhY+szOcTHS+j8jtAjM3wyoadwsYPdO7XeoTvfrjEnjq7yI8XGahXvLfRR9Dsi+b9wYe9SIeOAz0jStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrGldmuU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrGldmuU"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6f586a0d5so1059447a34.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781374079; x=1781978879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4dX83juCft31gARoq+L8Lqtl19w42Vx8Ga6lD9s8Foc=;
        b=LrGldmuU/kBLP3/S4Iu9Q/NLaL4boEUT7w5q7nU8SOVuFstuzaziN4hMfItbYKOEF0
         KEuwIbV637OpiZ4et38t7/BJp6N1aBTSUvASzr2eZjH8s5Z8EFezK9inuWnJxvHEJibG
         pD1B/E9q8AoHySvExcSbU3D7trwokyeDRzmjMm31kewSknXUc9J5W3iSbCfjP1GgPU0P
         pUXG4wzMmfr8+pLLjTmdoytkmTb9g8GsuZenxZbdNIEGRrm0fFEL2pnzfplZKpiDLXXU
         Z0uie0M+utnGppV8ZWBFk4YhezXzaUNj7GosjomsJU4s82CLR0fEGDLrmDMVGB0EXiIG
         5ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781374079; x=1781978879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dX83juCft31gARoq+L8Lqtl19w42Vx8Ga6lD9s8Foc=;
        b=qmcR4bXzrPxPYPmozESWeFvQiQje/dOf9aTQbiVLSAKF+TVWjqKpTti/Z3660iz5js
         nkkl1SGLUsk6CwByafNZf7Z5nwDFrCNudk2nAACyFL9FJoOMp77GXDpMTwR4o8YUDYd/
         D++/rZOz5N70IyY82Y5byNj4pGkPB6E+qsyVAN5pFWxYyc39SGX+AUdtPeNkZCdEizTm
         z3ubQgA5T8Wbq4gyRR+hSwMG4rMTIVdjKbcnDXdgG4RvFlG8ylXGo56v2kNHZjv6RfzQ
         oir0Q81dM2hyss0ujAc08ANHmKwLw4L4ZX/5fxbQDBFWV52pqQIzn4S4rBl80B6xRGrB
         Sh/A==
X-Gm-Message-State: AOJu0YwzWA/kIwpLDiOGbSQ1rrkPq98r1iKFXNyE3RATYNLGlJimGmYh
	zxQhdpAHdvEFkpWaFeiLjXY7xKYP9Q02cALmgJP5onoeCK6Kitj6uAqWe1TvqdnT
X-Gm-Gg: Acq92OE3FiwDJVwZKg6YVK8PF8MLqmysrF1Pa4Ji/L8ry8qYxKrX5X3Orj3BPkA1hDt
	K018GkFvyRe6GSYtLauP/sElyBuSIw42Pj1TlRI5Bc7lpY9AUHV5axXCmg39Xd7S27FQNSex0GS
	46J4dEhUKkG8z2c5BKlRkegTkQkNsJNO4ZzqDbgz1mt9pH2M47jE6ZozveP0QwoIfLcBLG3l1HI
	/YdFDgJSv6RL6lMW4HjVxtiVQjX0uduG4Vi8NIHwmAgwcwocACKZZDEeTkjw6UhokU7631XuqE6
	D/lsHbyENDkutE9T0eJiF9lId69B8ZaWxtVmmK7vtxF/q6jJOPKrbcmj+r5ghRGTnWSunrnalMm
	EfBshANR8+G27TTlv+DNPYKNP595x73w5+boM1TD8wh3iDAKuqPrHxtUKxCV0TNwtF0vP1+SSLR
	V2xE9oEICMCE887iptfZeEeBSH5C3qiBkChm3u6Ss3zqblpWtm/45RIGOfkPOAKYUxKx15xZ/wE
	9kRkyGoC6mjdvv0kZN4w10IwViM0BEWSUGezGTOQFu58HjQk40=
X-Received: by 2002:a05:6830:7001:b0:7e6:c752:3f0c with SMTP id 46e09a7af769-7e78e7a015cmr2930788a34.24.1781374079093;
        Sat, 13 Jun 2026 11:07:59 -0700 (PDT)
Received: from MacBookPro.lan ([2600:6c4e:600:3c6:100c:91d9:c41d:6cb7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e78144823asm4571584a34.5.2026.06.13.11.07.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Jun 2026 11:07:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next] bpf: Raise maximum call chain depth to 16 frames
Date: Sat, 13 Jun 2026 11:07:55 -0700
Message-ID: <20260613180755.29671-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Bump MAX_CALL_FRAMES from 8 to 16 to allow deeper call chains
that Rust-BPF requires and update selftests.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  | 13 ++---
 kernel/bpf/verifier.c                         | 15 ++++--
 .../selftests/bpf/progs/test_global_func3.c   | 52 ++++++++++++++++++-
 .../bpf/progs/verifier_liveness_exp.c         |  2 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c | 25 +++++----
 tools/testing/selftests/bpf/verifier/calls.c  | 48 +++++++++++++++++
 6 files changed, 128 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d57b339a8cb8..39a851e690ec 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -404,7 +404,7 @@ struct bpf_func_state {
 	struct bpf_reg_state *stack_arg_regs; /* Outgoing on-stack arguments */
 };
 
-#define MAX_CALL_FRAMES 8
+#define MAX_CALL_FRAMES 16
 
 /* instruction history flags, used in bpf_jmp_history_entry.flags field.
  * Frame number and SPI are stored in dedicated fields of bpf_jmp_history_entry.
@@ -421,20 +421,21 @@ enum {
 struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 idx : 20;
-	u32 frame : 3;	/* stack access frame number */
+	u32 frame : 4;	/* stack access frame number */
 	u32 spi : 6;	/* stack slot index (0..63) */
-	u32 : 3;
+	u32 : 2;
 	u32 prev_idx : 20;
 	/* special INSN_F_xxx flags */
 	u32 flags : 4;
 	u32 : 8;
-	/* additional registers that need precision tracking when this
-	 * jump is backtracked, vector of six 10-bit records
+	/*
+	 * additional registers that need precision tracking when this
+	 * jump is backtracked, vector of five 11-bit records
 	 */
 	u64 linked_regs;
 };
 
-static_assert(MAX_CALL_FRAMES <= (1 << 3));
+static_assert(MAX_CALL_FRAMES <= (1 << 4));
 static_assert(MAX_BPF_STACK / 8 <= (1 << 6));
 
 /* Maximum number of bpf_reg_state objects that can exist at once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb46a81a8c51..2abc79dbf281 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3144,7 +3144,7 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].indirect_target = true;
 }
 
-#define LR_FRAMENO_BITS	3
+#define LR_FRAMENO_BITS	4
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
 #define LR_SIZE_BITS	4
@@ -3153,7 +3153,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
 #define LR_SIZE_MASK	((1ull << LR_SIZE_BITS)    - 1)
 #define LR_SPI_OFF	LR_FRAMENO_BITS
 #define LR_IS_REG_OFF	(LR_SPI_BITS + LR_FRAMENO_BITS)
-#define LINKED_REGS_MAX	6
+#define LINKED_REGS_MAX	5
+
+static_assert(MAX_CALL_FRAMES <= (1 << LR_FRAMENO_BITS));
+static_assert(LINKED_REGS_MAX < (1 << LR_SIZE_BITS));
+static_assert(LINKED_REGS_MAX * LR_ENTRY_BITS + LR_SIZE_BITS <= 64);
 
 struct linked_reg {
 	u8 frameno;
@@ -3177,10 +3181,11 @@ static struct linked_reg *linked_regs_push(struct linked_regs *s)
 	return NULL;
 }
 
-/* Use u64 as a vector of 6 10-bit values, use first 4-bits to track
+/*
+ * Use u64 as a vector of 5 11-bit values, use first 4-bits to track
  * number of elements currently in stack.
- * Pack one history entry for linked registers as 10 bits in the following format:
- * - 3-bits frameno
+ * Pack one history entry for linked registers as 11 bits in the following format:
+ * - 4-bits frameno
  * - 6-bits spi_or_reg
  * - 1-bit  is_reg
  */
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 974fd8c19561..b66abb350fb0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -53,9 +53,57 @@ int f8(struct __sk_buff *skb)
 	return f7(skb);
 }
 
+static __attribute__ ((noinline))
+int f9(struct __sk_buff *skb)
+{
+	return f8(skb);
+}
+
+static __attribute__ ((noinline))
+int f10(struct __sk_buff *skb)
+{
+	return f9(skb);
+}
+
+static __attribute__ ((noinline))
+int f11(struct __sk_buff *skb)
+{
+	return f10(skb);
+}
+
+static __attribute__ ((noinline))
+int f12(struct __sk_buff *skb)
+{
+	return f11(skb);
+}
+
+static __attribute__ ((noinline))
+int f13(struct __sk_buff *skb)
+{
+	return f12(skb);
+}
+
+static __attribute__ ((noinline))
+int f14(struct __sk_buff *skb)
+{
+	return f13(skb);
+}
+
+static __attribute__ ((noinline))
+int f15(struct __sk_buff *skb)
+{
+	return f14(skb);
+}
+
+static __attribute__ ((noinline))
+int f16(struct __sk_buff *skb)
+{
+	return f15(skb);
+}
+
 SEC("tc")
-__failure __msg("the call stack of 9 frames")
+__failure __msg("the call stack of 17 frames")
 int global_func3(struct __sk_buff *skb)
 {
-	return f8(skb);
+	return f16(skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c b/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c
index b058de623200..72646fa2745e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c
+++ b/tools/testing/selftests/bpf/progs/verifier_liveness_exp.c
@@ -15,7 +15,7 @@
  * FP offset at each call site.  arg_track keys on (frame, off[]), so
  * r1=fp-8, r1=fp-16, ... r1=fp-400 produce 50 unique cache keys per level.
  *
- * This test chains 8 subprograms (the MAX_CALL_FRAMES limit).  Each
+ * This test chains 8 subprograms (within the MAX_CALL_FRAMES limit).  Each
  * intermediate function calls the next one 50 times, each time with a
  * different FP-relative offset in r1.
  *
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 70ae14d6084f..e38f102da45f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -372,37 +372,36 @@ __naked void precision_two_ids(void)
 SEC("socket")
 __success __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
-/* check that r0 and r6 have different IDs after 'if',
- * collect_linked_regs() can't tie more than 6 registers for a single insn.
+/*
+ * check that r0 and r5 have different IDs after 'if',
+ * collect_linked_regs() can't tie more than 5 registers for a single insn.
  */
-__msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
-__msg("14: (bf) r6 = r6                      ; R6=scalar(id=2")
-/* check that r{0-5} are marked precise after 'if' */
-__msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
+__msg("7: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
+__msg("12: (bf) r5 = r5                      ; R5=scalar(id=2")
+/* check that r{0-4} are marked precise after 'if' */
+__msg("frame0: regs=r0 stack= before 7: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3,r4 stack=:")
 __naked void linked_regs_too_many_regs(void)
 {
 	asm volatile (
 	/* r0 = random number up to 0xff */
 	"call %[bpf_ktime_get_ns];"
 	"r0 &= 0xff;"
-	/* tie r{0-6} IDs */
+	/* tie r{0-5} IDs */
 	"r1 = r0;"
 	"r2 = r0;"
 	"r3 = r0;"
 	"r4 = r0;"
 	"r5 = r0;"
-	"r6 = r0;"
-	/* propagate range for r{0-6} */
+	/* propagate range for r{0-5} */
 	"if r0 > 7 goto +0;"
-	/* keep r{1-5} live */
+	/* keep r{1-4} live */
 	"r1 = r1;"
 	"r2 = r2;"
 	"r3 = r3;"
 	"r4 = r4;"
+	/* make r5 appear in the log */
 	"r5 = r5;"
-	/* make r6 appear in the log */
-	"r6 = r6;"
 	/* force r0 to be precise,
 	 * this would cause r{0-4} to be precise because of shared IDs
 	 */
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 42d523a21a43..302d712e0d7e 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1219,6 +1219,30 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call H */
 	BPF_EXIT_INSN(),
 	/* H */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call I */
+	BPF_EXIT_INSN(),
+	/* I */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call J */
+	BPF_EXIT_INSN(),
+	/* J */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call K */
+	BPF_EXIT_INSN(),
+	/* K */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call L */
+	BPF_EXIT_INSN(),
+	/* L */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call M */
+	BPF_EXIT_INSN(),
+	/* M */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call N */
+	BPF_EXIT_INSN(),
+	/* N */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call O */
+	BPF_EXIT_INSN(),
+	/* O */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
+	BPF_EXIT_INSN(),
+	/* P */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1257,6 +1281,30 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call H */
 	BPF_EXIT_INSN(),
 	/* H */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call I */
+	BPF_EXIT_INSN(),
+	/* I */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call J */
+	BPF_EXIT_INSN(),
+	/* J */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call K */
+	BPF_EXIT_INSN(),
+	/* K */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call L */
+	BPF_EXIT_INSN(),
+	/* L */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call M */
+	BPF_EXIT_INSN(),
+	/* M */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call N */
+	BPF_EXIT_INSN(),
+	/* N */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call O */
+	BPF_EXIT_INSN(),
+	/* O */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
+	BPF_EXIT_INSN(),
+	/* P */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-- 
2.53.0-Meta

