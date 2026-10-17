Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F813AF665
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257492; cv=none; b=OC+Gknb0mQLQS3zdR0gH3XaiqDyP9tkRaXnh3mAzHWEEY+5uddWoMsdH+Nd1FWRjMgjcufTOkX+sFglDpsPXp/RWcPEZf29W6NdwLhDC8b0oQPlI0Wq4HgwkdCyUxJa4yZdBZzvrjAFl3V9aotFstuJORsW4ke2iV5zPybJ/WRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257492; c=relaxed/simple;
	bh=Jvelmht/F/NKNfJ850/flVNnEWsmcP9Ifp0ujgvk5VQ=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=GykSg05c9Ax/GwaeWGma33HnL2/sxg1jH8SylRlq+LJdsDphQXkrrcI5QTx6f1svAZEcKXOnNSErrD/YNoZFNx475pLt/lUvq020FcsOp4qH09Zr+DXzBxMCgnkKzHuwQfMFVJeHM/g+329Y1GhpgwhdkkGzEphHPPZCfseNi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS5lnzR3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS5lnzR3"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-88834d30002so359994b3a.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792257489; x=1792862289; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ej72fw3Gu093orBIxpGR9u4spG5xFbe4ODyBQUTpE58=;
        b=GS5lnzR33xJMEQcInWBIm1R4MtBoBAzMV0j9lrYhH4GPCR72lcw0NThneiE0hop8pE
         IEHSp4HDE6Rlhah5VPg8xmkxWtnm+oSCwZZcXK/ihWMCwSrwUnkOFWpDQr7TggLCAeUQ
         Q2PTQtgQR5gaROx2ipTh8s6T90kMtc5cPi+XrVHsGO5ybSya+cXH/wb2x6MFhP1Epx59
         lrqcT5wNiaco3cQvxMqAq3EBnRLYIb/Q3nno94kDPjDsafMA84LbErvB2CD9OmfO6f27
         HtdoEaGzsEVc6h+Rx5TWScYjXpWgdDooKGi3i9RubUFuIEhwztZGJIVFpvD3mZpL7Ihd
         uW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257489; x=1792862289;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ej72fw3Gu093orBIxpGR9u4spG5xFbe4ODyBQUTpE58=;
        b=U2VL7sXkMsESNVFX+N0YzcE1dLa1Kid1dMbLxElJr2sNaETxEwQOzxy9cObqx5OS3P
         5nIU6+K+G6UP3BQ2eCODroWU1x0CyolWuYQ1cRepaR78C8L80dyyVygGlKR498zcsu0x
         m8jMm1qZIEeLroisevApWf/3gNbflXZT2e0qf0CNYrzos+o2hli6MbT4dkA7shiS1rG1
         I8zQEQSa/T1YK4NtnL6Q+SG2GGdM61ra4p6qjMQruSpuU1Z13rdkRRWruGpZqmQlz7l6
         P+a9flcF7jOV8j4aPzTfsfnngRVwWBZH78HBfg4vLUjEMJRVB8tAb/T0c/dUMECq4CbN
         5DRg==
X-Forwarded-Encrypted: i=1; AKwUvBz5DT+pM4ioDP5aH/3kV726RO209BxGvcVIn7c0nCawrfZI2DIIgbaBsiron1EPxjpJ1Rw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkcdVXIrk2UeF+8btgJK/deI5iO0RfdVDPSBzHG8V9PoSIuHQ/
	OxTUbWyKow4odVTfOTtdy1UO6xuJ1p6/p6bLuOtesGlJoWfKtZjs04Ut
