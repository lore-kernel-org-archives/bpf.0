Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427C4BEE5A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164285; cv=none; b=bzLewZ5WFqpmntKStApL70qk1EcObLfBywrDwQR0cU/rYq1XB3G6zZ++kAb3yJFrw3FHG0/s+EEWGCfvxYVgdtRuExps8xqsszuGqkr4a+cCE51i0rqxPXDP1A7wmY99KQysWiVGnhilmoAHeqp/AjgqopI9Ibi32ap6ESWI2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164285; c=relaxed/simple;
	bh=Z7mKavabYiOMPioWghesn9vj17WDM796N/cwSByR0jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAbn2MVLSrvppAy2oXhXAPKy5OgLOtah5K4opb3dOz6YcDYGRYm7zmDs1FbVF5LObkwWg21UxbzsY2LzXnNjUGSMsG7UDhtF61x7nibigrAtRPsDdBQPfZz3NFKTYj3D5FJShmiyloU3RkRGkzDiaaiWKUlU3Qv77PoxdvwkH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgwtxrc9; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgwtxrc9"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd478bso28447fac.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164279; x=1789769079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPaSi/xbEJ/JB4d3XR0FESfFvOlIOk7T4uM7yI/yqzo=;
        b=qgwtxrc9fy50LJs+jp0JgO+kN7i+gKN3vQ41iHnGw+6p0kfwVGsgmXGwX+Q82w3PRr
         r5C2kiqvSsEWeQc6KyopBUyqjWSlfv2JrKPpsOH2PgINzk0UrU8n/06aNWMHmiTgnosH
         7RqnT/s+97A6SrPgIX2cO92uRp+38ztj8Z9n224nUd/Kr/iLucxre6leI51dSVhP/s+M
         lVQDnkAo5xvYJfa5d5KSlGWfN5R7kd4WTbbod0s5Z5wOX5bNtf1zCd5kh/L6KAloO9K3
         pcBh0Lo9lcWxk0XeoRc80fo7K6v7PNxLWnI9rMrY+Z21EGftUYqBYcSRE6p1AdWQ8mVA
         02kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164279; x=1789769079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RPaSi/xbEJ/JB4d3XR0FESfFvOlIOk7T4uM7yI/yqzo=;
        b=mxX1+6IfTTiB2ITpi00TkZCrKNz9w4qtAuRyfhO4bCSQRTSakjKd/Weyo3OVvBLWzE
         ihc3FadUt2wIdjtMTuNekziuKP+JSr0erfXu9kIvP4dEtd16hqAncVcuk8qBYalaD0i+
         6gvA9q9WYooCfdEpCOn51C4G8OVeepVV5NO34bLqCgAuIgtK1mao5kpoeyeG57+VzPAq
         Qylbjti4k3cIVl7AHo0mwVjN0HC977WRBW+Lnd53smOzxyW5kIg/o4VDdt9EAyMS5z8n
         YhmjDqgQf/93eau3js5vt6fuOfLi5/H/sidY0Yoqf7bW84b0RpkKg79YLnpKnbYhuJ/K
         vp9Q==
X-Gm-Message-State: AFuF++nzR3XRVqdD0fXWKOaVjRlEh8GsxlPEI8UngJne5lftwquDI1yB
	5LIA9hdYZvuc3qaISINAb0V8kNEGctFUdAvT/FgO86oGIRWJrOHy8Edj7gabvw==
X-Gm-Gg: AYBFou0Yn66mxv3BAcuPERXKJ6w4KbQM8DuxX8jOfrhvZb5XGcLAIun+jMuLwRNiNAz
	F/3uzhqhtKQI0NnYeFbJTB+LWkVKz88o1jiwmd6qUJ+Ns6nJ0irvyn1CCNXkneDZ12Dqjn5dRCz
	+zlW7fOCYtUy8eFJrD3uOeSZFFRHUK3Glp+AMvSq7stuMwE5gkX4KcoW2roeQMxbEFDDuG3H9T5
	QS5ZVLAlJegTFAGxRB5CqI4xuQk0mKdzqQl9U/VkJrzfT03A7uPY1SGJYKa4lVCJ7E3NU6CGZ7P
	2jP/hL5TOVTc5ssQoVfRB9H9UXrbmPCZP7c2lmZW/Hl2EL5T3+7UpIp6m4GzIxV9uuBKTyy3kDJ
	LEB118ywyE6UL9im6b7LpiMNvCsVwYTib+t5adS10dwfjGPTtfTwW5RThmRBu1crH+8hddoIAll
	hVz6iGAXGRqoyDcPe1dEtFawET5SvciVDAnG8UL7X42u83PMbC6dg4rxAomxgbRw==
