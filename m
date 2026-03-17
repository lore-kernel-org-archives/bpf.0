Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D60288D2
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746344; cv=none; b=Wo4DMrejRfN7JkcKtY2X9mKVy8W/b4lzhRjUaMPPhUSrCYur3gq1OCk7DciWF8vNbsnDcTYiUHJAzLjfblag7II6HkFcB8d/rvIsj3R+keSdnyjIDmIYrOJ1fQM3y/PINITqUGbRsNCWhUjjf25wh5nDi7G41mZ2PlMviM1/LHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746344; c=relaxed/simple;
	bh=BbTbDFg8tB/mofDnmXv/miCMFDWw95vP0W894qew3QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArYRk0kheKNUdTwmjNVZOmLHWNepD3Owq13LuNIW9yQqqwBS0P6BR8atSr4tNHLStfpxKbhI8ZipylF8VpfdYGSPlwkQ4qYDWuNfb8yooV/sP0SD/4qORJdY0ROhimSryUfmJSjPg2lI2LB7s8XHIaaZodtJEU/59573Ry3hjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1Cc3iuV; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Cc3iuV"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-46708149af2so2876904b6e.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 04:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746340; x=1774351140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCGFiwWorr+SI3krg7gsoldYatZUtwGue2nXcxg7flg=;
        b=B1Cc3iuVXiyD8PmqNvvGgNwMjvIrBqeZhdPeT3ktSU5ySnwqEubZDRhHOTyoT/+rPq
         m3N7vUO5mlalMTuZl+/bxAKZa+ivGApcgvZYWR8p/4PxtjBCMpZnWRcW8opj/rDqLim/
         7udysPDFDDH9UjQfbZT83e7Rp2nmq+VItxM9TvEaNUej2HPO5ZKU0ZY5aRgmJOEf3T0N
         xI7Gho/LX0ab7oUhHFsxHiPBiqQqim2Fj2QvQe/dYVBfK912bsor/JBxRbN4ogPDojk2
         4/lFuR1shzFaEBfxKhC/OY3vrQbMAu20yxa0unArZ4TKc/2yjlBAvmBfSsA4+adlzZyI
         kMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746340; x=1774351140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCGFiwWorr+SI3krg7gsoldYatZUtwGue2nXcxg7flg=;
        b=V4STqi25UPIKixnpvHFlcEbqVGEVUJ6rVDucw7opNhaWm7//D7LHxGshHqDhnB28kf
         VoZEwsUssVADW0W1v1LkJDUdWCEYNTjN/TGBUPXa24D9oD25/SfA6Oj06nYP/FlBtKzy
         arE0D8rIoynn5FunkvPDZZ82TxVOJDKc1uXXltFxP9AqeYMWsoJw9mfNebUU8FWzsFMj
         BB03+BBOzSLIHbhrgIN270FQ2STutFaCBKRXRDYzZFQER2q6cjZcSJ0xuuAq2Svig4Qy
         O1pymOkuLRCbgpOAfzyRXS/LN779MSN1LVs9pZIZ6VJ/CuxQyRCkIzVCBYMi8u4JAdX6
         hi2g==
X-Gm-Message-State: AOJu0Yx0OZzotVW0vHyxZBLB+fq158jab0Ie6tY/+CaJaJYPkLGy8YKT
	b5MBbb6ZOEKH8qZSnZg7RjI6khMaYZ0rkzFui/VGFxiwp+GfDZ6hO8BtLbItmsQajZ8=
X-Gm-Gg: ATEYQzx/Io20SlauQtYsA15md3Yfij/vQYvVPwqZeBwcVX9GNNLTU+aNobcVQ8TFgps
	bZW0183+75WNDhmvJA5koGvFYYMNNoBH1ynHG075itOJdWTMykOrKDRaY4NQcrkbaZnFS380trX
	OfGLsIsPkYEBDbOocUIqIKpEoXZjSX8muTEYyXzvSOWUZi327Ee8JS+udioChD9+VhIuQwdnHu/
	zZmy1MBRwezx+/Im6Lg+Mp4Avcy3doIBHAOhcq+V0/8XpXFA2DfRF8/8SYjNTxdNtnrs+KxNDkD
	kELkYnQCM9oooV+3UA1x1jqoBOEqL+eM13lKv86afmSDRks7Lg6I5nZvzmj6yA09a/D8xdGEKyA
	UDaZyNm0qq7Sm7U0bAa9N2aJqn7gLbEbkgBGC3VwHsSPHjXWmPWWkieDe/6viWP3+bGE7s3jSGP
	XZVezS0pxqaUMK8OKEbWxyeWjxRLetUFgSvaNH9q5DXmQK
