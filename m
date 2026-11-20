Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160810;
	b=WPr3xhoTnElObK+U5kvOf+y+gqq0WgnLV5IhuB4k2HYRfR8kZ73idWegkd37oixgt1tb
	 Q/uZe7N7dsDs2Fhia4IY4ubpQ+UyT5S93y7lt5nKeKKBj3XaLlTNuRXdCtnr7CRcnNq2V
	 eDUzIIRRS8D5D5vZUl5R97kiVsOo5wttEIOZPuwvo0NQ4CB8oJjebpt5BY2ydfS0OupUJ
	 SibnHHPLZeDoKOxc+mbfdSIM2YKb+J/fRbjseLzAI1XDJOcI9OYFOwrDny+nBMGm3R/ju
	 VJzeicTfbQtJKkz3YO/y1BtL5GJtnQzWQALAiM/92qWbxm43jZrq9ArlXy/iv3hQ1ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MMaVeJGk0RZ34t0+TNJrxpIDhNTxGTjJf5LV0LU/e+w=;
	b=4yZFC3Ch4auMDs00Zh1TWxgZWSjmmBc0mfTZyAtPwYHX1rwEPKLqZbnIQKIdqNB/4J8f
	 Wk4qN4x21g4UwfmEiYLOyR+FWh8EXGdjx6OFc8pTkLfOMDzX+WNsWqSE/RoKJopNsMqDu
	 NwzJtoAFO70IQM06qTreWP05ZT9tYzE4TZc6lkOmoZ3I+6AoJZaPDELHqJg/VaG0AMvyS
	 NnJe9CbXX9B1ELJoGZQXf8pq0qZaIe+yQYrF/61WCT2MihVd2EVUW+0b1x480HeOXqE8d
	 OdtgqYGNJ0i2wJbKjDeOEdTKj2qkPjD2AbpS2B0t8Te+wcTvZ2ErDpW+e7V7giZVocw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HYsGEYFq;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DB606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4DB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HYsGEYFq
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so288909b3a.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160809; x=1795765609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMaVeJGk0RZ34t0+TNJrxpIDhNTxGTjJf5LV0LU/e+w=;
        b=HYsGEYFq27TZPgo1XT01G+ORMevML7Yn7p9+HIEj3wAjE3oAZEQS3B30xNWCl7VYuK
         gS2+pTi2aPeYFFv8RFukH2qZFe1myuRPhgrn+QUQjkAVX9oKC2MKh1tGwTIhCqHi/wrv
         dIEIn+8uNbgkGC+gnzDgEYxoK65J2CgynwTRV4RlOukygmgzz+BBDOu1LSjw4Mug0Oqv
         u3FVw0hYa2cfqp9PCygqRSKydUyMc42E6MQ9LC+HvFtdPcY6rV+uuoZP/kjVXmgctFxc
         AkbmeVnPEio41hStPoS1EDrlEGBTJzjQELapPtt3Zjur3pgfAU9cSTBDgRKV3Ymg2T5f
         Sk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160809; x=1795765609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MMaVeJGk0RZ34t0+TNJrxpIDhNTxGTjJf5LV0LU/e+w=;
        b=ETZcbvuHPtr72uvbtaQAJ+iVsvYvv+jzGSl7l6k9l6k0VG9BUAxNVVH1DbjbKGNPUL
         wq/oraNjskPkelIaoZXbf1S3Miq+En11V0H5S+RfKp+pSdnUxBhGeiz1woC9MLGdOX8/
         0ZMG4lUsvnp4youR3bMJD5xC3xCPcl5nRVDjZpw8bgO9uofaN7hIn4owX3G9qacId/vk
         Xz4+lRO4c5VtAXHA3QN4mti47txthdaY/nVbzceeiY8zFOtxn5QpKEbAMSk+Cza94onO
         ovTIpItPU8XhJvEgz5qrnmJ69KEzX7dwNh2y1iSSRETA3D8ynRRKcsx9kWCSiXCBgCZ/
         DDKw==
X-Gm-Message-State: APuU4Z9NBxIRo75dNyLv1FpALuWXpNMuSXKNYWbEELLHyFvCDLpHnA63
	WY1+1SoJ+PoBSDWcJeuyg3kRRLwLm9Cv1ed55NlgK/ZgVYqFAcWjfZPkDvZqXg==
