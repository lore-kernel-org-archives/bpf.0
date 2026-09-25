Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6914F55CC
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370792; cv=none; b=bQPCCkF+S8N4IiqRGCRFO//GuD6tCSt8VFZtVc8J3y3l5yurJz/7Ex2cu2JJIvC+oR3dDEM6aAChILzsr6kad41vebd0NpMAu+a2kuHu6KYktoXr6cog3/bbDC7FuIsl4FK6ukqqTN5VgDpBP283kqOsmH2WZ3/B86QpiaytUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370792; c=relaxed/simple;
	bh=XIptI9rM8iZMYMGG9N5+DWhwAM/blpHn0l5qKtXQ5V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUM+pWriWkD3RLJnSJT7Jf8BoJvvjONZPIJxwbfGVNEHhe/1JJkoTV2drGTLNp+PM38GHhLnWpPI8l0KpJMsWaLce+9eVr8y4nFZ/BgoWrUW1660RFD7JQ3rLVkxSFhL+OuksMFs1y6XmebePc1bAZnNoaetfG/VpyAV5egug94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlmxYfl/; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlmxYfl/"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-7f4f0d37dccso756944a34.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370789; x=1790975589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uet7W/DK8Eg60tUBYLG+nk713YDYgd4WEmXExiwPIrM=;
        b=rlmxYfl/zI03w0b6Bo9Ogx+BVP1qFjHFma9WAui8HnJF9pwLJeNB175UwQBJ5IWZWt
         fQgOmOEyDCLdvfFxBFPAJvGA+RiicJN61ncygy7iXmCx/Uf/Y83YfB/kpx0jiWVxbBGv
         AvQYNNW9MXupe1fx00/RGRfCeQ5jMTvgoXQ208WcUhG4lRnIF/Ft8Spi/LSkY+fAmjYs
         v5AeZpwa3j6ezT3d7XkAxpzgk/7SI/0ZCHYkpp7kLLtnEcRdKHO7zTqBaU8Sh7BhIHCC
         TjzDrYmXdB/BFAHTK5a77sifA2cVH9DkR0XwJSiBnr6YRnr/+1kBa+yxZqxiQe9huG2l
         R4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370789; x=1790975589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uet7W/DK8Eg60tUBYLG+nk713YDYgd4WEmXExiwPIrM=;
        b=rEGlcIADNklP5Qyyzffvd8GJ+DYkOb7q/BIXS9yA/TRpmDUPNcJBOloEw+hypqt0k2
         D9QkQ0SiJmySeTwx1bGIlElz1R8AKfogAbc82juQDturXT//lmeFrVzjETfjeOLP44qE
         1JHLQ1MAxkFW5G9MDaM+vSBNK3Rxkw9JZYMbNLIhX17275svkuThWnseezFzDMyJljts
         vndUzjZc/7gGAbVcHF1jNEDT7/+kHrN92fzGbJdxmndjXdZ3sqEIipAPsvq+dVKif0IZ
         qr5QtbWOUar88f2JaztalbJTH9TpJ1mtcnqtCujzewaEVJswoeLgwsS8LLFLkeNq7v46
         egng==
X-Gm-Message-State: AFuF++kipT7HwlidGO8x8/NKPJk/rK65IKUHs4DGMnKXknwG3xv/3IWV
	m3RBLYSA+9XNYZWj/Wd1eWXobnKf2ouM/+qbj1Alo1F3vJRFp+3Xdd+YQj2cqw==
X-Gm-Gg: AYBFou0OEkxVsmPpnXCtvq2Yza4YAQjKPH9Im4AKu7zb9ZdPr2goHUrIcZKOYZ0JZgE
	lYaiBoihK6cx07WP4YxKKZbaUL11x1cEBHwaJBqT4OM/WUp0XXI9LkNs+Bu1QndroLc/JRp4Nro
	0e4tIUFe3rpjb8PDyNX+jrrcR0O0NA+68HuOcfadYOmOTPoBzdY8G1fO+Sa7J+qXNxTnYkHu8dP
	aPhuNkacNn36W7htr126JxywNHhIRsiKeC2BUysum1ihr2Wx7nqzrIS6EqQ3umyWM4Zm8oG6iRD
	91FeKDMzQlfD1dsHvdjwCbNsTMgGz8Qas2Q8Bzx1Xbbo1en+rGAeQiE3EngK14+H/V80EgIrb7q
	1xPXnb8GR2wR2GmwnXo6mmV9CcYIYOduKmkKm0LcpHWFOcCBDHyKITM+Cu58zBaH9tkz02gWzwS
	b5lXxoQosUzlSst4hkO61aRzw4SfS4/XHkhuHicMgyqheAkEW1LPyrrFCuKYh5
X-Received: by 2002:a05:6830:258a:b0:806:14ab:a7b0 with SMTP id 46e09a7af769-81783e88264mr8160458a34.30.1790370789518;
        Fri, 25 Sep 2026 14:13:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e92c20d0sm3654386a34.16.2026.09.25.14.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:09 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/12] bpf: Check subprog dynptr arguments in the common path
Date: Fri, 25 Sep 2026 14:12:52 -0700
Message-ID: <20260925211256.1834061-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subprog and helper/kfunc dynptr arguments ultimately use the same
process_dynptr_func() validation. Route the subprog dynptr branch
through check_func_arg() so register type, offset, and dynptr state
are checked in the common order.

The existing wrong-register-type test passed a NULL local to a callee
that did not use the argument. Clang left the context pointer in R1,
while GCC materialized zero. The common checker rejected the values at
different stages and emitted different diagnostics.

Obtain a PTR_TO_BTF_ID from bpf_get_current_task_btf() and keep its
callee argument live. This makes both compilers exercise the intended
register-type mismatch.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                           | 11 +----------
 tools/testing/selftests/bpf/progs/dynptr_fail.c | 11 +++++------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 96749d9b3e26..4a5c682ee73c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10882,7 +10882,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		nslots = btf_arg_slots(t);
 
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
-		    arg_type == ARG_PTR_TO_CTX ||
+		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
 		    base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
@@ -10911,15 +10911,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (arg_type == ARG_PTR_TO_DYNPTR) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_DYNPTR);
-			if (ret)
-				return ret;
-
-			ret = process_dynptr_func(env, reg, argno, env->insn_idx,
-						  arg_type, &meta);
-			if (ret)
-				return ret;
 		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
 			int err;
 
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 9418dfe4d7b7..148cf4417322 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -2053,19 +2053,18 @@ __noinline long global_call_bpf_dynptr(const struct bpf_dynptr *dynptr)
 	/* Avoid leaving this global function empty to avoid having the compiler
 	 * optimize away the call to this global function.
 	 */
+	__sink(dynptr);
 	__sink(ret);
 	return ret;
 }
 
 SEC("?raw_tp")
-__failure __msg("R1 expected pointer to stack or const struct bpf_dynptr")
+__failure __msg("R1 type=trusted_ptr_ expected=fp, dynptr_ptr")
 int test_dynptr_reg_type(void *ctx)
 {
-	struct task_struct *current = NULL;
-	/* R1 should be holding a PTR_TO_BTF_ID, so this shouldn't be a
-	 * reg->type that can be passed to a function accepting a
-	 * ARG_PTR_TO_DYNPTR | MEM_RDONLY. process_dynptr_func() should catch
-	 * this.
+	struct task_struct *current = bpf_get_current_task_btf();
+	/* R1 holds a PTR_TO_BTF_ID, which cannot be passed to a function
+	 * accepting ARG_PTR_TO_DYNPTR | MEM_RDONLY.
 	 */
 	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
 	return 0;
-- 
2.52.0

