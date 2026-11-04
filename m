Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829378;
	b=ekCeW3VJ2ef75cEhVYbmrwMqORrmkJ6l/I3oNdFNMylZPvi5Q1e0/QROcru7b63VdOSZ
	 FQzJ6DctfQDw26/S4nuwCy0T+STYHsHZaqvISE546zdnrKw5/CkL3rrMK1leXssnBY41k
	 ty+cgNhnJv/Abp+5ExTFjLfvDWZ8DUiZMkXW+qsLDXXJ9L9P2KruCtNdwt6s/FQIQ1K84
	 E/VWAEn7jLR68Jz+bzn4RL9dXXvw2xTmAJw+dQEQVAPW5nnY+nXOatRWrKrPLO7QGhSRq
	 O7oaeIjZ2rfRuJ9g7qymLmeTFGt1kn12+ygv7AbsS5iTc5CiEUGMRD9DaWCqjvk5n5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xVxaHn2bK9+Dbqkc02sJHWoZGNzj0FIyS7RzMuGt/Jw=;
	b=BUOeQtUwcacM08Sd5McoFL8ZsVEbBS35xUu50PAG6CTcIAs7kLDitv3bXwZD3P6a4Jd6
	 btSNbfHZHzmVfS19G/n7zWY76FIrSwclsxmObc2rArjk+UvBgSCL26uqhQ1preoBzstGu
	 Uhvv+U54qcAjS+8T95lM1pOZNB3z6YSO57ocpc9ypxh76Hl/JSh1Srnxe25nYDOALXipb
	 q1p3hP3f1WvCslM+OQqDi7wLU0ALxq+0wafRvxRHqCVHVMevGUB6y0d+cpBY0Xc1+iEls
	 zXHuFFHO38e1R5kj1lMZg/6UOh0OTMiTAOCB7vSCIu/0VuojyBSx7Z0yzumd3c1AUUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJjhMrPv;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB16086E4B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DDB16086E4B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJjhMrPv
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so801406a91.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829378; x=1794434178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVxaHn2bK9+Dbqkc02sJHWoZGNzj0FIyS7RzMuGt/Jw=;
        b=kJjhMrPvqxdPCsKsLfeNAtvYpLn55RA3Hy5z5mpFbEj7gUXVDe50e1ik68QQZ9sewS
         gWbp/A6FVlTtZzco9+tE181ua1FMsy+qViqOVxDdNT40LZjvt4j1pV1ZLONtNEbNafx3
         cJyeIk9hGdobYDkY3GevJDVRqs/G/MFP6cefquqWwA2fASjijKlq6ccmOSqzM5aFK7FN
         OlDrLlMxpINoJWOfziJTUv0ORAhDxamjQNvufi8NUFk/TQ2XRKGDUABk137SmbB41dMb
         zoEdAb0q8rH6vjuNBEeOUIA6DzuzfNZeqj5b/w3pafLzpiAdg/zBUDGcWo1VoDBnKbIK
         BYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829378; x=1794434178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xVxaHn2bK9+Dbqkc02sJHWoZGNzj0FIyS7RzMuGt/Jw=;
        b=L8a9Wj3bETnJS2Kn8Vq4Wp3omTHWOmwfm/ATB2LuyKQNdD0Gdu92JInqDhe5QA3Ul1
         WtIivuLYxMUPuSkeJ87dBn5ZXTTyHtpukW6I5n0yB0wl5u8ngYqPPopOtd9aNVB4dqEY
         CBW9N626YSl5LrW+3g4o1GPWtQqpRisiLOFzMAwedOoJyLjWLXp/KsYFJAYa6xhiQbEB
         zcRUOv+QGDJIpyGtQFQCLUoClhINQ2GBSDijTYI0g8er2c1pq14Sqh6a8d/q6N2nxFjK
         2oXX5yK90j9S/pUoUwm2FOGe7S9Iyf92BIjqYMA2HrshvRmwt1A8h34rfLItaa70M1pX
         lTyQ==
X-Gm-Message-State: APuU4Z/msWxMEMIB1YQg/OPQ9/wa1cmYuuJRqCyUouEU/yfu++2fD0gG
	oa27/ZUMuutN5MJoWFQFLvNQCp+BllouclFhPv+U55Fmt/oisXzs8uaeuGgEtg==
