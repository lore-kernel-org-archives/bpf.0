Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B63BB69F
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621626; cv=none; b=FvWKDkWhGYGSWpHJo/do0PZVGMoRpNSerOeaVZK/bDQuOsvMnCyPHw08rnEOYMd8uDg1FizYYMzvqAP453PY6ONlTa+SXCvPXipSRjDWmIAv4Hm3FTMuQmHk1lKXX1+vl8MQeVo0H40S07N9h+iSTaMYKhzZ6DOBYdfED4Ax7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621626; c=relaxed/simple;
	bh=desD+43C1PhUdjl2w2Y6FmgxTmE40FzJK1s8I2enDdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5LT4gd/xDxZ17jx/dtz4pPDxLSr/Ur1TObDtDd7SZaA5hQWHQ7paJXCi0hi0Bm3ewG/Fl17ARmdNyjfzrRaTzPZWDntHXqIJP9UtRDU7zFv6RnJjSigoxw75K8A6f3u+0nBi+btriCfIusqjXHQuM2zW69GsFc5r4iPckS7cH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV9Ev/4L; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV9Ev/4L"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81adacb0f81so137216a34.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621619; x=1791226419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRvmLUYXSHhrKKbNpnHm3Xe1G4IhWMh5xwZQbOJaOJU=;
        b=bV9Ev/4LqFS0XPgKPbQjcxQqMl3hE4XmgH2akmreruCuY1NXeSgTv/PG235YmaSa7V
         uOgetwzyaiY7a++w0Nm7VoOGNMiLG+SC2RRJLVNLkNzLM9KETzbK+uRqqMLdfVGreQBG
         oV81f7B7FD1OkphY4zS3U1lfnbgCNCJW3J8zXhjalN6Z5fFopKkJ9CijDbxLtR9Dc1zH
         N7pcAD5sKRBTasFPdZ6KdT9Em6+QXedttr5DnEIfnS9C/VKw6v049q7JxPjj9STIRtBP
         B5NH9QJ322Y8oBF2uYkiTufkgEKp8ljxKMQMLEP5r7bihKGKgAiT3JJM/BVAWR8Chget
         ZIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621619; x=1791226419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRvmLUYXSHhrKKbNpnHm3Xe1G4IhWMh5xwZQbOJaOJU=;
        b=Z4ADTMjiORHBW/HX6Ga2h8DbluXcOmgxXgAArqjNT0NnIPPPWG/yYX7rxHATYlCDQZ
         /3iZGJpqPlXFX+4zYmuBHRjrhFY8FbLVWImbU6OkVTn8/yBNoSUpeOt5Vy+FVGmDV0Bw
         d/YvoW1sDzBGCZDIH7ZaapssU/+SP5XLAF3WxLhWSvva8mPOraOUhPvrBaxambD8TaCY
         X/KZwMGwrSMnTV0VWymOvOfShqicGw0PSM39qefnRfoO1/Hr0s6M6I7MS07j/TH0zGkI
         GtaV0DPfDpxPez41wm3ZaisSRxATIe/mm+UNKB5y+fmprz5sGGP9mBvMNMgoq9YeuIXU
         r6RA==
X-Gm-Message-State: AFuF++lNQB0OKYO8/AjiLpmdf4AQPi21FjTfT+jj9dUEqLxturLzAF67
	/LUSt9jPdNk50sMfaNMjVQs1BbTZdb+ZekG8ynw+G5LcjdI8punrTDM8XcWBqQ==
X-Gm-Gg: AYBFou3UrD1gbBEuvfmvnm5m6qVxPPQEjcz+MdK5cDWdEo9ndB2r7GJsZMx7KEr69aK
	p0OFQacmLT6GcWeSy1NgZEZkzuFrTXrNz2QF2RV3B7Sq6c2nLNn1692Nu+txiGOG8RPxQD22b7i
	Mq+F5tLBC1LD+XOlC4pByBCklMuYQPyCRU6Q6iguip4rIiI4FDGwqbjiPGidtsFEZpoe3khLw0E
	rOADxcc9uWya9bZtxFFMnhxyoMWyq/Yxo8GCeiLhJfjBz2snlFQvRgOLhVXP8ayBEpQlAs96/77
	DDbaPiZl6SwuX+UA/hFAfJN/h1b9kUYF1PNBcHzF3QpHwSFcFFM2YGnTUaTilLx1iDUCqF0nevD
	JC2Dvx9+crHIV1s07cG/SZI1O0XkNii74RtIDJmkrRb1yqT97/Ffj4sNNliy7+G4U8TCo7O3kx2
	D5w/5zA87SB0XlaKejUFMdbqNqj59GB+573pRiZJ3AHHoZuRRi88XPzRFHd2Oa
X-Received: by 2002:a05:6830:6604:b0:81c:b7d6:e6e0 with SMTP id 46e09a7af769-81e758215c5mr137606a34.10.1790621619448;
        Mon, 28 Sep 2026 11:53:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d57ef2c07sm2193063a34.4.2026.09.28.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:39 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/11] bpf: Identify subprog calls in argument metadata
Date: Mon, 28 Sep 2026 11:53:25 -0700
Message-ID: <20260928185334.1004200-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare subprog calls to use the common check_func_args() path. That
checker distinguishes call kinds through bpf_call_arg_meta, but
btf_check_func_arg_match() leaves both BTF and the function ID zero even
though it validates a program-BTF signature.