X-Gm-Gg: AZFdTZen/7/Puk3BhK3ByVI51No9qGDhObiceNzeAA8WSNObeMctDxnswIm3c7ZRz29
	wn/leKfE2hd8IA26AoOxmJJwYks7jZ6V2yn0aTwvk3rPljnSFdEacNYQnNkQ0+iQCt/RzGnZpza
	/m6pmM7AGMeNH+0dPb9mbGEB/HOWaEG+Kxock8XEoW0l/JLnTk6Bise49ZRgWGKlN6/iKDpl28C
	wOeWwpFJnfwpyC4IfbSD2BaM2rkg4gbHvCwQPzeDta8IJM4i6TpokmBUN1lmjwic/c1qV7guuVI
	DJFa897OZhIZmVn9T5FC7ojgVIcqxa09cgeGI5NsnXnjPY0JqXSHebw3h0uMsPiSGvBJS063ChT
	oXVCIFxpUNPppBeSyp7oVw3SVStVqlZcCVMq0dubNs5PU9tnY3CeWycVY5ui2M7Gt6nCQtRoS5j
	T/n64FpbkStJLjLeV/CrSiqwLI95tz6l8sjNPHE1+fXYjnUs9IBdjrumQmgKfJTb2BPhN7950Fx
	Z5ljEyr1ph8nnsiBYKbQrKuyzm2LkMMrXnk/DKoY5qmkj8KX6sa3R1DNezFYaeh06En5zlzGxGf
	DX8+//SV4OqeD+59wwEmgymGA7IumInh2zlh2ZbmDXMLHqur1aegEu8237siKkqfPHET1H8AlQE
	m87ZtM83S7S1/XkuEGNo8/kAhuiiocCe/UXrJ1Xg5keR1p8vYFb3ipv4z7wWdlD4rbRjKkedpcw
	Y=
X-Received: by 2002:a05:6a00:9283:b0:8b0:5438:86a4 with SMTP id d2e1a72fcca58-8c87bdb534dmr2268256b3a.16.1795160808304;
        Thu, 19 Nov 2026 23:46:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873442863sm1113662b3a.43.2026.11.19.23.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:46:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 23/49] bpf: Find the xregs that an unproven insn depends on
Date: Fri, 20 Nov 2026 07:41:55 +0000
Message-ID: <20261120074430.2704488-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

After an error the next pass has to keep some states apart. To keep all
apart is too costly. Find the xregs that the unproven insn depends on,
the deps:

  data_deps      their value flows into an operand of the insn
  control_deps   their value flows into a jump that can skip the insn

bpf_compute_deps() makes a backward slice. It is the analysis of
liveness with other seeds:

                                        data     control
   1: r6 = ctx->idx                     r1       -
   2: r7 = 0                            r6       -
   3: if r6 <= 7 goto 5                 r6       r7
   4: r7 = -22                          r6       -
   5: if r7 != 0 goto exit  join point  r6       r7    <- seed
   6: r3 = map value                    r6       -
   7: r3 += r6                          r6 r3    -
   8: r0 = *(u8 *)(r3 + 0)              r3       -     <- seed

It follows values through calls, returns and the frames of callers.
What a helper stores is not known. But the address and the size decide
which slots it keeps.
A store through a join of two addresses forgets the slots between them.
So may_write_mask has these slots too.
What is held is tracked like an xreg: the insns that acquire or release
write it. find_control_seeds() finds the jumps with one edge that leads
to the insn and one edge that does not.

