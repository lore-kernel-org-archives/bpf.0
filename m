Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022720;
	b=GCS8bPk2rVhG6XbCzUdEG2karrX0SMAomRJ8w5sdKqbQ/+xfJ0XZw570kgeBfAMq+OhG
	 PtoEvePgvLtCgFAgY4kRtEW61gMkIrdsc37QjWCN0YYKfsn6UAJ0+LKxNQKsvjJZ/R394
	 n2s/QXpcAr6m78SAmzO7wSEWNOdJd3UKu+Wtw7BdFPGeWcJ5X0+wel2ISHxghJv0uzK4S
	 ENxl9q1zFIJUtVZGqlTUY10vFP4mMY5shdWpj/yXbVKrVfhyK6fAtraYlrTBDVlE4m2RM
	 c0T1dacwE4UfnRlzZy+UXqa2HNZFkkyA+hSZSsPtMPKfDGG2ORoGkeJBAOxqYnqEvzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LzRCDaV1RWIHS2HYSp9n+7PHsg0zF+xoiDpuL0ERjTA=;
	b=RbeEzQf1l8ZutANk8h6pQbE/oaQ/PbLaNAilTk9dY8iBqtu1DSOiDjN1aDimB+fxwoGe
	 bu8a3PTx9tEtKBd4eqRDA6VdzX5dJZXK6imVG3BAp/zUyM3oOMKc6yNUJiBbzbOFE+y4i
	 BrT563gVn8vKoFqp2wCRoQY7d7xr6uwqrFtPVbCaZ/OdlxcLQRJKuVmLeHdQBseJtGG8y
	 F+0TgPtrenPreK2P25WZhKzjdW0LtI3XQ4Kk6mzvbkvk4jo1eZnOPvt0xJHb+gXFcQRxO
	 l2JeuQMFHVjTFUAin0Z+4G4ARRou/mVxZDhyJAVOioCp5JuJVB9d0p3InL47bptWmsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="z7/ZEyFq";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5B606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C5B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7/ZEyFq
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so9117135ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022719; x=1794627519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzRCDaV1RWIHS2HYSp9n+7PHsg0zF+xoiDpuL0ERjTA=;
        b=z7/ZEyFq4yYP9Ht7OcSSD9UxBQNML1h3IDE7371dbCa2WpRbb2tVCFL+Q0V3winYGh
         BoJZ+Wvl/uYtGSCb/1TDPpca2EaDmb+kshwvidzn7zCxLKVZBpOg4NwQI86rfZAxKFHj
         Bhmk0sAR/XH/NlzAH53gbcUMt0kJwvkIinU1Au5SrftonRAPTjV0d2Ka5o9THfBAWEId
         hYmHp6W3aBC0NfuFmlHhVzXkDRnQ6qCGtFolq4uUgWfabYRpSFT37BU0FOGb32SRKuQ+
         OUaOhMNXyuWumIrjdYD9+u79V7vhCceop6jdvn4Rsykizghpc33Mu3ez5JDjE00CNtx8
         SKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022719; x=1794627519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LzRCDaV1RWIHS2HYSp9n+7PHsg0zF+xoiDpuL0ERjTA=;
        b=qqYGjKBDWA9xV9Fy0zmY4UljUbUX4ZuP/JQZ/sQBDdJT4/U427qHoUtZUwk/D8NDB8
         6OMU+4ve/7Aff2eps3/V3gFGZWjEjmHBXVBBrq6YhVH+fL69grwAnVQMdUkCf7xHJMby
         Xd+EalN2ktIlKkYt3ajoLsfJMrhIa2OEHG1njPCOSUm3Xou0x6nHXmOK9PXS4FzKSXCV
         XSGR6/J7EAtFTNlnauvMeGY+ZCbxgqIZOFmad5OKD2cTkt3hnnBjRgBen2kco5RI6EjA
         y3frs7O016meqq9OgTjgaIAMtqm6MwnnQWjjHpHFXgolmBdobG2fBqNamtsVes+qhrr9
         2EMQ==
X-Gm-Message-State: APuU4Z8rELmx1zwvg31EQtklvwB/PUkZlCUI39iKGypbu3kQQC4wgLpP
	8jHtOYKRu6/7/3SDddb7rDYDzA/ipEjhFWKENouMX6nZNASG57z7hryw8mFpjw==
X-Gm-Gg: AYBFou042VGn/N0qxiADBll+v1RXKNYtQvqoz4epWhnbgy1djBMCFMJf2l3tSiNMqE5
	cz8K2zibeprXqm3VTPgOXgjL1x4g1KJCmknBv+lw6grnkw5c0ubk0LjMxfj76qi3tIhSoEDnQzO
	UrLeqYc76J3ZQwh8tGtzsq17GjZW40Cl/UIRP81p/CCqG7xQSejEyBZ+hVmNGy79RNkIMQdWd5V
	RKJwa75+khpwKaWQbFkLiGvejw7SFiVfklS46P6lnmu8bbqybG9eWoHEmn9sbeq3yytvEb5o3XU
	maLVka4+C13a1/3FV56knX19PR0LWwGpYlGzClIG5gcPNrvlfJ8ogsisJMoA/oRhWDYLuH4IigH
	w3rA36lQN9g83zB5d5B2O1Th2hQmKwNfiq0TRCvS32UPkONFrSgN4MNI/G0D6YSOJXAt8aY8fNg
	uqBefLpeDdo3JJjZ0ezDbq2hcPXhyBPV7dLxPzH6BQOeuR7FCnapn1NptFsxq0L3WaU5cWa/fDf
	hmk6Awkp/GLUmr91J/MIm8s+eE80iMRNy1S/oB1Z2c9dpMhCvt3fR0hdXt52O7WfGKEphjXTU1V
	r0goMUWf/qAH9lRSdB5MPRRqksRz1Bag/8MYH7K4ovdTrm6TKn/HYQeldE4hdsveIF7gurcxrWn
	FFpdbD2m5020D35ZnIB7c13JElWotYpSmBGwr4yKKz3YD9cYprUktswuQdn79qazvxxC8ciJoYP
	U=
