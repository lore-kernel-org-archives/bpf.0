Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA639FCD7
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997846; cv=none; b=sFYsW4TwgetV17reKJ9rksZ/lwKYoSNAjLFMmQaxt9wIRBWo0P/wIf+VKdgJo+sxVBrqpjXbAuB8IYP6fGhx1KipfYzwzsHTARFDAyMYiBARc/cqvHpXMQ+carqRgoEgD7m7XVmG+ICqnRHIW+6Ud4/emZgHE0NFOf/BrWVkcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997846; c=relaxed/simple;
	bh=mBwaNPmfQPu+i0Utw0f/9AkbZI76mXk6OR+QYi3BXyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj6mMqYO3SbJYMSrTFzRSaQkxG21OfCv/G4K1hIOjvZN645f1tn8o8AKi1L8UQmwlCUozrgP0aN1VQAvUi9qL9uOiPVBwVe68KY03tTkPc9fr1L6xlAxB57l7Gt1FLorEIgdYVHmEqcr5RTffDyNLxI8m3Wd3D/g3uei8i3R4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5ZdC0s6; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5ZdC0s6"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4337130f8f.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780997843; x=1781602643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeiPc0vbRa94CmWykE5q21TdtlgAS4gf3pw0fJXoQoE=;
        b=P5ZdC0s6ckgKT5N2MJh379X1n0tw2vduTFNKEIPfnYkgrxwZ1ZGQthd+VkdhuMczIc
         HXGP1TrZ19MMxTx4eCIqu9B6g6fhs5skZaIFe7W9i637XTInRPnjmOIur17F+2iYlsuc
         UOnBd6r9HFcVNtV3yo6gJC16/Oeyvcx1bl1Y5K2et51C46bg928O/Gg2lnDJT/XTWkI+
         B+1hR0lb6fchffyzai7WJ7FO2z3e1aLXteFj+F5Ey2V2sRFCAtQXpyhkrY61TOkmKQDD
         yF97hciqv41y44VZAFraovT1g48PjBZZyiw3LU4m57EVObrlSGRyH5L1l9Dojye/tl77
         RY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997843; x=1781602643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeiPc0vbRa94CmWykE5q21TdtlgAS4gf3pw0fJXoQoE=;
        b=asxs3ItvEkIac39bZv78uWbUcsJQohBjITCgraHwsY6rVwwaAlvBS6q4ivgbyXtn5v
         pjY5BVbfdFOLv3Gzg2YVjW0avQL5U+fmkVeEYnkt2YDqr6ATdE4SEWkbgZHXc3llVZoo
         ogHMgR4I4Vtyumm1LtJaS0X69QhVVtHp54moGmvB5QwdDxxdUeze7G7VS2hylDGvv6WC
         vtVS+S3E/40vdpgxERaxZK+xaX+09Hi/Z/2CVIO61AqUt8jrD9VX3Pmq27WKcrtKsxx6
         Doqms8yLbmHwBYLKS3b0dB566yU7MQ/llJzNPES40vTd9glJHfeY8kmfLn7RMWLs4/W9
         nMug==
X-Gm-Message-State: AOJu0Yx4VUbLDp3YbeWi1yrJ6fMKj4Kxdjwai5fqUvexNPoKTTmMBZ7y
	pPgEpLXBbSeiIAd3rQdAv71FhT7DnSMttbU84s+vT1ewdTU7S50VDOchnL/6ASnW
X-Gm-Gg: Acq92OFJFn29dhV43UmzU/amXr8Nv3YjY+lEWjDd8sHN1FvvLEyRsklZc4MK1SRVE0U
	lM+SdN580Gm7/4VhtitxLVQ5HNHWYl23CIAER1W+aQD8M2vIlj493V0p4PqvRm49b460+jLwo/N
	88iRRaQ6ugbp3OxU/ex1kde6IAGCqhxxtV4mLUgKEkvkFUSMSAI/YpLOVNAnjRCExQuFOyuJWtB
	f3z393OXmPwFMFMAFdVh0aFpp4aItyjr8V+OLh98rpch8rYw2qcvx9fFn3pGtuy7N2yp+Utn2v2
	+Y+p/hh0iIzlPPmRh0xURcPvelvtFPA4WYly5b92EeruyssART45qcKekP/vrR1bpPpP3t7z1+D
	pLDjaK9quD/xmNlSY1fvA698f0+TZyWYSqnjMyYm3uacOWN9dHcYBbuNGs/ruWr1Sg9SytwZY65
	PV3KHgmss3OIy55mm2H+JxgtqHKdxfGEbc4LgjPTFM0wHrQpWs9nqY6WAF8B9psVfpbSVE/GAy3
	O28pqa/7ggWGSVOUFpBX+zHpB6ucrebeYI7d3jfIwa1YGVXM4zoFG02Kq8QgkDqzOQSdmpeR7FF
X-Received: by 2002:a05:6000:d07:b0:43f:e22e:e8da with SMTP id ffacd0b85a97d-460302e0882mr22695262f8f.5.1780997842757;
        Tue, 09 Jun 2026 02:37:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm61917302f8f.3.2026.06.09.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:37:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/4] bpf: Reject bpf_obj_drop() from tracing progs
Date: Tue,  9 Jun 2026 11:37:14 +0200
Message-ID: <20260609093719.2858096-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609093719.2858096-1-memxor@gmail.com>
References: <20260609093719.2858096-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9218; i=memxor@gmail.com; h=from:subject; bh=MfU1TPEgjzsI8a8T1TwkfBWAqfIBJ4G8RzpSeqa8VDo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUv93orVru/8/bauY0xu3Bt9ynVNwwtBV8EH1x8vP1lyZ 0tFyMP5HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIuzEjw68t3Bo2r1790GC+ 4Jv3/YTInUn3C9Zt+qcuoa1gttpzdRQjw9227xcfvr6+gv+EemLoqjSn+b28Pw75Nk37rXsp2iv mBx8A
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
 kernel/bpf/verifier.c                         | 16 +++++++
 .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++++++++++++-
 .../selftests/bpf/progs/task_kfunc_success.c  | 13 +++---
 4 files changed, 92 insertions(+), 8 deletions(-)

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
index ed7ba0e6a9ce..3b43e2bd0f2a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -205,6 +205,7 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
+static bool is_tracing_prog_type(enum bpf_prog_type type);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
@@ -12881,6 +12882,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
 	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
@@ -12957,6 +12959,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
+	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||
+	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
+	     (prog_type == BPF_PROG_TYPE_TRACING && env->prog->expected_attach_type != BPF_TRACE_ITER))) {
+		struct btf_struct_meta *struct_meta;
+
+		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
+		if (struct_meta && btf_record_has_nmi_unsafe_fields(struct_meta->record)) {
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