Represent a subprog call with a non-NULL BTF and a zero function ID.
Define helpers as NULL BTF plus nonzero ID, and kfuncs as non-NULL BTF
plus nonzero ID. Requiring a nonzero kfunc ID also prevents unavailable
special-kfunc IDs from matching subprog metadata. The corresponding
subprog predicate is introduced later alongside its first use.

Setting BTF would expose checks that treat every BTF-backed call as a
kfunc. Restrict kfunc-only BTF parameter lookup, register admission,
release diagnostics, no-cast alias, and projection handling to actual
kfuncs.

The BTF is not modified here, but bpf_call_arg_meta::btf and several
downstream consumers use non-const pointers. Match those existing types
instead of broadening this series with a const-correctness cleanup.

No functional change is intended.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b54873c8b95e..de9276a3ee4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8639,18 +8639,27 @@ static bool arg_type_is_scalar(enum bpf_arg_type type)
 }
 
 /*
- * A kfunc is named by a BTF ID, which can take the same numeric value as an
- * enum bpf_func_id. Only test meta->func_id against a BPF_FUNC_* once the call
- * is known to be to a helper; meta->btf is set only for a kfunc.
+ * A helper has no BTF and a nonzero function ID. A kfunc has both, while a
+ * BPF subprogram has BTF and a zero function ID.
  */
+static bool is_helper(const struct bpf_call_arg_meta *meta)
+{
+	return !meta->btf && meta->func_id;
+}
+
 static bool is_helper_call(const struct bpf_call_arg_meta *meta, enum bpf_func_id func_id)
 {
-	return !meta->btf && meta->func_id == func_id;
+	return is_helper(meta) && meta->func_id == func_id;
+}
+
+static bool is_kfunc(const struct bpf_call_arg_meta *meta)
+{
+	return meta->btf && meta->func_id;
 }
 
 static bool is_kfunc_call(const struct bpf_call_arg_meta *meta, u32 btf_id)
 {
-	return meta->btf && meta->func_id == btf_id;
+	return is_kfunc(meta) && meta->func_id == btf_id;
 }
 
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
@@ -8963,7 +8972,7 @@ static int check_func_arg_release(struct bpf_verifier_env *env, struct bpf_reg_s
 	verbose(env, "release function %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 		meta->func_name, reg_arg_name(env, argno));
 
-	if (meta->btf) {
+	if (is_kfunc(meta)) {
 		const struct btf_param *btf_arg;
 		const struct btf_type *t;
 		u32 ref_id;
@@ -9017,7 +9026,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		verifier_bug(env, "unsupported arg type %d", arg_type);
 		return -EFAULT;
 	}
-	if (meta->btf && base_type(arg_type) == ARG_PTR_TO_BTF_ID &&
+	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_BTF_ID &&
 	    (base_type(type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(type)]))
 		goto found;
 
@@ -9040,7 +9049,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 	/* Allow allocated memory for kfunc ARG_PTR_TO_MEM but not helper. */
-	if (meta->btf && base_type(arg_type) == ARG_PTR_TO_MEM &&
+	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
 	    type_is_ptr_alloc_obj(type))
 		type = PTR_TO_MEM;
 
@@ -9363,7 +9372,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
 {
-	const struct btf_param *btf_arg = meta->btf ? &btf_params(meta->func_proto)[arg] : NULL;
+	const struct btf_param *btf_arg = is_kfunc(meta) ?
+					  &btf_params(meta->func_proto)[arg] : NULL;
 	const struct bpf_func_proto *fn = meta->fn;
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_reg_state *regs = cur_regs(env);
@@ -10789,7 +10799,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 }
 
 static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
-				    const struct btf *btf,
+				    struct btf *btf,
 				    struct bpf_reg_state *regs)
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
@@ -10801,8 +10811,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	u32 i;
 	int ret, err;
 
-	/* Leave btf and func_id zero: this is neither a helper nor a kfunc. */
 	memset(&meta, 0, sizeof(meta));
+	meta.btf = btf;
 	meta.func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
@@ -13783,7 +13793,7 @@ static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_re
 	 * resolve types.
 	 */
 	if ((arg_type_is_release(arg_type) && !is_helper_call(meta, BPF_FUNC_sk_release)) ||
-	    (meta->btf && btf_type_ids_nocast_alias(&env->log, reg_btf, reg_btf_id,
+	    (is_kfunc(meta) && btf_type_ids_nocast_alias(&env->log, reg_btf, reg_btf_id,
 						    arg_btf, arg_btf_id)))
 		strict_type_match = true;
 
@@ -13800,7 +13810,7 @@ static int process_arg_ptr_to_btf_id(struct bpf_verifier_env *env, struct bpf_re
 	 * actually use it -- it must cast to the underlying type. So we allow
 	 * caller to pass in the underlying type.
 	 */
-	taking_projection = meta->btf && btf_is_projection_of(arg_tname, reg_tname);
+	taking_projection = is_kfunc(meta) && btf_is_projection_of(arg_tname, reg_tname);
 	if (!taking_projection && !struct_same) {
 		verbose(env, "%s %s expected pointer to %s %s but %s has a pointer to %s %s\n",
 			meta->func_name, reg_arg_name(env, argno),
-- 
2.52.0

