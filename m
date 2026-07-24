Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B995459AF3
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920114; cv=none; b=Pdk6k9NZryj5iBhQwqxVfNwutPMegwd9dMMkrZ60ZU3fQ6z2r8ey/8va6qoJdvvuJoW/knAlcg4m3d2jVaN2W5+Y49MWnQlv/CZfnFftRhTxtwUiyywZXptthIz7iLJDNOBjNbxnnAtudsuPRi4IdHl+6EiGXKhivxo+osPLXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920114; c=relaxed/simple;
	bh=+NHKFjXb6vA0loOe996PFi0qM7fV+hH9JWbVQ+umVQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnoEMUlnrM8mtdsn6plIUlmoVGA4xb4Cc40bK43hh4qDc4Y5Cbd6ANWR/oMVZsthyKS207bowYnki1piexWr796d2lrMi9FOlG7kGWHK4hnw7XdHhQ/PtjfLZAKu33i0ycrykrJZrGLjQuUz5GqCoQc8wH66naoEfWNVtomDz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP1Rwzhz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP1Rwzhz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf52d15d88so8589925ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920112; x=1785524912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPSHLhvQFJwe9rTN0dDeER03eul43DtfUCRG77RVw6M=;
        b=WP1RwzhzX+/h3Np2jAEyuCZ7eMVHZCTcDCMHKVf5icVrrVLa6I7O/y6HIdcuhkCqv6
         z0CSUE8FCpzyfzoCozgLhPnVq5qZYR1BP2t6/ZWaRYJbOFDSZEtahaZ0LPuYnVbuotx8
         P0DcgAZaFHFu0bts/8XQnaBl+6SzxfhrmMtkKW7dlXAzBvrM6ul5IX1tKQFxzpslSX/A
         ND0JUAkcc2E/0VMrnIITNfSQfbKFf+g5BtTnfCB652ElRS0Jzpzqyff+tlRt5wP9Y5sN
         SfbGmhfyvpZcpNKivgHgchisZwlig+1dV5tmlMxMJTCrfLZjpki9oQ6s0PNwEhdaB/IE
         a9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920112; x=1785524912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPSHLhvQFJwe9rTN0dDeER03eul43DtfUCRG77RVw6M=;
        b=kAAciMatcf7Ho9Jvk4nuzvhc16W48W1gO8kxZAJ4FYyQbykO2oA3+q9TsVGVtw1EX9
         c9ItWC+FXlsdeVpjQqWBcjf1uHZL2hX4gc5qifhAgN2HjjJyW5y+/NOfVEm0ZmV7Mc1o
         tsuUz1tVycuwRurTWf6a6vexRlrGvNIrWedGKkFnYpTicOEIXLlAVnNSNCi2aqtLJ4Qy
         b4b9BcrJynIB4MPoWQ4W37TkMJLm+t4JEsaEPGN3Fo4/HwSTRYk4Kq1WA3gLxCzxDaUF
         tODVC7oqYpoUqtxlegx0fmW82cmo7/3NfP35Of0JAKxzGC1WTuV6Ed8YnAUWgn+fJzRp
         ToZw==
X-Gm-Message-State: AOJu0Yx8S5coUy9wFq94tO/cWBFPi1dVkFSu1RJyMeS6MkoCn9jK0Lt5
	h305vjmySW2hR/0tqt6Ze3N0tGRfN/5pLKB0OmSTJWOPXXLhbzAUo3u3VAxSIg==
X-Gm-Gg: AR+sD10C01E8XbEhWJ5+/WiOeHKxJYYoTZaCZbPEIuFyPmYmhXnjnSDU+3ubP/1Xz/X
	17bmxSCWqDmsrNbAdMm5okeW/TILduLdmpZAdQM0L4eTvs8fPFD4j1KWxH+b7S6Y4d7ywSQY0Sw
	Klo7BZZ00wsQAvYzZbWa1QCMUfJObpFNJmULh7CrpmXRbbCZvhIA7jn4yPce7ANhbDIVsITo9f6
	la5mQvOBQEVwBb0fWY9fGCNAT/PbY+gPCELoBn8lifsDkcv9rIoB41xMVy5E0CH9E/hNCc217M1
	lfij724Mrh7XZ8Z/KGqMI5me6BoGDcitILOaRy+NJD1LnJ2qm04lH2yY5BANKZeDf010JbYImtG
	HD1f4EJI9Kt2sIh7ttajry2o4A0HUPAAkCw74gqdy8IisQKPJX23EtoudEwIaCKu81A/0A9/TxR
	4=
X-Received: by 2002:a17:902:f601:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2cfa6a55fadmr85240565ad.9.1784920111649;
        Fri, 24 Jul 2026 12:08:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa4697sm56504455ad.11.2026.07.24.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:31 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 16/18] bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
Date: Fri, 24 Jul 2026 12:08:10 -0700
Message-ID: <20260724190813.1458271-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that get_kfunc_ptr_arg_type() classifies a kfunc pointer argument
from its BTF alone, express a nullable argument by OR-ing PTR_MAYBE_NULL
into the classified type, and resolve a NULL register after
classification instead of before it.

