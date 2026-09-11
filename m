Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEC46EC70
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164281; cv=none; b=YBubfPsxGA9kzZzIElJKVslb8NItTPQS8aZRzca/MzEs/jaOFhWFPz9f97xjjlPvQyZB8cO+Ig5w/2/NTK+q4XWXkn7+tBcx65sjK3Fu12hRmP5pgyaZuvefdtPuKDTcM/2vBSnmtc02BldMWgsH9J+WdACdG3lxbSonSgx2P9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164281; c=relaxed/simple;
	bh=yoKA+h9sQhqaQtH+XFNeHn+0On/nK26dCcopz0iFbKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGKq9xqKYzY+zFQOMbPQnzHIQxZL3trvmTW9A1Tg5lL7EvUGJubA/ubtlv7n4SaotwV0zDDfV8i2bj0X9ic/AAo3rNQvyNHkIFkxfb5dJaNqXm2DcTfcCPPGnH0XpxLB1CtBovqpeRM0UWqpKND0lQ3PJd71IV66JKhP7666qiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2wfY7s+; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2wfY7s+"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f57db8b5a4so1293212a34.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164275; x=1789769075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JVeFTogyFVQGfnazLRMq7jqu8ctF6rXu26Goc7QmoE=;
        b=X2wfY7s+9PByenb07q+u1tnQff33ZV8mZMML6eHwgKXOFYr59cwZIhL+zTLUA7eACN
         C1R/M6u9S9ywuUlbj4z2Vu4ev+0MuhzouLlJn+e66XhlBNc4mamIlUMUfQibA0iUW9qL
         +IloyRaULJT0uf8m/TuZoYIzuYv79w1UpK6dSMDv90r31F3A09xAKmNkXGilJSsJPlWk
         2nyeOd2AGQ2DCPR7h9XHqzmhTKCh5dNHlDH6O779QUOV4iPZZdzCzS8h2xD4xBPzS5cz
         0ITY4+k5hMpb47ZHnnYVa+p7MYRCAx5kuFhME42+lsGAHhG6F92jb2C4XEwsMIQ1f664
         kZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164275; x=1789769075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JVeFTogyFVQGfnazLRMq7jqu8ctF6rXu26Goc7QmoE=;
        b=NG2BU5d8LiZkpWZlCgdaHQSOsbCxP84En50yPIseY+tLnvacYnt3XNCxFA6mtV++al
         HrJKk1ygkWpgsZx2juQQ+/5U0MZKEt/La2wRUcqdYVTNh0tXIPBaW67XkAqKkomtR6c7
         jNJA6CjW2vaovTDxkzi3+YxDfu6qt6vVkQSISvYPYeFypp2L0fI1ZFSW22EZBvoIAmbv
         94x+C8U2/8tQFnylsxhqr5V/9G6/R9ZjGIIweyCOZE7dHc052Nww/2BgnFUONJHnv2R0
         Hz2U2HlLYDVW3FX82hYlni3ffElr0h2QCIgmN2kNr7c5uVQ2JV+Uj+R9gnS6hr9yo7+N
         Gf1w==
X-Gm-Message-State: AFuF++m0HAqhbM+j/V05p06nD05qaF1H7kaH1AjafLA7+l731lnyhcZV
	TdZ6BgNKGfODrjj2sXwW5RttzmIchuw+gudDN/LqBxz9gEZq8Ra/yl0uAW3Ztw==
X-Gm-Gg: AYBFou3feaMrBl0DBjyueQ2Lbh3XsKUH2NtqxE9/ViTXl285j/IIQfNKIYkIcVLtEbq
	SxM1mtv5vO7d1h0isS0+XJXsfH4o6s9qo+hOVggtH/+jXkeQviu2quSYjuW7UwIPnE5yfY3Yrn/
	V7XsxVuSyCpCxWIdk0GJitLfuOEp7mmu5vLtvdNkziCI0Ul1sZXmff9Z0WIZBYGINhkmE8CHSPQ
	r5+RYjY4fdldSwyfNyKuTuO2xx72x4F+kp9KasoyXPBKGa/DzeqB52BDUgDUhCsTtCUD9jHPjXe
	OT5LD4HhcRErcB/EneNxxcvrMCMnGjs1OiF8woq9BhcEZJFcGRg2DntVZQQNqBNp0HzDFiEI1pg
	cCu2EOS3pPewtki8Y6j55/lz+jeV3tGxYbAhDoNnhuZeOQbkWsl410jLFOHDYZvONgi7xXqSBxq
	CLjo8plEleu/oOCEif2LhTJpV/Eev7B0g16/zLgQtGimsM2L4/iQh5lutZ8fOS/g==
X-Received: by 2002:a05:6830:83b5:b0:7fa:ac4f:77a with SMTP id 46e09a7af769-803ffa99b83mr5386628a34.25.1789164275054;
        Fri, 11 Sep 2026 15:04:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d1875csm3668736a34.22.2026.09.11.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:34 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 12/23] bpf: Resolve BTF ID of ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
