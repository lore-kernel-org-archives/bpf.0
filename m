Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85C37FF50
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121120; cv=none; b=WieB2cesVxTSJQeUgIVtUdXnaLwkO8/QlgWGvNpyyJTEXZv+iKvrK/lng0FhBkcEy/6bbiI0ayhYC/oG76cSwzkP2qTl0VC7+Tios9oA2v+IQevKj9qcNQtIE4QoJFANpgDbgML0+LmVdXBbwnlhtzAn+RyAXKitSIccFzB1OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121120; c=relaxed/simple;
	bh=Mu8l153blKmR38XU+M3FTv1PTjW0z5uZEOJQZTdH2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0rK1jCPwNbqwb0ClKeT00Gs/6ozItxN6vrs3vngDM5SF6i3rPjOP9jSiBgf3oSSQJdW67389qJ3Dn/t5ZJTMHO1X2g1qCHYXi1fugAYfBcwgKyxEDpgxRnez4sd8B1QnMrLr2a9GeoE3ChmpJn3DIoPMWXKKQ8wZplGbyGOVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGV1hQxM; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGV1hQxM"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso285689a12.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121118; x=1791725918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BCPRQCQ8C7SCHpwXeJ7IGK9IZAvCQlUk4m+FAHyeBOQ=;
        b=cGV1hQxMAlKdLTGxYfWfoS29iPjkAIGimeUnWF7KYOTLzjAKIrp/zbc4WoS35JBcHR
         BdD3hpKdEWY6V33dposSwDEXks1CgbotA1S7K9JkFAVpl6XKV/KZ1TxPW5Dbyg82jpmI
         1HnGk5jItp+xWoL8e+n19fyWCBdLXFXwY33N+ZE0PPWSzWISSJxA/XR0FU0g/DGh5w6B
         cV+euTKt1+bSnB0kxgpYyLRg4S/MTNU1ZbKmyHZwkII3Haq2JyxW9guIBUO3/VMSa2K3
         y3caC1NbnDhsxzDkgzPZoCJPbXEYUpJQsfPu8vhRy4dsjzVBNizXc5jc3rSFgnsiGiqe
         BjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121118; x=1791725918;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCPRQCQ8C7SCHpwXeJ7IGK9IZAvCQlUk4m+FAHyeBOQ=;
        b=1e7zAZ3QSDLhxHgM9NNFTYdeYM7rkPpNvMnwTEqLKOLUgt33yiae0NJwxNN/pfzV/S
         MJiOzprCHivzw/CnsW6kks1cqQ+tyw5L2iDG8xRedAEGo3/8dJyk/yB4iZxsULnl5kvc
         1/geFfTBGAr8w+ZeCpa5yAfq4TJSmlKOaGVtzzHlDbAh5p6b42pEJJIvYILd2Y9Qrgm8
         9NDcbGyRwa8rPze9ePgWNrptvlpLYp4fN6K4+VKK4CSt8KnJU3pzVP7J3lV26rzzEBDA
         Ww/ydJY3h7AH6+dkUiDp69s4iAsiXoAFc0DpPk3KcAjxK06PFIdiB1vDOamdBV2tVXX2
         CHwQ==
X-Gm-Message-State: AFuF++l10hPIq9PJB1lYnymKmdAEjZTj73rWGN6HeyxeHh1d1ZgG8Gde
	F/YQemBdWtKBgD1zC2gcCHjPzQSRhrno9xJkRdI52Ph8aBaL67UvlNeLxLkJ1A==
X-Gm-Gg: AYBFou0uLN3TEnobyMPrHLkwKpvo5IJwWoz641NiFeRUIgMBhCLzssV2VuoRT7kiIKf
	75/T8tjExBjdzEQJ1E3ZSylEmAh195RiiMTfhXZCrYFTBTZ5SpGTtV++0IbXo+agG07Hwr+ntFv
	t5c5zerqv9uMsfAucbQFVipawpSaMuF0hcmmp2yPL2h+dj7l6OAsZqqZTqFGoKC7f5u9CizPl9l
	ABVTO0yt2qfhwsfcN8JAmEEYnyrtnbtQk17fbdU/DdwXTt4mrI7phypI5cnW5j/OZGvkGBfhXgt
	E3MEGLEab33DIZoVfsKO8y8s0t8M8WK+ZgMyrYOsTlEX9bFreauMfNAmvsBY7nhnrGwB/qwwOuR
	u5uBHqEcrPkzmCDUw3LpdOfwcRbJjxe2ov8DFJJtu/Gkl7EGFOF4FAx70lHascXlxY+Ol2zaN9+
	aWCGOBlqPm5XfE7NxzVK4RBJnG7hr90+QJjM+mgrScJRuxoDQbcQ7VIYS0G+ggmH52KQuc/kNFQ
	m8urpm+zbfvhyxK1byfVmpZNQ==
X-Received: by 2002:a05:6a20:da1b:b0:3dd:85a8:4c67 with SMTP id adf61e73a8af0-3e0bd2575a0mr7534791637.46.1791121118063;
        Sun, 04 Oct 2026 06:38:38 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 02/43] bpf: describe helper stack accesses with arg_access_info
Date: Sun,  4 Oct 2026 06:37:44 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-2-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
| MEM_WRITE            | false              | may_read, may_write  |
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
index fd3c0206bd67..b558399bdc08 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14344,35 +14344,32 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
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
@@ -14395,6 +14392,10 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 
 		i = aux->const_reg_vals[map_reg];
 		if (i < env->used_map_cnt) {
+			/* Bloom-filter peek reads the value buffer. */
+			if (!is_key && insn->imm == BPF_FUNC_map_peek_elem &&
+			    env->used_maps[i]->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
+				access_type = BPF_READ;
 			size = is_key ? env->used_maps[i]->key_size
 				      : env->used_maps[i]->value_size;
 			goto out;
@@ -14404,7 +14405,12 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
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
@@ -14420,7 +14426,7 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			}
 		}
 		if (!val)
-			return S64_MIN;
+			return info;
 		size = val;
 		goto out;
 	}
@@ -14434,18 +14440,12 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
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
@@ -14455,18 +14455,21 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
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
