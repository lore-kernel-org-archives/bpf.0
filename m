Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A848456E15
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920109; cv=none; b=ULSzHxho7ihhEawjBqxNMn6m98vRJVpqhn35R877FDg2xuEr/d1EaGeLp7mzHIEnpZvabHqOov0WaG2qPk14gO7Nj7c5gLfXUe/HjUSn3fdHR64E5VotHWcZ/SKaBTTDkOo7a/dCDtsO7RGib7TL2tzX/h8GTSRO3NidwQUEeoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920109; c=relaxed/simple;
	bh=Moa8gdkUwZ0ICeMVeIHb4zaOwpMWGqlRgZ4U3g4tko4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWhtXQi9S90ISPrUuA4OuFE/G6Rpl3DHdQ650SwdsuS2TyrS28UYkDVdfsO64tzg4BI4DqszK8vSkiompMKtZeCmPITptCKDhKvqUtHf9ryTwzfDm4zFU3fIDs4scfjU8xLGJv3m0Jflso7Z4Gg+1Mt5fjgJWpA9Xx0mWDV7Pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOFVsVQT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOFVsVQT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so9728085ad.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920107; x=1785524907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHaJ7xGj2u/0UzZR+fvaLLCIibAsdfjMGxDxeJtqO7s=;
        b=QOFVsVQTzmOUOdf9t55G1IPCsl3jTErFsAI2HzuwEy0rEa3xefhHlXAQkMialSOKmM
         884saXEVr4SBqqQXAOt8l1MFrafsr75HxeT3Y7Bi/Epxr99HExaDpBiIvCna2J9UjfRN
         GijLW0Dejhz2qu5r0lFVlz02VWWrIUXBmjGIBJn5S/bVeKjM4O5eP2ZeZ8OKmqS2LIVb
         iB2O3GTsYcnLlnl6zrRHpQ4tXDwcszKRE/LaXfPiYpEku3TcPruQFLv2LPu0IoZmPiiy
         exw8um7xUlZt6a4Djb0ZQXN6TMJZhuJsE6wQgQw0/s2GSHz35S3wcryUqDZkNJ7GqxRv
         yTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920107; x=1785524907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bHaJ7xGj2u/0UzZR+fvaLLCIibAsdfjMGxDxeJtqO7s=;
        b=K/W3+d7KF4gVKiQmnlB+jxTCYwtT5lWxmYn/AGipGBwCOrVH+GDTMrvF4WtjdPkdaq
         dzK3eeKhkxmUJ9kS7bXjPh8hULuUJxSfL6g76wttMC1Dq4T/1lCxU59piA9IVgeXsQmT
         6th9VGgh0JTkuPmXFzgsr5R73i5CL+dOogSZa0r5rWMvFNo2J6LgXTg5M+hP79f6M6w2
         28p6sUhsmPtv1UletVWqLlPICvu1Etc/2PKd0X9sAKQOXcfzLVF4Ox0G2v+RQC/4n97t
         /1G8kyVFlRf/hvE+IpveNYgxOB5/aDPGcENiSHbfm39sK4iRpHqwvGa3sunb+fSmob7z
         mHuA==
X-Gm-Message-State: AOJu0YzBA3KnqR4sXg7oqGrkSXFGy7oFy6uJC3cmWn4I4zh5NDWLI2iu
	fV5+ROkHxbil0pr86+ZLxhx5wOKmaGcV4bk/03esoepeHy+GjnIfJ2EKmtIy4A==
X-Gm-Gg: AR+sD10XmpyN4Ep4rp2XWcI4giyfAbvfeG3vQxnOqmSjzn9JsawFBLShs2+Z8rLzkeC
	7L+jKgt6Lth0ewJsj5A1vNLwOeNoAqzo+nJ+pWAej1w89z6ox9Lk2h1mF3vUbEu9QuCSnfQYTYI
	UxbBQUTUktmyTJaAjAo4Fjtf1WkX2YBxScalJjWj3fp60o0vE3cazjORljFy2B8ECTrtsZV7Zkl
	6bdxud2qCpmJfOqFCFZdrZS3HCAEjsByJ00asxbuQzcIiqOy6j3UDj/z3aK5BOUhefCstnPIwsY
	NC9m4s5X0LTUpo0670k0KeJPYcQ/DXdQWRRARpf0NGfnq6KzfTflVmSBcW+4Hg9Y61svSK9qiE/
	zEurwU3d6Zy5Wkb7HTY4FVsI4oZgMa62yxSyFndj+8UcSyKTkgwH5o5+xbt3RbCbxFQI=
X-Received: by 2002:a17:902:e945:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2cfa6bc4699mr90661135ad.17.1784920107512;
        Fri, 24 Jul 2026 12:08:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5f17sm58648195ad.41.2026.07.24.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:27 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 12/18] bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
Date: Fri, 24 Jul 2026 12:08:06 -0700
Message-ID: <20260724190813.1458271-13-ameryhung@gmail.com>
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

get_kfunc_ptr_arg_type() returned KF_ARG_PTR_TO_NULL when a nullable
pointer argument was passed a NULL register. This folded a register-state
decision (bpf_register_is_null()) into what is otherwise BTF-based
argument classification, and it short-circuited before the BTF_ID/MEM
resolution.

Drop KF_ARG_PTR_TO_NULL and handle the NULL case in check_kfunc_args()
instead: a nullable argument that is actually NULL is skipped. Note that
it is okay to skip even when it is a mem+size pair because the size
argument check has been moved to the scalar section. The skip is done
before get_kfunc_ptr_arg_type() so that a NULL passed to a nullable
non-scalar-struct argument is not newly rejected by the BTF_ID/MEM
resolution.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6b373630ca9..64668e7d184a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11082,7 +11082,6 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
-	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_CONST_MAP_PTR,
 	KF_ARG_PTR_TO_TIMER,
@@ -11359,11 +11358,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
-	if (arg + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
-		arg_mem_size = true;
-
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -11372,10 +11366,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
 		return KF_ARG_PTR_TO_CTX;
 
-	if (is_kfunc_arg_nullable(meta->btf, &args[arg]) && bpf_register_is_null(reg) &&
-	    !arg_mem_size)
-		return KF_ARG_PTR_TO_NULL;
-
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
 
@@ -11437,6 +11427,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_CALLBACK;
 
+	if (arg + 1 < nargs &&
+	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
+		arg_mem_size = true;
+
 	/* This is the catch all argument type of register types supported by
 	 * check_helper_mem_access. However, we only allow when argument type is
 	 * pointer to scalar, or struct composed (recursively) of scalars. When
@@ -12137,6 +12132,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
+		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
+			continue;
+
 		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
@@ -12149,8 +12147,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		}
 
 		switch (kf_arg_type) {
-		case KF_ARG_PTR_TO_NULL:
-			continue;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
@@ -12414,19 +12410,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		{
 			struct bpf_reg_state *buff_reg = reg;
-			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
 			argno_t next_argno = argno_from_arg(i + 2);
 
-			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
-				ret = check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno,
-							 BPF_READ | BPF_WRITE, true, meta);
-				if (ret < 0) {
-					verbose(env, "%s and ", reg_arg_name(env, argno));
-					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-						reg_arg_name(env, next_argno));
-					return ret;
-				}
+			ret = check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno,
+						 BPF_READ | BPF_WRITE, true, meta);
+			if (ret < 0) {
+				verbose(env, "%s and ", reg_arg_name(env, argno));
+				verbose(env, "%s memory, len pair leads to invalid memory access\n",
+					reg_arg_name(env, next_argno));
+				return ret;
 			}
 			break;
 		}
-- 
2.52.0

