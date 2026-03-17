Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73C288D2
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746338; cv=none; b=fz4lxkDspuiAw+sa1JK0aFL1ymrXCWV+LbiDl24eTdGN0eLnxeT1gH6qpDCOH+hCESALM7TnQAm1w2OaIfr6sp3fdejtzSrOOFIo48ecCeArglyzOsEhuePAzwhftxUxT0VMszkJtOo1/BcnaLAAqX8lchoGd/JCqmGfIxgUJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746338; c=relaxed/simple;
	bh=3lr05iP953Tub+rVNpfe0in8GYu057tLq/v29aUGk6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLC9wef91clgNzxqFvKGblV8kdYlg9Hpzoid+Mgd79b6U6aPUwAd4M15S85VJbLxXQtkL7f2MGVP/1d9GslBpJ51sMnlbxHUvI9kcFiI4si/hUnqNLh650DYHz7tSwdovJ84Gq6SVUFDsXcNCYKN+dQeDTtEc3YDK670jq4ODIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bREjkUfI; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bREjkUfI"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-4673790ab85so3690277b6e.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746335; x=1774351135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLzx1snc9ElKO0ogyztXLq6ujXWy6/pY2VcOjhW0dug=;
        b=bREjkUfIBRjue3KYh/rUDIkxOi/eWJp2LvwV85XdSvhv4l/kaTsidf8gQGi5JEBd4o
         ifvCaPdiAYqnJwU2t6M7fYQU8Pp3pZ3qMtVlwks67SX6Qgp7g3DnWnu6XAwGzc/vBtHk
         PqC1JsizFfglP5QJQs3Rzgh521hu3z+gbHV+UKSOsW3txP48X+xPEjgx4jYHHTpOnEEq
         MG/9aQdiEzK2Vp+N+OwWxibBS6Or2ougTQJ3mAcC7ezmNK9eY90ANF3U8Pjc374bUPmw
         uVmCoEqNVfJ636EPJ5CWlyP5HnmAeaRfKEzz7vQ0BzvtmwBoxZfrKPJqsh3PaJlDyUih
         n9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746335; x=1774351135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RLzx1snc9ElKO0ogyztXLq6ujXWy6/pY2VcOjhW0dug=;
        b=UNLGULdeDFJjPyRfedA/2O+fBnH3c3Li2Z5j1LZTNN3tsd6aWcYsJwzFou+LLj6Ypk
         jTj2T+SKRRdkmAe/RHVTpKD31V2C0DkUIsljAcR6qHoLKMkQHXfDaTJLo0jYEwBzmMGX
         9iPAUGJzO9xq+F/5SZS4LnOA9k/n3DiFudCbeuwBhjNl4IMKGDXuhoNsSm7mzlO9i8BJ
         Fv1CT5SPi9bkMbpq1CrKp9z9JeGD5kXDk9zeggs0JstZD3nTTh8gIqI+4WN7msFXuoUG
         wSXVA//T8tncLZ+z7P6R+gpCr4gp66dMLP8YI/jtIWBg8JBARDVIeuWquWbkFaoPat5F
         O/3w==
X-Gm-Message-State: AOJu0YzIzMag61lyBoekTuV8Ybh+EPay62CQUu4sFWevT2P9Fr1FtkUQ
	zJkM8eZXOHVIfoiRr5y0WOf0KQFFf0YeYlJKkQZT19rQhIcNzinGroT/MqJxtpZL94M=
