Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207912;
	b=eBkOfltcYDJRKW5FM2HhC2El5B456OgWdrWrHyevaGUmV4W34sZhg2V3zFg7xjz3oFHZ
	 h/dyOwWI69CpCUMto2DSJnbx8V4dyaA/FKo4AjXLe7OI32btxhNUcpCLgmPNAxkCxgpDm
	 IibNM7li1rv3wZokcUOItLYqAc4eGEM7IE2nVZbPwzym6DQNBS2mq2T9yHuLs2eWdATXq
	 WMtd0xas+FhMjg62I1JcKkFWG85Ql4gSV7UMXbxIQwHhc2N+PXdER9A5f+hrcd7iM/qgV
	 WbfE9AY+EBmGw1ee4quX8eqajENLG+v/FuGHo1e+WiP/oYx3fcAT+oAjtkFekE+LVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VwUx8mQnE1Wvs0fN/sWja4g9sd1sjUSYb93SlkbStMY=;
	b=oB9Y8Cw+0fZR9fMEeE5iOcLkkifgmlC5YL7TEI159fvU35tfO4GgfxaKkM4cP2cBOD8y
	 8cpDKZEOv79c161nvl7OXSg+Rdwyc/A1jAy3+o/ybiLmvfJqTbNTfMltThVRg3mHxrH+K
	 D2jO4jYWLEvusXAZ2KJbXLuex0nEtJ/HCU72II0WsxPD8FD9f5h+rvtyZpJ8qRIFqRJVp
	 B0jK+776Efd80DPXW0kQBvn5lSPRDeiMcwpgY8L8jWAYSBfjSwp6z34jT2JwhKgA2mjbt
	 kmCG7h5pkTFbfWusPPlpii1FCmPgBLMzk4S0BpzzB97LXqVWtpcqcF4bPBsfUcUQ+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vy4OvUSr;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1446606A6A1
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1446606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vy4OvUSr
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f0458cc9easo8905115ad.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207904; x=1795812704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwUx8mQnE1Wvs0fN/sWja4g9sd1sjUSYb93SlkbStMY=;
        b=vy4OvUSrUPS5HqM57rr4DS8dQlGCvxH3dZXYdSYfLf4kRG0a+Ml9VWH/K9Je3k5ReP
         UKg5FT0MNECIi1BjU4eJ8LQEoi0bd8DLzxqNzPfGfdWNMvRRyXiXVQxOOMgbeOPXS+zP
         NmvLzQcaBz4Iv9lpGTZqgr/0zg5LuEl30WYFG0jmhBGCOImZSMJNC4WidsUSfuFzg9ZH
         JQ224E7ZJaAiWpzSaDo3alF+7W9Hb75Qo0js2/VeF4OpiPPO98uqD3zqFvZoLojRzAP6
         yqnX7Lo4hUar6vWN0Elk8WmMGfb/tHzr7TaIWwBrX8Xy8rbRj2mKE1QeRlL2AiNBJxT7
         4HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207904; x=1795812704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VwUx8mQnE1Wvs0fN/sWja4g9sd1sjUSYb93SlkbStMY=;
        b=eSTWpMdP4MyQI98iTRToXP4t/sKNRm50ebZucDL4Zhel2r1dnw3Mtq1chZa0GRkS6F
         wzjG905Moq6+9DngCHDtf91yODPomQvFq+CHbJ1i46BLowvUeDbRy7qIDxxHhs0UWKUZ
         lpvq/ZiwedEFoH6sEnlCvna8SP2N28tDVRU6AER/TderX5fRenjk7CuQxP4KgAqaqZud
         Kv1MHUIGVEQf4EdHWNOH4CD7Utmq+ddyqzOifVTL6xvQbecIMeXwl08wzS9q1GTtcSPo
         4tnPlZxVr4q8ha4uwfrqXZJK1TOEpz/GbnbaCo/E6LlOmFw+GYNgEp1aQcx7YmthpCir
         Qhqg==
X-Gm-Message-State: APuU4Z/fy3kDMHXCd0/Y8YHO1QLSC+wu5KsJ+r6N06Ms7zLMsdwkFftE
	4UPH1rhq6bzVDN6hj7BW0tCZT28ElXrSVZZn+pNoON3g2v/wRL8SEQCa1Jp4mw==
