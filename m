Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287A369D54
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570414; cv=none; b=VpYgdW7lIm31OFpOlR6nae1D0ue7I2iFsoZdmc1ticL2tEEWYWkwqaVxqf08icYJbsFeGBpuZ2qRbiC2iAnmr73QGrOiFjg2K86OiMrTmQcH01iTAjCzThK5eB8Sy51ovGXPKBlNlm4vrl5B4H2Qnt11loX9vP3EX+q2GbFjfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570414; c=relaxed/simple;
	bh=QKZz+2poAtFAqyjxvijulvObi0QXg5U2INmpIv5cLmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm97DqKdQ4sQxnKZzJqBUU++84OMLtIUZWkdnYEHCZEuRIHnorKU2Xkt6QdWu0x0D5tPTK6oR8Rar+ijNabIe2lMgEyI8p4XvKlBrf6XrRfRBAqikEA1lxb80ksNBSIS8Q2zcLxLu83vQLLZVVlhVhCAtXk8tMPd5MYLznWQ8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrI2uTtO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrI2uTtO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccf2360620so15201745ad.3
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570412; x=1786175212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7C5s3GJ8pSSJcJT3sAnI6k6cUjLYXMp5cmCkmHjEV8=;
        b=FrI2uTtO+7XNpYmKwDvVBvAk/6O1d4r4WT1Kz0dqFzEfV5YcM+YMowon4w1VVL/ghX
         Ia9BukJy2LWv/PGzK+Ffq/5r7zetYf54xJGj2yh0m7fKNMs0kiyof1KOtPwhyNOW+4qH
         Ei6f+8n2FYkipQ5waFMTa8ydxXvEjhhAOKtiSOzlsiTbavKOgqW2H+LmFuU4epTtZ5TP
         JH0dMCymdYmNtBAFXXpO23hh33fSRfpQ/CmUVflGH5CEnHvaGvnelTjcVglN91nDvS9a
         pfy/J8gKVb7kyjoNuJLIRqXhBa8H+05ZRwWmzQRwCtQiE4Nv1Z7hZPqkg7p76qgSVWdY
         Z9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570412; x=1786175212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7C5s3GJ8pSSJcJT3sAnI6k6cUjLYXMp5cmCkmHjEV8=;
        b=NaJMwVVGFPrZ9XunPucokmPAjkQXcIhlNvETXLeMoPa/UeJg0SQ0maYYPdkfGeulHa
         bz9AjuZusr0Iy4L1Mx23cPhhwnT4H5Tr1/qlp+msOnNb1scNdgMuJDMUS6VHsYIMzMLt
         yyeObjidSNaAi8ky2h0PYIoXDnAaBQHddDZxKo0UetPa+Rh+krW84PLQ3kMbIqeF9eNW
         EAKIfu9co16AEyzDBfRajuVNhU/e2x6GsrvyzLqOqsYye3wAS16t5+ZDRr3Ax1sGsB8X
         aqNsILM4JaLLFuGWiCFOL45oE4yEAD9S5y7RfhhGUHi5WJf3GOC4rY2/89WSWImSTsWS
         VT7Q==
X-Gm-Message-State: AOJu0Yz0jvGdMtUEgcTo3VccHlSa1a95bLXynD0qaHBpp1e4PfGvJq8Y
	pl/eccBqekzbgPbws+YQiXDcShVHkqcH/zAlCjeMhIVvje2Le4UbM+tm3J6xJw==
X-Gm-Gg: AR+sD1296oIll8v4QE2fA2JIUEkLz4bVTtlXsCZNJMF+yvVk+OBWYXbJ2FDcaLlYjFH
	LxJPj6otloCLCLIoVw/Qb1qO3m2GlyalhMjArMdj6NhCZgqu2dgoQNzsQgIr/T8qPQqWknvr8fd
	nEp6kI2/IAl3LjXwdrdwMUukyw71pZdzg4uktqsOHRG3HK7TVV38Cj82B17A96oVMzg1xkE7dBG
	jz9zmAa6Zy8SJB9K99dKjv2FWC6MXJIiu8Mp9fX5wbPXSQyC6SXDNeUJealEJQIwI0Jfd0VIDKe
	cObJI71BLYqlnMijsScpxIaSd8+yiolKyh/5wLy1ClpBToLmQCS/Fic6TNzbXqGFG8mRuHHn+ZE
	7rAf4A1RYNNLDp5OzpC1cAjXcRI/b8zbAAFIPK5HEJtK4B3cV18PEgkam/XOvRUxNO7gAQx476w
	zGElkwLoyolsaE716Eh9495iNHM5qlSgrSa2aPufYSCyhw4lA6+50=
X-Received: by 2002:a17:902:ecd2:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2d0523be26bmr24820555ad.29.1785570412181;
        Sat, 01 Aug 2026 00:46:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b77sm15070975ad.2.2026.08.01.00.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/18] bpf: Fold __szk const size handling into the scalar arg path
Date: Sat,  1 Aug 2026 00:46:25 -0700
Message-ID: <20260801074633.1595644-11-ameryhung@gmail.com>
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

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
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
index 5655e1ef8ba8..b8ce9b8c99e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6995,6 +6995,35 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
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
@@ -12054,24 +12083,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12393,7 +12409,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			struct bpf_reg_state *buff_reg = reg;
 			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
-			const struct btf_param *size_arg = &args[i + 1];
 			argno_t next_argno = argno_from_arg(i + 2);
 
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
@@ -12406,23 +12421,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