The masks are a guess. They select where a pass does more work. A wrong
mask cannot make the verifier accept an unsafe program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   6 +
 kernel/bpf/liveness.c        |   4 +-
 kernel/bpf/precision.c       | 539 +++++++++++++++++++++++++++++++++++
 kernel/bpf/precision.h       |  55 ++++
 kernel/bpf/verifier.c        |   7 +-
 5 files changed, 608 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c26fa0c0cea..be3d965a3be 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -952,6 +952,8 @@ struct bpf_insn_aux_data {
 	u32 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
 	u32 guard_unset_reg:1; /* where it goes a register is read that is not set here */
 	u32 non_speculative_first:1; /* speculative states end here, their fixups did not fit */
+	u32 acquires:1; /* a reference or a lock */
+	u32 releases:1;
 
 	/* below flags are initialized once */
 	u32 bb_end:1; /* last instruction of a basic block */
@@ -1641,6 +1643,8 @@ u64 bpf_hash64(const void *p, size_t len, u64 hash);
 u64 bpf_hash_join_key(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
 int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
+bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		      u32 fr, u32 xregno);
 void bpf_note_reads_from_unproven(struct bpf_verifier_env *env, u32 idx);
 void bpf_note_unproven_insn(struct bpf_verifier_env *env,
 			    const struct bpf_verifier_state *st, u32 idx);
@@ -2367,6 +2371,8 @@ int bpf_compute_loops(struct bpf_verifier_env *env);
 int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
+int bpf_insn_callee(struct bpf_verifier_env *env, int idx);
+
 /* equation.c */
 int bpf_equation_env_init(struct bpf_verifier_env *env);
 void bpf_equation_env_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index ebfe1603a65..c9fea08eada 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1664,7 +1664,9 @@ static int record_stack_access_off(struct func_instance *instance, const struct
 			return err;
 	}
 	if (info.may_write) {
-		err = mark_stack_may_write(instance, frame, insn_idx, slot_lo, slot_hi);
+		/* A join of the offsets is a range. A write forgets the slots between them. */
+		err = mark_stack_may_write(instance, frame, insn_idx, slot_lo,
+					   (-arg->off[0] - 1) / STACK_SLOT_SZ);
 		if (err)
 			return err;
 	}
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index 6aa54c656a7..8af213dccca 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1,4 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Which states a pass keeps apart. Pass 0 joins all numbers, see bpf_hash_live_types(). After
+ * an error the next pass keeps more apart (trace partitioning), see do_check_all() and
+ * bpf_partition_more(). An insn whose check fails is unproven. A later pass can prove it.
+ *
+ * The deps are the xregs that the unproven insn depends on:
+ * data_deps:    their value flows into an operand of the insn
+ * control_deps: their value flows into a jump that can skip the insn
+ *
+ *	if (r7 == 0) goto L1;		r7 is in control_deps
+ *	r2 = r6;			r6 is in data_deps
+ *	r0 = *(u8 *)(r2 + 0);		unproven insn
+ *  L1:
+ */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
@@ -6,6 +20,53 @@
 
 #include "precision.h"
 
+static unsigned long *mask_at(struct bpf_verifier_env *env, unsigned long *masks, u32 func, u32 idx)
+{
+	const struct bpf_precision *prec = env->precision;
+
+	return masks + prec->func[func].first +
+	       (size_t)(idx - env->subprog_info[func].start) * prec->func[func].words;
+}
+
+/* @masks for frame @fr of @st. A caller needs what the callee reads and what follows the call. */
+u32 bpf_frame_mask(struct bpf_verifier_env *env, unsigned long *masks,
+		   const struct bpf_verifier_state *st, u32 fr, unsigned long *out)
+{
+	u32 func = st->frame[fr]->subprogno, words = env->precision->func[func].words, i;
+	const unsigned long *m = mask_at(env, masks, func, bpf_frame_insn_idx(st, fr));
+
+	for (i = 0; i < words; i++)
+		out[i] = m[i] | (fr < st->curframe ? m[words + i] : 0);
+	return words * BITS_PER_LONG;
+}
+
+bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		      u32 fr, u32 xregno)
+{
+	unsigned long data_deps[XREG_WORDS], control_deps[XREG_WORDS];
+
+	if (!env->precision->data_deps ||
+	    xregno >= bpf_frame_mask(env, env->precision->data_deps, st, fr, data_deps))
+		return false;
+	bpf_frame_mask(env, env->precision->control_deps, st, fr, control_deps);
+	return test_bit(xregno, data_deps) || test_bit(xregno, control_deps);
+}
+
+/* The function that the insn at @idx calls, or hands to a helper. -1 if that is not known. */
+int bpf_insn_callee(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u16 funcs = aux->const_reg_subprog_mask & aux->use_regs;
+
+	if (bpf_pseudo_call(insn))
+		return bpf_find_subprog(env, idx + insn->imm + 1);
+	if (hweight16(funcs) == 1 && (aux->calls_callback ||
+				      bpf_is_async_callback_calling_insn(insn)))
+		return aux->const_reg_vals[__ffs(funcs)];
+	return -1;
+}
+
 /* The insn at @idx is unproven because it reads a value from another unproven insn */
 void bpf_note_reads_from_unproven(struct bpf_verifier_env *env, u32 idx)
 {
@@ -140,3 +201,481 @@ bool bpf_same_insns_unproven(struct bpf_verifier_env *env)
 				test_bit(env->insn_idx, prec->last_unproven_insns) &&
 				!test_bit(env->insn_idx, prec->this_pass.unproven_insns));
 }
