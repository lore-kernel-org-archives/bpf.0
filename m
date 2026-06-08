Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73143DEAFB
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930127; cv=none; b=gwWiYhmMKnYBh52Bk7wE0M6JgwJ4v9e3CeWsV2idsJA038q25Gz6Gbb0salnReOvcc5SqgICI5t70cldkbHqwoG7WoMbV4Vi4TvG+YDhrzeHEhTfQ1vfImVaBFjkANReVhcMqxVUSTHK4DJilSzPFx3+HmhsowYmC418gxBAm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930127; c=relaxed/simple;
	bh=/Cy3NxzmsLV48pkFD6Kb5gjUyf7HWwtzMj+ScXPvRrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6rdz5sCvtv1wSpSX8JZV3iNs+soD/wlUUZ6slSGhtOzWNFKB94xojmQgY6TL6j8QbSMQxGzdTFQvO2mmGfq7YmqBz4f4eAUABhqXrcxjFvqmE5fAzE8YaMhRtrCv3/2ETEGKlfU0h+QOyKND/26VTJJq+udmmNfgChI8uFFbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkE/4R+g; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkE/4R+g"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so36818635e9.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930124; x=1781534924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKtVGxsu6RwAnK1V9OojbyWlUqbsVTWouxAJah2IUJg=;
        b=NkE/4R+g3pJyzIadhsEj43+bC5K6iE0H8/2EucxeM7n8myuF1gTct6PFQlSIvpeOfs
         XWHA6LX+YhJMRKdAzVGH89EZp/DuekcE0JFIskuZYda0QQNQoZ+J3rZD2k0jaRHeHdBF
         bX4gV5qsqWyvz09Cyz7/q8HKq6phSla1kD6hnMa1d0j+FruDtVHKWSRGcffu4PGxFjaO
         WbK+EXlZV2DAGt7G+3v0OlQr+UZprqxyVSdgm9GgfrkABktDSEASXVtByXN5ot43Q4QK
         W1MGSfYCrvwXxXDRZ/1ZBlINUBNSdVh2FQejs2+/cqC1zFa7DwxZoQHGXkxYl2DrD8Vx
         QcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930124; x=1781534924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKtVGxsu6RwAnK1V9OojbyWlUqbsVTWouxAJah2IUJg=;
        b=ImgAmBj+yZ7dJeb+Nu/huZEH3QaWC8c8tYGHGfL11JzKEMb++Mfkn6m4aXv9Kxe29f
         J3yENqP4svAcLqiFQgnPbWgzmfglhHyuEHizBnxAmWkwCjjpuKATIsHlFR9qGyFlhVb5
         RhoUOwfP+Z/q57a41UoI6TrepsoOjd6Bz8S6Q21LTCwmx4BaHtjX4wmSiSIirseEi7bv
         24EwjdnzrNtShDOurSn5zNG+B52gUYpMehUdc59nFeLnBVSjoUHPVoIzaXFmb88XloYs
         0DXslKBVPXqRsi7npAyE8Lw6oOI3vaZ2XQGCiOPt6uwp54jtPPUK+cx4o55cMVMZm1Va
         Rxgw==
X-Gm-Message-State: AOJu0YzjSuh19u3mHwbJ9VXzCx2HYjK7l7GeQLvSSjht7xFdyY0VKcQf
	ZS16R1HYjFLjlVeYd/PDVCRolHNd8xndVYESuzxTlzM3ZXcNlAxP2zh/SRwTH8u7
