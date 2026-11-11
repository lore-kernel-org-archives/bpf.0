Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401886;
	b=nBkCvBXIE7y4rX7opHPsZHUql00QSHg9LtbrV/S2BnSTOLFxgvwuGMri48V2+cyqEFl5
	 rcxTyqwmu6upc9u6L2gts3PcQpDWofR71q/yyXUxOTJzjTiCQrQtyn74bUQqv/tlrKCVv
	 jgyFAtUUO+nfx3cHLsY9lwutJcINIPUSEGeR2R2cynSYWB4SuPgGYZmNf5vCbNJ1tBCBy
	 2CA/r5tkMkpWLnkC1nfngOsbfI6762vKD/5lU73qtft3BOYCFSRu0ccUcEUk4dL93iypR
	 aDm1nKJYwdFoz22usmwUlRVX+nTURB5pP0tyg2Ef9RetfCjd4bGwuexlbx/oKFn5vZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=N6jUrSFXUcwfWxtGicepk9qBQ40NnRsRRNYRmcvv6VI=;
	b=xTC7Yd2q5em8Gt9/PTmpE3h8v0+BzhwkhQ9Pkrsd2CMwmO53523nZCY37i8rMwMVpLWE
	 kxxaowrWYOvgrPNlpGLFS/0azAQvWvbRa8wqwt61UdeSDhlTm1zuseW8p7m7tQQa9uKd/
	 aPxVk4NaiWm/dFuXWOyVU1pwQqSCyyMIkP3FWXza99divhVJQX5M9HHFMGuEss1PB2WxT
	 O0g4k9x7i2i3kWfb7pF/ZucHJGx415Nmt+onN3bdyt2m+uAVN6zCB/hj+ex7lUejgJ3O6
	 L21PLdxnjbgffL5RIy0d+EJXMcF9z9HgxDgVZHy6iUWPNejWDezDRSIaljoMarYw0mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kcGwN0wf;
	arc=none smtp.remote-ip=209.85.221.66
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379E606A335
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A379E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kcGwN0wf
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4910b863b84so2019617f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401884; x=1795006684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6jUrSFXUcwfWxtGicepk9qBQ40NnRsRRNYRmcvv6VI=;
        b=kcGwN0wfxQ2gF6V9FpP5G0I6Cpf9oXKkmexCQv/D98oso+xMLbh/R8m+/Xir5b5hIu
         YV7F+Hl5VgMen/+AV0fdmYqDwQFALsfmZtFWAd4cofIBM/a0tsK077y62FuMg14m+CLl
         gIvO9LbsRAjimdfTVE94kvjRtE5K0KWvv6GXjT2G55ulF/murj2gKriUJA0ojC+vbom1
         c6ipTI7EqXM6VBVDkpcvxm3l+poed3nwUg+bb2hI/K8X+F4sfZC2voFInKQgb1nHEg0t
         5bqKjziv7quck1uCYBB6cJuJr8/nGe+JcYM+91kZHTaz2fAvu6jyIHnS2IAjbwPFxdK4
         yl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401884; x=1795006684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N6jUrSFXUcwfWxtGicepk9qBQ40NnRsRRNYRmcvv6VI=;
        b=Xp7n2V5XAWMeCqrgSQxnYtfnVHX/s2VClNr5rwmB0ZWNctg+9B9MwGpnFdlR1hevXi
         k4CMvVmxs7+qK5kY8wgsGDKOQuHJJ4i7LTxMM0q6t5FXaa9q0be8FscS28Ut6l4YmlSZ
         y7LMixYwcBsDmDoHmVtMuH+pvid2ex8ZcQotTxo5uBjhUUxyLYyFfwn8MzQA1gg/m/D5
         0/71wCqMwlMF8WTMNAFGrmTputinpnsm4rZYOiz5vcTG9fQ/BxQOwuwItSqWflSXFUcF
         VrviGE1+uP1o+P562+F+UEjMgxVJlDth7aqsIndt3p3yccFxmyuV6PZm8tsEd0ehp6HF
         QdBA==
