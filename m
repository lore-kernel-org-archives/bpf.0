Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8541D131
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432475; cv=none; b=fxEXMLiv+OiWXejO9eF4rHuMySDFeBg00q4RcFhjCxzX5mPnyYbN7FnMsirMA7wxGjR9JdrH4yK0OdnCTOxlg/Dp9re7BdCmKjrqO1QfcdGviiSgnv7ZTFosq4soi8sikK/qClR0P/sGD626nKYRl4FjuzzeRBFqjnCjLSwDoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432475; c=relaxed/simple;
	bh=cby20MXJFrAc1td2N1qgqY0Pj54xhV6Y5S53G5IaeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVyOuF3B0NkeB1Up+0iOkQu9a9TQxUoS3fkjkV55XQ5pYkoTviLHjZh2O9qRyMU7TEfeQEHGbF4GTLQUiFYFQA7grfVkJRIxoaqO4dzhlBI8fVPYY4O+wLrbEq5MwmGR2vVjQgbycjXgF2nMmGLOIdkLjuXcJYawV4UveZjpMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG9xMkaJ; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG9xMkaJ"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so799103a91.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432473; x=1791037273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BqXCmLh900gHtWM4pYtbcbmZUY4I6e2x05Z7grwMZcw=;
        b=bG9xMkaJn/ICo/77pF38RBIitvHS8YtfFXX6EavNoIATVQR4QnUsDG6MfQbiHu+gUI
         E4EK3bqkK1F1cdg5Ei8gWqulNcgzRR6XHNs2gHQf8Uhh06q7y0rIFhEZuXBUAR66lLho
         9sL8uQupX9ZMwyG+tMdK/IHzG2KQ1lB+RyxqXHbNpu4sJ16Xgb7hUNuXxNgojqNs0bNo
         E8eEppjd4JqJxMSE+XIGzybFByflW4R6YHEo7t5dw44Fk0SLBMTmczTK16Ya4WGmgPN3
         BFd8hffub2hOeEa2XnOgIqAPTD0nviEFPqjPuTsHi11XcAd7oTwZA7PVAfAvMcu/sbeK
         Rkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432473; x=1791037273;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqXCmLh900gHtWM4pYtbcbmZUY4I6e2x05Z7grwMZcw=;
        b=vlkwMjPlntbW/qEQqMHDoshCuQIMV5LmTYDD07R9azzs5u2GbhqwCNDujsa3PMXboG
         JlmRZAn0b+WWYuD2WhnJmkTYUc7qjKxKY6MS9pCQ33yjPo+m81GMvU5KgVmYjvzVSJVm
         8XxBAfq2ReApWITG+ZLvNquEFDXLxXdWT8b1dlpZMaBnJNTXIm/7h8DhA5Rm+Puf+X9I
         ByD8U0EQS9KLuXOdt9BBhKYxulqtiTxKLmzDtoyTo1arzvABMWAHD3jAy6PykjvGbnx4
         H9twvqk4VQjUvNAmmBxOhMfYLR8Rqq2fcDpQwP9Oy2jDoZl919WLgPrqlfXNPHdJ1cYf
         I9GQ==
X-Gm-Message-State: AFq9FYKuOGBuukt/djZaPccXgPy34QIfELFK1IsRmjyQu/h4mEeazPGd
	azoYwUbnYsprvF1Z+dBisUbmhaJrsWfqUcky5jac9eI45JxWFuMgWQ57cI1+7TreM2k=
X-Gm-Gg: AYBFou1/x14ZaWNlOjFNq2ea0+NPXUbv3lTopGB7s7dXTfqfytfJb/JDesGFG4bJyRY
	BjsyFPqdrL8sE2gmcpxmGFjUOr2cwgY5412gMHDUnhZVaS9dFD9dO9kUc8XBl1oeEBlcvo7JoPD
	r++rZJZxIvnS3Llu+X0FvL+kqst/LileVNstoqFs4+1o+KIUoiTur24p0xRSEvDcFbzPgsh0IxZ
	Z1VoI6FcedVlg1JZ0dGuyE8JrQi57LYa+hiT5Glt5AygRMdoKNCmFJxWBp9QNGru48OtS70D3Rd
	T5GQAnICePJf9PQozWXbJ1Fz1EPU+OSHBJCfc1VckSvvW+h8evMOmJElbX+6cOgL3sFWirtDKe2
	CdXpRugTBZoZkl7QUqdAen0nJ7XRIyxRRi7LTzhi55MqU3FZ3tpUEIjYeTMmwBdEo2DxvG0iX/Z
	3Y7hvDuG6vdCmdLMZzaR4UFYY7LS024ldZFQnAHfaV+pCdkQlcUG6Mb+LMMxhH/HbcLycI8I1WJ
	1Vxjh4bNAXU4U+vsl56q/KdXn1EWAVL1VoGkD7UUQ==
