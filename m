Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911576;
	b=wDHsMAN56ls+Xmrj8G/FILqr5FZuqVF4CofvyRiMgdbTEV1K0LdngGT/0s+buZa2iqEJ
	 DNFUxxtaqzP8E5hot3qVeNOILIAbPrXiQLA96+Wf7H347P1WVksX3V12K7/keNQ3rcPh+
	 U6i9dG8QsmBR+vYHfvtk+10nceE4wFakwCcEfgpwYnmHqMwUv+1QbaavM8IrULtIvLAkE
	 MdKZidvlAz+LMNe9qQ1eI6fGR/LNflqGzJ5jIz5gyflvX0R7UcE7pP9ajGrx+rpCNUtWT
	 iwxrc4dYlmz6EXT4aqCe2y77qpp/qbt34Gcu8QyYhIPW5BVXy6cvn/gkCibaO1xQuoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aQtUVe34/g0/ggtw2Inm9cVIrEbln1O4sKMZP1LVS6E=;
	b=ghYYboXPh75Bdmu5/pOV0wDUFepLNZaOnPcOqLyJAZhr/8LKwlsPC1WQaNOyv0Vxi1OV
	 cPC2W1wO/2COoWM/rt71iEms2hyQ5g1QSLBNbhd1uNboToJSE6mmrAjol6GoknU8Nl0JH
	 UOUw1m7L06EZ0FXB5bVuiooCKoadhAtlbPDhdSHppJzzlXP3uQZ/3yvjZRHSyp+jxxd/3
	 IIOnmsY9zMH4GApc+GWnPbe1wQhKbCfP1h2MTLQNB/6XytlhmxiU8zxjE96mxyY5eMYha
	 Lz2d7i/gBlqY2RmAXcm8SVQrcegSyqdzR0zRWJWIEHj3Ja1/4FbGBO96UW0fRamcDDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0oHThgEV;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C4606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0oHThgEV
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd3310348d2so491884a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911575; x=1794516375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQtUVe34/g0/ggtw2Inm9cVIrEbln1O4sKMZP1LVS6E=;
        b=0oHThgEVkVuuAfSEJqLM1mgJ3SFLBnr6b6FKt1eWVwQQiFLZFZBw9h4tRgs1UXu2Wt
         PxPR+Wkx6V/NmZMB41ZnzgWQ28EljtVEYeEL91vH5R4uZ2iMKlTpzi113gph/jvAeUwq
         1NfdCuLxmU3GiJ6mcecOW5M2bpKB52mF9fkajWx6iBezjMxdKSmggg/QtezE/d3nUjh4
         +N7IYvJLt9PXFMCgNLiZFFRnqDG7U248fM4cy5SQBA9l/B7cLgrwsphYl5ru4EJUV44R
         Oh2sgXSBQTlaXXpbHrYIsW/64+whP3Ra3v44zxhVyVC6Zhq9DTV6N1KWYs5FHlLsGubO
         g8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911575; x=1794516375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQtUVe34/g0/ggtw2Inm9cVIrEbln1O4sKMZP1LVS6E=;
        b=wYL4Q2Sel/HKGVU42vVT6on+3owSE1eXpNNxQucu9SXRNbFYgYWFPaQ0Apsm7vwnYQ
         HlNMYZEScxAF8iZt3wO01bvpMgNiwwCl3/qPQN1pxzY3UPWvJolpF+COtaUo+w6bbHYY
         uvc9n6Zr+9RE/x9UJdox7JiYMv6u0JlTWoxtASAaM72/H/SR71z8pL/i5LlON3Ke8Vcx
         w5s/Nr7YWwPf0UXlEPGgD6kK61Gtk0FTKfm4XAHj+g4n1dsDpZmUeU+5h+efciaXfoNG
         qYItNwyyZz2coK0KGaHbVg0d8QRjBJAv1k/YbADk/UqrPRYm6Nj/brdxsPcSmDbSm8ZH
         Adgw==
X-Gm-Message-State: APuU4Z++OslwloW07OnIuSo1O6aVJViYveM09EWb0E0E/znnylzgzePQ
	7dTfZRUPOOdWbVwNN7eEkal8o2TAujKTStVRjcUkXAUahiwVm8sv1l+cPlKAEw==
