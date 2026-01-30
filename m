Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA22737F2
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805740; cv=none; b=CFSeOyCREcQwAUXyNcAam+AfNQbQ6bxU+Gu7T1FIFrm1ahfzh/3avZ4HkHcaueerB2zoThZZ0Bzsv1w1Njk7dt2LSImELzS6wHcVfC3sMOAg26oyxejzUMQHWZk3/uMxdtL+9uMwsIlu3dYeqeGsTjrdiXC53/S2MhKrvWwgoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805740; c=relaxed/simple;
	bh=OscIr7gqtxNUKyjf5n0CZcrVD8Zy+BqlGBsgaBr0b/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KElmOt/6k/qY5WEwI5UYvCSHzOwxpNoEOYtHjdiVW5+JopYADx8eNd0DzMijQhK2Fe+lKG+DAH8xlHA1+RE0EMBPgabZLzMEUcaR1K98MD2XyIXkfAY55aH52XHc/TtAn3EKLr52sqWx0LGbPbO2XOwibdEk4xWqZiqe0P8Ofrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VluXmjYh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VluXmjYh"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so2320089f8f.2
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769805737; x=1770410537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5rnzmnjRqerJcO0QRhFQStNTmpK+ePaVro0e3Lxv/I=;
        b=VluXmjYhSnpI1j6ZWaaf4qe+Imr2oX3k/rq94zXGx6LUUQg1Y31ciywJp7kWLi0mgD
         95IW9st/k7BwfdwI6o0DzSRawbVl+qFbaWqQ7HQwGS1A+PFr477568mrGPZomoqNsOh3
         zxWzS/v5Vic8/LdCPfQqgJ4l34qOKjYD/AyruOAemtKtC1iqzsgqRCDjixAOeOXzLx1Y
         5v4L6Yf84viOsDfeBnfaClGY+HmvxhHgufjzL0gaMcn4xTD7WZoDe/J90Ef57vw1zLub
         eA1l6W1L8tgjTqnP1scVrDod/EZmLL6Z2FATYVRAqwm6pIXrGJL1+EUspg3ZaR/UWe6s
         mEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769805737; x=1770410537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5rnzmnjRqerJcO0QRhFQStNTmpK+ePaVro0e3Lxv/I=;
        b=nSF50S+dPlm6do0fT6ytB4T14eRaiSGoJs2dfgkoTExjah4zLra8XM0gYnFMhVsFgi
         +egKxc8BE/hgOkcADbyJ0bufsCVUR58bLDbYhtR7HgJmSLvGX4VWt0wUt0cvCWAHvz45
         z+mJKqMZx9v7zL1SPTzNPMJGpIUV5Hb60sd8Qg95WVR9Ed978AvYaC/pnb2zymbmSNsL
         jCNH+3QZDAZzjxw5siKBzh+qcsufKupIl5QbjcO5Tfb8D2KhEFQPvPhOJDQKsBDxVknH
         gw6beOxPV2UKIRFvNA5T+p4MMuYUJvVQeAtQjWsVeM8qKM94ROLFv+2FuEuPMh6JpxjJ
         i0Ew==
X-Gm-Message-State: AOJu0YwqEyycP0PI8n7/Ak3p/uyxaK8EkNBn0J7AG7IjIfD01/MX4Ks7
	XVctEi+JJFO3pkPssGpdVB7De0KG0MqMj3xqMWmxNAuQYsws0Ae0FqRx
X-Gm-Gg: AZuq6aJLuPgcb33xjgr0CjMdmB51DgNeb6wzR8LqZNWtISeTsvjpFsEQbitlDITpNte
	fQz2dIs+1224Up+YBJjuoGDljP0WzWvLlX77XcnvmSDoZJcggyfaFFBRWfrCUFdfv+P93RxbUNn
	MtaENdGpls3/UUgUZse6E1WBNcNts/vDuh/6vdzogh8uJd9eV0q809ZKlzD0L7Jew8JuRO6c6Da
	fmE7RwDCXbyOGoyWPS8RzWjJ+ieNdAU3G+xvziFKLWECZeHmD7vQTOxt/J4fcNY1c560dzcGzk1
	qEHo9gl3WPodbC+AWdXhJWH5kmNZaH0h9aS4NHasZidbuUdoC++fenQBaSorAEdan/SIR76FhXr
	/N3HOHxxuwfOgSSQRilqO/iLXkMyICDPBKPLVOxsb8c1EzFUdysSieXU/XtVXCO8hoNUsEw==
X-Received: by 2002:a5d:64c6:0:b0:430:f7ae:af3e with SMTP id ffacd0b85a97d-435f3ab21bamr7151432f8f.32.1769805737360;
        Fri, 30 Jan 2026 12:42:17 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:cab1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c4f3edsm275403845e9.15.2026.01.30.12.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:42:17 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 30 Jan 2026 20:42:10 +0000
Subject: [PATCH bpf-next v2 1/2] bpf: Introduce struct bpf_map_desc in
 verifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-verif_special_fields-v2-1-2c59e637da7d@meta.com>
References: <20260130-verif_special_fields-v2-0-2c59e637da7d@meta.com>
In-Reply-To: <20260130-verif_special_fields-v2-0-2c59e637da7d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769805735; l=9681;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=x93cDua/9G6FPBHIRl3ECwHJSc7M+G2hI0QakONf2XU=;
 b=p2GSmOxfno+Xd8R3Tf7dwa5CDQrwukIXmkGiLoFQmNM8UG+cS25Z56CbLozQ7pgSes8f44ev/
 VBXED9R/fN4Bd3U1kBA+tsLm5B9w0CejR8/scRMuBoB/yYtxyJNk3ti
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