X-Gm-Gg: AYBFou1hpIY3kaeHSkluiWI71kSAQz+vmblL1Hmh8jOO0EOmoBR8oqlGYnyh0lpOwqe
	nP1nlBhKlPtwbjH+UEqE9o/rKMuC7Nish7M2kz7Pl7+LofmuM6WlTDnoAt0eH1un6kHZyGfU3nh
	5jekRhQ3O4IOAZFo2TZYHf6jVR+F9/zdrZFPek45mkmia2Ekwg8SvJOPE9LCA6BSks1VC9Pe6sV
	cGxYPvID15h6mn6kXueITVwALVc+lxKgIMQHmBBElsu3aZDniPNwXFPiFgAPXR9fUuK0KMr1Kxz
	nLc4my0O/YIBTRZWpSzZ+B6CJEl5MP+OG31p1SU5BIY543JZaeJ6GpejGxOXXLEQaOp7GMNGQl/
	ntOyftpAZmcE0anxQuZtLK+/YeHMgx98Q0Cu/5Xlp+UMbC8NX/ipHeCr3ytHQYKDlTpXc7yMftN
	DNHIe0+ibNEvYJWUFeGBZCI3I77o3mWLhvmk7kKy+sY2S6k1+FQXcyMyFy1ipfrPKSCdDQj8dXn
	rB6RTWU9XB2LqD+OL/IK5C87zbUFCy4KGeT419x8+7qWz2WceelEo/D/kYTFDG2xFf9ivXaxao1
	jXLeles3C3g40Bb28wxYdeDpLSKA0WWT6oiM1cEG9+AM3mVaKb9TeIdnr7LcIDEEHvC6ixX4qhb
	zxvEuZc0zRP682zLxQk0U19x6TffivO99Wp1we0U5jZ4qEm5c2QAB6LvTny99xFG9HynaOTMfpg
	==
X-Received: by 2002:a17:90b:580e:b0:3ac:9176:e837 with SMTP id 98e67ed59e1d1-3ae89835172mr13192817a91.50.1793829377301;
        Wed, 04 Nov 2026 13:56:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32678ecsm715560a91.9.2026.11.04.13.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:56:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 8/9] bpf: Bump MAX_CALL_FRAMES to 32
Date: Wed,  4 Nov 2026 21:55:22 +0000
Message-ID: <20261104215523.1852636-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
References: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
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

Progs that use Rust crates nest calls deeply and hit the limit of
16 frames. Bump the limit to 32.

The new limit is for JITed progs. A chain of more than 16 frames requires
the JIT, like callx. Such a prog is rejected when the JIT is off, and it
does not fall back to the interpreter when the JIT fails. The check is
a no-op with CONFIG_BPF_JIT_ALWAYS_ON, as on x86-64 and arm64.

A frame number now needs 5 bits. Widen it in bpf_jmp_history_entry and in
the packed linked registers. There the index of a register or a stack slot
loses one bit. The static_assert next to it shows that the index fits.
Widen the mask of frames in liveness.c to 32 bits. Pack struct arg_track
to keep it at 10 bytes: there is an array of them for each insn.

Each verifier state has 16 more pointers. mem_peak of veristat grows by 3%
for sched_ext, by 4% for the selftests, and by 1% for Cilium.

analyze_subprog() follows each chain of calls that passes a pointer to the
stack, before the main pass. At the limit it returns -EINVAL, and the log
has no message. Print which call it is and the message that the main pass
has for too many frames, and return -E2BIG as the main pass does:

  f31() passes a pointer to the stack to f32()
  the call stack of 33 frames is too deep

analyze_subprog() calls itself for each frame of such a chain. Its frame
has 264 bytes on x86-64 with gcc 13. The 32 frames of the longest chain
take 8.25K of the 16K of the kernel stack.

The progs that test the limit of 16 frames load now. Make their chains of
calls longer:

  prog                                  frames               result
  ------------------------------------  -------------------  ----------
  global_func3                          main, f32 .. f1: 33  rejected
  static_func_deep_stack_second_caller  33, 17 are executed  rejected