X-Gm-Gg: AZFdTZeVFrBuS4Qca+mqgq3mwygbQ7PP5SAbuH8J/l+PG+yDI82cFmbejfKzIpb/3s9
	CiynWXQQTCkzDXIXNJ0I9iTt/RVx+eoeTlQzS0oDW9/yEDP4KCkPiszY6LGcdIeH/Drw4Vw+Hlq
	7GOhTeJlNISue8y82MUKApdOtcBO2f6FnbzuQf7OMWTYJrozwWxDYUIcEQ2D87Zqq8U7pbuvfEO
	FNnRX9lQHPA1ARIxiXWrTcpEVHWA5Ku1MoVi/7E5C9o65f3L1k31ovLkcBupiuB/JvVS5CJ0smR
	ozXbT2TBxiadl4Ieo277FiemJCZkHpUGCztRVbVneloCAhkKkn/zGu01/sSS2hFtnMEHdOReTFR
	J5Kkl1kL+RYWPUs1t5yneI9DzXG3X7uKrcPt8lR8yweUJKuk0hqAqEDe7c0meqpobSI6rNByU8T
	SO8pPPLBMPJ0NS2S+bP6HjKpFJVUdj55iSTOkK1Riu7e5LcqEw3hupeY/JUbp0wZSw7wU8yrTPi
	C6/63ZXSEB4SgbsFSR7znQte6v4xom1iy5wW/V8Sl1G1rKXCPyzLxz7IWJ6Yt+DW868G2IZ5pRB
	tArR3OhMdzBneZaCFEJzMoBIX5lMTJ/JrrSges25xZ+8+mKo+5vVNkKZBkMTs32xGx5hygESbms
	jfWbKgwA7hJRR21084PWcMltzSLyY3ZIzzBxqs+lrowqbugfxyYNY0tkqih7ERQ88EPY1TlFduw
	==
X-Received: by 2002:a17:90a:d607:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3b41c9759a5mr3898543a91.61.1795207903896;
        Fri, 20 Nov 2026 12:51:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b21e19fsm293214a91.0.2026.11.20.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 17/49] bpf: Keep a table of equations in each state
Date: Fri, 20 Nov 2026 20:49:25 +0000
Message-ID: <20261120204959.614908-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

What holds on one path has to be in the state of that path. Give each
state a table of equations. The state says: there are numbers for the
syms, in their ranges, for which all equations hold.

  xreg equations    sym equations         syms
  r1 = sym0         sym2 = sym0 + sym1    sym0  0..7
  r2 = 4 * sym0                           sym1  0..255
  fp-8 = sym2                             sym2  0..262

The three arrays are one allocation. It is copied, freed and charged
with the state. An insn deletes the sym equations of its earlier visit.
The clean-up of a later patch limits the size of the table.

Each scan of a table adds to the cost. At the limit a scan does not
start, see over_limit(). The work on equations stops half way then, and
the pass proves nothing. The last state can get there after the last
test of the limits. So the new do_check() of a later patch tests them
again when it ends.

An equation does not outlive its xreg. bpf_find_var_bounds() has no
bounds for a register that is not set, or for a slot without a spill.
A pointer that became a scalar is another number.

The trip index of a loop is an xreg too. A later patch counts it.

The number in a pointer is its offset. The cpu can speculate past the
jump that refines it, so pointers need bypass_spec_v1. There are no
equations without CAP_BPF.