+
+/* What callers need of a function: the registers that it returns, and */
+#define RET_REGS	(BIT(BPF_REG_0) | BIT(BPF_REG_2))
+#define RET_HELD	BIT(4)	/* what is held */
+#define RET_ACQUIRES	BIT(5)	/* it writes that */
+#define RET_STORES	BIT(6)	/* what it stores to their frames */
+#define RET_LOADS	BIT(7)	/* it needs what it loads from there */
+
+/*
+ * What is held is tracked like an xreg, with one bit per insn in held_insns. It includes the way
+ * in which a function was left. It is in the join_key, so only the insns that write it matter.
+ */
+static bool reads_held(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code);
+
+	if (bpf_is_unwind_goto(insn) || bpf_pseudo_call(insn) || bpf_is_callx(insn))
+		return true;
+	/* a loop header, ld_abs, a call, an exit */
+	return test_bit(idx, env->precision->last_pass.unproven_insns) &&
+	       (aux->loop || class == BPF_LD ||
+		(class == BPF_JMP && !bpf_insn_is_cond_jump(insn->code)));
+}
+
+static bool has_slots(const unsigned long *mask, const unsigned long *slots, u32 bits)
+{
+	u32 i;
+
+	for (i = 0; i < BITS_TO_LONGS(bits); i++)
+		if (mask[i] & bpf_slots_to_xreg_word(slots, i))
+			return true;
+	return false;
+}
+
+/* The call at @idx needs @needs of function @t. Returns the arguments that @t needs. */
+static u16 compute_call_deps(struct bpf_verifier_env *env, unsigned long *masks, u8 *ret, int t,
+			     u8 needs, bool *held, bool *changed)
+{
+	u32 start = env->subprog_info[t].start;
+
+	*changed |= needs & ~ret[t];
+	ret[t] |= needs;
+	*held |= test_bit(start, env->precision->held_insns);
+	return *mask_at(env, masks, t, start) &
+	       (GENMASK(BPF_REG_5, BPF_REG_1) | BIT(XREG_STACK_ARGS));
+}
+
+/* What the insn at @idx of function @s needs before it. @in has what is needed after it. */
+static bool compute_insn_deps(struct bpf_verifier_env *env, unsigned long *masks, u8 *ret, int s,
+			      int idx, bool is_seed, unsigned long *in, bool held)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u32 bits = env->precision->func[s].words * BITS_PER_LONG;
+	u16 use = aux->use_regs, def = aux->def_regs, args = 0;
+	bool changed = false, stores, reads, loads, call, held_after;
+	struct taken_funcs *taken = &env->precision->taken;
+	u8 class = BPF_CLASS(insn->code), needs;
+	int t, callee;
+
+	call = class == BPF_JMP && BPF_OP(insn->code) == BPF_CALL;
+	/* the next call of the callback reads what this one stores */
+	if (aux->calls_callback) {
+		bitmap_or(in, in, mask_at(env, masks, s, idx), bits);
+		held |= test_bit(idx, env->precision->held_insns);
+	}
+	if (insn->code == (BPF_JMP | BPF_EXIT) || bpf_is_throw_kfunc(insn))
+		held = ret[s] & RET_HELD;
+	held_after = held |= is_seed && reads_held(env, idx);
+	stores = has_slots(in, aux->may_write_mask, bits) ||
+		 (aux->writes_outer && (ret[s] & RET_STORES)) ||
+		 ((is_stack_arg_st(insn) || is_stack_arg_stx(insn)) &&
+		  test_bit(XREG_STACK_ARGS, in));
+	needs = (in[0] & def & RET_REGS) | (stores ? RET_STORES : 0) | (held ? RET_HELD : 0);
+	if ((in[0] & def & XREG_REGS) || stores)
+		__set_bit(idx, env->precision->controlled_insns);
+	/* what a helper stores is not known, whatever it reads */
+	reads = (in[0] & def & XREG_REGS) || (stores && !call);
+	loads = reads || test_bit(idx, env->precision->bad_value_insns) ||
+		!(test_bit(idx, env->precision->last_pass.unproven_insns) ||
+		  test_bit(idx, env->precision->last_pass.bad_read_insns));
+	if (!loads && class == BPF_STX)
+		use = BIT(insn->dst_reg);
+	reads |= is_seed;
+	in[0] &= ~(unsigned long)(def & XREG_REGS);
+	for (t = 0; t < BITS_TO_LONGS(bits); t++)
+		in[t] &= bpf_slots_to_xreg_word(aux->live_stack_before, t) |
+			 (t ? 0 : BIT(MAX_BPF_EXT_REG) - 1);
+	/* the address and the size decide if a helper keeps a slot */
+	if (call && (has_slots(in, aux->may_write_mask, bits) ||
+		     (aux->writes_outer && (ret[s] & RET_STORES))))
+		in[0] |= use & (aux->stack_ptrs | aux->stack_ptrs << 1);
+
+	callee = bpf_insn_callee(env, idx);
+	if (callee > 0 && bpf_subprog_is_global(env, callee))
+		callee = -1;
+	if (callee > 0 && bpf_pseudo_call(insn)) {
+		args = compute_call_deps(env, masks, ret, callee, needs, &held, &changed);
+		use = env->insn_aux_data[env->subprog_info[callee].start].live_regs_before;
+		reads = is_seed;
+		needs = ret[callee];
+	} else if (callee > 0) {
+		reads |= compute_call_deps(env, masks, ret, callee, needs & ~RET_REGS, &held,
+					   &changed);
+		needs = ret[callee];
+	} else if (bpf_is_callx(insn) || aux->calls_callback) {
+		changed |= needs & ~taken->needs;
+		taken->needs |= needs;
+		held |= taken->held;
+		args = taken->args;
+		needs = taken->ret;
+		reads |= args;
+	} else {
+		needs = 0;
+	}
+	if (insn->code == (BPF_JMP | BPF_EXIT))
+		args = ret[s] & RET_REGS;
+	if (held_after && (aux->acquires || aux->releases || (needs & RET_ACQUIRES) ||
+			   bpf_is_unwind_exit(insn) || bpf_is_throw_kfunc(insn))) {
+		__set_bit(idx, env->precision->last_pass.call_insns);
+		reads |= aux->releases;
+		changed |= !(ret[s] & RET_ACQUIRES);
+		ret[s] |= RET_ACQUIRES;
+	}
+	if (held)
+		changed |= !__test_and_set_bit(idx, env->precision->held_insns);
+	in[0] |= args | (reads ? use & XREG_REGS : 0);
+	if (reads && (call || is_stack_arg_ldx(insn)))
+		__set_bit(XREG_STACK_ARGS, in);
+	if ((reads && loads) || (needs & RET_LOADS)) {
+		bpf_add_slots(in, aux->may_read_mask, bits);
+		/* the callee reads what it wrote */
+		if (needs & RET_LOADS)
+			bpf_add_slots(in, aux->may_write_mask, bits);
+		if ((aux->reads_outer || (call && aux->writes_outer)) && !(ret[s] & RET_LOADS)) {
+			ret[s] |= RET_LOADS;
+			changed = true;
+		}
+	}
+	return changed;
+}
+
+/*
+ * A backward slice: the same backward analysis as liveness, from other seeds.
+ *
+ *  liveness:      start from the reads of ALL insns
+ *  data_deps:     start from the reads of the unproven insn
+ *  control_deps:  start from the reads of the jumps that can skip the unproven insn
+ *
+ *                                        data     control
+ *  1: r6 = ctx->idx                      r1       -
+ *  2: r7 = 0                             r6       -
+ *  3: if r6 <= 7 goto 5                  r6       r7
+ *  4: r7 = -22                           r6       -
+ *  5: r8 = 1               join point    r6       r7
+ *  6: if r9 == 0 goto 8                  r6       r7 r8
+ *  7: r8 = 2                             r6       r7
+ *  8: if r8 == 3 goto exit join point    r6       r7 r8    <- seed of control_deps: r8
+ *  9: if r7 != 0 goto exit               r6       r7       <- seed of control_deps: r7
+ * 10: r2 = r6                            r6       -
+ * 11: r2 <<= 3                           r2       -
+ * 12: r3 = map value                     r2       -
+ * 13: r3 += r2                           r2 r3    -
+ * 14: r0 = *(u64 *)(r3 + 0)              r3       -        <- seed of data_deps: r3
+ *
+ * controlled_insns gets the insns that write an xreg of @masks, for add_transitive_deps().
+ */
+int bpf_compute_deps(struct bpf_verifier_env *env, unsigned long *masks,
+		     const unsigned long *seed_insns)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	struct bpf_precision *prec = env->precision;
+	unsigned long in[XREG_WORDS], *old;
+	int i, k, s, t, idx, err = 0;
+	struct bpf_iarray *succ;
+	bool changed = true, held;
+	u32 bits;
+	u8 *ret;
+
+	ret = kvcalloc(env->subprog_cnt, sizeof(*ret), BPF_VERIFIER_GFP);
+	if (!ret)
+		return -ENOMEM;
+	memset(masks, 0, prec->words * sizeof(long));
+	bitmap_zero(prec->held_insns, env->prog->len);
+	bitmap_zero(prec->controlled_insns, env->prog->len);
+	prec->taken = (struct taken_funcs){};
+	while (changed) {
+		changed = false;
+		bpf_add_cost(env, env->cfg.gotox_edges, BPF_COST_COPY);
+		err = bpf_add_cost_and_check(env, prec->words + env->prog->len, BPF_COST_XREG);
+		if (err)
+			break;
+		/* callees first */
+		for (k = 0; k < env->subprog_cnt; k++) {
+			s = env->subprog_topo_order[k];
+			bits = prec->func[s].words * BITS_PER_LONG;
+			for (i = sub[s].postorder_start; i <= sub[s + 1].postorder_start; i++) {
+				/* it can be dead code, see push_unwind_exit() */
+				idx = i < sub[s + 1].postorder_start ? env->cfg.insn_postorder[i] :
+				      sub[s].bail_insn;
+				if (idx < 0)
+					break;
+				bitmap_zero(in, bits);
+				succ = bpf_insn_successors(env, idx);
+				held = false;
+				iarray_for_each(t, succ) {
+					bitmap_or(in, in, mask_at(env, masks, s, t), bits);
+					held |= test_bit(t, prec->held_insns);
+				}
+				t = bpf_head_guard_target(env, idx);
+				if (t >= 0)
+					bitmap_or(in, in, mask_at(env, masks, s, t), bits);
+				changed |= compute_insn_deps(env, masks, ret, s, idx,
+							     test_bit(idx, seed_insns), in, held);
+				if (idx == prec->loop_carried_at) {
+					bitmap_or(in, in, prec->loop_carried, bits);
+					changed |= !(ret[s] & RET_STORES);
+					ret[s] |= RET_STORES;
+				}
+				old = mask_at(env, masks, s, idx);
+				changed |= !bitmap_subset(in, old, bits);
+				bitmap_or(old, old, in, bits);
+			}
+			if (!sub[s].addr_taken)
+				continue;
+			prec->taken.args |= compute_call_deps(env, masks, ret, s, prec->taken.needs,
+							      &prec->taken.held, &changed);
+			prec->taken.ret |= ret[s];
+		}
+	}
+	kvfree(ret);
+	return err;
+}
+
+struct block {
+	u32 first, last;
+	/* @last leaves that loop to @out. It is the outermost one, 0 if none. */
+	u32 header, out;
+};
+
+/* The basic blocks of @sub in post order */
+static u32 find_blocks(struct bpf_verifier_env *env, struct bpf_subprog_info *sub, u32 *first,
+		       struct block *blocks)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct block *b = blocks;
+	struct bpf_iarray *succ;
+	int i, n, s, t, h;
+
+	for (i = sub->start; i < sub[1].start; i++)
+		first[i] = bpf_flow_is_bb_start(env, i) ? i : first[i - 1];
+	for (i = sub->postorder_start; i < sub[1].postorder_start; i++) {
+		n = env->cfg.insn_postorder[i];
+		succ = bpf_insn_successors(env, n);
+		if (succ->cnt == 1 && !bpf_flow_is_bb_start(env, succ->items[0]))
+			continue;
+		*b = (struct block){ first[n], n };
+		iarray_for_each(s, succ) {
+			t = bpf_loop_at_index(env, s);
+			for (h = bpf_loop_at_index(env, n);
+			     h >= 0 && h != t && !bpf_is_nested_loop(env, t, h);
+			     h = aux[h].loop_header) {
+				b->header = h;
+				b->out = s;
+			}
+		}
+		b++;
+	}
+	return b - blocks;
+}
+
+static bool may_not_return(struct bpf_verifier_env *env, struct bpf_subprog_info *sub, u32 idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+
+	if (bpf_pseudo_call(insn))
+		return env->subprog_info[bpf_insn_callee(env, idx)].might_throw;
+	return bpf_is_callx(insn) && sub->might_throw;
+}
+
+/*
+ * The jumps that can skip one of controlled_insns: one edge leads to the insn, another does not.
+ * A back edge leads to nothing, so 'continue' skips. The edge that stays in a loop leads to all
+ * that the header leads to, so 'break' skips too. A call that throws skips too.
+ */
+static int find_control_seeds(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = NULL;
+	struct bpf_precision *prec = env->precision;
+	u32 len = env->prog->len, idx = 0, cnt = 0, s, bit, *first;
+	struct block *blocks, *b;
+	struct bpf_iarray *succ;
+	u64 *leads, any, all;
+	int err = 0;
+
+	leads = kvmalloc_array(len, sizeof(*leads) + sizeof(*blocks) + sizeof(*first),
+			       BPF_VERIFIER_GFP);
+	if (!leads)
+		return -ENOMEM;
+	blocks = (void *)(leads + len);
+	first = (void *)(blocks + len);
+	bitmap_andnot(prec->controlled_insns, prec->controlled_insns,
+		      prec->controlled_insns_done, len);
+	bitmap_or(prec->controlled_insns_done, prec->controlled_insns_done,
+		  prec->controlled_insns, len);
+	while (!err && (idx = find_next_bit(prec->controlled_insns, len, idx)) < len) {
+		if (!sub || idx >= sub[1].start) {
+			sub = bpf_find_containing_subprog(env, idx);
+			cnt = find_blocks(env, sub, first, blocks);
+			bpf_add_cost(env, sub[1].start - sub->start, BPF_COST_XREG);
+		}
+		for (b = blocks; b < blocks + cnt; b++)
+			leads[b->first] = 0;
+		for (bit = 0; bit < 64 && idx < sub[1].start; bit++) {
+			leads[first[idx]] = BIT_ULL(bit);
+			/* the other insns of the basic block have the same control seeds */
+			while (++idx < sub[1].start && !bpf_flow_is_bb_start(env, idx))
+				;
+			idx = find_next_bit(prec->controlled_insns, len, idx);
+		}
+		for (b = blocks; b < blocks + cnt; b++) {
+			if (bpf_is_throw_kfunc(&env->prog->insnsi[b->last]))
+				continue;
+			succ = bpf_insn_successors(env, b->last);
+			bpf_add_cost(env, succ->cnt, BPF_COST_COPY);
+			any = 0;
+			all = U64_MAX;
+			iarray_for_each(s, succ) {
+				any |= leads[s];
+				all &= leads[s];
+			}
+			if (succ->cnt > 1 ? any != all : any && may_not_return(env, sub, b->last))
+				__set_bit(b->last, prec->control_seeds);
+			leads[b->first] |= any;
+		}
+		for (b = blocks; b < blocks + cnt; b++)
+			if (b->out && (leads[b->header] & ~leads[b->out]))
+				__set_bit(b->last, prec->control_seeds);
+		err = bpf_add_cost_and_check(env, cnt, BPF_COST_XREG);
+	}
+	kvfree(leads);
+	return err;
+}
+
+/* The calls that lead to the unproven insns */
+static int find_calls_to_unproven(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	struct precision_per_pass *last_pass = &env->precision->last_pass;
+	struct bpf_insn_aux_data *aux;
+	bool taken = false, changed = true;
+	int i, k, n, s, err = 0;
+
+	while (changed && !err) {
+		changed = false;
+		for_each_set_bit(s, last_pass->unproven_funcs, env->subprog_cnt)
+			taken |= sub[s].addr_taken;
+		/* callees first. callx and a cycle of calls need more rounds. */
+		for (k = 0; k < env->subprog_cnt; k++) {
+			n = env->subprog_topo_order[k];
+			for (i = sub[n].start; i < sub[n + 1].start; i++) {
+				aux = &env->insn_aux_data[i];
+				s = bpf_insn_callee(env, i);
+				if (!aux->seen || !bpf_calls_function(env, i) ||
+				    !(s > 0 ? test_bit(s, last_pass->unproven_funcs) : taken))
+					continue;
+				__set_bit(i, last_pass->call_insns);
+				changed |= !__test_and_set_bit(n, last_pass->unproven_funcs);
+			}
+		}
+		err = bpf_add_cost_and_check(env, env->prog->len, BPF_COST_XREG);
+	}
+	return err;
+}
+
+static bool add_masks(struct bpf_precision *prec, unsigned long *to, const unsigned long *from)
+{
+	bool more = false;
+	size_t i;
+
+	for (i = 0; i < prec->words; i++) {
+		more |= from[i] & ~to[i];
+		to[i] |= from[i];
+	}
+	return more;
+}
+
+/* The control_deps of controlled_insns. Returns 1 if there is more in the deps. */
+static int add_control_deps(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	int err = find_control_seeds(env) ?:
+		  bpf_compute_deps(env, prec->new_control_deps, prec->control_seeds);
+
+	if (err)
+		return err;
+	return add_masks(prec, prec->data_deps, prec->new_data_deps) |
+	       add_masks(prec, prec->control_deps, prec->new_control_deps) |
+	       add_masks(prec, prec->type_apart, prec->new_data_deps);
+}
+
+static int compute_deps_of_unproven(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	u32 len = env->prog->len, i;
+	int err;
+
+	err = bpf_compute_deps(env, prec->new_data_deps, prec->last_pass.unproven_insns);
+	if (err)
+		return err;
+	/* the insns that write data_deps wait for add_transitive_deps() */
+	bitmap_copy(prec->def_insns, prec->controlled_insns, len);
+	bitmap_zero(prec->controlled_insns_done, len);
+	bitmap_zero(prec->control_seeds, len);
+	bitmap_or(prec->controlled_insns, prec->last_pass.unproven_insns,
+		  prec->last_pass.call_insns, len);
+	/* the helper decides how many times the callback runs, callx what runs */
+	for_each_set_bit(i, prec->last_pass.call_insns, len)
+		if (bpf_calls_function(env, i) && !bpf_pseudo_call(&env->prog->insnsi[i]))
+			__set_bit(i, prec->control_seeds);
+	return add_control_deps(env);
+}
+
+static int alloc_masks(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	DECLARE_BITMAP(live, MAX_BPF_STACK_SLOTS);
+	struct bpf_precision *prec = env->precision;
+	struct bpf_insn_aux_data *aux;
+	unsigned long *masks;
+	u32 s, i, slots;
+	int err;
+
+	if (prec->func || prec->hops_to_err)
+		return -ENOMEM;
+	prec->func = kvcalloc(env->subprog_cnt, sizeof(*prec->func), BPF_VERIFIER_GFP);
+	prec->hops_to_err = kvcalloc(5 * env->prog->len, sizeof(u16), BPF_VERIFIER_GFP);
+	if (!prec->func || !prec->hops_to_err)
+		return -ENOMEM;
+	prec->hops_to_exit = prec->hops_to_err + env->prog->len;
+	prec->apart_xregno = (void *)(prec->hops_to_exit + env->prog->len);
+	for (s = 0; s < env->subprog_cnt; s++) {
+		bitmap_zero(live, MAX_BPF_STACK_SLOTS);
+		for (i = sub[s].start; i < sub[s + 1].start; i++) {
+			aux = &env->insn_aux_data[i];
+			bitmap_or(live, live, aux->live_stack_before, MAX_BPF_STACK_SLOTS);
+			/* the callee reads what it wrote */
+			if (bpf_pseudo_call(&env->prog->insnsi[i]))
+				bitmap_or(live, live, aux->may_write_mask, MAX_BPF_STACK_SLOTS);
+		}
+		slots = find_last_bit(live, MAX_BPF_STACK_SLOTS) + 1;
+		if (slots > MAX_BPF_STACK_SLOTS)
+			slots = 0;
+		prec->func[s].first = prec->words;
+		prec->func[s].words = BITS_TO_LONGS(bpf_spi_to_xreg(slots));
+		prec->words += (sub[s + 1].start - sub[s].start + 1) * prec->func[s].words;
+	}
+	env->mem += 18 * prec->words * sizeof(long) + 5 * env->prog->len * sizeof(u16);
+	err = bpf_check_limits(env);
+	masks = err ? NULL : kvcalloc(18 * prec->words, sizeof(long), BPF_VERIFIER_GFP);
+	if (!masks) {
+		env->mem -= 18 * prec->words * sizeof(long);
+		return err ?: -ENOMEM;
+	}
+	prec->data_deps = masks;
+	prec->control_deps = masks + prec->words;
+	prec->disjoint_apart = masks + 2 * prec->words;
+	prec->type_apart = masks + 3 * prec->words;
+	prec->in_frames = masks + 4 * prec->words;
+	prec->undo = masks + 5 * prec->words;
+	prec->kept = masks + 10 * prec->words;
+	prec->new_data_deps = masks + 15 * prec->words;
+	prec->new_control_deps = masks + 16 * prec->words;
+	prec->loop_control_deps = masks + 17 * prec->words;
+	return 0;
+}
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
index 23980622006..63869360160 100644
--- a/kernel/bpf/precision.h
+++ b/kernel/bpf/precision.h
@@ -5,6 +5,14 @@
 
 #include <linux/bpf_verifier.h>
 