The two tests of the call stack in verifier/calls.c get 16 more calls.
static_func_deep_stack_second_caller and the test of dead code there run
with the JIT only: with the JIT off they get the message about the JIT.

global_func3 accepts 32 and 33 in the message: the main pass counts the
main prog, check_max_stack_depth() does not.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  14 +--
 kernel/bpf/liveness.c                         |  11 +-
 kernel/bpf/verifier.c                         |  18 +++-
 .../selftests/bpf/progs/test_global_func3.c   | 100 +++++++++++++++++-
 .../bpf/progs/test_global_func_deep_stack.c   |  13 +--
 tools/testing/selftests/bpf/verifier/calls.c  |  97 +++++++++++++++++
 6 files changed, 231 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 60d6d93c57db..d6e41444ab14 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -446,7 +446,9 @@ struct bpf_func_state {
 	struct loop_stack_entry *loop_stack;
 };
 
-#define MAX_CALL_FRAMES 16
+#define MAX_CALL_FRAMES 32
+/* What the interpreter has stack for. A longer chain of calls requires the JIT. */
+#define MAX_CALL_FRAMES_INTERP 16
 
 /* instruction history flags, used in bpf_jmp_history_entry.flags field.
  * Frame number and SPI are stored in dedicated fields of bpf_jmp_history_entry.
@@ -466,24 +468,24 @@ enum {
 struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 idx : 20;
-	u32 frame : 4;	/* stack access frame number */
+	u32 frame : 5;	/* stack access frame number */
 	/* special INSN_F_xxx flags */
 	u32 flags : 4;
-	u32 : 4;
+	u32 : 3;
 	u32 prev_idx : 20;
 	u32 spi : 12;	/* stack slot index */
 	/*
 	 * Scalar registers and spilled scalars linked to the condition of
 	 * this jump, which need precision tracking together when the jump is
-	 * backtracked. Each is packed as 4 bits of frame number, one bit
-	 * telling a register from a stack slot and 11 bits of register or
+	 * backtracked. Each is packed as 5 bits of frame number, one bit
+	 * telling a register from a stack slot and 10 bits of register or
 	 * slot index, see linked_regs_pack().
 	 */
 	u16 linked_regs[BPF_LINKED_REGS_MAX];
 	u8 linked_regs_cnt;
 };
 
-static_assert(MAX_CALL_FRAMES <= (1 << 4));
+static_assert(MAX_CALL_FRAMES <= (1 << 5));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
 /* Maximum number of bpf_reg_state objects that can exist at once */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c01037011788..525c0faff1a6 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -818,11 +818,11 @@ static int print_instances(struct bpf_verifier_env *env)
 struct arg_track {
 	union {
 		s16 off[MAX_ARG_OFFSETS]; /* byte offsets; off_cnt says how many */
-		u16 mask;	/* arg bitmask when arg == ARG_IMPRECISE */
+		u32 mask;	/* arg bitmask when arg == ARG_IMPRECISE */
 	};
 	s8 frame;	/* absolute frame index, or enum arg_track_state */
 	s8 off_cnt;	/* 0 = offset-imprecise, 1-4 = # of precise offsets */
-};
+} __packed __aligned(2);
 
 enum arg_track_state {
 	ARG_NONE	= -1,	/* not derived from any argument */
@@ -1182,7 +1182,7 @@ static struct arg_track fill_from_stack(struct bpf_insn *insn,
 					int depth)
 {
 	struct arg_track imp = {
-		.mask = (1u << (depth + 1)) - 1,
+		.mask = GENMASK(depth, 0),
 		.frame = ARG_IMPRECISE
 	};
 	struct arg_track result = { .frame = ARG_NONE };
@@ -2393,7 +2393,10 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 			continue;
 
 		if (depth == MAX_CALL_FRAMES - 1) {
-			err = -EINVAL;
+			verbose(env, "%s() passes a pointer to the stack to %s()\n",
+				bpf_subprog_name(env, subprog), bpf_subprog_name(env, callee));
+			verbose(env, "the call stack of %d frames is too deep\n", depth + 2);
+			err = -E2BIG;
 			goto out_free;
 		}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8f4549da6db..4161ecabfea9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3656,8 +3656,8 @@ static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
 }
 
 /* Layout of one packed linked register in the jump history, see linked_regs_pack() */
-#define LR_FRAMENO_BITS	4
-#define LR_INDEX_BITS	11
+#define LR_FRAMENO_BITS	5
+#define LR_INDEX_BITS	10
 #define LR_FRAMENO_MASK	((1u << LR_FRAMENO_BITS) - 1)
 #define LR_IS_REG	BIT(LR_FRAMENO_BITS)
 #define LR_INDEX_OFF	(LR_FRAMENO_BITS + 1)
@@ -3693,9 +3693,9 @@ static struct linked_reg *linked_regs_push(struct linked_regs *s)
 
 /*
  * Pack linked registers for a jump history entry, one u16 each:
- * - 4 bits frameno
+ * - 5 bits frameno
  * - 1 bit  is_reg
- * - 11 bits register or stack slot index
+ * - 10 bits register or stack slot index
  */
 static void linked_regs_pack(const struct linked_regs *s, u16 *packed)
 {
@@ -6127,6 +6127,16 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 			goto out;
 		}
 
+		err = -EOPNOTSUPP;
+		if (dinfo[s].frame >= MAX_CALL_FRAMES_INTERP) {
+			if (!env->prog->jit_requested) {
+				verbose(env, "JIT is required for a call stack of more than %d frames\n",
+					MAX_CALL_FRAMES_INTERP);
+				goto out;
+			}
+			env->prog->jit_required = true;
+		}
+
 		err = -EACCES;
 		depth = dinfo[s].arena_depth + si[s].arena_stack_depth;
 		if (depth > env->max_arena_stack_depth)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index b66abb350fb0..16a353195494 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -101,9 +101,105 @@ int f16(struct __sk_buff *skb)
 	return f15(skb);
 }
 
