Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAF2AF1B
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708322; cv=none; b=apGB02CdGXydszC4jQu3wWA94x5O6n+POOya+7paJCK+3zIrTt0z273KkrZum5ejatcx9Mtvh431G6SFso342yCfrPjO8JyIiIu3LaGabIhY1ejtQm8rcXPB7+G1cpV4l/xfENQ7AZosF2EuD1+FkhBwNX34flTZmCjbO1sYaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708322; c=relaxed/simple;
	bh=O/jcH7aNmFAwkhIZomwRlb8J+3QLDVYUJlF7vAo2taQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH3qPJpCuZI3xsTBWu1BY9bxE7a0YmoCDXDBTre5tcEgyoyyRIqhOvBzGOiowdw7gGcB+VkZGMduSIbyNuBlvVRGEttiA7Ks87ABCE1AQQc7mqcStn88xHX+ruwyFGPadn7kTIGXXWyyrdFmLcGbjIntP+ltL2vYWWqV83tVsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imy+NCsD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imy+NCsD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47edffe5540so15638395e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 09:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769708319; x=1770313119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2q9MBoUYt5V7rPxiSK8ZYm8Pxm0CfFIdZLp7KHeG8M=;
        b=imy+NCsDeSKXsMB64j9FFlM4CxXs3hVFlt2CG+ACS54RYHOWBk3gf2LkKn1idHTjjJ
         c7AXVlGbMp9ECkEx9jkc8V1AOfHypI+EHv6yOlXyjMYNsLSZb4cIgrAY1dF9ixCtApdB
         GFL0+1DDRZHaxzZbirbet5TtZE3JEhSKGXWAX4vQ1HxyIanW1+t0siaitSqxkyWQYXlz
         2eW2EljIQ+vH+oKvu6DV3L/2dn1g5x+ZWgg2xxK5ITgfUJ7u7MMCayzNTnLO9rgHEGAB
         WPFFe8HUJQJ4XmGLtzAfMEV0HcEeCYF8TiBJblWWlXB0QE7CkK5foMmVKNnzpuovYKqb
         otwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708319; x=1770313119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2q9MBoUYt5V7rPxiSK8ZYm8Pxm0CfFIdZLp7KHeG8M=;
        b=ueu+REMOU1IeJxOo/lzzaiIGqo8lrzaHHswVWeHBV973MJV9+mnpmTzP/3DT0ShAob
         vTKzPgoqB1uoI+QpY+U5NWsykS+bYQZuFgeno3fM8MxugcSmeLBhgh5wg8r8yHQvBGas
         3m95J/6+SFhYL7AtdUOA02yCPXtglpMEuDS6aw64IOmOrJUaYup92XPwcLnJyBG4k0KZ
         CqUYC2j7tNrYM8tlgwib5YbVaphFCllceo5TI68M/DEU8XWpkb3ohD0KQguuKIXRXOQX
         q/rAzQuHssznKrQQN4rAzAMQEbDoOyTgRGFwaZTW+yPBt5mZGV4pZ37cbWvOE86eFwGw
         M/Jg==
X-Gm-Message-State: AOJu0YzmnWG4uAF2C2e/E1/DNoyIxpuagfMBXBDUtxdXrgm3MfSYvdwG
	cZNbi5qka1vl61I+LAw0YtU1aZ5lOLlb1fJF5jH463mH1F8oE3LwgBDX
X-Gm-Gg: AZuq6aLQAJCe1aSxb6LCH4tKV9TUb21BftaELHyxMyubGgsrycxaU5OWtuj1gv5JeuN
	f+dADn7FpGwPmP/TbDUo5uv3feNFDZblwq7Y337oN08QvZc+qfOd3aJsRcIx+OlB2z9Vg9yMckE
	IZXFHxfsHp/g4UfkGFeNZ4MByYrS1V3611IhL5BY0YJ/b24zT51XoH0TK3TgjYvVlyKfOjxCeTB
	rskVsM8rex2zQ5DLUVaJieJcE1B5M4YWlf3quqQP0y8lCmTL/rxWWCJWnXFeD6tLSjzQAg0Um0b
	GBalDrjqZWN0PYeG1ZMNWZMZP2a0fLhP7Admcrjy+6qiMSFuP6e1izZaInUN3c+rA3vWZRdIF8Y
	cQkmImq3Ym/nU/eXsTeshzym3cVpE1P8+cOeZkVpi53moK6+GYXQ8LPgk0g+qFZQ6FUUqRwzwWh
	dFz3jNag==
