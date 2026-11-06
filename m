Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937109;
	b=k7WswdGWcAKzECiAS9GcxszFdX6QXmyiOcAs3bmtyMy+T5BgfF76AfwfYOD/AgWk0jV2
	 3ddqsRNUFRf1G4CC+yfUXjdKsqK7geoOyUY32ave+33/hrlUr5gINNsohjaVcG/cu+CX5
	 57ou4oj79v2Hd7wmCEL3+axfY4iSMfrI4Kx7aRTFtTJxTv2Esi9CclnPcjzT7wQwKBwd5
	 3xtD8LQLIhJ4rHxMWkyBGfh9rv+VsFGjs3hiDFIqc4B9q3LIJzqJvNWEJ0/hv1VDmemJr
	 /y6rqu91SPLKr+4qz3NLuTKzY7k6movmgKM0wp1qfl0WY0ghGLe1jvdZSzkfqnHYjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B2kc0g9vB8ZTmTPYqT81Y85QXd+kleImCAXs4K+6qhw=;
	b=LeRhQ5BfM6lQ9rU2Bw8Uza0TGELfIKQ6pVsLt6ii5Z4UceKDVBz7KQm/Pc+6F4MPZSke
	 ekKZaQeWTJhoXxjzCqjJ4CR5J6vudhhCojB0AuRuTEMSyW19m4fvQ1CAnBhu2RtVsTZ3o
	 l1nRY0BRJkW5JQpTsXFtEoVagi3Ltux/RpDIueTY76fP8HuH60VrVYPJXysAwrxcoF3zJ
	 bncUb1+YU3JPIw1s6zQAUs3IykJ9heOG5cAsGQyebPvIC6y/c5pNnsoq6iugOVCyy3B/y
	 iHgv4xN0IwaWb2Nrs3RMh7kkCGyFAHFVfMvB6cNGgFj30VCmHTxdQ9iQHAl2d2kB5Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="maAQpf4/";
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077F606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3077F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=maAQpf4/
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb628232d2so113981a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937108; x=1794541908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B2kc0g9vB8ZTmTPYqT81Y85QXd+kleImCAXs4K+6qhw=;
        b=maAQpf4/m4tyP5fOZZNroXZhK+vol8wQCqjV+fTueBbO9ppwJ5JHvUekSFQbgA0zAP
         Co6xfAfreCp86/y1NM+HFt1XnpG9mSS/098VdkVK/iusLAtFGkaUkRRRDtj73tJOcThv
         ZqtdJ0naPaB4TvYi9d0Bcm6/Q1nnEI0kx6EUPrE3euWRtjc9Xl9WobmKfZkyoi7BUVxb
         vrvVWMulbkzUUNGaTSiTx28SInlLpYjnQWUglJ2rZv/oIb5wnoy0AnETtxATjVQAK7fi
         W4vHLDamSBNoM9CLd/a/6JitIoG7yj0DxNgiBJ+OxUcgbCVYWYGuIjD+jahlWct+aXHf
         hnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937108; x=1794541908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B2kc0g9vB8ZTmTPYqT81Y85QXd+kleImCAXs4K+6qhw=;
        b=vtxnuDoSWsFV2oRCl8DwQrkBSyYt81oOqOqiEJ3wTaENegaRX7Dg3BQ4tE6F7BDLit
         s+P9JNW1u9z2QSjKHQBJwnBxOJTIjJEy0O57kfkMymURgQkHWcH9ASy8B34AVBU4U18V
         BHJI+ACKbe9XLrv4gruh42FaB4nmedM/fFd2Q46CKJtICUg3w7c8MOwz3IO0g19hISo6
         pFFwvEUCO3en3mB9sTSO+dxSqphQhldZbMduleNqXxnwyXfolB20KRygTx6D4nsvvvJF
         0FNPUnhOuQP2v6dSzvawc2Uitn4pcWhM4C/MOW/r06fguRFmt3npXzrefca7uC4aidiI
         8Vjg==
X-Gm-Message-State: APuU4Z8kOgT2U4RTJ1RZotc4vTeN2i2A9BYLvszCZ2/CSk9fmksZW0T8
	pJWnx5odpmv9GNMyb3Jf9NeFN2BY3ZGkhxN2Tn/VT72/epEBi9crV7vEp3+KaQ==
X-Gm-Gg: AYBFou2VTZyrgn50y5Bu04SRtYzWUxbumA8mBv5tot7PutHAr7mCh5INDS6GAn8OyDj
	4Ef1kWdt7SpPa15dKSltor8oLddtGDAwPBEQu6L6FzFPcZ2aT2o5UL/OupDlOycWfRICnN8TBhi
	25ORFIiGQvYDwUiidCrzJrz2lnvzh02mvbOxIowzIKCk9KsmECyMQg4v8Hv0KyREhifscDO1YOt
	S81VLuoP0fJGoSn06d3oQRFoVwDcJ7W3vuIlQPYInwG/foexgodpBUX8iuwIIpywJ9HP7hL2qCH
	UVPbOm//14F4LrvpDjmlG4QXEHsWZsWPQwozcVDeY0wbIpE22rsSitXxIpF74OL1/V+R1qQavDg
	VC7+gEXBBbz/8p7zSui0YdrjZ0VBbvAr180CR8cFfmokQ59xb1Q5ExqNJ5E8mhPak/bC3MG6pSO
	lypcdQUx/87YoTopS/gk699GALCV5jRBYIr20CSyinrRIxPyEqrrm1ua4/jK/sj4zfIWlfvi1zx
	nI65KHnvguu7mnL0j6vYYUxiF0GjPFX8fF2WHL5IJTfMpVVNYunHABegVrKhjwMiWa6MgP9AEsX
	efKbCTgEhfGoz7CpFvZvLLjL7lIZXrNyhemot5/iQfrPLTuUJvvWFLsxNoZdWvQJbKB3+ACgH8Q
	kM3kuoFcyVIWdntr0LT3GfIZz19VIFE9z2Bs7UA9uUvI6t36IEyjcq9y6U0NMU+4ceDpcp+kh1Q
	==
X-Received: by 2002:a05:6a21:a46:b0:3dd:85aa:452d with SMTP id adf61e73a8af0-3ebb29c9cadmr1679868637.31.1793937108360;
        Thu, 05 Nov 2026 19:51:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a750aasm138960a12.22.2026.11.05.19.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:51:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 06/45] bpf: Tell which arguments of a call a join must leave alone
Date: Fri,  6 Nov 2026 03:50:30 +0000
Message-ID: <20261106035111.3315285-7-alexei.starovoitov@gmail.com>
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
index 754c64d7c9cb..07a9097e3d4e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9206,6 +9206,13 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
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
@@ -15370,6 +15377,61 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
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

