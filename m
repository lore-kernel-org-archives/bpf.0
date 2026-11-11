Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401887;
	b=SZXUX6pRGwlw7Df776dQLxMjF4TU8bia+Vuyuu/hrfDibxXIOKsy2WdGb3YiZkhci9Zq
	 tYByZhJY53viWjFkP7q7PRPqg2oFqa0c6KA8nHCyIsiBwvshy3u/FIuDb4p4W74Zsn7UT
	 uly3D/9FO0rjKKRWRcbms5F7/chiMO1BqEmyyrj1cpK9NrvK4gIRN4B72dZa83QgQ8jJn
	 yWWL2OVrplUgbFmRQoPCmnKjkzOQwSiSkuvgQGPilFjRzollGM1G694OV6d7mUutydm8J
	 mdC6l1Cx7elVcT0dCsxdVcMw88ha8h5/4YH7trB95ia0MnrUcZU3fv8VRTNRcDgNd1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=huSziSFDfkEwGCSPja9m20FprsDct6Mi3V7MWbxgs/g=;
	b=aW4sErmtfqpSfHNTXBw9p9dYQRFj2WB+QoRGtebZ5v9Bvh8kdsSDuN4w83IaS1PRbSEi
	 51hqfqEo6URJ0Ckq9utpmGEtjR8ErPrEgIsWw138Sbb37dHzgpRkHbesA8k9P97r1h2Mp
	 ZdX+Of4NrPd1TxHyApXEhUK7rMTjnxoiIEJvSY36VUAgmS3jk9Dym2GQDkhV0do2BfI0A
	 B4uquyx9rmxyYRBRHLlAni19/MT59qgJjHCCUtYwgwZIRpFnncVNIJu5YMvh2fXrpR5kt
	 K4hph0eqRcwIx3UZlvoVh1fBaFULxeVHglAM/Nn+f6sFDvdRSXFs6kr+grlGqlkDL5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMs8wev1;
	arc=none smtp.remote-ip=74.125.225.65
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A1606A32A
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 098A1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMs8wev1
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-48e345608cfso927993f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401885; x=1795006685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huSziSFDfkEwGCSPja9m20FprsDct6Mi3V7MWbxgs/g=;
        b=aMs8wev1QdINmCg4ilS9Wn1jRun5RtovD+CG653/qpp3rQ6YabGsOJtb242z2qswQx
         93rd71TV3vpcWtOlxhPO354zEyOz5iZbl5kEpUq3i7t1jQ/WDzmOwnAlrJtwAfpyUkd9
         bovrG4e7z0opM39eI0sQg6X96kQ6mKbEMb1sgnrRV/JCxAwVcSZpLP4jG/6KP2oRFRdq
         iZDPgxmW5/P+kf/krnn0gtKN60ldYkR1Exnr0LM70+8NiO6hYBX8Z87ISc3vp7o9kyrT
         eeoLhRRU6Vb3KoOgqB0p4Z7niIunjIYORtROmWVOmnzrMYmyKCzGnv63D7QSRlFWUsqq
         PCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401885; x=1795006685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=huSziSFDfkEwGCSPja9m20FprsDct6Mi3V7MWbxgs/g=;
        b=eCR1MrPWvZZD1UcjjXFJac63WF0EPs1zroULbHm2UNEmLx9M2saw0OI+2NwXL1cGS6
         mijEOs6shkqT18fPfMJnA7If5hTMpzl6Pkut9WbkLAItmmrlZJtEZ/jcMeECca0vKKYK
         qJv/vJ0nGrHTi7C0YS3nKuQCEB6+TzRlcYgFpjY/Oy2YiuHXlOc++4czOgIocswr8+rt
         yWwD63gGifuHDcyxHC8hA1nilQC8OBEscoVzlERGAi7z78UMofXvbKG98SU6o3XaKkwx
         +UuXHwRFn6uQMJATb4ivesMxDoOvAEyjisNyJ5zd/+rP12/QF9QPYkaHUWs/rUQNgsp6
         J8gw==
X-Gm-Message-State: APuU4Z8JvLaNP/PNH0hKq8Y/ctlm2oMDvXlgS4klNz+dHD4O0PyzHrnp
	kBewtHblu31bGQArr4bQxO6frMe6g+epaOPxV0rrvNc6jLk694fe31BiAbxTLY2ufKA=
