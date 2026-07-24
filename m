Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F745107A
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920107; cv=none; b=Uww54BJlFsWTLE8XROA4qXfzFojVxqQ9D8K0KhTjOA8YS9lGBV/XNE6GOiQL5OTyumzDnhifeCYqFjIDmypaO4oTp7+KhnfIT30rQTVjSiC1QyJ4MqYnxRISG5kljc2Ex3JvtpIsyySqQXlB6CJjQv/2VmYirOXOPazOHmCoqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920107; c=relaxed/simple;
	bh=vG8pHndEle0m4iTFL7D1kMovBFpgPJFgxSkveorZ+nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9FtL106GE5K59mUwd5Fd450NO1JyUqbz3r3TLnDWfY8mpQvgykf2kafLkUShzAfWfJRNpwMfVjxwZK+kufgaaVJEDzvi2TCmm1X7L7z/TTPZdeEO534qHSfASJuhgM7aKB24pKa9A27C06bSPchF68dJVD3Y9PkvgruEbce0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcHxtmBy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcHxtmBy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84867f07d63so1004558b3a.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920106; x=1785524906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=01Zo9Lwup184Ib1Y5zM+T8E/Ihy9RUwEMcH+b8Dn4gU=;
        b=gcHxtmByGvV0kVA9JwIrT2CRYLLNrKRJUhbPNBhfLoIo0yjPkj8z9VzB6p51fbbmWF
         Gv4FnpnHw+Ta5VB7c9oWzxiRAEVLDjlpRyLzz4ddkV0KP716yy3iESlW0R3qHmCQ2o61
         bzBuWQyOGlsNrf9A2lFlCWpV1ohPwIHg2PivN8eWwWVWSDPfMcmyTxAnKRxCvsXR02Hj
         0gdpwD3NfnTy8jZVLGOKk0wV/bMP4glC3ufBsOjWhOllG6HCtRjLSdKfh2HPPfS3uvxQ
         Lr+9ayRVXHMdr5hxzeyW0CeQ6Zx7Iic6hz7HKqiGTSzJgUSmQrhNfhDhDro17ASmCb7L
         VkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920106; x=1785524906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=01Zo9Lwup184Ib1Y5zM+T8E/Ihy9RUwEMcH+b8Dn4gU=;
        b=Ai36HvMI6s8Vk/gjNLQaKzXpE8cKrp+ZP9D8eAW6Npx6EgVep9G7su+0knkzslXJ3F
         HNasjd6lJeaMpnnLeA3rjNwMwUo0cykv+ZW8xu8Lo7xwn9gU2Co8xNyK5T9ie6b2DA78
         GfB1dkmMQcZT5+Fq8j41OjmUuIVEfi1FvwpaXp9zDt/WaDL9QWLM2p/xNQ+frtGjliYb
         qScA4VzBszMLKMIKWVoHhJcPNHnqOulPgnBIvNC2ncVle+UXV/u7JemI8aj/UZjvHV5L
         5jw6nq/YUaxIrgtNsK/j1WWa7j1cXW4wGuFKOc0AH9ReDPIr7cYRpoMk4fDYgvIxgszL
         8AcA==
X-Gm-Message-State: AOJu0Yxs8NgJ+5LPpWWBUx/O7WNIRBiN0RjjsOAFV9uYBNNh6i/OEl4F
	mk/cCTxS6A55Mi2k/4Tq6O0ysL9tMxt3C9yl5brKQaypsDYvxd2qe0ojkfmt4g==
X-Gm-Gg: AR+sD1059Doc6vPFcL0hC/SoaRabZ3djl9xbO5Gy8fgtpWPCM5HutFGZQUBusjhpCz6
	dxQTaBFkaqa1O2hWkETwIY3e4eLgsk/ePtYl5vn7MIN+C7i/LtxhVwzoOIPlDluJ6UWYO9GS7jX
	obSRP8Qm9Xo4OtAZzUWEVlC+pw4MVONwcK1F4ulYZyYjVKQyUzbAV/YqRNpmp1nCGvXKGE9DE5R
	bEH5ODzUxoURI33hf63uTU/kmPjU/XBMOnoS9vJVUEnjFftkFcMCoRm6+fucrXruy7nBQHo0gzO
	VGhljVsikSEhFAIjJRvFZB2bM8ZoQuipeQVdnC7H12Z9Ab+ZLz9tzftWKVJQWMagM1YfV43eORL
	FYEgh5fQQWEgQga3RIoIy1KdouMidUIRRFAyK3bIH8o+5m+vMBMfZJK6kKSNvQ69NmGM=
X-Received: by 2002:a05:6a00:4488:b0:848:2f7a:2e5c with SMTP id d2e1a72fcca58-84e2bbca99emr9085954b3a.75.1784920105527;
        Fri, 24 Jul 2026 12:08:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53470a92sm308250b3a.60.2026.07.24.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 10/18] bpf: Fold __szk const size handling into the scalar arg path
