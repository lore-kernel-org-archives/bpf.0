Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640524;
	b=2woj6oXU8tdi6MVNEJTRujI6XGVpDHcXnWsnJRZ2AxmiQc0O5udrYeB1rIytXBBxV5Ra
	 5gnaQIfnEFJbB0IEO+PUTnbHyHRzCRLw0fCV49HofM4jEpwfcJ5sxONz3nI8MjjlmDUq/
	 fIrNLUHEPYhjozZaNQcWSIGttPNVrQSHvyfgu6bVCOP2sNqjxdG+qKPlKTEaHXrU0fP5x
	 rDjEYmoxg2DESTLQehaH1FHXZG56E+tDXd9j5AyCmt66NRIJeRxGsw43TTiY8rf0GBKAa
	 vjEdkW/J209cQNVWVDoyTWIZWd5pnW4iMA97u2wbFAd0f0zo8+1cOFUEx3wMpgYhEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=7KFaf+qQGaEllgFAN2tKjbPGhPG3fCgMElbNyJeYcLk=;
	b=pS7EMK49gYAA40kmvu5Gh5k48VqsbrcfrCN8xGS73148KIvT8bMKiGe29oJc+qAuOKnc
	 4XiceNNMycI+6vJHOyGyDRtQ06fCYYhuWJDxhD1Wx2BPcMuoTPgoSJ/lpoqsJyMvNgQ8h
	 53iRDoL3eCHAvDLWhRNoRBuJUf9M7XB8vLzgfY3TA2T7g62afc8MU/uihCBVjkPIZd2+V
	 z6SiyciF/Fq5PaqXdB/6fW/+Vg8/vC2jtuTXWGpasPQ1mEZBSJ9jCmZrUXBvqAWuzS7BH
	 RatABmO/+sY8VS0m5dTBk3JKKneD9FLv9vLEXLvWvFBpl5mi3Fe4zvAGS5URM8VQgHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n91WQojV;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B23606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B23606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n91WQojV
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so806426a91.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792640523; x=1793245323; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7KFaf+qQGaEllgFAN2tKjbPGhPG3fCgMElbNyJeYcLk=;
        b=n91WQojVZGIHjy2qLPl2p7mg1ESaYvnEAvAKTREk9VzkPZ2eaDaYV89wNvcJdmkW+V
         xXmdjH7hQ1GqoD3pJbHgnf1paRB39/CpLogB6mNvj5vTgHGbZvUqOoxAqyMhUzmfLkgC
         GrsIlU3H7j+WELspR3qfhYSMxu0Qnvt3gAyxynw3uapP+wUPv7i9/IhynxSo4a3YjZ5+
         98acgGuOjgnae4+cw7V6HqFW9hkQI5suycil2NnxMtxTujJQ5sILY671r7PERxGlazrB
         BA3oR8Zv/EQi/JFzVtmFJDnLYA0Q4j1R7AUw0/EP0ipPW05nXe6ZMeTUtpc1VIX2CI6b
         YRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640523; x=1793245323;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KFaf+qQGaEllgFAN2tKjbPGhPG3fCgMElbNyJeYcLk=;
        b=b6xkWhqyVEkYkimVKTSgxkRTYGQNyZpqqJctgwwIxxkfIJX2O273QvIbhEjDy60r7D
         q/8M2DAXDvCZplZ8GKBZwpVr2QCNm6mz/i4p3tDLLfVkRbKstMzIfFWFFIaniisaZK9G
         hmTEoa8YpN8t0Cf8K02iOiu/YJ+bvyw+fF2z30QpHWYHFX7CTiT0nH0lhZcK7uCpwmfb
         I/9nSRNBkjKO78qxm8LsJtM5G+VTQyOYPA4Kh9+LpJtxNbsEjYAwDRGRJxwIi3fQ3iLX
         aSY12e88B9cGEoVntTPP2+ea60sImHE2AJAit27OlMe3e1mBIvrNvFiv7Is6SpsI0deL
         wD2A==
