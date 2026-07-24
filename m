Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164394534A5
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920110; cv=none; b=FvxuOBR8W9oKc8ozARkQRJ+ri5OVZTPxKdZ33Q/sPHVT9q8zzcKSS86GOgqS2ezZ19ppycT7sNpozHr/S+E8GHBJc3+ZGW2WCmhbo1yZTugYDK/SPNapJnKehUn7rlCYnINRjmfi8a5yvJkx/LF/WV4sgT3nPzXxcAr4klYBi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920110; c=relaxed/simple;
	bh=dR/p7v0DDqjn2gg9E+1xndL+W3jE9nB74ZAnKbfCgnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNcoGX77MHaFg5H33dWXryaIGBpT8ApOC5Idxi/QDHqhVTESS3wXNb5FzS2OykhgW/z7OJ7OyXqcWUZSdJWpfsshdLM+irCWwDDkvj7/HG4LKAWwbEuxsmBpc598wh35NvHQRGorptRVYndWZxWOByXsv3uGZAfFehE5Sw8o3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R544SUOu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R544SUOu"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf52d15d88so8589635ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920108; x=1785524908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLqhMu+LxZGDKXQPuuUXgn64sT4LBl6Xfz6MEPvVLZ8=;
        b=R544SUOutGHRjWA9GIYmbdTWXCIaAvWrLeBIy0s+pyOqiQNsjrmhNaVUsHqCX3HN0o
         BeKpOTRb3dOpvLvb0kbI54u4z+E342d6x2NB4q3+azCW7q5DfYnywKZjQMlfDbBQMH8V
         abcYk6CfoIojC6B8q3vKpNdyg/hMxHzkAdw8NhRE8zQulxIzyzkmY7yt/LU+OXY3Zobf
         mON+IykXjpyWzemPBxzuqwxc1uAZA8fS0NqtAZ6e1hSfUpbg1ijqlky6T8IbgKwgbsJd
         zEfG6QVbGAzK4LMygIZA03zNTzK+Lm6OT+5DvLDM4/NLL+mbxUsBarg3KlJBaQw97nZr
         IkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920108; x=1785524908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLqhMu+LxZGDKXQPuuUXgn64sT4LBl6Xfz6MEPvVLZ8=;
        b=jxjZZ++VfokS4IrBIlM9aZrYRBe+d9kNPJdhdF6c3W6CiEuUfwNNfVXCvl5khqJpfa
         n2W4SGfJzusDo7xnij87oclrlD0FHSR5gKPMB/6qxXv/aGbRngnkKWO7jTLtJlwcqNwu
         h+urBFlpNfvq8Zwna0ZXtDa/WKiPJ2QQG0509hl8Gbf8x5kxYIj2kY3DtVtkm47aZPc8
         F9KZ6j3jKyfZfTFA9yqaSZWnwqaZ6gx3WR2kBLQeSEEKWg/CnLTnzmaXVaDEvBZcJdtZ
         eKcilXB32M0UAoHaMpvOa+sLz9PYgT5bzVhLqqKUwPnANTy1fU3JWJ8RUuTjoi5cXVvq
         5Cew==
X-Gm-Message-State: AOJu0YyASp/VwfK6x8wI+rtQgUJ2qQ/pbCCc82RmVwmXCAQeoEsgIEti
	pYLg4Dma0Hpdhu9BVyJPEpdYD5Uzx4mS+YkN6pmF6PHNdLj+ta1JAX8W78t4qw==
X-Gm-Gg: AR+sD10nTEKd8oTcwLj2RPGa3iOt257IZwaqPJrMaMpKMIph5U1HlvKWPSHB+4Smb61
	O+tknRyQ2kuxZ+VbrmIxus6AYP2kovj7m2x/7oFsQl+ORn331e0udjZQSvNFjeIAZqfQ1HNelLD
	HgvNV/Yku8UKN05Qzv1/0JkicnWvxJ1PGalzj6Xb0wqv2IZ8cbuP7U4kcLMngduVVvwVb9Fs596
	I/3toyUn1RBajbbXiGCUaymQZgWNTJi7R8WGadgeusoKQVDxgWy+sjMlCkH+xZph9BBfJs5pFa0
	/r9gahWSaSD7W/LKIztHGlwkwY7SmmJyc901wYLT9tTYVfVLZESYQd9ViQhIQhVZejR17TFH4h7
	D3sldaptyCGtkB1K53yQdHDEfrkt3eYvEIyaxVcPsTHcFKZI9JfV/5Ju9pg2BP4XoDlQ=
X-Received: by 2002:a17:903:946:b0:2c9:97a8:afef with SMTP id d9443c01a7336-2cfa6f81d7bmr88104315ad.40.1784920108406;
        Fri, 24 Jul 2026 12:08:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf9c8b7a7esm46452805ad.3.2026.07.24.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 13/18] bpf: Distinguish fixed- and variable-size kfunc mem args with MEM_FIXED_SIZE
Date: Fri, 24 Jul 2026 12:08:07 -0700
Message-ID: <20260724190813.1458271-14-ameryhung@gmail.com>
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
index 64668e7d184a..144c2d8aa492 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11078,7 +11078,6 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_LIST_NODE,
 	KF_ARG_PTR_TO_BTF_ID,	       /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
-	KF_ARG_PTR_TO_MEM_SIZE,	       /* Size derived from next argument, skip it */
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
@@ -11344,7 +11343,7 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
 }
 
-static enum kfunc_ptr_arg_type
+static int
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
@@ -11444,7 +11443,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
 		return -EINVAL;
 	}
-	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
+	return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12146,7 +12145,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		switch (kf_arg_type) {
+		switch (base_type(kf_arg_type)) {
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_trusted_reg(env, reg)) {
@@ -12169,7 +12168,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		case KF_ARG_PTR_TO_RB_ROOT:
 		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
-		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
@@ -12200,7 +12198,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (ret < 0)
 			return ret;
 
-		switch (kf_arg_type) {
+		switch (base_type(kf_arg_type)) {
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
@@ -12396,33 +12394,32 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

