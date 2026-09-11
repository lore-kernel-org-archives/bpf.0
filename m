Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9F39A807
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164271; cv=none; b=WSVOu5y8pSL15Og2wySiC+TZ/RfZm63ARMvB1TwiKI+PjbMLGDOPNUPCEHYEyrEBNtlWQwk6OTxwDYhjUHqTf5IlDiUTBm2O2FIVbHpKhTYxGAEE6nFJ7+YP1p3DchsGS4NqcIOWxukv7QNGR+WgCF6uCgR47gaNUmZZEAfvynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164271; c=relaxed/simple;
	bh=cvKJ7BccvB/VmySKbJQSXIiJ5LNsGkoEzxVHOvpU/d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxp9Gc+XkhSzZXWGV3C7REA36bYSt8KcE1wGu6I2QttMNpAfBxmUV8VEYJczhcAR6aBl+HHnVo2yglOnF/dlYUTGEZepVomU5IEagru5gghewZSas6wGVL41KdESZ3GvRtztH9lkoN7c+uqtT/r/4PzrQGyCbt81HGeLS2Qn40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeAFetc1; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeAFetc1"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b28df1f600so1328393b6e.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164268; x=1789769068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQrpq6ctMsMeXfnPoyY8vgHIKzC+ykyRKehOdOxJBYM=;
        b=aeAFetc1a1A2AKnTIyEmLslkU9AtSvryMbx2uET85rO24SB38gVtaJugtTfbBexgoy
         hPwUG7hDXyj35gRMCojhCOzd84+uaggbkN1IeZf4SR7EOMzYe9xrAZDqY5S9fX8l8n8G
         rMxAHKGUx65csdOQjJK6v2nzDBbhZ52qQF+xsQjAcZXRSM3B/zuv2nJWsxnmsYqnVSuv
         r0scGLD5F/baN9TLfnFUPUl3EjQC6OTtEAhF+tS47vWFGTBcYUQz9yr0/2aQxbx1ltjr
         hRCOwhOJ24Qzo9YFOBSxuHuqlS+PHIqjLp+S9vqql85tBqWJNY1VxITY4Hy2t3s37jU2
         hfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164268; x=1789769068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQrpq6ctMsMeXfnPoyY8vgHIKzC+ykyRKehOdOxJBYM=;
        b=HrxKTG77i3hVwRhOFuSZt8j3HELcGncDECclLbbg1hyDccc34lqe9HNqck7p+uHdeB
         MPtFLVIM+3Xpt+oazqHljCCkD5dPF7/0cVY0Sq/lHYycqCsnzf3jtw1QJdZYM4ZCV29K
         4TWoUORHe4oZ/VFgotYTcxPnT2gVC/D3IZFtC736Y2dvMqAJNAHMxxVLygJaUq6frvH5
         ZgKbC6iZfwoUgB75dAfy61C6vR4g9ZoIKitpQyCpAScTDvLfvgXGToS9LBxPfmttVtxu
         9MlquG2OsdlklWM57LstBlfb2SJiClRLZT52QmQLFNkEujbwaoFs8vOVeSBDyIMb7lz5
         0tOw==
X-Gm-Message-State: AFuF++lhtnVJOaiJxWarkvxJ128i/bYvne+E+I7gjT6KGPsNVpg6BoP5
	nV1Y5kyjObBLYPQw/oavhvzc+VHcCaof3uRX15cFWlxmpfHbpf/UVnOXay5O4g==
X-Gm-Gg: AYBFou1A8NDaoS7obTcSaEBZRrjTIdjr+msf6AmZQjiLMW9B3D/Xt58emPeCsRQZpBM
	eJMAGuezBnrZ0mrlXh89OTqH2MiN39LGa0E7+3ukz8JPrzvC8vvYu1deTOa0BNWLnZl+4ps1SbV
	/l2KSoIcyujB5wut3XZbxNkwTzVoPmvwU9Rm03Z6ljvBj7a28IfY0LEMgh9+BTog5TIeIJDRB4I
	UZazg0Pztqd2q+iuWbyUT5yI5JoYw8cPlG2SkXpq8KJQZOlrNWVUPZH37Rs66upmomOafYSORKW
	SSnSvsG+UuKqpvYc2JNQLfaKb192wNMhqOmcSMYihNYgfXL7QUdZBuaqTknXGex8vDWqRGYs3yM
	l1YY0GU5X4Fn0hgnBkE7o6Mr+DektZdxd1rJCc69K01dlBuw7A4LHglnlT1o37MvHrzW3Y8ftey
	PRNWKJ2WJ4BPtBbcm3CEBb2EVvrIkqxkigh3bx3eKGacEwrZRDp0Fjq4tI+zWCFQ==
X-Received: by 2002:a05:6808:4fe2:b0:4a4:ed9a:e793 with SMTP id 5614622812f47-4c31d866e16mr5743822b6e.16.1789164267886;
        Fri, 11 Sep 2026 15:04:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm3218423b6e.4.2026.09.11.15.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:27 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 07/23] bpf: Classify kfunc arguments the verifier ignores
Date: Fri, 11 Sep 2026 15:03:59 -0700
Message-ID: <20260911220415.1396439-8-ameryhung@gmail.com>
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

The verifier does not inspect __ign arguments or implicit arguments,
except that bpf_prog_aux is handled specially. get_kfunc_arg_type()
leaves the ignored arguments unclassified, so gen_kfunc_arg_proto()
skips them and check_kfunc_args() repeats the same BTF predicates for
every call.

Add ARG_IGNORE and classify ignored arguments in get_kfunc_arg_type().
The generated prototype can then record them, and the call site can
consume the recorded type without deriving the classification again.
Keep bpf_prog_aux on its existing BTF-based path for now.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ebfdf9d209f3..54af5562ec95 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -923,6 +923,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
 	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
 	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
+	ARG_IGNORE,		/* argument the verifier does not check at all */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dc849e670876..09e96d04801d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8838,6 +8838,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 key_size;
 	int err = 0;
 
+	if (arg_type == ARG_IGNORE)
+		return 0;
+
 	if (regno >= 0) {
 		err = check_reg_arg(env, regno, SRC_OP);
 		if (err)
@@ -12140,6 +12143,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	const char *ref_tname = NULL;
 	int arg_type;
 
+	if (is_kfunc_arg_ignore(meta->btf, &args[arg]) || is_kfunc_arg_implicit(meta, arg))
+		return ARG_IGNORE;
+
 	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
 
 	/* Scalar arguments are classified from their BTF suffix/name alone. */
@@ -12269,7 +12275,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			       struct bpf_func_proto *proto)
 {
-	const struct btf *btf = meta->btf;
 	const struct btf_param *args;
 	u32 i, nargs;
 	int arg_type;
@@ -12288,9 +12293,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 	}
 
 	for (i = 0; i < nargs; i++) {
-		if (is_kfunc_arg_prog_aux(btf, &args[i]) ||
-		    is_kfunc_arg_ignore(btf, &args[i]) ||
-		    is_kfunc_arg_implicit(meta, i))
+		if (is_kfunc_arg_prog_aux(meta->btf, &args[i]))
 			continue;
 
 		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
@@ -12911,7 +12914,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			continue;
 		}
 
-		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
+		if (arg_type == ARG_IGNORE)
 			continue;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
-- 
2.52.0

