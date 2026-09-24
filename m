Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615344A8FE6
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269091; cv=none; b=l4VGog2BqQc1ORYOeJp1u3Z3OngEe8DueVVlLb408dBji4tS5FNNI7YT8WYC0eVhH7wE7eTAfXCVVy9krQ1XcQEstDIfcUQjZ/xzfvThCtN+qIDx8vj3S5rWlFTrlvAggs1eHtsvn96E33SmlzsyAqRxCzOJJhmMyiK/ObeM6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269091; c=relaxed/simple;
	bh=svjCu+rHac5ooO/yG52EY3SLmfIV+fRA5BQukGIdfHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V90Ca15FmhDHDtUkSdZs/sT7BopNtVQCl0Li2lwHScu/gARf+bS6t2yfg4sGNVqAj/D/HZTcr9WWkvnaYOZcskZYn8fBXUN+4m/IGZ9bDb25Odbdhu24L5OshocYcrOFMKcJ/wvmSNiPRZSmTLyWjcHpd7sOZfSQT8qAapdZoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH/EwnF3; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH/EwnF3"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4843169420fso4985f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269087; x=1790873887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0UgR1mbEYaQSsIvvBAmFBNcW/oCs8t3tTZO/gtDzI0=;
        b=AH/EwnF3/zNE6LZFQhxlwUlErrXKeYNaU81tOlT6ITGFxe4VaWmKltPgAz81MZptFb
         CAfK0ChzVO7fW3YF3ElBKlzUJmVYn3mLTH9llDcP1zd7WHNgJduI2viS94gbbeh006om
         vk7akJmPDQbyEfpbfGmuTY8SfPqeQap6iCU4oiTUO0uOmYE3/IrATKuEFI2f+qtd1mdU
         qKhV1tRlB+r/O6M5say2PPeAiQyzZiw99NlYbXm5Dn0ajttLasJQOFgNkABuw+7pOUep
         VbLOdmKvEcKMSr6Zzy/uJV6PXeIWvuh/8ccNgh5o21PamwvUuSCadABDqoD1uoQxqCDd
         5mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269087; x=1790873887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0UgR1mbEYaQSsIvvBAmFBNcW/oCs8t3tTZO/gtDzI0=;
        b=HT4liPam6/YEB98DZ6gx7m5XGOnKtIP4sdJo+JgS3w0ipEEvvnlSsRcpcQ99G/3cFz
         fSCNjzla6oN0fgnRcsCpGRhevwdah9CoPrbmxZ1+Vp+5SQ7eV4sgUL8xptUrU7OE1iWu
         jpwsTKiKD/UgLHBNBqat80q2IGemjuq08Q8YIg3vRhiHe4gD5dZNJTFhAz8nd1jkTLAO
         sCp/i+rqJod66b0CmKB1mgOJFL3pG9aXR2dvDrr3t1eA0iK2Gq9nhouS2/6KGQzT9E3r
         1x+wR5/4E3zUD3ho2AwUwkXhOvV5Eh+k9JW+/Px5mtzv2ijv/a3joF3WWfh9dzDrgH/E
         qgOQ==
X-Gm-Message-State: AFuF++m31N9wy+aSjyFHPCNNBJ2bb9wWu91o+FWydFSyK9iTdjuGzJm7
	nw0Wf/EekYE4O/oRVWx43jzprwtVwYLKojyi/7VMGTMpfp1jiZ6fFqCgrZHo9n2A
X-Gm-Gg: AYBFou2EqjC5HBoelbUvDfyl4vQdawHepPdVgfJrouOQbID7wsaKDLTcERwy9/wMtgZ
	jEW8hmBRszA3URoLD8/dvvvodV4khhV9+ZZqTrxLNTx9oMKfjfr2vW6GLtgrMHOCDgAYpbKp3dF
	uDUg/zmEXHxIyJu3289dkWebnTUZwI6tQhlfyuqVs5JhTtQeW9HRJyaArEKoIywWks38SqWOiDP
	c/t3btQppH6zKwmOfwUkkWr3h9Ec9EJJgeHYxvnCIiURLqvjuu1m6me8G8hPinyqjwjVOQYOt1R
	15SMn3oCIU7OMXi7PMGQsY0jeH9JE/SXt2+CNJhkvG/H9G58olXoRcynh3A4edTuhNAdsPYsQpr
	ncQYKYWbw7S/ZfTrOfIscPzyXVW2twdAnXSKUKftPlEsri7Gnz8hOL1CTtu5FA4sUNLgURXWp1U
	OpxCtGS2nSIyD02RHEoeyXCgW20lesKfcLbApK+ZCdb+CKWOKhcTDhFIBwUXOxPthzw4IRAJ5VJ
	O5vgQWvtUuE7DoSvjv978qMt/2bgHXSHTbOHZXgjXD9HtUdovl/EWjBC9v+GlfxI/EjslaEG+Av
	yMxKrOuFR8gGVFEF+mz6DVmKhF++VANnqKjG4A==
