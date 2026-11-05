Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911552;
	b=vtlhQM+ydqi5eZOBTDto6VPm7xh6zhgrSSzBNEzBjmNlyumCG5/YuRK0SwZKI4SWOYSU
	 YNrmEr6n+ijje1YIH6o7uThvvHwA6giFOQvxbH9dHLXAvx4xmLGmybi5BVGpsMQoVu4TO
	 sJOBX5AWCkaunVlTaahLTcwhjAHk4/bMjn9J/D5jzaVkXM+DyQEFVVRkJMPgMHdJvoGt/
	 FH8Yo7k3c6GFyqzAdgR7cqzced/pLO2VlaOP6ifTmucYbuYz8i/m4+s2cqnX30FFGR1Ll
	 Kf7booh/bAASc7TluEoH/0fxj7+3cdaPq5PaVTguaPkn6Xs/gtwUXRsXF0ADgOtrJYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mqsQC4jvu3pX066IYpQrUMsomgsEamno42txoEdLHes=;
	b=AzgZKYQQDO1Bh7coUBE3T9+OdwdQ1jyfO7YQuKV4ndR99r1aR89CxLEREXkims1ay6Ao
	 EuCAwy1gXP+oDigDaEddGN1A3VLjoQBa2ArIcVCuy04QkDhMwb9YMOSagsdF102fOPUEl
	 uV+HQeJ/Vnvp1Np8DxoVsjPCifnk870PG5eYMhXapaf8smAxFfTqhHVH5yk02pY/PryIw
	 d0Zl+thtcZQd9ieJdD8g4lnWcAn/9ptvxQXh4fpCurSnRP1X2q9R1h9sCSP4NH79uPKWg
	 Hz1vZIC5PIDxVJvIjJBpWYvInzsRzxpj3aUmUrunCcImxFIqCRggxF5lsBxBgUnutfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osHmAt41;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A8606A329
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 065A8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osHmAt41
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1366004a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911551; x=1794516351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqsQC4jvu3pX066IYpQrUMsomgsEamno42txoEdLHes=;
        b=osHmAt41pidnRxIO7Ey40d4P8wUUqtu1+JLLhYFQVxBZJdpKvEtJafTbmTx4lc0nw+
         uvXc5wSBS2cmOlp1mbSWAJZkTqchlpOsCVaCymP9tw6PO5GIM+RRWjg1F04QZzgmzsp+
         6PqX8IXAaExLJD0r9dhHS/mGDI/zgfApPZyPcgOoFxE04YCRQtiiM3c2yPO1Fr52k/uT
         1lmNMBWqtahV45qfQY8+Y6YDW5fuWnOnGGgOexXGht5M/z6iErnxZl1sx8QLhcxsuJFa
         kJtKV5LQLXRgh4mto1tzmGEcaY6q6W0Z+aFAYq6YrXmRCmdsh1Wvf40/lFUk88iTGkZh
         Y5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911551; x=1794516351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mqsQC4jvu3pX066IYpQrUMsomgsEamno42txoEdLHes=;
        b=gw7w03Ae7SiepBZCwFRt2rVTuAuvl/m/3H2iWOHf1SZQHOJhC/4WrpZ44JRFiZcXly
         dZzkwmwJuLl5bxaKtBUSKMBTdTWJHji8pXceof9ceqO7WII7QSy+OWAmwwBONCGxa5ht
         YFlHLLR9lug0o59btzQNalkBaq0unY17y2p6vIrTBVU/MyeoYLD2fPtJLsO8Tsig6s+O
         0lRAnvGSCfwYjAz14IJDd7tB9bf7G8romeQLW3fRcZ0KK5iyxzCt7PexvfN8ZzT3XCCj
         R2p98S1m2xTljDksQ5rqYFhd7T72K8HIarOljq3C1kBwC8ybW6kZI7g5X/pMpOlyY4Gd
         Mjuw==
X-Gm-Message-State: APuU4Z+3Jo6JeDPeF5dTiwbcXkorS64ROL64Ha6ThRoufYqCkycmfM5Q
	mWymulqy6n3SqYM0lUzULxjF8wPEvmtjxE852+N0lvRYCvaCqqxP+VG7CvHAGQ==
X-Gm-Gg: AYBFou0imJEczjQ92VmFHglvNU7pNxltXM9Y7CVCBjLIugfWry8YfMNrAr8+bQVkXO3
	JXzMbmtfcDuvKMMjg1wi/FikfuYur8RDyYZg3u5fH0joZ0Xuw5CEaHZjy9A17JKmPR4mHyLwuU0
	YuPK+srunwWjnZzF51kgogakR2w0NZraR8MywSwe5AaDW+F71q8m+adWrGpGrUqLydATlJHjcUV
	19rtyH4f2o8os3emckwdFH1Nf+HEH6IXNQ/maVE25XUqSK2iDeqM9LV527//n6h/L6Tps6aCD0w
	vLsQEeZsUGFoKPzJZrlWf7yNu0Sfpn4FVQjMLRL1U8DjaJ0TnqwI75NB/79IoPnHfBPO1O104iN
	JYZbAdGJCrarxARSwJU1GP/97dTG3/vvte4A7mJpCemGfpbeKijTs8hOx4IHmPv4MXv/iRr7c5A
	j5YcVfJ5w1vT5g2b6+vNon/Cm2vCFIZWDC7qo7s4tz++KIWi/mtA/L8zCnFaaD3J53DRLcfjXrF
	sKJl9Vxcx8foRSdxgoNWkLj1HjjHGW9xaj53/55FFeAzEBpCDTriJM5evY95HPqA0jaW8KZUsGl
	D4iBEN14TYw81av+2XP8hxgmpUZCKuecCedKq3ogjEIyc6KGj8joxjaZ13SOKrPLDnrIe/cyBV3
	lf0N1PZZFBHjZJcx5bokxSAs3wf71H/+zcpIb7DkQ33DpAf2/bcyTBS7B3+yQMM59ACHbLITt2w
	==
X-Received: by 2002:a17:90b:2749:b0:3ad:a17d:f46c with SMTP id 98e67ed59e1d1-3b0db738a04mr151347a91.62.1793911550979;
        Thu, 05 Nov 2026 12:45:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32b6507sm5646371a91.16.2026.11.05.12.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:45:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 06/35] bpf: Tell which arguments of a call a join must leave alone
Date: Thu,  5 Nov 2026 20:44:43 +0000
Message-ID: <20261105204513.2230344-7-alexei.starovoitov@gmail.com>
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
index 1b08ccd5d766..dafbf2851b22 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1606,6 +1606,9 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 void bpf_join_free(struct bpf_verifier_env *env);
 
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
+u16 bpf_call_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
+u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
+bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e39d1efb08ae..747c739ad9f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9160,6 +9160,13 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
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
@@ -15306,6 +15313,61 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
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

