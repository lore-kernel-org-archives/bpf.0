Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4D497B66
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164294; cv=none; b=cJSLFdZo29gb2PpeAycFsYrH44h/Na0m5EYUv9u6RvjXw70Y7KsBMbg6XL3y0Op2OAhKwcbsmE5H9CSmwyi2F7btjfcf/oDFLcCdXcTCBBE4zUKjzmkBmyHmNHtHjS6PODX2cndwIkRdBSbAlkKyrwa29E/A4wo/RrE+W8Nn3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164294; c=relaxed/simple;
	bh=5PdpSZvyx0uYJYPjogvUIJieeXqNLHVf6CxAxDd0I8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuFPw6XGTYm5LCMC8hwgUrwocbj7dJgIbV/bfuf97SMOdRFqbBQ6FrF+3xnxaDvxolMyMj8iIvKXhaog7rdfd63EFqd8USzNJy+s/5M4u02r4hmOzJ5KYwjBNy4uZGRhvKJhljAAIoNDLAJdl7Y0wEc/D1NiwMUUtf8YrwXWIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWkaIh6g; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWkaIh6g"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfb21so331785fac.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164288; x=1789769088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSm4Z6hOHbHhpnSl+YTi30PPx0j7X7iB1p72pIPAVLM=;
        b=pWkaIh6gDktVhD5J+W1yifKKkd/qR/Su7bZSNVM35m/kMSmZRKl0TVhxzVq2psdVLY
         CHOkRaJ4M26Gzz64omzRCtODohSsn4oCDJMOCqdQIlVefUnmyMxiy4Fwtb1prUui/lMV
         yhiXwVsxsYYGcCNxvlRdLyrK7L2IYsxPrbYIFPD0z9Uv8/l2dsz2PmpfAWS5GlXxWdQG
         b01P5bC+KooGgPM98Hy/3scuMlsb4cVlDDhl/xOaq2gRN2c2zCyms2JQU6/7XncWCvoq
         jSmxHBwfzueKgtRli9g0bXwP+ZJhnBkohxuBF4fX3Y8PvOyQFYgsp8VVj8+LAkVuax8a
         Cy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164288; x=1789769088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nSm4Z6hOHbHhpnSl+YTi30PPx0j7X7iB1p72pIPAVLM=;
        b=ghFZZvUb294qEa4gWjkBGem/lMXF4WuWELug23ZmC3ekrCHcNs4UdTd4d7kRSFG7Oq
         BcaU4YxpEaY+A5lTZwOq2Y/b7qtcSRHPx+DTAIzlXZ4Sxa+lXCZu1ZUZdlTTHy7AErTf
         vGPgEHlkM+IevQqOSnMfSoG3JubC2LnmtJNsd2MyQ7C/sOfZpVDOfe+nLanX9c2dGikt
         nSTJZ0GiWQ8uR5WgjWU/g8OkH9uk4r1xIEweP8KEQ6eqwcPomGeBi2q9F2PmS1FHCj5N
         Zm+0AG4yr26fTjSD72zmM/CmEqg7tReKeW/GZLxOB48sPfU84TuHM7hpBKxk0/73rRtf
         mtCQ==
X-Gm-Message-State: AFuF++mFI5imLSl9FC9l9ac8NS+dYvDITMXoQxmEdWTIuMyMq9ZFECW1
	4nHJWyTCSpxMb1Q5AWbv5Qlp+FzFT5fJb3sHG5Gp+lWTna+PxCeNv5kBsY+l/w==
