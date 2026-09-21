Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2843191BA
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958332; cv=none; b=erbhRAX1Y1h0g+LuEKbQldmWi63iVWv+0oTJP4h+9xgHyAq3ZUn9pHQSkJriiOsR0TmFVPFAR8rbE8L5RfVbQhHTyDAUiqazJZlQydCZ9zfejDIlDFg3cYe2wM+R276uW1vTDMWbpPSv5qYjjtoCwKlZUf3NtMu8aePDEL1sN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958332; c=relaxed/simple;
	bh=gJayH6BwxtQUwAySqBBGerWwBKscFXhaKu+WnAWjDbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sptO3jJFpTgevqjvE6KuBXl/sBBDVZ90KToVo7xzOKUeeEQrVGBuDS7ParJkGB45N0CotnzNDl392FYiEHinTiNhGxBgMFqtPobixpCBxtGGHQu3Lf4/bs2C0NM5IWGIws6vF/M0kr+TcQ3J5g7vfSanZLHXqLQeT+XOtgLTLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOxlzXYe; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOxlzXYe"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so891896f8f.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958328; x=1790563128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MDAX90bCoGpk9SV57WGrKBzGBCd8q+YB79RHhrCfan0=;
        b=YOxlzXYeuToayXJ6tnVk61w0tbeY9RRYJOUXzkEVeS+iN7bG3laHTcVFL67BsaZx9g
         MbFFrC1S3RmktEAFihex/nNebe9CpUvXivd5pyv/boKCvxh2cyOldW5AKfWgqSXkQhD5
         cII8+wNpyMoOBOUuhV0J3OhZ/fbaZFsGd3dlNQHcy574JXlqvPCb2h1hJSWlFU0rBg9n
         58xfwwXNaRaTuMNSFsVGOCuyo9fQxov6OS9p93vWvjpHq6y027PbywGBHqVfDExivYIt
         dGsVXWFc0/fZT3XEGfH7d0iicGkOwNayHJZu/B8dmf2rO0hCRGT2WKLqL32MPyLu0f3P
         NBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958328; x=1790563128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MDAX90bCoGpk9SV57WGrKBzGBCd8q+YB79RHhrCfan0=;
        b=W5DH4lDzyoV4qW1RXH4EZV/lxelgwQj9lXjvInlQ8V9CRu09ZK9ltrHLRElKSJJajH
         xRO4dnMphTjgnBb1e62FQk7h8wVMT9lqNzyuKrFklxS2V4aFKwhOgjZ6MKpAgN2USVym
         e8+2AxMYY4N0fCGsmJ6dJm+8+pa8SSLDzAfJz1K08U/6OSqhzvnyT5bXyYVvOuE0wdjX
         lOvw8pFFjkZmhtB2NNqCbVKq5QYaXxXIVU3hqTzPsHPERsIJZjNz5FpGR26/m5UcAYq8
         LktoeqJwTfRCOiJMMBQfmUlyJbuE291X4iWKJh5JxxPN0rlkwOnwqSUOFmjh5A+W1NP1
         YGQw==
X-Gm-Message-State: AFuF++nCgK+vXMmKowC0qUMKKVWvk0f6JSYhSKhNHm4fZw9Nlurk5cMx
	HhxT9Dx1OxMkHWLUO8Yh1uRvrvf5rbKXBNJKP8aa+rjWINCpfRRqBH0PibzxQYX1
X-Gm-Gg: AYBFou0QGxPBNG31gsi1s6C29yEkABqf8kNxjtuVvIXVIq17KUhgazOXUOqz0ilkT86
	rV4wgAWG+7o1yvoQWh/933dFikNRow2KjEnfZDhz/km+4hOyYrQVTfqK5prmiHLgQxgkqBcIets
	iVQr9O8WarJPzwXav7u2JQwOX4ZhSIhUh7AszmObSxNngViQJ5W6gf/VU53Dqm31Z+fmX7LVclN
	VSW6g7X2o/dyq4Y91UGQGdB4QF0+29j+t/hPdbH4KAH2V4kmPKDvfpVrLUc0ukXMxSdFcejRgce
	AlbzmMZIytkNOj6Zi1/C9GXzGos+stJMkqy7SRRbdFqhxjW7OP1V0iGlf4p19cFVueqmYe9JX+l
	3YNVBicbseLSobzvew4avPDi2aBh5Uuvn9s4I12ohWdhFTqBgip4G02is6xSerjUD0z+CbsubhS
	EPeCfUXOUW+M7qKnRBWA2LnEs1qkcTP61u9QySjovRt7VxL5JoKmmzL966i515HVffAdZJXzCHp
	a9C1Mj5hCQsgcHfR6P7OCiuwjnUqPsd3zPAdwqwvcVEnCrnfotStPF51kAM+lFH85o9CLh23A/a
	qkS4M6/fasoon7ewRrRsbd35Jzh9UzjhgI8YMJq00buEzhs2
