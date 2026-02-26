Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AF47278B
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140394; cv=none; b=qqMz6Mr3AplVKT8XRoExLh8Q97LN0FxK47+KK0cn3L4emvqfbtrIUS3+Dp5bUliSYqguK6umAq1F6FBmkBPMZNoBzuAgBsfkVVDB3EGBZvtlrjuMqvPwMrluy5coyoRluLCl9GbihKakAfZFDA2F53Tw/D/j8v17boH5PlC8e6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140394; c=relaxed/simple;
	bh=MdmSDav4rcCxffkav5Qu4BE2w2g7CdGRYopbzgn1MNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkEpU11bDlYQ7r/e7SUIjpbd5usActX8KAMFbyuXN/no6iKRhPKCeifUozOTN5PRrbuuRcv/3vGQmbzgvUBL2WPAp36HLjJaCCNO9Lv46zyfUmUYDKLpLNT8ZCQZqa2uzPPzkVgcrhT5jo9DOk0bLungImGEg/KEmvFCMXCEoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NeGil4Gd; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NeGil4Gd"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso1633564e87.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140389; x=1772745189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNzGwUdZ6+knZ41f6dzJzlNu6h5Ekihml2eSy0ufkRA=;
        b=NeGil4GdrU1TPRl3uXdALbyQVgrwZ66TZlrxCl4BTEF+ytJyRsbuVLH7G05XwkAWfv
         RJoNHnd4ndh4IMtASBy14HfsYwxjzFmJUycAb9Wa/7JU6xLPUmLPi1FctLWI3jyfbV4z
         fBHBkDIelyeH+b/yp7zdpHnChZAVhE3j/zptbQfEVlfVf4AVX2aCSY5LdZBQ5F2+7Xr3
         rAAmg+FUMuBdhkFKryQ6wt2ESruPdOEEpCIAcDirjX9jP4zJr+Klx6Yw5PhCLL7+Jc9c
         9440Jq0pOqbkSHLEzdBv7BCJHoC0c7/KvP5UG9lSh0AOglVvr6rgdga3obs24eBcrkaN
         5cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140389; x=1772745189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kNzGwUdZ6+knZ41f6dzJzlNu6h5Ekihml2eSy0ufkRA=;
        b=hfhBVDwBtjXk2tVoPu76C4dMGVHOrXohr+EyRMAyo54slDNAFp5JEjNb8iSAhdtGX7
         JniKDt1NaGwyrfVYAcdem/Dc5G3clFxo5LYKBQHjhIg8KhZ3DlCKLc+jMyuWHl3Y/d3r
         f3uggaYjVi9sLo6BU42wLNVYcUfpZ0UM0jwqO1JwrYeIHGlW3JYklVfDggbcaXTnAFn2
         4J4N7uilJr6P8BOMCfF9ANmFVRuXMBe6+/Gvwt/9HaZIFuKTSsDOvzERzCS4JOi677l2
         nJH8O+uutazImE3NWwHvv7hPWfOEO7/baIAPdgMcZjm2MUfmPBWh0Nb8PBwLxaMBBemq
         yO5g==
X-Gm-Message-State: AOJu0YwVJmsDIsYVbkNdRWHKqFc36TNBsMKWEj16iF9Hpzqe2ztyDujl
	kisnWBtTYQOMvxN6yISesCMNcFsD6qs51C86WRdIaIiZiD4jBrzhZCk59XuFfC3svKY=
X-Gm-Gg: ATEYQzxx6/fwVjn5bsQpayXCmBfxqxhhRLm/by5Oni472P6A9yNCLrBrvmupiiE4oHk
	tEDhfc5L4ilxyX5DXTCegFG0F2n4Y0bnEtxXZwa41tOEdPS7plUg1d4Zq9O4BQkJTlnglkAlx9y
	5d4vX7MJNyPF3o/xh76gD/7XH9hbGA9fdpV9dGnUWZ2d/5Fq0ztquuboFxiNtlEIxBv1oTEydq7
	38MIMouTBy9S7YctfVOm678uKMwFgB4af3O2SkqzkML55wxrcLVQQiT+JM9s9dFak5Sbo2e2/SX
	R+ucLPCHl6+3ulMIYJcDawE33s22g2aopu9o/f70I5ajyWfJiTb6jb5ml+swPpnbgcNOpGp13LG
	ig4ZM4PK5u11qPyHbJW0HpZz2NPbgiID2/OQJndetpTwo50z7B6RkhWfXvejmx+Fa7rvfUr+TOP
	YhlDpNPEAGDkFJrtBPyMO1epjQBUCQ7iVffEx6BB8wiX78/5eiVCwuuXEUgWMWNTnLGDpI
X-Received: by 2002:a05:6512:230a:b0:5a1:8b2:853b with SMTP id 2adb3069b0e04-5a10ff9992dmr162991e87.12.1772140389208;
        Thu, 26 Feb 2026 13:13:09 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a10f78f3bdsm371061e87.14.2026.02.26.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:08 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:53 +0100
Subject: [PATCH RFC bpf-next 2/5] bpf: Allow passing kernel context pointer
 to kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-skb-local-storage-v1-2-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

bpf_cast_to_kern_ctx() returns a trusted PTR_TO_BTF_ID pointing to the
kernel-side context struct (e.g., sk_buff for TC programs). Passing this
pointer to a kfunc that expects KF_ARG_PTR_TO_CTX fails verification,
because the check accepts only PTR_TO_CTX.

Relax the check to also accept a trusted PTR_TO_BTF_ID whose btf_id matches
the kernel context BTF ID for the program type. Introduce is_kern_ctx_ptr()
to perform this check.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 113e2eaec4db..017071197466 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6474,6 +6474,27 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
 	       !bpf_type_has_unsafe_modifiers(reg->type);
 }
 
+static bool is_kern_ctx_ptr(struct bpf_verifier_env *env,
+			    const struct bpf_reg_state *reg)
+{
+	int kctx_id;
+
+	if (base_type(reg->type) != PTR_TO_BTF_ID)
+		return false;
+	if (!tnum_is_const(reg->var_off))
+		return false;
+	if (!is_trusted_reg(reg))
+		return false;
+
+	kctx_id = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
+	if (kctx_id < 0)
+		return false;
+
+	return btf_struct_ids_match(&env->log, reg->btf, reg->btf_id,
+				    reg->var_off.value, btf_vmlinux, kctx_id,
+				    true);
+}
+
 static bool is_rcu_reg(const struct bpf_reg_state *reg)
 {
 	return reg->type & MEM_RCU;
@@ -13495,7 +13516,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_CTX:
-			if (reg->type != PTR_TO_CTX) {
+			if (reg->type != PTR_TO_CTX &&
+			    !is_kern_ctx_ptr(env, reg)) {
 				verbose(env, "arg#%d expected pointer to ctx, but got %s\n",
 					i, reg_type_str(env, reg->type));
 				return -EINVAL;

-- 
2.43.0

