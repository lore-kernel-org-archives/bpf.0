Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90904C2246
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542910; cv=none; b=Bu+hCP1a3O3V9acHFv73Dqm+6WvtXPoubJeT+7KhehE7D8KUowvpdeZc8n5Ka9xA3j9ngYs9NrHLmJotZMLcxJjqy9k0Dn3DltujlVVeQGtJNP0h9q/bukxuYpiWZqmHe2n7QOTL3UZ5ZtsMx8f8NKd8YL3orkTxD7GbZb472sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542910; c=relaxed/simple;
	bh=geiYmGF/w901rEAK+tt4LagpFYdXOW5DExUT4oU/ljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvb/ZZouJRUuYkroy2y7SCFsQL5beMGtM5PLC9oovmboub/To8jsBV56kRZG+23dlHKT1NSwrPjEfv8N4ejdc1f9B463DoXlA33J98PyrIcOl3QovlwKESbC6hfjKxY67S7DXsJzgg4JWxCwAXXN+L7aLsz9v59oME0UqKwEues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egi2UZnh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egi2UZnh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a8af3a704fso1792961a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542899; x=1792147699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aJy9OpTpIon+GJbMJg96I4Vtgaq0uoordt8zaL6PqcI=;
        b=egi2UZnhudoqelRY8emQVx3Uqbjcy5E5cFsrOrTdQFKi7iutuEnt/G70cGe4XsEKUH
         w5blVd8rqrHxEyPisRpEaqhJB737KvDOcP7SpNG2v/Z/IfZNkZCsJPDX9+UjcqtQIaLv
         TggpLTw5ImeA1lau5GKsBwleQzf6FWiWcPrB8dVZga69h/f7YMAZGuyBSrk+JmJRkg4v
         TXZGHifByv0NghHPNFU/LHKI2SXRxIJdo2rA9cvViUmeWxwaHTyGVcE8ze29cck374qa
         XjVqhxCVeKqelNTQ3zf28hzHj9Wn9rNI17Q4ly6yuZlR3NfgdjM6wvqabUNiO7U1bppr
         1hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542899; x=1792147699;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJy9OpTpIon+GJbMJg96I4Vtgaq0uoordt8zaL6PqcI=;
        b=Fi+5NKrIl2zpzPpZ2u+NZ08kFRCRJMKOSeGs8NZaOQJKa+oYKB1Y/+IspSuJkVszzz
         uc7tlYhRESI8kByywYRmJnvUIPEF6ipHiL6ThQ797RWkNg1vaJcLyVfgET+IBpgsuu8a
         PAT3iIPwOEDOn+wJBCOSPuA8neVBez+1WTAEFxwVamIsAcKyOT3M+PgJgjBfzawTfZ3A
         T6ygMjd4Af4888XKsrAOejzOGYKjdg6ZjQqe+48zGUKobUU0Y3P2zC2JY9kQzm3YXx7i
         xSmHST2dtLoPZmI780Y+4y6HjjMbGi9T5SRHmuZ/DbPDTV4KLvTF+4x5Zbz8nw6s87Ra
         VF6w==
X-Gm-Message-State: AFq9FYK2T6+9gUqsECz0Y3YbHQPSrL0oEdQSOKYxwv7GlucMWZgL6XuB
	/xgIeWoopyH041aXyys1rPMAP9PDMIDiiZH3Luq3CnMPvvQM5yhtMQn4mAh78NSl
X-Gm-Gg: AYBFou3qiebsr8Cu0WfFWHxho3JME2Ros6Fz7mrhIFIh2+ntwEsVc9tnYPlN/gmhNeX
	WHXtJqTosssj4v6RjqqAtO8L+2bo6TPSp9MFwyD8Pb7PVGcb2r67jHuzixZ1qulNltS5KJP4BOU
	MzzsrwJyeBiwuLRtNQrfwPpDVCny3clVpvdUeGFKymWcs5C2QDcKwi7hfTAKJtE1G83b4W6AQUp
	pzTPUIb4N9bF3Tj+jypqXF3LqzKz3zK4OtqwUoBYGES+hC+gGl3BA3QpvKORuzKlHzIDdVQfJLm
	eBDOX/PqDYOiMl/11RCLizG/wJjEtzEPv3/0Hr0Lht8oMZTNedKo2Dxuqnqcfv6ekEXscAaxvV8
	oqlDy/PtLue3WOcEXBKRUbsO/wluqpO3iBJ/eMfF47wqHtZDTdL4wVEdbyHoF8HEp5tG+2z0JsL
	KRiYA4ok50FWiGHvo0+b2QXy+wWWTBz6uoqrZ7V3bp3OMhFX+8MM6fd70HawDtxjH4a3KZgKyQh
	T6hxXl1YBCCBnc=
