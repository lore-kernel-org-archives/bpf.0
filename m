Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C471486434
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164281; cv=none; b=MDiYD4oVDiI0bBYPaAGOvUjrgartgeetFYTUDLR0mCRYIz4MaUXKFn52aGBM1VRxMdExZkmyIwk0JuMzd28wP0VE7jBPxauErJij59mK4hDArrc0z+ugQtDquEU5O9cKTqAQs1z4rGfOfXIYtKUGyq5fh/2tLkzrOcnVQ6GrALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164281; c=relaxed/simple;
	bh=7+ewtS8UKoJuzSrNJX/ajvfxy5NffxF9AkAlWK7jReU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j57raD6kK6lgtEbaigNpNbaw0SkRF6WP5MIlk68b0knbZCqz75gFiuF1PUEAdIIuWKFGorNwUkKDGIH08e4YYLcsVfFPN4pBwfs0LUe1/PkBi6Ej7qzrbELtR4mfSxxIb1nN9hqbcjdJrGOS7Wz4B+jQNzWhyOtlzCZPj6FhQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXpMKQMf; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXpMKQMf"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7f4f0dd5507so37225a34.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164276; x=1789769076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKUSe+Zw6EJCKp1jwfC8Ud1tfVIbj+CkaQi8U9etPW4=;
        b=IXpMKQMftqOfLPaSUut65SzzYsxl5ztLbu2lO+sDNpw3+0taeaZzpE0DjzgLbDe4wL
         MoWp/9AbMLM/R/9C8N+UcmFYQuX1Ip2h6TBx1ki4FiWyo71ymaX4YcEJcfJIxWvhpeD7
         lpTBoWv+SlhneDaKZkTNH+zq+wMx5vnZCxl0WtxcZJQ5s+DHj1jMnc8hy0PmDrLcy99z
         +bsWmvm1IV7cLphBwhtMsY4YSTmNDuJ+O87D2mXRYKAlx2nsniEn36Jp7Uts4McU18NK
         PSCwM2qGUM3asfvC08ClLb5TenyioD3aX9Lhpv6a8jZT/OeplzC8BDEANOZMQD2W4BNH
         v0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164276; x=1789769076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKUSe+Zw6EJCKp1jwfC8Ud1tfVIbj+CkaQi8U9etPW4=;
        b=hi7yeyekJUZPNKV7mMCq5b0RxeCA8BfPxGoKjghUeEc+WJT55n6uZWgP15m/5o0Fh+
         3PwjOHtFcvrijtx3soshlTxw2/fNIEOrCPkWlpxNJyl5RZAgdBiXlgFCpJDL3y0zujRS
         epo3HJx3fff0zZ5wIRI7v1oR0UtkdLulk9KwYNZkNFcSejrqxsscnAoKYEOy07IEqXGI
         7Dl15H5e5PkXrkwAz4N33lDZAgwMBRhxZ/g7GQyxdOwQi0LTdxaOslWGq84bdGaGCDul
         Hy2NZczSXhzGbmgV8lBAarM7QDxBvmAK/rG6Hzi7acS5ZYod1mlmt8R660K3shQUfE5T
         ETVw==
X-Gm-Message-State: AFuF++mHPgXIepG1Gre9EX/K4lLo4zJLM2o5lKcsyZ/Nl6QrQFo36beR
	2OhLMvJdKSUErIO+6U8uOTuf6YN7LIgzCxpzqnDLlceIvCVMzsQcFPF1+pD2cw==
X-Gm-Gg: AYBFou3sJSYiVpKPU6DwKPQV1rdzr8TzQNYuTjn7a8RdRQslsru3gbI7TfTN4SZzCvb
	bMmclhS67DepcITCy/CRV7Mei35+V+i4TOOytRPuLrxtlneJsjQEOhAIMeqp1OB09S+WPdmlhRz
	c1MLaCNw3QmuyyHt4uDzr0tbd1bDZbei/YYRDBT5cO+opAgeiYRLMJMmsYxjMqiqIQNmvvZB/w+
	YEU3etorJJeAT8+0ashYJoAA3xir69+aJ0BN9RYVW2z2oGVd6VlcXHp1+MR8nuv/Wj0Iv7ipIdF
	eXN3ORVz5AN9pvuQf2UUuSnZWXE/lVldJV6gL7HapDfVOy9u2GV1ZjMIU2wxiG25N9IHhtKKBu3
	BKryOGI8oHZkZpNsMeRavBOYBrDkLUFJHISN5/pSAtkXLfO6jE6r4BB572JMLvwP25+7K8afxc/
	xYroeK6oCqjn03m4v3VhYIkKqvB4fXcZN+MRIb1uZ3IGxVDILOcYVpoqb8KXCB
