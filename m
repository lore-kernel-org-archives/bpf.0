Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9E39A807
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164262; cv=none; b=c1tVkH5/GmgKXEphfcZuhc973W+PsQPq3O7EmQuEkQk0+30GVLGsAdLSbYrT6blctwiJGoTHr+o4KW+g1GaZ5J4oIDKBAQYqkh/5Jtz7uM1UoauIzXSeummhmDsNyXR0mNLgljuRD4JhIRT1hpwN1fq+BrZOH57EgqFNGsdRHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164262; c=relaxed/simple;
	bh=AT0mvskpZm3zMQHjKPOegcaQ8hxscnX3Iwj9/oMORwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVNqJPms7GfLrbNdZ0pWqBQxpgDB9uFVDgi9rV5KWYDrhKeahxeDo2lc5Uc6mn28rr+wYctwR4CJT5nA60L6VM/x/VX60NEPj4pwz9BV6A20ABBrjQJN1bk3lP4Svc3NWwLfwl49r/zdI4ps8y6v6mzWCsnZJoYUfa6APyq24V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjdxYexo; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjdxYexo"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a36887bso214686b6e.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164259; x=1789769059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fse0yOP7JU89I51QWM9sycoZ6up2w6+yBPRiLZyRx0U=;
        b=YjdxYexog3NfkZDNhNaOX/ciWz7JnEMQbsxlmGCBd7EDuITxDua+r1gWLCjNbekKbI
         gdYPWB5q0KdZUakkfJIFkyhESvQyQ3wyguASkwAL6hmjCEkayw4nPQQykv60rM1dfZmJ
         zAMk8pvkVQThEdanySEvXIxNQ9PzOh7r4qXc1iuLPnqQJQnYADopZ0X6zDKNGkvEskCg
         1eeiQvqhYVAyXdIiMLvOBURf61kNxKfZ5Hexjvy3LPJUI6AT2FdBkCuhMyd8mdD7Ha59
         R71uw+lRcCbFDABlYv5VWNo/yeCBlCkekkn9D41EcjIJxRh5kfzjbJ/Q5HBOgc1H1aYN
         lrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164259; x=1789769059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fse0yOP7JU89I51QWM9sycoZ6up2w6+yBPRiLZyRx0U=;
        b=o9xOhDM8qNnNOOWZRwQUftE/Gv5Cz/xWR4OU70VQ2pSPWTG6OVTkerr/ZuiAAHzh7h
         uaHmspe2lZk+BfO2IJrZ4ynM1yme0KOJN/4LFTGaMz5nLHgEOoA0gnbBGp3IqA04OuZs
         4KOtVNqhGRFke43Iouqf1PyIrFESW3HzZ04bGEtCwZ0wLlw/iowg4Spek47iw9cauIYX
         +gKdhMMDuyqlEE6st5O0kjxjXIAtkFDRbG1TR3+qmvSDHJbQiI/vhOSSck7XOfy7x53J
         8lDfLkscPm1HIHhYell4fdEI/fMOlDsChg9pknlRcVeDQnp87prWdpMUH4bwIcakL0Ub
         mA4Q==
X-Gm-Message-State: AFuF++ks3+mHDJhf58jZXZN+Q/1qjR2q//eHJhylJYTusO40NBoKQwyI
	CaI1h7l3OZZ/BlZlW1AHEFqktP407e4l1MuxIuqOEtgvFSYv+xvbeyQfsdrLHQ==
X-Gm-Gg: AYBFou12P7+APEJV4ZAA33LoFkmz5NUlrPSBPc4oQSQqsLA5kp1orIAGNa/srwqbyvU
	mjui2NdwN16PkwaK/y7RBWZ0IX9PnOZctuh9QSoULrSs6j9AnDtL3/KRv+AGkUQ3X1S8Pao2TAG
	KNQdcGYhJCAuCM8MIQbIhC6mooCVSvENDrY0FhrOfODbOpB8iZin+Wdifv+fmIeuSux1qdSCnx6
	ZsBL+BOGmpESOYHMiuDTpcNAmA0Wxb9BuZLaszt4/MzGoBTkaz2ojsOYun8obuRMZKazBiJQplo
	VqvTEoFYlHFV136E23aHsPyRBlhVNur7hCup4Rz9cMnCz4BnYD9iAkACCeyHPpPX1uE4Kj967MP
	IitUl1wUlmRj16R/cn74Ai1xGhpU+wj2oUOnUAyEgcHFr68SAtZr81e9QqoLFRxuC5Odwb09Bnt
	lVNQnscX7fcnNUN78QViqumFFcwell3sp+D1oHD+K2igEiuz1YjJchpE0HSe6uIj5dezZj4xAky
	A==