Date: Fri, 11 Sep 2026 15:04:04 -0700
Message-ID: <20260911220415.1396439-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() walks the kfunc's BTF on every verification of a call
to work out which BTF ID an ARG_PTR_TO_BTF_ID argument expects. Helpers
name theirs in bpf_func_proto::arg_btf_id[], as a pointer to a BTF ID
that resolve_btfids fills in at build time.

The ID of a kfunc argument's referent is already stored in the
immutable BTF records that describe its pointer and modifier chain. Make
arg_btf_id[] point to the BTF field containing the resolved ID. A __map
argument instead uses the existing vmlinux BTF ID pointer. Produce this
metadata alongside the argument classification in get_kfunc_arg_type().

Declare the argument BTF ID pointers const, since the verifier only
reads through them. The BTF object owns their storage and remains
alive while the generated prototype is used, so the pointers remain
valid when the kfunc descriptor array is reallocated or sorted.

Both helper and kfunc callers can now read the expected BTF ID through
the same bpf_func_proto field, which lets check_func_arg() take over
the ARG_PTR_TO_BTF_ID case.

arg_btf_id[] shares a union with arg_size[], so an argument cannot
store both. The scalar-struct memory fallback keeps resolving its byte
size at verification time, as it does today.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   | 12 ++++++------
 kernel/bpf/verifier.c | 42 ++++++++++++++++++++++++++++++------------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aa4d3bb5e8cc..d0066d744ceb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1021,13 +1021,13 @@ struct bpf_func_proto {
 	};
 	union {
 		struct {
-			u32 *arg1_btf_id;
-			u32 *arg2_btf_id;
-			u32 *arg3_btf_id;
-			u32 *arg4_btf_id;
-			u32 *arg5_btf_id;
+			const u32 *arg1_btf_id;
+			const u32 *arg2_btf_id;
+			const u32 *arg3_btf_id;
+			const u32 *arg4_btf_id;
+			const u32 *arg5_btf_id;
 		};
-		u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
+		const u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
 		struct {
 			size_t arg1_size;
 			size_t arg2_size;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39f7f633b4d6..0547fbeeebbe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8839,7 +8839,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	int regno = reg_from_argno(argno);
 	enum bpf_reg_type type = reg->type;
-	u32 *arg_btf_id = NULL;
+	const u32 *arg_btf_id = NULL;
 	u32 key_size;
 	int err = 0;
 
@@ -12179,13 +12179,18 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 
 static int
 get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-		   const struct btf_param *args, int arg, int nargs)
+		   const struct btf_param *args, int arg, int nargs,
+		   struct bpf_func_proto *proto)
 {
 	const struct btf_type *t, *ref_t = NULL;
+	const u32 *ref_id_ptr = NULL;
 	argno_t argno = argno_from_arg(arg + 1);
 	const char *ref_tname = NULL;
+	u32 ref_id;
 	int arg_type;
 
+	proto->arg_btf_id[arg] = NULL;
+
 	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
 		return ARG_PTR_TO_PROG_AUX;
 
@@ -12213,7 +12218,11 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			reg_arg_name(env, argno), btf_type_str(t));
 		return -EINVAL;
 	}
-	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
+	/* Keep a pointer to the BTF field containing the resolved referent ID. */
+	ref_id_ptr = &t->type;
+	ref_t = btf_type_skip_modifiers(meta->btf, *ref_id_ptr, &ref_id);
+	while (*ref_id_ptr != ref_id)
+		ref_id_ptr = &btf_type_by_id(meta->btf, *ref_id_ptr)->type;
 	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -12336,13 +12345,20 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_release(meta) && arg == 0)
 		arg_type |= OBJ_RELEASE;
 
-	/*
-	 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
-	 * otherwise demand a referenced or trusted one. Other argument kinds
-	 * have their own provenance requirements and must not inherit MEM_RCU.
-	 */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID && is_kfunc_rcu(meta))
-		arg_type |= MEM_RCU;
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
+		if (is_kfunc_arg_map(meta->btf, &args[arg]))
+			proto->arg_btf_id[arg] = reg2btf_ids[CONST_PTR_TO_MAP];
+		else
+			proto->arg_btf_id[arg] = ref_id_ptr;
+
+		/*
+		 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
+		 * otherwise demand a referenced or trusted one. Other argument kinds
+		 * have their own provenance requirements and must not inherit MEM_RCU.
+		 */
+		if (is_kfunc_rcu(meta))
+			arg_type |= MEM_RCU;
+	}
 
 	return arg_type;
 }
@@ -12368,7 +12384,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 	}
 
 	for (i = 0; i < nargs; i++) {
-		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
+		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs, proto);
 		if (arg_type < 0)
 			return arg_type;
 
@@ -13024,8 +13040,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			continue;
 		}
 
+		if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+			ref_id = *meta->fn->arg_btf_id[i];
+
 		if (is_kfunc_arg_map(btf, &args[i])) {
-			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
 			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
-- 
2.52.0

