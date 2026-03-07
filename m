Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898E1367
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841785; cv=none; b=TQfz02A4/LUJ/DPDdeyo0VRRLxS1yBCgcWe7mMJeRNFJEX5TCWK6tqbWTrMeQqXkwC1Fjx7rFU6dFTin0qEbG+mnGk4ejST/VQieIz70HcI5Uyt97ecBtLWGoVD1f24TCC9maTjM5yVQzegqjTA+oFvNGvpIMtlVbykzFLNQ14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841785; c=relaxed/simple;
	bh=TFtD0VUWzX+fTxk/BDaunB5FisIwh/zm1I00aX7GLRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVExMubwmFjXu64ILOhA8jXaZ78mvk4B6HXTZSOe/xqRBEbZW8V5gWlAO5z1GDTKNcz81CgxzT7SOAtYgpM63Bw6gcxRxk8Jx1dehmGXdIpZcN0KRNmJpJbtnGtr4c4t/puZI5aakAIKUAHHhjGlD5DgeEmS2iZJnK9OAoTQiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwdc/g7h; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwdc/g7h"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1277d379936so11501835c88.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772841783; x=1773446583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ansN0o+nrIEMYBCK8RGHd68y3vGVHITHCZLZF4aLC3g=;
        b=dwdc/g7hsctFsBd2CZFyRtcYDaOW5F+bO6FD2zJPH6g8LINvMQGkx7lg5lGLKEDqlv
         ugopA7KCBXiyg6dC1OzPbCA8pTbPCwLarwqP265SyZbsueJosxUMS1rBQmd91kValu8m
         Ht3a8KDbj2Bbt3rC+GdNhELExqgU/JNu4o9dKjU3z80W6x1v4ELrKy864DSx45z0MHjI
         u11b6VJrLOHKwPBvf0g+R8/kLmYc58oHAw7heKeXk50nHFt5t7R1Zn3Lq1oXps5kOjqR
         LgftOwwCfz/Gf+Bo2Mv1ZeVz06UgWyr9MUsmJMA0hUtO4EG51iK1ZxURQsjA6J3bkSPk
         6OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772841783; x=1773446583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ansN0o+nrIEMYBCK8RGHd68y3vGVHITHCZLZF4aLC3g=;
        b=JVlPUwkvD8X6volfMDWzMSzbIbtAWdHLL3oylkW086khmbsXkrAbfOBN+58Ko2ClRY
         pmKMJ0qsYZfYoliKLOH/MGfODETAf50JJWd6I6h5i7AbraDTTVCNZ5+8tA4ePey1kSyW
         2wFtfK8qr0/oEMyzi4cFSFHKYjO8nKkZ9/7v6ZjJi0Jp1pY14f1nuBmAMacfhqecVLDU
         h+4/PNfHf0DwLk8D/4hLhd+j3wfe93ofIlBeh9MBwHn/guR1zPSbne2VRFi4GCvcGyhf
         B4s+Wz+OLlUG2pSUq2fOZ8MVE2SmuorDEBgb8wsC29f+cCEP7Y7ASCsGtrfBE2ZLhnGp
         8IHQ==
X-Gm-Message-State: AOJu0YyQrnLVW0MZUstHqlzMg+d6Grlj6BK6tn5cHnyyebKCn7q2yqqg
	//3QVKMPmjgOXeaQRAkeGqchNKajXsSBUAC+5L+S0VPWVYIqTO8GKeW6DZbF38Kb
X-Gm-Gg: ATEYQzxVgFEmvGixStel225Ha2ZmbZKFZyN0M3uScwgBnD0agHTTpmMwlytKsSGcO6R
	yCcDvj+vpHS512QAo6De2OZsYNjVzk3+fyiBkI+qqeOcORNy5KM7WmvJBDV6Bco7thM29xlgrJ9
	RgRRQbMepsz1QNnfcxVxJg1XuTgLG46wFkdqeqyqorBoEqtCuaYUEyzAPxSaDcbRd2l8jhY3jdJ
	QZCdPWGF0rBNHBerQP2XVFvaKIYgNJrDH6xJSeZ9KbN6nDJo3WsvkQqDpc3jIkgDGBaZ6G8oAVY
	fI2wtecvTQGDNG+4+Q3vgnj4kD19xJCpa8fV5NlUO6oogdbuWnFUZ2JBlHob0QgLfr+m7ANzvtH
	P/x7AnNoC1hPRqCUKj46FCSbLsN+kyZviPgZTYnlFsi3FAFWW7CsC755uXbfLCulz+MKp/RZapd
	7Mf/9IOoBJhVC3bUYK6chB0SmXJHNLsmDXmhay0p2iTVPytriFlmR1yqXCMSWhTNQ3/ped0u4Ki
	eH3Hls=
