Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6A45A285
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920114; cv=none; b=ZJPeQdppcpkk4UQP4uOj9dRURFSgbjV09/OMqNQyLk08EWHkCq92eVtWRAWK3Rapq2G9yRFRCIFWr3jBNPYg+7lOwYRIkTBktj51si6vkNDFyfUjOoTdbew+CGEWRubSAYlEd3BOV6gbZak7YpcVeQWe4QLROG4rIgdKZ5hYD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920114; c=relaxed/simple;
	bh=CCnQ87WcRNCe+d5qnYheYbqUwKDnVN6dB26AW8hQGdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tINSyMI9TQma/Q2UdogRAQkSB+GoUhSDnsAiSyNzBjBuCe+uMSKAESJ7OEZPhrttqAgVC17dOWZGlHAkbrtR9HAIfRg38D42VkjqQmQfmD4A3DUvGnWcQLWFcdmahnKAiTmJLZ3TPAMBVrPaIOCI/M91AsvmcMAyRVcljHIDJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwcO1XTu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwcO1XTu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceb096e675so10651125ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920112; x=1785524912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5i1eGUZoanW3HyQyf96dF4zCJKvJyGS/knL/fru1g34=;
        b=GwcO1XTu4hDGM/UAH1W6im7B1OnePjWiGdOMPGCuWkN19l9F2UbUvyHf2oLmOIeeiJ
         XOHViZXedrt4XjMzG5FXgdeVviEzpKfJgu5MnIPco0GXwKB0eq+lzxrW4SpucBgbLWmT
         TtiUoZt2UGG1D8G093LBYaYwhVix8eKue911LlpvQ6F18aHoiRwGnwXfb1br81H0P3a7
         pqnufP22t3sE5E8d5Un2RYsOFx3uG78zCQUqoEJkXjrgF3gIz5idnMKIhH/yJYcI1ohl
         ycGAcQ0GOIQiAtTYt2js2a1Kv9zacDEET/1vBkfaDKs+e5lwPhHAygHXHlWRsgbTvQi8
         7rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920112; x=1785524912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5i1eGUZoanW3HyQyf96dF4zCJKvJyGS/knL/fru1g34=;
        b=ejxxbQIpTAtSRqvGG5NWVM68LyjCMVTBb1R6J2+F6hcc9QJKaMqxJV8bcEEavSpKuv
         OQa08sOIT3JsZEEZ6Dbkeo3U3gIe6tCXOaVud3RQ95+G9e5Zztgo95+AfyF4XzD3Puan
         5Bj5Aicsy/caUKT9LNmmJYo6Abpu3xx0U5pO23eLwqcP2y7Q16VawFqr/ybIOnZ4QEEo
         W6Q9RG4qyf5f7claGBfEN+tZa4B+35d71isbzB5W9NWubSdvtIrOfWZ+cTdz4aFTX86L
         qnej5aSjWaj4s1oPT/hfQ45Ft+9rdtSQLK4VmM50RVeANWXVzs5kYhs89OPBFjz5FSVz
         blxQ==
X-Gm-Message-State: AOJu0Yz0mFQwL8RISg6JbubXSJzbm8FzN+HYA0C1qE1YknLSJrmINkpG
	X8qq5UJJm4p3wBoip/qQXGFQpbUXBKvk3vow1l821ZmeRnK2QQdJHxQhJqQEwg==
X-Gm-Gg: AR+sD11eZFHnovWfkv/7s1LksgpiDnOCMv8Nxp57a8Kv3JWVBRzXA6QLvnjgz0A0Qni
	x9w9B44rnuzkStzRpdehgSePa1OqAjfUlu6/ISJBGm5ljX7bRyvxhmsQVzyfLOWPaY+sGtbxVrR
	o+J6DR9ucSyZ3x+oPaKnpQy5uNmhqbr+BfyR2StYENsEIUVNMjiWPeGFfNGAg3gZpvf+6339OCT
	hQarpT2i4ZabcQ5WGaVBE2AAxJ5eVU1WQ6/WcXO77/qxyB6mUR7yvD1LzHjaBRaCNm0K2ZfochN
	2ixa+3ao+Z8CzyAvFwb83pjFYUL2619MEfsryvXFV9q29GcHlGv11KXh9D12rgKqApqkXvX+ypQ
	4JPVfaB1W1y9GUwiSodJsphRzs3pTeI692Pib+DEdOrqBQ/OoGGhe7KQlvk5huwGSAMvQ
X-Received: by 2002:a17:902:d490:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2cfa6bc41bemr105209735ad.21.1784920112651;
        Fri, 24 Jul 2026 12:08:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd828asm56717515ad.19.2026.07.24.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 17/18] bpf: Classify scalar kfunc arguments from BTF