X-Received: by 2002:a05:600c:c08e:b0:480:7162:fa48 with SMTP id 5b1f17b1804b1-4807162fc49mr61929505e9.13.1769708318405;
        Thu, 29 Jan 2026 09:38:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:48a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066beeaf9sm221975345e9.6.2026.01.29.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:38:38 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 29 Jan 2026 17:38:24 +0000
Subject: [PATCH bpf-next 1/2] bpf: Introduce struct bpf_map_desc in
 verifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-verif_special_fields-v1-1-d310b7f146c8@meta.com>
References: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
In-Reply-To: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769708316; l=9633;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=2VGLoPhYBGQAWdpBkeFVtm1gujHTZZ2DiHDDryLDQ/E=;
 b=+VMMAoul/2gvQqCc2/uPYCnpihELM9iMvlxLxePvTSFsA+apXIKZIHtcfh59P4YBm02r9oVS9
 69Gy00/WAVYBrU+AR4GHS3bN6yzqOSOTXkCB7DU4VFCRPpQMp85OG97
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce struct bpf_map_desc to hold bpf_map pointer and map uid. Use
this struct in both bpf_call_arg_meta and bpf_kfunc_call_arg_meta
instead of having different representations:
 - bpf_call_arg_meta had separate map_ptr and map_uid fields
 - bpf_kfunc_call_arg_meta had an anonymous inline struct

This unifies the map fields layout across both metadata structures,
making the code more consistent and preparing for further refactoring of
map field pointer validation.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 79 ++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2f2650db9fdf71737eecd56febbe3cbf8fe42b4..2c5fb7be73923b9f8395a6fae53209f002c48fd1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -272,8 +272,13 @@ static bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
 	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
 }
 