X-Received: by 2002:a05:6808:5382:b0:467:2375:58c9 with SMTP id 5614622812f47-46757403007mr9608352b6e.45.1773746339668;
        Tue, 17 Mar 2026 04:18:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342ef6fesm11253818b6e.14.2026.03.17.04.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:18:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/4] bpf: Reject modified syscall PTR_TO_CTX for global subprogs
Date: Tue, 17 Mar 2026 04:18:48 -0700
Message-ID: <20260317111850.2107846-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317111850.2107846-1-memxor@gmail.com>
References: <20260317111850.2107846-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; h=from:subject; bh=BbTbDFg8tB/mofDnmXv/miCMFDWw95vP0W894qew3QI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpuTHjwUudLgB76jlgU9OmuTu9NZPae73gi/1nNJ8P qXqNOjuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabkx4wAKCRBM4MiGSL8Rygu3EA C/XlmfaEcYdFItqmZf08460G5wpF4aUtqzJNn18tfu5fAJYndM9EqLHn5f2BhzryDNrtmYxE7w1m0S TvBU/gltXbFgAWcYY5taymeTHsYQWee07xqP590+X3LU43zbdQ5NV1KbeTNfQbbfpl/a7WOHRnDpLC mMD+mNOwyNw6sWLd40YGmFjdyRFgo36quDUjj8kdlr3GBS7WZBsHRuzWf0OjeLlzsjiwDyz38S/nbI 1e0m+5eh/t+X1rc4C7HkLYKSdOr1pYFB4Vz3amc1z6eqzHcZLFp1oPMyzT9MNILNkSmbKAX1AtpyiZ edpZythhOBaVBgj/6NOi8Jd9yEzYszSqd+9Cq3rdT2nnbD7XL8VrnRdXS/P/C/fBb006WJ0kxvo3Bj O26olQGBmnSImd2RUjBSfySNvTf2fQF2JNSrW0qHYsOXAhYGPSXSg7o10tZddkiZq2KQKWPbmuYicQ 58LpcHm5lllVjKboFJOBsYPn98bWYFs8N2Df7+ZquQHSCBUhyV0vfXd1T8fBNBoEEtyNHRwyEHfnTc b7h1eVC65Wllt3npv2NTtjf6Qk2qnosqx4pyXq9dOaThfXThNBRQLzJwr/Hx7cdvaNGeFQjlD4ohKz 4cxHGn1g4MTV0cc9zK9x03gGJp4cebwMF7TgxeGMJbVFWSXJXMoc+qF+uo6Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Now that syscall programs allow modified offsets to be passed as a
context argument, we must make sure that they are passed unmodified to
global subprogs. The reasoning is that we can have inconsistent and
potentially unsafe max_ctx_offset based checks if the global subprog is
used to access the ctx, or when it is replaced by an extension prog.
We'll need a post-processing pass to correctly identify the
max_ctx_offset across the call graph, but it's extra work for little
functional gain, hence just reject this case.

We have to make this change now, since we opened up the checks made in
check_func_arg_reg_off for BPF_PROG_TYPE_SYSCALL's PTR_TO_CTX in past
commits.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 50639bb69d91..3f34510ec183 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10778,6 +10778,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				bpf_log(log, "arg#%d expects pointer to ctx\n", i);
 				return -EINVAL;
 			}
+			/*
+			 * We should not allow modified offset ctx to be passed
+			 * into global subprogs, to avoid messing up the math of
+			 * max_ctx_offset for the whole program. Supporting this
+			 * will require a post-verification pass, not worth it.
+			 */
+			if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL &&
+			    (!tnum_is_const(reg->var_off) || reg->var_off.value)) {
+				bpf_log(log, "arg#%d of syscall prog must have zero offset\n", i);
+				return -EINVAL;
+			}
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
 			if (ret < 0)
-- 
2.52.0

