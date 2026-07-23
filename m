Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3E2749DF
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783306; cv=none; b=erkgOcRezQCIESRo/y9/4BC4enkPpVAvyfstz7Fhgbp+6nty9U7pBS17IPI3ONAVfGbsnvRgrtJlf8p/WRx6dL5y85GMh4b6iY6L3mIQUmgjs9+GSLseiJv5oHnDPdLH6Md376IafTfy7h7SDP8F3yLqdD49eiazmqDyJiRmT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783306; c=relaxed/simple;
	bh=zP51odzI09XgNdg25AICZO2Q2cej1vTLNbJ4rz223Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6phYBg45Qvq6or7Nl8iXG/PEll0x+rjEoNWPEClhETQWB89LPN0Tp9Jyyd80pWHvddj9eeKZsHp3bflQ5aBFc1VBIeLvJL0d3FNSZPzLPrDYE6IPedrUL54E1Xnhy8Hrbq5HUJg3X+p7pAJ7giogzxR8G3MXTG0BBTi2x2Q2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTOko8Dx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTOko8Dx"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so227260a91.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783304; x=1785388104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCkzTpTAwOn4xfxhJMfeeAIjIM3dfTRfE7oHxZ65vU4=;
        b=pTOko8DxllUEwHe/c7JDMGSFUp6aeQ8c6UC/K870yh7SyiCOYO1lvUqMi4IVVxRdEw
         MyiQL7HwIQT0ZTf+WZuPkxQPgRgZnuDpBiWxdiXt0IGvDmyEKXaZBu5A9CkgdJ3eUVnV
         eP8nw+hmUn5cV9EFRAd21k7O4lSeZmGNiL01WOtvT/E7VJnhv9fs7qcsklVb9RJ74hlC
         zXYSY8ep7/wpU8GC5uPaGnq9X3Wb225d5rcJ4YiOZ9E71hWCkL5QgSCtb5F4C5JcANt0
         ClkUULzZgRH5HMgJKsg6obJ6iM8JPIpcdiLwxe+8PQ1mwdVloMXtcx1AhCfVInbz4iIs
         /MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783304; x=1785388104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCkzTpTAwOn4xfxhJMfeeAIjIM3dfTRfE7oHxZ65vU4=;
        b=DbNJFNfKhXI0EOW8VUARuaJxikF0dO8W14J3qssUuk5A/+sN3GDvc7q7NWnsg302KK
         wP+aEezJHXXIYbptOcYxAQAFP+aBrcsuLK/LwamKvuDnd7ZMANddc6gJ+WRpaGjUr7PM
         1lP1Tym3P1JTKyaSgM+AxQu8Df7nriKw5X74rhCyhYCE1+4ZOoc5wDJ+WHo6D1V/KIDZ
         WG/LxR7Huz/V3O4AMpEUm66lDMNAqRyuLM1QLtYmJDqW+gv/Zpovr70VweMIyyC7gY+1
         5a480cdNgbuQaYvrNRdxe68d5IXB8oClNk2AFqb8z8C5Ln4fT8J+eRRAC4TKDDN0KJ4B
         82WA==
X-Gm-Message-State: AOJu0YwNpR5I6HYQCLHBgVkWlZ1N895JXzzjdwRRPYisNz7adezWFZBf
	KNkkxDnipU3FY6sCdRkouRFXd2Vf6wg/DNBm7jWE4J4SUpqcy02FQWO3SEszvw==
X-Gm-Gg: AR+sD1118E/pRnOTXZh586Pts3ah+mVX6gamTaDwgiQ7Qypxoplza1uEdhjEq0YiU0f
	mgXD3JesRVV6DC85Q0XWo4HfF5mrlZ2OOVk2e4Oh+/JR89MHn3ZM60s45cRsHIzSwPAeGcj0ih9
	vf2oRzZT/f5sYqJ5YSJw7AJPL7lcos51J0wIjtoA1/RumpyjnIagvX/QdztP1QwiDzQpqGFgmWW
	fPqUNRcsEkKU1dS5yA5oRKPwJJkKjF1c6U73lPZB29QwjUQh3YFO6b6eM/Ff3HZJBfGXW/5IapN
	lIhSwSh/9p8kcCkTNXF0I7eYPpsbbQfTYQ0rveGFq0Jk+Ngl3sz3hUDQ3LGEnZrvTMsJDbLkShJ
	pz1FTIIAsnlWGbsZ/hoc9heAo/4aooqbYHQ7+DB09JldxkAHbn2T1PlAURyhe/1P+wb/J
X-Received: by 2002:a17:90b:2b47:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-38ec6453e68mr1558640a91.2.1784783304558;
        Wed, 22 Jul 2026 22:08:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaac5788sm301562a91.12.2026.07.22.22.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:23 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/18] bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
Date: Wed, 22 Jul 2026 22:08:00 -0700
Message-ID: <20260723050806.1158442-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
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
index d77b590e0469..438c27d9b39e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11088,7 +11088,6 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
-	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_CONST_MAP_PTR,
 	KF_ARG_PTR_TO_TIMER,
@@ -11365,11 +11364,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
@@ -11378,10 +11372,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
 		return KF_ARG_PTR_TO_CTX;
 
-	if (is_kfunc_arg_nullable(meta->btf, &args[arg]) && bpf_register_is_null(reg) &&
-	    !arg_mem_size)
-		return KF_ARG_PTR_TO_NULL;
-
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
 
@@ -11443,6 +11433,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
@@ -12143,6 +12138,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
+		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
+			continue;
+
 		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
@@ -12155,8 +12153,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		}
 
 		switch (kf_arg_type) {
-		case KF_ARG_PTR_TO_NULL:
-			continue;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
@@ -12420,19 +12416,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

