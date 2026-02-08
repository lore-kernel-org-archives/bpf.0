Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B3946A
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770568453; cv=none; b=mYoWfh2dCEWGEu8ENZgErS7odG+JCcyxW4OEEZ7hW3u49F8Jy1D3MbIWfRYre07JI0d4RSOombAHF107+XZ9OiyGAq3VUQrIMBNfcXth2z2xtW4fHyk71OY9ilhGy+Pmhy3gdfAtTnvar3edcG9zeJW/MJQOhaT081WYaUfNhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770568453; c=relaxed/simple;
	bh=7gjx6cr+PGu/P24fUbnGfEOtuG0cRu/9DFY/irh7P4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXMF6t8bG6sUdRJb2R76PD6IuOt9nibp8z56yljitA5pjwEgDxe7Ku0adshHB5ajKgonHzHUU8wCwakquinsF7Hrh4pxTLySbOuNkvKwubZVu0KYoX/s6oL7Egb0P2Cqhc39snqGtsdskPH3+QNPK2WNYk3zZNdaZnlLTLjo3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAsljgy7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAsljgy7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8244c048d41so1601840b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770568452; x=1771173252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiikWOXI8BM2b6t4oc652K4v5Nr/7wfAQODrHWYhzsM=;
        b=PAsljgy7CZA4byfO9iSLoaio1JOVm1gyhSFFexDt2X+BJQXtrb9/Jh8BlRPV2MHvxP
         CsSoN3jLSwjuCC5Wt9GRajcbD3sn+UMSz6yfypDeec6j1sqxQShtCgAHzlGwXPF9TxAi
         z+S26iSbBZ772E0xR3GbR0PiLiZ2TmUvLb0GTmG4WLiJ2dUlRGm9authaTrLBosGGxZG
         QwJNEavWJPNs/xgzXVkplxMU48ZdV/obpPIxnkCzTY1HJdaYtO8oBcgenEXaWm2Q2JW+
         Yvp/h9eMtTAltTSDzuQJj6keZeCuGuQR4Q8/vKDX2tC08ETJH4ANuqaq++fWS7XC46UU
         2FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770568452; x=1771173252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiikWOXI8BM2b6t4oc652K4v5Nr/7wfAQODrHWYhzsM=;
        b=XvnZ3YNGDUkhLe17EXwLD8Ur15+EfYrK/CYq84BkFgje1PCD7SBy3gDw9Jnv6GBOFb
         BJPynhNs0nUbAlb0iJiLCgXuLLgyClAcrQdLdYFOV6z3lJVyBZgKioI0SbhS1revgjx7
         KC7dttQi37yrPwA7EP7frAepNmtwqEEiPWxdpb5A3aQkDYA5slHYdvC6xZ7/3G5/mHSS
         CDWzAt356wkSISEcd5htJtQR9qIwIx2TR2WTprp/m1SyujT3uolIlEmmPRfT4Ca5H8BX
         7Aq4vrmAvI6ZgGc9eSbDdviKsJ8l8kQXQiqqWdRyfU4g6PJ3F9qU8TMX2VYpacC4PRkL
         A2qg==
X-Gm-Message-State: AOJu0YyBBkMbPe2l4RK6GFJE819v7UtdWRkf8ntRDQCrBBHF2xouHpms
	UOSuofc3tmmHB/8KEXZIdXEt+cSHRqRCnEYh5AyML3WJG3rLYAig10Q/kByWzA==
X-Gm-Gg: AZuq6aKfB0qgF/QoqQbyZeDC+/s1L+uItMdIfyciAv1j2UaTT5ml+/K5rUZNPm0zGzo
	0/HlvJadFPek8b4nTWOs8vI7ARax1wxzfXdYDeYhyc3IStuxZuJ3alPM9wwg5HB0ZOi/JFAOf5j
	aJ3nast9cjVX1H7GlR9IcRx4gBWBkkDorjq1yFcQunlvXOSh24FcJGPrsFW9B43/n3lGYeYaRFw
	ZB2D9jS1Xm9gX0i9P0BZwS354lPhzE4rmuZKnwuxs35LnnO5Z8skeHwEWv06Zm4xgJsZ9QLsFKL
	Z3xQmL5MR22m7XadS4PnOYgRGsV9dssJv6kSNCaqwHn/o2c86EthXY3MbvU02TfN6cPExK2maBI
	k2uBhgi/EICVo8bnMiVP5tp414ynn0/zrQQcdN6HsMqMpXgkeNSkMCD9/sbV2HNjLkzZLaZqWGE
	CQF+YEd9ALrAJB9PiS5CFFeFr/DsgOvIsr4WzaDRFWau8xXyPC2qq1+ibcVqmz3J/mmrwJC3XcE
	rbu29c6Z+qqAjCLW1/f5wkxihEzSL38RK7HciVVudBUmX87NP6681etjJ6T
X-Received: by 2002:a05:6a00:9098:b0:823:120a:d09a with SMTP id d2e1a72fcca58-82441655aa8mr7138124b3a.31.1770568452180;
        Sun, 08 Feb 2026 08:34:12 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418812c5sm7247916b3a.41.2026.02.08.08.34.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Feb 2026 08:34:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	puranjay@kernel.org