X-Gm-Gg: ATEYQzyDNxoUx7sbc7T4xV0cO9CVMMIGyaayICIHh8g6ySaLcPqLHNgnFy1ZZNNRcUs
	1lp2eQBP/0LDUybVHpVtQTwvfZQAm/hSkw6wPhaTq+1PUwWpVK6izajDG6CbCml/2YbhTGHDj4J
	/N/9Rfr44Owr68oCu8ZA7P0JtGG6QoJ1mGUaqS8JX72IiDhswcxoGDd1Om+JD45/O1bkQEk3FQA
	XIF1ytgS4WUbirGKLdJ/yx8RvYZ0IsMj3/p0Xl+BZkIcysJ8rBlsNWxoxcsJTAjnQiuz2IMiLML
	q6IQaRxzI4B5W7Vyn3dnDcQVY/AKl5JChSMgYFfa9o+svtYugDZcOhBYxbP7RiO5fv97xu8byMm
	pSfVDxWHHYAU8cVA/eO1m2TT3LqASE3izFAAE4EU/Ahx83HOxaOPVHy59ev6Hzaa63fEs6BcP6z
	3oASIz0lIfc3Db8Jpkjr6pBJaWErrUNPMq9dDjiTSTpT4c
X-Received: by 2002:a05:6870:75cf:b0:417:2524:2d76 with SMTP id 586e51a60fabf-417b91db604mr9804888fac.2.1773746334786;
        Tue, 17 Mar 2026 04:18:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e2df1ddsm18980698fac.9.2026.03.17.04.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:18:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/4] bpf: Support variable offsets for syscall PTR_TO_CTX
Date: Tue, 17 Mar 2026 04:18:46 -0700
Message-ID: <20260317111850.2107846-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317111850.2107846-1-memxor@gmail.com>
References: <20260317111850.2107846-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5780; h=from:subject; bh=3lr05iP953Tub+rVNpfe0in8GYu057tLq/v29aUGk6g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpuTHin1vhMXw2TMMio4/li+5/+4RJISLNsqdRlIss 3k2KUxuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabkx4gAKCRBM4MiGSL8RyoKmD/ 0Z/Wp+XraL4OxkAhPuDx+IILh6UYMnaYy9GOLIkwZEGDFlk6f5kvoKH9N3zga14jnQpwG+XcWOAAcy NzNpqn4NDQFxj5/kjyEP0utr8pTsTRp7geDaRTqdwyYXGa7SqupHKhoILBQLgIOWk/DFtkAhgEfC1P lP6vFbZhF2dOsUaiSPv0J/yKqiWvGrq2RVZZFe9EWhEwe2U/ncZOD8U3hBkzd3gMxC0mCpELzVF6U6 ac7D+C1rNoJMEJ52sE07icd1irrpQPcmm7LbTbW68SqWZHfkoPEQMdt4YrYrdK/m5qs0I+RomYUhf4 F2+FeHVKvlqv2hezaZug8RKTefYjHUuPjv+fgimVbM5eD6/fWroEspTYzDwlMqjmHd0DaNGCnSKEME Jm0EW1OmZm3OQOGF1ZFt4mxg7ZkKLYao1gJppH3beDvoz0CSZ3p52cCP6ymnHSPfkq+4YNrFXyO+Mt mzdhi+yjdPpHWrmVIIS8xNQ/IBM4Pq9hlbtZx68v3vYvuGzW6PplFS/BdNUUdzNSPVavwQuzyRKAk2 NCeWoLRTv1lAurBQ0WR8U12vrk2o2rAheTJ87iiGrZD0b3TnLgV2I9NHb87RQmUrGbbcOxS47Qiqhv mohVqQGoDRDJ4uVDBvveaXomX1JC+GgCjK0jQ48r8s5gOOaN9OGkFgrntP/g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Allow accessing PTR_TO_CTX with variable offsets in syscall programs.
Fixed offsets are already enabled for all program types that do not
convert their ctx accesses, since the changes we made in the commit
de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"). Note
that we also lift the restriction on passing syscall context into
helpers, which was not permitted before, and passing modified syscall
context into kfuncs.

The structure of check_mem_access can be mostly shared and preserved,
but we must use check_mem_region_access to correctly verify access with
variable offsets.

