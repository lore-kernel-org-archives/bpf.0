Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401880;
	b=Oms9bmyVE8yf6rNVTlK/Btu4l/F0YsnjHf9KgRYo7/1h5DlifWuqH0Nzqp9KTsqSEVsL
	 iHQvAiC5SMtFzNpBYY1L7JVMMjUNDSjiUumasdfQ05KKXxmZcyMyp1+IaEGQtqGpU420B
	 xGh8LqQwUxTVXSpCfNePk8I8JrLTWTz3/eNCljeHu49kS7hbkjyU5xQY2zN5bf5HXeroB
	 YGwBDuKNIzTeL/1EwdI0ZevqeR9zWCOneCjiWUoyYp+W4swuO86d+8LiyQiNowQwDwWFf
	 pwEFl2/avuiaP0n0QsmuhlXCLUWRDj6Gah37tc+cS/qaFsy3m6L0G1MffygkE2NzFqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=PcsKT/4svhkOIFNICex6wK+digTaPoxSwFhPeZgjuAc=;
	b=jcCAeQEPwWWHOpHfosciU8nC0Hwkhmw9bjHQhB9cg1GeSJ5boQXUgeW5xfwEVQTwSEz8
	 SodWMvBFuNLU+B6TThljmck3i2fl6xyQGKa7GaDfkLrqvZBdW+21SF4KE7lXyMlXQgRj+
	 CO65lcpV2mg1/3HWzvPpuCe7248QMPQERWoo7RqFY7gfbsBePOUZ/nxBgVkt1ZzoWzCux
	 J74j0/tWmHAtd2bnNAJ2uPevjOVe8T5LZj3K8GQ6M01YpWg5fNIRgGeDcKI06okwOInE+
	 6HYEzD5KgwjKDnL+8GctdHo3z19uE8Dj21qwhQ/z1dHTldx560MC807b/ajnqIbqz6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mzPO5RLf;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B2606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B9B2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mzPO5RLf
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-490a95c2353so241596f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401878; x=1795006678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PcsKT/4svhkOIFNICex6wK+digTaPoxSwFhPeZgjuAc=;
        b=mzPO5RLf+Hrh6zEcQctrMJdi8gZOIEJDXjvaylDonS6wyz6DYkI75ZTIcZis+9U9EQ
         9y3O8ZHrFmPWWhOV96Ra6GlTUFJ5AHwtmE/ySJojHIOqJRnqvtrGri+4JX7nK+uCnkLy
         F44UfEUuzmoF4oTXzIQn3B4o0VKHjuJU4i09Y4Y+YTgj0zinkc/iD1KiEiHNkM2ugPLy
         /22hgs8doef/Px5gcZL2QLw8Dkcb/DJBvz6nVm+XofphKA4XGELOh8eEfD8DQ5ZDuig8
         +J462nozQm33VLC9YQ4kw6l+KhTJgdoet5CByludvuktIlgoUzZmdV1PffdRFDP6p9Dy
         YFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401878; x=1795006678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PcsKT/4svhkOIFNICex6wK+digTaPoxSwFhPeZgjuAc=;
        b=k1G2F/umat+9PAh4b2n82T/ObLAlIAbEYoMgIz3n/1pOd9fIGqutyjjhUaOftLYR/u
         JhBkYbdYb5bQnAEJGaCZ1WJQuysGm64STyfwo6tjTCcik7UY7KAEh9v5IPtbyENxBEJa
         1DBmKWDc18yqiV5qt0v/IIWpwQHMF+Bb4eTn8faVcU3n/EuRRO8eO66aTcCtPWWKfnbL
         +V/WmGkx4AezTqUtxgmHUAA6ET3Sq6wvSeZ0/IZGmgEsTPPO0Lkzh3WwW4g7Ozq8fQrX
         NIHYb0Twr5VUyw/ujdDpQeQCV0gAsgi9BughH/J5dnExNp+5vtAmxwSuW1bhfpjZaHxB
         hZ/g==
X-Gm-Message-State: APuU4Z+dJiWXEoZ+8gzLtjjZty+7ZEyxMuM70rOIY+bWqsTNM3J01Y8Z
	BawB6h4wxijOkusR5bjV7vse555BGUkW1qN+0CN7ISoxhb85sgFpsDE1A/uNafkHqyw=