X-Received: by 2002:a05:600c:34c4:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fce783626mr73443475e9.21.1789958328491;
        Sun, 20 Sep 2026 19:38:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm198572365e9.3.2026.09.20.19.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 02/11] bpf: Record raw memory arguments during argument checking
Date: Mon, 21 Sep 2026 04:38:26 +0200
Message-ID: <20260921023843.411943-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4263; i=memxor@gmail.com; h=from:subject; bh=85DLJMAWeWqCqayBPZRCk3+FPJ6HyV2tZD9+FlEQY6g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9E1ednJp3gsY6l1lP/s9b10iGFTQM6Nzm7fHTa6gJ xoC92Z3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCI9PxkZbj2oyL15venvzmtv z/HbneILe7LQsOX7O/dd7H2PWx0CQxgZDu/2lJ5ZYxHGba9eUMz75V6cXLmueOnSy3ciPT2Vk1+ xAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Record raw outputs in check_func_arg() after resolving their memory type,
instead of pre-recording them in check_raw_mode_ok(). Keep prototype
validation separate from per-call output tracking so kfuncs can share the
latter in a following patch.

For bpf_strtol(), bpf_strtoul() and bpf_kallsyms_lookup_name(), a variable-size
input is checked before the arg4 output. Recording outputs as their arguments
are checked prevents that input from clearing the output's raw mode early.
Only clear raw mode when a variable size belongs to the recorded output:
an unrelated later input must also preserve an earlier output descriptor.

For bpf_map_peek_elem() on a bloom filter, type resolution removes MEM_UNINIT
and MEM_WRITE because the value is an input. Recording the resolved type makes
the later bloom-filter-specific raw-mode reset unnecessary. Reuse the same
raw-memory predicate for output recording and prototype validation.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18aad4886f9c..67c1abfde922 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7217,12 +7217,13 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 */
 	meta->msize_max_value = reg_umax(size_reg);
 
-	/* The register is SCALAR_VALUE; the access check happens using
-	 * its boundaries. For unprivileged variable accesses, disable
-	 * raw mode so that the program is required to initialize all
-	 * the memory that the helper could just partially fill up.
+	/*
+	 * A variable size does not guarantee that the call initializes the whole
+	 * checked range. Disable raw mode for this output and apply the ordinary
+	 * stack initialization checks, including their privilege exceptions.
 	 */
-	if (!tnum_is_const(size_reg->var_off))
+	if (!tnum_is_const(size_reg->var_off) &&
+	    meta->arg_raw_mem.regno == reg_from_argno(mem_argno))
 		meta->arg_raw_mem.regno = 0;
 
 	if (reg_smin(size_reg) < 0) {
@@ -8940,6 +8941,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
+	if (!meta->btf && arg_type_is_raw_mem(arg_type))
+		meta->arg_raw_mem.regno = slot + 1;
+
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		err = mark_arg_precision(env, argno);
 		if (err)
@@ -9029,14 +9033,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			return -EFAULT;
 		}
 
-		/*
-		 * Disable raw mode for bpf_map_peek_elem() on a bloom filter. The helper reads
-		 * the value buffer as an input rather than filling it.
-		 */
-		if (is_helper_call(meta, BPF_FUNC_map_peek_elem) &&
-		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
-			meta->arg_raw_mem.regno = 0;
-
 		err = check_helper_mem_access(env, reg, argno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta, NULL);
@@ -9860,8 +9856,9 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
-static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
+static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
 {
+	bool seen = false;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
@@ -9869,9 +9866,9 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
-		if (meta->arg_raw_mem.regno)
+		if (seen)
 			return false;
-		meta->arg_raw_mem.regno = i + 1;
+		seen = true;
 	}
 
 	return true;
@@ -10003,7 +10000,7 @@ static int check_func_proto(struct bpf_verifier_env *env, const struct bpf_func_
 			    struct bpf_call_arg_meta *meta)
 {
 	return check_arg_prog_aux(env, fn) &&
-	       check_raw_mode_ok(fn, meta) &&
+	       check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
-- 
2.53.0

