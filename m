Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0E33B966
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783307; cv=none; b=E5On4Z1w5sKJZV8JSBVW+aUCw8OiMzPw81TgT96q9nbjzR6X7gGFkF+uLQOrYztCksMyP8u4ItfoY4WcJD7SPPYBn34yWyCvzwdndSuAbIK8hZxiM3U+JkHSCvfjeXg7vTVJqmfiVjta9DsnoMXblam7UCc0HZljOMBFd/2Qyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783307; c=relaxed/simple;
	bh=dGfiXfiqljEPKEL9hVZam1pgUocal5iMaUZmkPX/lPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAo3lyU0pWn3m8/E4DVJY+DZ1Qs4viqQlwzT1Wi2mJKTnw+uvQlaFGbAaccqn10My8ipgd5y3etUPeWCt3A2QpqPKI4Udmm2+kU+aYhLOyLKEgTge4+6AnaO1wR0LcvstC3a4GYLl56o4fOE1HzMTv/KSZV0rF/Cj0cO5qN60jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amMIKoV+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amMIKoV+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so61669b3a.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783306; x=1785388106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CxY65+6fJvdsCAEaBA4BIPCUTb3SZtYq6P4UY2kpVU=;
        b=amMIKoV+U/CUU2vtZjwB2u4rFAqimEQAzOy8aGdZeeolk1puSgUPCnjLitzwB4hbey
         1Lo64LrWdMqxbZTU2DmLFwADpe2pwMrIlIe9wUnRtyq/igKflZ1lPQYWg31ETMi3gWcZ
         /ZH4HQ5yTHZyQOfjbAfnz72kb3jBWO9LkFmMsvfQ7rRd4Sz5BrI1BVatKCFCxmAdohti
         Zo1q8P0GCTedNnvH4JlTlHqloBSBNjB3VObeHTIsm3xqqUD7lOPAdknSmVEO5jaT8T9E
         X1LrErcHsWvauKm67QwZK4Dbt/1IgW4HFEFghOdriVqIQIaezSNGmbNL//NIOjvD5HEb
         uiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783306; x=1785388106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CxY65+6fJvdsCAEaBA4BIPCUTb3SZtYq6P4UY2kpVU=;
        b=YgkyJbMKM8e7f0DbzwBpv0mqFCjOLmpQmM5X1ZOJ6pdC3On0Wc+mdO4Vyr3SYUituZ
         r5a4VO+w+3FHDbUXqWSyCueKx/yOJB+V8jVqQ00ZdVzIT8f45y9ZhAfhNd378UoYY+gV
         udvgdg6rr4xO7uU3pIY+J52EdNDGk8pDX6HlaO+LYdh1sXIGYyLIU0F7bvXp+vex/CBc
         mIa6Xbj3tBDhmlyYDQPaG33O+kV4ndV0SE+/TTXQOwexKG/H1JVx5Sk+FJhyWOHLPVlA
         FLwajidg45IhCkUj75LsAr6AZhgDRGSnVRckTQZN73SqgXk/p3T3JeHm5gBDbbERwWaM
         N2sA==
X-Gm-Message-State: AOJu0YyLPjDgKKsTJzOY5OW0gon4/0ngZvQ0Rulc2d6eGlkG8r1TyrYZ
	a8aLhjPaQ2QCAfUfD83hrtuYTrOnYT/Sl+tkNR72RpE87rN79UX6pYPXr+T+Cg==
X-Gm-Gg: AR+sD12USce64zeNdy9Jm/5Mbr9T2MnZLpXRatU89+nbWEk1rChqBapZufQsHdC6w81
	U+oHnjpkanZllHSMj8uwgLzg+Vym8loEzm+YP6qgvoryGkPjhTii2yh03Efw+Zd4wwU9L5i3+bD
	a6xirbNpXvMvYetbaajg/s3zIMo8doeKWbxf6+ZhWqzzGNVs3u4DJDHwLKafpmTTRrK14z0p5y3
	gFcJfMnoJmrsHDtJOgREE/JfJ2elZiTR+skgiPQ1Cps9RaFmT2Kz/jD8owzRbjhGRTdHFus24o0
	qjqoUIfkPcfpnPGMQ1axpBqTWQxFDQZOsuXySDRY9syl1m/OFZ4WLLF34oarNjb75hRxRcLNs4H
	VYJvPQIjQUoqM0XY0SZipIahqQidUP6xTZzEBfhJGEdT9N0Mw3/m+oKi7Ila7BEmRJX6C
