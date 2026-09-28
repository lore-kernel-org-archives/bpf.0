Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809437A4B8
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619270; cv=none; b=NaFemvJXVrO+LCHYerXasUkJLaFpDVPDWfF4pP7KJmeNbyevEGD6LJZz1SovHqnbQw4SyGID06kC32XDEa+1wxjn23sr7W9jnVsmSScMnCVW/Q6jLdGHl04I3rwHfhWrXSgkVn7wlJM7JwKNvLKLcT0dyYhSxMy9k2K5hr9y17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619270; c=relaxed/simple;
	bh=JcFDF+DB7MRjPTn5yZPtEEyUBR2nxxWNxWbcr1hB2/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2Ln082PKwffnibUILpYAsxCQzSNW8CMnYBg1DL+Ss4uSLZnu7a6C9QglHBfMEukU9fbR8ddIlOv91xsgqcLZp01+yNiFw+KO9DXGzEd+UGlLcvnFvfOUh9vs3JoDhfRSORUkNSdBF71ddR3vXPoJx278bre7IWTNwDtLMxh8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcBG/3kB; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcBG/3kB"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so2030505a34.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619268; x=1791224068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZMxXuMGMepX0bi515Mrz3PCx619GrINvdbzljXupY4=;
        b=CcBG/3kBpPw1ACLQst15oTExNco98UKrp9MLt3YhBf5AH6tR/FZBclVmSYkVRNoetB
         2sNIPDigWTGt+CBPYUd5hvFaHP5vD+l3EPo0RPIW+nQlo2B9L44TCcQmO1q4z2Ugdevz
         nZrajryBgmP8nP2V8mEcFsG5Vs2Hcou8174NxOQnI+q16pZ8xkPeavMRdFF2eLkg/Id+
         YZwTbFl2U4v1wYCrhCqwI5sDlJ6J14+p8aGlpuoPGwBjMhKSwROd9dAYNBBXTcbNlP8w
         oqN1Q7p5eZBVzt1D6gjeJuziN9v4+Ku7tpiLfzSNBJexx2G3yrHtjjovSk8s+jg3EXIN
         poqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619268; x=1791224068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZMxXuMGMepX0bi515Mrz3PCx619GrINvdbzljXupY4=;
        b=AtxvuLtBTSeTS+cB6oijfn+EynHSuCa6/RnZch0yW9qY862G6u5ah2uWZsepa0tkFn
         VPMEbrxFytzg2+7yoaMjwguEOJ9naxUKIl/0o4/qvkvRb27QKjrzGKBYR5CF/MYOTg0N
         QFDMYQKX7MhdCa8IYsbL/5J8TFPh7c+mKbjohh2wFFgea/8YkHbjMs3Bz5J5dFGlb3Yb
         BH0Okk0+48dN2aqETMXfVVeBpspEZLYmeCcSSEtKhMxdPdaOICd4dJ/rV5SVIqY1vfPj
         cKNmO4U2uzDyvUv63y4zkqqcxOblGORR0NWsD3BqrGVE+lGCN3EhOJP0zSm/lBi0ESLI
         60WA==
X-Gm-Message-State: AFuF++k47SViQ1ngkxL4nypRgpO1KVqaFgKvU0HnSFl3kCyjYY2zLVfE
	dTvkC2MIXCzMh17TPCouSjZblCeZ3xRbyvlCejpacZQk2VGJ5MDMh398EX/wxA==
X-Gm-Gg: AYBFou3LGbVLxcqk40gp7GUa0+jbQX44r/XGdI4TxAETAmYQHK/AgZGMYLDunRyfcnz
	NcGp24bFY24JfXM40VaEKBxLLKhmCssieTj/4AflAR2ap5clkzkfN8g+iOc+f4ksyW9ZOYXBJPX
	Hffd+QATSDPP+9g0X1XsRh+AMA/2evGNdbzmvWo8oV6NB6OLxupTbHkbsO4CNO4g75UPbzlbANv
	f2+88dIBlp5KmSGuvlkKhTLAF8TXL0TwIa5PHt96oeKRdVZ5tJ5HEFo64Fl+n+0fUt7kEbHYx4j
	iWrE3yuCpPwej8PfvYeiCtFUA96KlRRquTDiL9RBTzAOehAHNrq75AgmWDsk62e/UI83XFCk9nJ
	SYm6G62T7q1PINwT9YNGLpM38rY+aOvJ6LLPT52vNKpjSFkmiF6+XEeDFAJ19uxx2gK1I8BGYvQ
	7n8TIPYi1fA5muntPfea936JTVwP8hnnZhKrmoEAdNltGHq5xQELOF3w647GZa
X-Received: by 2002:a05:6830:61c9:b0:7fa:ac4f:793 with SMTP id 46e09a7af769-81783e87cb6mr15624590a34.31.1790619268066;
        Mon, 28 Sep 2026 11:14:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d58f177e1sm2215806a34.24.2026.09.28.11.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:27 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/11] bpf: Check subprog dynptr arguments in the common path
Date: Mon, 28 Sep 2026 11:14:10 -0700
Message-ID: <20260928181414.644158-9-ameryhung@gmail.com>
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
index 237b81ee3159..fb0e2649bab3 100644
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