X-Received: by 2002:a05:7022:6b8b:b0:127:345c:43b2 with SMTP id a92af1059eb24-128c2e86483mr1562619c88.28.1772841782613;
        Fri, 06 Mar 2026 16:03:02 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f62d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3bf4cb2sm2153786c88.0.2026.03.06.16.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:03:02 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	emil@etsalapatis.com
Subject: [PATCH bpf 1/2] bpf: collect only live registers in linked regs
Date: Fri,  6 Mar 2026 16:02:47 -0800
Message-ID: <20260306-linked-regs-and-propagate-precision-v1-1-18e859be570d@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306-linked-regs-and-propagate-precision-v1-0-18e859be570d@gmail.com>
References: <20260306-linked-regs-and-propagate-precision-v1-0-18e859be570d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fix an inconsistency between func_states_equal() and
collect_linked_regs():
- regsafe() uses check_ids() to verify that cached and current states
  have identical register id mapping.
- func_states_equal() calls regsafe() only for registers computed as
  live by compute_live_registers().
- clean_live_states() is supposed to remove dead registers from cached
  states, but it can skip states belonging to an iterator-based loop.
- collect_linked_regs() collects all registers sharing the same id,
  ignoring the marks computed by compute_live_registers().
  Linked registers are stored in the state's jump history.
- backtrack_insn() marks all linked registers for an instruction
  as precise whenever one of the linked registers is precise.

The above might lead to a scenario:
- There is an instruction I with register rY known to be dead at I.
- Instruction I is reached via two paths: first A, then B.
- On path A:
  - There is an id link between registers rX and rY.
  - Checkpoint C is created at I.
  - Linked register set {rX, rY} is saved to the jump history.
  - rX is marked as precise at I, causing both rX and rY
    to be marked precise at C.
- On path B:
  - There is no id link between registers rX and rY,
    otherwise register states are sub-states of those in C.
  - Because rY is dead at I, check_ids() returns true.
  - Current state is considered equal to checkpoint C,
    propagate_precision() propagates spurious precision
    mark for register rY along the path B.
  - Depending on a program, this might hit verifier_bug()
    in the backtrack_insn(), e.g. if rY ∈  [r1..r5]
    and backtrack_insn() spots a function call.

The reproducer program is in the next patch.
This was hit by sched_ext scx_lavd scheduler code.

Changes in tests:
- verifier_scalar_ids.c selftests need modification to preserve
  some registers as live for __msg() checks.
- exceptions_assert.c adjusted to match changes in the verifier log,
  R0 is dead after conditional instruction and thus does not get
  range.
- precise.c adjusted to match changes in the verifier log, register r9
  is dead after comparison and it's range is not important for test.

Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                              | 13 +++--
 .../selftests/bpf/progs/exceptions_assert.c        | 34 ++++++-------
 .../selftests/bpf/progs/verifier_scalar_ids.c      | 56 ++++++++++++++++------
 tools/testing/selftests/bpf/verifier/precise.c     |  8 ++--
 4 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401d6c4960eccfa90893660b7d8aece859787f7f..a5418f80b90433949a3531ea8b0cf85b3508fb78 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17335,17 +17335,24 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
  * in verifier state, save R in linked_regs if R->id == id.
  * If there are too many Rs sharing same id, reset id for leftover Rs.
  */