+static __attribute__ ((noinline))
+int f17(struct __sk_buff *skb)
+{
+	return f16(skb);
+}
+
+static __attribute__ ((noinline))
+int f18(struct __sk_buff *skb)
+{
+	return f17(skb);
+}
+
+static __attribute__ ((noinline))
+int f19(struct __sk_buff *skb)
+{
+	return f18(skb);
+}
+
+static __attribute__ ((noinline))
+int f20(struct __sk_buff *skb)
+{
+	return f19(skb);
+}
+
+static __attribute__ ((noinline))
+int f21(struct __sk_buff *skb)
+{
+	return f20(skb);
+}
+
+static __attribute__ ((noinline))
+int f22(struct __sk_buff *skb)
+{
+	return f21(skb);
+}
+
+static __attribute__ ((noinline))
+int f23(struct __sk_buff *skb)
+{
+	return f22(skb);
+}
+
+static __attribute__ ((noinline))
+int f24(struct __sk_buff *skb)
+{
+	return f23(skb);
+}
+
+static __attribute__ ((noinline))
+int f25(struct __sk_buff *skb)
+{
+	return f24(skb);
+}
+
+static __attribute__ ((noinline))
+int f26(struct __sk_buff *skb)
+{
+	return f25(skb);
+}
+
+static __attribute__ ((noinline))
+int f27(struct __sk_buff *skb)
+{
+	return f26(skb);
+}
+
+static __attribute__ ((noinline))
+int f28(struct __sk_buff *skb)
+{
+	return f27(skb);
+}
+
+static __attribute__ ((noinline))
+int f29(struct __sk_buff *skb)
+{
+	return f28(skb);
+}
+
+static __attribute__ ((noinline))
+int f30(struct __sk_buff *skb)
+{
+	return f29(skb);
+}
+
+static __attribute__ ((noinline))
+int f31(struct __sk_buff *skb)
+{
+	return f30(skb);
+}
+
+static __attribute__ ((noinline))
+int f32(struct __sk_buff *skb)
+{
+	return f31(skb);
+}
+
 SEC("tc")