X-Gm-Gg: AYBFou2XdGiafqSJuU9/fDnKZjERVjSCR9UHVgMhzsgC8VLsamr11xHpAu4aYl3So4W
	7zQRQWtWxnIrjg2Xt7TMs+IGb9BhsBLFbs9gKpvjmeF4KD4dv4LBx51HfS8hay5LQQdwwO269Wn
	sPaGd5dRNwV4aOqKkRaGnXao6G6lP27aE2PuI7ANAM0hdjq79XBf5JaSGhD1RO9BntjdNG7QUyK
	EvqnckSBFf2RCKPDUT3blSSQs7WjrNeTDE7g6rsOJgFaGKhLK9v6xs61rOCZlrcdNhMbh7uP4io
	/hnwuI48XaF5jT0ujKExYQmxx7FcqWG3GDPzVyi/eIWASBUrj3nN6ra6QTbT9ifWZqq1XCFZoge
	Kmgd8ie16jkVeUdxNW8wB582fU3BitX9yg65h1AjVXf+LGwFpyg44r2oY1EFP4wJiF8OYMQPlxJ
	wUjW3YtU/16i8XnO/28YrRDx3diHvWQId8pohrCyKmOLd0N/Y/jNs6uBSsVXcI3Ag9F7nquolAK
	PzDvz6tIXG9/QfvSxAEzXYnX172Fs1kYDnNVg/uK4qclHYA4IjIWDsV5V6Q0BhOA1zdt5/Ve9Gg
	d08=
X-Received: by 2002:a05:6a00:1c87:b0:881:cbb0:6a90 with SMTP id d2e1a72fcca58-8a04cb09c96mr2314780b3a.58.1792257489208;
        Sat, 17 Oct 2026 10:18:09 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947b0esm2338377b3a.39.2026.10.17.10.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 10:18:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 17:18:07 +0000
Message-Id: <DM7A976G9OGW.ZR7PNBUP083C@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v12 00/25] bpf: Run exception cleanup landing
 pads when bpf_unwind() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 07:51 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> Each frame therefore runs its own pad, on its own stack, and leaves
> through its own epilogue -- which is what puts its caller's r6-r9 back.

it's v12 and bots keep finding real bugs, I think it's a sign
that we have to pivot.

The idea is to sacrifce run-time and make unwind logic a nop for the verifier:
callee will use r3 to tell caller whether it needs to unwind.
while all callers do
'if r3 != 0 goto landing_pad'.
Then unwind is plain insns for the verifier, for every pass
in front of it and for JITs.
in_pad, unwind_exit, INSN_F_UNWIND, cleanup_pad in aux data,
pad edges in cfg.c, liveness.c, backtrack.c, unwind_frames(),
keep_subprog_exits(), native tables, epilogue_ip,
arch_bpf_stack_walk_ra(), PAC signing, all the complexity go away.

JITs have to keep r3 over the epilogue. x86, arm64, riscv, s390 do.
fexit, freplace and tail call don't, so they are refused
for a subprog that can unwind.

The callee of callx is a static subprog that the main pass walks,
so it returns via prepare_func_exit() like any other.
When a subprog with address taken can unwind all of them set r3.