Subject: [PATCH bpf-next 1/2] bpf: jne/jeq fork
Date: Sun,  8 Feb 2026 08:34:04 -0800
Message-ID: <20260208163406.14974-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260208163406.14974-1-alexei.starovoitov@gmail.com>
References: <20260208163406.14974-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

TLDR: not worth doing.

When the verifier processes JEQ/JNE against a known constant, the
existing logic in reg_set_min_max() refines:
 - equal branch:     dst_reg = const (exact value)
 - not-equal branch: dst_reg != const (edge-trim only)

The JNE edge-trim only tightens bounds when the constant sits at
a range boundary (e.g. umin == const → umin++). For a register
with range [0, 255] and "if r0 != 100", the not-equal branch
keeps the full [0, 255] range — no useful information is gained.

Improve this by forking the not-equal branch into two sub-states:
 - fork 1: dst > const  (via JGT refinement → e.g. [101, 255])
 - fork 2: dst < const  (via JLT refinement → e.g. [0, 99])

This is implemented by pushing an additional verifier state onto
the exploration stack after reg_set_min_max() and sync_linked_regs()
have already processed the original two branches.

The fork is guarded by feasibility checks requiring both unsigned
and signed ranges to strictly span the constant (umin < val < umax
and smin < val < smax). The signed check prevents infeasible states
from reg_bounds_sync() cross-propagating signed bounds into unsigned
after the JGT/JLT refinement.

For JEQ: the not-equal branch is this_branch (fallthrough), and
fork2 targets the next instruction.
For JNE: the not-equal branch is other_branch (jump target), and
push_stack copies env->cur_state (the equal branch), so dst_reg
in fork2 must be overwritten with the not-equal branch's copy.

Linked registers sharing the same ID are propagated via
sync_linked_regs() on both forks.

File                Program                 Insns (A)  Insns (B)  Insns     (DIFF)
------------------  ----------------------  ---------  ---------  ----------------
scx_beerland.bpf.o  beerland_enqueue              332        361      +29 (+8.73%)
scx_central.bpf.o   central_enqueue                68         74       +6 (+8.82%)
scx_central.bpf.o   central_init                  200        210      +10 (+5.00%)
scx_chaos.bpf.o     chaos_tick                     14         15       +1 (+7.14%)
scx_flash.bpf.o     enable_sibling_cpu            120        113       -7 (-5.83%)
scx_flatcg.bpf.o    fcg_cgroup_init               120        132     +12 (+10.00%)
scx_lavd.bpf.o      lavd_dispatch              218925     237897   +18972 (+8.67%)
scx_lavd.bpf.o      lavd_quiescent                168        191     +23 (+13.69%)
scx_lavd.bpf.o      set_power_profile             167        109     -58 (-34.73%)
scx_layered.bpf.o   layered_dispatch            13909      14480     +571 (+4.11%)
scx_layered.bpf.o   layered_enqueue             13798      24143  +10345 (+74.97%)
scx_layered.bpf.o   layered_runnable             6077       6447     +370 (+6.09%)
scx_layered.bpf.o   layered_select_cpu           2288       3121    +833 (+36.41%)
scx_layered.bpf.o   layered_set_cpumask           238        250      +12 (+5.04%)
scx_layered.bpf.o   layered_stopping              598        643      +45 (+7.53%)
scx_layered.bpf.o   tp_task_rename                 70         73       +3 (+4.29%)
scx_qmap.bpf.o      qmap_select_cpu                52         55       +3 (+5.77%)
scx_rlfifo.bpf.o    rustland_dispatch             340        363      +23 (+6.76%)
scx_rustland.bpf.o  rustland_dispatch             340        363      +23 (+6.76%)
scx_rusty.bpf.o     rusty_set_cpumask            3259       3552     +293 (+8.99%)
scx_userland.bpf.o  userland_enqueue               91         97       +6 (+6.59%)
scx_userland.bpf.o  userland_select_cpu            53         56       +3 (+5.66%)
scxtop.bpf.o        long_tail_tracker_exit        104        119     +15 (+14.42%)
scxtop.bpf.o        start_trace                   127        134       +7 (+5.51%)

Program                                   Insns (A)  Insns (B)  Insns       (DIFF)
----------------------------------------  ---------  ---------  ------------------
bpfj_dns_sendmsg                               6322       8432     +2110 (+33.38%)
bpfj_exec_execve                               4790       4091      -699 (-14.59%)
bpfj_exec_execveat                             4790       4091      -699 (-14.59%)
do_parse                                     157621     688994  +531373 (+337.12%)
do_sendmsg                                   157635     689008  +531373 (+337.09%)
balancer_ingress                              62403      70516     +8113 (+13.00%)
on_py_event                                   88094      76037    -12057 (-13.69%)
on_custom_event_start                         13847      15347     +1500 (+10.83%)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..c9f0c62ab4e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17579,6 +17579,113 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				 &linked_regs);
 	}
 