Date: Fri, 24 Jul 2026 12:08:04 -0700
Message-ID: <20260724190813.1458271-11-ameryhung@gmail.com>
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

To align helper and kfunc pointer to memory argument handling, move
kfunc constant memorry size argument handling to the kfunc scalar
section. In addition, factor out constant scalar argument handling.

The constant size argument (__szk) of a kfunc memory/size pair was
recorded into meta->arg_constant by a dedicated block in the
KF_ARG_PTR_TO_MEM_SIZE case, duplicating the "only one constant
argument" and "must be a known constant" checks already in the generic
scalar argument handling. That block also did an explicit i++ to skip
the size argument.

This also fixes a precision gap: the old dedicated block did not mark
the size register precise, relying on check_mem_size_reg() for that. But
check_mem_size_reg() is skipped when the buffer is a nullable arg passed
as NULL (e.g. bpf_dynptr_slice(_rdwr) with a NULL buffer), so in that
case the __szk value was recorded and used for regs[R0].mem_size without
marking it precise. Routing the size through the scalar path marks it
precise in all cases.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h | 11 +++---
 kernel/bpf/verifier.c        | 66 +++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bb0d43814e90..b54c1a5c9b11 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1479,6 +1479,12 @@ struct ret_mem_desc {
 	bool found;
 };
 
+/* A constant scalar argument; Populated by process_const_arg() */
+struct arg_constant_desc {
+	u64 value;
+	bool found;
+};
+
 struct bpf_call_arg_meta {
 	/* Common */
 	struct btf *btf;
@@ -1496,10 +1502,7 @@ struct bpf_call_arg_meta {
 	u32 kfunc_flags;
 	const struct btf_type *func_proto;
 	const char *func_name;
-	struct {
-		u64 value;
-		bool found;
-	} arg_constant;
+	struct arg_constant_desc arg_constant;
 
 	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ce34a9575f15..0f8d40308317 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7015,6 +7015,35 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 	return 0;
 }
 
+static int process_const_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			     argno_t argno, struct bpf_call_arg_meta *meta)
+{
+	int regno = reg_from_argno(argno);
+	int err;
+
+	if (meta->arg_constant.found) {
+		verifier_bug(env, "only one constant argument permitted");
+		return -EFAULT;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "%s must be a known constant\n", reg_arg_name(env, argno));
+		return -EINVAL;
+	}
+
+	if (regno >= 0)
+		err = mark_chain_precision(env, regno);
+	else
+		err = mark_stack_arg_precision(env, arg_idx_from_argno(argno));
+	if (err < 0)
+		return err;
+
+	meta->arg_constant.found = true;
+	meta->arg_constant.value = reg->var_off.value;
+
+	return 0;
+}
+
 enum {
 	PROCESS_SPIN_LOCK = (1 << 0),
 	PROCESS_RES_LOCK  = (1 << 1),
@@ -12064,24 +12093,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return -EINVAL;
 			}
 
-			if (is_kfunc_arg_constant(meta->btf, &args[i])) {
-				if (meta->arg_constant.found) {
-					verifier_bug(env, "only one constant argument permitted");
-					return -EFAULT;
-				}
-				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "%s must be a known constant\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-				if (regno >= 0)
-					ret = mark_chain_precision(env, regno);
-				else
-					ret = mark_stack_arg_precision(env, i);
+			if (is_kfunc_arg_constant(meta->btf, &args[i]) ||
+			    is_kfunc_arg_const_mem_size(meta->btf, &args[i], reg)) {
+				ret = process_const_arg(env, reg, argno, meta);
 				if (ret < 0)
 					return ret;
-				meta->arg_constant.found = true;
-				meta->arg_constant.value = reg->var_off.value;
 			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
 				meta->r0_rdonly = true;
 				is_ret_buf_sz = true;
@@ -12402,7 +12418,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			struct bpf_reg_state *buff_reg = reg;
 			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
-			const struct btf_param *size_arg = &args[i + 1];
 			argno_t next_argno = argno_from_arg(i + 2);
 
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
@@ -12415,23 +12430,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					return ret;
 				}
 			}
-
-			if (is_kfunc_arg_const_mem_size(meta->btf, size_arg, size_reg)) {
-				if (meta->arg_constant.found) {
-					verifier_bug(env, "only one constant argument permitted");
-					return -EFAULT;
-				}
-				if (!tnum_is_const(size_reg->var_off)) {
-					verbose(env, "%s must be a known constant\n",
-						reg_arg_name(env, next_argno));
-					return -EINVAL;
-				}
-				meta->arg_constant.found = true;
-				meta->arg_constant.value = size_reg->var_off.value;
-			}
-
-			/* Skip next '__sz' or '__szk' argument */
-			i++;
 			break;
 		}
 		case KF_ARG_PTR_TO_CALLBACK:
-- 
2.52.0