X-Gm-Gg: Acq92OHzePMmQ4iBZAfmfDQFKVyY//O9aZ/hy1zFmP/jaMMHS8RVBZHnqKIvfBMTte6
	lWmagEOdG46sjrt6vIsGbi5bqwtxLxV6mY+Z6kapT6wx1ds6t6z9fPa76a2ws3Y5vo58ZDlNDIZ
	suGFYwMFaWCF3pVZny2LdsvLYS3JZWszDgHIo7O2YmUf/iSjD2PXRQMHsjxstqhx8NWNBKQZRBd
	5xl4H/Uo0ng45bRQdDTJ9H/4i4LVyVRYMKhwR4HeS9+fs+L0nlFHgv6wM5NLEo5S7bX2cKCcjmH
	DwKHtXywVRnS3gL4bL9bsep1KLWji5snz10MTTSagHOyDWpC/eY2UdBMmBPA5Dtx5wXZX1nSzxF
	S8UMj3iWpzKvfqxCUKTX2ZoZwVYFKkD5+/g9fhZPcl65m1Vt0cTOLsTlPruMuDWcFReoa6NKTB+
	Rgo/YC0VwPAq81JZJw2UHvmTItG+PbRN14R9IjCy8rggf/ojgA+ZzoraaZLdvqB05dce6akQS0j
	FGbRs54625D+yW4dZSej2Q7vRHRn/jNdSX5xrrVuBGJzN7sumhaCWLhhiks8nlp6YXIKMyKN+mH
X-Received: by 2002:a05:600c:620f:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-490c2612e9amr243134075e9.22.1780930123973;
        Mon, 08 Jun 2026 07:48:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc4082c3sm385512735e9.13.2026.06.08.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:48:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Justin Suess <utilityemal77@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/5] bpf: Reject bpf_obj_drop() from tracing progs
Date: Mon,  8 Jun 2026 16:48:35 +0200
Message-ID: <20260608144841.1732406-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144841.1732406-1-memxor@gmail.com>
References: <20260608144841.1732406-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8637; i=memxor@gmail.com; h=from:subject; bh=4U88F8nHW9iA3tcSYRWKGrRPJx6mxOt+2zR0Undfxgg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUvtmhR7f8VUbr2D5QHvHnFO5am8NEuRhSlb+0he8f/Oo vva9y07SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJHaWIZ/5gUpTeIewXuetmv9 aTulvGkri4p37vuPZ9oXamTdXfj+CcNPxp6rOvFKgZL9HJ5Pgvh+ZT2w8fkR5xc9+ZHQbNZf/Nb cAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Justin Suess <utilityemal77@gmail.com>

bpf_obj_drop() runs bpf_obj_free_fields() synchronously for
program-allocated objects. When such an object contains NMI unsafe
fields, a non-iterator tracing program can reach that destruction from
arbitrary instrumented context, including NMI.

NMI is likely one instance of this problem, and other instances would
include possible unsafe reentrancy. Deferring bpf_obj_drop() is not
appealing either: it would add delayed-free machinery to a release
operation that otherwise has straightforward synchronous ownership
semantics.

Reject bpf_obj_drop() and bpf_percpu_obj_drop() from tracing programs
unless every field in the object's BTF record is explicitly NMI safe.
Note that while bpf_rb_root and bpf_list_head would be NMI safe on their
own to free, the objects recursively held by them may not be; be
conservative and just mark them as not NMI safe for now.

Use a whitelist for the NMI-safe field set instead of listing only known
NMI unsafe fields. Locks, async fields, unreferenced kptrs, and
refcounts are known to be NMI safe because their destruction is either a
no-op, simple state reset, or async cancellation. Referenced kptrs,
percpu referenced kptrs, uptrs, graph roots, graph nodes, and any future
field type are rejected until audited for arbitrary tracing and NMI
contexts. This is less susceptible to future changes in fields that were
previously safe by exclusion, and to new fields being added without
updating this check.

Convert the existing recursive local-object drop success case to a
syscall program in the same commit, since this verifier change makes the
old tracing program form invalid. The test still exercises
bpf_obj_drop() releasing a referenced task kptr from a safe program
type.

Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           | 29 +++++++++++++
 kernel/bpf/verifier.c                         | 14 +++++++
 .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++++++++++++-
 .../selftests/bpf/progs/task_kfunc_success.c  | 13 +++---
 4 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 62bba7a4876f..0654d2ffadc1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -492,6 +492,35 @@ static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_f
 	return rec->field_mask & type;
 }
 
