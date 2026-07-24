Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C044CACA
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920108; cv=none; b=J7AsmmlaLezTLRYJXzpMZA4l07Te3LaYw+dl/vtINEqzvMkb4krcXRAhgkkSkW5JVTzbpQRzqWhjvO6sHqnhEfGiVI9PILZPdl1Mt2RPbUzUbW/Ckoe8WZ8ZUmf5GBC/2QpP5Ic4xrAyo6N129AhOiioI/JFYH/5zc5xDxEaLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920108; c=relaxed/simple;
	bh=X+XmrKchswRg8lZas6drc7StoKyen0Br1WzMwBSyXKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+GrwOyartWKwXPw/ZnR3O+CFcLTDiaHj7DWWtjjhyS8Eg9OZwjC8efos91X9TOGNf9GZKfOxfdkGNrORZP6AFdLhUPtEQoCVCHQYuIZ1SwlPN3lciyrLFNewInWEZh54Wln9FI8W3ULWo0gd3aK5UxoGr2Fag+9hGnHLKiwl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXHGD9lG; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXHGD9lG"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso683284a12.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920106; x=1785524906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fvm3XXo5pA1B2iajhO2vQIF4mamfijGjWwewCrlEZ0s=;
        b=RXHGD9lGTyQtXz5HnG8/W9uGi/ssqSD+JDl89QMH1Pp569cQYq0QSeEns8QOFsAmy3
         ktAcYkJ8GEzrTkseeKmWH2HRwKd/rVpX3JZQmwaPJ/AbmzNOXHTYT1fL+qVEzoCTgtFg
         Kg5Hp1YKoGxXClrZGjjCVAr/SfgENJCZD9L4Z1x/VMOHm3pH/Up9MvKIEVrt0+tfFS+H
         CsCU3B8YZc0jYuqsXFn3i+IHKXWxi+jN6g74i5auHsyR5YnR6w5teVn3+lnxsA3hJ0XK
         15L9mQjpL9XWS2RsWcehoVrHRQJMah8XyNt5LrpiZxwwybFaQS1dQ0SltPLE6nnQAMrp
         q+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920106; x=1785524906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fvm3XXo5pA1B2iajhO2vQIF4mamfijGjWwewCrlEZ0s=;
        b=VAp4YL77D1zpMpe5+J2+ZBfhViqGti/AO6irdPPf80fLzv6H2dTXW9QVc85THLc8bW
         6tNdm6WxGrETkK/ZWaSQgjF95k+U5A9lq+BqeL/efz8PtENAdInVHkwISmRhsY2z+iu1
         Gh5qctTH8JEDUB0jJqb9tb++kvIY05jOvu2tzDk1yzQ++mBBlkHTngsEhbnjIM0yxcQj
         KztomJXelUnjP4Hi4ztH+9y8M+Pj9oBisQRBY4mFRdJ8LWf+2aKnF8Rc9EdjYBgjjwv4
         Mkp8nsJ7M9Onx7KbrxfV66VkopjA8J7ux1ea8R/W6Yqi4a9efATF7JWfKOrHSg8VCjeR
         CXlw==
X-Gm-Message-State: AOJu0Ywb6vi6/NS9xguzXwtU5wZ2TnlTJK9CMfO4glxHGXbIgKxnTzaH
	kcL3RXjAvdkU5e2jHOlrSA8zcIhESa00lHWxyzicChSMOTN/hv5T5ijoPiEdQA==
X-Gm-Gg: AR+sD13Lby2DcJH2zqcAGkJyfLh9KI9d+X+s9WwJ4+Druya9+NsVHDq349u8z+ItjJq
	2bYQOAMrp1xLZWyu5jll362uMmXnAVs2w+/aOiVtqAimbqsSvS7j5u+bnRPjGzsNQDgcEWSV9sL
	zU9k8q7XQ2OyE5Z/BRohk5R+ozgPZIwWDfzRyNa7rU+Vr1G3YbkGsE/exwby101E8uPFmq9xE7c
	d/m2NDHIBwgK8bydZZ2si6wZTeQ/KctC5pToQPE40nyUr6cUkOg9PkBfdv5ZWxSd4BmXjwZRUaK
	8YGpduhjskfK89UEwfjD9RGbR6Fl7xnwlJ/v+F0C6N/bO/+VZ95Y5XhYKOd2RIxMWjHhcLtMHph
	cjEgto9O2S5D8Yu0TOq3/2bE8cjDV7h8B3iB3OaKlqhDF3q0kxXUuRurkn3VCG+ZxAHOw
X-Received: by 2002:a05:6a20:72a2:b0:3bf:c49d:9183 with SMTP id adf61e73a8af0-3c44b21d79fmr8740333637.50.1784920106566;
        Fri, 24 Jul 2026 12:08:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660deeasm450434a12.3.2026.07.24.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 11/18] bpf: Classify kfunc mem_size args from BTF without register state
Date: Fri, 24 Jul 2026 12:08:05 -0700
Message-ID: <20260724190813.1458271-12-ameryhung@gmail.com>
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

check_kfunc_args() already makes sure a scalar value is passed to a
scalar kfunc argument. Drop the check in is_kfunc_arg_mem_size() and
is_kfunc_arg_const_mem_size() to further decouple
get_kfunc_ptr_arg_type() from register state (a prerequisite for
generating a helper-like prototype from kfunc's BTF).

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f8d40308317..f6b373630ca9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10795,26 +10795,24 @@ static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta)
 }
 
 static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+				  const struct btf_param *arg)
 {
 	const struct btf_type *t;
 
 	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+	if (!btf_type_is_scalar(t))
 		return false;
 
 	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
 static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
-					const struct btf_param *arg,
-					const struct bpf_reg_state *reg)
+					const struct btf_param *arg)
 {
 	const struct btf_type *t;
 
 	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+	if (!btf_type_is_scalar(t))
 		return false;
 
 	return btf_param_match_suffix(btf, arg, "__szk");
@@ -11348,7 +11346,7 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 }
 
 static enum kfunc_ptr_arg_type
-get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *caller,
+get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
@@ -11362,8 +11360,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *call
 		return KF_ARG_PTR_TO_CTX;
 
 	if (arg + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1], get_func_arg_reg(caller, regs, arg + 1)) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1], get_func_arg_reg(caller, regs, arg + 1))))
+	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
 		arg_mem_size = true;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -12094,7 +12092,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			}
 
 			if (is_kfunc_arg_constant(meta->btf, &args[i]) ||
-			    is_kfunc_arg_const_mem_size(meta->btf, &args[i], reg)) {
+			    is_kfunc_arg_const_mem_size(meta->btf, &args[i])) {
 				ret = process_const_arg(env, reg, argno, meta);
 				if (ret < 0)
 					return ret;
@@ -12139,7 +12137,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, caller, regs, meta, t, ref_t, ref_tname,
+		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno, reg);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
-- 
2.52.0