X-Gm-Gg: AYBFou2hEoSaHjRwiVt+Y7xh5YLXKnhqTiwYPuCyjRjqPHF8Qtg5zHLQjBFT604G6o5
	nS8+UnPek1OONa326YmHSfCz9ImHNC/GCy45hoLwwby/C9aYaKQGRQYYouFfaMI+zDHK4DWNPAB
	YpmT5JUVjnefveCuPmGoS+yRhd3s3Kz7wt/5IVhZCxhm7dQhZzyl3QKbSXCBm/DUc5T1Vu38eFd
	uzq9ZICFMIEfyuOz4Au/+xILcZoiL85RtHgGUEbDo2qK+7lCEL7nUILiGQEIps+BYcN63UvNMwg
	aJlafRIuzbivdpChoT24tzuIGFx98c+N686K3PONh0gsWbcPHttBhs6dISSSHXH0o7xkBraj8jN
	QtFjJSyM1JJZa3+ojvnJlNQkAlFDSBFyjoCbouDjh7uTyi+9z3GGK3UWWcCYHL9wj7zVy43OJJG
	pOCDnYYwv+FUl9wwNFVrkkCAYyKMi1X7p1pSN/HWOvh7DKzUTDUdUgi5+WRZaHq9w=
X-Received: by 2002:a05:6870:b4a1:b0:47b:cd37:f931 with SMTP id 586e51a60fabf-47dea3fca5emr8441003fac.13.1789164287635;
        Fri, 11 Sep 2026 15:04:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df9629facsm2767790fac.18.2026.09.11.15.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:47 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 21/23] bpf: Consolidate release argument validation
Date: Fri, 11 Sep 2026 15:04:13 -0700
Message-ID: <20260911220415.1396439-22-ameryhung@gmail.com>
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

Helper and kfunc argument verification both require a live owning
reference for non-dynptr release arguments. Whether that reference may
be NULL is expressed by PTR_MAYBE_NULL in helper prototypes and the
__nullable BTF suffix for kfuncs. Factor the shared ownership policy
into check_func_arg_release().

Drop the helper-only rejection of maybe-null owning references. This
allows bpf_kptr_xchg() to accept its explicitly nullable source
directly, matching nullable kfunc release arguments. The verifier
consumes the reference regardless of its runtime nullness. Update the
tests so an owned nullable source succeeds while a nullable non-owning
source remains rejected for lacking ownership.

Preserve the identity of a nullable per-CPU allocation when
bpf_kptr_xchg() transfers its ownership inside an RCU critical section.
The converted MEM_RCU aliases no longer own a reference, but still need
a non-zero ID so a NULL check on one allocation cannot refine another
unrelated allocation.

Use common legacy and structured diagnostic text for both call kinds.
Tailor the structured suggestion to describe a pointer for helpers and
include the expected BTF type for kfuncs. Resolve that type lazily from
the kfunc BTF parameter only when reporting an ownership failure. The
kfunc path now keys the check directly on the cached OBJ_RELEASE
argument flag instead of comparing the argument register against
meta->release_regno, and uses the cached argument kind for the dynptr
exemption.

This is another prerequisite for routing both call types through
check_func_arg().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 82 ++++++++++---------
 .../selftests/bpf/prog_tests/cb_refs.c        |  4 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  6 +-
 .../selftests/bpf/progs/cpumask_failure.c     |  2 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |  4 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |  6 +-
 .../bpf/progs/verifier_global_ptr_args.c      |  2 +-
 .../bpf/progs/verifier_ref_tracking.c         |  2 +-
 .../selftests/bpf/progs/verifier_sock.c       |  6 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |  2 +-
 .../selftests/bpf/progs/wakeup_source_fail.c  |  2 +-
 11 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb33d0755a61..fe8a45303602 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8463,6 +8463,43 @@ static int check_func_arg_nullability(struct bpf_verifier_env *env,
 	return -EACCES;
 }
 
