Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041773BCD21
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621635; cv=none; b=oPc3AfhLE3NWPpngLAym0OAc2MQw7VEWuZmeM876CZ+C5j5cGy6eoEqCK5plXFLizr9QsLPgV9zboErmwJuhWDWn7/2XZP0MZYfjb2jxHZboLWpKskw1Vz/D0KiLmX8DXzU5Cvmd54SOCbNvOcaZPLa6u6smLEzi3hgCOIfOaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621635; c=relaxed/simple;
	bh=lVvoTRKV+3BCpwXdHLW7u7f0rPILUFp1FrBra9szLDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAOV9XzTOy/pveHBitfQn15PPAAkaA+yTQDtGAqxkO0xDIW0bEjrikditUMsp+J/OQNOOcVSxVLPin498XJGX/kh8Cob4r20d2zQV1Q1/kVwWoul2klDhWAvBFY2B9hufiXbwkccBUSykShr+4sbKWQXUpt+lLpa+34xGNjn/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7t1smmq; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7t1smmq"
Received: by mail-oo2-f38.google.com with SMTP id 006d021491bc7-6d8a300d018so829715eaf.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621627; x=1791226427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3iiqVhboOCWmQpAJF/Wgomf8WFXysfrIu+o1Faknj+M=;
        b=c7t1smmqjPTKN4R7FEc1EXb70Ei+tfsVkSO6EsojMhVeGw82U3+FaDFQf4ciiDGPwK
         MYKXC0ORqZVDRc/9ZC35zQj0reBzACBncaNktp7X7SmTSxl+RHLksbPT3WginN4OkgOu
         hLxeY6wRTLNpgyFJJBFMobR3wAUiGhJ7R4tToIXs5m7z6lE6JTBnVmBHaWoU7dv71lgj
         QaWz4W0FPa8CLHCOad+wxql03OGQTULET62bVSgm8e1XVOxdAP7W4YTUYZ091zeh0u9g
         2Q/mC3LB+FeUXSJF3+ZpNfyuSPOC503UAOrP5uEyl2cz6NWVQDSJciEWoqIXE2tAvyLS
         lFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621627; x=1791226427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3iiqVhboOCWmQpAJF/Wgomf8WFXysfrIu+o1Faknj+M=;
        b=V7UGEzNUm6/hUhoLjbS+g81AEDp1/pC1WcpyLdOumflhzNjXu6CBh/sDSetNrp9ts6
         86r0BloXlY96afFQDO7TpJY0T5mjhVVpDSd8f7HunHq4I6UkEV85fe2jLxb1pg90SM+E
         47TtmsSiNTOEE9otgxoy/MLq3lyWOkVDHbMayxhWDeVwoN12lWfSLlvBf/khh4egYr4i
         84wNQbTBFLohnY51+AfYhIRe0S4lJKfJjYwOHBUUnvhci0yNc5ubqNM7w10x0leRsPio
         df28u6HDd3bO3CzczX/M6SYLSSEnA46uBmJjr8FQ6zqF1iG4bhV4HCmuMA6efFlZmrz9
         F5mA==
X-Gm-Message-State: AFuF++kTmTIelAumOo3E77eUvSs420g1yyrsp6my0nShUukccmpQMJMb
	la5FYXdWoB7Q4Q0/g6/BzRekpMN+JkuLBWPclOjnjRM2/sTV/ZRjKdjUPBE1xw==
X-Gm-Gg: AYBFou3+mbESsht6e+XQ+CIwvzjYPh7ijTUKWF2eNvKoq80fXbBy64gIxy8MOx8l5Zh
	oOzS/e3hC6387HJKVvTso9Syx+rgnCSzsyFNZesxv29Chd7K30YX6SczxMBLrhDLziliBc8yDCo
	Q+SnjEctMG/DRoCYWfGNIWsZpWzydHIeFOPAh/shyOOMANGM3j+f9l4QPMRMy2qql/zNXfhg7Q0
	WImriqI/GkC3XEDJ5Hy3MgmS1tIRnS2zyKSyH7/zO4/U2ZMLeU7/nl5QDk8fr8xJ1lOHlae6D7X
	b+5PQaDwC/PoCwtSwm/TCjQdpVPXts45KAzO70uI7GHEeiKmBPKTR7qyFEH3Yq5oiiM0LspdDKr
	bRM91HBccu64P5rtecfqfkQGvhnzYeXjmMnuRd8q2xwHUsGLENcCFpDnlkF6VK+H+MKxr4Bvsnk
	RJo6PqKEmdUdgCLrHvVpW+2/hgslzuapewDClytoqxyGz+tfzFIqOJ0P5Gt1h7lA==
X-Received: by 2002:a05:6820:a29a:10b0:6d7:9e0f:3335 with SMTP id 006d021491bc7-6d79e1ea671mr3150245eaf.21.1790621627376;
        Mon, 28 Sep 2026 11:53:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d882dc49dbsm6011615eaf.9.2026.09.28.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:47 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 08/11] bpf: Check subprog dynptr arguments in the common path
Date: Mon, 28 Sep 2026 11:53:31 -0700
Message-ID: <20260928185334.1004200-9-ameryhung@gmail.com>
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

Subprog and helper/kfunc dynptr arguments ultimately use the same
process_dynptr_func() validation. Route the subprog dynptr branch
through check_func_arg() so register type, offset, and dynptr state
are checked in the common order.

check_func_arg() validates the register against the PTR_TO_STACK and
CONST_PTR_TO_DYNPTR compatibility set before dispatching to
process_dynptr_func(). Once the subprog path uses the common checker,
process_dynptr_func() has no caller that bypasses this validation. Remove
its now-redundant register-type check.

The existing wrong-register-type test passed a NULL local to a callee
that did not use the argument. Clang left the context pointer in R1,
while GCC materialized zero. The common checker rejected the values at
different stages and emitted different diagnostics.

Obtain a PTR_TO_BTF_ID from bpf_get_current_task_btf() and keep its
callee argument live. This makes both compilers exercise the intended
register-type mismatch.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 23 +------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c | 11 ++++-----
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index efb20e50c974..0d554e95fdb5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8133,18 +8133,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 {
 	int spi, err = 0;
 
-	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
-		verbose(env,
-			"%s expected pointer to stack or const struct bpf_dynptr\n",
-			reg_arg_name(env, argno));
-		bpf_diag_call_arg_fmt(
-			env, insn_idx, argno, meta->func_name,
-			"Pass the address of a stack dynptr object, or use a const dynptr pointer returned by the verifier-supported path.",
-			"a dynptr argument must be a pointer to a dynptr stack slot or a verifier-provided const struct bpf_dynptr, but %s is %s",
-			reg_arg_name(env, argno), bpf_diag_reg_type_plain(env, reg->type));
-		return -EINVAL;
-	}
-
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
 	 *		 constructing a mutable bpf_dynptr object.
 	 *
@@ -10883,7 +10871,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		nslots = btf_arg_slots(t);
 
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
-		    arg_type == ARG_PTR_TO_CTX ||
+		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
 		    base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
@@ -10912,15 +10900,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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

