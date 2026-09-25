Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F04F6489
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370784; cv=none; b=Ik2qk5384h6c0LTCDnBhgj3oN0DcBLrg/68cXeQbf/qNwkwV5iT2m62+a2j5HImtg+Zu+qYyqoRwBsXAJ7za7x2phtS/WkoGAd1UUxMlbV6yiRzSBWAag+pwG6cWTZNBvUmFtF0n70eZadRhH3f5HaYxGDsb8tPB8KHjFQb+TDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370784; c=relaxed/simple;
	bh=qvV1yA5+6ON69x4ft2et525KJQUCjqwJVucXSOWasdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ0x691Q9nErgYQwcNk10vpImtQavh7vgq6j1vFn8q06u6+B7txbzSYFXKLSyEG6xE2RMXqSMgj0cVhh6bkFogneUlguUTuXCnsw3l/pw8t84/XduRJekhBTqZ5Z3R/8kSEH98d7vzPVFnZ+Gj0CHj3gC8uRlXJL+N1T2N0j+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP0Av2Ft; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP0Av2Ft"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-492d8c4add0so828138fac.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370781; x=1790975581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkLQZFOo9kb23ID2KMOGbJI7Lu5qA0zMwN/Hzw0Aru8=;
        b=eP0Av2FtEUFG2gmfB6S99+CU7DBMRXWn+Q4BIbNieuw18wpCIVJYCf3pTzknAyDgIa
         SEZXV2oLZzK/56vQTeIpzZblsuBp/GRN1piiXtz+1bjWjE0Jl7BMNGINxaZ6QAFDbAry
         AzXxG5W/KwTeb+JgLjYvjDj5gjrQAVv76Gx5ypwmciLz1XMxEHU2rFRsQTGNOc+26BNC
         i1tTwrcfZEhRWCP927P0HfFGRRqYPVzgPvm33tXxwIlExMAaEf58gImiB8eUWH62KKj2
         0ai5iPOujqi/92tA92GTCRf0oYoV7lmdcwxK8t4hJjHjlEmwSOu+qfaCEPh3TdY19/Es
         vW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370781; x=1790975581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bkLQZFOo9kb23ID2KMOGbJI7Lu5qA0zMwN/Hzw0Aru8=;
        b=DO8TZhO4BG721TnTYTFjLjO67ZybvKAFFF4Aew4lNaFVq1Q/tJuGi0S05VpVR9vF2h
         W8u3UZ2mK/QpO3iJwm4F6nYR934xrZg6xmRZge+ZiTKmCdPpWKj8dDOmQvP2uxzQwFm5
         l8rpzAn3mcn+UUTIbGjpe19OakRqz7IuhWchhwniqfemoekiDZlHPNJLAmtswZ9B86jk
         z7hc9Umr6bS9a91lvaC0M6hqCT0B//SGLmTRlLSXr/sUQS4ch3zd9ME0KZOP++E3LpFJ
         d2F+KinC9/N88agcYGI0SRcp8FNOG+QyqLNfL1mUiat1pN1S8RDBJFvAYMEAYRZ4ERlb
         z1GQ==
X-Gm-Message-State: AFuF++m/qIue1+v/5Xbu6fUYvn4Zm/NXo3Tsir8dYOxAUXufg6+Dadgh
	Wi56hAvdrqFklXNeHD3+0YXbgBH5qbI/i2L4JN+1148IXPT5a3G+0nE73OkW7g==
X-Gm-Gg: AYBFou2SmHnxJCqooojv1nxeR3SIuRNTOAXZS6O2fgtP7QZg3L478lRc31PdN+B3Vc1
	T+Q7CY4Ct0+ZP76uh1UF537mlm35bq2qM8NocLyXPMLIsihmtHsBCIxDZby/ZQNOQj0CLYkbxAX
	s1nEz2VabXUBQJrfhKqZmvvk3wQMw9ujFSLRJ9L1XNZS0hLjIgA0deeRgqJ2Q7Pnfn/8TZlyWAr
	UFECdJ8gvbnHDyftBdq/yGmQcPHfa4HeUIsiTK7ZfM6p1UWENO3y0L3+ZjNy5ICGlu+/CWNZcF3
	c8Bp+CxQUxzN5a/xGPSJbzRNJKDYXpxYVN9dgj9B47l3wHfCAYQj2M8oh/W12AjtVAIX/rb1stB
	jQk3w82WfTuJt7kOGJPizF1MXwoTOiJD+7Hb/MMQUdXZ0UBfYYS4IN4vhxHakTcVuzUj3OIYLZ1
	BuM06AY8bSJTxdtaweeqo8eWHZC8sMHIVuXkTQpOeQx1AhT1cOn/DDH0PAjz6+FA==
X-Received: by 2002:a05:6870:4596:b0:475:a112:1278 with SMTP id 586e51a60fabf-491e700c4ccmr7023369fac.37.1790370781386;
        Fri, 25 Sep 2026 14:13:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4933511a1a6sm2845943fac.3.2026.09.25.14.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/12] bpf: Identify subprog calls in argument metadata
Date: Fri, 25 Sep 2026 14:12:46 -0700
Message-ID: <20260925211256.1834061-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare subprog calls to use the common check_func_args() path. That
checker distinguishes call kinds through bpf_call_arg_meta, but
btf_check_func_arg_match() leaves both BTF and the function ID zero even
though it validates a program-BTF signature.