X-Received: by 2002:a17:90b:568f:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3ab39fe0e82mr1457362a91.0.1791542898953;
        Fri, 09 Oct 2026 03:48:18 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 02/51] bpf: describe helper stack accesses with arg_access_info
Date: Fri,  9 Oct 2026 03:47:20 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-2-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adjust bpf_helper_stack_access_bytes() to return results as a struct
arg_access_info. The result is based on bpf_func_proto->argX_type
value as in the following table:

| Argument flags       | allow_uninit_stack | Meaning              |
|----------------------+--------------------+----------------------|
| MEM_WRITE            | true               | may_read, must_write |
| MEM_WRITE+MEM_UNINIT | true               | must_write           |
| MEM_WRITE            | false              | may_read, must_write |
| MEM_WRITE+MEM_UNINIT | false              | may_read, may_write  |
| 0                    | true/false         | may_read             |

MEM_WRITE now produces must_write when allow_uninit_stack is true:
the verifier discards previous stack knowledge over the affected
range. Previously, liveness only treated MEM_UNINIT this way.

Also use resolve_map_arg_type() to account for bpf_map_peek_elem()
treating its buffer as an input for bloom filters.

Annotate ringbuf dynptr submit and discard arguments with MEM_WRITE.
Their existing OBJ_RELEASE handling already invalidates the dynptr, but
the prototypes need to describe the write as well as the release.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  6 ++--
 kernel/bpf/liveness.c        |  5 ++-
 kernel/bpf/ringbuf.c         |  4 +--
 kernel/bpf/verifier.c        | 81 +++++++++++++++++++++++---------------------
 4 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d4f32acba236..5c99c024c309 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1731,9 +1731,9 @@ struct arg_access_info {
 	u8 must_write:1;	/* Prior verifier state is destroyed throughout size. */
 };
 
-s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
-				  struct bpf_insn *insn, int arg,
-				  int insn_idx);
+struct arg_access_info
+bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
+			      struct bpf_insn *insn, int arg, int insn_idx);
 s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 				 struct bpf_insn *insn, int arg,
 				 int insn_idx);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 7b317fb5ca82..353b52031577 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1604,7 +1604,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Adapt the signed helper/kfunc access size until both producers are converted. */
