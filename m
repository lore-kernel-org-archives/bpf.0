Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935413B811F
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621625; cv=none; b=gPw9Qbyn+wDmMeMxY3V5z4MjxOdhYzUMR+Q3smuV+fYZM5CeiF+EvS+E5C9tywyIUhpX2/dGJUUBTCfEPg3RvGAtFzvNiyfsLGLzpfGMa98hKhEm1io1Re6p8r3SWeBaFmotRbVoQD6G3B3epxXlf7tAbhLKCUxzSEju4UWnQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621625; c=relaxed/simple;
	bh=ZrYxXC7Age+fMMC6oGl9bkQoaXNRLMqg80s2iujtqJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKnjqdpN5Iv5Z7IvXo+2B5q7qzXSosA8sGzUz3JXXae6JdlQ95Ho058/TFrtYgtbzvAtMv3VCXgDZILlW7CCC6G4vAWaEkxeXQLpvSLZdvFnDOWfYxrIRhr7P2tkfB706CS3QO1BlaH5Iombv07s1DzI78Nsf9FETwB6zzez7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rchnXMZh; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rchnXMZh"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b15bca7e0so1507789a34.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621618; x=1791226418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmmihtK/i1alxH9W9Ha9nPgDqdToxZnnRPtZQ3TEPhI=;
        b=rchnXMZh5iz1Kf6rXirNhEj2kKcix1YH+m0TwqVE+zsConNIN4Ohh1reh2EhNlGbXG
         8EO6Rj9Q91We57V6PeNUARWaX/HHDIW3+tX4iKnLQ3oSTbQMGfKn5cOBW1eGBvBqBc3n
         C83zsCdeldg2kxSFxP9AH11PGMk4gk/BpcfPv3B2FsxWVGfUPsaOjG4ub8au/A2uXCED
         qFtoBSkFhyTKlR14NDHPil2kisIDjjTJWkRwrle1ZcgH5nqQUwxA1MmWARDQXF4xwreU
         9h53N/WMR3OaUCx5gUJSdzJKyftAD4c48BItPiiR5ibBXJJgvMbxjNhZQoIFuPuqh7VB
         0vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621618; x=1791226418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lmmihtK/i1alxH9W9Ha9nPgDqdToxZnnRPtZQ3TEPhI=;
        b=XjcSXqj4+K4SE1Ipro8GcY34VZNnm7bU5B5eTKGLka1azy2l3irWkQ0SiFpE7u+38T
         8ITU1SOgR6lcb2YKlM0I6loBSjB31Otdu5R7fhiuEyXXHzAJy0I5Vh3x6hvP2/j0SS5t
         OVffLVPE6Eylq+5Zt87VcI4DIsQel7+rsnqzoCql1epsS+lCxIx+DZbnNSVJNbQHLTuW
         D4Y4qC4dfCZnUsbOc/l3NN8/oQq/1j268QQ/EMcyJSoaNzrQgzK3t/LACxoMdbBz2SZi
         AciPL3Fdf/B7jNHjBQ6CU3pFcLn5PJ1nmzbmNVzNf8z4CfAeBH3zKukXhzgsaxaySw2i
         mPaA==
X-Gm-Message-State: AFuF++nDLr+bz//HVxIhu+5am3Jq6gIUGiOCt20uhuyW9ipin4m0MP55
	6mV+KulOqHl59JryokrCYDxDu7k4GKyTIlZ2p4/Mxsf1aPO86LGY/gWFKVD5bA==
