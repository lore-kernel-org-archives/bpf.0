Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A637DEBE
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619259; cv=none; b=uwDhlq8eZpg9w5BUPi8f8DctMfcGmnyHk3JNqHpLPRJHQLK9Y9n9M6x2hi4kUI1Eflwbh4yJ1scFZfvOMsNXoWFdbKJIGgaOtaZHrD30lVYvUj9krOfr4F0BwQhJQHhxVU3f2mx+NNOh18xuiGqcDvE9fR92RTjhSexY1SujcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619259; c=relaxed/simple;
	bh=PmDm8NrWxnRNhTgWYvuFUwAl0LMBkAc2mM4U/HWfLOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGKyRw+AJr8BkzTS1ynWvHUiTJlRZIO7I25o8bH8ykTJewFrrjbYfGEAOUnyAHe0Fq02dK1IcsLo5Rqg4YnEhHUlj7g6oB5Q17fcmXofNJTRBYCxqho7sLI+cgQgpc2RiplsQBnAnZ1e7ZGtTZurdCgCNNBH9c12Tsev6Ibuzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLW1Paw8; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLW1Paw8"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-7f4f0d1779dso2741103a34.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619256; x=1791224056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJ3YL7MLj7/AVgphAU8y0p3oSWsXDfQBZHEXpkUwD/U=;
        b=jLW1Paw8/zTF/BNsdbF2F1pJUKXgDcYkX6WnlSA+m2S8J95lnXB9cUVnszpJFH2sbn
         CJgFYHixUk1KZe0RBMy8uu5IJv4nXbKfO/ugU5Eo+NNjyE3E1M3p0IHv2vYoI5dLSbfC
         98Ot05qya4qvxeFTA4kYU0WS8J048SM+taOaZA255/jZXrhsRcbRB86dIqOdCxNjAAJf
         4li1t5HUKyFarA/5leEUCyUghri2INovSVY7fwMQc2a8XW/ggoBthM+Ssa3YExB6j1I1
         XFuDA4pwrcC4Km3Fmk7MKBfI0m3xIwu/gyLiS15AbSDAkI4T/E0J8lukZ4t1Hsn5eZS3
         wNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619256; x=1791224056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJ3YL7MLj7/AVgphAU8y0p3oSWsXDfQBZHEXpkUwD/U=;
        b=giT8Z+Fbv9F4XlsdGwX/SUQdgAjyGtYKPtHMSSRbFTgcZmernojpb51kB5PQqFkL5K
         66XE0060Fwf5GtzReZRLPefNKyJhO4QB+itx6aXirjKWddK6gHtJ2/DQ1IK14rI8UyGl
         uzofB48ZL0jjbBYUn5QVi7Yrjso88uEf1EmhQLNoVh4k4CKuXkzJDFWJiFaEDCznO7WO
         2MOUB5F65aDiS+S0iq4nQA4lLTSsa7qp9ON7hLGDBLtYn1SY++ZTBqe5iV8vtYOmpOzK
         cCAyW/vl9YNFSDlfH86w4ISzl7zvxF633YWeU+q05WGC3mStjiqGCJoaU7i7Y5/T74k8
         /weQ==
X-Gm-Message-State: AFuF++nEBsFBgrx5hvCS9b+I5NxHjkKqIZjj+iOd8R08YHTojq/n7HvT
	KFet+1W1l0SHv5EAdRyJq6vuEWVko097oJmS+7usk7j/Om+l+FnMdLwg5aRM8w==
X-Gm-Gg: AYBFou0B49Z7833XZ+/9erAa5tHGdLs8rCzv7m6j7u4Ft5CjPe6LFcSbL6GlJQUSWvP
	/GeihRElRXmjh27/h/teAn67zzqUf0fjwgs9HXtnqY0+PiT+ZfPRPu6M7Uri2FByKDdcINTW3mf
	JSeFVGWAFI0VrmP5yh7eKjoZ7fwP0iISewP5mo7aWZu5/zNKFU/mf84KeY7cyLhfkP4gK3trSEv
	Xz2lgy56TNe1d+lfVchHhnkl/5PfWyXhhohYWVNk2RLUebrugfrKb3PUOPhCDkkMATz5czWne9u
	o15xGMjjjpD6sLtq0h/xVOSSD0za5Z1mUhPh2SDW/7iRexiq+juyfiwf5UnUv65rD+DKg5xuS2J
	ovksiZiiXXQb+N5DeeTuov6eT46ID8al0H3kyloq7oXg/3igL5T3FRalJ4UwEKEDvPf+2hur/ZA
	iq2UYcY1X4t6H6OkUz1mHovEZY7eSBtfTlLeV6xh0O8SnSwqTGhgn+RrFk76xTtw==
