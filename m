Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997AD439F8F
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121152; cv=none; b=Z6Tl/qSLswBaNwDbksOdZYfthSC+PwlpCsIzHPSRkP8jTl7QTPmKJWR1vBnCfOe94L1hEr83Tj5z5t9dUy980AsUr3VsO5I2y/SYBWpvUqIJCAybzUKO/kEJxyTls+UmrzR+gzSwazB0M19u6VyUpwvG8zfCRukXtEQNLdDzOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121152; c=relaxed/simple;
	bh=ytmLwE2m73Qs1Q8vwy6BpQHJxepd5pkb0fDKbWX6fB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1AvfflZU9Mu+ahU7truWYX1TbJvU5Euj76BnuTxmuqxOuncafVfh2RKGZ1YiUDsdmt78+ULcpvga4UHrI4/jOmRr1e1LMhCj9HgHIP2+WRyhKoIZra4PjrlCWb6+GWopWHiuKwVDayRwbJjflgpfAYcgJGmWuiJH8vn5gZpKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfjlVrK5; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfjlVrK5"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so421617a12.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121149; x=1791725949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GaCxiCU7O3fKxYOQRvzPXKp2LYdrnyz5kZgHLll1rz0=;
        b=EfjlVrK5WODDi0tFmfXBpDYMvQa/l+0fbMB3HAYyEgRjC/R5+N2mEVbjHIQI7pn5DZ
         ZKbzHCT2THoBIzsdILXe2NKz2ELjmKteLOqoFu7ppg/I04/cMAaqDEi3VqLnocuNLbcR
         BBHfYfGxxQriI+84lrukdk9yXuA68X+qFmxR0rREWMuta7dJEpPYcYluiy9V3PqPA7cx
         gX/DXguCviP3dV7o9BjnpbnJxDG+V3IbuTpw8sWGq4FzcpeiKBrMYyNyyYQUP9Pi0EEF
         qDCCepyH3JVZIYnaJPtw/YVN8XHvpoMpuH9lBp6c0TqFEfXLH/kDeP4PH0P/+G6XXoSD
         EveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121149; x=1791725949;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GaCxiCU7O3fKxYOQRvzPXKp2LYdrnyz5kZgHLll1rz0=;
        b=lKi2lLAZvWGJtT9zOZ4t1NJR+6OexhGk0AcpN8Ffz4e/HiVyQBuSYbfYwG67gUt0Ir
         VfCzQ7eJpY9qFqm4yiXJhSFsibxPgHZVahticlqgzCwtYpCyCKmHB3GeHqgXHqoesXD/
         UyQSVkdKo25aE+uLThLEdpDm4CPvlWGCdbkLaCFIZskVwQmhZM0KGRvZdVlT+uLm3y4f
         bzuiFKExcgMkqByptl7Yvko5SNTt257l3vA0QhILjBEq5yGKHHGfjSlCwLVkY0GH99+N
         n7oIuyPS1A3RZWdwTZubplcZAiDBHJvOUVpBewZyQ6d5b+KTda7Xu1MTuDsPRk0LjeRW
         sA4w==
X-Gm-Message-State: AFuF++kWI1guU8rXQE7Ub6hE538eGPBAi6edJdp167AOpDhOGgLa5770
	PNDOdPHxcbduLgN6YQ8PT2yeEKrr0+nbYpVpQhHocEc2plRlw5vxn1GyYelomA==
