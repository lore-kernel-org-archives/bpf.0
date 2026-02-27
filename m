Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1833F23DD
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207183; cv=none; b=MpUsInu+50DTApL+rypAszPPAdOdGyUrNH6ZhaXXFctPfi2BG1t4GYM/KJXwBZ1qBsd2AdgI4EYNwqhrSSBnAKNlY6CnCxseG/iJ9+rkBKx4avUVaPphirIwUcwvl2OztCghnvBzYFCrhTTvdRNLl0vrPOYsTRJiARV6x4NXSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207183; c=relaxed/simple;
	bh=su6cQ5ub3510LD8e5awI8NAL6FjlKiQne3U+9ns4/hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBmFS5p12SUm+QkWqzIRZy9Z+3+o0ZEvOO0afz2hK77MYCFjZKEMlJbNgAfFiuSgwc8eL4iDL5ll0aqAAnT6HK1kXvFYKZw/Y3zV6Auept17NDo4ea801MxQzeid8tps1+p18YO4K2Kg4IHns0pmWD8heLnCLPtVa8rkwQjmp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=N+lNEQGi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="N+lNEQGi"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3b3e643dso136253085a.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772207180; x=1772811980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTLVP+YXmjFL23LSdR4Smq0ffOdm6oO1sMtamyE0Li0=;
        b=N+lNEQGi3XkQ+ftXhUX+RSD+R23ykCeeMdPrMoVCYZb1Mtojk4Rl4VH9W81JP4xQOf
         StqrPHq8aMlrLGgHfA5GQacd9xfTvdZMmIrI/DEh6tQK0bDIzZdqYMn5ueJ172m8wxz8
         8CcSyMOk6Iua3Oo1761z+75JQxYSUPCv1DJ3ukXZ4VXcDyRJ3HSmIeDTTpzwwjKkf8to
         C6HBH8S5VWKaO+GepjPE0JG0J4duTQf0p8fcMXT7Xaqwk11KI/whu0Y+2qXdU7EYuRY5
         6Fst7Pap60BIyhvW0bCcgVd/zKh0T8p15gfq+LGoWUVAOiU3c4JmTREwMrSa0CIIkhHH
         68Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207180; x=1772811980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTLVP+YXmjFL23LSdR4Smq0ffOdm6oO1sMtamyE0Li0=;
        b=nKVetnEneV/GZ5CUtoJWBaaEf4vtyMaoaDkAvDquPU7nfh3W3imEB4oVK2NV9MXLNc
         HgGs53nZb6xJjxVBuxpAJ2qQwLijX3ichWrBYPDLsN9DUP4EfdG1lEUy+KWnJeh3Ae9a
         1migy5zUZQEuix4ekTx3aQz13wNw2V0J2II4OjRn8YwM3Dh+k6BjdGNJG1h0WvTFwfFh
         6Ouz43mwqqyuf5dqv2GwpDnh7SVi96L6D0ODq7i+emS5AUjk/pMxPsvJmLxxlh7J3aqp
         +I1o/LWWg4IlO9rVGEX1vgafG1qSzP/rmr+pDeGWwKX/zuaueELdwWfp8mwJywiEDqj7
         UOJg==
X-Gm-Message-State: AOJu0YyfmJt/6mQbDOeiMbOA7hrM7TBVi9K9INBDGC9J+BM/JFnX/p36
	ETAIjjTgYhWo4CkhjJFO8lEghsI018RlaMKaYvG11/AUBatKUw3eGPlfLO+WdsK93mcGYwDiNJx
	I+W0P1EI=
X-Gm-Gg: ATEYQzyux0bI7UmOcEBGBdj+vpwB5JXQE5DhfuJxGJbifyDCWTJ2bVJh2B+reLh7XBu
	8hh3nP/4dOPKsjPYavbWptX/Wt0nNJf/elHqRxmEIs6g/nxQE/sHCmI9K+nWGJx35Mda48HpUjQ
	+1GRDrY02miO6gHNE9jNQ5DRzAOKG2eOvaRfnthbngpMXKCSPr4WfC0Fk6fA2/VzTMLpF6Sj/m0
	sina2ZmbfQdVnHPGajIpki3KbMjtN3QjWT6dEPB94my7Brrq7wXmD5fWv6X+uL/X29//Ko4y9q/
	80XP1TYZObtHaatwO+yHyENh/Sc3aXXrcV1U+EVKG8dR0NTCYfzBODMofpx4Qe5Js//4KpQs1z1
	KZqBb50gBbZNx5TJsNc0oEHXHfD1qsYKlNFjoKWF6FJi0XMC5fh7Fqb/X8zZ1bJHk6bBbvWoLKw
	CIlESaIj/DXWV7Oe+lieGNAg==