uapi in patch 1, kfuncs in patch 2 and libbpf patches 17-21 stay as-is.
Something like this instead of patches 3-16
(tested on x86 only, in qemu: rustc output from v10 thread, catch, second unwind,
global subprogs, move into callee, callx directly and via a table
in rodata load and run. full test_progs was not run):

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..f55a14e6c388 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1882,6 +1882,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool ret_unwind;
 	bool kprobe_write_ctx;
 	struct {
 		s32 keyring_serial;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 11cd90d85bad..917fe736af8c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -944,6 +944,9 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool might_unwind: 1;
+	bool ret_unwind: 1; /* says in r3 whether it returns or unwinds */
+	bool unwind_stub: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
@@ -1103,6 +1106,7 @@ struct bpf_verifier_env {
 	struct bpf_func_ptr *func_ptrs;
 	u32 func_ptr_cnt;
 	bool has_callx;
+	bool callx_unwinds;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
 	 * subprog_cnt * subprog_cnt bits, where bit (caller * subprog_cnt + callee)
@@ -1214,6 +1218,8 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
 	return &env->subprog_info[subprog];
 }
 
+#define BPF_REG_UNWIND BPF_REG_3
+
 static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
 {
 	return subprog_info(env, subprog)->ret_reg_pair;
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 43d5740034c0..0f8dbacdf9ca 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -448,6 +448,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				bt_clear_reg(bt, BPF_REG_0);
 				/* and if it does not set R2, main pass would catch it */
 				bt_clear_reg(bt, BPF_REG_2);
+				bt_clear_reg(bt, BPF_REG_UNWIND);
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
@@ -548,7 +549,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
-			bool from_subprog_call, r0_precise, r2_precise;
+			bool from_subprog_call, r0_precise, r2_precise, r3_precise;
 
 			/* BPF_EXIT in subprog or callback always returns
 			 * right after the call instruction, so by checking
@@ -565,6 +566,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 
 			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
 			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
+			r3_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_UNWIND);
 
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
@@ -578,8 +580,10 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * might be a precise helper argument as well, so leave it set.
 			 */
 			bt_clear_reg(bt, BPF_REG_0);
-			if (from_subprog_call)
+			if (from_subprog_call) {
 				bt_clear_reg(bt, BPF_REG_2);
+				bt_clear_reg(bt, BPF_REG_UNWIND);
+			}
 			if (from_subprog_call && (bt_reg_mask(bt) & BPF_REGMASK_ARGS)) {
 				verifier_bug(env, "backtracking exit unexpected regs %x",
 					     bt_reg_mask(bt));
@@ -593,6 +597,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				bt_set_reg(bt, BPF_REG_0);
 			if (r2_precise)
 				bt_set_reg(bt, BPF_REG_2);
+			if (r3_precise)
+				bt_set_reg(bt, BPF_REG_UNWIND);
 			/* r6-r9 and stack slots will stay set in caller frame
 			 * bitmasks until we return back from callee(s)
 			 */
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index ac3b575f935e..2c26094bd96b 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/btf_ids.h>
 #include <linux/slab.h>
 #include "exception.h"
 
@@ -135,3 +136,242 @@ int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_attr *attr,
 	kvfree(krecord);
 	return ret;
 }
+
+BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
+BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
+
+static bool is_kfunc(const struct bpf_insn *insn, u32 btf_id)
+{
+	return bpf_pseudo_kfunc_call(insn) && !insn->off && insn->imm == btf_id;
+}
+
+bool bpf_is_unwind_kfunc(const struct bpf_insn *insn)
+{
+	return is_kfunc(insn, bpf_unwind_id[0]) || is_kfunc(insn, bpf_unwind_resume_id[0]);
+}
+
+static struct bpf_subprog_info *callee_of(struct bpf_verifier_env *env, u32 idx)
+{
+	return bpf_find_containing_subprog(env, idx + env->prog->insnsi[idx].imm + 1);
+}
+
+static bool unwinds_at(struct bpf_verifier_env *env, u32 idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+
+	return bpf_is_unwind_kfunc(insn) ||
+	       (bpf_pseudo_call(insn) && callee_of(env, idx)->might_unwind) ||
+	       (bpf_is_callx(insn) && env->callx_unwinds);
+}
+
+/*
+ * Can any subprog whose address is taken unwind? The callee of a callx is one
+ * of them. With @mark all of them say in r3 how they return.
+ */
+static bool addr_taken_unwinds(struct bpf_verifier_env *env, bool mark)
+{
+	struct bpf_subprog_info *sub;
+	bool ret = false;
+	u32 i;
+
+	for (i = 0; i < env->prog->len + env->func_ptr_cnt; i++) {
+		if (i >= env->prog->len)
+			sub = bpf_find_containing_subprog(env,
+					env->func_ptrs[i - env->prog->len].xlated_off);
+		else if (bpf_pseudo_func(&env->prog->insnsi[i]))
+			sub = callee_of(env, i);
+		else
+			continue;
+		ret |= sub->might_unwind;
+		sub->ret_unwind |= mark;
+	}
+	return ret;
+}
+
+static bool mark_might_unwind(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub;
+	bool changed, any = false;
+	u32 i;
+
+	do {
+		changed = false;
+		for (i = 0; i < env->prog->len; i++) {
+			sub = bpf_find_containing_subprog(env, i);
+			if (sub->might_unwind || !unwinds_at(env, i))
+				continue;
+			sub->might_unwind = sub->ret_unwind = changed = any = true;
+		}
+		if (env->has_callx && !env->callx_unwinds && addr_taken_unwinds(env, false))
+			env->callx_unwinds = changed = true;
+	} while (changed);
+
+	if (env->callx_unwinds)
+		addr_taken_unwinds(env, true);
+	return any;
+}
+
+static int pad_of(struct bpf_verifier_env *env, u32 idx)
+{
+	u32 l = 0, r = env->cleanup_info_cnt;
+
+	while (l < r) {
+		u32 m = l + (r - l) / 2;
+
+		if (idx < env->cleanup_info[m].begin_off)
+			r = m;
+		else if (idx >= env->cleanup_info[m].end_off)
+			l = m + 1;
+		else
+			return env->cleanup_info[m].landing_pad_off;
+	}
+	return -1;
+}
+
+static int patch(struct bpf_verifier_env *env, u32 off, struct bpf_insn *buf, u32 cnt)
+{
+	u32 i, delta = cnt - 1, orig_idx = env->insn_aux_data[off].orig_idx;
+	struct bpf_prog *prog;
+
+	/* The insns of a patch are not adjusted for the patch itself. */
+	if (bpf_pseudo_call(&buf[0]) && buf[0].imm >= 0)
+		buf[0].imm += delta;
+	prog = bpf_patch_insn_data(env, off, buf, cnt);
+	if (!prog)
+		return -ENOMEM;
+	env->prog = prog;
+
+	for (i = 0; i < cnt; i++)
+		env->insn_aux_data[off + i].orig_idx = orig_idx;
+	for (i = 0; i < env->subprog_cnt; i++)
+		if (env->subprog_info[i].exit_idx != U32_MAX &&
+		    env->subprog_info[i].exit_idx >= off)
+			env->subprog_info[i].exit_idx += delta;
+	for (i = 0; i < env->cleanup_info_cnt; i++) {
+		struct bpf_cleanup_info *rec = &env->cleanup_info[i];
+
+		if (rec->begin_off > off)
+			rec->begin_off += delta;
+		if (rec->end_off > off)
+			rec->end_off += delta;
+		if (rec->landing_pad_off > off)
+			rec->landing_pad_off += delta;
+	}
+	return 0;
+}
+
+/* Replace insn @off with buf[0..n) followed by 'if r3 != 0 goto @tgt'. */
+static int patch_jmp(struct bpf_verifier_env *env, u32 off, struct bpf_insn *buf, u32 n, u32 tgt)
+{
+	s32 rel = tgt - off - 1 - (tgt > off ? 0 : n);
+
+	if (rel == (s16)rel) {
+		buf[n++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_UNWIND, 0, rel);
+	} else {
+		buf[n++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_UNWIND, 0, 1);
+		buf[n++] = BPF_JMP32_A(tgt > off ? rel : rel - 1);
+	}
+	return patch(env, off, buf, n) ?: n;
+}
+
+#define STUB_LEN 3
+
+static bool needs_stub(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
+{
+	u32 i, last = (sub + 1)->start - 1;
+
+	for (i = sub->start; i <= last; i++)
+		if (unwinds_at(env, i) &&
+		    (i == last || pad_of(env, i) < 0 ||
+		     is_kfunc(&env->prog->insnsi[i], bpf_unwind_resume_id[0])))
+			return true;
+	return false;
+}
+
+/*
+ * Turn the table into code before anything looks at the program.
+ *
+ * A subprog that can unwind says in r3 how it returns:
+ *   exit                    r3 = 0; exit
+ *   call bpf_unwind         r0 = 0; r3 = 1; if r3 != 0 goto pad
+ *   call bpf_unwind_resume  r0 = 0; r3 = 1; if r3 != 0 goto stub
+ *   call subprog, callx     call subprog; if r3 != 0 goto pad
+ * where pad is the stub when no record covers the call. The stub is
+ * 'r0 = 0; r2 = 0; exit' after the last insn, so a final call that
+ * does not return falls through to it.
+ */
+int bpf_exc_lower(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub;
+	bool any = mark_might_unwind(env);
+	struct bpf_insn buf[5];
+	int err, pad;
+	u32 i, n;
+
+	if (any && (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux)))
+		return -EOPNOTSUPP;
+	env->prog->jit_required |= any;
+
+	for (sub = env->subprog_info; sub < env->subprog_info + env->subprog_cnt; sub++) {
+		/* They return to the caller with whatever is in r3. */
+		if (sub->ret_unwind && sub != env->subprog_info &&
+		    (sub->has_tail_call || sub->has_ld_abs)) {
+			verbose(env, "tail call or ld_abs in a subprog that can unwind\n");
+			return -EINVAL;
+		}
+		if (!needs_stub(env, sub)) {
+			/* check_subprogs() left a final call to be decided here */
+			if (BPF_OP(env->prog->insnsi[(sub + 1)->start - 1].code) == BPF_CALL) {
+				verbose(env, "last insn is not an exit or jmp\n");
+				return -EINVAL;
+			}
+			continue;
+		}
+		sub->unwind_stub = true;
+		buf[0] = env->prog->insnsi[(sub + 1)->start - 1];
+		buf[1] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		buf[2] = BPF_MOV64_IMM(BPF_REG_2, 0);
+		buf[3] = BPF_EXIT_INSN();
+		err = patch(env, (sub + 1)->start - 1, buf, STUB_LEN + 1);
+		if (err)
+			return err;
+	}
+
+	for (i = 0; i < env->prog->len; i += n) {
+		struct bpf_insn *insn = &env->prog->insnsi[i];
+		u32 stub;
+
+		sub = bpf_find_containing_subprog(env, i);
+		stub = (sub + 1)->start - (sub->unwind_stub ? STUB_LEN : 0);
+		n = 1;
+		if (!sub->ret_unwind || i >= stub)
+			continue;
+
+		if (insn->code == (BPF_JMP | BPF_EXIT)) {
+			if (sub == env->subprog_info)
+				continue;
+			buf[0] = BPF_MOV64_IMM(BPF_REG_UNWIND, 0);
+			buf[1] = *insn;
+			n = 2;
+			err = patch(env, i, buf, n);
+			if (err)
+				return err;
+			continue;
+		}
+
+		if (!unwinds_at(env, i))
+			continue;
+		pad = is_kfunc(insn, bpf_unwind_resume_id[0]) ? -1 : pad_of(env, i);
+		buf[0] = *insn;
+		if (bpf_is_unwind_kfunc(insn)) {
+			buf[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			buf[1] = BPF_MOV64_IMM(BPF_REG_UNWIND, 1);
+			n = 2;
+		}
+		err = patch_jmp(env, i, buf, n, pad < 0 ? stub : pad);
+		if (err < 0)
+			return err;
+		n = err;
+	}
+	return 0;
+}
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index cf099dcc5b74..3ca174f9bfc6 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -8,8 +8,11 @@
 
 union bpf_attr;
 struct bpf_verifier_env;
+struct bpf_insn;
 
 int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_attr *attr,
 		       bpfptr_t uattr);
+bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
+int bpf_exc_lower(struct bpf_verifier_env *env);
 
 #endif /* __BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 608621d7f225..8580fa2b634f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1383,6 +1383,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->ret_unwind = env->subprog_info[i].ret_unwind;
 		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8df3f4746b68..ce6ab81c1ec0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5128,6 +5128,8 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_unwind)
+BTF_ID_FLAGS(func, bpf_unwind_resume)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task)
 #endif
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..51ccb8b080a9 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2482,7 +2482,7 @@ static int callee_subprog(struct bpf_verifier_env *env, const struct bpf_insn *i
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info,
-				   bool ret_reg_pair)
+				   bool ret_reg_pair, bool ret_unwind)
 {
 	struct bpf_call_summary cs;
 	const u8 class = BPF_CLASS(insn->code);
@@ -2616,6 +2616,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		case BPF_EXIT:
 			def = 0;
 			use = ret_reg_pair ? (r0 | r2) : r0;
+			if (ret_unwind)
+				use |= reg64_mask(BPF_REG_UNWIND);
 			break;
 		case BPF_CALL:
 			def = ALL_CALLER_SAVED_REGS;
@@ -2698,7 +2700,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		ret_reg_pair = bpf_ret_reg_pair(env, subprog);
 
 		for (i = start; i < end; ++i)
-			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
+			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair,
+					       subprog && env->subprog_info[subprog].ret_unwind);
 	}
 
 	/* Forward pass: resolve stack access through FP-derived pointers */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1facec5485b3..fabd48affd52 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3360,7 +3360,9 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			if (code != (BPF_JMP | BPF_EXIT) &&
 			    code != (BPF_JMP32 | BPF_JA) &&
 			    code != (BPF_JMP | BPF_JA) &&
-			    !insn_is_gotox(&insn[i])) {
+			    !insn_is_gotox(&insn[i]) &&
+			    !bpf_pseudo_call(&insn[i]) && !bpf_is_callx(&insn[i]) &&
+			    !bpf_is_unwind_kfunc(&insn[i])) {
 				verbose(env, "last insn is not an exit or jmp\n");
 				bpf_diag_program_structure(
 					env, i, "subprogram can fall through",
@@ -11190,6 +11192,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * callbacks
 	 */
 	env->subprog_info[subprog].is_cb = true;
+	if (env->subprog_info[subprog].might_unwind) {
+		verbose(env, "subprog %d may unwind and is used as a callback\n", subprog);
+		return -EINVAL;
+	}
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
 		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",
@@ -11386,6 +11392,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			}
 		}
 
