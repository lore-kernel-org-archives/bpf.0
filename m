Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937127;
	b=TA+0CQ/ppwEM1wQBMDtfTW1p6KDEEVlJ9QfjGVcimZS62j+Q08W6L3GHc47ctvX3W25I
	 rxcOU2N6WqXfr43UroD3PB3hSPjJsidW2ayfn4mW06IQjY2TzVCqPOCRZDmMcGVfC0zcx
	 p7Iyh+Nlfr/bMga2nVVC3ERM7osayzSFndpRmNrZgFv2VEx8bBLWu2J07IX5Ky9Hi0ihU
	 aQgeVaWHNepNBa95URto1lbxh3RNTPnpAVf/DKync9zEBeSLfGq39ABDSp/CxVlrWy7IE
	 ZaA3UskMhN6fBDoxWJbBvGV+nGaPO21qXAz/r1a/FMziwOSIW0XUQzsNJBhJ80TzWzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yQoJTz50Yx2Yyhcbwsr6pKD0oN8CtlXnaeC4KwZ4wD4=;
	b=vjjN6XyxVYp+w0usGiReXU4qPZabdADYEnnSXHCW0l3y5vzGgoYDWav28apQyuzuYSOc
	 QV6ZLyGhd/Ezfw0nBQUso43uJiD4fpiYbV/Ks/hmI85bntOioYaIHMtauiVU4mXwoPp7I
	 DMZmyeQsF0mWVXjtQymuCieAew/YtKjsl7cPCl4OIvETickVMmqv6Wfw2+LrNkBAT0Wqp
	 bND4OsGqq6Zp9lMprnXR3TRaqrmNYmhsNzOe/Lio3s5H9BL9oRT+Df9dXNmbVkgLk8hxY
	 5iK0JC/rb9bUJNJNqwgx30lJH2mP6ZUqt54xQZtZ4t1nBWm4TlpqW2//N5zabRN6IfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R+X6+tyM;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4A606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R+X6+tyM
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so138644a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937126; x=1794541926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQoJTz50Yx2Yyhcbwsr6pKD0oN8CtlXnaeC4KwZ4wD4=;
        b=R+X6+tyMtu/5yay2ULoRCwt/OoQsBneHXKSsh2esGBScFYAdjU5uLsXy7XRyhNuB5F
         +nZYQuWkph5KEOJxsOZe1Xpcz7e+vt+gacuGztKkFE0q7/AfZa6xEY9m+D7sWuYHNTu1
         xqjhYc5vquDO1+VV+zte22yB2ja1Z4WIXjXS4Hrw7JTugzeMobk9/9YoqMlNJpVdw8/V
         LEoMFe5yc2NLRPikyuBgekyhQAdK3cVtZoWrwsRZOJPRru+aPxF57FTOtjK0+k0DJPjP
         LrBDR2oSSBnliJP0clnpab7oq2imxNrxZyH+RXbuqmZiciNgf2HuIsvg/sVvDH+6ldY4
         bRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937126; x=1794541926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yQoJTz50Yx2Yyhcbwsr6pKD0oN8CtlXnaeC4KwZ4wD4=;
        b=ZhVt9z+cnldQYlc+NzqMzVxVyQRn3UhKznKI+yksLjTqXcMt5nYb2v1+bpkBf5Yp7L
         JyOK9oh0zgyzRmuudWHF95/J16f7pgeQM16aRrnRoYHM9hiZyqs86OjiJAhdJjp6UXTd
         M8XpuIom1MNmuCcyWf4qnqxpDqWXli3Hqfw+vwI6Y4pYjjz1s7IZhxCpmZETP7HLnJlB
         /F/oDYfi6OxDRSvYR/Q6k62+lfRWXPjDlW9eSZXZdAzfcEs/Z7Qm6tBnXdxS4iJ2ITfr
         1J95ufn5VRy83gU09qLf5oZveOiErIX1DFtExT0CMorYFlBfjHhRDEm1NncUskE5Qwu5
         LE+w==