X-Forwarded-Encrypted: i=1; AKwUvBzf3BbEUlhaFSfFucN6TSXg8QgAvnh1ZNkptd/US0W0p+SMH3W7ECe7hqwHkBJaW+mlwds=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2p4bNzvZd4h91epj6lEBokH0nSjOa1Nqd7zXHYQJt6+jTe6W+
	r7S8+tp8tB2O1VF3lUGtBXo9it5UuHVAhAqtFvfT34+Gnmw5qC/tutPc
X-Gm-Gg: AYBFou0vgH6N1SABzYfGN9pT7R/TKjQpheXVSJ1jSx2wlLeD+pdBIlEMAMOXZknISr1
	yB022jMYsJLYuP8o+qAyBPTo/Xjjl55jV/CaM7wtA+KjTOCuz2jHy6rzqa3oj0D8Et0PwHiejCB
	nGmLhQF5XGSphJybe0jKQMsTRm0t6EIMSdhSfuRb6q3+JFXAD2NgYmvPHgCXqXQxzkLwjZY5Vz8
	2SYpjjFGSxvay+5YzyR5BYHKyLO2PsbFHEuvGvtc+HW65ubjj6s4Tv/8xy0KRgWBzuavY0Vrq/3
	CXlBqJwhcM3upID4VxyAbmCDH2QwQg8Il6jugNivUNAvsshktG1PznpVHFXh0Gv/crHdOn+m7TB
	+4OmrG/xrH/FZDQC3skk2ZZsX5jrzHaCaved4hnAPwt/SH35KK7+ktsTA48WwkzudNEpxjEz0To
	3vAYWi81tVOnoppEdGJdH1M1FlWx9u59ag4GvuvBSQI89J0VmKHI5KdnFyWRT68RjtjQUZpBUdU
	61+mC1/5GXaotWO2crwt7NLLAzpPpd55ehMTmVuswVTwvFEPSeyNwQiaflIqXpfjT2JrO/RrsIV
	HLH3z42eO6agR1KgUH4xT7B2CSmO5xnkLT2hZ116i5vTcqw/z12deVINrhzw
X-Received: by 2002:a17:90a:d2ce:b0:3ac:7872:d1b7 with SMTP id 98e67ed59e1d1-3ad86ed6b4fmr3371903a91.32.1792640523278;
        Wed, 21 Oct 2026 20:42:03 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada47f8ff1sm2182206a91.0.2026.10.21.20.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 20:42:02 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 03:42:01 +0000
Message-Id: <DMB212RCKZ56.LTNAJWB2D39T@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ameryhung@gmail.com>, <yonghong.song@linux.dev>,
 <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Track borrowed iterator results by
 default
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, <bpf@vger.kernel.org>
In-Reply-To: <20261021210754.3270023-2-xyx2021@mail.ustc.edu.cn>
References: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn> <20261021210754.3270023-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 02:07 PM Xu Yunxiang <xyx2021@mail.ustc.edu.cn> wrote:
> +		if (iter_next_borrows_struct(meta) &&
> +		    !is_kfunc_rcu_protected(meta) &&
> +		    !(bpf_stack_slot(state, spi)->spilled_ptr.type & MEM_RCU)) {
> +			err = invalidate_reference_dependents(env, meta->ref_obj.id);

check_kfunc_call() doesn't set parent_id when the result is MEM_RCU,
so nothing is tied to such iterator and there is nothing to invalidate.
No need to repeat the RCU checks here.

> +static int __release_reference(struct bpf_verifier_env *env, int id, bool release_root)

[...]

> +			if (!release_root && id == root_id && reg->parent_id != id)
> +				continue;

Drop this check. It's dead code.
The id of the iterator is only in its first STACK_ITER slot and the mask
doesn't include STACK_ITER, so no reg has the id of the iterator.
Then release_root only decides whether release_reference_nomark()
is called. No need for the bool.

I think it can be implemented a bit simpler:

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b66e20a..a18254b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -82,6 +82,7 @@
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 #define KF_PERFMON      (1 << 18) /* kfunc requires CAP_PERFMON */
+#define KF_ITER_RET_INDEPENDENT (1 << 19) /* next result outlives the current element */

 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d20..516f6b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -211,6 +211,8 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 static int __release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference_nomark(struct bpf_verifier_env *env, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
+static int invalidate_reference(struct bpf_verifier_env *env, int id);
+static u32 reg_lifetime_id(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
@@ -793,8 +795,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (err)
 			return err;

-		/* Track parent's id if the parent is a referenced object */
-		parent_id = ref_obj->id;
+		/* All non-clone constructors take their backing object in R1. */
+		parent_id = reg_lifetime_id(env, &cur_regs(env)[BPF_REG_1]);

 		if (dynptr_type_referenced(type)) {
 			int id;
@@ -1074,7 +1076,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j;
+	int spi, i, j, err;

 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -1084,8 +1086,11 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;

-		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->id));
+		if (i == 0) {
+			err = release_reference(env, st->id);
+			if (err)
+				return err;
+		}

 		bpf_mark_reg_not_init(env, st);

@@ -1627,6 +1632,11 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }

+static u32 reg_lifetime_id(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+{
+	return reg_is_referenced(env, reg) ? reg->id : reg->parent_id;
+}
+
 static int release_lock_state(struct bpf_verifier_env *env, int type, int id, void *ptr)
 {
 	struct bpf_verifier_state *state = env->cur_state;
@@ -6848,9 +6858,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		flag &= ~PTR_MAYBE_NULL;

 	if (atype == BPF_READ && value_regno >= 0) {
+		u32 parent_id = reg_lifetime_id(env, reg);
+
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
 			return ret;
+		if ((regs[value_regno].type & PTR_TRUSTED) &&
+		    !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | MEM_USER)))
+			regs[value_regno].parent_id = parent_id;
 	}

 	return 0;
@@ -8636,6 +8651,21 @@ static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_DESTROY;
 }