X-Gm-Gg: AYBFou3+jrMus6gMIWPgoOqk4SuUbfas/dVjdvw1O66GDALe0a3fbD8v+gRCS5y0o0M
	WcYIFMw2tgMPfWv2R4FSauNP8cR4yzy3NTXO5NVQ6j/cqTvhk7bEIh1mYKMUJ4nuloXag3qwPvH
	mgFFwsBM1bkl7DXFhk8cMsiRIo1BsoeidPcn+XQRQNDtPhkxyi8Y4rpRlLLLX+DKpCJ015vh+7U
	bBKAmrLsQb1XHyh5Py/mclCG7z7ruQmL6SbYl3Jo6BTAxOpXD2g0LQ3elXzleb7FHbqd6MzjbMj
	pD9Z615EZweioCurIb1CdjLP7mJPQleU4soYzKPNGtQgmbpxW3V3wRs2L0iVwEaAqMn8am8Ywao
	j0VDUSFVxIkNTeVGngsYC+Nd7l1R9WJ6bOc88S/HpArUzVW0NqEIjjCmOAdfCcanBi+6A5rdjFo
	h+ceMMivDkc0doBiUg66P8b660vbqrKs6y7qP8jfO/euM/eO2U85YS80tryJq/nVJ1KacwC4Jci
	1hpIURXiEHRqHs=
X-Received: by 2002:a05:6a21:670b:b0:3d8:5a37:549c with SMTP id adf61e73a8af0-3e0bc9f8ccdmr8305844637.7.1791121148709;
        Sun, 04 Oct 2026 06:39:08 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 35/43] selftests/bpf: tests for may_write stack-liveness tracking
Date: Sun,  4 Oct 2026 06:38:17 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-35-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
    summarized as may_def at the caller's call instruction
  - analyze_subprog()                     -> may_def stack slot range
                                             when callback is unknown.

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
  - helper_output_unknown_size     - output size unknown to liveness,
                                     may_def without use or def
  - caller_stack_write,
    conditional_stx_in_subprog,
    shared_instance_must_write_overwrite
                                   - callee writes summarized as may_def
                                     at the call site
  - bpf_loop_two_callbacks         - call to unknown callback marks full
                                     stack range as may_def.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 180 ++++++++++++++++++++-
 1 file changed, 175 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 0e6f25a09b5d..a06156c18c9e 100644
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
@@ -2271,11 +2339,19 @@ static __used __naked void merge_leaf_read(void)
 	::: __clobber_all);
 }
 
-/* Same bpf_loop instruction calls different callbacks depending on branch. */
+/*
+ * Same bpf_loop instruction calls different callbacks depending on branch.
+ * One callback writes through ctx. With no unique callback, all frames must
+ * be marked as possibly read and written, including at enclosing call sites.
+ */
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_loop#181            ; use: fp2-8..-{{(512|2048)}} fp1-8..-{{(512|2048)}} fp0-8..-{{(512|2048)}}")
+__msg("stack use/def subprog#0 bpf_loop_two_callbacks (d0,cs0):")
+__msg("5: (85) call pc+{{.*}};{{.*}} may_def: fp0-8..-{{(512|2048)}}{{$}}")
+__msg("8: (85) call pc+{{.*}};{{.*}} may_def: fp0-8..-{{(512|2048)}}{{$}}")
+__msg("call bpf_loop#181            ; use: fp2-8..-{{(512|2048)}} fp1-8..-{{(512|2048)}} fp0-8..-{{(512|2048)}}"
+      " may_def: fp2-8..-{{(512|2048)}} fp1-8..-{{(512|2048)}} fp0-8..-{{(512|2048)}}{{$}}")
 __naked void bpf_loop_two_callbacks(void)
 {
 	asm volatile (
@@ -2393,6 +2469,20 @@ __flag(BPF_F_TEST_STATE_FREQ)
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
@@ -2441,6 +2531,65 @@ static __used __naked void write_first_read_second(void)
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
@@ -2949,3 +3098,24 @@ __naked void spill_below_512_stays_precise(void)
 	"exit;"
 	::: __clobber_all);
 }
+
+/* Unknown-size outputs still carry a possible write, without a read or kill. */
+SEC("socket")
+__success __log_level(2)
+__msg("call bpf_probe_read_kernel{{.*}}; may_def: fp0-8{{$}}")
+__naked void helper_output_unknown_size(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 7;"
+	"r0 += 1;"
+	"r2 = r0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r3 = 0;"
+	"call %[bpf_probe_read_kernel];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32), __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}

-- 
2.53.0