X-Gm-Gg: AYBFou1hX/enzNonf6J8wO2nfmDzZWSIsiovzb5PSztnSayZ8wXOcrI13s4OBBBSxTQ
	E6K5H3jrxLJiWHmKcTnoBtYnj9tc//UIUZz9u4BDWzzeb8QBmQuDXupTNkVtuMc8l7LNfLrNNT8
	Q4rzgEMYb9JbcxYI8GfeFVNg9uhAepHC3IO9ravwydHnsqX/CcQR9/c3xuSOtLltrazAxqCRVHq
	Eb969zdZUBxz+M6heaMP/pZJqKOlofEheHO2AAoJAcx+J32eOCQgKiMIvV8AXtZB/h//Q0gWbgL
	/wIOVvHhJBD22sNqdYcgA2Y5feLkhU0PQdn2Nbi7dnqxDmD4ZI0fDtGNjGTAxRmozg8zNCWb780
	HgQoz+PlwYSOx6rYmeUliEID1qdtdrLDR9FPEwsP0qwTZgSRA2JmUTU+6URLRcRvYh+3D35e3Mm
	nX8FsLvUyOuGopCTXFs+4uh+PQjVTUREQ0Z3umYN0OezWk6iZKCjKyHdhoh4eo9kVYaH5OIFnFY
	WUx07BXH/JEhy/Ebo9ot1kN6O6fkclnANtgR/93ENEggAffF26DZ8POv2MwW0SHV9frbScW7O9K
	YUL9rOR9y/cOyIYc/xSwNxHNE+shb5Zlp774E3QD2IZrZ5KDgz+bbQEOMNP0NHjXDWtH5piwWIT
	YA5eDZd7l6s/xb1OZPdJa//wJP0kyqcPAF/6Yi/QLSnuqLVZIuAYoL3g6ruPzAYFc9L1q
X-Received: by 2002:a5d:5f86:0:b0:48e:6669:fefb with SMTP id ffacd0b85a97d-499c8981462mr4714675f8f.22.1794401878335;
        Wed, 11 Nov 2026 04:57:58 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc9asm10095884f8f.29.2026.11.11.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:56 -0800 (PST)
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
Subject: [PATCH bpf-next v1 17/29] bpf: Apply hidden slot limits only when a slot is needed
Date: Wed, 11 Nov 2026 13:57:15 +0100
Message-ID: <c426b1de0feb20215a1f4290b607509e3c9d0f7a.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14304; i=memxor@gmail.com; h=from:subject:message-id; bh=v4C+iJFdE0KR8gqIaFclC344xPQcFvyIQcf+ywzQ7bU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzELvG++jjV47PVn1T/SOrs5nPseri/487L2ertQfc SWVMfNkRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbizMrIsOlO+6JGTc7Ngke5 zjJfP/wjrjAvYMbx+hMTJmxL5NpbZ8jIsDvkk1565s8zSf8ic78Ubi+cfqf5uRPT1z1yswRr8jv VuAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The instructions that maintain a hidden slot are emitted once per call,
and a slot holds one handle. Currently a program that throws is rejected
for anything that these instructions cannot handle, as soon as the main
pass sees it:

 - an instruction that acquires resources of different types, or takes
   their handle in different ways, on different paths;
 - an acquisition whose handle is not in a register;
 - a release whose handle is not in an argument register, is in a
   register that does not point to the released resource, or is taken in
   different ways on different paths;
 - a frame that holds two resources acquired by the same instruction.

None of this matters for a resource that gets no hidden slot, either
because its sites describe it or because no throw finds it held. Such a
program loads if it contains no throw, and a throw elsewhere in the
program is no reason to reject it.

Record these cases during the pass, and reject them after it, only for
the resources that need a hidden slot:

 - An instruction gets one acquisition for each way it acquires.
 - A release records why its handle cannot be cleared from a slot.
 - An acquisition records that a frame held two of its resources.

Two resources of one instruction that a throw finds held have no
location that all visits agree on, so they always need a slot. That case
loads only if no throw finds them held.

The messages do not change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |   9 ++
 kernel/bpf/frame_desc.c      | 182 ++++++++++++++++++++++++-----------
 2 files changed, 137 insertions(+), 54 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a7c9b113e071..edd6005c32f6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1272,6 +1272,7 @@ struct bpf_res_acq {
 	s16 off;	/* the slot, relative to R10 */
 	bool held;	/* some frame holds what it acquired at a site */
 	bool slot;	/* and some site cannot say where: the handle is kept in a slot */
+	bool multi;	/* a frame held two of what it acquired at once: one slot cannot */
 };
 
 /* How many places a site remembers a frame keeping one handle in. */