X-Received: by 2002:a05:6830:dc6:b0:7fa:ab72:9df9 with SMTP id 46e09a7af769-805a071941dmr167091a34.17.1789164276231;
        Fri, 11 Sep 2026 15:04:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f670ec82sm3946427a34.20.2026.09.11.15.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 13/23] bpf: Resolve ARG_PTR_TO_MEM | MEM_FIXED_SIZE size in kfunc bpf_func_proto
Date: Fri, 11 Sep 2026 15:04:05 -0700
Message-ID: <20260911220415.1396439-14-ameryhung@gmail.com>
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

A generated kfunc prototype classifies a pointer to scalar memory
without an adjacent size argument as ARG_PTR_TO_MEM | MEM_FIXED_SIZE.
The kfunc path currently walks BTF and resolves the pointee size each
time it verifies a call. The common check_func_arg() path instead
expects that size in bpf_func_proto::arg_size[].

Resolve the size when generating the prototype and teach the existing
kfunc path to consume the cached value. This prepares fixed-size memory
arguments to move to the common checker.

arg_size[] shares storage with arg_btf_id[]. An ARG_PTR_TO_BTF_ID
argument that falls back to scalar-struct memory therefore keeps its BTF
ID pointer and continues resolving the size when that fallback is taken.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0547fbeeebbe..615a5667e569 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12182,11 +12182,11 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		   const struct btf_param *args, int arg, int nargs,
 		   struct bpf_func_proto *proto)
 {
-	const struct btf_type *t, *ref_t = NULL;
+	const struct btf_type *t, *ref_t = NULL, *resolve_ret;
 	const u32 *ref_id_ptr = NULL;
 	argno_t argno = argno_from_arg(arg + 1);
 	const char *ref_tname = NULL;
-	u32 ref_id;
+	u32 ref_id, type_size;
 	int arg_type;
 
 	proto->arg_btf_id[arg] = NULL;
@@ -12329,6 +12329,15 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
+		resolve_ret = btf_resolve_size(meta->btf, ref_t, &type_size);
+		if (IS_ERR(resolve_ret)) {
+			verbose(env,
+				"%s reference type('%s %s') size cannot be determined: %ld\n",
+				reg_arg_name(env, argno), btf_type_str(ref_t),
+				ref_tname, PTR_ERR(resolve_ret));
+			return -EINVAL;
+		}
+		proto->arg_size[arg] = type_size;
 		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 	}
 
@@ -12984,7 +12993,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
-		u32 ref_id = args[i].type, type_size;
+		u32 ref_id = args[i].type;
+		u32 arg_size = arg_type & MEM_FIXED_SIZE ? meta->fn->arg_size[i] : 0;
 
 		if (arg_type == ARG_PTR_TO_PROG_AUX) {
 			cur_aux(env)->arg_prog = regno;
@@ -13360,20 +13370,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			 * If the register does not contain btf id but the argument type is a pointer to
 			 * scalar-only struct, allow verifying it as a fixed size memory.
 			 */
+			resolve_ret = btf_resolve_size(btf, ref_t, &arg_size);
+			if (IS_ERR(resolve_ret)) {
+				verbose(env,
+					"%s reference type('%s %s') size cannot be determined: %ld\n",
+					reg_arg_name(env, argno), btf_type_str(ref_t),
+					ref_tname, PTR_ERR(resolve_ret));
+				return -EINVAL;
+			}
 			arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 			fallthrough;
 		case ARG_PTR_TO_MEM:
 			if (arg_type & MEM_FIXED_SIZE) {
 				bool known_memory;
 
-				resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
-				if (IS_ERR(resolve_ret)) {
-					verbose(env, "%s reference type('%s %s') size cannot be determined: %ld\n",
-						reg_arg_name(env, argno), btf_type_str(ref_t),
-						ref_tname, PTR_ERR(resolve_ret));
-					return -EINVAL;
-				}
-				ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE,
+				ret = check_mem_reg(env, reg, argno, arg_size, BPF_READ | BPF_WRITE,
 						    meta, &known_memory);
 				if (ret < 0) {
 					const char *expected_type;
@@ -13384,14 +13395,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 							env, insn_idx, argno, func_name,
 							"Pass memory with at least the required number of accessible bytes and suitable read and write access.",
 							"the kfunc expects %u bytes of memory for %s, but the verifier cannot prove that %s provides a readable and writable range of that size",
-							type_size, expected_type,
+							arg_size, expected_type,
 							bpf_diag_reg_type_plain(env, reg->type));
 					else
 						bpf_diag_call_arg_fmt(
 							env, insn_idx, argno, func_name,
 							"Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a pointer.",
 							"the kfunc expects %u bytes of memory for %s, but it is %s and not verifier-known memory",
-							type_size, expected_type,
+							arg_size, expected_type,
 							bpf_diag_reg_type_plain(env, reg->type));
 					return ret;
 				}
-- 
2.52.0