The check made in check_helper_mem_access is hardened to only allow
PTR_TO_CTX for syscall programs to be passed in as helper memory. This
was the original intention of the existing code anyway, and it makes
little sense for other program types' context to be utilized as a memory
buffer. In case a convincing example presents itself in the future, this
check can be relaxed further.

We also no longer use the last-byte access to simulate helper memory
access, but instead go through check_mem_region_access. Since this no
longer updates our max_ctx_offset, we must do so manually, to keep track
of the maximum offset at which the program ctx may be accessed.

Cc: Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 51 +++++++++++--------
 .../bpf/progs/verifier_global_subprogs.c      |  1 -
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268de..50639bb69d91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7843,6 +7843,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		 * Program types that don't rewrite ctx accesses can safely
 		 * dereference ctx pointers with fixed offsets.
 		 */
+		bool var_off_ok = resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL;
 		bool fixed_off_ok = !env->ops->convert_ctx_access;
 		struct bpf_retval_range range;
 		struct bpf_insn_access_aux info = {
@@ -7857,15 +7858,25 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
-		if (err < 0)
-			return err;
+		if (var_off_ok) {
+			err = check_mem_region_access(env, regno, off, size, U16_MAX, false);
+			if (err)
+				return err;
+		} else {
+			err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
+			if (err < 0)
+				return err;
+		}
 
 		/*
 		 * Fold the register's constant offset into the insn offset so
-		 * that is_valid_access() sees the true effective offset.
+		 * that is_valid_access() sees the true effective offset. If the
+		 * register's offset is not constant, then the maximum possible
+		 * offset is simulated.
 		 */
-		if (fixed_off_ok)
+		if (var_off_ok)
+			off += reg->umax_value;
+		else if (fixed_off_ok)
 			off += reg->var_off.value;
 		err = check_ctx_access(env, insn_idx, off, size, t, &info);
 		if (err)
@@ -8442,22 +8453,16 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_ptr_to_btf_access(env, regs, regno, 0,
 					       access_size, BPF_READ, -1);
 	case PTR_TO_CTX:
-		/* in case the function doesn't know how to access the context,
-		 * (because we are in a program of type SYSCALL for example), we
-		 * can not statically check its size.
-		 * Dynamically check it now.
-		 */
-		if (!env->ops->convert_ctx_access) {
-			int offset = access_size - 1;
-
-			/* Allow zero-byte read from PTR_TO_CTX */
-			if (access_size == 0)
-				return zero_size_allowed ? 0 : -EACCES;
-
-			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						access_type, -1, false, false);
+		/* Only permit reading or writing syscall context using helper calls. */
+		if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL) {
+			int err = check_mem_region_access(env, regno, 0, access_size, U16_MAX,
+							  zero_size_allowed);
+			if (err)
+				return err;
+			if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
+				env->prog->aux->max_ctx_offset = reg->umax_value + access_size;
+			return 0;
 		}
-
 		fallthrough;
 	default: /* scalar_value or invalid ptr */
 		/* Allow zero-byte read from NULL, regardless of pointer type */
@@ -9401,6 +9406,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MEM | MEM_RINGBUF,
 		PTR_TO_BUF,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
+		PTR_TO_CTX,
 	},
 };
 
@@ -9710,6 +9716,11 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		 * still need to do checks instead of returning.
 		 */
 		return __check_ptr_off_reg(env, reg, regno, true);
+	case PTR_TO_CTX:
+		/* Allow fixed and variable offsets for syscall context. */
+		if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)
+			return 0;
+		fallthrough;
 	default:
 		return __check_ptr_off_reg(env, reg, regno, false);
 	}
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index f02012a2fbaa..2250fc31574d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_struct_t *t)
 
 SEC("?tracepoint")
 __failure __log_level(2)
-__msg("invalid bpf_context access")
 __msg("Caller passes invalid args into func#1 ('subprog_user_anon_mem')")
 int anon_user_mem_invalid(void *ctx)
 {
-- 
2.52.0