+/* Adapt the signed kfunc access size until its producer is converted. */
 static struct arg_access_info stack_access_info(s64 bytes)
 {
 	bool write = bytes < 0 && bytes != S64_MIN && -bytes < U32_MAX;
@@ -1634,8 +1634,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 		return 0;
 
 	if (bpf_helper_call(insn)) {
-		info = stack_access_info(bpf_helper_stack_access_bytes(env, insn,
-								       arg_idx, insn_idx));
+		info = bpf_helper_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else if (bpf_pseudo_kfunc_call(insn)) {
 		info = stack_access_info(bpf_kfunc_stack_access_bytes(env, insn,
 								      arg_idx, insn_idx));
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 3f1013d80544..447863ece26a 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -722,7 +722,7 @@ BPF_CALL_2(bpf_ringbuf_submit_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags)
 const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto = {
 	.func		= bpf_ringbuf_submit_dynptr,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE | MEM_WRITE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
@@ -741,7 +741,7 @@ BPF_CALL_2(bpf_ringbuf_discard_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags
 const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
 	.func		= bpf_ringbuf_discard_dynptr,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE | MEM_WRITE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 353bde9ae227..bbb81ba0f2dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14358,35 +14358,32 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 }
 
 /*
- * Determine how many bytes a helper accesses through a stack pointer at
- * argument position @arg (0-based, corresponding to R1-R5).
- *
- * Returns:
- *   > 0   known read access size in bytes
- *     0   doesn't read anything directly
- * S64_MIN unknown
- *   < 0   known write access of (-return) bytes
+ * Describe a helper's stack access through argument @arg (0-based, R1-R5).
+ * must_write means the verifier destroys prior state throughout size bytes.
+ * In other words, must_write follows the verifier's model of the
+ * function's behaviour, which is safe to use for is_state_visited() pruning.
  */
-s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
-				  int arg, int insn_idx)
+struct arg_access_info
+bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			      int arg, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+	struct arg_access_info info = {
+		.size = U32_MAX,
+		.may_read = true,
+		.may_write = true,
+	};
 	const struct bpf_func_proto *fn;
+	enum bpf_access_type access_type;
 	enum bpf_arg_type at;
-	bool full_write;
-	s64 size;
+	bool exact_size = true;
+	u64 size = U32_MAX;
 
 	if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
-		return S64_MIN;
+		return info;
 
 	at = fn->arg_type[arg];
-	/*
-	 * Generic outputs may leave bytes untouched. Keep prior initialization
-	 * live when the caller cannot read uninitialized bytes. Constructors of
-	 * special objects, such as dynptrs, still define their storage.
-	 */
-	full_write = (at & MEM_UNINIT) &&
-		     (!arg_type_is_raw_mem(at) || env->allow_uninit_stack);
+	access_type = func_arg_access_type(at);
 
 	switch (base_type(at)) {
 	case ARG_PTR_TO_MAP_KEY:
@@ -14409,6 +14406,10 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 
 		i = aux->const_reg_vals[map_reg];
 		if (i < env->used_map_cnt) {
+			/* Bloom-filter peek reads the value buffer. */
+			if (!is_key && insn->imm == BPF_FUNC_map_peek_elem &&
+			    env->used_maps[i]->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
+				access_type = BPF_READ;
 			size = is_key ? env->used_maps[i]->key_size
 				      : env->used_maps[i]->value_size;
 			goto out;
@@ -14418,7 +14419,12 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 		 * Map pointer is not known at this call site (e.g. different
 		 * maps on merged paths).  Conservatively return the largest
 		 * key_size or value_size across all maps used by the program.
+		 * This is only an upper bound, so it cannot establish a definite
+		 * write. Map-dependent argument types can also turn an output
+		 * into an input, so conservatively retain a read dependency.
 		 */
+		exact_size = false;
+		access_type |= BPF_READ;
 		val = 0;
 		for (i = 0; i < env->used_map_cnt; i++) {
 			struct bpf_map *map = env->used_maps[i];
@@ -14434,7 +14440,7 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			}
 		}
 		if (!val)
-			return S64_MIN;
+			return info;
 		size = val;
 		goto out;
 	}
@@ -14448,18 +14454,12 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			int size_reg = BPF_REG_1 + arg + 1;
 
 			if (aux->const_reg_mask & BIT(size_reg)) {
-				size = (s64)aux->const_reg_vals[size_reg];
+				size = aux->const_reg_vals[size_reg];
 				goto out;
 			}
-			/*
-			 * Size arg is const on each path but differs across merged
-			 * paths. Reads may extend anywhere up to the frame top.
-			 */
-			if (full_write)
-				return 0;
-			return S64_MIN;
 		}
-		return S64_MIN;
+		/* Preserve access directions even when the extent is unknown. */
+		goto out;
 	case ARG_PTR_TO_DYNPTR:
 		size = BPF_DYNPTR_SIZE;
 		break;
@@ -14469,18 +14469,21 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 		 * doesn't access stack. The callback subprog does and it's
 		 * analyzed separately.
 		 */
-		return 0;
+		return (struct arg_access_info) {};
 	default:
-		return S64_MIN;
+		return info;
 	}
 out:
-	/*
-	 * Other accesses keep the previous state live, including untouched bytes
-	 * of an unprivileged generic output.
-	 */
-	if (full_write)
-		return -size;
-	return size;
+	info.size = min_t(u64, size, U32_MAX);
+	info.may_read = !!(access_type & BPF_READ);
+	info.may_write = !!(access_type & BPF_WRITE);
+	info.must_write = info.may_write && exact_size && info.size != U32_MAX;
+	/* Generic unprivileged outputs retain prior initialization state. */
+	if (!env->allow_uninit_stack && arg_type_is_raw_mem(at)) {
+		info.may_read = true;
+		info.must_write = false;
+	}
+	return info;
 }
 
 /*

-- 
2.53.0