X-Received: by 2002:a05:6870:a24e:b0:47d:18ca:afc7 with SMTP id 586e51a60fabf-47f59b932aamr286865fac.30.1789164278844;
        Fri, 11 Sep 2026 15:04:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df9629facsm2767532fac.18.2026.09.11.15.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:38 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 15/23] bpf: Consolidate nullable argument validation
Date: Fri, 11 Sep 2026 15:04:07 -0700
Message-ID: <20260911220415.1396439-16-ameryhung@gmail.com>
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

check_kfunc_args() rejects a NULL or possibly-NULL register passed to
a non-nullable pointer argument up front. Helpers only do so inside
check_reg_type() for PTR_TO_BTF_ID arguments, leaving other pointer
kinds to fail indirectly through compatible_reg_types[].

Give both paths the same policy and factor it into
check_func_arg_nullability(). Gate it on arg_type_is_scalar() rather
than on the BTF shape of the kfunc parameter. This keeps a zero passed
to a size argument from being interpreted as a NULL pointer.

Taking nullability from the argument classification also avoids an
is_kfunc_arg_nullable() lookup for every kfunc argument on every
verification.

Keep release-argument nullability separate from ownership checking.
A possibly-NULL release argument must be rejected even if it is
otherwise nullable, while the ownership check must still permit a
literal NULL for bpf_kptr_xchg().

Use call-neutral structured diagnostics and retain the expected BTF
type when it is available for a kfunc argument. Resolve that type lazily
from the call metadata only when reporting an error. Helpers now report
NULL-ness rather than a register-type mismatch for non-BTF-ID pointer
arguments and literal NULL passed to a non-nullable pointer argument.
Update the affected selftest expectations.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 110 ++++++++++++------
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/progs/cpumask_failure.c     |   2 +-
 .../selftests/bpf/progs/iters_testmod.c       |   4 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   6 +-
 .../selftests/bpf/progs/verifier_ctx.c        |   2 +-
 .../progs/verifier_helper_access_var_len.c    |   4 +-
 .../selftests/bpf/progs/verifier_live_stack.c |   2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |   3 +-
 .../bpf/progs/verifier_map_lookup_refine.c    |   2 +-
 .../bpf/progs/verifier_ref_tracking.c         |   4 +-
 .../selftests/bpf/progs/verifier_sock.c       |   4 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |   2 +-
 13 files changed, 94 insertions(+), 53 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e7230cb5791..541467f9101f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8180,6 +8180,25 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
 }
 