Date: Fri, 24 Jul 2026 12:08:11 -0700
Message-ID: <20260724190813.1458271-18-ameryhung@gmail.com>
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

Add kfunc scalar argument types, classify them in get_kfunc_arg_type()
along side with pointer arguments and move scalar type verification
into the main switch in check_kfunc_args(). This keeps BTF-based
classification separate from register validation for every argument,
paving the way for generating the kfunc argument prototype at add-call
time. No functional change intended.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 118 +++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3b357007e893..e44fc7296d0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11099,6 +11099,11 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 	KF_ARG_PTR_TO_TASK_WORK,
+	KF_ARG_CONST,		       /* const scalar */
+	KF_ARG_CONST_MEM_SIZE,	       /* const scalar sizing a preceding memory arg */
+	KF_ARG_CONST_ALLOC_SIZE_OR_ZERO, /* const scalar sizing a returned buffer */
+	KF_ARG_MEM_SIZE,	       /* scalar sizing a preceding memory arg */
+	KF_ARG_ANYTHING,	       /* unconstrained scalar */
 };
 
 enum special_kfunc_type {
@@ -11355,14 +11360,40 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 }
 
 static int
-get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-		       const struct btf_type *t, const struct btf_type *ref_t,
-		       const char *ref_tname, const struct btf_param *args,
-		       int arg, int nargs, argno_t argno)
+get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+		   const struct btf_param *args, int arg, int nargs)
 {
+	const struct btf_type *t, *ref_t = NULL;
+	argno_t argno = argno_from_arg(arg + 1);
+	const char *ref_tname = NULL;
 	bool arg_mem_size = false;
 	int arg_type;
 
+	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
+
+	/* Scalar arguments are classified from their BTF suffix/name alone. */
+	if (btf_type_is_scalar(t)) {
+		if (is_kfunc_arg_constant(meta->btf, &args[arg]))
+			return KF_ARG_CONST;
+		if (is_kfunc_arg_const_mem_size(meta->btf, &args[arg]))
+			return KF_ARG_CONST_MEM_SIZE;
+		if (is_kfunc_arg_mem_size(meta->btf, &args[arg]))
+			return KF_ARG_MEM_SIZE;
+		if (is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdonly_buf_size") ||
+		    is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdwr_buf_size"))
+			return KF_ARG_CONST_ALLOC_SIZE_OR_ZERO;
+		return KF_ARG_ANYTHING;
+	}
+
+	if (!btf_type_is_ptr(t)) {
+		verbose(env, "Unrecognized %s type %s\n",
+			reg_arg_name(env, argno), btf_type_str(t));
+		return -EINVAL;
+	}
+
+	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
+	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
+
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -12051,7 +12082,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
 		u32 ref_id, type_size;
-		bool is_ret_buf_sz = false;
 		int kf_arg_type;
 
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
@@ -12075,39 +12105,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
-		if (btf_type_is_scalar(t)) {
-			if (reg->type != SCALAR_VALUE) {
-				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
-				return -EINVAL;
-			}
-
-			if (is_kfunc_arg_constant(meta->btf, &args[i]) ||
-			    is_kfunc_arg_const_mem_size(meta->btf, &args[i])) {
-				ret = process_const_arg(env, reg, argno, meta);
-				if (ret < 0)
-					return ret;
-			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
-				meta->r0_rdonly = true;
-				is_ret_buf_sz = true;
-			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
-				is_ret_buf_sz = true;
-			}
-
-			if (is_ret_buf_sz) {
-				ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
-				if (ret < 0)
-					return ret;
-			}
-			continue;
-		}
-
-		if (!btf_type_is_ptr(t)) {
-			verbose(env, "Unrecognized %s type %s\n",
-				reg_arg_name(env, argno), btf_type_str(t));
-			return -EINVAL;
-		}
-
-		if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
+		if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 		    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
 				reg_arg_name(env, argno));
@@ -12124,11 +12122,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
-		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
-		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		if (btf_type_is_ptr(t)) {
+			ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+		}
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
-						     args, i, nargs, argno);
+		kf_arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12142,6 +12141,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		}
 
 		switch (base_type(kf_arg_type)) {
+		case KF_ARG_CONST:
+		case KF_ARG_CONST_MEM_SIZE:
+		case KF_ARG_MEM_SIZE:
+		case KF_ARG_ANYTHING:
+		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 		case KF_ARG_CONST_MAP_PTR:
@@ -12182,6 +12186,36 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			return ret;
 
 		switch (base_type(kf_arg_type)) {
+		case KF_ARG_CONST:
+		case KF_ARG_CONST_MEM_SIZE:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+
+			ret = process_const_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_MEM_SIZE:
+		case KF_ARG_ANYTHING:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			break;
+		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+
+			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size"))
+				meta->r0_rdonly = true;
+			ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
-- 
2.52.0