X-Gm-Gg: AYBFou3A4kv/4yR/H3tnPbKrBpY1w8byEEHCDDi7ASyhOZmIWumB6fMKCmCy+Az1iXk
	uIuPl8wlbJS+UC1T4acFmWwr/Vit/0riJkjmm3OVB2pm5WVsq+j5CHQcXACdOfpKmwmGQFLwTSp
	Im+DyU67O4RzNt+QIGlDjhgf0j2pJOejYxfhKMZZY2OylmCxxYJL/+SIG/TNg0IptPwq40JPofN
	Md8qNw/+g20bruQK4f/buY+oHgCWd/EbFNVmSDCizAJ4Ea7EAnXvz0TPCq9gD5QSkaTdJLzTBfK
	dVmIrsABFwTg899bUqVMEvuiDNhGxNPUJCBT9EMuXuDMpJm7V44lNpMWIhSv7ouOx8aQnEWwSAq
	xuRV6oa9y7B9LPxfyqgxjqsmnBhWQz7BQlgexIDTvc4foGHrYU6dr+KLKbbIU80MjqGMq+5C7Hl
	64zcAofOXkmrAXaq9kQ/NFPDD61kQK21NSAHWbcuhCu+34NA2WnxivqgHKUgzz288Gy5PU3HiMl
	UzjTLxFffusJNrhPCr4Xaa/kF55mtez8llj758Oc1XXCzQkuyYEa8HU9crkwR/ijpTLnooMc57J
	9g4cfD6Vd5NMMNTIrFP6L7nfC/E2SPhMW/6qhA+NZCLhdOIkizrjBvIOa+KckiU3zQi3sAJB1ys
	cq5jknxAQ22n+HA5sdEVwU4u1uuAD2W1Crh0ghTkgUHTwco4d01XCG3AA+ols4tTgnm7CIRCbPg
	==
X-Received: by 2002:a17:90b:5282:b0:3b0:a413:dd8e with SMTP id 98e67ed59e1d1-3b0db712d37mr107074a91.43.1793911574588;
        Thu, 05 Nov 2026 12:46:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c8ef38sm586467a91.12.2026.11.05.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 10/35] bpf: Find the registers and stack slots that later checks depend on
Date: Thu,  5 Nov 2026 20:44:47 +0000
Message-ID: <20261105204513.2230344-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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

The join of two constants is not a constant, and some checks need one. The
two states meet before the insn that checks. Thus the verifier must know,
where they meet, that a later check depends on a register or a stack slot.
A table per kind of check, FLOW_NEED_*, tells the rules that refuse a join:

ARG        an argument that must be a constant
    if (x) return bpf_rdonly_cast(0, ID); return bpf_rdonly_cast(0, 0);
  The compiler makes one call of it: "R2 must be a known constant" in
  selftest mem_rdonly_untrusted/mixed_mem_type.
STACK_OFF  an add to a pointer to the stack
    if (... || depth >= BT_MAXLVL_PRINT) return 0; ind = stack[depth];
  The compiler tests one copy of depth and adds another. bt_print() of scx:
  "invalid variable-offset read from stack R3"
PTR_OFF    an add to a pointer to the packet, the context, a kernel object,
           a map value that is read-only or has a timer, a lock, a pointer
    if (data + hdr_len + inner_ip_offset > data_end) return TC_ACT_UNSPEC;
    inner_protocol = inner_iph->protocol;
  With [20, 40] as the offset the test tells nothing about data + hdr_len:
  "invalid access to packet, off=48 size=1" in katran/tcdecapinfo.
JUMP       a jump that compares with a constant, an argument or a return
           value that the verifier compares with a range
    if (ret < 0) ..; to_sport = state->to_sport;
  ret is a negative constant where state can be NULL. As a part of a range
  it passes the test: "R3 invalid mem access 'map_value_or_null'" in
  tail_handle_snat_fwd_ipv4 of Cilium.