X-Received: by 2002:a05:6830:61c7:b0:806:23ea:25b6 with SMTP id 46e09a7af769-8177fba95aamr15600932a34.2.1790619256610;
        Mon, 28 Sep 2026 11:14:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d58b094fesm2178686a34.20.2026.09.28.11.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 01/11] bpf: Fix kfunc BTF parameter lookups after wide arguments
Date: Mon, 28 Sep 2026 11:14:03 -0700
Message-ID: <20260928181414.644158-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several kfunc argument checks index BTF parameters using the ABI slot
number. Parameter and slot indexes diverge after a by-value argument
wider than one eightbyte, so a later argument can select the wrong BTF
parameter or index past the end of the function prototype.

This affects the BTF lookups in check_func_arg_nullability() and
check_func_arg_release(), and the parameter passed to
btf_check_iter_arg() by process_iter_arg().

check_func_arg() already tracks the BTF parameter and ABI slot
separately. Pass the parameter index to all three consumers while
retaining argno for register and stack-slot diagnostics.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c8626215ee6..a57acef6a9e9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8263,12 +8263,12 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 	return btf_param_match_suffix(meta->btf, arg, "__iter");
 }
 
-static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
+static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			    u32 arg, argno_t argno, int insn_idx,
 			    struct bpf_call_arg_meta *meta)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
-	u32 arg_idx = arg_idx_from_argno(argno);
 	int spi, err, i, nr_slots, btf_id;
 
 	if (reg->type != PTR_TO_STACK) {
@@ -8288,7 +8288,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	 * to any kfunc, if arg has "__iter" suffix, we need to be a bit more
 	 * conservative here.
 	 */
-	btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, arg_idx);
+	btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, arg);
 	if (btf_id < 0) {
 		verbose(env, "expected valid iter pointer as %s\n",
 			reg_arg_name(env, argno));
@@ -8919,7 +8919,7 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
 }
 
 static int check_func_arg_nullability(struct bpf_verifier_env *env,
-				      struct bpf_reg_state *reg, argno_t argno,
+				      struct bpf_reg_state *reg, u32 arg, argno_t argno,
 				      enum bpf_arg_type arg_type,
 				      struct bpf_call_arg_meta *meta, int insn_idx)
 {
@@ -8932,7 +8932,7 @@ static int check_func_arg_nullability(struct bpf_verifier_env *env,
 	if (meta->btf) {
 		u32 arg_btf_id;
 
-		arg_btf_id = btf_params(meta->func_proto)[arg_idx_from_argno(argno)].type;
+		arg_btf_id = btf_params(meta->func_proto)[arg].type;
 		expected_type = bpf_diag_fmt(env, "value of type %s",
 					     bpf_diag_fmt_btf_type(env, meta->btf, arg_btf_id));
 	}
@@ -8947,7 +8947,7 @@ static int check_func_arg_nullability(struct bpf_verifier_env *env,
 }
 
 static int check_func_arg_release(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				  argno_t argno, enum bpf_arg_type arg_type,
+				  u32 arg, argno_t argno, enum bpf_arg_type arg_type,
 				  struct bpf_call_arg_meta *meta, int insn_idx)
 {
 	const char *expected_type = "pointer";
@@ -8967,7 +8967,7 @@ static int check_func_arg_release(struct bpf_verifier_env *env, struct bpf_reg_s
 		const struct btf_type *t;
 		u32 ref_id;
 
-		btf_arg = &btf_params(meta->func_proto)[arg_idx_from_argno(argno)];
+		btf_arg = &btf_params(meta->func_proto)[arg];
 		ref_id = btf_arg->type;
 		t = btf_type_skip_modifiers(meta->btf, btf_arg->type, NULL);
 		if (btf_type_is_ptr(t))
@@ -9412,7 +9412,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		return 0;
 	}
 
-	err = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
+	err = check_func_arg_nullability(env, reg, arg, argno, arg_type, meta, insn_idx);
 	if (err)
 		return err;
 
@@ -9424,7 +9424,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
-	err = check_func_arg_release(env, reg, argno, arg_type, meta, insn_idx);
+	err = check_func_arg_release(env, reg, arg, argno, arg_type, meta, insn_idx);
 	if (err)
 		return err;
 
@@ -9758,7 +9758,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
 			return -EINVAL;
 		}
-		err = process_iter_arg(env, reg, argno, insn_idx, meta);
+		err = process_iter_arg(env, reg, arg, argno, insn_idx, meta);
 		if (err < 0)
 			return err;
 		break;
-- 
2.52.0