X-Received: by 2002:a05:600c:a013:b0:49d:1f10:8b9f with SMTP id 5b1f17b1804b1-49fe66bdeb8mr51650435e9.7.1790269082820;
        Thu, 24 Sep 2026 09:58:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c5c41asm119529145e9.4.2026.09.24.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:58:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/18] bpf: Size the per-frame verifier structures for a 2 KiB stack
Date: Thu, 24 Sep 2026 18:57:13 +0200
Message-ID: <20260924165740.2146806-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8672; i=memxor@gmail.com; h=from:subject; bh=svjCu+rHac5ooO/yG52EY3SLmfIV+fRA5BQukGIdfHY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraNFV1j09zzRC3ayF7lzXNV3jpHn87+nnGwr29Mu96 51i7XK2o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMR+cvIcMP4wuuvRjkpTy4G un7Yo5T1zD/2kbzjxZiqmk3fb2av/MzIcKDLPMPOMehi6w/P6ZZai1gjWr70hs044SZ7aDqDa0A +GwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier keeps a few structures whose size follows the deepest
frame a program may have: the backtracking and scratched-slot bitmaps,
the jump history slot index and the clamp of the liveness masks. They
are all expressed through MAX_BPF_STACK_SLOTS, which derives from
MAX_BPF_STACK, the frame size of the interpreter.

Introduce MAX_BPF_STACK_JIT, the stack budget a program may get on a
JIT that can lay out frames of any size, and derive those structures
from it so that a frame may be as deep as that budget. Nothing grants
the budget yet, so no program verifies differently; the only visible
change is that the liveness log prints a whole-frame read up to the new
depth, so the three selftests matching such reads are updated.

The spill tracker of the liveness analysis keeps a table entry per
instruction and tracked slot, so it follows more than the 64 slots of a
MAX_BPF_STACK frame only while that table stays within what 64 slots
need for the largest program; a subprog of a million instructions keeps
64, one of a quarter million may track all 256. This bounds the table
at its old worst case of 640 MiB instead of letting a single deep store
push it past what kvmalloc() serves.

The backtracking and scratched-slot bitmaps grow from one to four
words per frame, a fixed few hundred bytes per verifier environment.
tmp_str_buf, which formats a frame's slot list for the log, grows from
320 to 1408 bytes so that all 256 slots still fit, and the log's line
buffer from 1 to 2 KiB so that a line built from it is not cut; the
environment stays within its 64 KiB allocation. The liveness masks are
only as wide as the stack a frame uses, so most frames cost the same as
before; a frame that is read as a whole, through a pointer of unknown
offset or by bpf_loop() with two callbacks, now carries masks of eight
words, 192 bytes per instruction per frame instead of 48. Measured over
the 5075 selftest programs, that is 0.2% of the total peak verifier
memory: strobemeta_bpf_loop and pyperf600_bpf_loop grow by 11% (1.2 MiB
and 0.6 MiB), a few dozen small programs by 40 to 100 KiB each,
everything else is unchanged. The next patch bounds such reads by the
program's budget, so this cost is only paid once a JIT grants it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  | 26 ++++++++++++-------
 include/linux/filter.h                        |  5 ++++
 kernel/bpf/liveness.c                         | 17 ++++++++++--
 .../selftests/bpf/progs/verifier_live_stack.c |  6 ++---
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c5f2e18b7e54..019322e8196b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -19,11 +19,12 @@
  * that converting umax_value to int cannot overflow.
  */
 #define BPF_MAX_VAR_SIZ	(1 << 29)
-/* size of tmp_str_buf in bpf_verifier.
- * we need at least 306 bytes to fit full stack mask representation
- * (in the "-8,-16,...,-512" form)
+/*
+ * size of tmp_str_buf in bpf_verifier.
+ * we need at least 1399 bytes to fit full stack mask representation
+ * (in the "-8,-16,...,-2048" form)
  */
-#define TMP_STR_BUF_LEN 320
+#define TMP_STR_BUF_LEN 1408
 /* Patch buffer size */
 #define INSN_BUF_SIZE 32
 