X-Received: by 2002:a05:6a00:2448:b0:848:4ee6:4d0 with SMTP id d2e1a72fcca58-84e2e92a630mr1330902b3a.23.1784783305973;
        Wed, 22 Jul 2026 22:08:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0d6498sm2151161a12.6.2026.07.22.22.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/18] bpf: Distinguish fixed- and variable-size kfunc mem args with MEM_FIXED_SIZE
Date: Wed, 22 Jul 2026 22:08:01 -0700
Message-ID: <20260723050806.1158442-14-ameryhung@gmail.com>
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

A kfunc memory-pointer argument comes in two flavors: a fixed-size buffer
whose access size is derived from the pointed-to BTF type, and a
variable-size buffer paired with a following __sz/__szk size argument.
Both were represented by separate kfunc_ptr_arg_type values
(KF_ARG_PTR_TO_MEM vs KF_ARG_PTR_TO_MEM_SIZE) with the pointer classified
as the latter when a size argument followed.

Mirror how helpers describe the same distinction: classify both as
KF_ARG_PTR_TO_MEM and OR in MEM_FIXED_SIZE for the fixed-size case, just
as helpers use ARG_PTR_TO_MEM | MEM_FIXED_SIZE. The switches now key on
base_type(kf_arg_type) so the flag rides along, and the KF_ARG_PTR_TO_MEM
handler either resolves the size from BTF (MEM_FIXED_SIZE) or falls
through to the mem/size-pair check, which validates the buffer against the
following size register and skips it. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 59 ++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 438c27d9b39e..f89551bbae7c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11084,7 +11084,6 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_BTF_ID,	       /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
-	KF_ARG_PTR_TO_MEM_SIZE,	       /* Size derived from next argument, skip it */
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
@@ -11350,7 +11349,7 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
 }
 
-static enum kfunc_ptr_arg_type
+static int
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
@@ -11450,7 +11449,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
 		return -EINVAL;
 	}
-	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
+	return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12152,7 +12151,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		switch (kf_arg_type) {
+		switch (base_type(kf_arg_type)) {
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
@@ -12175,7 +12174,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_RB_ROOT:
 		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
-		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
@@ -12206,7 +12204,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (ret < 0)
 			return ret;
 
-		switch (kf_arg_type) {
+		switch (base_type(kf_arg_type)) {
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
@@ -12402,33 +12400,32 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_MEM:
-			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
-			if (IS_ERR(resolve_ret)) {
-				verbose(env, "%s reference type('%s %s') size cannot be determined: %ld\n",
-					reg_arg_name(env, argno), btf_type_str(ref_t),
-					ref_tname, PTR_ERR(resolve_ret));
-				return -EINVAL;
-			}
-			ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case KF_ARG_PTR_TO_MEM_SIZE:
-		{
-			struct bpf_reg_state *buff_reg = reg;
-			struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
-			argno_t next_argno = argno_from_arg(i + 2);
-
-			ret = check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno,
-						 BPF_READ | BPF_WRITE, true, meta);
-			if (ret < 0) {
-				verbose(env, "%s and ", reg_arg_name(env, argno));
-				verbose(env, "%s memory, len pair leads to invalid memory access\n",
-					reg_arg_name(env, next_argno));
-				return ret;
+			if (kf_arg_type & MEM_FIXED_SIZE) {
+				resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
+				if (IS_ERR(resolve_ret)) {
+					verbose(env, "%s reference type('%s %s') size cannot be determined: %ld\n",
+						reg_arg_name(env, argno), btf_type_str(ref_t),
+						ref_tname, PTR_ERR(resolve_ret));
+					return -EINVAL;
+				}
+				ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE, meta);
+				if (ret < 0)
+					return ret;
+			} else {
+				struct bpf_reg_state *buff_reg = reg;
+				struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
+				argno_t next_argno = argno_from_arg(i + 2);
+
+				ret = check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno,
+							 BPF_READ | BPF_WRITE, true, meta);
+				if (ret < 0) {
+					verbose(env, "%s and ", reg_arg_name(env, argno));
+					verbose(env, "%s memory, len pair leads to invalid memory access\n",
+						reg_arg_name(env, next_argno));
+					return ret;
+				}
 			}
 			break;
-		}
 		case KF_ARG_PTR_TO_CALLBACK:
 			if (reg->type != PTR_TO_FUNC) {
 				verbose(env, "%s expected pointer to func\n", reg_arg_name(env, argno));
-- 
2.52.0

