Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC23905F4
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036754; cv=none; b=PXSwpNg4RpVs2aaREixCarBkmAv5jzT1wi76/tqS2Irf4uzRgo2qJxE/4W86pj2wXZHJyrUyUuYSOSsqJ53Z3ijh0bK6WNuG8F+VhOQv8U7qH+Th9fQgq8vqqF4seAopJCJHxrs6h3zeDAm3EpIgfR+uxNQ1o0WmlPPM93q4fJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036754; c=relaxed/simple;
	bh=uT9Og2AUhwDKf6SzZTimV/urnFbDBKg10QJ3+WAPEek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJeuaBHuPTsgoAz7ROPM5pEnpYNHgen6ppfnqNB7nQg79mxAiU782Gks4Eco8wh5wsk7jKg4QVeQC0A2ugXRvLapLUi+8ZDp87g7zNh4QNgRVWf7/ipS5Lx2y65ZL/J5JxYyXPy/AEpeVfEeUNFBapFfIF5HTilGVQvp3k6EpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEGxrKoX; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEGxrKoX"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so4442657f8f.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781036751; x=1781641551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cwtTEONv5qdnBgAfNW5QGDhHiM9gsPAJqns+TeiRhc=;
        b=UEGxrKoX9MwMy0BCAGNjCtEe/hNSDang0qug/RbQq0FiJ7oavq+XtN1Bj6OuRYeHca
         bn1VGq4d/RL7XAlIcbhUZcIVx75vWp5YFNFfGqG6vUiwJ+m0zvGbLqe8JO5F1nb0fn58
         dzm5zxtaKsZxnyANP+WNxDAoHnVtSOUw2ool6ARfVoXE5dcFSXwcb2pli4UQz6lXU8RB
         iQGbUHntHeN1Py8F7Hmr15UY6Nw6tCE547np6dkefqOG10DDHve6FmHsyPU4ZLZYZMQM
         UUiRLOoNyuJ4hSH9DtMKv0xFWeEUiTfc2YHIQIZM0X/sZIAf39okUv/b/lfsB4q2vfDU
         E4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036751; x=1781641551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cwtTEONv5qdnBgAfNW5QGDhHiM9gsPAJqns+TeiRhc=;
        b=d6zKlFkijL71rP3PGysILb4l1rJQfwP3JL0w4z9eXMQ7p7F6Eafj9fuM4lmHnQU8Hl
         ClrGYHRwhkLl/jI084dtwztTEwg/mZCt3+jrn4f1t83SxvsRkwygrKDJzzjcCxCgk9yp
         SKm1aaDEATWPw0qPcNHtknP1PUNbNft8H19VT/MYShGxSL49U3vGLoyqAS5d1KxJy7W6
         4lar9JWr4zTAaHhEPeGlqGJzcpJEsd9KxwLFXnEqh+d8spSrJOPCgugS2CMgmLHHcfNP
         Ti5CNhD3zkADBhXZMrMbPooVlMJKuczxAZ95xlaABdLwB99YXDvwWyXJAus2K2YxxgHh
         EC6Q==
X-Gm-Message-State: AOJu0Yyre3aJUaxKUK4GV5bgcY8ukpScs89wlk4WdPIAzeFVIEdsmSlT
	BhjcBAUBmz2mEOYtgR9LCYo1D4zzrArPqGbGXjdoZlzBndFyL0bAMiAoSAGLXhB+
X-Gm-Gg: Acq92OGeSs5N76wb6veYTTgfYo4pc3CYwqi6XdCU/YH0AWfc1tAebNJIe8in+mSDQcf
	0+PUCt/IYUkOVuzup/gDplDgNqsBwVW9QFovbOMcRdes76TCNNeocGYTc3g+RxD+FtcxZ4inhKv
	BJX5lvtTdk1QB3R3EtgaqxVETiNrBbX8txvZI5LIx/ouUD2/3q6w9xslyt5wu5gdPZNWRC3U0Hj
	W1oExQcEX2o3InX0LUYrqYMHNRdZsPsUJeVtBJox5obdH0pizabAqCS9SWeRfjsjc60bo9LgAwG
	Chm6ZHGhl1EWXvXkXY1XsciTYYMXBK0FnKY9NRyr56k/AxQtzakVapWEVTLE7F908rF16PDK09M
	xkC9bfPG9b3skO8FQ513RIq0JkU2GL1315JoeNowtvqRLsRD7B7RQpMoDq+8l6jej3n8V5NoXPA
	NNob2eG/PaDyfO1yQD54ZPOSabcxMW1H+vY6dhyYwyZvaZU9LvpSm50IkVCT1Es9++8xmeRdrQO
	n+x8gEDjgTnF0fOmDm/umpTd4sloRvaWLHVEfqZBuIy2+DgW84NDbtEdQArHtd4bzPG4SE6eE59
	r92q3dWTjnA=
X-Received: by 2002:a5d:5301:0:b0:45e:dabf:a00e with SMTP id ffacd0b85a97d-4603061ed2cmr25147802f8f.31.1781036750777;
        Tue, 09 Jun 2026 13:25:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm58234764f8f.30.2026.06.09.13.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:25:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/4] bpf: Reject bpf_obj_drop() from tracing progs
Date: Tue,  9 Jun 2026 22:25:43 +0200
Message-ID: <20260609202548.3571690-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609202548.3571690-1-memxor@gmail.com>
References: <20260609202548.3571690-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9445; i=memxor@gmail.com; h=from:subject; bh=18O1oojJbdveBQqfiGgwyNJC7ouEpZ0svhsfrnTEPHM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUujLDa90jhAb7uEcT37xHZFlZ/rAxlz09Y43vx4tW5LS 4FxhV5HKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJrJxNiPDnNvrlVxZPDiqq3Km iuxc/LPdSznr3PaDXtfUuPsEl38qY2Q4ebWr/zjnvs7r7BYBOd0iDkViFiIW986++yqcYDF75wl eAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Justin Suess <utilityemal77@gmail.com>

bpf_obj_drop() runs bpf_obj_free_fields() synchronously for
program-allocated objects. When such an object contains NMI unsafe
fields, tracing programs that can run from arbitrary instrumented
context can reach that destruction from unsafe contexts, including NMI.

NMI is likely one instance of this problem, and other instances would
include possible unsafe reentrancy. Deferring bpf_obj_drop() is not
appealing either: it would add delayed-free machinery to a release
operation that otherwise has straightforward synchronous ownership
semantics.

Reject bpf_obj_drop() and bpf_percpu_obj_drop() from tracing programs
that may run from unsafe contexts unless every field in the object's BTF
record is explicitly NMI safe. Do not reject sleepable
BPF_PROG_TYPE_TRACING programs, since they are not the arbitrary/NMI
contexts that motivate the restriction.

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
 kernel/bpf/verifier.c                         | 17 ++++++++
 .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++++++++++++-
 .../selftests/bpf/progs/task_kfunc_success.c  | 13 +++---
 4 files changed, 93 insertions(+), 8 deletions(-)

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
index 954b85609f32..eb46a81a8c51 100644
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
@@ -12957,6 +12959,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
+	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||
+	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
+	     (prog_type == BPF_PROG_TYPE_TRACING && env->prog->expected_attach_type != BPF_TRACE_ITER
+	      && !env->prog->sleepable))) {
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