+static int check_func_arg_release(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				  argno_t argno, enum bpf_arg_type arg_type,
+				  struct bpf_call_arg_meta *meta, int insn_idx)
+{
+	const char *expected_type = "pointer";
+
+	if (!arg_type_is_release(arg_type))
+		return 0;
+
+	if (arg_type_is_dynptr(arg_type) || reg_is_referenced(env, reg) ||
+	    bpf_register_is_null(reg))
+		return 0;
+
+	verbose(env, "release function %s expects referenced PTR_TO_BTF_ID passed to %s\n",
+		meta->func_name, reg_arg_name(env, argno));
+
+	if (meta->btf) {
+		const struct btf_param *btf_arg;
+		const struct btf_type *t;
+		u32 ref_id;
+
+		btf_arg = &btf_params(meta->func_proto)[arg_idx_from_argno(argno)];
+		ref_id = btf_arg->type;
+		t = btf_type_skip_modifiers(meta->btf, btf_arg->type, NULL);
+		if (btf_type_is_ptr(t))
+			btf_type_skip_modifiers(meta->btf, t->type, &ref_id);
+		expected_type = bpf_diag_fmt(env, "value of type %s",
+					     bpf_diag_fmt_btf_type(env, meta->btf, ref_id));
+	}
+
+	bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
+			      bpf_diag_fmt(env, "Pass the resource-owning %s returned by the matching acquire call, or avoid the release function after ownership has already been transferred or released.",
+					   expected_type),
+			      "release functions require a value that owns a live resource returned by a matching acquire function");
+	return -EINVAL;
+}
+
 static const char *bpf_diag_expected_reg_types(struct bpf_verifier_env *env,
 					       const enum bpf_reg_type *types, int count)
 {
@@ -8881,29 +8918,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 skip_type_check:
-	if (arg_type_is_release(arg_type)) {
-		if (type_may_be_null(reg->type)) {
-			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
-				reg_arg_name(env, argno));
-			bpf_diag_call_arg(
-				env, insn_idx, argno, meta->func_name,
-				"the pointer may be NULL, but this call requires a non-NULL pointer",
-				"Add a NULL check and make the call only on the non-NULL path.");
-			return -EACCES;
-		}
-
-		if (!arg_type_is_dynptr(arg_type) &&
-		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
-			verbose(env,
-				"release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
-				meta->func_name, reg_arg_name(env, argno));
-			bpf_diag_call_arg(
-				env, insn_idx, argno, meta->func_name,
-				"release helpers require a value that owns a live resource returned by a matching acquire helper",
-				"Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has already been transferred or released.");
-			return -EINVAL;
-		}
-	}
+	err = check_func_arg_release(env, reg, argno, arg_type, meta, insn_idx);
+	if (err)
+		return err;
 
 	if (reg_is_referenced(env, reg))
 		update_ref_obj(&meta->ref_obj, reg);
