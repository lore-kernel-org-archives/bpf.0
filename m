Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373E3AE713
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570418; cv=none; b=Qo54YXvDnaYhqUOImu1aUM9HQs39DpH+xOY0ZAs0o9NaykN3YTcMa65RmcGicZES2fkEQpe6Mc9yrFPTO77N829lmbvbistonCEm4iCwZgG8XAMTlOLV3r4OQccuSNBL6RgmtS4/p5qUT9hiCVscXXtQikEIxH4OpSPthELVM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570418; c=relaxed/simple;
	bh=I+4aziiMmmT+vHHKVw3H5VNjoQGFwDMJ37LWq/oFG18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMNJnQaVyq5kO25j6cgc2SFHOaD6bU+0kOoEtY0nU+ttJD/+HPYuug2tPmmWFQ9Kj77MkJFj/9q1olITXI9+w8oWgoZMMenuKrqsj91Dh5YiC4sa1HdlsYajALWiPqNSYq+7oyLRW/3tsGIFahNQBmKjf95CrpQnvUkIMdp3FTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKbqUEv+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKbqUEv+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace91f112so19372815ad.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570417; x=1786175217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYAWduL3/WZz9i7kCeRAm8wydp69pjvY7jV8I+vUuoc=;
        b=cKbqUEv+WGY4ozkkxeo8NgdTvU0Q0zwqrFcLxJ0Lduc7JTgESgyyW9ZQGz34faPy7r
         k5aFXiduUvrnU7w9t1U9e1WowtU1yyMflpg8SQx7e5RZnZvEYyxxVMDwwOPYlYj4J+VT
         eQAlCh7Oj8I2VzNs6xJkRcPd+ilzJTUhXkcVOTzS2aOfZ4VnKsxmM6+bd00y5+9gHIDX
         WgT/GdVA6SG1oZBu2SabxnDs5pWOkojMusAGdsgpWUxCfV7aUis2X5juEjQki5CI9/wD
         v8V3l4oGwmJ2IKSeUWVqbRlNFJ67P8+Y7wnxMLL+0wYfTnrX/b0p5D4L/ZoiAobI7RuW
         6nBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570417; x=1786175217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dYAWduL3/WZz9i7kCeRAm8wydp69pjvY7jV8I+vUuoc=;
        b=T6fey68ZFQusEcbWoFryn4TQP2nGiW1ewiXBAS+Z6rTfxlUaY3YsBqs5tl1ADKzzSO
         FsCH6fBGxpkK0R1IIsAQAwVTHF4cEu390j3+Tp8rTpuo5Fzz6ScG8EWTmAApp4lYbvRd
         qwY9qTGPAjyecLAaCvtwK8WFRulS7bGesBo9aQpKU9/+T/TYxNou1N1nnw+a1fUGOqFF
         BMS5LntotTBA9woHfs9Fi5Dljw7QOcMCRuzHOLQZFzku4PoWpxOSmLqge+vU8M8rqTBv
         JL3gXVwEFSHY5ripGBu3Mn80ywtLf/pfZ0yuvxgdZC1bgLJkW7Qq9P8w3mI8pJSoaO2j
         Oi5Q==
X-Gm-Message-State: AOJu0YynxGY3WgVGf9M+9W5UZQ/KMihRkg/MHVgjKhEjMdl+ZgifZfQM
	tsxCwjYq9HfH3j7OyEPJlplT10sFchLckPsa9NNqZroU9kwgtwChYv29Ovsheg==
X-Gm-Gg: AR+sD11B7THn+Is/QCCC4zZnmUfG1B/glJ59Yt6dqb76NwztPo4lLCbSijxD6pAlMrX
	1lsenxoF/4fZuvRdoHZJkI4IU6MQ/JFGu/g6nB3gsIGkSFJP5LTd6ZxpzY63eDvtXvVlmFpUupO
	BRaCMDvJ8WTZpw6RjHmi/kZe/jVl7M4zTNtz6qh1CjLuf7M3zj0R1fqGgR5/wFGQBnqFZe9xYa6
	j8yeG7qrLOgbwjaeO5gvt7NWj832RvnzAfx/8xyt06S6dp8KGZerdzwye0hf3mEr2A0o2SuN8tN
	YoWIY52i2sRySAy+zP0AJYoeGqdKCOxGpcuq2EFNIIlPW5urG197k80LNeW+6B287DdViLtB8Or
	71ERxXTLHjZ9yiHa+eIOALEvaox1Y4wP4qbWZOPC33g/YCmVXLdpdBZaIvkiHsDkHFrScvy+n46
	1gv7KgbuZqiXzY3/jkS+BV/4byQ7X+eVYSuIVWwsSiFfnHyclgKlk=
X-Received: by 2002:a17:903:8c7:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2d05247217bmr27174665ad.43.1785570416701;
        Sat, 01 Aug 2026 00:46:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb486sm15075455ad.53.2026.08.01.00.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 13/18] bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
Date: Sat,  1 Aug 2026 00:46:28 -0700
Message-ID: <20260801074633.1595644-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
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

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 789d4e729457..7507576c7025 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11072,7 +11072,6 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
-	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_CONST_MAP_PTR,
 	KF_ARG_PTR_TO_TIMER,
@@ -11349,11 +11348,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
@@ -11362,10 +11356,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
 		return KF_ARG_PTR_TO_CTX;
 
-	if (is_kfunc_arg_nullable(meta->btf, &args[arg]) && bpf_register_is_null(reg) &&
-	    !arg_mem_size)
-		return KF_ARG_PTR_TO_NULL;
-
 	if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
 
@@ -11427,6 +11417,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
@@ -12127,6 +12122,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
+		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
+			continue;
+
 		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
@@ -12139,8 +12137,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		}
 
 		switch (kf_arg_type) {
-		case KF_ARG_PTR_TO_NULL:
-			continue;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
@@ -12405,19 +12401,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