The log has the table:  0:r2=4*sym0+0 sym0=[0,+7]

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  22 ++
 kernel/bpf/equation.c        | 439 +++++++++++++++++++++++++++++++++++
 kernel/bpf/equation.h        |  58 +++++
 kernel/bpf/flow.c            |   2 +
 kernel/bpf/log.c             |   3 +
 kernel/bpf/verifier.c        |  10 +-
 6 files changed, 533 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5256f48723b..d4fba11a891 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -115,6 +115,7 @@ struct bpf_reg_state {
 	 * the dynptr to determine proper reference freeing.
 	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
 	 * to a specific instance of bpf_iter.
+	 * A scalar has no id, see struct bpf_equations.
 	 */
 	u32 id;
 	union {
@@ -422,6 +423,13 @@ static inline u32 bpf_xreg_to_spi(u32 xregno)
 	return xregno - MAX_BPF_EXT_REG;
 }
 
+/* The trip index of a loop is an xreg too. The loops of a frame come after its slots. */
+#define BPF_XREG_TRIP MAX_BPF_XREG
+static inline u64 bpf_xreg(u32 frameno, u32 xregno)
+{
+	return (u64)frameno << 32 | xregno;
+}
+
 /* Where may_goto that the verifier adds goes, see check_loop_guard() */
 enum bpf_guard_edge {
 	BPF_NO_GUARD_EDGE,
@@ -461,6 +469,8 @@ struct loop_stack_entry {
 	u32 entry_id;
 	u32 held_cnt;		/* when the state entered the loop */
 	bool peeled;		/* in a peeled trip, not in the leftover */
+	/* an xreg: how many times the program came back to the header */
+	struct scalar trip_index;
 };
 
 /* The state is in a walk on patience, which may not get to the end of the loop */
@@ -577,6 +587,7 @@ struct bpf_equations {
 };
 
 struct bpf_verifier_state {
+	struct bpf_equations equations;
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
 	/* Acquired reference states */
@@ -1319,6 +1330,7 @@ struct bpf_verifier_env {
 	u64 max_cost, max_mem;
 	u64 pass_max_cost;		/* see bpf_undo_precision() */
 	bool aborted;			/* a thaw does not take it back */
+	bool no_mem;			/* a table cannot grow, see bpf_check_limits() */
 	/* What a pass writes. Each pass starts from the snapshot. */
 	struct_group_tagged(bpf_env_per_pass, per_pass,
 	int err;			/* the first error */
@@ -1462,6 +1474,7 @@ struct bpf_verifier_env {
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
+	struct bpf_equation_env *eq_env;
 	struct bpf_flow *flow;
 };
 
@@ -2169,6 +2182,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
+bool bpf_grow_array(struct bpf_verifier_env *env, void *array, u32 *cap, u32 cnt, size_t size);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
@@ -2350,6 +2364,14 @@ int bpf_compute_loops(struct bpf_verifier_env *env);
 int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
+/* equation.c */
+int bpf_equation_env_init(struct bpf_verifier_env *env);
+void bpf_equation_env_free(struct bpf_verifier_env *env);
+int bpf_equations_copy(struct bpf_verifier_env *env, struct bpf_equations *dst,
+		       const struct bpf_equations *src);
+void bpf_equations_free(struct bpf_equations *eqs);
+void bpf_equations_print(struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
+u32 bpf_equations_bytes(const struct bpf_equations *eqs);
 void scalar_bounds_sync(struct scalar *s);
 bool scalar_subsumes(const struct scalar *old, const struct scalar *cur);
 
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index d49c01fa057..ce000ad0374 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -230,3 +230,442 @@ bool bpf_find_next_diff(struct bpf_verifier_env *env, const struct bpf_equations
 	bpf_add_cost(env, pos->seen_cnt - seen_cnt, BPF_COST_SCAN);
 	return false;
 }
+
+/* The table */
+
+/* Make room for @cnt elements. @array is the address of the pointer. New elements are not set. */
+bool bpf_grow_array(struct bpf_verifier_env *env, void *array, u32 *cap, u32 cnt, size_t size)
+{
+	void *p;
+
+	if (cnt <= *cap)
+		return true;
+	p = kvrealloc(*(void **)array, array_size(2 * cnt, size), BPF_VERIFIER_GFP);
+	if (!p) {
+		env->no_mem = true;
+		return false;
+	}
+	*(void **)array = p;
+	env->mem += (2 * cnt - *cap) * size;
+	*cap = 2 * cnt;
+	return true;
+}
+
+u32 bpf_equations_bytes(const struct bpf_equations *eqs)
+{
+	return eqs->xreg_equation_cap * sizeof(*eqs->xreg_equations) +
+	       eqs->sym_equation_cap * sizeof(*eqs->sym_equations) +
+	       eqs->sym_cap * sizeof(*eqs->syms);
+}
+
+/* @dst becomes a copy of @src. @grow: with room for more. */
+static bool realloc_equations(struct bpf_verifier_env *env, struct bpf_equations *dst,
+			      const struct bpf_equations *src, bool grow)
+{
+	struct bpf_equations new = *src;
+	u32 bytes, spare;
+
+	new.xreg_equation_cap = src->xreg_equation_cnt +
+				(grow ? src->xreg_equation_cnt / 2 + 4 : 0);
+	new.sym_equation_cap = src->sym_equation_cnt + (grow ? src->sym_equation_cnt / 2 + 4 : 0);
+	new.sym_cap = src->sym_cnt + (grow ? src->sym_cnt / 2 + 4 : 0);
+	bytes = kmalloc_size_roundup(bpf_equations_bytes(&new));
+	spare = (bytes - bpf_equations_bytes(&new)) /
+		(sizeof(*new.xreg_equations) + sizeof(*new.sym_equations) + sizeof(*new.syms));
+	new.xreg_equation_cap += spare;
+	new.sym_equation_cap += spare;
+	new.sym_cap += spare;
+	bpf_add_cost(env, BPF_COST_INSN + bytes / 64, BPF_COST_SCAN);
+	new.xreg_equations = kvmalloc(bytes, BPF_VERIFIER_GFP);
+	if (!new.xreg_equations) {
+		env->no_mem = true;
+		return false;
+	}
+	new.sym_equations = (void *)(new.xreg_equations + new.xreg_equation_cap);
+	new.syms = (void *)(new.sym_equations + new.sym_equation_cap);
+	memcpy(new.xreg_equations, src->xreg_equations,
+	       src->xreg_equation_cnt * sizeof(*src->xreg_equations));
+	memcpy(new.sym_equations, src->sym_equations,
+	       src->sym_equation_cnt * sizeof(*src->sym_equations));
+	memcpy(new.syms, src->syms, src->sym_cnt * sizeof(*src->syms));
+	kvfree(dst->xreg_equations);
+	*dst = new;
+	return true;
+}
+
+int bpf_equations_copy(struct bpf_verifier_env *env, struct bpf_equations *dst,
+		       const struct bpf_equations *src)
+{
+	if (src->sym_cnt)
+		return realloc_equations(env, dst, src, false) ? 0 : -ENOMEM;
+	bpf_equations_free(dst);
+	dst->infeasible = src->infeasible;
+	return 0;
+}
+
+u64 bpf_new_sym(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+		const struct scalar *bounds)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct scalar copy = *bounds;
+
+	if (!bpf_grow_array(env, &eq_env->scratch, &eq_env->scratch_cap,
+			    eqs->sym_cnt + 1, sizeof(*eq_env->scratch)) ||
+	    (eqs->sym_cnt == eqs->sym_cap &&
+	     !realloc_equations(env, eqs, eqs, true)))
+		return VAR_NONE;
+	eq_env->scratch[eqs->sym_cnt].refined_sweep = 0;
+	copy.grew_once = false;
+	eqs->syms[eqs->sym_cnt] = copy;
+	eqs->normalized = false;
+	return VAR_SYM | eqs->sym_cnt++;
+}
+
+/* Put a sym with coef 1 or -1 on the left side. False if there is none, or it says nothing. */
+static bool isolate_sym(struct bpf_sym_equation *sym_eq)
+{
+	int i, j, lhs = -1;
+	s64 sign;
+
+	for (i = 0; i < 3; i++) {
+		for (j = i + 1; j < 3; j++) {
+			if (sym_eq->sym[j] != sym_eq->sym[i])
+				continue;
+			sym_eq->coef[i] += sym_eq->coef[j];
+			sym_eq->coef[j] = 0;
+		}
+		if (lhs < 0 && is_plus_minus_one(sym_eq->coef[i]))
+			lhs = i;
+	}
+	if (lhs < 0)
+		return false;
+	for (i = lhs; i > 0; i--) {
+		swap(sym_eq->coef[i], sym_eq->coef[i - 1]);
+		swap(sym_eq->sym[i], sym_eq->sym[i - 1]);
+	}
+	if (!sym_eq->coef[1]) {
+		swap(sym_eq->coef[1], sym_eq->coef[2]);
+		swap(sym_eq->sym[1], sym_eq->sym[2]);
+	}
+	sign = -sym_eq->coef[0];
+	for (i = 0; i < 3; i++) {
+		sym_eq->coef[i] *= sign;
+		sym_eq->sym[i] = sym_eq->coef[i] ? sym_eq->sym[i] : NO_SYM;
+	}
+	sym_eq->off *= sign;
+	return sym_eq->coef[1];
+}
+
+/* Delete the equations that are marked, and the equations of @insn_idx */
+static void forget_sym_equations(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+				 s32 insn_idx)
+{
+	struct bpf_sym_equation *sym_eq, *next = eqs->sym_equations;
+
+	for_each_sym_equation(env, eqs, sym_eq) {
+		if (sym_eq->sym[0] == NO_SYM || sym_eq->insn_idx == insn_idx)
+			continue;
+		if (next != sym_eq)
+			*next = *sym_eq;
+		next++;
+	}
+	eqs->sym_equation_cnt = next - eqs->sym_equations;
+}
+
+/* An insn deletes the equations of its earlier visit. normalize_equations() limits the table. */
+static bool append_sym_equation(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+				struct bpf_sym_equation sym_eq)
+{
+	if (env->no_mem)
+		return false;
+	if (sym_eq.insn_idx >= 0 && !env->eq_env->equation_added)
+		forget_sym_equations(env, eqs, sym_eq.insn_idx);
+	env->eq_env->equation_added = true;
+	if (eqs->sym_equation_cnt == eqs->sym_equation_cap &&
+	    !realloc_equations(env, eqs, eqs, true))
+		return false;
+	eqs->sym_equations[eqs->sym_equation_cnt++] = sym_eq;
+	eqs->normalized = false;
+	return true;
+}
+
+bool bpf_add_sym_equation(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+			  struct bpf_sym_equation sym_eq)
+{
+	return isolate_sym(&sym_eq) && append_sym_equation(env, eqs, sym_eq);
+}
+
+/* @res is what @insn makes of @op */
+bool bpf_add_op(struct bpf_verifier_env *env, struct bpf_equations *eqs, s32 insn,
+		const struct expr *op, const struct expr *res)
+{
+	return res->coef == 1 && !res->off && var_is_sym(res->var) &&
+	       res->var != op[0].var && res->var != op[1].var &&
+	       append_sym_equation(env, eqs, (struct bpf_sym_equation){
+		{ 1, op[0].coef, op[1].coef },
+		{ res->var, op[0].var, op[1].var },
+		insn, op[0].off, op[1].off });
+}
+
+/* An insn like @insn made @res of @op, or it makes a constant */
+bool bpf_find_op(struct bpf_verifier_env *env, const struct bpf_equations *eqs, s32 insn,
+		 const struct expr *op, struct expr *res)
+{
+	const struct bpf_insn *a = &env->prog->insnsi[insn], *b;
+	u8 same = BPF_OP(a->code) == BPF_END ? 0xff : ~BPF_X;
+	const struct bpf_sym_equation *sym_eq;
+	struct scalar bounds, src;
+	struct expr expr[2];
+
+	if (!op[0].coef && !op[1].coef) {
+		scalar_set_const(&bounds, op[0].off);
+		scalar_set_const(&src, op[1].off);
+		scalar_alu(&bounds, &src, a);
+		*res = make_expr(0, 0, bounds.var_off.value);
+		return tnum_is_const(bounds.var_off);
+	}
+	if (over_limit(env))
+		return false;
+	for_each_sym_equation(env, eqs, sym_eq) {
+		if (!is_op(sym_eq) || sym_eq->sym[0] == NO_SYM)
+			continue;
+		b = &env->prog->insnsi[sym_eq->insn_idx];
+		expr[0] = rhs_expr(sym_eq, 0);
+		expr[1] = rhs_expr(sym_eq, 1);
+		if (((a->code ^ b->code) & same) || a->off != b->off ||
+		    !expr_equal(&expr[0], &op[0]) || !expr_equal(&expr[1], &op[1]))
+			continue;
+		*res = sym_expr(1, sym_eq->sym[0], 0);
+		return true;
+	}
+	return false;
+}
+
+/* The equation of @xreg, or of the first xreg after it */
+static struct bpf_xreg_equation *xreg_equation_pos(const struct bpf_equations *eqs, u64 xreg)
+{
+	u32 lo = 0, hi = eqs->xreg_equation_cnt, mid;
+
+	while (lo < hi) {
+		mid = (lo + hi) / 2;
+		if (eqs->xreg_equations[mid].xreg < xreg)
+			lo = mid + 1;
+		else
+			hi = mid;
+	}
+	return eqs->xreg_equations + lo;
+}
+
+struct bpf_xreg_equation *bpf_find_xreg_equation(const struct bpf_equations *eqs, u64 xreg)
+{
+	struct bpf_xreg_equation *xreg_eq = xreg_equation_pos(eqs, xreg);
+
+	return xreg_eq < eqs->xreg_equations + eqs->xreg_equation_cnt &&
+	       xreg_eq->xreg == xreg ? xreg_eq : NULL;
+}
+
+/* @xreg holds @expr. It has no equation if @expr has no sym. */
+void bpf_set_xreg_equation(struct bpf_verifier_env *env, struct bpf_equations *eqs, u64 xreg,
+			   const struct expr *expr, bool is_ptr)
+{
+	struct bpf_xreg_equation *xreg_eq, *end;
+	bool found, insert = expr && var_is_sym(expr->var);
+
+	if (insert && eqs->xreg_equation_cnt == eqs->xreg_equation_cap)
+		insert = realloc_equations(env, eqs, eqs, true);
+	xreg_eq = xreg_equation_pos(eqs, xreg);
+	end = eqs->xreg_equations + eqs->xreg_equation_cnt;
+	found = xreg_eq < end && xreg_eq->xreg == xreg;
+	if (found != insert) {
+		bpf_add_cost(env, end - xreg_eq, BPF_COST_SCAN);
+		memmove(xreg_eq + insert, xreg_eq + found,
+			(end - xreg_eq - found) * sizeof(*xreg_eq));
+		eqs->xreg_equation_cnt += insert - found;
+	}
+	if (insert)
+		*xreg_eq = (struct bpf_xreg_equation){ xreg, expr->coef, expr->off,
+						       var_symno(expr->var), is_ptr };
+	eqs->normalized &= !found && !insert;
+}
+
+void bpf_equations_free(struct bpf_equations *eqs)
+{
+	kvfree(eqs->xreg_equations);
+	memset(eqs, 0, sizeof(*eqs));
+}
+
+/* The cpu can speculate past the jump that refines the offset */
+static bool ptr_off_is_tracked(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+{
+	return env->bypass_spec_v1 && bpf_reg_has_range(reg) && reg->type != PTR_TO_INSN &&
+	       !(reg->type & PTR_UNTRUSTED);
+}
+
+/* The bounds of @var. NULL if there are none. */
+struct scalar *bpf_find_var_bounds(struct bpf_verifier_env *env,
+				   const struct bpf_verifier_state *st, u64 var, bool *is_ptr)
+{
+	u32 fr = var >> 32, idx = var;
+	struct bpf_reg_state *reg;
+	struct bpf_func_state *f;
+
+	*is_ptr = false;
+	if (var_is_sym(var))
+		return &st->equations.syms[idx];
+	f = fr <= st->curframe ? st->frame[fr] : NULL;
+	if (!f)
+		return NULL;
+	if (idx >= BPF_XREG_TRIP)
+		return idx - BPF_XREG_TRIP < f->loop_stack_cnt ?
+		       &f->loop_stack[idx - BPF_XREG_TRIP].trip_index : NULL;
+	reg = idx < MAX_BPF_REG ? &f->regs[idx] : !bpf_xreg_is_slot(idx) ? NULL :
+	      bpf_get_spilled_reg(bpf_xreg_to_spi(idx), f, BIT(STACK_SPILL));
+	if (!reg || reg->type == NOT_INIT)
+		return NULL;
+	*is_ptr = reg->type != SCALAR_VALUE;
+	return !*is_ptr || ptr_off_is_tracked(env, reg) ? scalar_of(reg) : NULL;
+}
+
+/* A hidden register has no value, see MAX_BPF_XREG */
+u64 bpf_reg_to_xreg(const struct bpf_verifier_state *st, u32 regno)
+{
+	return regno <= BPF_REG_FP ? bpf_xreg(st->curframe, regno) : VAR_NONE;
+}
+
+/* A pointer that became a scalar is another number */
+static struct scalar *equation_xreg_bounds(struct bpf_verifier_env *env,
+					   const struct bpf_verifier_state *st,
+					   const struct bpf_xreg_equation *xreg_eq)
+{
+	bool is_ptr;
+	struct scalar *s = bpf_find_var_bounds(env, st, xreg_eq->xreg, &is_ptr);
+
+	return is_ptr == xreg_eq->is_ptr ? s : NULL;
+}
+
+/* The value of @xreg: a constant, the right side of its equation, or the xreg itself */
+bool bpf_xreg_expr(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 xreg,
+		   struct expr *expr, bool *is_ptr)
+{
+	const struct scalar *s = bpf_find_var_bounds(env, st, xreg, is_ptr);
+	const struct bpf_xreg_equation *xreg_eq;
+
+	bpf_add_cost(env, 1, BPF_COST_XREG);
+	if (!s)
+		return false;
+	if (tnum_is_const(s->var_off)) {
+		*expr = make_expr(0, 0, s->var_off.value);
+		return true;
+	}
+	xreg_eq = bpf_find_xreg_equation(&st->equations, xreg);
+	*expr = xreg_eq && xreg_eq->is_ptr == *is_ptr ?
+		sym_expr(xreg_eq->coef, xreg_eq->sym, xreg_eq->off) : make_expr(1, xreg, 0);
+	return true;
+}
+
+/* It is not reduced */
+static void eval_expr_nosync(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			     const struct expr *expr, struct scalar *bounds)
+{
+	bool is_ptr;
+
+	bpf_add_cost(env, 1, BPF_COST_XREG);
+	if (!expr->coef)
+		return scalar_set_const(bounds, expr->off);
+	scalar_scale(bounds, var_is_sym(expr->var) ? &st->equations.syms[var_symno(expr->var)] :
+		     bpf_find_var_bounds(env, st, expr->var, &is_ptr), expr->coef);
+	scalar_add_const(bounds, expr->off);
+}
+
+void bpf_eval_expr(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		   const struct expr *expr, struct scalar *bounds)
+{
+	eval_expr_nosync(env, st, expr, bounds);
+	if (!expr->coef || (expr->coef == 1 && !expr->off) || scalar_is_unknown(bounds))
+		return;
+	bpf_add_cost(env, 4, BPF_COST_XREG);
+	scalar_bounds_sync(bounds);
+}
+
+void bpf_eval_diff(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		   const struct expr *a, const struct expr *b, struct scalar *bounds)
+{
+	struct scalar b_bounds;
+
+	eval_expr_nosync(env, st, a, bounds);
+	eval_expr_nosync(env, st, b, &b_bounds);
+	scalar_add_scaled(bounds, bounds, &b_bounds, -1);
+	if (!scalar_is_unknown(bounds))
+		scalar_bounds_sync(bounds);
+}
+
+static void print_operand(struct bpf_verifier_log *log, const char *prefix, struct expr expr)
+{
+	if (expr.coef)
+		bpf_log(log, "%s%lld*sym%u%+lld", prefix, expr.coef, var_symno(expr.var), expr.off);
+	else
+		bpf_log(log, "%s%lld", prefix, expr.off);
+}
+
+static void print_sym_equation(struct bpf_verifier_log *log, const struct bpf_sym_equation *sym_eq)
+{
+	bpf_log(log, " sym%u=", sym_eq->sym[0]);
+	if (is_op(sym_eq)) {
+		bpf_log(log, "insn%d", sym_eq->insn_idx);
+		print_operand(log, "(", rhs_expr(sym_eq, 0));
+		print_operand(log, ",", rhs_expr(sym_eq, 1));
+		bpf_log(log, ")");
+		return;
+	}
+	bpf_log(log, "%lld*sym%u", sym_eq->coef[1], sym_eq->sym[1]);
+	if (sym_eq->coef[2])
+		bpf_log(log, "%+lld*sym%u", sym_eq->coef[2], sym_eq->sym[2]);
+	bpf_log(log, "%+lld", sym_eq->off);
+}
+
+void bpf_equations_print(struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
+{
+	const struct bpf_equations *eqs = &st->equations;
+	struct bpf_verifier_log *log = &env->log;
+	const struct bpf_xreg_equation *xreg_eq;
+	const struct bpf_sym_equation *sym_eq;
+	u32 i, xregno;
+
+	for (xreg_eq = eqs->xreg_equations;
+	     xreg_eq < eqs->xreg_equations + eqs->xreg_equation_cnt;
+	     xreg_eq++) {
+		xregno = xreg_eq->xreg;
+		bpf_log(log,
+			xregno < MAX_BPF_REG ? " %llu:r%d" : xregno < BPF_XREG_TRIP ? " %llu:fp%d" :
+			" %llu:trip%d", xreg_eq->xreg >> 32, xregno < MAX_BPF_REG ? xregno :
+			xregno < BPF_XREG_TRIP ? (MAX_BPF_EXT_REG - xregno - 1) * BPF_REG_SIZE :
+			xregno - BPF_XREG_TRIP);
+		bpf_log(log, "=%lld*sym%u%+lld", xreg_eq->coef, xreg_eq->sym, xreg_eq->off);
+	}
+	for (sym_eq = eqs->sym_equations;
+	     sym_eq < eqs->sym_equations + eqs->sym_equation_cnt; sym_eq++)
+		print_sym_equation(log, sym_eq);
+	for (i = 0; i < eqs->sym_cnt; i++)
+		bpf_log(log, " sym%u=[%lld,+%llu]", i, eqs->syms[i].r64.base,
+			eqs->syms[i].r64.size);
+}
+
+int bpf_equation_env_init(struct bpf_verifier_env *env)
+{
+	if (!env->bpf_capable)
+		return 0;
+	env->eq_env = kvzalloc_obj(*env->eq_env, BPF_VERIFIER_GFP);
+	return env->eq_env ? 0 : -ENOMEM;
+}
+
+void bpf_equation_env_free(struct bpf_verifier_env *env)
+{
+	if (!env->eq_env)
+		return;
+	kvfree(env->eq_env->scratch);
+	kvfree(env->eq_env->use_links);
+	kvfree(env->eq_env->phis);
+	kvfree(env->eq_env->phi_index);
+	bpf_equations_free(&env->eq_env->join_state.equations);
+	kvfree(env->eq_env);
+}
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
index b5ca29f2c6c..db1f9fe3776 100644
--- a/kernel/bpf/equation.h
+++ b/kernel/bpf/equation.h
@@ -41,6 +41,42 @@ struct equation_pos {
 	u32 next, seen_cnt;
 };
 
+/* Scratch data of a function about a sym */
+struct sym_scratch {
+	u32 use_cnt;		/* equations that use it */
+	/* propagate_bounds(): the sweep that has to look at its equations */
+	u32 refined_sweep;
+	u32 new_symno;
+	bool determined, by_op;
+	const struct bpf_sym_equation *op;	/* that makes it */
+	struct expr cur_expr;	/* check_equations(): its value in the other state */
+};
+
+struct bpf_equation_env {
+	struct sym_scratch *scratch;
+	u32 *use_links;
+	u32 scratch_cap, use_link_cap, refined_cnt;
+	bool has_expr[2], is_ptr[2], equation_added, divided;
+	/* equation_join.c */
+	struct bpf_verifier_state join_state;	/* it has equations and no frames */
+	struct join_phi *phis;
+	u32 *phi_index;
+};
+
+#define for_each_sym_equation(env, eqs, pos)						\
+	for (bpf_add_cost(env, (eqs)->sym_equation_cnt, BPF_COST_COPY),			\
+	     pos = (eqs)->sym_equations;						\
+	     pos < (eqs)->sym_equations + (eqs)->sym_equation_cnt; pos++)
+
+#define for_each_sum(env, eqs, pos) \
+	for_each_sym_equation(env, eqs, pos) \
+		if (!is_op(pos))
+
+#define for_each_xreg_equation(env, eqs, pos)						\
+	for (bpf_add_cost(env, (eqs)->xreg_equation_cnt, BPF_COST_COPY),		\
+	     pos = (eqs)->xreg_equations;						\
+	     pos < (eqs)->xreg_equations + (eqs)->xreg_equation_cnt; pos++)
+
 /* The pass is over its budget. It finds no more equations, a scan in a loop does not start. */
 static inline bool over_limit(struct bpf_verifier_env *env)
 {
@@ -105,8 +141,30 @@ static inline int find_sym_pos(const struct bpf_sym_equation *sym_eq, u32 sym)
 	       sym_eq->sym[2] == sym ? 2 : 3;
 }
 
+/* equation.c */
+u64 bpf_new_sym(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+		const struct scalar *bounds);
+bool bpf_add_sym_equation(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+			  struct bpf_sym_equation sym_eq);
+bool bpf_add_op(struct bpf_verifier_env *env, struct bpf_equations *eqs, s32 insn,
+		const struct expr *op, const struct expr *res);
+bool bpf_find_op(struct bpf_verifier_env *env, const struct bpf_equations *eqs, s32 insn,
+		 const struct expr *op, struct expr *res);
+struct bpf_xreg_equation *bpf_find_xreg_equation(const struct bpf_equations *eqs, u64 xreg);
+void bpf_set_xreg_equation(struct bpf_verifier_env *env, struct bpf_equations *eqs, u64 xreg,
+			   const struct expr *expr, bool is_ptr);
+u64 bpf_reg_to_xreg(const struct bpf_verifier_state *st, u32 regno);
+struct scalar *bpf_find_var_bounds(struct bpf_verifier_env *env,
+				   const struct bpf_verifier_state *st, u64 var, bool *is_ptr);
+bool bpf_xreg_expr(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 xreg,
+		   struct expr *expr, bool *is_ptr);
+void bpf_eval_expr(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		   const struct expr *expr, struct scalar *bounds);
 bool bpf_expr_div_exact(struct expr *expr, u64 off, s64 coef);
 bool bpf_find_next_diff(struct bpf_verifier_env *env, const struct bpf_equations *eqs,
 			const struct expr *a, const struct expr *b, struct equation_pos *pos,
 			struct expr *diff);
+void bpf_eval_diff(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		   const struct expr *a, const struct expr *b, struct scalar *bounds);
+
 #endif
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 5d86792025f..f8e8ea7b05a 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -308,6 +308,8 @@ int bpf_check_limits(struct bpf_verifier_env *env)
 	env->aborted |= bpf_must_abort();
 	if (env->aborted)
 		return -EINTR;
+	if (env->no_mem)
+		return -ENOMEM;
 	if (env->cost <= min(env->max_cost, env->pass_max_cost) && env->mem <= env->max_mem &&
 	    !env->over_limit)
 		return 0;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 7b1390d9054..8a905f4df9b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -803,6 +803,9 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			verbose(env, "%s%d", i > first ? "," : "",
 				state->loop_stack[i].loop->header);
 	}
+	/* one table for all frames */
+	if (print_all && frameno == vstate->curframe)
+		bpf_equations_print(env, vstate);
 	verbose(env, "\n");
 	if (!print_all)
 		mark_verifier_state_clean(env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c3d33960fba..5cd1d83d0c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1748,6 +1748,7 @@ void bpf_charge_state(struct bpf_verifier_env *env, struct bpf_verifier_state *s
 	u32 bytes = 2 * sizeof(*st) + ksize(st->refs), fr;
 	struct bpf_func_state *f;
 
+	bytes += bpf_equations_bytes(&st->equations);
 	for (fr = 0; fr <= st->curframe && (f = st->frame[fr]); fr++)
 		bytes += kmalloc_size_roundup(sizeof(*f)) + ksize(f->stack) +
 			 ksize(f->stack_arg_regs) + ksize(f->loop_stack);
@@ -1767,6 +1768,7 @@ void bpf_free_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 		state->frame[i] = NULL;
 	}
 	kfree(state->refs);
+	bpf_equations_free(&state->equations);
 	if (free_self)
 		kfree(state);
 }
@@ -1800,7 +1802,8 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
 		free_func_state(dst_state->frame[i]);
 		dst_state->frame[i] = NULL;
 	}
-	err = copy_reference_state(dst_state, src);
+	err = copy_reference_state(dst_state, src) ?:
+	      bpf_equations_copy(env, &dst_state->equations, &src->equations);
 	if (err)
 		return err;
 	bpf_add_cost(env, bpf_xreg_cnt(src) + src->acquired_refs, BPF_COST_COPY);
@@ -24907,6 +24910,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (env->log.level & BPF_LOG_LEVEL2)
 		log_program(env);
 
+	ret = bpf_equation_env_init(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_flow_prepare(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -25048,6 +25055,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->used_index.slots);
 	kvfree(env->kfunc_index.slots);
 	kvfree(env->insn_array_maps);
+	bpf_equation_env_free(env);
 	bpf_flow_free(env);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.postorder_nums);
-- 
2.55.0

