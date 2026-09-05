Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93626AF4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645714; cv=none; b=EWBQIZ7C8ox45ZhyPIDMpIYVji5JyrY8yndRXibowffPFgwvvs2ykjbEu/inTRT99lmmAeYsOF1FtssJN7oxskmTV/rfDRnNnrZn0AyW4CEGcCaKmTuhDEsCvZvgpspSBPDc5GMQyll10uNltv+4XQH8WVTLkjmWB7X0uB9EWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645714; c=relaxed/simple;
	bh=gtjiJOlPiz/hznSsG0MP74pCNAIDnRVOBZ/w5XwjnO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYmpqOqIc6tU2F/9T8rYQc6++FWhRocd8I86J4Ye1wPdIfYQsiEWAK7m6hkRxw7VAQFnvAMNrWXZebFCcKUEFgWP8VahlXeaV06OKDflGXk0E/n938nL4DUYkNXXgT623cFHMrT2ea5KjO+d41Y0k7+oXHWOKuEReI5RWPNQJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVl+bMLX; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVl+bMLX"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b1a1a442c1so1618647eaf.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645712; x=1789250512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVB5ucBlLHIE7YoOqzr3JMq0I8KKkr8XOXa9A08WXZA=;
        b=oVl+bMLXxDiSyauo84BeCfmS+gdcVT/uJQqtV4Z+FcdXDUD4tW7T30rl3Agx5u+fq6
         1F7rDA/unHdQWczu3U9RE8lIN05uM6k9VcJTlq+VeIfXBBiHarNV2i766TnDIwz+n4jm
         XUR2kaS3BFCRd85VMRoZwsR8dks72PRPb97cdrNkFdE3cokuIP8azCV+eqoiVWN7ZP3C
         0TpXNCrus+qibErSngUAuhIClCmK7M6l3EguIk9iVDE/52wT2wYEBXY4CeJ8UvCGc//x
         9OksGAQkphKh9rAf2EwbMjBtMXWgR8MlT5padSXQRj9xok+kqKREJtDYWbVSsz/Dp7Zi
         iUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645712; x=1789250512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lVB5ucBlLHIE7YoOqzr3JMq0I8KKkr8XOXa9A08WXZA=;
        b=hLv9LaEWy1/2ZJPRA1Aqqes70V7REEQ1P/9b6dGxO9Nm1zAuZiAuzEGsfqajVrnDB4
         EJRBLujJV4c+UzTv1VSTcN1mKxniwtHuQCP7fAWxgjtcDwpD0kOV/G0V9W+pnuTJu8hs
         ekontXkgthjid/7j7idlIq6fauXfvewXguJUOuByAnJ5dH4iIUTy1j4EmkrO8goypc/4
         D69+Q3hMWaxYwVhQ/U9EtW0hBf5WOcBwxhhZk0D7og08iBnWXApkLfzKf9g05T/tD+6C
         il0dZ0KFtiJJK9403z4QceyTg0tySN67bDGOsugCSeI1kKUKrp10guKAZIPz9O8rldSp
         TsDQ==
X-Gm-Message-State: AFuF++k8acu2kPQJ1sCrpUj0rLF5mPgwZbMMfNl6xpF7sPmzN1CRtBS0
	VBJdw87y65qfonlXh0P8qG+vKVlxMProQ8HqaaHTIOV/vLJ3sY45buCY3STaXQ==
X-Gm-Gg: AYBFou1w1CnLaPPjCzFEuL6lV+x+b+DQso9V+SJD0u9JFdopYxNqw3WuVpUb3Y4+b8p
	gYXcDhROXS7taUR5z49TSWk3Cu1ggPajvVJFDj55pF1Xcda/6KJiE8Ci67N8oOZohos6d0g6Iih
	8S2AbFw1azMk2nj60N4AhErCJjAYn7CYGw9d5KedW/7qOKd2V9Pv28lAo9TzpQOThqW4img44I9
	voxRaNEgTtQu2izaooABBNlXzPihCLyYWGSvcU3o+Fu3VwdS8kwpwUse+C+8kmj8S3Pi8YWN3QH
	4uXg2ivTE9Z24Cs1665W7UCarVO8xKAKErKzsULz0wZ3k/s5FiafRLDafvkvGPE5PmPnxD288R6
	nQtR6sd0LBfVetDLTB757YZpr4xKbC9S09E+oXtpFL0IOgttxT6eeVx++YkYwZuWXJwbXcyz+Zf
	lWe4H0vmjxS4xeyMFawQayQyxOFrkyCsQVf6gJ4MrFrejx7di2gdlkg0lYHClBvQ==
X-Received: by 2002:a05:6820:603:b0:6b1:b867:1a1 with SMTP id 006d021491bc7-6b6fc7d43ccmr14245722eaf.12.1788645711596;
        Sat, 05 Sep 2026 15:01:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47554935962sm5539723fac.12.2026.09.05.15.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 21/22] bpf: Consolidate release argument validation
Date: Sat,  5 Sep 2026 15:01:16 -0700
Message-ID: <20260905220117.922028-22-ameryhung@gmail.com>
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
 kernel/bpf/verifier.c                         | 79 ++++++++++---------
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
 11 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 487ad1ee4179..6c5d7e544f84 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8418,6 +8418,43 @@ static int check_func_arg_nullability(struct bpf_verifier_env *env,
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
@@ -8825,29 +8862,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -12990,19 +13007,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
index 50ea3d72d446..8743f52e755d 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -11,8 +11,8 @@ struct {
 	const char *prog_name;
 	const char *err_msg;
 } cb_refs_tests[] = {
-	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
-	{ "leak_prog", "Possibly NULL pointer passed to trusted R2" },
+	{ "underflow_prog", "release function bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
+	{ "leak_prog", "Unreleased reference id=4 alloc_insn=33" },
 	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
 };
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index efe7bcae70f8..8de2206875ab 100644
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
index d1ff9e7e87e3..4b64f1dc7b81 100644
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
index f96b0c13ed1a..639276591902 100644
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
index 0bdeb7bc4687..87604020ba21 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -153,7 +153,7 @@ __weak int subprog_trusted_destroy(struct task_struct *task __arg_trusted)
 
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
index ff08aa75d6f7..7d4d894b203e 100644
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