-__failure __msg("the call stack of 17 frames")
+__failure __msg("the call stack of {{3[23]}} frames")
 int global_func3(struct __sk_buff *skb)
 {
-	return f16(skb);
+	return f32(skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
index 3a852809b078..1b111a65614f 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -124,21 +124,22 @@ int global_func_many_chains(void *ctx)
 }
 
 /*
- * r1 is the number of calls that follow, so main -> fs7 .. fs0 and main -> fs15 .. fs8
- * are executed: 9 frames each. main -> fs15 .. fs0 is in the call graph: 17 frames.
- * libbpf puts fs7() .. fs0() in front of their second caller fs8().
+ * r1 is the number of calls that follow, so main -> fs15 .. fs0 and main -> fs31 .. fs16
+ * are executed: 17 frames each. main -> fs31 .. fs0 is in the call graph: 33 frames.
+ * libbpf puts fs15() .. fs0() in front of their second caller fs16().
  */
 #undef F_0
 #undef FN
 #define F_0 ASM_FUNC(static, fs0, "")
 #define FN(n, prev) ASM_FUNC(static, fs##n, "if r1 == 0 goto +2; r1 += -1; call fs" #prev ";")
-F(15)
+F(31)
 
 SEC("syscall")
-__failure __msg("the call stack of 16 frames is too deep !")
+__failure __msg("the call stack of 32 frames is too deep !")
+__load_if_JITed()
 __naked int static_func_deep_stack_second_caller(void)
 {
-	asm volatile ("r1 = 7; call fs7; r1 = 7; call fs15; exit;" ::: __clobber_all);
+	asm volatile ("r1 = 15; call fs15; r1 = 15; call fs31; exit;" ::: __clobber_all);
 }
 
 /* Ensure that even 32 levels deep, the function verifies. */
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 0af237c02ddf..f9d71e01ddf4 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1325,6 +1325,54 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
 	BPF_EXIT_INSN(),
 	/* P */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P1 */
+	BPF_EXIT_INSN(),
+	/* P1 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P2 */
+	BPF_EXIT_INSN(),
+	/* P2 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P3 */
+	BPF_EXIT_INSN(),
+	/* P3 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P4 */
+	BPF_EXIT_INSN(),
+	/* P4 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P5 */
+	BPF_EXIT_INSN(),
+	/* P5 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P6 */
+	BPF_EXIT_INSN(),
+	/* P6 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P7 */
+	BPF_EXIT_INSN(),
+	/* P7 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P8 */
+	BPF_EXIT_INSN(),
+	/* P8 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P9 */
+	BPF_EXIT_INSN(),
+	/* P9 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P10 */
+	BPF_EXIT_INSN(),
+	/* P10 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P11 */
+	BPF_EXIT_INSN(),
+	/* P11 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P12 */
+	BPF_EXIT_INSN(),
+	/* P12 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P13 */
+	BPF_EXIT_INSN(),
+	/* P13 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P14 */
+	BPF_EXIT_INSN(),
+	/* P14 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P15 */
+	BPF_EXIT_INSN(),
+	/* P15 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P16 */
+	BPF_EXIT_INSN(),
+	/* P16 */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
@@ -1387,10 +1435,59 @@
 	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P */
 	BPF_EXIT_INSN(),
 	/* P */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P1 */
+	BPF_EXIT_INSN(),
+	/* P1 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P2 */
+	BPF_EXIT_INSN(),
+	/* P2 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P3 */
+	BPF_EXIT_INSN(),
+	/* P3 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P4 */
+	BPF_EXIT_INSN(),
+	/* P4 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P5 */
+	BPF_EXIT_INSN(),
+	/* P5 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P6 */
+	BPF_EXIT_INSN(),
+	/* P6 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P7 */
+	BPF_EXIT_INSN(),
+	/* P7 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P8 */
+	BPF_EXIT_INSN(),
+	/* P8 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P9 */
+	BPF_EXIT_INSN(),
+	/* P9 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P10 */
+	BPF_EXIT_INSN(),
+	/* P10 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P11 */
+	BPF_EXIT_INSN(),
+	/* P11 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P12 */
+	BPF_EXIT_INSN(),
+	/* P12 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P13 */
+	BPF_EXIT_INSN(),
+	/* P13 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P14 */
+	BPF_EXIT_INSN(),
+	/* P14 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P15 */
+	BPF_EXIT_INSN(),
+	/* P15 */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call P16 */
+	BPF_EXIT_INSN(),
+	/* P16 */
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
+	.flags = F_NEEDS_JIT_ENABLED,
 	.errstr = "call stack",
 	.result = REJECT,
 },
-- 
2.55.0