Represent a subprog call with a non-NULL BTF and a zero function ID.
Define helpers as NULL BTF plus nonzero ID, and kfuncs as non-NULL BTF
plus nonzero ID. Requiring a nonzero kfunc ID also prevents unavailable
special-kfunc IDs from matching subprog metadata. The corresponding
subprog predicate is introduced later alongside its first use.

Setting BTF would expose checks that treat every BTF-backed call as a
kfunc. Restrict kfunc-only BTF parameter lookup, register admission,
release diagnostics, no-cast alias, and projection handling to actual
kfuncs.

The BTF is not modified here, but bpf_call_arg_meta::btf and several
downstream consumers use non-const pointers. Match those existing types
instead of broadening this series with a const-correctness cleanup.

No functional change is intended.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2792dcf91061..43cae33d9921 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8638,18 +8638,27 @@ static bool arg_type_is_scalar(enum bpf_arg_type type)
 }
 
 /*
- * A kfunc is named by a BTF ID, which can take the same numeric value as an
- * enum bpf_func_id. Only test meta->func_id against a BPF_FUNC_* once the call
- * is known to be to a helper; meta->btf is set only for a kfunc.
+ * A helper has no BTF and a nonzero function ID. A kfunc has both, while a
+ * BPF subprogram has BTF and a zero function ID.
  */
+static bool is_helper(const struct bpf_call_arg_meta *meta)
+{
+	return !meta->btf && meta->func_id;
+}
+
 static bool is_helper_call(const struct bpf_call_arg_meta *meta, enum bpf_func_id func_id)
 {
-	return !meta->btf && meta->func_id == func_id;
+	return is_helper(meta) && meta->func_id == func_id;
+}
+
+static bool is_kfunc(const struct bpf_call_arg_meta *meta)
+{
+	return meta->btf && meta->func_id;
 }
 
 static bool is_kfunc_call(const struct bpf_call_arg_meta *meta, u32 btf_id)
 {
-	return meta->btf && meta->func_id == btf_id;
+	return is_kfunc(meta) && meta->func_id == btf_id;
 }
 
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
@@ -8962,7 +8971,7 @@ static int check_func_arg_release(struct bpf_verifier_env *env, struct bpf_reg_s
 	verbose(env, "release function %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 		meta->func_name, reg_arg_name(env, argno));
 
-	if (meta->btf) {
+	if (is_kfunc(meta)) {
 		const struct btf_param *btf_arg;
 		const struct btf_type *t;
 		u32 ref_id;
@@ -9016,7 +9025,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		verifier_bug(env, "unsupported arg type %d", arg_type);
 		return -EFAULT;
 	}
-	if (meta->btf && base_type(arg_type) == ARG_PTR_TO_BTF_ID &&
+	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_BTF_ID &&
 	    (base_type(type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(type)]))
 		goto found;
 
@@ -9039,7 +9048,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 	/* Allow allocated memory for kfunc ARG_PTR_TO_MEM but not helper. */
-	if (meta->btf && base_type(arg_type) == ARG_PTR_TO_MEM &&
+	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
 	    type_is_ptr_alloc_obj(type))
 		type = PTR_TO_MEM;
 
@@ -9362,7 +9371,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
 {
-	const struct btf_param *btf_arg = meta->btf ? &btf_params(meta->func_proto)[arg] : NULL;
+	const struct btf_param *btf_arg = is_kfunc(meta) ?
+					  &btf_params(meta->func_proto)[arg] : NULL;
 	const struct bpf_func_proto *fn = meta->fn;
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_reg_state *regs = cur_regs(env);
@@ -10788,7 +10798,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 }
 
 static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
-				    const struct btf *btf,
+				    struct btf *btf,
 				    struct bpf_reg_state *regs)
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
@@ -10800,8 +10810,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	u32 i;
 	int ret, err;
 
-	/* Leave btf and func_id zero: this is neither a helper nor a kfunc. */
 	memset(&meta, 0, sizeof(meta));
+	meta.btf = btf;
 	meta.func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
@@ -13781,7 +13791,7 @@ static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_re
 	 * resolve types.
 	 */
 	if ((arg_type_is_release(arg_type) && !is_helper_call(meta, BPF_FUNC_sk_release)) ||
-	    (meta->btf && btf_type_ids_nocast_alias(&env->log, reg_btf, reg_btf_id,
+	    (is_kfunc(meta) && btf_type_ids_nocast_alias(&env->log, reg_btf, reg_btf_id,
 						    arg_btf, arg_btf_id)))
 		strict_type_match = true;
 
@@ -13798,7 +13808,7 @@ static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_re
 	 * actually use it -- it must cast to the underlying type. So we allow
 	 * caller to pass in the underlying type.
 	 */
-	taking_projection = meta->btf && btf_is_projection_of(arg_tname, reg_tname);
+	taking_projection = is_kfunc(meta) && btf_is_projection_of(arg_tname, reg_tname);
 	if (!taking_projection && !struct_same) {
 		verbose(env, "%s %s expected pointer to %s %s but %s has a pointer to %s %s\n",
 			meta->func_name, reg_arg_name(env, argno),
-- 
2.52.0

