Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166222D5412
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645683; cv=none; b=FP3RJhJS7r1KIxm/6LNtDiCYbYOsby/9NU2gb/B8KfWvphnjBjwUBkajiYUkNUHrR4ASnPrBgXBWCoCzTjfYvPLfz/imYNXX32Rv4l38e9pzp6kKrM7bDv4Jd1VRlc9tBUoU8OTijqG3Ao4qOVV0mzTXjD0VUQu4OFLvlYum5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645683; c=relaxed/simple;
	bh=MybOltquMioPztP922a82rAQBrYjhkfGbvpvcYs8IBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFqOR0IoMDk2GHZ3//+nRIFefVNWG/RlJGuBYJcvjsoAAMvVGjX4uC71DEh4b8IC5+GKTVJHDz9p9CAAD7Iw4Hpy0f1/5pgExFep60XJUyDz5WmaQQwL2i6RBhA0w0tZhtPUPE1il1s69TQtOOQhHC5eqkAiHNQv3p4P+gGg5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEVtycF/; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEVtycF/"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b5b727be96so1655336b6e.3
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645681; x=1789250481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6kpwS2Mez5/dsVr6nF6/sZsI2JRi6C6nsHscGARI48=;
        b=CEVtycF/GzjgygiX+Q2eLDKeavMJFuuQWnlVPCtZXd7nSbeFxpjsgoQ0tV8Q0NfQ0/
         Bp+whvJoaeSzqZvEAX8DR48ilnNDAut+TuMWq48SbtCW8MizippwyXWFZ4aNki9O0tRX
         XtvoNYXCFaK0acJgj7Saa+uDFzJxtunzJ++uAUk1lNZUzMJGbfg0pZrygkDGXORMvvPq
         cgTNtbxNMFc8QdnJ7QkNYVhK9CO1NKEx/zHingESqIKCBQsatuuiCQ9VGWT30icyQ1RX
         vTRV0czPl35QnhJXbqPJ8M6npvPwE8lhUzo8koOr0cgttlfvW2DVEFtu0AwyA5KVayW6
         PPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645681; x=1789250481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g6kpwS2Mez5/dsVr6nF6/sZsI2JRi6C6nsHscGARI48=;
        b=Zp3tF53XcWppZQfwWNbD37x3oh3dUlttkAGeoPOEkcI1GDf7b6k3ihtAofGMM4cAoZ
         c4TyyPlB5/b29TTS83ce3NwhJYHwnFV2tI3sEJbCKqoExP218M+i1jMAX4pAipbQFG/G
         k2W/6ynWbMJHqOFppcc2EPAKYCdnLJOQijYgfqu06zlPFBUBwili8m4eP/HQtQZLc8eP
         Gf43NEdHDyHA4ZnlsYkZ6Sp890+xL9zkrCBlcnBnMKIPxF3DxjyqTw3xGlgnepQyCakF
         8KG74YlIY2H3pOA7P2XTy9wpKsq8kOzLOytrOUVDgVN2yDOLv4K2OMwLIHC/zzvFMR5l
         05Zg==
X-Gm-Message-State: AFuF++m4D/qBGz8mUDo3qWpNU5mPeru3I8e6kpWFUL6ILa34Z5ZRqI40
	j1lfXxKeNJ13XbhxJGcAJUQL7x7fx+360bQ4zwI/vSZc089B4h7SXbz9dEpjng==
X-Gm-Gg: AYBFou1RJEN1sSjSZnBpsPT+BAG8kUuIN2YfUcWHWxo64VIAD2dc75lxrAH/1Q2r1bX
	UKS9hthAuYvha1iw3+xOPDE/2V0X15m4AoVFvnSChywG6yZv0mx2+hPUnUIqHLwTShfXSexTGTp
	h9MTk6Sen64oE2Bp0BGMvEddV9xI/UJnKJIk1OIpr+OPAu6tsRcBWBndc0m4bQOUQ9sjqvAuxug
	78Yvvu7Ygpvvj7lR1gcvy+LJVzonuLayPeC1Vr+5sLUwO5OUCKCVrzqrWAOQIQYPa8uas6bqlI6
	n4qaDVM9MwV+iEB5y5O+p4qTPeLGF6Asdskjro7L4+y0COd+wmGsBAw8CqdzCqQSU347o4RDp1A
	u0M61Uic6zLm8jf33Q9N2+PPdU0SINNotDNOP6lfwo52RMb/9gVucv3mmZOGwRcXl1J5p3HiN18
	lLK7wVQBoERG9vrIFMoQUIDrqPZQ8gN2kVN7pISRdY7dyZ6Y6FgbZcmsMNu/pR