+/*
+ * The xregs of a mask, see MAX_BPF_XREG. r10 is the same in all states.
+ * Its bit stands for the arguments on the stack.
+ */
+#define XREG_STACK_ARGS	BPF_REG_FP
+#define XREG_REGS	GENMASK(BPF_REG_9, BPF_REG_0)
+#define XREG_WORDS	BITS_TO_LONGS(MAX_BPF_XREG)
+
 /* What a pass finds about its errors */
 struct precision_per_pass {
 	/* bitmaps of insns */
@@ -15,19 +23,51 @@ struct precision_per_pass {
 	u64 suspect_loops, first_suspect_loops;	/* of the unproven states, of the first one */
 };
 
+/* callx calls one of the functions whose address is taken. They count as one function. */
+struct taken_funcs {
+	u16 args;
+	u8 needs, ret;
+	bool held;
+};
+
 struct bpf_precision {
+	/* Masks of xregs per insn. The masks of a function are as wide as its stack is deep. */
+	struct { u32 first, words; } *func;
+	size_t words;
+	unsigned long *data_deps, *control_deps, *disjoint_apart;
+	/* data_deps, and where only type and object matter */
+	unsigned long *type_apart;
+	unsigned long *in_frames;		/* see bpf_call_needs_frames() */
+	unsigned long *undo;			/* these five before the last partition */
+	unsigned long *kept;			/* these five, see keep_precision() */
+	/* of the unproven insns of the last pass */
+	unsigned long *new_data_deps, *new_control_deps;
+	struct taken_funcs taken;		/* see bpf_compute_deps() */
 	/* this pass, and the last pass whose partition was kept */
 	struct precision_per_pass this_pass, last_pass;
+	/* bitmaps of insns */
+	unsigned long *held_insns;		/* see reads_held() */
 	unsigned long *bad_value_insns;		/* unproven, its value is possibly the cause */
 	unsigned long *last_unproven_insns;	/* in the last pass */
 	unsigned long *bad_read_insns_done;
+	unsigned long *control_seeds, *controlled_insns, *controlled_insns_done, *def_insns;
 	u32 last_unproven_left;		/* last_unproven_insns whose check did not fail again */
 	bool new_nospec;
 
+	u16 *apart_xregno;	/* per insn, see bpf_range_of_data_dep() */
 	/* The path-sensitive run */
 	unsigned long *err_insns;		/* insns at which the failing path can end */
+	u32 *hops_to_err, *hops_to_exit;	/* per insn, see compute_hops() */
+	unsigned long *loop_control_deps;	/* see bpf_jumps_see_same() */
+	u32 loop_carried_at;
+	unsigned long loop_carried[XREG_WORDS];
 };
 
+u32 bpf_frame_mask(struct bpf_verifier_env *env, unsigned long *masks,
+		   const struct bpf_verifier_state *st, u32 fr, unsigned long *out);
+int bpf_compute_deps(struct bpf_verifier_env *env, unsigned long *masks,
+		     const unsigned long *seed_insns);
+
 static inline bool bpf_calls_function(struct bpf_verifier_env *env, int idx)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[idx];
@@ -36,4 +76,19 @@ static inline bool bpf_calls_function(struct bpf_verifier_env *env, int idx)
 	       env->insn_aux_data[idx].calls_callback || bpf_is_async_callback_calling_insn(insn);
 }
 