Three more tables are only for bpf_flow_is_needed(): does a check depend
on a value that a counted loop changes and that has no closed form? If not,
the value is an unknown scalar in the loop, and the verifier has no reason
to walk the iterations one by one:

    for (int i = 0; i < STACK_MAX_LEN; ++i) {
      if (!frame_ptr || !get_frame_data(frame_ptr, pidData, &frame, &sym))

Each iteration fills the 24 stack slots of sym anew, and no check looks at
them. pyperf600_nounroll takes 1241 insns, 154K with a walk of all 600.

VALUE_OFF  PTR_OFF, STACK_OFF, and an offset in each other map value
BASE       the address of a load or a store
JUMP_ALU   JUMP, and the values that the tested value is calculated from

flow_compute_need_const() goes backward through the control flow graph
until nothing changes, like the calculation of live registers. A use that
it misses can reject a valid prog. It cannot accept an unsafe prog.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 324 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 837d5054c2a3..1eecd9ee5123 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -515,6 +515,74 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 	return ret;
 }
 
+/* The slot that @insn spills to or fills from, if it's one that struct flow_need has a bit for */
+static int flow_fp_slot(const struct bpf_insn *insn, u8 base)
+{
+	u8 mode = BPF_MODE(insn->code);
+
+	if (base != BPF_REG_FP || (mode != BPF_MEM && mode != BPF_MEMSX) ||
+	    insn->off >= 0 || insn->off < -64 * BPF_REG_SIZE || insn->off % BPF_REG_SIZE)
+		return -1;
+	return -insn->off / BPF_REG_SIZE - 1;
+}
+
+/*
+ * A number is added to a pointer to the stack. A store at an offset that is not known
+ * forgets what the slots it may hit hold, pointers above all.
+ */
+static u16 flow_stack_off_regs(struct bpf_verifier_env *env, int idx)
+{
+	u16 ptrs = env->insn_aux_data[idx].stack_ptrs;
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 op = BPF_OP(insn->code);
+
+	if (BPF_CLASS(insn->code) != BPF_ALU64 || BPF_SRC(insn->code) != BPF_X ||
+	    (op != BPF_ADD && op != BPF_SUB))
+		return 0;
+	if ((ptrs & BIT(insn->dst_reg)) && !(ptrs & BIT(insn->src_reg)))
+		return BIT(insn->src_reg);
+	if (op == BPF_ADD && (ptrs & BIT(insn->src_reg)) && !(ptrs & BIT(insn->dst_reg)))
+		return BIT(insn->dst_reg);
+	return 0;
+}
+
+/*
+ * A jump that compares a register with a constant, which may be in the other register.
+ * A call does the same: the verifier compares a size, or what bpf_set_retval() takes,
+ * with what is allowed. So does the exit of the prog, see flow_compute_need_const().
+ */
+static u16 flow_tested_regs(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	u16 consts = aux->const_reg_mask | aux->const_reg_wide_mask;
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+
+	if (bpf_helper_call(insn) || bpf_pseudo_kfunc_call(insn))
+		return bpf_call_checked_arg_regs(env, insn);
+	if ((class != BPF_JMP && class != BPF_JMP32) ||
+	    op == BPF_JA || op == BPF_CALL || op == BPF_EXIT || op == BPF_JCOND)
+		return 0;
+	if (BPF_SRC(insn->code) == BPF_K || (consts & BIT(insn->src_reg)))
+		return BIT(insn->dst_reg);
+	return consts & BIT(insn->dst_reg) ? BIT(insn->src_reg) : 0;
+}
+
+/* With or without sign extension */
+static bool flow_is_copy(const struct bpf_insn *insn)
+{
+	return BPF_OP(insn->code) == BPF_MOV && BPF_SRC(insn->code) == BPF_X && !insn->imm &&
+	       (!insn->off || insn->off == 8 || insn->off == 16 || insn->off == 32);
+}
+
+static bool flow_is_shift(const struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+
+	return (class == BPF_ALU || class == BPF_ALU64) &&
+	       (op == BPF_LSH || op == BPF_RSH || op == BPF_ARSH);
+}
+
 /*
  * The places of a function that hold a value: the registers, the arguments on the stack that it
  * got and those that it hands over, the slots of the stack that struct flow_need has a bit for.
@@ -821,3 +889,259 @@ int bpf_flow_compute_kinds(struct bpf_verifier_env *env)
 	kvfree(ret);
 	return err;
 }
+
+/*
+ * A number is added to what may be a pointer whose offset the verifier looks at:
+ * - An object of the kernel, the context, a socket take a known offset only.
+ * - The packet: the offset was compared with the end of the packet before the states met.
+ * - The value of a map that has a timer, a lock, a pointer in the middle.
+ * - The value of a read-only map: what is loaded from a known offset is known.
+ * Not a value that holds nothing but numbers. Only the lowest and the highest offset
+ * count there, and the join of two constants has both. @any_value: that one too.
+ */
+static u16 flow_ptr_off_regs(struct bpf_verifier_env *env, int idx, bool any_value)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u16 both = BIT(insn->dst_reg) | BIT(insn->src_reg), ptrs;
+	u8 op = BPF_OP(insn->code);
+
+	if (BPF_CLASS(insn->code) != BPF_ALU64 || BPF_SRC(insn->code) != BPF_X ||
+	    (op != BPF_ADD && op != BPF_SUB) || (aux->stack_ptrs & both))
+		return 0;
+	ptrs = both & ~(any_value ? aux->plain_regs : aux->value_regs);
+	if (op == BPF_SUB)
+		ptrs &= BIT(insn->dst_reg);
+	/* the one that may be the pointer makes the other one the number */
+	return ptrs && ptrs != both ? both ^ ptrs : ptrs;
+}
+
+/* The base of a load or a store, unless it's a number or a pointer to arena for sure */
+static u16 flow_base_regs(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code);
+	u16 regs = 0;
+
+	if (class == BPF_LDX || bpf_atomic_is_load_acq(insn))
+		regs = BIT(insn->src_reg);
+	else if (class == BPF_ST || class == BPF_STX)
+		regs = BIT(insn->dst_reg);
+	return regs & ~env->insn_aux_data[idx].plain_regs & GENMASK(BPF_REG_9, BPF_REG_0);
+}
+
+/*
+ * Some arguments of kfuncs and helpers have to be known constants: the id of a type,
+ * the size of what is reserved in a ring buffer, the size of a slice of a dynptr.
+ * A compiler makes one call of
+ *	if (x) p = bpf_rdonly_cast(q, ID); else p = bpf_rdonly_cast(q, 0);
+ * and one store of
+ *	if (x) a[n++] = p; else b[m++] = p;
+ * where a and b are on the stack.
+ * and one load of
+ *	x = ipv6 ? *(u16 *)(pkt + 54) : *(u16 *)(pkt + 34);	y = z ? task->pid : task->tgid;
+ * The join of two constants is not a constant. Find the registers and the slots of the stack
+ * that end up in such arguments, or in offsets in the stack or from a pointer,
+ * like live registers are found: backwards, until nothing changes.
+ * States in which they differ are not joined.
+ * Nothing depends on it but what is known: it's fine to miss a store through a pointer.
+ *
+ * FLOW_NEED_JUMP: those that a jump ahead compares with a constant, see flow_join_makes_up().
+ * As they are, or extended: without 32-bit insns a compiler tests
+ *	r7 = r8; r7 <<= 32; r7 >>= 32;
+ * and goes on with r8.
+ * A slot that is filled through another pointer to the stack than r10 is not one of them, and
+ * flow_null_differs() counts on that.
+ *
+ * The last three kinds keep no states apart. They are for bpf_flow_is_needed(), which asks
+ * whether anything ahead looks at a number that a loop changes from iteration to iteration.
+ * FLOW_NEED_VALUE_OFF: FLOW_NEED_PTR_OFF, and the offset in a map value that holds nothing but
+ * numbers. It has to be in the value. It can be an argument, or what a function returns:
+ *	return v->hist[count_bits(x)];
+ * So can an offset in the stack. FLOW_NEED_STACK_OFF doesn't follow it through a return, so this
+ * table has it too.
+ * FLOW_NEED_BASE: the base of a load or a store, as it is, behind a cast, moved by a constant:
+ *	p = NULL; for (i = 0; i < 3; i++) { if (p) n += p->len; p = next(); }
+ * FLOW_NEED_JUMP_ALU: FLOW_NEED_JUMP, and what the tested number is made of step by step:
+ *	for (i = 0; i < 3; i++) x /= 10; if (x < 8) ...
+ * In x op= y that is x. y is not followed.
+ * What is stored through a pointer to the stack other than r10 counts as tested. It's a result
+ * for the caller, and no table follows it from the store to the fill:
+ *	count_bits(x, &n); return v->hist[n];
+ * These two go through callx, to every function whose address is taken.
+ */
+static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_need **pneed,
+				   enum flow_need_kind kind)
+{
+	struct bpf_insn *insns = env->prog->insnsi, *insn;
+	struct flow_need in, out, *need;
+	struct bpf_iarray *succ;
+	bool jump = kind == FLOW_NEED_JUMP || kind == FLOW_NEED_JUMP_ALU;
+	bool callx = kind == FLOW_NEED_BASE || kind == FLOW_NEED_JUMP_ALU;
+	bool changed = true, any = false, keep, from_src, reg;
+	int i, s, idx, slot, err = 0;
+	u16 *gen, callx_regs = 0, pair = BIT(BPF_REG_0) | BIT(BPF_REG_2);
+	u8 *ret, class, op;
+
+	need = kvcalloc(env->prog->len, sizeof(*need), GFP_KERNEL_ACCOUNT);
+	gen = kvcalloc(env->prog->len, sizeof(u16), GFP_KERNEL_ACCOUNT);
+	/* the callers need what the subprog returns: r0, and r2 of a pair */
+	ret = kvcalloc(env->subprog_cnt, sizeof(u8), GFP_KERNEL_ACCOUNT);
+	*pneed = need;
+	if (!need || !gen || !ret) {
+		kvfree(gen);
+		kvfree(ret);
+		return -ENOMEM;
+	}
+	for (i = 0; i < env->prog->len; i++) {
+		if (jump)
+			gen[i] = flow_tested_regs(env, i);
+		else if (kind == FLOW_NEED_STACK_OFF)
+			gen[i] = flow_stack_off_regs(env, i);
+		else if (kind == FLOW_NEED_PTR_OFF || kind == FLOW_NEED_VALUE_OFF)
+			gen[i] = flow_ptr_off_regs(env, i, kind == FLOW_NEED_VALUE_OFF);
+		else if (kind == FLOW_NEED_BASE)
+			gen[i] = flow_base_regs(env, i);
+		else if (bpf_helper_call(&insns[i]) || bpf_pseudo_kfunc_call(&insns[i]))
+			gen[i] = bpf_call_const_arg_regs(env, &insns[i]);
+		if (kind == FLOW_NEED_JUMP_ALU && BPF_CLASS(insns[i].code) == BPF_STX &&
+		    insns[i].dst_reg != BPF_REG_FP &&
+		    (env->insn_aux_data[i].stack_ptrs & BIT(insns[i].dst_reg)))
+			gen[i] = BIT(insns[i].src_reg);
+		if (kind == FLOW_NEED_VALUE_OFF)
+			gen[i] |= flow_stack_off_regs(env, i);
+		any |= gen[i];
+	}
+	if (jump) {
+		/* the verifier compares what the prog and its callbacks return with a range */
+		ret[0] = BIT(BPF_REG_0);
+		for (i = 0; i < env->prog->len; i++) {
+			if (!bpf_pseudo_func(&insns[i]))
+				continue;
+			s = bpf_find_subprog(env, i + insns[i].imm + 1);
+			if (s >= 0)
+				ret[s] = BIT(BPF_REG_0);
+		}
+		any = true;
+	}
+	while (any && changed) {
+		changed = false;
+		if (signal_pending(current)) {
+			err = -EAGAIN;
+			break;
+		}
+		cond_resched();
+		for (s = 0; callx && s < env->subprog_cnt; s++)
+			if (env->subprog_info[s].addr_taken)
+				callx_regs |= need[env->subprog_info[s].start].regs;
+		for (i = 0; i < env->cfg.cur_postorder; i++) {
+			idx = env->cfg.insn_postorder[i];
+			insn = &insns[idx];
+			class = BPF_CLASS(insn->code);
+			succ = bpf_insn_successors(env, idx);
+			out.regs = 0;
+			out.slots = 0;
+			for (s = 0; s < succ->cnt; s++) {
+				out.regs |= need[succ->items[s]].regs;
+				out.slots |= need[succ->items[s]].slots;
+			}
+			in = out;
+			if (class == BPF_JMP && BPF_OP(insn->code) == BPF_CALL) {
+				in.regs &= ~GENMASK(BPF_REG_5, BPF_REG_0);
+				if (bpf_is_callx(insn))
+					in.regs |= callx_regs & GENMASK(BPF_REG_5, BPF_REG_1);
+				s = idx + insn->imm + 1;
+				if (bpf_pseudo_call(insn) &&
+				    !bpf_subprog_is_global(env, bpf_find_subprog(env, s))) {
+					if (kind != FLOW_NEED_PTR_OFF)
+						in.regs |= need[s].regs &
+							   GENMASK(BPF_REG_5, BPF_REG_1);
+					s = bpf_find_subprog(env, s);
+					/*
+					 * Not for an index where states are kept apart: that is
+					 * one of many numbers.
+					 */
+					if ((kind == FLOW_NEED_ARG || kind == FLOW_NEED_VALUE_OFF ||
+					     jump) &&
+					    (out.regs & pair & ~ret[s])) {
+						ret[s] |= out.regs & pair;
+						changed = true;
+					}
+				}
+			} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
+				s = bpf_find_containing_subprog(env, idx) - env->subprog_info;
+				in.regs |= ret[s];
+			} else if (class == BPF_LDX || class == BPF_LD) {
+				slot = class == BPF_LDX ? flow_fp_slot(insn, insn->src_reg) : -1;
+				if (slot >= 0 && (out.regs & BIT(insn->dst_reg)))
+					in.slots |= BIT_ULL(slot);
+				in.regs &= ~BIT(insn->dst_reg);
+			} else if (class == BPF_STX || class == BPF_ST) {
+				slot = flow_fp_slot(insn, insn->dst_reg);
+				if (slot >= 0 && (out.slots & BIT_ULL(slot))) {
+					in.slots &= ~BIT_ULL(slot);
+					if (class == BPF_STX)
+						in.regs |= BIT(insn->src_reg);
+				}
+			} else if ((class == BPF_ALU || class == BPF_ALU64) &&
+				   (out.regs & BIT(insn->dst_reg))) {
+				op = BPF_OP(insn->code);
+				reg = BPF_SRC(insn->code) == BPF_X;
+				/* the result is known when what it is made of is */
+				keep = op != BPF_MOV;
+				from_src = reg;
+				if (jump)
+					from_src = flow_is_copy(insn);
+				if (kind == FLOW_NEED_JUMP)
+					keep = flow_is_shift(insn) && !reg;
+				if (kind == FLOW_NEED_BASE) {
+					keep = !reg && (op == BPF_ADD || op == BPF_SUB);
+					from_src = reg && op == BPF_MOV;
+				}
+				if (!keep)
+					in.regs &= ~BIT(insn->dst_reg);
+				if (from_src)
+					in.regs |= BIT(insn->src_reg);
+			}
+			in.regs |= gen[idx];
+			if (in.regs != need[idx].regs || in.slots != need[idx].slots) {
+				need[idx] = in;
+				changed = true;
+			}
+		}
+	}
+	/*
+	 * An offset that is an argument: not through the call, see above, and not where the calls
+	 * meet. A function would be looked at once for each offset that it's called with.
+	 */
+	for (s = 0; kind == FLOW_NEED_PTR_OFF && s < env->subprog_cnt; s++)
+		need[env->subprog_info[s].start].regs = 0;
+	kvfree(gen);
+	kvfree(ret);
+	if (!any) {
+		kvfree(need);
+		*pneed = NULL;
+	}
+	return err;
+}
+
+/*
+ * Does anything ahead of the insn at @idx look at what @r holds there? @r is a register or a stack
+ * slot of the function as scev.c counts them. See flow_compute_need_const(): it's a guess.
+ */
+bool bpf_flow_is_needed(struct bpf_verifier_env *env, int idx, u32 r)
+{
+	const struct flow_need *need;
+	int i;
+
+	/* no table has a bit for it */
+	if (r >= MAX_BPF_REG + 64)
+		return true;
+	for (i = 0; i < FLOW_NEED_KINDS; i++) {
+		need = env->flow->need[i];
+		if (need && (r < MAX_BPF_REG ? need[idx].regs & BIT(r) :
+					       need[idx].slots & BIT_ULL(r - MAX_BPF_REG)))
+			return true;
+	}
+	return false;
+}
-- 
2.55.0

