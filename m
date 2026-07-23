Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3513537FD
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783313; cv=none; b=eOm1JsZ9LZlsVk9ciMO573m48HFCc1RafgAvWDlTwt/sEDNxHbr3kzEmMAkQECSUPhbZk1Ds+zvJtiftgjnmwundqQF/aHx5BoCgDCMT3Kv5Pe7ttcb7y35kituYa5WEe1PRYbvjRkfuUmxS5mOUK8O5Ybi06fIoxEzYoZwEHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783313; c=relaxed/simple;
	bh=kXSGTUDT1+r6pNCX78jn7rE3sS+ku8qsVAfQrvGRxR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkwCgz+gBDolHp0d2CkoYHjMWshCS+0j4gnH+Cf1VMCeStQRxZd6J0qziK0uNZ65PNKClT6NohShEje55tlEEO0trnoldlO6e4WcqDLBVyUKZESZeLKbZJVwqXIM36JDHwRQBzeGe1L6nZ9XnjEgpQ90hK0c98xwFjjV3Na12q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=om6W710X; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om6W710X"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so2590845ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783311; x=1785388111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21w3UQnNJfiepNqV/Qz2T9uxv5XnNyBMRzZyKcKHb48=;
        b=om6W710XwpJ0hQ7Kban09Cd85kNiDngCE6dIWLerzZYLgB3Ytd2lXWSkTAmm9V8sxu
         2xPCgmIkBRlME6Q0w505xBzsZhWQ+ClnS/VwzAtpghGji+C0SOGDqsYiyEs7Ru9nIt7N
         8b8ZtR9wM0yQHv3RDkK+H6SDt55Uadr3W5qNRUCWmpbUxudciJCRULauKZw0rU8vGKVN
         9jo9QYDAb9KI2BaHuTnreqgo9uBozGGUjpdH9SgQtYULXXWuViXIg72t6tFv23ll2ka1
         MnR5RbIlr7sJP3vMtDHT+ZLsVL3TwahZpJMno48Xb/vG/c9H58dErl3q4lsWmsu3Ivwy
         r6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783311; x=1785388111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=21w3UQnNJfiepNqV/Qz2T9uxv5XnNyBMRzZyKcKHb48=;
        b=GMKiKHg6ZZi6z9Ch70gk7dOe6K/7xYK6qy9S9ls5ilZMOhYeu/Skx/qbZV1nqu28gb
         KVuBYqflNsAhlN30PVrpyMuxcT9D4hmFsUToM1G21NNGZZKFBFz2BYfHnTwxA7OeGK6Z
         4Z2FioP1Iw6p72yyQhHGHmMy3pIZ3N+6k/AqXBoRn8LC+iMeMcLZWb0bz1l06GHAhNW6
         sQhkzLE7lqf++9AiuHLWUqGOdLulTJbHwgQ9aPCCI9mIeFPq5vCPd0zeUkQrN7gAirWX
         Xiir/unFVKCRwWVFQSr24AjZYKw5F31op1QMM1C1+LWp1mzBGiwBjKqEdlRnT2cyQLVU
         /QBg==
X-Gm-Message-State: AOJu0Yxpvd8PVOL8MXyXphnttXamN5pRvmsltB7D4Hp6UGGR0kuHkP4X
	6YUMsaPNDp+jhmLPGXWPfk8pU1o1WSRV3VNLyIL8cFxQNo8h42DA2uw2bfrSzQ==
X-Gm-Gg: AR+sD1374RV2Uyuwovr1gWLIG2BcQtJSDwWIPcTndbvMo10veeWzGZ2tji/gon2tPXI
	KuN2rY2MGxri14jWUFIDI7lqFRgQmWZoOAHvBYOvBpdyjHGwFojNkz6dOf5RIwxBXfdrOVKMb8O
	aGaHM9RDHnUOfCDFjG8uuzq6tj1FHxkUDcuv/i1tEOba85Hu30fij8SjJNmGzWgxRSkx1PxnCwT
	ZrT28lM6W5gy3a6hvsPrYifZiBOPlNWj6SdzBfG7RbFqwqbAFGqYT+bLtjLPa0Y1EMKShPI5tTK
	b72Cakud+vaBWR1Cs1m8YzoxzBx/FD5aQrnANE0j7fppCZWJq4OJHujIIGzPgrnLtyav6ZCtdKJ
	mZQatZ3oSYZfTTwDLRXKge/zd3ZYJY0/RLOpHrP/cPqPih3oAO6BZauPZpH7Qya2Pymgu9AUEHR
	bqaqY=
