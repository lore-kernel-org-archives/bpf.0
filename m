Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66D349CD6
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645705; cv=none; b=hGsewM4QoHzDFpVXfcPC6RcuEnF+FfonNl+LA9KrrL1zaFWHJiwhDeqlUOkqcbEKgV3QrAyM7Oc64N3jTPUHotbQkEOmtvO6QICHOg0BxB2QAuO0WytFvQKrc2lsTWDd6a/LHQTbvbkFQ+ueoCNxyyFpCCkHK4yCTDxCnScr3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645705; c=relaxed/simple;
	bh=zTLMOboRFblccu09S2RI+U9wfVRPx5YDsmG8FNcayg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohnr/PQjIiWkEx1OnEnQLrV2ZKiUa9w2v/xlPuecvhx2rvPGBM6IAPCFDl01Oc4I8T6QHIq814OFv/u1mCkeci7aV/FJ16zMoQzFHDFA1GYM07bsfY1t6k/tXrEmNuUUiKbD46X/4aPcIeaDlSPlRAwbKmN45g07imrMWYsrvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZXaP46m; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZXaP46m"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f3f52143cdso1933804a34.2
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645702; x=1789250502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FoMZvrOQtVEmQAlXa34uJVRWaXDgKQyL9iUofPnIKyM=;
        b=AZXaP46mpy0D2Fc5IR3UYVta+bWcbpBR9+NztUYS9Kea2q7Cen9CzQE+vtkG5rhM/J
         7tHLZ3bWJiAO4yQCIq0OLcFUtcPZ/B7K6ORimUCckpY1sMK3gJLWWXJ7yw/hNfQKmOA0
         pufkSxNdYX+q4qecgNCrCThW6TKw9ISY0SKEFzuXIGILZOtn7ODrduhvGCkcu6cZbDAz
         hAitVaTW+sRO1N3EhLlDjAY4gnQhrwS+UHF4nrOsF7725OS5gluIxwzP7NuNI7R+XiyH
         1sx+WkMOVp+ET6FoKGk2XW3NBFueBQT1HSyfHhBRaYZWiqL85YBtsGwmo+R3QTklQBSf
         L4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645702; x=1789250502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FoMZvrOQtVEmQAlXa34uJVRWaXDgKQyL9iUofPnIKyM=;
        b=SjwE8yXDaZcZBsBLDWJzAYrJrbijMxV33B/aOJx480c7yyjkfEYSHcewXoyOsUyS64
         PSjTTq3Vh32afUhoLYZ1Nf7cAHCgoqmBfnuN6WVLmZJbW7XaPptTvta/L3NAUJFZ4zOS
         DC0nAtLNTIRaoltm5SPvSFSC75qW1RAaQ4qIEey5nH9pwGyJkCh4CY+iIFos/S3xOrcY
         Xw9CCZHQjiAVgmXt90YHRqiCAUUyEbBzedkE6RujB2qgSlNpVuOg9CBvfY2AcQsSfK5S
         3/egK47Wtk2G98a+Kz1gFIDZLPKkUg57/qpAG1uOIilLlzK35JneS5xj4NevsQ7fa1tx
         KDzg==
X-Gm-Message-State: AFuF++lrtFy4IJzDbdTbT43jGkdGqn9sDTX+i6nDtpGZMkWLCLd0jn2s
	Go9sJ87hGiXXx3tnxJQx8kBqjoqXC992dLQJ6NYWx7tMqQYgRu3T6DkC6NqL5Q==
X-Gm-Gg: AYBFou0WfHkZRbQ3h029drnUsQ2x16L02jlLvLWqfVaj9j0V2O7fqRcdL/W4QvJcirA
	dywU6xdO+Ie3LBssNf6KcK1S14DDHQqpcl/KhEW21ma9c12fKmwxdNkyNM4G0PcUrz7BrxvpX7H
	CPd6CLw4vvGbkLuzxC0/8vQNIPE9KuefJqfvW2acQh1kRRyGBRPn42ofoYGaO61fXiwZhW+dOti
	7S/1WFgsyGGVjbU5O037nZDVx84LqyTjr/XeAHqt9LEXqA0IFCIxGuvMOksjZCYS/D1Uh/vm/Vi
	cyLlixslbRXDday5CRHew9IfBi/Hcd1naGwGu7ElVV/ZSat2eNwf91EmTGRuPEAfM740AtSVDdi
	pI4uqZsXJOmO9NthMdCbYLXol7ZJMQAdAp2JL7uqjjVx9Vd4KFoaE2ksPi14SxLLm/Oqb7z05ox
	XwzcXD9FvuvRFrNxd2H3oax99Q2PrFiaJwaFa2quVes01WAslIRuY=
X-Received: by 2002:a05:6830:258a:b0:7fa:ac4f:784 with SMTP id 46e09a7af769-7faac4f0f27mr7612163a34.16.1788645702297;
        Sat, 05 Sep 2026 15:01:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f67947fcsm6994666a34.5.2026.09.05.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:41 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 15/22] bpf: Consolidate nullable argument validation
Date: Sat,  5 Sep 2026 15:01:10 -0700
Message-ID: <20260905220117.922028-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
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
index 15ed47b90316..1f5f975c73a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8135,6 +8135,25 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
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
@@ -8336,6 +8355,34 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
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
@@ -8448,17 +8495,6 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
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
@@ -8839,6 +8875,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		goto skip_type_check;
 
+	err = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
+	if (err)
+		return err;
+
 	/* arg_btf_id and arg_size are in a union. */
 	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
@@ -8853,15 +8893,28 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -12978,20 +13031,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
index 5e25ca806060..60c14e185856 100644
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