@@ -9748,7 +9765,8 @@ static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 			continue;
 		if ((reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
 			bpf_diag_mod_begin(env, reg, NULL, BPF_DIAG_MOD_WRITE);
-			reg->id = 0;
+			if (!type_may_be_null(reg->type))
+				reg->id = 0;
 			reg->type &= ~MEM_ALLOC;
 			reg->type |= MEM_RCU;
 			bpf_diag_mod_end(env);
@@ -13089,19 +13107,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (ret < 0)
 			return ret;
 
-		if (regno == meta->release_regno && !is_kfunc_arg_dynptr(meta->btf, &args[i]) &&
-		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
-			const char *expected_type;
-
-			expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-			verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID passed to %s\n",
-				func_name, reg_arg_name(env, argno));
-			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
-					      "Pass the resource-owning pointer returned by the matching acquire kfunc, and avoid calling the release kfunc after ownership has already been transferred or released.",
-					      "release kfuncs require a resource-owning value of type %s returned by a matching acquire kfunc",
-					      expected_type);
-			return -EINVAL;
-		}
+		ret = check_func_arg_release(env, reg, argno, arg_type, meta, insn_idx);
+		if (ret < 0)
+			return ret;
 
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 50ea3d72d446..e415acc08b16 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -11,8 +11,8 @@ struct {
 	const char *prog_name;
 	const char *err_msg;
 } cb_refs_tests[] = {
-	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
-	{ "leak_prog", "Possibly NULL pointer passed to trusted R2" },
+	{ "underflow_prog", "release function bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
+	{ "leak_prog", "Unreleased reference id=4 alloc_insn=3" }, /* alloc_insn=3{2,3} */
 	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
 };
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index a7c8c765a98d..731eaa09db96 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -154,7 +154,7 @@ int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char *path)
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("release kfunc bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(cgrp_kfunc_rcu_get_release, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *kptr;
@@ -191,7 +191,7 @@ int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const char *path
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("release kfunc bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *acquired = (struct cgroup *)&path;
@@ -237,7 +237,7 @@ int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *path)
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("release kfunc bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(cgrp_kfunc_release_unacquired, struct cgroup *cgrp, const char *path)
 {
 	/* Cannot release trusted cgroup pointer which was not acquired. */
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 76a3cba6f23c..c89c88db39d1 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -183,7 +183,7 @@ int BPF_PROG(test_global_mask_no_null_check, struct task_struct *task, u64 clone
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("Possibly NULL pointer passed to trusted R2")
+__failure __msg("release function bpf_kptr_xchg expects referenced PTR_TO_BTF_ID passed to R2")
 int BPF_PROG(test_global_mask_rcu_no_null_check, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *prev, *curr;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 186b56357110..ac4003bfb8b0 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -252,7 +252,7 @@ int reject_untrusted_store_to_ref(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("release helper bpf_kptr_xchg expects referenced PTR_TO_BTF_ID passed to R2")
+__failure __msg("release function bpf_kptr_xchg expects referenced PTR_TO_BTF_ID passed to R2")
 int reject_untrusted_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -364,7 +364,7 @@ int kptr_xchg_ref_state(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Possibly NULL pointer passed to trusted R2")
+__success
 int kptr_xchg_possibly_null(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 404f7f9d7150..0ca2e1a38a94 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -179,7 +179,7 @@ int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_f
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired = (struct task_struct *)&clone_flags;
@@ -225,7 +225,7 @@ int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_flags)
 {
 	/* Cannot release trusted task pointer which was not acquired. */
@@ -353,7 +353,7 @@ int BPF_PROG(task_access_comm4, struct task_struct *task, const char *buf, bool
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *local;
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index a3d2af8dc839..b277b1efb8c7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -177,7 +177,7 @@ __weak int subprog_trusted_destroy(struct task_struct *task __arg_trusted)
 
 SEC("?tp_btf/task_newtask")
 __failure __log_level(2)
-__msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
+__msg("release function bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(trusted_destroy_fail, struct task_struct *task, u64 clone_flags)
 {
 	return subprog_trusted_destroy(task);
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
index f3fad911b5bc..799db6f5713b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -1288,7 +1288,7 @@ l1_%=:	r1 = r6;					\
 
 SEC("tc")
 __description("reference tracking: bpf_sk_release(listen_sk)")
-__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_sk_release_listen_sk(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index d59b2f905671..2a136c917680 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -603,7 +603,7 @@ l2_%=:	r0 = *(u32*)(r0 + %[bpf_tcp_sock_snd_cwnd]);	\
 
 SEC("tc")
 __description("bpf_sk_release(skb->sk)")
-__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_sk_release_skb_sk(void)
 {
 	asm volatile ("					\
@@ -620,7 +620,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("bpf_sk_release(bpf_sk_fullsock(skb->sk))")
-__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_sk_fullsock_skb_sk(void)
 {
 	asm volatile ("					\
@@ -644,7 +644,7 @@ l1_%=:	r1 = r0;					\
 
 SEC("tc")
 __description("bpf_sk_release(bpf_tcp_sock(skb->sk))")
-__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_tcp_sock_skb_sk(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 2cea3d9c3647..b5f456d57669 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -80,7 +80,7 @@ int BPF_PROG(get_task_exe_file_kfunc_unreleased)
 }
 
 SEC("lsm.s/file_open")
-__failure __msg("release kfunc bpf_put_file expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_put_file expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(put_file_kfunc_unacquired, struct file *file)
 {
 	/* Can't release an unacquired pointer. */
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
index d4d0f1610853..ff9ea5aa80ad 100644
--- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
@@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
 }
 
 SEC("syscall")
-__failure __msg("release kfunc bpf_wakeup_sources_read_unlock expects referenced PTR_TO_BTF_ID passed to R1")
+__failure __msg("release function bpf_wakeup_sources_read_unlock expects referenced PTR_TO_BTF_ID passed to R1")
 int wakeup_source_unlock_no_lock(void *ctx)
 {
 	struct bpf_ws_lock *lock = (void *)0x1;
-- 
2.52.0