@@ -244,12 +245,13 @@ enum bpf_stack_slot_type {
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
 
 /*
- * Largest number of BPF_REG_SIZE stack slots a single frame can have. A frame
- * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth()
- * enforces the bound on the combined depth of frames sharing the kernel stack
- * and on each frame using a private stack.
+ * Largest number of BPF_REG_SIZE stack slots a single frame can have, sized
+ * for the largest stack budget any JIT supports. A frame may use any part of
+ * its program's budget; check_max_stack_depth() enforces the budget on the
+ * combined depth of frames sharing the kernel stack and on each frame using
+ * a private stack.
  */
-#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
+#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK_JIT / BPF_REG_SIZE)
 
 /* 4-byte stack slot granularity for liveness analysis */
 #define BPF_HALF_REG_SIZE	4
@@ -719,7 +721,11 @@ struct bpf_insn_aux_data {
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
 #define MAX_USED_BTFS 64 /* max number of BTFs accessed by one BPF program */
 
-#define BPF_VERIFIER_TMP_LOG_SIZE	1024
+/*
+ * Longest line the verifier log can carry: a full stack mask of
+ * MAX_BPF_STACK_SLOTS slots, see TMP_STR_BUF_LEN, plus its prefix.
+ */
+#define BPF_VERIFIER_TMP_LOG_SIZE	2048
 
 struct bpf_verifier_log {
 	/* Logical start and end positions of a "log window" of the verifier log.
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4f0662e42897..fe72e71984e5 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -98,6 +98,11 @@ struct ctl_table_header;
 
 /* BPF program can access up to 512 bytes of stack space. */
 #define MAX_BPF_STACK	512
+/*
+ * Stack budget of a program on a JIT that lays out frames of that size.
+ * The interpreter and JITs without such support keep MAX_BPF_STACK.
+ */
+#define MAX_BPF_STACK_JIT	2048
 
 /* Helper macros for filter block array initializers. */
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1d83a4cf6ec5..25e95387e0e1 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -15,7 +15,7 @@
  * Half-slot 0 covers [fp-4, fp), half-slot 1 covers [fp-8, fp-4), and so on,
  * hence FRAME_HALF_SPIS - 1 is the deepest half-slot a frame can have.
  */
-#define FRAME_HALF_SPIS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)
+#define FRAME_HALF_SPIS		(MAX_BPF_STACK_JIT / BPF_HALF_REG_SIZE)
 #define FRAME_MAX_WORDS		BITS_TO_LONGS(FRAME_HALF_SPIS)
 
 /* Masks tracked for each instruction of a frame */
@@ -1021,6 +1021,19 @@ static void arg_padd(struct arg_track *at, s64 delta)
 	}
 }
 
+/*
+ * Slots the spill tracker may follow for a subprog of @len instructions
+ * without its per-instruction tables costing more than they could for the
+ * largest program while every frame stayed within MAX_BPF_STACK: as many
+ * entries as 64 slots need for BPF_COMPLEXITY_LIMIT_INSNS instructions.
+ */
+static u32 spill_slots_affordable(int len)
+{
+	u32 base = MAX_BPF_STACK / BPF_REG_SIZE;
+
+	return max_t(u32, base, base * BPF_COMPLEXITY_LIMIT_INSNS / len);
+}
+
 /*
  * Number of 8-byte spill slots to track for the instructions in [@start, @end):
  * the 64 slots of a MAX_BPF_STACK frame, which the tracker has always
@@ -1793,7 +1806,7 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 	int end = env->subprog_info[subprog + 1].start;
 	int po_end = env->subprog_info[subprog + 1].postorder_start;
 	int len = end - start;
-	u32 nslots = subprog_spill_slots(env, start, end);
+	u32 nslots = min(subprog_spill_slots(env, start, end), spill_slots_affordable(len));
 	struct arg_track (*at_in)[MAX_AT_TRACK_REGS] = NULL;
 	struct arg_track at_out[MAX_AT_TRACK_REGS];
 	struct arg_track *at_stack_in = NULL;
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index c3b08089fef1..a916d4049a0b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -1953,7 +1953,7 @@ static __used __naked void fwd_parent_key_to_helper(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_map_update_elem{{.*}}; use: fp1-8..-512 fp0-8")
+__msg("call bpf_map_update_elem{{.*}}; use: fp1-8..-2048 fp0-8")
 __naked void helper_arg_fallback_keeps_scanning(void)
 {
 	asm volatile (
@@ -2267,7 +2267,7 @@ static __used __naked void merge_leaf_read(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_loop#181            ; use: fp2-8..-512 fp1-8..-512 fp0-8..-512")
+__msg("call bpf_loop#181            ; use: fp2-8..-2048 fp1-8..-2048 fp0-8..-2048")
 __naked void bpf_loop_two_callbacks(void)
 {
 	asm volatile (
@@ -2874,7 +2874,7 @@ __naked void narrow_store_defines_nothing(void)
 SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#{{[0-9]+}} merge_read_all_callee (d2,cs{{[0-9]+}}):")
-__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-512")
+__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-2048")
 __naked void merge_keeps_whole_frame_read(void)
 {
 	asm volatile (
-- 
2.53.0