@@ -1317,8 +1318,16 @@ struct bpf_res_rel {
 	u8 reg;		/* the argument the call releases */
 	u8 flags;	/* BPF_RES_F_DEREF */
 	s16 adj;	/* the argument points that many bytes into the object */
+	u8 bad;		/* BPF_RES_REL_*: why no insns can clear a slot here */
 };
 
+/* The handle is in no argument register. */
+#define BPF_RES_REL_NO_REG	1
+/* The register does not point to what is released. */
+#define BPF_RES_REL_NOT_PTR	2
+/* The call takes the handle in different ways on different paths. */
+#define BPF_RES_REL_DIFFER	3
+
 /* A call that enters or leaves a section, for the count of its frame, see frame_desc.c. */
 struct bpf_section_insn {
 	u32 insn;
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index 72dc6597321a..0ef7fda410ee 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -39,7 +39,11 @@
  *  - A frame that returns holds nothing but a reference it returns in R0,
  *    which the call acquires for the caller like the call of a kfunc that
  *    returns one, and is in the sections it was called in.
- *  - A frame holds one resource of an acquiring call at a time.
+ *  - A slot holds one handle, so a frame that holds two resources of one
+ *    acquiring call at once can have no slot for them.
+ *
+ * What can have no slot loads when its sites describe it or no throw finds
+ * it held, and is refused otherwise.
  *
  * The main pass records every call that acquires or releases, which
  * acquisition a release may be of, and the visits of the sites. What needs a
@@ -443,6 +447,8 @@ static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_stat
 	*adj = 0;
 	*obj_off = 0;
 	if (after) {
+		if (!in_reg)
+			return -EOPNOTSUPP;
 		reg = frame->regs[regno];
 		if (!reg_ref_off(&reg, ref->id, adj))
 			*adj = 0;
@@ -473,8 +479,11 @@ static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_stat
 }
 
 /*
- * The acquisition of insn @insn through R@reg: the same on every visit, since
- * the insns that keep its slot are emitted once. Returns its index.
+ * The acquisition of insn @insn through R@reg, of a resource of class @res.
+ * An insn that acquires in different ways on different paths has an
+ * acquisition for each: the insns that keep a slot are emitted once per insn,
+ * so none of them may need a slot then, see bpf_frame_desc_resolve(). Returns
+ * its index.
  */
 static int acq_add(struct bpf_verifier_env *env, u32 insn, u16 res, u8 reg, u8 flags, s16 adj,
 		   s16 obj_off)
@@ -484,14 +493,9 @@ static int acq_add(struct bpf_verifier_env *env, u32 insn, u16 res, u8 reg, u8 f
 
 	for (i = 0; i < cnt; i++) {
 		a = &env->res_acqs[i];
-		if (a->insn != insn || a->reg != reg || (a->flags ^ flags) & BPF_RES_F_CTX)
-			continue;
-		if (a->res != res || a->flags != flags || a->adj != adj || a->obj_off != obj_off) {
-			verbose(env, "frame_desc: insn %d acquires resources of different types on different paths\n",
-				insn);
-			return -EINVAL;
-		}
-		return i;
+		if (a->insn == insn && a->reg == reg && a->res == res && a->flags == flags &&
+		    a->adj == adj && a->obj_off == obj_off)
+			return i;
 	}
 	if (cnt >= U16_MAX - 1)
 		return -E2BIG;
@@ -507,7 +511,9 @@ static int acq_add(struct bpf_verifier_env *env, u32 insn, u16 res, u8 reg, u8 f
 
 /*
  * refs[@idx] is what acquisition @acq acquired, held by the frame that owns
- * it: its handle is in the slot of the acquisition, and the slot holds one.
+ * it. The slot of an acquisition holds one handle: a frame that holds two of
+ * what it acquired at once is fine as long as the acquisition gets no slot,
+ * see bpf_frame_desc_resolve().
  */
 static int ref_set_acq(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 		       int acq)
@@ -518,9 +524,8 @@ static int ref_set_acq(struct bpf_verifier_env *env, struct bpf_verifier_state *
 	for (i = 0; i < st->acquired_refs; i++) {
 		if (i == idx || st->refs[i].acq != acq + 1 || st->refs[i].frameno != ref->frameno)
 			continue;
-		verbose(env, "frame_desc: a frame holds two resources of insn %d at once, which is not supported in a program that throws\n",
-			env->res_acqs[acq].insn);
-		return -EINVAL;
+		env->res_acqs[acq].multi = true;
+		break;
 	}
 	ref->res = env->res_acqs[acq].res + 1;
 	ref->acq = acq + 1;
@@ -561,11 +566,9 @@ int bpf_frame_desc_record_acquire(struct bpf_verifier_env *env, int idx, int reg
 	}
 	if (res < 0)
 		return res;
-	if (regno < BPF_REG_0 || regno > BPF_REG_5) {
-		verbose(env, "frame_desc: insn %d takes the handle of a resource in no register\n",
-			env->insn_idx);
-		return -EINVAL;
-	}
+	/* no insns can put it into a slot then: R10 stands for no register */
+	if (regno < BPF_REG_0 || regno > BPF_REG_5)
+		regno = BPF_REG_FP;
 	acq = acq_add(env, env->insn_idx, res, regno, flags, adj, obj_off);
 	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
 }
@@ -630,6 +633,48 @@ int bpf_frame_desc_record_ctx_arg(struct bpf_verifier_env *env, int idx, int arg
 	return ret < 0 ? ret : ref_set_acq(env, st, idx, ret);
 }
 
+/*
+ * The call @insn releases through R@reg what acquisition @acq acquired: its
+ * handle leaves the slot of the acquisition in front of the call, when it has
+ * one. @bad says why no insns can do that here. The insns compare the
+ * argument the same way whatever it releases, so releases of one argument
+ * that differ in how they take the handle are bad as well. That matters for
+ * an acquisition that has a slot only, see bpf_frame_desc_resolve().
+ */
+static int rel_add(struct bpf_verifier_env *env, u32 insn, u16 acq, u8 reg, u8 flags, s16 adj,
+		   u8 bad)
+{
+	u32 i, cnt = env->res_rel_cnt;
+	struct bpf_res_rel *r, *same = NULL;
+
+	for (i = 0; i < cnt; i++) {
+		r = &env->res_rels[i];
+		if (r->insn != insn || r->reg != reg)
+			continue;
+		if (r->flags != flags || r->adj != adj) {
+			if (!r->bad)
+				r->bad = BPF_RES_REL_DIFFER;
+			if (!bad)
+				bad = BPF_RES_REL_DIFFER;
+		} else if (r->acq == acq) {
+			same = r;
+		}
+	}
+	if (same) {
+		if (!same->bad)
+			same->bad = bad;
+		return 0;
+	}
+	r = kvrealloc(env->res_rels, array_size(cnt + 1, sizeof(*r)), GFP_KERNEL_ACCOUNT);
+	if (!r)
+		return -ENOMEM;
+	r[cnt] = (struct bpf_res_rel) { .insn = insn, .acq = acq, .reg = reg, .flags = flags,
+					.adj = adj, .bad = bad };
+	env->res_rels = r;
+	env->res_rel_cnt = cnt + 1;
+	return 0;
+}
+
 /*
  * Record that the current insn releases the resource refs[@idx], before it
  * is released: its handle, in the argument the call releases, see
@@ -642,11 +687,10 @@ int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx)
 	struct bpf_verifier_state *st = env->cur_state;
 	const struct bpf_reference_state *ref = &st->refs[idx];
 	const struct bpf_func_state *frame = st->frame[st->curframe];
-	u32 i, cnt = env->res_rel_cnt, insn = env->insn_idx;
+	u32 i, insn = env->insn_idx;
 	int regno = env->release_regno;
 	const struct bpf_res_acq *acq;
-	struct bpf_res_rel *r;
-	u8 flags = 0;
+	u8 flags = 0, bad = 0;
 	s16 adj = 0;
 
 	if (!env->describe_frames || st->speculative)
@@ -667,40 +711,17 @@ int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx)
 		return -EINVAL;
 	}
 	acq = &env->res_acqs[ref->acq - 1];
+	/* what insns could not compare with a slot matters when there is a slot only */
 	if (regno < BPF_REG_1 || regno > BPF_REG_5) {
-		verbose(env, "frame_desc: insn %d releases a resource whose handle is in no argument register\n",
-			insn);
-		return -EINVAL;
-	}
-	if (acq->flags & BPF_RES_F_DEREF) {
+		regno = BPF_REG_FP;
+		bad = BPF_RES_REL_NO_REG;
+	} else if (acq->flags & BPF_RES_F_DEREF) {
 		flags = BPF_RES_F_DEREF;
 	} else if (!(acq->flags & BPF_RES_F_ARG) &&
 		   !reg_ref_off(&frame->regs[regno], ref->id, &adj)) {
-		verbose(env, "frame_desc: insn %d releases a resource R%d does not point to\n", insn,
-			regno);
-		return -EINVAL;
-	}
-	for (i = 0; i < cnt; i++) {
-		r = &env->res_rels[i];
-		if (r->insn != insn || r->reg != regno)
-			continue;
-		/* the argument is taken the same way whatever it releases */
-		if (r->flags != flags || r->adj != adj) {
-			verbose(env, "frame_desc: insn %d takes the handle of what it releases differently on different paths\n",
-				insn);
-			return -EINVAL;
-		}
-		if (r->acq == ref->acq - 1)
-			return 0;
+		bad = BPF_RES_REL_NOT_PTR;
 	}
-	r = kvrealloc(env->res_rels, array_size(cnt + 1, sizeof(*r)), GFP_KERNEL_ACCOUNT);
-	if (!r)
-		return -ENOMEM;
-	r[cnt] = (struct bpf_res_rel) { .insn = insn, .acq = ref->acq - 1, .reg = regno,
-					.flags = flags, .adj = adj };
-	env->res_rels = r;
-	env->res_rel_cnt = cnt + 1;
-	return 0;
+	return rel_add(env, insn, ref->acq - 1, regno, flags, adj, bad);
 }
 
 /* The current insn enters (@delta 1) or leaves (-1) a section of @kind: counted by its frame. */
@@ -1095,6 +1116,50 @@ static int emit_acquire_after(struct bpf_insn *buf, const struct bpf_res_acq *a)
 	return cnt;
 }
 
+/*
+ * Acquisition @acq needs a slot. Can the insns that keep it be emitted? They
+ * are emitted once per insn, so the insn has to acquire in one way, with the
+ * handle in a register, and every call that releases what it acquired has to
+ * take the handle in one way that insns can compare with the slot.
+ */
+static int slot_can_be_kept(struct bpf_verifier_env *env, u32 acq)
+{
+	const struct bpf_res_acq *a = &env->res_acqs[acq], *b;
+	const struct bpf_res_rel *r;
+	u32 i;
+
+	for (i = 0; i < env->res_acq_cnt; i++) {
+		b = &env->res_acqs[i];
+		if (i == acq || b->insn != a->insn || b->reg != a->reg ||
+		    (a->flags ^ b->flags) & BPF_RES_F_CTX)
+			continue;
+		verbose(env, "frame_desc: insn %d acquires resources of different types on different paths\n",
+			a->insn);
+		return -EINVAL;
+	}
+	if (a->reg == BPF_REG_FP) {
+		verbose(env, "frame_desc: insn %d takes the handle of a resource in no register\n",
+			a->insn);
+		return -EINVAL;
+	}
+	for (i = 0; i < env->res_rel_cnt; i++) {
+		r = &env->res_rels[i];
+		if (r->acq != acq || !r->bad)
+			continue;
+		if (r->bad == BPF_RES_REL_NO_REG)
+			verbose(env, "frame_desc: insn %d releases a resource whose handle is in no argument register\n",
+				r->insn);
+		else if (r->bad == BPF_RES_REL_NOT_PTR)
+			verbose(env, "frame_desc: insn %d releases a resource R%d does not point to\n",
+				r->insn, r->reg);
+		else
+			verbose(env, "frame_desc: insn %d takes the handle of what it releases differently on different paths\n",
+				r->insn);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * Decide what needs a hidden slot, once the pass has seen every frame, and
  * reserve it.
@@ -1149,6 +1214,15 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 		}
 		if (!a->slot)
 			continue;
+		ret = slot_can_be_kept(env, i);
+		if (ret)
+			break;
+		if (a->multi) {
+			verbose(env, "frame_desc: a frame holds two resources of insn %d at once, which is not supported in a program that throws\n",
+				a->insn);
+			ret = -EINVAL;
+			break;
+		}
 		/* some visit of the insn has nothing a slot can hold where this one has */
 		if (!(a->flags & BPF_RES_F_CTX) && acquires_sometimes(env, new_of[a->insn], a)) {
 			verbose(env, "frame_desc: insn %d acquires a resource on some paths only, or one of a type that cannot be released\n",
@@ -1348,8 +1422,8 @@ int bpf_frame_desc_emit(struct bpf_verifier_env *env)
 	if (!env->res_acq_cnt && !env->section_insn_cnt)
 		return 0;
 	new_of = insns_of_pass(env, &orig_len);
-	items = kvcalloc(env->res_acq_cnt + env->res_rel_cnt + env->section_insn_cnt, sizeof(*items),
-			 GFP_KERNEL_ACCOUNT);
+	items = kvcalloc(env->res_acq_cnt + env->res_rel_cnt + env->section_insn_cnt,
+			 sizeof(*items), GFP_KERNEL_ACCOUNT);
 	if (!new_of || !items) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.53.0