X-Gm-Gg: AYBFou3M8zqcfiehAnb7ykC4e7265y5qeeOUtkD3NaMQ3hARd43EdefXNv1tN2xLdZz
	/n0Fz0jZvtyZRnjJ738nXxdot7LhH8d/rP8qU9W67fYpu8To+wsEiqaJBALuJD02Zh1nO2fwMs9
	BSPG4SYabzVLCDTpzJxs1N0ArNNrnHeNdz2UVwSzywDAMFxM2lg2ntIRTwdBLrKrciKtVXJy3lB
	We+kHguPaL/pCIh98/+WDgj2QW0obh8mGJ7I9DC4Um42hov2FsoMRTSd/X52Kuse+22NNIygJUQ
	sqkxlUK/qPu6huuuiOo6gsEl+s4uefAjYjMKP99XoHjr4NaiMmwPb3HkXJgQyaFjBWAvQhEOW3Q
	Almsjw21Qb8rX9PIsLCDYYoARj4kTWE96b9AXa5FOTu79Xms0XOEdJELx2zWslOu1EXj0vt/s2W
	2w7WrXGoz5IOK/qIrJtDhLa4hzbWA1KoTna8LwToP6QwFiC7CEJG05surIASsnqlaftrSrkwDyP
	e4j6DvGSb5HgKGMYBUD6crAFLG+INzmzvc0MuyvKUUNEh82mYP+CCLhyHVGXhdN7Clg6ttdgfPQ
	m7aY1MuUsUkvPYJia/TaVb4J0x963YG9VtHzwIRa1Nhpmxo8SJgBH0UsFPMGL8p7/uRaWj2AuKV
	cLhyfCPfad+f3WisypyPejEZH+5zM1auX866lrDTrGjdFaW5cHRbbDnnOpZR2Sel1bM7VRdPmbf
	iGHtbgicF9ZZOkj6A=
X-Received: by 2002:a05:6000:4a1b:b0:491:3fdd:af42 with SMTP id ffacd0b85a97d-499c80df762mr3598844f8f.37.1794401885092;
        Wed, 11 Nov 2026 04:58:05 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4989a2a505asm9221440f8f.13.2026.11.11.04.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:04 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 21/29] bpf: Support callx when a callee releases resources
Date: Wed, 11 Nov 2026 13:57:19 +0100
Message-ID: <0847523e18df54ccf22c46885001d309841a60c2.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11848; i=memxor@gmail.com; h=from:subject:message-id; bh=zU2wn8dpx0b6KW7/k/24I5rYdtc+0ADgRiKl+Y+OOxQ=; b=kA0DAAoWRy03e2NUL4MByyZiAGr0XKKgZVl41377/SGohqMCmZ3PWnb+FLHozn5v8tRa3F6S/ Yh1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmr0XKIACgkQRy03e2NUL4Px6gD+K1f8 uRXlj9Ed76ieG7gk8pUIetIFlkJ0vGmUrTS7PcsA/3NnJiPPHUcG1fTlEDsArLPuQZC2bWSbKLa LAkzfSJkO
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently a callx transfers no reference, and its caller does not clear
a hidden slot before it. A subprog that is called through a function
pointer can release a resource of its caller only if the caller keeps
the resource without a hidden slot.

A callx can call one of several subprogs, but the instructions inserted
before it run whichever subprog is called. These are the instructions
that clear the caller's hidden slot, both for a transferred reference
and for a resource that the callee releases without a transfer. They are
correct only if all the subprogs agree on what they release.