X-Received: by 2002:a05:6808:d4f:b0:4b3:7b97:bec3 with SMTP id 5614622812f47-4b9621bd37bmr9254890b6e.18.1788645680774;
        Sat, 05 Sep 2026 15:01:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b97167bd69sm6868035b6e.13.2026.09.05.15.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/22] bpf: Pass call metadata through shared argument checks
Date: Sat,  5 Sep 2026 15:00:56 -0700
Message-ID: <20260905220117.922028-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
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
index 5b51e7ee1a3f..f49c90beefc5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7618,11 +7618,11 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
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
@@ -7639,9 +7639,8 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
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
 
@@ -7650,7 +7649,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			"%s expected pointer to stack or const struct bpf_dynptr\n",
 			reg_arg_name(env, argno));
 		bpf_diag_call_arg_fmt(
-			env, insn_idx, argno, call_name,
+			env, insn_idx, argno, meta->func_name,
 			"Pass the address of a stack dynptr object, or use a const dynptr pointer returned by the verifier-supported path.",
 			"a dynptr argument must be a pointer to a dynptr stack slot or a verifier-provided const struct bpf_dynptr, but %s is %s",
 			reg_arg_name(env, argno), bpf_diag_reg_type_plain(env, reg->type));
@@ -7691,7 +7690,8 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, ref_obj, dynptr);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx,
+					      &meta->ref_obj, &meta->dynptr);
 	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
@@ -7721,7 +7721,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			verbose(env, "Expected a dynptr of type %s as %s\n",
 				dynptr_type_str(expected_type), reg_arg_name(env, argno));
 			bpf_diag_call_arg_fmt(
-				env, insn_idx, argno, call_name,
+				env, insn_idx, argno, meta->func_name,
 				"Use a dynptr constructor that matches this operation, or call an operation that accepts the dynptr's current type.",
 				"the dynptr is initialized with backing object type %s, but this operation expects dynptr type %s",
 				dynptr_type_str(actual_type), dynptr_type_str(expected_type));
@@ -7740,11 +7740,9 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -8336,7 +8334,7 @@ static const char *bpf_diag_expected_reg_types(struct bpf_verifier_env *env,
 
 static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			  enum bpf_arg_type arg_type, const u32 *arg_btf_id,
-			  struct bpf_call_arg_meta *meta, const char *call_name)
+			  struct bpf_call_arg_meta *meta)
 {
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
@@ -8389,7 +8387,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
 	actual = bpf_diag_fmt(env, "%s", reg_type_str(env, reg->type));
 	accepted = bpf_diag_expected_reg_types(env, compatible->types, i);
-	bpf_diag_call_arg_fmt(env, env->insn_idx, argno, call_name,
+	bpf_diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
 			      "Pass a value with one of the accepted pointer or scalar types for this call.",
 			      "it has type %s, but this argument accepts %s",
 			      actual, accepted);
@@ -8403,7 +8401,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		if (!(arg_type & MEM_RDONLY)) {
 			verbose(env,
 				"%s() may write into memory pointed by %s type=%s\n",
-				func_id_name(meta->func_id),
+				meta->func_name,
 				reg_arg_name(env, argno), reg_type_str(env, reg->type));
 			return -EACCES;
 		}
@@ -8430,7 +8428,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 			verbose(env, "Possibly NULL pointer passed to helper %s\n",
 				reg_arg_name(env, argno));
 			bpf_diag_call_arg(
-				env, env->insn_idx, argno, call_name,
+				env, env->insn_idx, argno, meta->func_name,
 				"the pointer may be NULL, but this call requires a non-NULL pointer",
 				"Add a NULL check and make the call only on the non-NULL path.");
 			return -EACCES;
@@ -8819,8 +8817,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
-	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta,
-			     func_id_name(meta->func_id));
+	err = check_reg_type(env, reg, argno, arg_type, arg_btf_id, meta);
 	if (err)
 		return err;
 
@@ -8832,9 +8829,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -8965,8 +8962,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta, NULL);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno, insn_idx, func_id_name(meta->func_id),
-					  arg_type, &meta->ref_obj, &meta->dynptr);
+		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, meta);
 		if (err)
 			return err;
 		break;
@@ -9713,12 +9709,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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
@@ -9802,20 +9802,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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
 
 			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type))
 				continue;
 
-			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
-			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta,
-					     bpf_subprog_name(env, subprog));
+			err = check_reg_type(env, reg, argno, arg->arg_type, &arg->btf_id, &meta);
 			err = err ?: check_func_arg_reg_off(env, reg, argno, arg->arg_type);
 			if (err)
 				return err;
@@ -10929,6 +10925,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		env->insn_aux_data[insn_idx].non_sleepable = true;
 
 	meta.func_id = func_id;
+	meta.func_name = func_id_name(func_id);
 	meta.fn = fn;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -13078,8 +13075,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