-static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 id,
+static void collect_linked_regs(struct bpf_verifier_env *env,
+				struct bpf_verifier_state *vstate,
+				u32 id,
 				struct linked_regs *linked_regs)
 {
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
+	u16 live_regs;
 	int i, j;
 
 	id = id & ~BPF_ADD_CONST;
 	for (i = vstate->curframe; i >= 0; i--) {
+		live_regs = aux[frame_insn_idx(vstate, i)].live_regs_before;
 		func = vstate->frame[i];
 		for (j = 0; j < BPF_REG_FP; j++) {
+			if (!(live_regs & BIT(j)))
+				continue;
 			reg = &func->regs[j];
 			__collect_linked_regs(linked_regs, reg, id, i, j, true);
 		}
@@ -17560,9 +17567,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 * if parent state is created.
 	 */
 	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
-		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
+		collect_linked_regs(env, this_branch, src_reg->id, &linked_regs);
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
-		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
+		collect_linked_regs(env, this_branch, dst_reg->id, &linked_regs);
 	if (linked_regs.cnt > 1) {
 		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
 		if (err)
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index a01c2736890f9482e5a16bc943e7d877600149c2..858af5988a38a96c66baf85179c2b8b278f35e11 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -18,43 +18,43 @@
 		return *(u64 *)num;					\
 	}
 
-__msg(": R0=0xffffffff80000000")
+__msg("R{{.}}=0xffffffff80000000")
 check_assert(s64, ==, eq_int_min, INT_MIN);
-__msg(": R0=0x7fffffff")
+__msg("R{{.}}=0x7fffffff")
 check_assert(s64, ==, eq_int_max, INT_MAX);
-__msg(": R0=0")
+__msg("R{{.}}=0")
 check_assert(s64, ==, eq_zero, 0);
-__msg(": R0=0x8000000000000000 R1=0x8000000000000000")
+__msg("R{{.}}=0x8000000000000000")
 check_assert(s64, ==, eq_llong_min, LLONG_MIN);
-__msg(": R0=0x7fffffffffffffff R1=0x7fffffffffffffff")
+__msg("R{{.}}=0x7fffffffffffffff")
 check_assert(s64, ==, eq_llong_max, LLONG_MAX);
 
-__msg(": R0=scalar(id=1,smax=0x7ffffffe)")
+__msg("R{{.}}=scalar(id=1,smax=0x7ffffffe)")
 check_assert(s64, <, lt_pos, INT_MAX);
-__msg(": R0=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
 check_assert(s64, <, lt_zero, 0);
-__msg(": R0=scalar(id=1,smax=0xffffffff7fffffff")
+__msg("R{{.}}=scalar(id=1,smax=0xffffffff7fffffff")
 check_assert(s64, <, lt_neg, INT_MIN);
 
-__msg(": R0=scalar(id=1,smax=0x7fffffff)")
+__msg("R{{.}}=scalar(id=1,smax=0x7fffffff)")
 check_assert(s64, <=, le_pos, INT_MAX);
-__msg(": R0=scalar(id=1,smax=0)")
+__msg("R{{.}}=scalar(id=1,smax=0)")
 check_assert(s64, <=, le_zero, 0);
-__msg(": R0=scalar(id=1,smax=0xffffffff80000000")
+__msg("R{{.}}=scalar(id=1,smax=0xffffffff80000000")
 check_assert(s64, <=, le_neg, INT_MIN);
 
-__msg(": R0=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_pos, INT_MAX);
-__msg(": R0=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_zero, 0);
-__msg(": R0=scalar(id=1,smin=0xffffffff80000001")
+__msg("R{{.}}=scalar(id=1,smin=0xffffffff80000001")
 check_assert(s64, >, gt_neg, INT_MIN);
 
-__msg(": R0=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_pos, INT_MAX);
-__msg(": R0=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_zero, 0);
-__msg(": R0=scalar(id=1,smin=0xffffffff80000000")
+__msg("R{{.}}=scalar(id=1,smin=0xffffffff80000000")
 check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 3072fee9a448bb3438d6167987c51bed54034a87..58c7704d61cd928cedddb7baa68413bbe9503141 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -40,6 +40,9 @@ __naked void linked_regs_bpf_k(void)
 	 */
 	"r3 = r10;"
 	"r3 += r0;"
+	/* Mark r1 and r2 as alive. */
+	"r1 = r1;"
+	"r2 = r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -73,6 +76,9 @@ __naked void linked_regs_bpf_x_src(void)
 	 */
 	"r4 = r10;"
 	"r4 += r0;"
+	/* Mark r1 and r2 as alive. */
+	"r1 = r1;"
+	"r2 = r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -106,6 +112,10 @@ __naked void linked_regs_bpf_x_dst(void)
 	 */
 	"r4 = r10;"
 	"r4 += r3;"
+	/* Mark r1 and r2 as alive. */
+	"r0 = r0;"
+	"r1 = r1;"
+	"r2 = r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -143,6 +153,9 @@ __naked void linked_regs_broken_link(void)
 	 */
 	"r3 = r10;"
 	"r3 += r0;"
+	/* Mark r1 and r2 as alive. */
+	"r1 = r1;"
+	"r2 = r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -156,16 +169,16 @@ __naked void linked_regs_broken_link(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg("12: (0f) r2 += r1")
+__msg("17: (0f) r2 += r1")
 /* Current state */
-__msg("frame2: last_idx 12 first_idx 11 subseq_idx -1 ")
-__msg("frame2: regs=r1 stack= before 11: (bf) r2 = r10")
+__msg("frame2: last_idx 17 first_idx 14 subseq_idx -1 ")
+__msg("frame2: regs=r1 stack= before 16: (bf) r2 = r10")
 __msg("frame2: parent state regs=r1 stack=")
 __msg("frame1: parent state regs= stack=")
 __msg("frame0: parent state regs= stack=")
 /* Parent state */
-__msg("frame2: last_idx 10 first_idx 10 subseq_idx 11 ")
-__msg("frame2: regs=r1 stack= before 10: (25) if r1 > 0x7 goto pc+0")
+__msg("frame2: last_idx 13 first_idx 13 subseq_idx 14 ")
+__msg("frame2: regs=r1 stack= before 13: (25) if r1 > 0x7 goto pc+0")
 __msg("frame2: parent state regs=r1 stack=")
 /* frame1.r{6,7} are marked because mark_precise_scalar_ids()
  * looks for all registers with frame2.r1.id in the current state
@@ -173,20 +186,20 @@ __msg("frame2: parent state regs=r1 stack=")
 __msg("frame1: parent state regs=r6,r7 stack=")
 __msg("frame0: parent state regs=r6 stack=")
 /* Parent state */
-__msg("frame2: last_idx 8 first_idx 8 subseq_idx 10")
-__msg("frame2: regs=r1 stack= before 8: (85) call pc+1")
+__msg("frame2: last_idx 9 first_idx 9 subseq_idx 13")
+__msg("frame2: regs=r1 stack= before 9: (85) call pc+3")
 /* frame1.r1 is marked because of backtracking of call instruction */
 __msg("frame1: parent state regs=r1,r6,r7 stack=")
 __msg("frame0: parent state regs=r6 stack=")
 /* Parent state */
-__msg("frame1: last_idx 7 first_idx 6 subseq_idx 8")
-__msg("frame1: regs=r1,r6,r7 stack= before 7: (bf) r7 = r1")
-__msg("frame1: regs=r1,r6 stack= before 6: (bf) r6 = r1")
+__msg("frame1: last_idx 8 first_idx 7 subseq_idx 9")
+__msg("frame1: regs=r1,r6,r7 stack= before 8: (bf) r7 = r1")
+__msg("frame1: regs=r1,r6 stack= before 7: (bf) r6 = r1")
 __msg("frame1: parent state regs=r1 stack=")
 __msg("frame0: parent state regs=r6 stack=")
 /* Parent state */
-__msg("frame1: last_idx 4 first_idx 4 subseq_idx 6")
-__msg("frame1: regs=r1 stack= before 4: (85) call pc+1")
+__msg("frame1: last_idx 4 first_idx 4 subseq_idx 7")
+__msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
 __msg("frame0: parent state regs=r1,r6 stack=")
 /* Parent state */
 __msg("frame0: last_idx 3 first_idx 1 subseq_idx 4")
@@ -204,6 +217,7 @@ __naked void precision_many_frames(void)
 	"r1 = r0;"
 	"r6 = r0;"
 	"call precision_many_frames__foo;"
+	"r6 = r6;" /* mark r6 as live */
 	"exit;"
 	:
 	: __imm(bpf_ktime_get_ns)
@@ -220,6 +234,8 @@ void precision_many_frames__foo(void)
 	"r6 = r1;"
 	"r7 = r1;"
 	"call precision_many_frames__bar;"
+	"r6 = r6;" /* mark r6 as live */
+	"r7 = r7;" /* mark r7 as live */
 	"exit"
 	::: __clobber_all);
 }
@@ -229,6 +245,8 @@ void precision_many_frames__bar(void)
 {
 	asm volatile (
 	"if r1 > 7 goto +0;"
+	"r6 = 0;" /* mark r6 as live */
+	"r7 = 0;" /* mark r7 as live */
 	/* force r1 to be precise, this eventually marks:
 	 * - bar frame r1
 	 * - foo frame r{1,6,7}
@@ -340,6 +358,8 @@ __naked void precision_two_ids(void)
 	"r3 += r7;"
 	/* force r9 to be precise, this also marks r8 */
 	"r3 += r9;"
+	"r6 = r6;" /* mark r6 as live */
+	"r8 = r8;" /* mark r8 as live */
 	"exit;"
 	:
 	: __imm(bpf_ktime_get_ns)
@@ -353,7 +373,7 @@ __flag(BPF_F_TEST_STATE_FREQ)
  * collect_linked_regs() can't tie more than 6 registers for a single insn.
  */
 __msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
-__msg("9: (bf) r6 = r6                       ; R6=scalar(id=2")
+__msg("14: (bf) r6 = r6                      ; R6=scalar(id=2")
 /* check that r{0-5} are marked precise after 'if' */
 __msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
 __msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
@@ -372,6 +392,12 @@ __naked void linked_regs_too_many_regs(void)
 	"r6 = r0;"
 	/* propagate range for r{0-6} */
 	"if r0 > 7 goto +0;"
+	/* keep r{1-5} live */
+	"r1 = r1;"
+	"r2 = r2;"
+	"r3 = r3;"
+	"r4 = r4;"
+	"r5 = r5;"
 	/* make r6 appear in the log */
 	"r6 = r6;"
 	/* force r0 to be precise,
@@ -517,7 +543,7 @@ __naked void check_ids_in_regsafe_2(void)
 	"*(u64*)(r10 - 8) = r1;"
 	/* r9 = pointer to stack */
 	"r9 = r10;"
-	"r9 += -8;"
+	"r9 += -16;"
 	/* r8 = ktime_get_ns() */
 	"call %[bpf_ktime_get_ns];"
 	"r8 = r0;"
@@ -538,6 +564,8 @@ __naked void check_ids_in_regsafe_2(void)
 	"if r7 > 4 goto l2_%=;"
 	/* Access memory at r9[r6] */
 	"r9 += r6;"
+	"r9 += r7;"
+	"r9 += r8;"
 	"r0 = *(u8*)(r9 + 0);"
 "l2_%=:"
 	"r0 = 0;"
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 061d98f6e9bb369e47f9612da02c4f82424d951d..a9242103dc47866498adbcf3c5c6ba225bb3c062 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -44,9 +44,9 @@
 	mark_precise: frame0: regs=r2 stack= before 23\
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2,r9 stack=:\
+	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
-	mark_precise: frame0: regs=r2,r9 stack= before 19\
+	mark_precise: frame0: regs=r2 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
 	mark_precise: frame0: regs=r8,r9 stack= before 17\
 	mark_precise: frame0: regs=r0,r9 stack= before 15\
@@ -107,9 +107,9 @@
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
 	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2,r9 stack=:\
+	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
-	mark_precise: frame0: regs=r2,r9 stack= before 19\
+	mark_precise: frame0: regs=r2 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
 	mark_precise: frame0: regs=r8,r9 stack= before 17\
 	mark_precise: frame0: parent state regs= stack=:",

-- 
2.53.0