X-Gm-Message-State: APuU4Z80kFt1popD9U5n6PlWWsp18ekau2LC009hAzSFzSCFGnkRcIAW
	Ag+5uNKqVKZBwHdTnN8yM64e3g7egNUBpkstQ/cRB8sL8wiT+vteBqNgxUat38pviYs=
X-Gm-Gg: AYBFou1CXwKGDO2kbWSCIIVT9q7+NmsuwRkctVAkAA3/zbMWJhGH2zyAokUWmMtDPVS
	vFLk7llIxgoxhPeB2y5WvwhrYQBo+jHcs98lkSnJfiFMBZFnO4M8+d+TuyNqtOEp5o37tirNknH
	8HPaepJFVCt0304xWxulHwEG/1MHiQnYlV8ogsWQxUkhyxqvnd3hh4KEgt70Mx6aisTRPLaaRoA
	kpzAdFDHNw61tyGswL5zpmjztEdDAPP3fIe50hBTkXR+x+hm6FeHteAtGMnISv6UPopgjtP6pJe
	JEHOb5Oysq8w/il4NK4o73F267TZVWYOuemCeaAKzHCbvhR4M211vC+LbdPqSX68ZiseyocoN/d
	BhTB9p2sMsSTpvgm8jU5dXBLlcWZ0sxaEPjmSICBbGc0Mfwccstz9JY1HsMyvnEvp/d3QWzXIoE
	IDblXEUuFTPBWM5JXqZV+F6300wQgD0P2nwJms5qUtg+PmGwJxRTtDJ2NkiIBsZVtIA8oZvUSat
	mYH/oiWETnJR1i6XWN8dv+90T630WqfB5zFpLnlJP7FjCpcZiaK6iGQSHm6zytY2k08bC10iQ97
	5LTJAPhThLmJjEp2HY/4lafFfpCxsq3mR5R5cYlVhAiXycC9C2bNpSBsU7AV5bLWPCJ7szX7+h1
	0kK00JQ49y5wOwJBykRfwRRfhCFZPD6gkV6K3hJK8f4TRuGBLdYv2bVWssq1RFcvLI4PLxSuyRg
	QxTMPXyWoQQX7Ibg==
X-Received: by 2002:a5d:6f07:0:b0:491:cd7:e96b with SMTP id ffacd0b85a97d-49996a31474mr5440484f8f.15.1794401883758;
        Wed, 11 Nov 2026 04:58:03 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c30b1sm10969574f8f.46.2026.11.11.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:03 -0800 (PST)
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
Subject: [PATCH bpf-next v1 20/29] bpf: Transfer a reference to the callee that releases it
Date: Wed, 11 Nov 2026 13:57:18 +0100
Message-ID: <97453d9e1f65a31c7f6ffbc09a7eb9f89913c5f3.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25175; i=memxor@gmail.com; h=from:subject:message-id; bh=QpJRSwev+A97IDG3dZubFCEWaj5ZdocIwAsx1mnLzP0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzCLX3q677q5XZxzdsfieLJPBShdJB2P+zvWnLOoVl 7xitHvXUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlkxDAyTNd4+/fotddd5WtE CmZPuRHB+3/Ng8Wnyg29tt3x+JQxkY2RoYX/3LPc2mUre/jmnJqXpuPW+LhN8O1fhncrRAsF/zh eYQYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently a callee can release a reference that its caller keeps in a
hidden slot only if it does not throw before the release, since the
caller clears the slot before the call. A subprog that is passed an
object, may throw, and then drops the object is rejected if its caller
keeps the object in a hidden slot.

Transfer the reference to the callee at the call:

 - When the verifier sees a subprog release a reference of its caller,
   it records which argument register the reference was passed in.
 - A direct call to the subprog then transfers the reference that the
   caller holds and passes in that register. For the caller, the call is
   the release: the handle is cleared from its hidden slot, if it has
   one, before the call. For the callee, its entry is the acquisition,
   with the handle in the argument register. The callee holds the
   reference like one it acquired itself: its sites describe it, or it
   gets a hidden slot that the entry of the callee fills from the
   argument.
 - A callee that returns without releasing the reference gives it back
   to the caller, under the caller's original acquisition.