X-Received: by 2002:a17:903:2284:b0:2cc:1452:a014 with SMTP id d9443c01a7336-2cfa6b7e283mr20078875ad.18.1784783311174;
        Wed, 22 Jul 2026 22:08:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3131b0sm25825865ad.62.2026.07.22.22.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 17/18] bpf: Classify scalar kfunc arguments from BTF
Date: Wed, 22 Jul 2026 22:08:05 -0700
Message-ID: <20260723050806.1158442-18-ameryhung@gmail.com>
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

Pointer kfunc arguments are classified into a kfunc_ptr_arg_type by
get_kfunc_ptr_arg_type() from the BTF alone, then validated against the
register state in check_kfunc_args(). Scalar arguments, in contrast,
were special-cased in a block before the switch: the SCALAR_VALUE
check, the __k constant / __sz mem-size handling, and the rdonly/rdwr
return-buffer sizing were all done inline.

Give scalars the same treatment. Add kfunc_ptr_arg_type values for the
scalar kinds -- KF_ARG_CONST_BTF_ID (__k), KF_ARG_CONST_MEM_SIZE and
KF_ARG_MEM_SIZE (__sz), KF_ARG_CONST_ALLOC_SIZE_OR_ZERO (rdonly/rdwr
buffer size), and KF_ARG_ANYTHING -- and classify them from the BTF
suffix/name in get_kfunc_arg_type() (renamed from
get_kfunc_ptr_arg_type() now that it handles all argument kinds).

The register-state validation for each scalar kind moves into its own
case in the check_kfunc_args() switch, alongside the pointer cases. The
pointer-only preparation (NULL check and ref_t/ref_tname resolution) is
now guarded by btf_type_is_ptr().

This keeps BTF-based classification separate from register validation
for every argument, paving the way for generating the kfunc argument
prototype at add-call time. No functional change intended.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 124 ++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 24858a38c34c..ba2608592bd5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11105,6 +11105,11 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 	KF_ARG_PTR_TO_TASK_WORK,
+	KF_ARG_CONST_BTF_ID,	       /* const scalar carrying a BTF type id */
+	KF_ARG_CONST_MEM_SIZE,	       /* const scalar sizing a preceding memory arg */
+	KF_ARG_CONST_ALLOC_SIZE_OR_ZERO, /* const scalar sizing a returned buffer */
+	KF_ARG_MEM_SIZE,	       /* scalar sizing a preceding memory arg */
+	KF_ARG_ANYTHING,	       /* unconstrained scalar */
 };
 
 enum special_kfunc_type {
@@ -11361,14 +11366,34 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 }
 
 static int
-get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-		       const struct btf_type *t, const struct btf_type *ref_t,
-		       const char *ref_tname, const struct btf_param *args,
-		       int arg, int nargs, argno_t argno)
+get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+		   const struct btf_type *t, const struct btf_type *ref_t,
+		   const char *ref_tname, const struct btf_param *args,
+		   int arg, int nargs, argno_t argno)
 {
 	bool arg_mem_size = false;
 	int arg_type;
 
+	/* Scalar arguments are classified from their BTF suffix/name alone. */
+	if (btf_type_is_scalar(t)) {
+		if (is_kfunc_arg_constant(meta->btf, &args[arg]))
+			return KF_ARG_CONST_BTF_ID;
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
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -12057,7 +12082,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
 		u32 ref_id, type_size;
-		bool is_ret_buf_sz = false;
 		int kf_arg_type;
 
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
@@ -12081,39 +12105,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
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
@@ -12130,11 +12122,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
+		kf_arg_type = get_kfunc_arg_type(env, meta, t, ref_t, ref_tname,
+						 args, i, nargs, argno);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12148,6 +12142,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		}
 
 		switch (base_type(kf_arg_type)) {
+		case KF_ARG_CONST_BTF_ID:
+		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
+		case KF_ARG_ANYTHING:
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 		case KF_ARG_CONST_MAP_PTR:
@@ -12157,6 +12154,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_RB_ROOT:
 		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
+		case KF_ARG_CONST_MEM_SIZE:
+		case KF_ARG_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
@@ -12188,6 +12187,34 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			return ret;
 
 		switch (base_type(kf_arg_type)) {
+		case KF_ARG_CONST_BTF_ID:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+
+			ret = process_const_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
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
+		case KF_ARG_ANYTHING:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+			break;
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
@@ -12435,6 +12462,19 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				}
 			}
 			break;
+		case KF_ARG_CONST_MEM_SIZE:
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
+				return -EINVAL;
+			}
+
+			ret = process_const_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
+
+			fallthrough;
+		case KF_ARG_MEM_SIZE:
+			break;
 		case KF_ARG_PTR_TO_CALLBACK:
 			if (reg->type != PTR_TO_FUNC) {
 				verbose(env, "%s expected pointer to func\n", reg_arg_name(env, argno));
-- 
2.52.0