X-Gm-Message-State: APuU4Z9k+l1E9UHFHvC5sYE1dxE1yti1Ur6RG5IRchRwnjQ43UVFzjXI
	SvWkAOzMeo9kLxaT9LF347127kiJcLX8r4INZOMTMP0MdLwLulZPYt94zH1xVg==
X-Gm-Gg: AYBFou2HuNaWq6rXpdQUH2mgWe1qgaimLboyFVXskHpWY+vvkAVpXv+fqEMKw1mvaa+
	J2XGZg8/sYEPLQlmI3zVJnPR2QtehoDreh5p0wFo88iDWEMIYfJiy009WFL+B+pEetMaJ1tWRlT
	1dzEVr2gbiH2ljZzKhLusTicdOdrhjKLdAX9ikPYM4cyyBcANxXPmQIA+78kp6+FkpTQGJvBGBG
	t6aZUkE4ZndIGdTgPDu7y4rZx8tLvyXFxBXjlamArlAj9G4XIg+Qso7q5pUgPK9SDYC4ad7Mwqm
	mYXMj14GcHw9yiPk0cCcjic+TVHFQ7qWsUk1Kv9uE282ZxY288yyBKtESI/gtJJMRGVld6z0Ie1
	9TqDikO7JaZZsD4+en7TPViRAA1R7JNZKqIaOV+RlM5b8q3J5ILFjtMFI63r4tFXEVFU1d+nQX5
	E8Ruio0/z5WIm2ZheWd573BBNQX/cbG1iiTlwJHzXwCNZbds2jLqXwFpQXei+DjWQ9GzZerXK18
	A6RVRvZ4x4qsIMTB1mzdLWn3iXTawsgSTmX0ffmLusvNi/FIjhykeT2B8CEnEChICiw+FYADnU/
	zI3gld+OZ+kzGYEXKIL7L1v1Hn/NDAA4Q9C7Te2Od2+N2mesqcfHaT8q5m1DzVT+cgn7YLWJEvj
	ikf15/G1Bv1nRZtdFrBLFxHG64+T3qEGIoNL04MKo1vmgxnFOuZpbed2PHI4PSjiqge/52rYQbz
	w5aC3JTRCVGuqEiaWU1i8=
X-Received: by 2002:a17:90b:554d:b0:3ac:bfa7:b079 with SMTP id 98e67ed59e1d1-3b0db5edb73mr1308391a91.7.1793937125985;
        Thu, 05 Nov 2026 19:52:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c8ff96sm1513209a91.13.2026.11.05.19.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:52:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 09/45] bpf: Find the registers that hold a number or a pointer to arena
Date: Fri,  6 Nov 2026 03:50:33 +0000
Message-ID: <20261106035111.3315285-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

The allocator of tools/sched_ext/scx_sdt.bpf.c looks for a free slot:

  if ((word & 0xffffffff) == 0) { num += 32; word >>= 32; }
  if ((word & 0xffff) == 0) { num += 16; word >>= 16; }
  ...                                         six times, this is ffs()
  return (i * 64) + ffs(freeslots);

The main pass joins the two states behind each 'if': num is [0, 32], then
[0, 48]. It must not join two constants that the prog adds to a pointer to
the packet, the context or a kernel object: these need the exact offset.
The states meet before the add, and there the add is only 'r0 += r3'. If r0
can be such a pointer, num stays a constant and each 'if' doubles the
states: up to 256 at an insn, not 2.

  insns processed with this pass, and without it:
  scx_sdt    sdt_init_task                               666       4897
  scx_rusty  rusty_init_task, the same allocator        1404      22884
  all progs of: selftests +23 %, scx +72 %, schedulers of rust-bpf +129 %
  rust-bpf   the main pass rejects rand_ranges_shuffle:
             "more than 1024 states that cannot be joined at insn 393"

bpf_flow_compute_kinds() goes forward through the control flow graph,
before the main pass. In front of each insn it finds the registers, the
stack slots and the stack arguments that hold, on each path to the insn:
 - a scalar or a pointer to arena: no check depends on where it points,
 - that, or a pointer to a map value that has only scalars and that is not
   read-only: only the lowest and the highest offset count,
 - the context: a load through it can give a pointer to the packet.