+		if (env->subprog_info[subprog].ret_unwind)
+			mark_reg_unknown(env, caller->regs, BPF_REG_UNWIND);
+
 		if (env->subprog_info[subprog].might_throw) {
 			struct bpf_verifier_state *branch;
 
@@ -11879,6 +11888,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			caller->regs[regno] = callee->regs[regno];
 			bpf_diag_mod_end(env);
 		}
+		if (subprog_info(env, callee->subprogno)->ret_unwind)
+			caller->regs[BPF_REG_UNWIND] = callee->regs[BPF_REG_UNWIND];
 	}
 
 	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
@@ -22135,6 +22146,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
+		/* Neither a trampoline that calls the subprog nor an extension keeps r3. */
+		if (aux->func && subprog && aux->func[subprog]->aux->ret_unwind &&
+		    prog->expected_attach_type != BPF_TRACE_FENTRY) {
+			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (conservative) {
@@ -23432,15 +23449,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
 	env->arena_scalar = attr->prog_flags & BPF_F_ARENA_SCALAR;
 
-	env->explored_states = kvzalloc_objs(struct list_head,
-					     state_htab_size(env),
-					     GFP_KERNEL_ACCOUNT);
-	ret = -ENOMEM;
-	if (!env->explored_states)
-		goto skip_full_check;
-
-	for (i = 0; i < state_htab_size(env); i++)
-		INIT_LIST_HEAD(&env->explored_states[i]);
 	INIT_LIST_HEAD(&env->free_list);
 
 	/* Prepare BTF and func_info needed to discover all subprograms. */
@@ -23483,6 +23491,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* After everything above has recorded insn offsets, so the patches adjust them. */
+	ret = bpf_exc_lower(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	env->explored_states = kvzalloc_objs(struct list_head,
+					     state_htab_size(env),
+					     GFP_KERNEL_ACCOUNT);
+	ret = -ENOMEM;
+	if (!env->explored_states)
+		goto skip_full_check;
+
+	for (i = 0; i < state_htab_size(env); i++)
+		INIT_LIST_HEAD(&env->explored_states[i]);
+
 	/* Build kfunc prototypes after resolving program resources. */
 	ret = add_kfuncs(env);
 	if (ret < 0)

pw-bot: cr