+/* Word @i of a mask of xregs that has @slots */
+static inline unsigned long bpf_slots_to_xreg_word(const unsigned long *slots, u32 i)
+{
+	return (i < BITS_TO_LONGS(MAX_BPF_STACK_SLOTS) ? slots[i] << MAX_BPF_EXT_REG : 0) |
+	       (i ? slots[i - 1] >> (BITS_PER_LONG - MAX_BPF_EXT_REG) : 0);
+}
+
+static inline void bpf_add_slots(unsigned long *mask, const unsigned long *slots, u32 bits)
+{
+	u32 i;
+
+	for (i = 0; i < BITS_TO_LONGS(bits); i++)
+		mask[i] |= bpf_slots_to_xreg_word(slots, i);
+}
+
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3a9dc2936..68f3127ea07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21406,6 +21406,7 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool do_print_state = true, from_unproven;
+	u32 held;
 
 	for (;;) {
 		struct bpf_insn *insn;
@@ -21524,9 +21525,12 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 			return err;
 
 		bpf_equations_before_insn(env);
+		held = held_cnt(state);
 		from_unproven = reads_from_unproven(env);
 		fixups = insn_aux->fixups;
 		err = do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn(env);
+		insn_aux->releases |= held_cnt(state) < held && err != PROCESS_BPF_EXIT;
+		insn_aux->acquires |= held_cnt(state) > held;
 		if (nospec_ends_path(env, state, err)) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
@@ -25105,13 +25109,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	bpf_free_subprog_jts(env);
-
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
 	ret = do_check_all(env);
+	bpf_free_subprog_jts(env);
 	/* while the calls are what they are in the program */
 	if (env->log.level & BPF_LOG_STATS)
 		add_insns_of_callees(env);
-- 
2.55.0