X-Received: by 2002:a05:620a:4891:b0:8a3:90c:55fb with SMTP id af79cd13be357-8cbc8e8493fmr395563985a.20.1772207180204;
        Fri, 27 Feb 2026 07:46:20 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm544180385a.4.2026.02.27.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:46:19 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 1/5] bpf: Factor out program return value calculation
Date: Fri, 27 Feb 2026 10:46:12 -0500
Message-ID: <20260227154616.6846-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260227154616.6846-1-emil@etsalapatis.com>
References: <20260227154616.6846-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the return value range calculation logic in check_return_code
out of the function in preparation for separating the return value
validation logic for BPF_EXIT and bpf_throw().

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/verifier.c        | 225 +++++++++++++++++++----------------
 2 files changed, 126 insertions(+), 100 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ef8e45a362d9..0e639613d8cf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -266,6 +266,7 @@ struct bpf_reference_state {
 struct bpf_retval_range {
 	s32 minval;
 	s32 maxval;
+	bool return_32bit;
 };
 
 /* state of the program:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..6cf2270c343c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2925,7 +2925,11 @@ static void init_reg_state(struct bpf_verifier_env *env,
 
 static struct bpf_retval_range retval_range(s32 minval, s32 maxval)
 {
-	return (struct bpf_retval_range){ minval, maxval };
+	/* 
+	 * return_32bit is set to false by default and set explicitly
+	 * by the caller when necessary. 
+	 */
+	return (struct bpf_retval_range){ minval, maxval, false };
 }
 
 #define BPF_MAIN_FUNC (-1)
@@ -11146,10 +11150,9 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
 }
 