X-Received: by 2002:a17:90b:37cf:b0:3a0:dbfd:1a1b with SMTP id 98e67ed59e1d1-3a0dbfd2680mr1614003a91.27.1790432473236;
        Sat, 26 Sep 2026 07:21:13 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:12 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 29/36] selftests/bpf: tests for may_write stack-liveness tracking
Date: Sat, 26 Sep 2026 07:20:27 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-29-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Branches to cover:
  - per-insn writes (record_stack_access_off):
      * off_cnt==1, fully covered slots   -> def + may_def (equal)
      * partial coverage                  -> may_def only (no def)
      * off_cnt 2-4, precise offsets      -> may_def only, per offset
  - whole-frame writes:
      * off_cnt==0 (offset lost)          -> may_def SPIS_ALL
      * ARG_IMPRECISE (frame lost)        -> may_def SPIS_ALL per frame
  - merge_instances():
      * both passes touch a frame         -> may_def union
      * one pass leaves a frame untouched -> may_def preserved
  - merge_may_write(): a callee's writes into ancestor frames are
    summarized as may_def at the caller's call instruction.

Tests exercising them:
  - may_write_two_precise_offsets  - off_cnt 2-4 precise multi-offset
  - imprecise_frame_write          - cross-frame ARG_IMPRECISE write,
                                     plus its caller-side summarization
  - merge_preserves_may_write      - map-value vs stack pointer at two
                                     callsites: union is preserved when
                                     one pass does not touch the frame
  - must_write_not_same_slot       - off_cnt==0 whole-frame may_def
  - two_byte_write_no_kill         - partial write, may_def without def
  - kfunc_iter_stack_liveness      - full-slot def == may_def
  - caller_stack_write,
    conditional_stx_in_subprog,
    shared_instance_must_write_overwrite
                                   - callee writes summarized as may_def
                                     at the call site.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 147 ++++++++++++++++++++-
 1 file changed, 144 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 6b295b30936d..41df0c393981 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -83,6 +83,31 @@ __naked void must_write_not_same_slot(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__log_level(2)
+__msg("stack use/def subprog#0 may_write_two_precise_offsets (d0,cs0):")
+/*
+ * r1 is fp-8 or fp-16, with both offsets tracked precisely (off_cnt == 2).
+ * A write through it cannot set def, but marks both candidate slots as may_def.
+ */
+__msg("6: (7b) *(u64 *)(r1 +0) = r0         ; may_def: fp0-8 fp0-16")
+__naked void may_write_two_precise_offsets(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r10;"
+	"if r0 > 42 goto 1f;"
+	"r1 += -8;"
+	"goto 2f;"
+"1:"
+	"r1 += -16;"
+"2:"
+	"*(u64 *)(r1 + 0) = r0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __log_level(2)
 __msg("0: (7a) *(u64 *)(r10 -8) = 0         ; def: fp0-8")
@@ -114,7 +139,7 @@ __log_level(2)
 __msg("stack use/def subprog#0 caller_stack_write (d0,cs0):")
 __msg("2: (85) call pc+1                    ; may_def: fp0-8")
 __msg("stack use/def subprog#1 write_first_param (d1,cs2):")
-__msg("4: (7a) *(u64 *)(r1 +0) = 7          ; def: fp0-8")
+__msg("4: (7a) *(u64 *)(r1 +0) = 7          ; def: fp0-8 may_def: fp0-8")
 __naked void caller_stack_write(void)
 {
 	asm volatile (
@@ -134,6 +159,49 @@ static __used __naked void write_first_param(void)
 	::: __clobber_all);
 }
 
+/*
+ * Cross-frame imprecise write: imprecise_frame_writer() receives a pointer
+ * into the caller's frame (frame 0) but conditionally replaces it with a
+ * pointer into its own frame (frame 1). At the store the two are joined into
+ * ARG_IMPRECISE (frame is unknown, mask = {0,1}), so the offset is dropped and
+ * the whole of both candidate frames is conservatively marked as may_def.
+ */
+SEC("socket")
+__log_level(2)
+/* The callee's write into the caller frame is summarized at the call site. */
+__msg("stack use/def subprog#0 imprecise_frame_write (d0,cs0):")
+__msg("2: (85) call pc+2                    ; may_def: fp0-8..-{{(512|2048)}}")
+__msg("stack use/def subprog#1 imprecise_frame_writer (d1,cs2):")
+__msg("12: (7b) *(u64 *)(r1 +0) = r2         ; may_def: fp1-8..-{{(512|2048)}} fp0-8..-{{(512|2048)}}")
+__naked void imprecise_frame_write(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"call imprecise_frame_writer;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void imprecise_frame_writer(void)
+{
+	asm volatile (
+	"r6 = r1;"			/* save arg: pointer into frame 0 */
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r6;"			/* r1 = frame0-8 (arg) */
+	"if r0 == 0 goto 1f;"
+	"r1 = r10;"
+	"r1 += -8;"			/* r1 = frame1-8 (own frame) */
+"1:"
+	"r2 = 0;"
+	"*(u64 *)(r1 + 0) = r2;"	/* join frame0-8 | frame1-8 -> imprecise */
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#0 caller_stack_read (d0,cs0):")
@@ -1011,7 +1079,7 @@ __naked void four_byte_read_upper_half(void)
  */
 SEC("socket")
 __log_level(2)
-__msg("0: (7a) *(u64 *)(r10 -8) = 0         ; def: fp0-8")
+__msg("0: (7a) *(u64 *)(r10 -8) = 0         ; def: fp0-8 may_def: fp0-8")
 /* 2-byte write only partially covers the upper half: may_def, but no def. */
 __msg("1: (6a) *(u16 *)(r10 -4) = 0         ; may_def: fp0-4h")
 __msg("2: (61) r0 = *(u32 *)(r10 -4)        ; use: fp0-4h")
@@ -1364,7 +1432,7 @@ __log_level(2)
  * fp-8 live at call: callee conditionally writes it, so the slot is not killed
  * (no def), but the conditional write surfaces as may_def at the call site.
  */
-__msg("1: (7b) *(u64 *)(r10 -8) = r1        ; def: fp0-8")
+__msg("1: (7b) *(u64 *)(r10 -8) = r1        ; def: fp0-8 may_def: fp0-8")
 __msg("4: (85) call pc+2                    ; may_def: fp0-8")
 __msg("5: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
 __naked void conditional_stx_in_subprog(void)
@@ -2393,6 +2461,20 @@ __flag(BPF_F_TEST_STATE_FREQ)
 __msg("subprog#2 write_first_read_second:")
 __msg("17: (7a) *(u64 *)(r1 +0) = 42{{$}}")
 __msg("18: (79) r0 = *(u64 *)(r2 +0) // r1=fp0-8 r2=fp0-16{{$}}")
+/*
+ * The callee's write into the caller frame is summarized as may_def at the
+ * call sites, transitively across both frames (depth 2 -> 1 -> 0). The two
+ * call sites differ because the shared write_first_read_second instance
+ * accumulates the cross-pass union ({fp-8, fp-16}) at different points
+ * relative to each forwarding_rw's summarization.
+ */
+__msg("stack use/def subprog#0 shared_instance_must_write_overwrite (d0,cs0):")
+__msg("7: (85) call pc+7                    ; use: fp0-8 fp0-16 may_def: fp0-8 fp0-16")
+__msg("12: (85) call pc+2                    ; use: fp0-8 may_def: fp0-16")
+__msg("stack use/def subprog#1 forwarding_rw (d1,cs7):")
+__msg("15: (85) call pc+1                    ; use: fp0-8 fp0-16 may_def: fp0-8 fp0-16")
+__msg("stack use/def subprog#1 forwarding_rw (d1,cs12):")
+__msg("15: (85) call pc+1                    ; use: fp0-8 may_def: fp0-16")
 __msg("stack use/def subprog#2 write_first_read_second (d2,cs15):")
 /*
  * Shared across two callsites with swapped args (r1 is fp-8 on one pass,
@@ -2441,6 +2523,65 @@ static __used __naked void write_first_read_second(void)
 	::: __clobber_all);
 }
 
+/*
+ * merge_instances() must preserve may_write when one pass doesn't touch a frame.
+ * mvs_leaf is reached through a single callsite (mvs_mid) from two outer chains,
+ * so it is one shared (depth,callsite) instance analyzed twice and merged:
+ * - chain A passes r2 = map value, mvs_leaf's doesn't touch stack;
+ * - chain B passes r2 = caller stack slot fp-8.
+ * The merge must keep the stack pass's may_write even though the map pass left
+ * frame 0 untouched.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("stack use/def subprog#2 mvs_leaf (d2,cs19):")
+__msg("21: (7a) *(u64 *)(r2 +0) = 42         ; may_def: fp0-8")
+__naked void merge_preserves_may_write(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 24) = r1;"		/* map key */
+	"r1 = %[map] ll;"
+	"r2 = r10;"
+	"r2 += -24;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	/* chain A: r2 = map value (ARG_NONE, not stack) */
+	"r1 = r10;"
+	"r1 += -16;"				/* unused fp anchor */
+	"r2 = r0;"
+	"call mvs_mid;"
+	/* chain B: r2 = caller stack slot fp-8 */
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call mvs_mid;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	: : __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+static __used __naked void mvs_mid(void)
+{
+	asm volatile (
+	"call mvs_leaf;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void mvs_leaf(void)
+{
+	asm volatile (
+	"*(u64 *)(r2 + 0) = 42;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 /*
  * Shared must_write when (callsite, depth) instance is reused.
  * Main calls fwd_to_stale_wr at two sites. fwd_to_stale_wr calls

-- 
2.55.0