+static bool iter_next_borrows_struct(struct bpf_call_arg_meta *meta)
+{
+	const struct btf_type *t;
+
+	if (!(meta->kfunc_flags & KF_ITER_NEXT) ||
+	    (meta->kfunc_flags & (KF_ITER_RET_INDEPENDENT | KF_ACQUIRE)))
+		return false;
+
+	t = btf_type_skip_modifiers(meta->btf, meta->func_proto->type, NULL);
+	if (!t || !btf_type_is_ptr(t))
+		return false;
+	t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
+	return t && __btf_type_is_struct(t);
+}
+
 static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 			      const struct btf_param *arg)
 {
@@ -8746,6 +8776,13 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		meta->iter.frameno = reg->frameno;
 		update_ref_obj(&meta->ref_obj, &bpf_stack_slot(state, spi)->spilled_ptr);

+		/* The iterator stays. What was borrowed from the previous element goes. */
+		if (iter_next_borrows_struct(meta)) {
+			err = invalidate_reference(env, meta->ref_obj.id);
+			if (err)
+				return err;
+		}
+
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
 			if (err)
@@ -11073,8 +11110,8 @@ static int idstack_pop(struct bpf_idmap *idmap)
 	return idmap->map[--idmap->cnt].old;
 }

-/* Release id and objects derived from it iteratively in a DFS manner */
-static int release_reference(struct bpf_verifier_env *env, int id)
+/* Invalidate id and objects derived from it iteratively in a DFS manner */
+static int invalidate_reference(struct bpf_verifier_env *env, int id)
 {
 	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -11089,11 +11126,6 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	if (err)
 		return err;

-	if (find_reference_state(vstate, id)) {
-		err = release_reference_nomark(env, id);
-		WARN_ON_ONCE(err);
-	}
-
 	while ((id = idstack_pop(idstack))) {
 		/*
 		 * Child references are inaccessible after parent is released,
@@ -11145,6 +11177,14 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	return 0;
 }

+static int release_reference(struct bpf_verifier_env *env, int id)
+{
+	if (find_reference_state(env->cur_state, id))
+		WARN_ON_ONCE(release_reference_nomark(env, id));
+
+	return invalidate_reference(env, id);
+}
+
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *unused;
@@ -15822,6 +15862,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+			if (iter_next_borrows_struct(&meta) && !(type & MEM_RCU))
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 		}

 		if (is_kfunc_ret_null(&meta)) {

pw-bot: cr