-static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg,
-				bool return_32bit)
+static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
 {
-	if (return_32bit)
+	if (range.return_32bit)
 		return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;
 	else
 		return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
@@ -11193,7 +11196,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return err;
 
 		/* enforce R0 return value range, and bpf_callback_t returns 64bit */
-		if (!retval_range_within(callee->callback_ret_range, r0, false)) {
+		if (!retval_range_within(callee->callback_ret_range, r0)) {
 			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
 					       "At callback return", "R0");
 			return -EINVAL;
@@ -17837,6 +17840,115 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
+
+static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+
+	/* Default return value range. */
+	*range = retval_range(0, 1);
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+		switch (env->prog->expected_attach_type) {
+		case BPF_CGROUP_UDP4_RECVMSG:
+		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
+		case BPF_CGROUP_INET4_GETPEERNAME:
+		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
+		case BPF_CGROUP_INET4_GETSOCKNAME:
+		case BPF_CGROUP_INET6_GETSOCKNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
+			*range = retval_range(1, 1);
+			break;
+		case BPF_CGROUP_INET4_BIND:
+		case BPF_CGROUP_INET6_BIND:
+			*range = retval_range(0, 3);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS)
+			*range = retval_range(0, 3);
+		break;
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_SOCK_OPS:
+	case BPF_PROG_TYPE_CGROUP_DEVICE:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		break;
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+		if (!env->prog->aux->attach_btf_id)
+			return false;
+		*range = retval_range(0, 0);
+		break;
+	case BPF_PROG_TYPE_TRACING:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_FENTRY:
+		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
+			*range = retval_range(0, 0);
+			break;
+		case BPF_TRACE_RAW_TP:
+		case BPF_MODIFY_RETURN:
+			return false;
+		case BPF_TRACE_ITER:
+			break;
+		default:
+		}
+		break;
+	case BPF_PROG_TYPE_KPROBE:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_KPROBE_SESSION:
+		case BPF_TRACE_UPROBE_SESSION:
+			break;
+		default:
+			return false;
+		}
+		break;
+	case BPF_PROG_TYPE_SK_LOOKUP:
+		*range = retval_range(SK_DROP, SK_PASS);
+		break;
+
+	case BPF_PROG_TYPE_LSM:
+		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
+			/* no range found, any return value is allowed */
+			if (!get_func_retval_range(env->prog, range))
+				return false;
+			/* no restricted range, any return value is allowed */
+			if (range->minval == S32_MIN && range->maxval == S32_MAX)
+				return false;
+			range->return_32bit = true;
+		} else if (!env->prog->aux->attach_func_proto->type) {
+			/* Make sure programs that attach to void
+			 * hooks don't try to modify return value.
+			 */
+			*range = retval_range(1, 1);
+		}
+		break;
+
+	case BPF_PROG_TYPE_NETFILTER:
+		*range = retval_range(NF_DROP, NF_ACCEPT);
+		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		*range = retval_range(0, 0);
+		break;
+	case BPF_PROG_TYPE_EXT:
+		/* freplace program can return anything as its return value
+		 * depends on the to-be-replaced kernel func or bpf program.
+		 */
+	default:
+		return false;
+	}
+
+	/* Continue calculating. */
+
+	return true;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
 {
 	const char *exit_ctx = "At program exit";
@@ -17845,7 +17957,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_retval_range range = retval_range(0, 1);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	int err;
+	int ret, err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
 	const bool is_subprog = frame->subprogno;
 	bool return_32bit = false;
@@ -17856,7 +17968,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (prog_type) {
 		case BPF_PROG_TYPE_LSM:
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
-				/* See below, can be 0 or 0-1 depending on hook. */
+				/* See return_retval_range, can be 0 or 0-1 depending on hook. */
 				break;
 			if (!prog->aux->attach_func_proto->type)
 				return 0;
@@ -17914,101 +18026,14 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return 0;
 	}
 
-	switch (prog_type) {
-	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-		if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UDP6_RECVMSG ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_RECVMSG ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETPEERNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETPEERNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETPEERNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETSOCKNAME)
-			range = retval_range(1, 1);
-		if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND)
-			range = retval_range(0, 3);
-		break;
-	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
-			range = retval_range(0, 3);
-			enforce_attach_type_range = tnum_range(2, 3);
-		}
-		break;
-	case BPF_PROG_TYPE_CGROUP_SOCK:
-	case BPF_PROG_TYPE_SOCK_OPS:
-	case BPF_PROG_TYPE_CGROUP_DEVICE:
-	case BPF_PROG_TYPE_CGROUP_SYSCTL:
-	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-		break;
-	case BPF_PROG_TYPE_RAW_TRACEPOINT:
-		if (!env->prog->aux->attach_btf_id)
-			return 0;
-		range = retval_range(0, 0);
-		break;
-	case BPF_PROG_TYPE_TRACING:
-		switch (env->prog->expected_attach_type) {
-		case BPF_TRACE_FENTRY:
-		case BPF_TRACE_FEXIT:
-		case BPF_TRACE_FSESSION:
-			range = retval_range(0, 0);
-			break;
-		case BPF_TRACE_RAW_TP:
-		case BPF_MODIFY_RETURN:
-			return 0;
-		case BPF_TRACE_ITER:
-			break;
-		default:
-			return -ENOTSUPP;
-		}
-		break;
-	case BPF_PROG_TYPE_KPROBE:
-		switch (env->prog->expected_attach_type) {
-		case BPF_TRACE_KPROBE_SESSION:
-		case BPF_TRACE_UPROBE_SESSION:
-			range = retval_range(0, 1);
-			break;
-		default:
-			return 0;
-		}
-		break;
-	case BPF_PROG_TYPE_SK_LOOKUP:
-		range = retval_range(SK_DROP, SK_PASS);
-		break;
+	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS && !ret_type)
+		return 0;
 
-	case BPF_PROG_TYPE_LSM:
-		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
-			/* no range found, any return value is allowed */
-			if (!get_func_retval_range(env->prog, &range))
-				return 0;
-			/* no restricted range, any return value is allowed */
-			if (range.minval == S32_MIN && range.maxval == S32_MAX)
-				return 0;
-			return_32bit = true;
-		} else if (!env->prog->aux->attach_func_proto->type) {
-			/* Make sure programs that attach to void
-			 * hooks don't try to modify return value.
-			 */
-			range = retval_range(1, 1);
-		}
-		break;
+	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
+		enforce_attach_type_range = tnum_range(2, 3);
 
-	case BPF_PROG_TYPE_NETFILTER:
-		range = retval_range(NF_DROP, NF_ACCEPT);
-		break;
-	case BPF_PROG_TYPE_STRUCT_OPS:
-		if (!ret_type)
-			return 0;
-		range = retval_range(0, 0);
-		break;
-	case BPF_PROG_TYPE_EXT:
-		/* freplace program can return anything as its return value
-		 * depends on the to-be-replaced kernel func or bpf program.
-		 */
-	default:
+	if (!return_retval_range(env, &range))
 		return 0;
-	}
 
 enforce_retval:
 	if (reg->type != SCALAR_VALUE) {
@@ -18021,7 +18046,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (err)
 		return err;
 
-	if (!retval_range_within(range, reg, return_32bit)) {
+	if (!retval_range_within(range, reg)) {
 		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
 		if (!is_subprog &&
 		    prog->expected_attach_type == BPF_LSM_CGROUP &&
-- 
2.49.0