It starts with 'all is known' and removes what is false on some path, until
nothing changes. The result is plain_regs and value_regs of an insn.

  ALU op other than 64-bit add, sub, mov     scalar, addr_space_cast too
  64-bit add, sub                            what both operands are
  load through a scalar or a map value       scalar
  load through the context                   is_valid_access() tells
  other load                                 scalar if below 8 bytes
  spill and fill through r10, r11            what the prog stored
  helper, kfunc                              from the prototype
  static subprog                             true at all calls, all exits
  global subprog, callback, target of callx  only the context

The result only selects the states that the main pass does not join. If it
takes a pointer for a scalar, a join can reject a valid prog. If it takes
a scalar for a pointer, there are more states. No unsafe prog loads.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 307 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 307 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 0f5acdf1cb94..837d5054c2a3 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -514,3 +514,310 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 	kvfree(seen);
 	return ret;
 }
+
+/*
+ * The places of a function that hold a value: the registers, the arguments on the stack that it
+ * got and those that it hands over, the slots of the stack that struct flow_need has a bit for.
+ */
+enum {
+	FLOW_ARG_IN	= 16,
+	FLOW_ARG_OUT	= FLOW_ARG_IN + MAX_STACK_ARG_SLOTS,
+	FLOW_SLOT	= 64,
+	FLOW_PLACES	= 128,
+};
+static_assert(FLOW_ARG_OUT + MAX_STACK_ARG_SLOTS <= FLOW_SLOT);
+
+enum flow_kind {
+	FLOW_IS_PLAIN,	/* a number or a pointer to arena: nothing checks where it points to */
+	FLOW_IS_VALUE,	/* that, or a pointer to a map value that holds nothing but numbers */
+	FLOW_IS_CTX,	/* the context, as the prog or a global function got it */
+	FLOW_KINDS,
+	FLOW_IS_OTHER = FLOW_KINDS,
+};
+
+/* What the places hold for sure in front of an insn */
+struct flow_kinds {
+	unsigned long is[FLOW_KINDS][BITS_TO_LONGS(FLOW_PLACES)];
+};
+
+static void flow_kind_set(struct flow_kinds *k, u32 place, enum flow_kind kind)
+{
+	int i;
+
+	for (i = 0; i < FLOW_KINDS; i++)
+		__assign_bit(place, k->is[i], i == kind);
+	if (kind == FLOW_IS_PLAIN)
+		__set_bit(place, k->is[FLOW_IS_VALUE]);
+}
+
+static void flow_kind_copy(struct flow_kinds *to, u32 place, const struct flow_kinds *from,
+			   u32 from_place)
+{
+	int i;
+
+	for (i = 0; i < FLOW_KINDS; i++)
+		__assign_bit(place, to->is[i], test_bit(from_place, from->is[i]));
+}
+
+/* What holds on both ways to an insn. Returns true if that is less than before. */
+static bool flow_kinds_meet(struct flow_kinds *to, const struct flow_kinds *from)
+{
+	unsigned long lost = 0;
+	int i, j;
+
+	for (i = 0; i < FLOW_KINDS; i++) {
+		for (j = 0; j < ARRAY_SIZE(to->is[i]); j++) {
+			lost |= to->is[i][j] & ~from->is[i][j];
+			to->is[i][j] &= from->is[i][j];
+		}
+	}
+	return lost;
+}
+
+/* The first insn of a function that is called from @k */
+static bool flow_kinds_enter(struct flow_kinds *to, const struct flow_kinds *k)
+{
+	struct flow_kinds e = {};
+	int i;
+
+	/* r12 points to arena. The rest is not set. */
+	bitmap_fill(e.is[FLOW_IS_PLAIN], FLOW_PLACES);
+	bitmap_fill(e.is[FLOW_IS_VALUE], FLOW_PLACES);
+	flow_kind_set(&e, BPF_REG_FP, FLOW_IS_OTHER);
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+		flow_kind_copy(&e, i, k, i);
+	for (i = 0; i < MAX_STACK_ARG_SLOTS; i++)
+		flow_kind_copy(&e, FLOW_ARG_IN + i, k, FLOW_ARG_OUT + i);
+	return flow_kinds_meet(to, &e);
+}
+
+/* The place that @insn loads from or stores to through r10 or r11, -1 if it's something else */
+static int flow_mem_place(const struct bpf_insn *insn, u8 base)
+{
+	int n = (abs(insn->off) - 1) / BPF_REG_SIZE;
+
+	if (!insn->off)
+		return -1;
+	if (base == BPF_REG_FP && insn->off < 0 && n < 64)
+		return FLOW_SLOT + n;
+	if (base == BPF_REG_PARAMS && n < MAX_STACK_ARG_SLOTS)
+		return (insn->off < 0 ? FLOW_ARG_OUT : FLOW_ARG_IN) + n;
+	return -1;
+}
+
+static enum flow_kind flow_map_value_kind(const struct bpf_map *map)
+{
+	if (map->map_type == BPF_MAP_TYPE_ARENA)
+		return FLOW_IS_PLAIN;
+	/* what is at a known offset of a read-only map is known: a number, a string, a function */
+	if (map->map_flags & BPF_F_RDONLY_PROG)
+		return FLOW_IS_OTHER;
+	return IS_ERR_OR_NULL(map->record) && !map->inner_map_meta ? FLOW_IS_VALUE : FLOW_IS_OTHER;
+}
+
+/* What @insn loads through the register @base */
+static enum flow_kind flow_loaded_kind(struct bpf_verifier_env *env, const struct flow_kinds *k,
+				       const struct bpf_insn *insn, u8 base)
+{
+	struct bpf_insn_access_aux info = { .reg_type = SCALAR_VALUE };
+	int size = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	bool tstamp = env->prog->tstamp_type_access, valid;
+
+	/* a number that is good for a load is an address in arena */
+	if (test_bit(base, k->is[FLOW_IS_VALUE]))
+		return FLOW_IS_PLAIN;
+	/* only the context has pointers that are shorter than a register */
+	if (!test_bit(base, k->is[FLOW_IS_CTX]))
+		return size < BPF_REG_SIZE ? FLOW_IS_PLAIN : FLOW_IS_OTHER;
+	valid = env->ops->is_valid_access &&
+		env->ops->is_valid_access(insn->off, size, BPF_READ, env->prog, &info);
+	/* it notes what the prog reads, and this is a question */
+	env->prog->tstamp_type_access = tstamp;
+	return valid && info.reg_type == SCALAR_VALUE ? FLOW_IS_PLAIN : FLOW_IS_OTHER;
+}
+
+/* What a helper or a kfunc returns */
+static enum flow_kind flow_returned_kind(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	const struct bpf_func_proto *fn;
+	struct bpf_call_arg_meta meta;
+	const struct btf_type *t;
+
+	if (bpf_pseudo_kfunc_call(insn)) {
+		if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
+			return FLOW_IS_OTHER;
+		t = btf_type_skip_modifiers(meta.btf, meta.func_proto->type, NULL);
+		if (!btf_type_is_ptr(t))
+			return FLOW_IS_PLAIN;
+		/* void * is a number, unless the verifier knows the kfunc. Such kfunc may fail. */
+		t = btf_type_skip_modifiers(meta.btf, t->type, NULL);
+		return btf_type_is_void(t) && !(meta.kfunc_flags & KF_RET_NULL) ? FLOW_IS_PLAIN :
+										  FLOW_IS_OTHER;
+	}
+	if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
+		return FLOW_IS_OTHER;
+	if (fn->ret_type == RET_INTEGER || fn->ret_type == RET_VOID)
+		return FLOW_IS_PLAIN;
+	if (base_type(fn->ret_type) == RET_PTR_TO_MAP_VALUE &&
+	    (aux->const_reg_map_mask & BIT(BPF_REG_1)))
+		return flow_map_value_kind(env->used_maps[aux->const_reg_vals[BPF_REG_1]]);
+	return FLOW_IS_OTHER;
+}
+
+/*
+ * @k is what holds in front of the insn at @idx. Make it what holds behind it.
+ * @ret: the registers that are FLOW_IS_PLAIN at all exits of a subprog.
+ * Returns true if less is known than before at the entry or about the exits of a subprog.
+ */
+static bool flow_kinds_step(struct bpf_verifier_env *env, struct flow_kinds *kinds, u16 *ret,
+			    struct flow_kinds *k, int idx)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+	u8 dst = insn->dst_reg, src = insn->src_reg;
+	bool wide = BPF_SIZE(insn->code) == BPF_DW && BPF_MODE(insn->code) == BPF_MEM &&
+		    !(insn->off % BPF_REG_SIZE);
+	bool lost = false;
+	u16 regs = U16_MAX;
+	int i, s;
+
+	if (class == BPF_ALU64 && (op == BPF_ADD || op == BPF_SUB)) {
+		__clear_bit(dst, k->is[FLOW_IS_CTX]);
+		for (i = 0; BPF_SRC(insn->code) == BPF_X && i < FLOW_IS_CTX; i++)
+			if (!test_bit(src, k->is[i]))
+				__clear_bit(dst, k->is[i]);
+	} else if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && !insn->off) {
+		flow_kind_copy(k, dst, k, src);
+	} else if (class == BPF_ALU || class == BPF_ALU64) {
+		/*
+		 * addr_space_cast too. It leaves a pointer that is not in arena as it is, and
+		 * a compiler casts what it cannot know. Nearly all of that is in arena.
+		 */
+		flow_kind_set(k, dst, FLOW_IS_PLAIN);
+	} else if (class == BPF_LDX) {
+		s = flow_mem_place(insn, src);
+		if (wide && s >= 0)
+			flow_kind_copy(k, dst, k, s);
+		else
+			flow_kind_set(k, dst, flow_loaded_kind(env, k, insn, src));
+	} else if (class == BPF_STX || class == BPF_ST) {
+		i = bpf_atomic_load_reg(insn);
+		if (i >= 0)
+			flow_kind_set(k, i, flow_loaded_kind(env, k, insn,
+						insn->imm == BPF_LOAD_ACQ ? src : dst));
+		s = flow_mem_place(insn, dst);
+		if (class == BPF_STX && wide && s >= 0)
+			flow_kind_copy(k, s, k, src);
+		else if (s >= 0)
+			flow_kind_set(k, s, FLOW_IS_PLAIN);
+	} else if (bpf_is_ldimm64(insn)) {
+		if (src == BPF_PSEUDO_MAP_VALUE || src == BPF_PSEUDO_MAP_IDX_VALUE)
+			flow_kind_set(k, dst, flow_map_value_kind(
+					env->used_maps[env->insn_aux_data[idx].map_index]));
+		else
+			flow_kind_set(k, dst, src ? FLOW_IS_OTHER : FLOW_IS_PLAIN);
+	} else if (insn->code == (BPF_JMP | BPF_EXIT) && !bpf_is_unwind_exit(insn)) {
+		s = bpf_find_containing_subprog(env, idx) - sub;
+		lost = ret[s] & ~k->is[FLOW_IS_PLAIN][0];
+		ret[s] &= k->is[FLOW_IS_PLAIN][0];
+	} else if (class == BPF_LD || (class == BPF_JMP && op == BPF_CALL)) {
+		s = bpf_pseudo_call(insn) ? bpf_find_subprog(env, idx + insn->imm + 1) : -1;
+		if (s >= 0 && !bpf_subprog_is_global(env, s)) {
+			lost = flow_kinds_enter(&kinds[sub[s].start], k);
+			regs = ret[s];
+		} else if (bpf_is_callx(insn)) {
+			regs = 0;
+		}
+		/* a subprog may return a pair in R0 and R2, the rest is not set */
+		regs |= ~(BIT(BPF_REG_0) | BIT(BPF_REG_2));
+		for (i = BPF_REG_0; i <= BPF_REG_5; i++)
+			flow_kind_set(k, i, regs & BIT(i) ? FLOW_IS_PLAIN : FLOW_IS_OTHER);
+		for (i = 0; i < MAX_STACK_ARG_SLOTS; i++)
+			flow_kind_set(k, FLOW_ARG_OUT + i, FLOW_IS_PLAIN);
+		if (bpf_helper_call(insn) || bpf_pseudo_kfunc_call(insn))
+			flow_kind_set(k, BPF_REG_0, flow_returned_kind(env, idx));
+	}
+	return lost;
+}
+
+/*
+ * Find the registers that hold a number or a pointer to arena, and those that point to the value
+ * of a map that holds nothing but numbers at worst, whichever way the prog gets to an insn:
+ * plain_regs and value_regs of struct bpf_insn_aux_data. The others may hold any pointer.
+ *
+ * Forwards, from "all is known" down, until nothing changes. Arguments go from the callers to
+ * the callees and results the other way, so the subprogs are looked at in both orders in turn.
+ *
+ * Nothing depends on it but which states are kept apart. A pointer that is taken for
+ * a number costs a rule. A number that is taken for a pointer costs states. So it's fine to
+ * miss a store through a pointer to the stack, and to take what callx calls for unknown.
+ *
+ * The edges that the verifier adds, see bpf_head_guard_target(): may_goto at the head of a loop
+ * takes what holds there to its target. A subprog that is out of budget goes to an exit with 0
+ * in place of the result, a number.
+ */
+int bpf_flow_compute_kinds(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	int len = env->prog->len, cnt = env->subprog_cnt, i, j, n, s, t, idx, err = 0;
+	struct flow_kinds *kinds, k = {};
+	struct bpf_iarray *succ;
+	bool lost = true;
+	u16 *ret;
+
+	kinds = kvmalloc_array(len, sizeof(*kinds), GFP_KERNEL_ACCOUNT);
+	ret = kvmalloc_array(env->subprog_cnt, sizeof(*ret), GFP_KERNEL_ACCOUNT);
+	if (!kinds || !ret) {
+		kvfree(kinds);
+		kvfree(ret);
+		return -ENOMEM;
+	}
+	memset(kinds, 0xff, len * sizeof(*kinds));
+	memset(ret, 0xff, env->subprog_cnt * sizeof(*ret));
+
+	/* what the kernel, a helper, callx or another prog calls: only the context is known */
+	for (s = 0; s < env->subprog_cnt; s++) {
+		if (s && !bpf_subprog_is_global(env, s) && !sub[s].addr_taken)
+			continue;
+		flow_kinds_enter(&kinds[sub[s].start], &k);
+		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
+			if (sub[s].args[i].arg_type == ARG_PTR_TO_CTX ||
+			    (!s && !i && env->prog->type != BPF_PROG_TYPE_EXT))
+				flow_kind_set(&kinds[sub[s].start], BPF_REG_1 + i, FLOW_IS_CTX);
+	}
+
+	for (n = 0; lost; n++) {
+		lost = false;
+		/* a chain of calls takes a round for each link */
+		if (signal_pending(current)) {
+			err = -EAGAIN;
+			break;
+		}
+		cond_resched();
+		for (j = 0; j < cnt; j++) {
+			/* it has callees first */
+			s = env->subprog_topo_order[n & 1 ? j : cnt - 1 - j];
+			for (i = sub[s + 1].postorder_start; i-- > sub[s].postorder_start;) {
+				idx = env->cfg.insn_postorder[i];
+				k = kinds[idx];
+				lost |= flow_kinds_step(env, kinds, ret, &k, idx);
+				succ = bpf_insn_successors(env, idx);
+				iarray_for_each(t, succ)
+					lost |= flow_kinds_meet(&kinds[t], &k);
+				t = bpf_head_guard_target(env, idx);
+				if (t >= 0)
+					lost |= flow_kinds_meet(&kinds[t], &kinds[idx]);
+			}
+		}
+	}
+	for (i = 0; i < len; i++) {
+		env->insn_aux_data[i].plain_regs = kinds[i].is[FLOW_IS_PLAIN][0];
+		env->insn_aux_data[i].value_regs = kinds[i].is[FLOW_IS_VALUE][0];
+	}
+	kvfree(kinds);
+	kvfree(ret);
+	return err;
+}
-- 
2.55.0