X-Gm-Gg: AYBFou3IQOPUMecJhtelI0tSfwMQyu7BF7ccwUHYNj11HY+AcoGuzX3L4e3FjKQU3+u
	0uqS63BC2VTwjkkzOw8/ApX31ameFuox5BWT/TA26QHH8+Q9jNGrxYzlb8E0NGMKvfwRtec8/QR
	KOAX04bKMgaT7hLQgc1AVUTMuZ81jN9BRqH1ohZhLUH5xWvOU5a1BMJHAC8CS4YmB3v3Bh7W6Zs
	Bpfk/g4/Hhp8EotosBhX3sEkdZlFgmh/PfSh7e/MZjYVT0PS1BVMob6hTd8AaFjyv9X9Vwmpvr3
	QMwkgK88tJBNavg3GhQE7XFgqYBiBXcIoDmYtXWqzP92gujOJkn6ytE3qVi4H4mEBffrakrQ3pg
	WBL+cEiDfPDI09D7GuqVC76s26+WfD5ODhxkEyyqSEpvYDMOmkrNKajcnGZmhqLxTfhtfDToGtt
	5P28NWOP6aTClIVpkb2HtJAlVmtyb8+VZhk5qR6huXd5avRWNOSsnDC+O7Z98d8w==
X-Received: by 2002:a05:6808:508d:b0:4b9:a829:f00f with SMTP id 5614622812f47-4d72ca3b377mr15809669b6e.27.1790621618032;
        Mon, 28 Sep 2026 11:53:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbd25cf71sm2314994b6e.16.2026.09.28.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:37 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/11] bpf: Fix kfunc BTF parameter lookups after wide arguments
Date: Mon, 28 Sep 2026 11:53:24 -0700
Message-ID: <20260928185334.1004200-2-ameryhung@gmail.com>
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
index 03dbc0e00398..b54873c8b95e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8264,12 +8264,12 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
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
@@ -8289,7 +8289,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	 * to any kfunc, if arg has "__iter" suffix, we need to be a bit more
 	 * conservative here.
 	 */
-	btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, arg_idx);
+	btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, arg);
 	if (btf_id < 0) {
 		verbose(env, "expected valid iter pointer as %s\n",
 			reg_arg_name(env, argno));
@@ -8920,7 +8920,7 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
 }
 
 static int check_func_arg_nullability(struct bpf_verifier_env *env,
-				      struct bpf_reg_state *reg, argno_t argno,
+				      struct bpf_reg_state *reg, u32 arg, argno_t argno,
 				      enum bpf_arg_type arg_type,
 				      struct bpf_call_arg_meta *meta, int insn_idx)
 {
@@ -8933,7 +8933,7 @@ static int check_func_arg_nullability(struct bpf_verifier_env *env,
 	if (meta->btf) {
 		u32 arg_btf_id;
 
-		arg_btf_id = btf_params(meta->func_proto)[arg_idx_from_argno(argno)].type;
+		arg_btf_id = btf_params(meta->func_proto)[arg].type;
 		expected_type = bpf_diag_fmt(env, "value of type %s",
 					     bpf_diag_fmt_btf_type(env, meta->btf, arg_btf_id));
 	}
@@ -8948,7 +8948,7 @@ static int check_func_arg_nullability(struct bpf_verifier_env *env,
 }
 
 static int check_func_arg_release(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				  argno_t argno, enum bpf_arg_type arg_type,
+				  u32 arg, argno_t argno, enum bpf_arg_type arg_type,
 				  struct bpf_call_arg_meta *meta, int insn_idx)
 {
 	const char *expected_type = "pointer";
@@ -8968,7 +8968,7 @@ static int check_func_arg_release(struct bpf_verifier_env *env, struct bpf_reg_s
 		const struct btf_type *t;
 		u32 ref_id;
 
-		btf_arg = &btf_params(meta->func_proto)[arg_idx_from_argno(argno)];
+		btf_arg = &btf_params(meta->func_proto)[arg];
 		ref_id = btf_arg->type;
 		t = btf_type_skip_modifiers(meta->btf, btf_arg->type, NULL);
 		if (btf_type_is_ptr(t))
@@ -9413,7 +9413,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		return 0;
 	}
 
-	err = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
+	err = check_func_arg_nullability(env, reg, arg, argno, arg_type, meta, insn_idx);
 	if (err)
 		return err;
 
@@ -9425,7 +9425,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
-	err = check_func_arg_release(env, reg, argno, arg_type, meta, insn_idx);
+	err = check_func_arg_release(env, reg, arg, argno, arg_type, meta, insn_idx);
 	if (err)
 		return err;
 
@@ -9759,7 +9759,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
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