X-Received: by 2002:a17:90b:1a91:b0:3ae:521e:767f with SMTP id 98e67ed59e1d1-3b0db705cb0mr4136558a91.36.1794022718855;
        Fri, 06 Nov 2026 19:38:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105817ce1sm1491021a91.9.2026.11.06.19.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 06/46] bpf: Tell which arguments of a call a join must leave alone
Date: Sat,  7 Nov 2026 03:37:14 +0000
Message-ID: <20261107033758.1547725-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

get_some_addr() of the selftest mem_rdonly_untrusted:

  if (bpf_get_prandom_u32())
          return bpf_rdonly_cast(0, bpf_core_type_id_kernel(struct sock));
  else
          return bpf_rdonly_cast(0, 0);

The compiler makes one call of the two, with r2 = 0 or the type id. The
paths meet in front of the call, and a join makes a range of two constants:

  R2 must be a known constant

cil_sock4_connect() and cil_sock4_sendmsg() of Cilium's bpf_sock:

  if (err == -EHOSTUNREACH || err == -ENOMEM) {
          try_set_retval(err);

The compiler decides the 'if' where err is set, and keeps a flag. All
paths meet, then the flag is tested. In the join err is [-113, 1]:

  At bpf_set_retval the register R1 has .. should have been in [-4095, 0]

The progs are valid. A pass that joins states must know, ahead of a call,
which registers it must not join.

antistall_set() of scx_layered:

  bpf_for_each(scx_dsq, __p, dsq_id, 0) {

bpf_iter_scx_dsq_next() ends this loop: it needs no may_goto. The pass that
finds the places for may_goto must know that, before the main pass sets
is_iter_next in insn_aux_data. With may_goto in each such loop layered_init
and mitosis_init are rejected on the added edge, and the schedulers in
tools/sched_ext take 48 % more insns.

  bpf_call_const_arg_regs()    a helper or a kfunc takes only a known
                               constant in these registers
  bpf_call_checked_arg_regs()  it compares them with a range: sizes of
                               memory, the argument of bpf_set_retval()
  bpf_insn_is_iter_next()      the call is bpf_iter_*_next()

The first two go by the types of the arguments in struct bpf_func_proto,
like check_func_arg(), for r1 - r5. bpf_set_retval() is checked elsewhere
and is added by hand. Nothing calls the three in this patch.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/verifier.c        | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 922f01ee8136..7fda41a4bf25 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1614,6 +1614,9 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 void bpf_join_free(struct bpf_verifier_env *env);
 
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
+u16 bpf_call_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
+u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
+bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 801e4607a462..ea6dd39982f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9215,6 +9215,13 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	return type == ARG_MEM_SIZE || type == ARG_MEM_SIZE_OR_ZERO;
 }
 
+/* A number that check_func_arg() takes only when it is a known constant */
+static bool arg_type_is_const(enum bpf_arg_type type)
+{
+	return type == ARG_CONST_SCALAR || type == ARG_CONST_MEM_SIZE ||
+	       type == ARG_CONST_ALLOC_SIZE_OR_ZERO;
+}
+
 static bool arg_type_is_raw_mem(enum bpf_arg_type type)
 {
 	/*
@@ -15379,6 +15386,61 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return info;
 }
 
+/* insn_aux_data->is_iter_next is not there before the main pass */
+bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_call_arg_meta meta;
+
+	return bpf_pseudo_kfunc_call(insn) &&
+	       !bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) &&
+	       bpf_is_iter_next_kfunc(&meta);
+}
+
+/*
+ * check_func_arg() goes by the types of the arguments in the proto of a helper or a kfunc.
+ * So does what has to be known ahead of the call: the registers with arguments of a kind.
+ */
+static u16 call_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			 bool (*is)(enum bpf_arg_type type))
+{
+	const struct btf_func_model *fm = NULL;
+	const struct bpf_func_proto *fn;
+	struct bpf_kfunc_desc *desc;
+	u32 i, slot = 0;
+	u16 mask = 0;
+
+	if (bpf_pseudo_kfunc_call(insn)) {
+		desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+		if (!desc)
+			return 0;
+		fn = &desc->proto;
+		fm = &desc->func_model;
+	} else if (bpf_get_helper_proto(env, insn->imm, &fn) < 0) {
+		return 0;
+	}
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type) && fn->arg_type[i] != ARG_UNUSED &&
+		    slot < MAX_BPF_FUNC_REG_ARGS; i++) {
+		if (is(fn->arg_type[i]))
+			mask |= BIT(BPF_REG_1 + slot);
+		slot += fm ? btf_func_model_arg_slots(fm, i) : 1;
+	}
+	return mask;
+}
+
+/* The registers in which the helper or the kfunc takes nothing but a known constant */
+u16 bpf_call_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	return call_arg_regs(env, insn, arg_type_is_const);
+}
+
+/* The registers in which it takes a number that has to be in a range */
+u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_set_retval)
+		return BIT(BPF_REG_1);
+	return call_arg_regs(env, insn, arg_type_is_mem_size);
+}
+
 /*
  * Describe a kfunc's stack access through argument slot @arg (0-based).
  * As for helpers, must_write describes destruction of prior verifier state,
-- 
2.55.0