+/*
+ * An argument that only ever takes a scalar, so a zero register passed to it
+ * is a value rather than a NULL pointer.
+ */
+static bool arg_type_is_scalar(enum bpf_arg_type type)
+{
+	switch (base_type(type)) {
+	case ARG_SCALAR:
+	case ARG_CONST_SCALAR:
+	case ARG_MEM_SIZE:
+	case ARG_MEM_SIZE_OR_ZERO:
+	case ARG_CONST_MEM_SIZE:
+	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * A kfunc is named by a BTF ID, which can take the same numeric value as an
  * enum bpf_func_id. Only test meta->func_id against a BPF_FUNC_* once the call
@@ -8382,6 +8401,34 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
 	bpf_diag_call_arg(env, insn_idx, argno, call_name, reason, suggestion);
 }
 
+static int check_func_arg_nullability(struct bpf_verifier_env *env,
+				      struct bpf_reg_state *reg, argno_t argno,
+				      enum bpf_arg_type arg_type,
+				      struct bpf_call_arg_meta *meta, int insn_idx)
+{
+	const char *expected_type = "pointer";
+
+	if (arg_type_is_scalar(arg_type) || type_may_be_null(arg_type) ||
+	    (!bpf_register_is_null(reg) && !type_may_be_null(reg->type)))
+		return 0;
+
+	if (meta->btf) {
+		u32 arg_btf_id;
+
+		arg_btf_id = btf_params(meta->func_proto)[arg_idx_from_argno(argno)].type;
+		expected_type = bpf_diag_fmt(env, "value of type %s",
+					     bpf_diag_fmt_btf_type(env, meta->btf, arg_btf_id));
+	}
+
+	verbose(env, "Possibly NULL pointer passed to trusted %s\n",
+		reg_arg_name(env, argno));
+	bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+			      "Add a NULL check and make the call only on the non-NULL path.",
+			      "the pointer may be NULL, but this call requires a non-NULL %s",
+			      expected_type);
+	return -EACCES;
+}
+
 static const char *bpf_diag_expected_reg_types(struct bpf_verifier_env *env,
 					       const enum bpf_reg_type *types, int count)
 {
@@ -8494,17 +8541,6 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		bool strict_type_match = arg_type_is_release(arg_type) &&
 					 !is_helper_call(meta, BPF_FUNC_sk_release);
 
-		if (type_may_be_null(reg->type) &&
-		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
-			verbose(env, "Possibly NULL pointer passed to helper %s\n",
-				reg_arg_name(env, argno));
-			bpf_diag_call_arg(
-				env, env->insn_idx, argno, meta->func_name,
-				"the pointer may be NULL, but this call requires a non-NULL pointer",
-				"Add a NULL check and make the call only on the non-NULL path.");
-			return -EACCES;
-		}
-
 		if (!arg_btf_id) {
 			if (!compatible->btf_id) {
 				verifier_bug(env, "missing arg compatible BTF ID");
@@ -8892,6 +8928,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 	}
 
+	err = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
+	if (err)
+		return err;
+
 	/* arg_btf_id and arg_size are in a union. */
 	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
@@ -8906,15 +8946,28 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 skip_type_check:
-	if (arg_type_is_release(arg_type) && !arg_type_is_dynptr(arg_type) &&
-	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
-		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
-			meta->func_name, reg_arg_name(env, argno));
-		bpf_diag_call_arg(
-			env, insn_idx, argno, meta->func_name,
-			"release helpers require a value that owns a live resource returned by a matching acquire helper",
-			"Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has already been transferred or released.");
-		return -EINVAL;
+	if (arg_type_is_release(arg_type)) {
+		if (type_may_be_null(reg->type)) {
+			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
+				reg_arg_name(env, argno));
+			bpf_diag_call_arg(
+				env, insn_idx, argno, meta->func_name,
+				"the pointer may be NULL, but this call requires a non-NULL pointer",
+				"Add a NULL check and make the call only on the non-NULL path.");
+			return -EACCES;
+		}
+
+		if (!arg_type_is_dynptr(arg_type) &&
+		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
+			verbose(env,
+				"release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
+				meta->func_name, reg_arg_name(env, argno));
+			bpf_diag_call_arg(
+				env, insn_idx, argno, meta->func_name,
+				"release helpers require a value that owns a live resource returned by a matching acquire helper",
+				"Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has already been transferred or released.");
+			return -EINVAL;
+		}
 	}
 
 	if (reg_is_referenced(env, reg))
@@ -13074,20 +13127,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		if (btf_type_is_ptr(t) &&
-		    (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
-		    !type_may_be_null(arg_type)) {
-			const char *expected_type;
-
-			expected_type = bpf_diag_fmt_btf_type(env, btf, args[i].type);
-			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
-				reg_arg_name(env, argno));
-			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-					      "Add a NULL check and call the kfunc only on the non-NULL path.",
-					      "the pointer may be NULL, but this kfunc requires a non-NULL value of type %s",
-					      expected_type);
-			return -EACCES;
-		}
+		ret = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
+		if (ret < 0)
+			return ret;
 
 		if (regno == meta->release_regno && !is_kfunc_arg_dynptr(meta->btf, &args[i]) &&
 		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 78566b817fd7..50ea3d72d446 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -12,7 +12,7 @@ struct {
 	const char *err_msg;
 } cb_refs_tests[] = {
 	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
-	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
+	{ "leak_prog", "Possibly NULL pointer passed to trusted R2" },
 	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
 };
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 4628feb53d86..6d730535eb95 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -183,7 +183,7 @@ int BPF_PROG(test_global_mask_no_null_check, struct task_struct *task, u64 clone
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to helper R2")
+__failure __msg("Possibly NULL pointer passed to trusted R2")
 int BPF_PROG(test_global_mask_rcu_no_null_check, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *prev, *curr;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 76012dbbdb41..5a3ff65e8234 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -135,7 +135,7 @@ int iter_ret_rcu_test_protected(const void *ctx)
 }
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("R1 type=rcu_ptr_or_null_ expected=")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_ret_rcu_test_type(const void *ctx)
 {
 	struct task_struct *p;
@@ -158,7 +158,7 @@ int iter_ret_rcu_test_protected_nostruct(const void *ctx)
 }
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("R1 type=rdonly_rcu_mem_or_null expected=")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_ret_rcu_test_type_nostruct(const void *ctx)
 {
 	void *p;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index eee35d203b66..0d7365b704b1 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -149,7 +149,7 @@ int reject_bad_type_match(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int marked_as_untrusted_or_null(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -217,7 +217,7 @@ int reject_kptr_xchg_on_unref(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("R1 type=rcu_ptr_or_null_ expected=percpu_ptr_")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int mark_ref_as_untrusted_or_null(struct __sk_buff *ctx)
 {
 	struct map_value *v;
@@ -364,7 +364,7 @@ int kptr_xchg_ref_state(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to helper R2")
+__failure __msg("Possibly NULL pointer passed to trusted R2")
 int kptr_xchg_possibly_null(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 7856dad3d1f3..9d42ba824408 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -208,7 +208,7 @@ __naked void null_check_7_ctx_bind(void)
 
 SEC("cgroup/post_bind4")
 __description("pass ctx or null check, 8: null (bind)")
-__failure __msg("R1 type=scalar expected=ctx")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void null_check_8_null_bind(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
index 343fc08d9747..d1452ef6f2f9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
@@ -621,7 +621,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to variable memory: size = 0 not allowed on NULL (!ARG_PTR_TO_MEM_OR_NULL)")
-__failure __msg("R1 type=scalar expected=fp")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void ptr_to_mem_or_null_8(void)
 {
 	asm volatile ("					\
@@ -637,7 +637,7 @@ __naked void ptr_to_mem_or_null_8(void)
 
 SEC("tracepoint")
 __description("helper access to variable memory: size > 0 not allowed on NULL (!ARG_PTR_TO_MEM_OR_NULL)")
-__failure __msg("R1 type=scalar expected=fp")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void ptr_to_mem_or_null_9(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 401152b2b64f..bc3dfdc1a536 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -246,7 +246,7 @@ static __used __naked void read_first_param2(void)
 SEC("socket")
 __flag(BPF_F_TEST_STATE_FREQ)
 __failure
-__msg("R1 type=scalar expected=map_ptr")
+__msg("Possibly NULL pointer passed to trusted R1")
 __naked void caller_stack_pruning_callback(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
index d3be69a9a755..621248a02a1f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -154,8 +154,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("forgot null checking on the inner map pointer")
-__failure __msg("R1 type=map_ptr_or_null expected=map_ptr")
-__msg("map_ptr_or_null, but this argument accepts map_ptr")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __failure_unpriv
 __naked void on_the_inner_map_pointer(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c b/tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c
index c01abf54923d..4b1eadddd89c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c
@@ -58,7 +58,7 @@ int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
 }
 
 SEC("?tc")
-__failure __msg("type=map_ptr_or_null expected=fp")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 int mapofmaps_value_as_helper_fixed_mem(struct __sk_buff *skb)
 {
 	char th[sizeof(struct tcphdr)] = {};
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
index 199ad18f8eb5..f3fad911b5bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -344,7 +344,7 @@ __naked void potential_reference_to_system_key(void)
 
 SEC("tc")
 __description("reference tracking: release reference without check")
-__failure __msg("type=sock_or_null expected=sock")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void tracking_release_reference_without_check(void)
 {
 	asm volatile (
@@ -363,7 +363,7 @@ __naked void tracking_release_reference_without_check(void)
 
 SEC("tc")
 __description("reference tracking: release reference to sock_common without check")
-__failure __msg("type=sock_common_or_null expected=sock")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __naked void to_sock_common_without_check(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 4f2f3209eec8..d59b2f905671 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -110,7 +110,7 @@ l0_%=:	r0 = *(u32*)(r1 + %[bpf_sock_type]);		\
 
 SEC("cgroup/skb")
 __description("bpf_sk_fullsock(skb->sk): no !skb->sk check")
-__failure __msg("type=sock_common_or_null expected=sock_common")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __failure_unpriv
 __naked void sk_no_skb_sk_check_1(void)
 {
@@ -466,7 +466,7 @@ l1_%=:	r0 = *(u32*)(r0 + %[bpf_sock_rx_queue_mapping__end]);\
 
 SEC("cgroup/skb")
 __description("bpf_tcp_sock(skb->sk): no !skb->sk check")
-__failure __msg("type=sock_common_or_null expected=sock_common")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
 __failure_unpriv
 __naked void sk_no_skb_sk_check_2(void)
 {
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 4b39f8472f9b..1efaff296b7c 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -311,7 +311,7 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
-	.errstr = "R1 type=rcu_ptr_or_null_ expected=percpu_ptr_",
+	.errstr = "Possibly NULL pointer passed to trusted R1",
 },
 {
 	"map_kptr: ref: reject off != 0",
-- 
2.52.0