Recording the argument changes what the current round of the main pass
has recorded so far, so the round is run again when one is found.

Only references are transferred. Other resources, such as a lock, stay
with the caller even if a pointer to them is passed.

This allows a subprog that drops an object or discards a record that it
is passed, and may throw both before and after.

Still rejected:

 - a reference that a callee is passed and returns without releasing on
   some paths, if the caller keeps it in a hidden slot;
 - a subprog that keeps a transferred reference in a hidden slot, if
   another call passes something else in that argument;
 - a callx to a subprog that releases a reference that its caller keeps
   in a hidden slot.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  30 +++++-
 kernel/bpf/frame_desc.c      | 192 ++++++++++++++++++++++++++++++-----
 kernel/bpf/join.c            |   6 +-
 kernel/bpf/states.c          |   6 +-
 kernel/bpf/verifier.c        |  12 +++
 5 files changed, 212 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a98023c239c4..03290f7e42b5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -524,6 +524,13 @@ struct bpf_func_state {
 	 */
 	u32 rcu_released_below;
 	u32 preempt_released_below;
+	/*
+	 * The ids of what the frame was called with in R1 to R5, and the
+	 * acquisition, plus one, each was of in the caller when the call
+	 * handed it to the frame, see bpf_frame_desc_record_call().
+	 */
+	u32 entry_arg_id[5];
+	u16 entry_arg_acq[5];
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -1112,6 +1119,13 @@ struct bpf_subprog_info {
 	bool stack_args_from_code: 1;
 	/* it releases what its caller holds, so it's verified in the context of such caller */
 	bool releases_inherited: 1;
+	/*
+	 * The arguments, a bit per register, that it releases what its caller
+	 * holds through: the call hands that to it, see frame_desc.c. And those
+	 * of them that some call passes something else in.
+	 */
+	u8 consumes;
+	u8 entry_none;
 	/*
 	 * The kinds of sections, a bit each, that a callee returned to it in
 	 * more or fewer of than it called the callee in: a count it keeps in a
@@ -1260,6 +1274,7 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 #define BPF_RES_F_DEREF		BIT(2)	/* the handle is the first word of a dynptr on the stack */
 #define BPF_RES_F_CTX		BIT(3)	/* a __ref argument the kernel passes the main program */
 #define BPF_RES_F_NO_PTR	BIT(5)	/* a lock that no pointer to what it is in leads to */
+#define BPF_RES_F_ENTRY		BIT(4)	/* what its caller hands a subprog in the register */
 
 /*
  * A call that acquires a resource, see frame_desc.c. When a frame can be
@@ -1269,7 +1284,11 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
  * per acquiring call.
  */
 struct bpf_res_acq {
-	u32 insn;	/* the insn as the main pass named it; the argument with BPF_RES_F_CTX */
+	/*
+	 * The insn as the main pass named it; the argument with BPF_RES_F_CTX,
+	 * the first insn of the subprog with BPF_RES_F_ENTRY.
+	 */
+	u32 insn;
 	u16 res;	/* the class of what it acquires */
 	u8 reg;		/* R0 for what the call returns, else the argument that is the handle */
 	u8 flags;	/* BPF_RES_F_* */
@@ -1279,6 +1298,7 @@ struct bpf_res_acq {
 	bool held;	/* some frame holds what it acquired at a site */
 	bool slot;	/* and some site cannot say where: the handle is kept in a slot */
 	u32 foreign;	/* an insn of another frame that releases what it acquired, plus one */
+	bool handed_back; /* a callee it was handed to returned holding it */
 	/*
 	 * An insn, plus one, that leaves what it acquired with another frame
 	 * than the one that ran the acquisition: the call a subprog returns
@@ -1344,9 +1364,9 @@ struct bpf_res_rel {
 
 /*
  * A call of a subprog during which a frame above the caller releases what an
- * acquisition of the caller acquired. The caller clears its slot in front of
- * the call when no throw finds it holding the resource there and no return
- * from the call does, see frame_desc.c.
+ * acquisition of the caller acquired, without being handed it. The caller
+ * clears its slot in front of the call when no throw finds it holding the
+ * resource there and no return from the call does, see frame_desc.c.
  */
 struct bpf_res_call {
 	u32 insn;	/* the call; U32_MAX when the caller is not in the state */
@@ -2383,6 +2403,8 @@ int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delt
 int bpf_frame_desc_record_exit(struct bpf_verifier_env *env);
 void bpf_frame_desc_record_sections(struct bpf_verifier_env *env, int subprog, bool rcu,
 				    bool preempt);
+int bpf_frame_desc_record_call(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			       struct bpf_func_state *callee, int callsite);
 bool bpf_frame_desc_keeps(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			  int f, const struct bpf_reg_state *reg);
 u16 bpf_frame_desc_kept_regs(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index d2ad02925f06..6679f134b14e 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -34,12 +34,15 @@
  * A slot belongs to one frame and holds one handle, so a program that throws
  * keeps to what that can express:
  *
- *  - A callee cannot reach the slot of its caller. What it releases of its
- *    caller's has no slot, or one the caller can empty in front of the
- *    call, see foreign_release().
+ *  - A callee cannot reach the slot of its caller. A reference it releases
+ *    that its caller passes it in a register is handed over to it by the
+ *    call: it is the callee's from its entry, and no longer the caller's.
+ *    What it releases otherwise, the lock of its caller for one, has no
+ *    slot, or one the caller can empty in front of the call, see
+ *    bpf_frame_desc_record_call() and foreign_release().
  *  - A slot goes with its frame. A reference a subprog returns in R0 is
  *    acquired by the call for the caller, like the call of a kfunc that
- *    returns one.
+ *    returns one, and one it was handed and did not release it gives back.
  *    Whatever else a frame comes to hold of what another frame acquired can
  *    have no slot: a lock a subprog returns holding, or a stack object a
  *    callee creates in the stack of its caller. Likewise a subprog whose
@@ -715,8 +718,13 @@ static struct bpf_res_call *call_note(struct bpf_verifier_env *env, u32 insn, u1
 /*
  * The current insn releases @ref, which a frame below the current one owns.
  * Nothing tells a callee where the slot of its caller is, so it cannot clear
- * one. There are two ways out:
+ * one. There are three ways out:
  *
+ *  - The call hands what the callee releases over to it, when it is passed in
+ *    a register: the callee owns it from its entry, as if it had acquired it
+ *    there, see bpf_frame_desc_record_call(). Which arguments a subprog
+ *    releases is found out here, and the round of the main pass is done again
+ *    with that known.
  *  - What the caller holds without a slot needs none cleared: its sites say
  *    where the handle is on the visits that find it held, and say nothing on
  *    those that find it released.
@@ -726,9 +734,7 @@ static struct bpf_res_call *call_note(struct bpf_verifier_env *env, u32 insn, u1
  *
  * The functions between the owner and the current frame are verified in the
  * context of their callers from now on, so that every throw sees the frames
- * below it as they are. The round of the main pass that finds one out is done
- * again, since it recorded the frames of its callers at the call, holding
- * what they held then.
+ * below it as they are.
  */
 static int foreign_release(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			   const struct bpf_reference_state *ref, struct bpf_res_acq *acq)
@@ -736,7 +742,7 @@ static int foreign_release(struct bpf_verifier_env *env, const struct bpf_verifi
 	const struct bpf_func_state *below = st->frame[ref->frameno + 1];
 	struct bpf_subprog_info *sub;
 	struct bpf_res_call *c;
-	int f;
+	int f, k;
 
 	for (f = ref->frameno + 1; f <= st->curframe; f++) {
 		sub = &env->subprog_info[st->frame[f]->subprogno];
@@ -745,6 +751,21 @@ static int foreign_release(struct bpf_verifier_env *env, const struct bpf_verifi
 		sub->releases_inherited = true;
 		env->frame_desc_redo = true;
 	}
+	/* every frame it was passed down through in a register is handed it by the one below */
+	for (f = ref->frameno + 1; f <= st->curframe; f++) {
+		if (!ref->id || ref->type != REF_TYPE_PTR || (acq->flags & BPF_RES_F_ARG))
+			break;
+		for (k = BPF_REG_1; k <= BPF_REG_5; k++)
+			if (st->frame[f]->entry_arg_id[k - 1] == ref->id)
+				break;
+		if (k > BPF_REG_5)
+			break;
+		sub = &env->subprog_info[st->frame[f]->subprogno];
+		if (sub->consumes & BIT(k))
+			continue;
+		sub->consumes |= BIT(k);
+		env->frame_desc_redo = true;
+	}
 	if (!acq->foreign)
 		acq->foreign = env->insn_idx + 1;
 	c = call_note(env, ref->frameno < 0 ? U32_MAX : below->callsite, ref->acq - 1);
@@ -828,6 +849,10 @@ int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delt
  *
  *  - A reference in R0 the call acquires for the caller, like the call of a
  *    kfunc that returns one, see bpf_frame_desc_record_return().
+ *  - What the call handed the frame to release, and it did not on this path,
+ *    is its caller's again, as what the caller acquired it as. The caller has
+ *    emptied the slot of that, if it has one, see
+ *    bpf_frame_desc_record_call().
  *  - Anything else, a lock the frame took for its caller, stays what it was
  *    acquired as, and can have no slot: the sites of the caller have to say
  *    where it is, or no throw may find it held, see
@@ -843,7 +868,10 @@ int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *st = env->cur_state;
 	const struct bpf_func_state *frame = st->frame[st->curframe];
+	const struct bpf_res_acq *acq;
 	struct bpf_res_call *c;
+	u16 back;
+	s16 adj;
 	int i;
 
 	if (!env->describe_frames || st->speculative)
@@ -855,6 +883,25 @@ int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
 								       frame->rcu_released_below,
 					       st->active_preempt_locks != frame->entry_preempt_locks +
 									   frame->preempt_released_below);
+	for (i = 0; st->curframe && i < st->acquired_refs; i++) {
+		struct bpf_reference_state *ref = &st->refs[i];
+
+		if (!ref->res || ref->frameno != st->curframe)
+			continue;
+		acq = &env->res_acqs[ref->acq - 1];
+		if (!(acq->flags & BPF_RES_F_ENTRY))
+			continue;
+		/* the call acquires what R0 carries */
+		if (ref->type == REF_TYPE_PTR && ref->id &&
+		    reg_ref_off(&frame->regs[BPF_REG_0], ref->id, &adj))
+			continue;
+		back = frame->entry_arg_acq[acq->reg - 1];
+		if (!back)
+			continue;
+		env->res_acqs[back - 1].handed_back = true;
+		ref->acq = back;
+		ref->frameno = st->curframe - 1;
+	}
 	/* does the caller hold after the call what a callee may release in it? */
 	if (!st->curframe || !env->subprog_info[frame->subprogno].releases_inherited)
 		return 0;
@@ -869,6 +916,71 @@ int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * Frame @callee of @st is entered with its arguments in place, by the call at
+ * insn @callsite of the frame below it when @st is given; a callback, a
+ * callx and a function verified on its own come with none.
+ *
+ * What a subprog releases of its caller's through an argument, see
+ * bpf_subprog_info::consumes, the call hands over to it: the reference the
+ * caller holds and passes in that register. For the caller the call releases
+ * it, so its handle leaves the slot of the caller in front of the call. For
+ * the callee its entry acquires it, with the handle in the register, and it
+ * holds it like what it acquires itself: its sites say where it keeps it, or
+ * a slot of its own does, filled at its entry.
+ *
+ * That slot is filled on every call, so every call has to pass what its
+ * caller holds, or NULL: bpf_subprog_info::entry_none has the arguments some
+ * call passes something else in.
+ */
+int bpf_frame_desc_record_call(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			       struct bpf_func_state *callee, int callsite)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[callee->subprogno];
+	struct bpf_reference_state *ref;
+	int i, k, acq, err;
+	s16 adj;
+
+	if (!env->describe_frames || (st && st->speculative))
+		return 0;
+	for (k = BPF_REG_1; k <= BPF_REG_5; k++) {
+		struct bpf_reg_state *reg = &callee->regs[k];
+
+		callee->entry_arg_id[k - 1] = 0;
+		callee->entry_arg_acq[k - 1] = 0;
+		if (reg->type == SCALAR_VALUE || reg->type == NOT_INIT) {
+			if ((sub->consumes & BIT(k)) && !bpf_register_is_null(reg))
+				sub->entry_none |= BIT(k);
+			continue;
+		}
+		callee->entry_arg_id[k - 1] = reg->id;
+		if (!(sub->consumes & BIT(k)))
+			continue;
+		for (i = 0, ref = NULL; st && i < st->acquired_refs; i++) {
+			ref = &st->refs[i];
+			if (ref->frameno == callee->frameno - 1 && ref->acq && ref->type == REF_TYPE_PTR &&
+			    !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
+			    reg_ref_off(reg, ref->id, &adj))
+				break;
+			ref = NULL;
+		}
+		if (!ref) {
+			sub->entry_none |= BIT(k);
+			continue;
+		}
+		err = rel_add(env, callsite, ref->acq - 1, k, 0, adj, 0);
+		if (err)
+			return err;
+		acq = acq_add(env, sub->start, ref->res - 1, k, BPF_RES_F_ENTRY, adj, 0);
+		if (acq < 0)
+			return acq;
+		callee->entry_arg_acq[k - 1] = ref->acq;
+		ref->frameno = callee->frameno;
+		ref->acq = acq + 1;
+	}
+	return 0;
+}
+
 /*
  * A subprog called at insn @callsite returned to the current frame of @st
  * with @r0, holding the reference refs[@idx], which is the caller's from here
@@ -1129,9 +1241,11 @@ void bpf_frame_desc_reset(struct bpf_verifier_env *env)
 	env->res_loc_cnt = 0;
 	env->res_call_cnt = 0;
 	env->frame_desc_redo = false;
-	/* that the subprogs release what their callers hold stays */
-	for (i = 0; i < env->subprog_cnt; i++)
+	/* what the subprogs release stays, what the calls of the round passed them goes */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		env->subprog_info[i].entry_none = 0;
 		env->subprog_info[i].section_delta = 0;
+	}
 	for (i = 0; i < env->prog->len; i++) {
 		env->insn_aux_data[i].res_none = false;
 		env->insn_aux_data[i].res_none_r0 = false;
@@ -1232,13 +1346,13 @@ static int emit_acquire_after(struct bpf_insn *buf, const struct bpf_res_acq *a)
 
 /*
  * A frame above the one that holds what acquisition @acq acquired releases it,
- * and the acquisition has a slot. The holder can clear the slot itself, in
- * front of the call the release happens in, when the resource is gone after
- * every such call and no throw finds the holder with it at the call: the slot
- * is empty then for as long as the callee can throw after the release, and it
- * was no use before it. The call is one of a subprog: a helper that calls a
- * callback may not call it at all, and the holder has the resource after it
- * then.
+ * without being handed it, and the acquisition has a slot. The holder can
+ * clear the slot itself, in front of the call the release happens in, when
+ * the resource is gone after every such call and no throw finds the holder
+ * with it at the call: the slot is empty then for as long as the callee can
+ * throw after the release, and it was no use before it. The call is one of a
+ * subprog: a helper that calls a callback may not call it at all, and the
+ * holder has the resource after it then.
  */
 static bool foreign_cleared(struct bpf_verifier_env *env, u16 acq, const u32 *new_of, u32 orig_len)
 {
@@ -1282,7 +1396,7 @@ static int slot_can_be_kept(struct bpf_verifier_env *env, u32 acq)
 	for (i = 0; i < env->res_acq_cnt; i++) {
 		b = &env->res_acqs[i];
 		if (i == acq || b->insn != a->insn || b->reg != a->reg ||
-		    (a->flags ^ b->flags) & BPF_RES_F_CTX)
+		    (a->flags ^ b->flags) & (BPF_RES_F_CTX | BPF_RES_F_ENTRY))
 			continue;
 		verbose(env, "frame_desc: insn %d acquires resources of different types on different paths\n",
 			a->insn);
@@ -1387,8 +1501,24 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 			ret = -EINVAL;
 			break;
 		}
+		/* the holder emptied the slot for the callee, which did not release */
+		if (a->handed_back) {
+			verbose(env, "frame_desc: what insn %d acquires is in a hidden slot, and a subprog it is passed to releases it on some paths only, which is not supported in a program that throws\n",
+				a->insn);
+			ret = -EINVAL;
+			break;
+		}
+		/* the slot of what a subprog is handed is filled on every call of it */
+		if ((a->flags & BPF_RES_F_ENTRY) &&
+		    (bpf_find_containing_subprog(env, new_of[a->insn])->entry_none & BIT(a->reg))) {
+			verbose(env, "frame_desc: R%d of the subprog at insn %d is what its caller holds on some calls only, which is not supported in a program that throws\n",
+				a->reg, a->insn);
+			ret = -EINVAL;
+			break;
+		}
 		/* some visit of the insn has nothing a slot can hold where this one has */
-		if (!(a->flags & BPF_RES_F_CTX) && acquires_sometimes(env, new_of[a->insn], a)) {
+		if (!(a->flags & (BPF_RES_F_CTX | BPF_RES_F_ENTRY)) &&
+		    acquires_sometimes(env, new_of[a->insn], a)) {
 			verbose(env, "frame_desc: insn %d acquires a resource on some paths only, or one of a type that cannot be released\n",
 				a->insn);
 			ret = -EINVAL;
@@ -1535,10 +1665,11 @@ static int emit_items(struct bpf_verifier_env *env, const struct res_item *it, i
 }
 
 /*
- * At the entry of each subprog: its slots and counts start out empty, and
- * the main program takes the references the kernel passed it that it keeps
- * in a slot from the context, which R1 points at. The insns go in front of
- * the first one, which a jump to it skips.
+ * At the entry of each subprog: its slots and counts start out empty, but for
+ * what it is handed: the main program takes the references the kernel passed
+ * it that it keeps in a slot from the context, which R1 points at, and a
+ * subprog what its caller hands it from the argument. The insns go in front
+ * of the first one, which a jump to it skips.
  */
 static int emit_entries(struct bpf_verifier_env *env)
 {
@@ -1547,7 +1678,7 @@ static int emit_entries(struct bpf_verifier_env *env)
 	int s, cnt, ret = 0;
 
 	new_of = insns_of_pass(env, &orig_len);
-	buf = kvcalloc(2 * (env->res_acq_cnt + 2), sizeof(*buf), GFP_KERNEL_ACCOUNT);
+	buf = kvcalloc(4 * (env->res_acq_cnt + 2), sizeof(*buf), GFP_KERNEL_ACCOUNT);
 	if (!new_of || !buf) {
 		ret = -ENOMEM;
 		goto out;
@@ -1564,6 +1695,13 @@ static int emit_entries(struct bpf_verifier_env *env)
 			if (a->flags & BPF_RES_F_CTX) {
 				buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_1, a->obj_off);
 				buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_AX, a->off);
+			} else if ((a->flags & BPF_RES_F_ENTRY) && a->adj) {
+				buf[cnt++] = BPF_MOV64_REG(BPF_REG_AX, a->reg);
+				buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 1);
+				buf[cnt++] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, a->adj);
+				buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_AX, a->off);
+			} else if (a->flags & BPF_RES_F_ENTRY) {
+				buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, a->reg, a->off);
 			} else {
 				buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, a->off, 0);
 			}
@@ -1619,8 +1757,10 @@ int bpf_frame_desc_emit(struct bpf_verifier_env *env)
 	for (i = 0; i < env->res_call_cnt; i++)
 		if (env->res_calls[i].clear)
 			items[n++] = (struct res_item) { new_of[env->res_calls[i].insn], i, ITEM_CLEAR };
+	/* the entry of a subprog fills the slots of what it is handed, see emit_entries() */
 	for (i = 0; i < env->res_acq_cnt; i++)
-		if (env->res_acqs[i].slot && !(env->res_acqs[i].flags & BPF_RES_F_CTX))
+		if (env->res_acqs[i].slot &&
+		    !(env->res_acqs[i].flags & (BPF_RES_F_CTX | BPF_RES_F_ENTRY)))
 			items[n++] = (struct res_item) { new_of[env->res_acqs[i].insn], i, ITEM_ACQUIRE };
 	sort(items, n, sizeof(*items), item_cmp, NULL);
 	for (i = 0; i < n; i = k) {
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 87d87d359312..913025ee1f73 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -463,9 +463,11 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 		    fa->entry_rcu_locks != fb->entry_rcu_locks ||
 		    fa->entry_preempt_locks != fb->entry_preempt_locks)
 			return false;
-		/* the sections a frame left of those it was entered in matter to a throw, see frame_desc.c */
+		/* the sections a frame left and what it was handed matter to a throw, see frame_desc.c */
 		if (env->describe_frames && (fa->rcu_released_below != fb->rcu_released_below ||
-					     fa->preempt_released_below != fb->preempt_released_below))
+					     fa->preempt_released_below != fb->preempt_released_below ||
+					     memcmp(fa->entry_arg_acq, fb->entry_arg_acq,
+						    sizeof(fa->entry_arg_acq))))
 			return false;
 		if (!join_loop_stack(fa, fb))
 			return false;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 01eb8d9077ef..ecea6d762e14 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -717,9 +717,11 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	    old->entry_rcu_locks != cur->entry_rcu_locks ||
 	    old->entry_preempt_locks != cur->entry_preempt_locks)
 		return false;
-	/* the sections a frame left of those it was entered in matter to a throw, see frame_desc.c */
+	/* the sections a frame left and what it was handed matter to a throw, see frame_desc.c */
 	if (env->describe_frames && (old->rcu_released_below != cur->rcu_released_below ||
-				     old->preempt_released_below != cur->preempt_released_below))
+				     old->preempt_released_below != cur->preempt_released_below ||
+				     memcmp(old->entry_arg_acq, cur->entry_arg_acq,
+					    sizeof(old->entry_arg_acq))))
 		return false;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec9f77a63197..1f41095f4f1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11451,6 +11451,12 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	err = set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
+	/* a plain call hands the callee what it releases of the caller's, see frame_desc.c */
+	err = bpf_frame_desc_record_call(env, set_callee_state_cb == set_callee_state &&
+					 bpf_pseudo_call(&env->prog->insnsi[callsite]) ? state : NULL,
+					 callee, callsite);
+	if (err)
+		goto err_out;
 
 	/* only increment it after check_reg_arg() finished */
 	state->curframe++;
@@ -11859,6 +11865,12 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 			return err;
 		}
 	}
+	/* what it is called with, should it release some of what it inherits */
+	err = bpf_frame_desc_record_call(env, NULL, callee, insn_idx);
+	if (err) {
+		bpf_free_verifier_state(&entry, false);
+		return err;
+	}
 
 	account_current_path(env);
 	env->subprog_info[subprog].on_its_own = true;
-- 
2.53.0