+static inline bool btf_field_is_nmi_safe(enum btf_field_type type)
+{
+	switch (type) {
+	case BPF_SPIN_LOCK:
+	case BPF_RES_SPIN_LOCK:
+	case BPF_TIMER:
+	case BPF_WORKQUEUE:
+	case BPF_TASK_WORK:
+	case BPF_KPTR_UNREF:
+	case BPF_REFCOUNT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool btf_record_has_nmi_unsafe_fields(const struct btf_record *rec)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return false;
+	for (i = 0; i < rec->cnt; i++) {
+		if (!btf_field_is_nmi_safe(rec->fields[i].type))
+			return true;
+	}
+	return false;
+}
+
 static inline void bpf_obj_init(const struct btf_record *rec, void *obj)
 {
 	int i;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26bfb4465725..d636484f1d6c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -205,6 +205,7 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
+static bool is_tracing_prog_type(const struct bpf_prog *prog);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
@@ -12970,6 +12971,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
+	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && is_tracing_prog_type(env->prog)) {
+		struct btf_struct_meta *struct_meta;
+
+		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
+		if (struct_meta &&
+		    btf_record_has_nmi_unsafe_fields(struct_meta->record)) {
+			verbose(env, "%s cannot be used in tracing programs on types with NMI unsafe fields\n",
+				func_name);
+			return -EINVAL;
+		}
+	}
+
 	if (is_bpf_rbtree_add_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_rbtree_add_callback_state);
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index 83b90335967a..e6e95c1416e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -68,6 +68,36 @@ static void run_success_test(const char *prog_name)
 	task_kfunc_success__destroy(skel);
 }
 
+static void run_syscall_success_test(const char *prog_name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct task_kfunc_success *skel;
+	struct bpf_program *prog;
+	int err;
+
+	skel = open_load_task_kfunc_skel();
+	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_run_err"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		goto cleanup;
+	if (!ASSERT_EQ(opts.retval, 0, "retval"))
+		goto cleanup;
+
+	ASSERT_OK(skel->bss->err, "post_run_err");
+
+cleanup:
+	task_kfunc_success__destroy(skel);
+}
+
 static int run_vpid_test(void *prog_name)
 {
 	struct task_kfunc_success *skel;
@@ -140,7 +170,6 @@ static const char * const success_tests[] = {
 	"test_task_acquire_release_argument",
 	"test_task_acquire_release_current",
 	"test_task_acquire_leave_in_map",
-	"test_task_xchg_release",
 	"test_task_map_acquire_release",
 	"test_task_current_acquire_release",
 	"test_task_from_pid_arg",
@@ -151,6 +180,10 @@ static const char * const success_tests[] = {
 	"test_task_kfunc_flavor_relo_not_found",
 };
 
+static const char * const syscall_success_tests[] = {
+	"test_task_xchg_release",
+};
+
 static const char * const vpid_success_tests[] = {
 	"test_task_from_vpid_current",
 	"test_task_from_vpid_invalid",
@@ -167,6 +200,13 @@ void test_task_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(syscall_success_tests); i++) {
+		if (!test__start_subtest(syscall_success_tests[i]))
+			continue;
+
+		run_syscall_success_test(syscall_success_tests[i]);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(vpid_success_tests); i++) {
 		if (!test__start_subtest(vpid_success_tests[i]))
 			continue;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 5fb4fc19d26a..d63a79ee33dc 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -140,17 +140,17 @@ int BPF_PROG(test_task_acquire_leave_in_map, struct task_struct *task, u64 clone
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
+SEC("syscall")
+int test_task_xchg_release(const void *ctx)
 {
-	struct task_struct *kptr, *acquired;
+	struct task_struct *task, *kptr, *acquired;
 	struct __tasks_kfunc_map_value *v, *local;
 	int refcnt, refcnt_after_drop;
 	long status;
 
-	if (!is_test_kfunc_task())
-		return 0;
+	(void)ctx;
 
+	task = bpf_get_current_task_btf();
 	status = tasks_kfunc_map_insert(task);
 	if (status) {
 		err = 1;
@@ -191,7 +191,7 @@ int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
 		return 0;
 	}
 
-	/* Stash a copy into local kptr and check if it is released recursively */
+	/* Stash a copy into local kptr and check if it is released recursively. */
 	acquired = bpf_task_acquire(kptr);
 	if (!acquired) {
 		err = 7;
@@ -220,7 +220,6 @@ int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
 	}
 
 	bpf_task_release(kptr);
-
 	return 0;
 }
 
-- 
2.53.0