Treat a callx like a direct call, and record for each subprog it can
call which resources that subprog leaves with the caller:

 - A reference that the caller passes in an argument through which the
   subprog does not release. If the reference has a hidden slot and the
   callx transfers it to another subprog in the same argument, the
   program is rejected.
 - Every resource of the caller, if the subprog releases no resources of
   its callers. Such a subprog is not verified in the context of its
   callers, so its return does not report that the caller still holds
   the resource. Recording it at the call stops the caller from clearing
   its hidden slot before the callx.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 ++++
 kernel/bpf/frame_desc.c      | 94 +++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 10 +++-
 3 files changed, 104 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 03290f7e42b5..67ae2631019f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1367,10 +1367,19 @@ struct bpf_res_rel {
  * acquisition of the caller acquired, without being handed it. The caller
  * clears its slot in front of the call when no throw finds it holding the
  * resource there and no return from the call does, see frame_desc.c.
+ *
+ * A callx calls one of several subprogs, and what is put in front of it runs
+ * whichever it calls: it has a record as well for what a subprog it calls
+ * leaves with the caller, see bpf_frame_desc_record_callx().
  */
 struct bpf_res_call {
 	u32 insn;	/* the call; U32_MAX when the caller is not in the state */
 	u16 acq;	/* index of the acquisition */
+	/*
+	 * The arguments, a bit per register, that a callx passes it in to a
+	 * subprog that does not release through them.
+	 */
+	u8 lent;
 	bool released;
 	bool held_after; /* some return from the call finds the caller holding it */
 	bool clear;	/* decided once the pass is over */
@@ -2405,6 +2414,7 @@ void bpf_frame_desc_record_sections(struct bpf_verifier_env *env, int subprog, b
 				    bool preempt);
 int bpf_frame_desc_record_call(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			       struct bpf_func_state *callee, int callsite);
+int bpf_frame_desc_record_callx(struct bpf_verifier_env *env, int subprog, int callsite);
 bool bpf_frame_desc_keeps(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			  int f, const struct bpf_reg_state *reg);
 u16 bpf_frame_desc_kept_regs(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index 6679f134b14e..11b2546bc179 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -39,7 +39,9 @@
  *    call: it is the callee's from its entry, and no longer the caller's.
  *    What it releases otherwise, the lock of its caller for one, has no
  *    slot, or one the caller can empty in front of the call, see
- *    bpf_frame_desc_record_call() and foreign_release().
+ *    bpf_frame_desc_record_call() and foreign_release(). A callx does both
+ *    for every subprog it may call, so they have to agree on what they
+ *    release, see bpf_frame_desc_record_callx().
  *  - A slot goes with its frame. A reference a subprog returns in R0 is
  *    acquired by the call for the caller, like the call of a kfunc that
  *    returns one, and one it was handed and did not release it gives back.
@@ -918,8 +920,8 @@ int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
 
 /*
  * Frame @callee of @st is entered with its arguments in place, by the call at
- * insn @callsite of the frame below it when @st is given; a callback, a
- * callx and a function verified on its own come with none.
+ * insn @callsite of the frame below it when @st is given; a callback and a
+ * function verified on its own come with none.
  *
  * What a subprog releases of its caller's through an argument, see
  * bpf_subprog_info::consumes, the call hands over to it: the reference the
@@ -981,6 +983,56 @@ int bpf_frame_desc_record_call(struct bpf_verifier_env *env, struct bpf_verifier
 	return 0;
 }
 
+/*
+ * The callx at insn @callsite of the current frame calls @subprog, one of the
+ * subprogs it may call. What the frame puts in front of the callx runs
+ * whichever it calls: the insns that take what it hands over out of its slot,
+ * and the one that empties the slot of what a callee releases without being
+ * handed it, see foreign_cleared(). So note what this subprog leaves with the
+ * frame:
+ *
+ *  - What the frame holds and passes it in an argument that it does not
+ *    release through. Another subprog may be handed it in that argument, and
+ *    the slot would be emptied for this one as well, see slot_can_be_kept().
+ *  - All that the frame holds, when the subprog releases nothing of its
+ *    callers'. It is not verified in their context then, so its return has
+ *    no frame to say so, see bpf_frame_desc_record_exit().
+ */
+int bpf_frame_desc_record_callx(struct bpf_verifier_env *env, int subprog, int callsite)
+{
+	const struct bpf_subprog_info *sub = &env->subprog_info[subprog];
+	struct bpf_verifier_state *st = env->cur_state;
+	const struct bpf_func_state *frame = st->frame[st->curframe];
+	const struct bpf_reference_state *ref;
+	struct bpf_res_call *c;
+	int i, k;
+	u8 lent;
+	s16 adj;
+
+	if (!env->describe_frames || st->speculative)
+		return 0;
+	for (i = 0; i < st->acquired_refs; i++) {
+		ref = &st->refs[i];
+		if (ref->frameno != st->curframe || !ref->acq)
+			continue;
+		lent = 0;
+		for (k = BPF_REG_1; k <= BPF_REG_5; k++)
+			if (!(sub->consumes & BIT(k)) && ref->type == REF_TYPE_PTR &&
+			    !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
+			    reg_ref_off(&frame->regs[k], ref->id, &adj))
+				lent |= BIT(k);
+		if (!lent && sub->releases_inherited)
+			continue;
+		c = call_note(env, callsite, ref->acq - 1);
+		if (!c)
+			return -ENOMEM;
+		c->lent |= lent;
+		if (!sub->releases_inherited)
+			c->held_after = true;
+	}
+	return 0;
+}
+
 /*
  * A subprog called at insn @callsite returned to the current frame of @st
  * with @r0, holding the reference refs[@idx], which is the caller's from here
@@ -1352,10 +1404,12 @@ static int emit_acquire_after(struct bpf_insn *buf, const struct bpf_res_acq *a)
  * with it at the call: the slot is empty then for as long as the callee can
  * throw after the release, and it was no use before it. The call is one of a
  * subprog: a helper that calls a callback may not call it at all, and the
- * holder has the resource after it then.
+ * holder has the resource after it then. A callx is fine when that holds for
+ * every subprog it calls, see bpf_frame_desc_record_callx().
  */
 static bool foreign_cleared(struct bpf_verifier_env *env, u16 acq, const u32 *new_of, u32 orig_len)
 {
+	const struct bpf_insn *insn;
 	bool any = false;
 	u32 i, j;
 
@@ -1367,7 +1421,8 @@ static bool foreign_cleared(struct bpf_verifier_env *env, u16 acq, const u32 *ne
 		if (c->held_after || c->insn >= orig_len)
 			return false;
 		/* a helper may never call the callback that releases */
-		if (!bpf_pseudo_call(&env->prog->insnsi[new_of[c->insn]]))
+		insn = &env->prog->insnsi[new_of[c->insn]];
+		if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn))
 			return false;
 		for (j = 0; j < env->res_loc_cnt; j++)
 			if (env->res_locs[j].acq == acq &&
@@ -1381,11 +1436,26 @@ static bool foreign_cleared(struct bpf_verifier_env *env, u16 acq, const u32 *ne
 	return any;
 }
 
+/*
+ * Does the callx @insn pass what @acq acquired in R@reg to a subprog that
+ * leaves it with its caller?
+ */
+static bool call_lends(const struct bpf_verifier_env *env, u32 insn, u16 acq, u8 reg)
+{
+	u32 i;
+
+	for (i = 0; i < env->res_call_cnt; i++)
+		if (env->res_calls[i].insn == insn && env->res_calls[i].acq == acq)
+			return env->res_calls[i].lent & BIT(reg);
+	return false;
+}
+
 /*
  * Acquisition @acq needs a slot. Can the insns that keep it be emitted? They
  * are emitted once per insn, so the insn has to acquire in one way, with the
  * handle in a register, and every call that releases what it acquired has to
- * take the handle in one way that insns can compare with the slot.
+ * take the handle in one way that insns can compare with the slot. A callx
+ * that hands it over has to do so whichever subprog it calls.
  */
 static int slot_can_be_kept(struct bpf_verifier_env *env, u32 acq)
 {
@@ -1409,7 +1479,14 @@ static int slot_can_be_kept(struct bpf_verifier_env *env, u32 acq)
 	}
 	for (i = 0; i < env->res_rel_cnt; i++) {
 		r = &env->res_rels[i];
-		if (r->acq != acq || !r->bad)
+		if (r->acq != acq)
+			continue;
+		if (call_lends(env, r->insn, acq, r->reg)) {
+			verbose(env, "frame_desc: the callx at insn %d passes what R%d holds to a subprog that releases it and to one that does not, which is not supported in a program that throws\n",
+				r->insn, r->reg);
+			return -EINVAL;
+		}
+		if (!r->bad)
 			continue;
 		if (r->bad == BPF_RES_REL_NO_REG)
 			verbose(env, "frame_desc: insn %d releases a resource whose handle is in no argument register\n",
@@ -1778,7 +1855,8 @@ int bpf_frame_desc_emit(struct bpf_verifier_env *env)
 
 		for (k = i; k < n && items[k].idx == idx; k++)
 			;
-		if (verifier_bug_if(idx >= len || env->prog->insnsi[idx].code != (BPF_JMP | BPF_CALL),
+		if (verifier_bug_if(idx >= len || (env->prog->insnsi[idx].code != (BPF_JMP | BPF_CALL) &&
+						   !bpf_is_callx(&env->prog->insnsi[idx])),
 				    env, "resource kept at insn %d, not a call", idx)) {
 			ret = -EFAULT;
 			break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f41095f4f1f..51896b200161 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11451,9 +11451,10 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	err = set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
-	/* a plain call hands the callee what it releases of the caller's, see frame_desc.c */
+	/* the call of a subprog hands it what it releases of the caller's, see frame_desc.c */
 	err = bpf_frame_desc_record_call(env, set_callee_state_cb == set_callee_state &&
-					 bpf_pseudo_call(&env->prog->insnsi[callsite]) ? state : NULL,
+					 (bpf_pseudo_call(&env->prog->insnsi[callsite]) ||
+					  bpf_is_callx(&env->prog->insnsi[callsite])) ? state : NULL,
 					 callee, callsite);
 	if (err)
 		goto err_out;
@@ -12280,6 +12281,11 @@ static int check_func_callx_one(struct bpf_verifier_env *env, int subprog, int *
 		return err;
 	env->subprog_info[subprog].via_callx = true;
 
+	/* what the insns in front of the callx do goes for every subprog it calls, see frame_desc.c */
+	err = bpf_frame_desc_record_callx(env, subprog, *insn_idx);
+	if (err)
+		return err;
+
 	return check_static_func_call(env, subprog, insn_idx);
 }
 
-- 
2.53.0