+struct bpf_map_desc {
+	struct bpf_map *ptr;
+	int uid;
+};
+
 struct bpf_call_arg_meta {
-	struct bpf_map *map_ptr;
+	struct bpf_map_desc map;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -283,7 +288,6 @@ struct bpf_call_arg_meta {
 	u64 msize_max_value;
 	int ref_obj_id;
 	int dynptr_id;
-	int map_uid;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -351,10 +355,7 @@ struct bpf_kfunc_call_arg_meta {
 		u8 spi;
 		u8 frameno;
 	} iter;
-	struct {
-		struct bpf_map *ptr;
-		int uid;
-	} map;
+	struct bpf_map_desc map;
 	u64 mem_size;
 };
 
@@ -8666,7 +8667,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 	if (err)
 		return err;
 
-	if (meta->map_ptr) {
+	if (meta->map.ptr) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
@@ -8674,8 +8675,8 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
-	meta->map_uid = reg->map_uid;
-	meta->map_ptr = map;
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = map;
 	return 0;
 }
 
@@ -8739,7 +8740,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 		rec = map_ptr->record;
-		meta->map_ptr = map_ptr;
+		meta->map.ptr = map_ptr;
 	}
 
 	if (!tnum_is_const(reg->var_off)) {
@@ -9246,13 +9247,13 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
 {
-	if (!meta->map_ptr) {
+	if (!meta->map.ptr) {
 		/* kernel subsystem misconfigured verifier */
 		verifier_bug(env, "invalid map_ptr to access map->type");
 		return -EFAULT;
 	}
 
-	switch (meta->map_ptr->map_type) {
+	switch (meta->map.ptr->map_type) {
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
@@ -9906,7 +9907,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	switch (base_type(arg_type)) {
 	case ARG_CONST_MAP_PTR:
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
-		if (meta->map_ptr) {
+		if (meta->map.ptr) {
 			/* Use map_uid (which is unique id of inner map) to reject:
 			 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
 			 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
@@ -9919,23 +9920,23 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 *
 			 * Comparing map_ptr is enough to distinguish normal and outer maps.
 			 */
-			if (meta->map_ptr != reg->map_ptr ||
-			    meta->map_uid != reg->map_uid) {
+			if (meta->map.ptr != reg->map_ptr ||
+			    meta->map.uid != reg->map_uid) {
 				verbose(env,
 					"timer pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
-					meta->map_uid, reg->map_uid);
+					meta->map.uid, reg->map_uid);
 				return -EINVAL;
 			}
 		}
-		meta->map_ptr = reg->map_ptr;
-		meta->map_uid = reg->map_uid;
+		meta->map.ptr = reg->map_ptr;
+		meta->map.uid = reg->map_uid;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
 		 * stack limits and initialized
 		 */
-		if (!meta->map_ptr) {
+		if (!meta->map.ptr) {
 			/* in function declaration map_ptr must come before
 			 * map_key, so that it's verified and known before
 			 * we have to check map_key here. Otherwise it means
@@ -9944,11 +9945,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verifier_bug(env, "invalid map_ptr to access map->key");
 			return -EFAULT;
 		}
-		key_size = meta->map_ptr->key_size;
+		key_size = meta->map.ptr->key_size;
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		if (can_elide_value_nullness(meta->map_ptr->map_type)) {
+		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
 			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
 			if (err < 0) {
 				meta->const_map_key = -1;
@@ -9966,13 +9967,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		/* bpf_map_xxx(..., map_ptr, ..., value) call:
 		 * check [value, value + map->value_size) validity
 		 */
-		if (!meta->map_ptr) {
+		if (!meta->map.ptr) {
 			/* kernel subsystem misconfigured verifier */
 			verifier_bug(env, "invalid map_ptr to access map->value");
 			return -EFAULT;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
-		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
+		err = check_helper_mem_access(env, regno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta);
 		break;
@@ -11310,7 +11311,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		int func_id, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
-	struct bpf_map *map = meta->map_ptr;
+	struct bpf_map *map = meta->map.ptr;
 
 	if (func_id != BPF_FUNC_tail_call &&
 	    func_id != BPF_FUNC_map_lookup_elem &&
@@ -11343,11 +11344,11 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	}
 
 	if (!aux->map_ptr_state.map_ptr)
-		bpf_map_ptr_store(aux, meta->map_ptr,
-				  !meta->map_ptr->bypass_spec_v1, false);
-	else if (aux->map_ptr_state.map_ptr != meta->map_ptr)
-		bpf_map_ptr_store(aux, meta->map_ptr,
-				  !meta->map_ptr->bypass_spec_v1, true);
+		bpf_map_ptr_store(aux, meta->map.ptr,
+				  !meta->map.ptr->bypass_spec_v1, false);
+	else if (aux->map_ptr_state.map_ptr != meta->map.ptr)
+		bpf_map_ptr_store(aux, meta->map.ptr,
+				  !meta->map.ptr->bypass_spec_v1, true);
 	return 0;
 }
 
@@ -11357,7 +11358,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
 	struct bpf_reg_state *reg;
-	struct bpf_map *map = meta->map_ptr;
+	struct bpf_map *map = meta->map.ptr;
 	u64 val, max;
 	int err;
 
@@ -11913,22 +11914,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		 * can check 'value_size' boundary of memory access
 		 * to map element returned from bpf_map_lookup_elem()
 		 */
-		if (meta.map_ptr == NULL) {
+		if (meta.map.ptr == NULL) {
 			verifier_bug(env, "unexpected null map_ptr");
 			return -EFAULT;
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
-		    can_elide_value_nullness(meta.map_ptr->map_type) &&
+		    can_elide_value_nullness(meta.map.ptr->map_type) &&
 		    meta.const_map_key >= 0 &&
-		    meta.const_map_key < meta.map_ptr->max_entries)
+		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;
 
-		regs[BPF_REG_0].map_ptr = meta.map_ptr;
-		regs[BPF_REG_0].map_uid = meta.map_uid;
+		regs[BPF_REG_0].map_ptr = meta.map.ptr;
+		regs[BPF_REG_0].map_uid = meta.map.uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
 		if (!type_may_be_null(ret_flag) &&
-		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
+		    btf_record_has_field(meta.map.ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 		break;
@@ -12031,7 +12032,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (type_may_be_null(regs[BPF_REG_0].type))
 		regs[BPF_REG_0].id = ++env->id_gen;
 
-	if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
+	if (helper_multiple_ref_obj_use(func_id, meta.map.ptr)) {
 		verifier_bug(env, "func %s#%d sets ref_obj_id more than once",
 			     func_id_name(func_id), func_id);
 		return -EFAULT;
@@ -12043,7 +12044,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
-	} else if (is_acquire_function(func_id, meta.map_ptr)) {
+	} else if (is_acquire_function(func_id, meta.map.ptr)) {
 		int id = acquire_reference(env, insn_idx);
 
 		if (id < 0)
@@ -12058,7 +12059,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err)
 		return err;
 
-	err = check_map_func_compatibility(env, meta.map_ptr, func_id);
+	err = check_map_func_compatibility(env, meta.map.ptr, func_id);
 	if (err)
 		return err;
 

-- 
2.52.0