Previously check_kfunc_args() short-circuited a nullable argument passed
a NULL register with a continue placed before get_kfunc_ptr_arg_type(),
so the NULL never reached classification. That kept a register-state
decision (bpf_register_is_null()) ahead of the BTF-based classification.

This mirrors how helper arguments carry PTR_MAYBE_NULL in their
bpf_arg_type and is a step toward describing kfuncs with a bpf_func_proto:
the nullability now travels with the per-argument classification, so it is
captured when the prototype is generated at add-call time.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 156 ++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 82 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76a84574b23e..3b357007e893 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11361,93 +11361,85 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *m
 		       int arg, int nargs, argno_t argno)
 {
 	bool arg_mem_size = false;
-
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
-		return KF_ARG_PTR_TO_CTX;
+	int arg_type;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
 	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
 	 */
-	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
-		return KF_ARG_PTR_TO_CTX;
-
-	if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
-
-	if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_REFCOUNTED_KPTR;
-
-	if (is_kfunc_arg_dynptr(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_DYNPTR;
-
-	if (is_kfunc_arg_iter(meta, arg, &args[arg]))
-		return KF_ARG_PTR_TO_ITER;
-
-	if (is_kfunc_arg_list_head(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_LIST_HEAD;
-
-	if (is_kfunc_arg_list_node(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_LIST_NODE;
-
-	if (is_kfunc_arg_rbtree_root(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_RB_ROOT;
-
-	if (is_kfunc_arg_rbtree_node(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_RB_NODE;
-
-	if (is_kfunc_arg_const_str(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_CONST_STR;
-
-	if (is_kfunc_arg_const_map(meta->btf, &args[arg]))
-		return KF_ARG_CONST_MAP_PTR;
-
-	if (is_kfunc_arg_map(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_BTF_ID;
-
-	if (is_kfunc_arg_wq(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_WORKQUEUE;
-
-	if (is_kfunc_arg_timer(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_TIMER;
-
-	if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_TASK_WORK;
-
-	if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_IRQ_FLAG;
-
-	if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_RES_SPIN_LOCK;
-
-	if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_CALLBACK;
-
-	if (arg + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
-		arg_mem_size = true;
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
+		arg_type = KF_ARG_PTR_TO_CTX;
+	else if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
+		arg_type = KF_ARG_PTR_TO_CTX;
+	else if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_ALLOC_BTF_ID;
+	else if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_REFCOUNTED_KPTR;
+	else if (is_kfunc_arg_dynptr(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_DYNPTR;
+	else if (is_kfunc_arg_iter(meta, arg, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_ITER;
+	else if (is_kfunc_arg_list_head(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_LIST_HEAD;
+	else if (is_kfunc_arg_list_node(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_LIST_NODE;
+	else if (is_kfunc_arg_rbtree_root(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_RB_ROOT;
+	else if (is_kfunc_arg_rbtree_node(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_RB_NODE;
+	else if (is_kfunc_arg_const_str(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_CONST_STR;
+	else if (is_kfunc_arg_const_map(meta->btf, &args[arg]))
+		arg_type = KF_ARG_CONST_MAP_PTR;
+	else if (is_kfunc_arg_map(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_BTF_ID;
+	else if (is_kfunc_arg_wq(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_WORKQUEUE;
+	else if (is_kfunc_arg_timer(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_TIMER;
+	else if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_TASK_WORK;
+	else if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_IRQ_FLAG;
+	else if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_RES_SPIN_LOCK;
+	else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_CALLBACK;
+	else {
+		if (arg + 1 < nargs &&
+		    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
+		     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
+			arg_mem_size = true;
+
+		if (btf_type_is_struct(ref_t) && !arg_mem_size) {
+			/* A pointer to a struct without a size argument is classified
+			 * as KF_ARG_PTR_TO_BTF_ID.
+			 */
+			arg_type = KF_ARG_PTR_TO_BTF_ID;
+		} else if (!btf_type_is_scalar(ref_t) &&
+			   !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
+			   (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
+			verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
+				reg_arg_name(env, argno),
+				btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+			return -EINVAL;
+		} else {
+			/* Otherwise this is a memory buffer supported by
+			 * check_helper_mem_access(): a pointer to a scalar, or to void
+			 * when paired with a size argument. The access size is derived
+			 * from the pointed-to BTF type unless a size argument follows.
+			 */
+			arg_type = arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+		}
+	}
 
-	/* A pointer to a struct without a size argument is classified as KF_ARG_PTR_TO_BTF_ID */
-	if (btf_type_is_struct(ref_t) && !arg_mem_size)
-		return KF_ARG_PTR_TO_BTF_ID;
+	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
+		arg_type |= PTR_MAYBE_NULL;
 
-	/*
-	 * Otherwise this is a memory buffer supported by check_helper_mem_access(): a pointer
-	 * to a scalar, or to void when paired with a size argument. The access size is derived
-	 * from the pointed-to BTF type unless a size argument follows.
-	 */
-	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
-	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
-		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
-			reg_arg_name(env, argno),
-			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
-		return -EINVAL;
-	}
-	return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+	return arg_type;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12135,14 +12127,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
-			continue;
-
 		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
+		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
+			continue;
+
 		if (is_kfunc_arg_map(btf, &args[i])) {
 			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
 			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
-- 
2.52.0

