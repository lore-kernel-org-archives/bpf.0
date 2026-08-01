Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B33B0AE8
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570420; cv=none; b=tnstNPoCqtdsWgpueUBEYBNQ+EJ6h5U3v2/N3hGULxCL7Jeu2JbFyakltfMDpi1J9WdELt+ShpedSr8d0oThVMrb2yLZRmsCC2k9etA2waobRV6pmkxdncaVMw4ujnG/imvMfEkxPII3ZvGXBOPmXuMKX7Vud0qNS9NrbMW66yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570420; c=relaxed/simple;
	bh=8L8ijzpmGZp4kbFOOwtiXPHBZXLAcggJkf0bTZksLRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHOt5JcfGCibxn2OUXdWNfcYyIsvzHCeffJ9guiHuJa/9DDoizyOlkZ2Wuxmq3hK1zjtrtYPjiKWqmBVI4n8kdSEZz2tvziGjEnncVXn0PY1dWKql6gbNYGV83t0QOq4knxf7o6Y8HCf04pEHftlcowp287wGpycE+iWEekMnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKAJBEOt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKAJBEOt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so18684555ad.2
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570418; x=1786175218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a8MXtxepMW8OVv5Jw+vqQXimWwygJCnnb/TBYAFE3sg=;
        b=pKAJBEOtWUlf7r8ZIQgOuHqLYhkILNkoxBBrSjZ6N8siWXmcgYbfSGDTbm6yrEIQjK
         Ht6Pb7IaDYGll3NoyEGLPSGKCZ3+XckKsF3WwQuWj27qZ1uwoOL9dVKwO3tMx3701BBM
         a+AUAZSanoY6Qj4LT2TN/df6pcUYikdKsGytMU7Tw2cgzkeaTSpj+NIJYHE72ekzoSft
         kvUv2CTxHzvKx1+sZ/6kh9m+S9z9p9APhBg6MV0YrmVqAQ8ZB5Gx7mg4NQlQMoA1HtNH
         q+k/86NCmJ6pmJhIpuFJXC49LVO8X+8bHsvCpGbmXM97YRBK2LCNdOagMsgEu83Cg3Qw
         FSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570418; x=1786175218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a8MXtxepMW8OVv5Jw+vqQXimWwygJCnnb/TBYAFE3sg=;
        b=psd2HAo6vBH+XK0dMopYpmHeah+bHlTFTlOgMNNV8Q7cB5TKXMZPn+jIr40Zy91nX4
         bID2ueJHWQgVKozrdehjW5KREW3uuq2LeqcIeK2CyTEi30u4ImqDy5tj/LZvpUrPwvc6
         Z9Ol0qqYlwcd4pmfntwdscsRQy4qJGdPckwIuw3hzhzmzBIrPyTg7M/eYxsofbkB2aK6
         8l0LFx6skTNw5EbyA8fbIQ3U+cZ5bKjyVXqLpQUY5XDwBZ1JXG6YQv060L6GfOtAOCtY
         42w+/IyTEit/I52xo17WWWRSXhGS9bSXKJ3NWhmN4RH+5CvdE4XjYjMMMppo/LheSffD
         aaFA==
X-Gm-Message-State: AOJu0YxcoWFHr4wLNdwWx0UZL+quEV4RdkFeWDo7WJtXjXRGoIotqj9e
	i9g3nSF9VMsmbsvoRs6/e3/z1CjxJ/KXePxR9pF8LapfLCag3XmC6HedM79IRA==
X-Gm-Gg: AR+sD10kPsfoy9YgpVYTKlRoenobnuXqXenvaQIrkySAxmVnNToWG91wqsCade1M4m/
	lB3p2N5n5BbZHk0LcUm9tPgQrvMxmDDMb8bkKqLCVPOKU0/6TVpkmEl1XVAi7s+7ipIv9ZXuTsF
	xPM5QqrTYka5DDoNMStbO4l8wNKU/+Gok9Qc5IUrgqazO0Yk0TqpMbqYk5EGKn1CzVuzXm1rSVj
	BGj6vzUOwB9uMPreH5I/zV8qjfQRorc+mVT0SOm41Q1blM7PvrNQHDE7iqGpg5Oq6piFTVWUKPB
	m4WyUpO1HfvkAHwykj+w/OQLyfc9pc6tZG+EGXNfx6+6ysFOpAv0WREEQX+h6cTuT3tH9PR/HGx
	b3FL0bDd5cot6Z37Zz9LbHcsYwrNNFvq/VBafaxuknAQxttZtqUNwU1BbAd6jzyym9zj8NeSQOJ
	nY5TxYmDsZQ5LxybwYBZr7pKgEJUqg8ip8GxvMx/ytO422bJO5tfEDhbYQDDzinA==
X-Received: by 2002:a17:903:22c1:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2d052061d18mr24160485ad.0.1785570418402;
        Sat, 01 Aug 2026 00:46:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19411sm15190225ad.8.2026.08.01.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 14/18] bpf: Distinguish fixed- and variable-size kfunc mem args with MEM_FIXED_SIZE
Date: Sat,  1 Aug 2026 00:46:29 -0700
Message-ID: <20260801074633.1595644-15-ameryhung@gmail.com>
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

Currently, KF_ARG_MEM_SIZE and KF_ARG_CONST_MEM_SIZE are only reachable
from ARG_PTR_TO_MEM fallthrough. A patch later will merge scalar
checking into the same switch and remove the fallthrough.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7507576c7025..b2aa0101adc4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11059,6 +11059,8 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 }
 
 enum kfunc_ptr_arg_type {
+	KF_ARG_CONST_MEM_SIZE,
+	KF_ARG_MEM_SIZE,
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
 	KF_ARG_PTR_TO_REFCOUNTED_KPTR, /* Refcounted local kptr */
@@ -11068,7 +11070,6 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_BTF_ID,	       /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
-	KF_ARG_PTR_TO_MEM_SIZE,	       /* Size derived from next argument, skip it */
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
@@ -11334,7 +11335,7 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
 }
 
-static enum kfunc_ptr_arg_type
+static int
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
@@ -11434,7 +11435,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
 		return -EINVAL;
 	}
-	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
+	return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12136,7 +12137,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		switch (kf_arg_type) {
+		switch (base_type(kf_arg_type)) {
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
@@ -12159,7 +12160,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_RB_ROOT:
 		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
-		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
@@ -12190,7 +12190,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (ret < 0)
 			return ret;
 
-		switch (kf_arg_type) {
+		switch (base_type(kf_arg_type)) {
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
@@ -12387,18 +12387,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_MEM:
-			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
-			if (IS_ERR(resolve_ret)) {
-				verbose(env, "%s reference type('%s %s') size cannot be determined: %ld\n",
-					reg_arg_name(env, argno), btf_type_str(ref_t),
-					ref_tname, PTR_ERR(resolve_ret));
-				return -EINVAL;
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
+				break;
 			}
-			ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE, meta);
-			if (ret < 0)
-				return ret;
-			break;
-		case KF_ARG_PTR_TO_MEM_SIZE:
+			fallthrough;
+		case KF_ARG_CONST_MEM_SIZE:
+		case KF_ARG_MEM_SIZE:
 		{
 			struct bpf_reg_state *buff_reg = reg;
 			struct bpf_reg_state *size_reg = get_func_arg_reg(caller, regs, i + 1);
-- 
2.52.0