X-Received: by 2002:a05:6808:30a6:b0:4c4:36a8:9599 with SMTP id 5614622812f47-4c436a899bamr2885038b6e.8.1789164258632;
        Fri, 11 Sep 2026 15:04:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3314b17d0sm3379820b6e.8.2026.09.11.15.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 01/23] bpf: Pass call metadata through shared argument checks
Date: Fri, 11 Sep 2026 15:03:53 -0700
Message-ID: <20260911220415.1396439-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helper, kfunc, and global subprogram argument paths supply callee
identity and state differently. check_reg_type() receives the call name
separately from bpf_call_arg_meta, while process_dynptr_func() receives
the call name, referenced-object state, and dynptr state as separate
arguments.

Populate meta->func_name for helper and global subprogram calls, keep
one metadata object for the entire global subprogram argument check, and
have both shared checking functions obtain their name and state from the
metadata. This gives dynptr validation one interface for every call kind
in preparation for unifying their argument-checking paths.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 67 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e2480..a45e0478f23c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7663,11 +7663,11 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
 /*
  * Validate dynptr arguments for helper, kfunc and subprog.
  *
- * @dynptr is both input and output. It is populated when the argument is
- * tagged with MEM_UNINIT (i.e., the dynptr argument that will be constructed)
- * and consumed when the argument is expecting to be an initialized dynptr.
- * @parent_id is used to track the referenced parent object (e.g., file or skb in
- * qdisc program) when constructing a dynptr.
+ * @meta carries the dynptr and referenced-object state. The dynptr is populated
+ * when the argument is tagged with MEM_UNINIT (i.e., the dynptr argument that
+ * will be constructed) and consumed when the argument is expected to be an
+ * initialized dynptr. The reference tracks the parent object (e.g., file or skb
+ * in qdisc program) when constructing a dynptr.
  *
  * There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
  * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
@@ -7684,9 +7684,8 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
  * and checked dynamically during runtime.
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			       argno_t argno, int insn_idx, const char *call_name,
-			       enum bpf_arg_type arg_type,
-			       struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
+			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
+			       struct bpf_call_arg_meta *meta)
 {
 	int spi, err = 0;
 
@@ -7695,7 +7694,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			"%s expected pointer to stack or const struct bpf_dynptr\n",
 			reg_arg_name(env, argno));
 		bpf_diag_call_arg_fmt(
-			env, insn_idx, argno, call_name,
+			env, insn_idx, argno, meta->func_name,
 			"Pass the address of a stack dynptr object, or use a const dynptr pointer returned by the verifier-supported path.",
 			"a dynptr argument must be a pointer to a dynptr stack slot or a verifier-provided const struct bpf_dynptr, but %s is %s",
 			reg_arg_name(env, argno), bpf_diag_reg_type_plain(env, reg->type));
@@ -7736,7 +7735,8 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, ref_obj, dynptr);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx,
+					      &meta->ref_obj, &meta->dynptr);
 	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
@@ -7766,7 +7766,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			verbose(env, "Expected a dynptr of type %s as %s\n",
 				dynptr_type_str(expected_type), reg_arg_name(env, argno));
 			bpf_diag_call_arg_fmt(
-				env, insn_idx, argno, call_name,
+				env, insn_idx, argno, meta->func_name,
 				"Use a dynptr constructor that matches this operation, or call an operation that accepts the dynptr's current type.",
 				"the dynptr is initialized with backing object type %s, but this operation expects dynptr type %s",
 				dynptr_type_str(actual_type), dynptr_type_str(expected_type));
@@ -7785,11 +7785,9 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			reg = &state->stack[spi].spilled_ptr;
 		}
 
-		if (dynptr) {
-			dynptr->type = reg->dynptr.type;
-			dynptr->id = reg->id;
-			dynptr->parent_id = reg->parent_id;
-		}
+		meta->dynptr.type = reg->dynptr.type;
+		meta->dynptr.id = reg->id;
+		meta->dynptr.parent_id = reg->parent_id;
 	}
 	return err;
 }
@@ -8382,7 +8380,7 @@ static const char *bpf_diag_expected_reg_types(struct bpf_verifier_env *env,
 
 static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			  enum bpf_arg_type arg_type, const u32 *arg_btf_id,
-			  struct bpf_call_arg_meta *meta, const char *call_name)
+			  struct bpf_call_arg_meta *meta)
 {
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
@@ -8435,7 +8433,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
 	actual = bpf_diag_fmt(env, "%s", reg_type_str(env, reg->type));
 	accepted = bpf_diag_expected_reg_types(env, compatible->types, i);
-	bpf_diag_call_arg_fmt(env, env->insn_idx, argno, call_name,
+	bpf_diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
 			      "Pass a value with one of the accepted pointer or scalar types for this call.",
 			      "it has type %s, but this argument accepts %s",
 			      actual, accepted);
@@ -8449,7 +8447,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		if (!(arg_type & MEM_RDONLY)) {
 			verbose(env,
 				"%s() may write into memory pointed by %s type=%s\n",
-				func_id_name(meta->func_id),
+				meta->func_name,
 				reg_arg_name(env, argno), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
@@ -8476,7 +8474,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 			verbose(env, "Possibly NULL pointer passed to helper %s\n",
 				reg_arg_name(env, argno));
 			bpf_diag_call_arg(
-				env, env->insn_idx, argno, call_name,
+				env, env->insn_idx, argno, meta->func_name,
 				"the pointer may be NULL, but this call requires a non-NULL pointer",
 				"Add a NULL check and make the call only on the non-NULL path.");
 			return -EACCES;
@@ -8869,8 +8867,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
-	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta,
-			     func_id_name(meta->func_id));
+	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta);
 	if (err)
 		return err;
 
@@ -8882,9 +8879,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (arg_type_is_release(arg_type) && !arg_type_is_dynptr(arg_type) &&
 	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
-			func_id_name(meta->func_id), reg_arg_name(env, argno));
+			meta->func_name, reg_arg_name(env, argno));
 		bpf_diag_call_arg(
-			env, insn_idx, argno, func_id_name(meta->func_id),
+			env, insn_idx, argno, meta->func_name,
 			"release helpers require a value that owns a live resource returned by a matching acquire helper",
 			"Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has already been transferred or released.");
 		return -EINVAL;
@@ -9015,8 +9012,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta, NULL);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno, insn_idx, func_id_name(meta->func_id),
-					  arg_type, &meta->ref_obj, &meta->dynptr);
+		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, meta);
 		if (err)
 			return err;
 		break;
@@ -9763,12 +9759,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_verifier_log *log = &env->log;
-	struct ref_obj_desc ref_obj = {};
 	const struct btf_param *args;
 	const struct btf_type *func, *func_proto;
+	struct bpf_call_arg_meta meta;
 	u32 i;
 	int ret, err;
 
+	/* Leave btf and func_id zero: this is neither a helper nor a kfunc. */
+	memset(&meta, 0, sizeof(meta));
+	meta.func_name = bpf_subprog_name(env, subprog);
+
 	ret = btf_prepare_func_args(env, subprog);
 	if (ret) {
 		if (bpf_in_stack_arg_cnt(sub) > 0) {
@@ -9852,12 +9852,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return ret;
 
 			ret = process_dynptr_func(env, reg, argno, env->insn_idx,
-						  bpf_subprog_name(env, subprog), arg->arg_type,
-						  &ref_obj, NULL);
+						  arg->arg_type, &meta);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
-			struct bpf_call_arg_meta meta;
 			int err;
 
 			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type)) {
@@ -9867,9 +9865,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				continue;
 			}
 
-			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
-			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta,
-					     bpf_subprog_name(env, subprog));
+			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta);
 			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
 			if (err)
 				return err;
@@ -11008,6 +11004,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		env->insn_aux_data[insn_idx].non_sleepable = true;
 
 	meta.func_id = func_id;
+	meta.func_name = func_id_name(func_id);
 	meta.fn = fn;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -13177,8 +13174,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
 			}
 
-			ret = process_dynptr_func(env, reg, argno, insn_idx, func_name,
-						  dynptr_arg_type, &meta->ref_obj, &meta->dynptr);
+			ret = process_dynptr_func(env, reg, argno, insn_idx,
+						  dynptr_arg_type, meta);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.52.0

