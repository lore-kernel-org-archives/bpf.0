Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7841E7C18
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783303; cv=none; b=TU2oJycr7GeEP7tToKnmhq6jO5esTZPkOcbq3E7Pk7sShmtZT0CpjLdL+sdU+DPH/9uN8Y0ApktLSs4/ujlJHG5ocwSuDvdengLYuowDxNiZepEABcP4S6qVUsuDpK3RhAufPgOSh3Ob/fFET5vUDMIT0mcOOSNfw3Biwzcy8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783303; c=relaxed/simple;
	bh=9REh2nzvz17E28Wt97Mad3B7J8pIJhFepOFFfnzFiJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6VclzhxIiduKc7up1RtTBp7yihLhaH6dvHkvEMRwyPZGoGgBLQbx52rFe8yUN3hBaAezWtGnOl312oBaBPbwV/zp3kFiY9CmbRYxNa/3fGxR0R918OCcRL6UoQs7UgIfDOQSGzYO5vNd1l45qOSPGpsK+XfAqnHrEW80CEr9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzisTYNq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzisTYNq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so2581465ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783302; x=1785388102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owecq8A+RJg4Svp5MQYQMZiCbu50HF5x1R0rp7ZjxzY=;
        b=gzisTYNq4FRQ0M69T7EXT0qWL47FSIYytcQ2WcVfmpRARNehlNSoszIA96T1u5zExO
         VCEibLvvp6K7hilDXNv910qE0t2+MQyBnJHZ0UuGBbF1boS6kF4vqFURruhY599oyCTy
         5QQUPNN4bXp6vInHvlraMV1WjJ0IL+DZyUkxEzSVUas3kCz3j6QCOD5d1pHy1gh9go6A
         kpVLSjQXT5LWVZpCYFY+viyV7HNndUW6qmqj82ikUbUEDjqibu806Oo3S74pd2xXwmQT
         vjwxlMbUMkSR4E0FXQ/B2KAhK3xvpGm5n2AEu/YL5Q7vd0yvs0YO7FM8uAvqCa+QOQpK
         ecFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783302; x=1785388102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=owecq8A+RJg4Svp5MQYQMZiCbu50HF5x1R0rp7ZjxzY=;
        b=iLXMo2pmOSnmPThAz0QX9lxGpw/JkYRvt6Htl4imfX9BuRqZuQN+WPJjk50X6eEAFX
         NL09KLBzQqUDn99lSP6knDyLYEVF9KrTIqxc9BPgjIMAnOACcQi9BBGE2cuVkBcToXob
         KNRtNMv0hyzeBBuEKlmBkKwsr5LAEiBdO9386iuY8g25yrOZHlfNYTfc/bL8SkVlu37y
         +4VQYRr59vsHEuPT0SEt7AGymREzZRuHzs4+7TVjoYqmZ9XPY0YfedBtUtmCIgkmAJA1
         dpmBFwug08AlvK/e5YE1yVKf3fCdbQUlQIHQkhkWVRGVM3n5ds6RrFPojUT3ALbOPT48
         D3KA==
X-Gm-Message-State: AOJu0YwDhQov2y5T1H+pGorhNaf9YRfjU/DRWuCf9lBXqKHiyPrEJawk
	OMApDzZBHshyRSwTvwOxgACYB/BeoOTtnUkE6JYRxsHNTBVd8eSYhfUzkwN3xQ==
X-Gm-Gg: AR+sD12KCNB+TRImgl+PAFYyK97NIT+trhbWyEvST0+woM/rtN8De/dNz1MM/zFYV9r
	TX9h7YiFiHMeVVdZOVMnx3/TQSrh9JRMVmiXHWtfzLFNwzEJPjWwLm6Z4Ks2zijBeazU2LtOxli
	h5VJ+xPvmJ1r1jBNQQJp+9yqNDlJ/1Na/52VtcSIIA0HbWLaAaW9NF9YOhNg3Cv9e60FsUjLyIx
	sRjSB0FmlqS2rasLL5nxnH6ZaoGKS56O2TuRrfKamiU2hLPvMQOwqDvCsKxq54r/t2udpNimj8E
	TntZlUDBEkDoMlQNVDYUJoyXlwaUrhZw9FbrclULwAZi0TX7P64/i/UuLsAl2OpFaAcvRVQ6dqH
	ohfSIYWEBtzbGLDPpNnHeI06T6XNlPL9rj7QUca8/rLIXJClycxUHLPGrD2Eo674GDJIr
X-Received: by 2002:a17:903:37d0:b0:2cc:eb5d:2b1 with SMTP id d9443c01a7336-2cfa6bc0ed0mr17796685ad.15.1784783301818;
        Wed, 22 Jul 2026 22:08:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e621dsm26029135ad.48.2026.07.22.22.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:21 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/18] bpf: Fold __szk const size handling into the scalar arg path
Date: Wed, 22 Jul 2026 22:07:58 -0700
Message-ID: <20260723050806.1158442-11-ameryhung@gmail.com>
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
index 7698ead36778..83f7afb86dfe 100644
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
@@ -12070,24 +12099,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12408,7 +12424,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			struct bpf_reg_state *buff_reg = reg;
 			const struct btf_param *buff_arg = &args[i];
 			struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
-			const struct btf_param *size_arg = &args[i + 1];
 			argno_t next_argno = argno_from_arg(i + 2);
 
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
@@ -12421,23 +12436,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