+	/* For JEQ/JNE with a known constant, fork the not-equal branch
+	 * into dst > const and dst < const for tighter range tracking.
+	 */
+	if ((opcode == BPF_JEQ || opcode == BPF_JNE) &&
+	    dst_reg->type == SCALAR_VALUE) {
+		struct bpf_verifier_state *neq_branch2, *neq_state;
+		struct bpf_reg_state *neq_regs, *neq2_regs;
+		struct bpf_reg_state fake_const;
+		bool can_fork = false;
+		s32 neq_target;
+		u64 val;
+
+		/* Determine which src is the constant */
+		if (BPF_SRC(insn->code) == BPF_K) {
+			val = (u64)(s64)insn->imm;
+			can_fork = true;
+		} else if (is_reg_const(src_reg, is_jmp32)) {
+			val = reg_const_value(src_reg, is_jmp32);
+			can_fork = true;
+		} else if (is_reg_const(dst_reg, is_jmp32)) {
+			/* dst is const — JNE/JEQ is symmetric for forking,
+			 * but we'd fork on src's range. Skip for now.
+			 */
+			can_fork = false;
+		}
+
+		if (can_fork) {
+			/* Identify the not-equal branch and check feasibility */
+			if (opcode == BPF_JEQ) {
+				neq_regs = regs; /* this_branch = fallthrough = != */
+				neq_target = *insn_idx + 1;
+				neq_state = this_branch;
+			} else {
+				neq_regs = other_branch_regs; /* other_branch = jump = != */
+				neq_target = *insn_idx + insn->off + 1;
+				neq_state = other_branch;
+			}
+
+			/* Check that the range spans across the constant.
+			 * Check both unsigned and signed ranges, because
+			 * reg_bounds_sync() may cross-propagate signed
+			 * bounds into unsigned after JGT/JLT refinement,
+			 * creating infeasible states if the signed range
+			 * doesn't also span the constant.
+			 */
+			if (is_jmp32) {
+				can_fork = neq_regs[insn->dst_reg].u32_min_value < (u32)val &&
+					   neq_regs[insn->dst_reg].u32_max_value > (u32)val &&
+					   neq_regs[insn->dst_reg].s32_min_value < (s32)val &&
+					   neq_regs[insn->dst_reg].s32_max_value > (s32)val;
+			} else {
+				can_fork = neq_regs[insn->dst_reg].umin_value < val &&
+					   neq_regs[insn->dst_reg].umax_value > val &&
+					   neq_regs[insn->dst_reg].smin_value < (s64)val &&
+					   neq_regs[insn->dst_reg].smax_value > (s64)val;
+			}
+		}
+
+		if (can_fork) {
+			/* Create a fake const register for regs_refine_cond_op */
+			memset(&fake_const, 0, sizeof(fake_const));
+			fake_const.type = SCALAR_VALUE;
+			__mark_reg_known(&fake_const, val);
+
+			/* Push second fork for the not-equal branch.
+			 * push_stack copies env->cur_state (this_branch).
+			 * For JNE this_branch is the equal branch, so we
+			 * must overwrite dst_reg with the not-equal copy.
+			 */
+			neq_branch2 = push_stack(env, neq_target, *insn_idx, false);
+			if (IS_ERR(neq_branch2))
+				return PTR_ERR(neq_branch2);
+			neq2_regs = neq_branch2->frame[neq_branch2->curframe]->regs;
+			neq2_regs[insn->dst_reg] = neq_regs[insn->dst_reg];
+
+			/* Fork 1 (existing not-equal branch): dst > const */
+			regs_refine_cond_op(&neq_regs[insn->dst_reg],
+					    &fake_const, BPF_JGT, is_jmp32);
+			reg_bounds_sync(&neq_regs[insn->dst_reg]);
+
+			/* Fork 2 (new state): dst < const */
+			memset(&fake_const, 0, sizeof(fake_const));
+			fake_const.type = SCALAR_VALUE;
+			__mark_reg_known(&fake_const, val);
+			regs_refine_cond_op(&neq2_regs[insn->dst_reg],
+					    &fake_const, BPF_JLT, is_jmp32);
+			reg_bounds_sync(&neq2_regs[insn->dst_reg]);
+
+			/* Propagate JGT/JLT bounds to linked registers */
+			if (neq_regs[insn->dst_reg].id) {
+				sync_linked_regs(env, neq_state,
+						 &neq_regs[insn->dst_reg],
+						 &linked_regs);
+				sync_linked_regs(env, neq_branch2,
+						 &neq2_regs[insn->dst_reg],
+						 &linked_regs);
+			}
+
+			err = reg_bounds_sanity_check(env,
+					&neq_regs[insn->dst_reg], "neq_gt");
+			err = err ?: reg_bounds_sanity_check(env,
+					&neq2_regs[insn->dst_reg], "neq_lt");
+			if (err)
+				return err;
+		}
+	}
+
 	/* if one pointer register is compared to another pointer
 	 * register check if PTR_MAYBE_NULL could be lifted.
 	 * E.g. register A - maybe null
-- 
2.47.3

