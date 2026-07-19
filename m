Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A43815D9
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784460959; cv=none; b=SJxXWFzdmJ59D0/ceO8txAeIk3woc5eV9Ojj5M0ndu3PR42EHxMnql6uZCIndWU+VinAeREu75e2PZidVsvbZzyHBb5GBovjxpVkR22iw3lRMupaa6BUBAQAwajdTl4+c1pKkqBgmgpls+C6emB/g/Y9POY0ndZINTIPJgwiWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784460959; c=relaxed/simple;
	bh=FzRbRBTLCps2I/T7eSASQhARyiyap9BskdP59BwUulc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slz8jFZThld3WKPTqRNq0QB9pKCv+HNo2Ba0FTgztV4p84lPbg/+6cRQeKuwSDwRttCbUAGI3/+Ab+c8N8HQnQLjU1F1dSf1E9YQTCCe+eJYCfdMLq01AJmfOKcON816ZWnsDwgEzsK+3CbD47JDfVav7x+iyl3Jdq91ggXo2N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEZuN/L+; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEZuN/L+"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so1387055e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784460955; x=1785065755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZ1jt3lk2tEyxiML3vvCKS9liqnuIp7XKU6l9GRir0U=;
        b=MEZuN/L+kBqxBrPXDHLJ3v3xFNkcso+BgyNk3l38/7r7B6ZtXpaeBagmip/5DHYR9Q
         beD6R1AekwYPTF7LGAlj9YpERNCE1ZU3Fc0E5jSTJPgE1b+dzUPNyg61ylmTBkOs/VdB
         WIDeA2Q6tVpDq9+kqn0tYCQy2nsBd5Ki2jCByuku5UWlnUtzyoN5zRSvtwF0mwWB0nAp
         bkLCIHXthzOSX5wB5sG6swnKdXdCm9wuzVioiKF2j5/5O95oxQahxqHFtXSwCnXClTwU
         HxFPeXC4yriV29Xbyy6sIMFE19PZpKElaanflgKEAVTxM2+vxtfy0n4WMMf6TkuB9m3z
         GPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784460955; x=1785065755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WZ1jt3lk2tEyxiML3vvCKS9liqnuIp7XKU6l9GRir0U=;
        b=hbCLJgHNH8zLGeJw/109Wi7Cp7R0w/IFj3oePxxoSPJs5y/XovE0CJ3ZdwwysDh024
         pi8b+GE4Ngf44rq/FsD854ge0QbzVJ2+yCCzT3UTBmGlBCzwHBJY2EPMO08qA23771fo
         QYRzC/YtZLXtn8M7Tix/9qBlY9Ue4eOfprUFYH2FgjvT1M2UOy5jZzBu13PkdA1o3GHd
         E4+4JByl+AnjRiqh84+uDrfHVSqStBpFk1UH+jE90dzTr6cUlid6O6gAOdJozOv2u8hL
         19FJHH0l2YOIk6SvgK45ReOohhJExobAQHR7qL3Jv3Rof6n10b8mfB7PEm6Q+TCMV7Kt
         AupQ==
X-Gm-Message-State: AOJu0YwETTarBgN07wb+WadUPBitmu3fRulSq5teaqRk1zPLodjV9CNk
	pm7Y/JEX0XV70oxHnJGASpRDssEcURq13qQ6ZbPSNf/3+Y9rPZiO9Wj2EloW06LE
X-Gm-Gg: AfdE7cl/lnV2u5rmZ6ZXyGUpMjvBi7jHbmboIvdHZU9vVWuzNMQR9fvSCAnEzmyCj3l
	R7JVANAfDdQi5CeKukNjAazBvOuuCNay6Wc1BQ0pU7UBYX1OkCit5QvXMII/fcCKB1YK9/VE+zI
	CAD2tI3ysXA8GKOUkniVbtTH2YqOHNcDVLlrxchszHPGeTt5WCalTTLd43bUBlBKEXww9Gb3MU6
	mwtPLxwRA2UavfMkGQ/rd1d+F+3jSV+RtFQy/TteRpPI/JaJpek/Y4QLgsiBULW7BodLO5zt6xj
	ni4EI07/P/6qJMoBXmk0m+l381QyGlS9X7+rt+y4Wcu7q3c5Xi5B8ywaTHMEPYHf92XlWaLyBoL
	+kEVDZ+sXcE/EukKKS/js6LmxZYpzGK4K/DweRyDTihgRHV0aLLDPNym8YtDysM8kza5t2SDo/I
	KLxgFT2f74AhVsjQnKRjYjaeZSx4snWFP0ZOXHxFql9AFcFXTt+4x5rqW0EVIW45u5MBswgD7xS
	NW592hyructCPlb2W780x5jebs2v6r7SS8v7/YGzeCL
X-Received: by 2002:a05:600c:b90:b0:493:c42c:7e87 with SMTP id 5b1f17b1804b1-4954a50885emr99247865e9.33.1784460954989;
        Sun, 19 Jul 2026 04:35:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7c69sm21305398f8f.17.2026.07.19.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 04:35:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] bpf: Fix is_tracing_prog_type() to cover fentry/fexit/fmod_ret
Date: Sun, 19 Jul 2026 13:35:50 +0200
Message-ID: <20260719113551.1294284-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719113551.1294284-1-memxor@gmail.com>
References: <20260719113551.1294284-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13472; i=memxor@gmail.com; h=from:subject; bh=FzRbRBTLCps2I/T7eSASQhARyiyap9BskdP59BwUulc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIStmc5fh3MN7rb+fDXTzW/jf9w/frIxn93d/vd8n935lR 8M21n3fO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRSVcY/qeyL1t7M+jRV9Z3 7yc2iS7pZJH8euPzx9j6XsH8t0f7nooz/Hed5PNfeUuqpsJOm68zfuz/GBIxyfNt8oM2L77DcU3 pH7gB
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The is_tracing_prog_type() predicate currently skips fentry, fexit,
fmod_ret, and also raw_tp attach type in BPF_PROG_TYPE_TRACING, due to
oversight.

Fix this by tightening the check, and moving predicates checking for the
restriction closer to the point of use. This change might affect
existing programs using them in unsafe contexts, but in such cases, it
is recommended for users to switch over to bpf_res_spin_lock instead.

Make appropriate changes to selftests to adjust to the change in error
messages and added restrictions.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 48 ++++++++++---------
 .../selftests/bpf/prog_tests/linked_list.c    |  6 +--
 .../selftests/bpf/prog_tests/map_btf.c        | 19 ++++----
 .../selftests/bpf/progs/map_in_map_btf.c      |  2 +-
 .../selftests/bpf/progs/normal_map_btf.c      |  2 +-
 .../selftests/bpf/progs/refcounted_kptr.c     | 10 ++--
 .../bpf/progs/refcounted_kptr_fail.c          |  5 +-
 .../bpf/progs/verifier_helper_restricted.c    |  4 ++
 8 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb6e16668d0d..3fe2410c7ce3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -207,7 +207,7 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
-static bool is_tracing_prog_type(enum bpf_prog_type type);
+static bool is_tracing_prog_type(struct bpf_prog *prog);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
@@ -7089,6 +7089,12 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			val, lock_str, spin_lock_off);
 		return -EINVAL;
 	}
+
+	if (is_tracing_prog_type(env->prog) && !is_res_lock) {
+		verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
+		return -EINVAL;
+	}
+
 	if (is_lock) {
 		void *ptr;
 		int type;
@@ -12317,6 +12323,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
+			if (is_tracing_prog_type(env->prog)) {
+				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
+				return -EINVAL;
+			}
 			ret = process_kf_arg_ptr_to_list_head(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
@@ -12333,6 +12343,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
+			if (is_tracing_prog_type(env->prog)) {
+				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
+				return -EINVAL;
+			}
 			ret = process_kf_arg_ptr_to_rbtree_root(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
@@ -12966,7 +12980,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
 	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
-	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
@@ -13044,10 +13057,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 
 	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
-	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||
-	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
-	     (prog_type == BPF_PROG_TYPE_TRACING && env->prog->expected_attach_type != BPF_TRACE_ITER
-	      && !env->prog->sleepable))) {
+	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(env->prog)
+	     && !env->prog->sleepable)) {
 		struct btf_struct_meta *struct_meta;
 
 		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
@@ -17769,9 +17780,11 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	return __add_used_btf(env, btf);
 }
 
-static bool is_tracing_prog_type(enum bpf_prog_type type)
+static bool is_tracing_prog_type(struct bpf_prog *prog)
 {
-	switch (type) {
+	switch (resolve_prog_type(prog)) {
+	case BPF_PROG_TYPE_TRACING:
+		return prog->expected_attach_type != BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_KPROBE:
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
@@ -17802,14 +17815,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
-	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
-		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
-			return -EINVAL;
-		}
-	}
-
 	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
@@ -17817,12 +17822,11 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
-	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
-			return -EINVAL;
-		}
-	}
+	/*
+	 * Restrictions on using BPF list,rbtree,spin_lock is checked later upon
+	 * use, since rejecting accesing map containing them in programs is too
+	 * conservative.
+	 */
 
 	if ((bpf_prog_is_offloaded(prog->aux) || bpf_map_is_offloaded(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index c3d133c6a00d..702268422673 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -59,12 +59,12 @@ static struct {
 	TEST(inner_map, pop_front)
 	TEST(inner_map, pop_back)
 #undef TEST
-	{ "map_compat_kprobe", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
-	{ "map_compat_kretprobe", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
+	{ "map_compat_kprobe", "calling kernel function bpf_list_push_front is not allowed" },
+	{ "map_compat_kretprobe", "calling kernel function bpf_list_push_front is not allowed" },
 	{ "map_compat_tp", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
 	{ "map_compat_perf", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
 	{ "map_compat_raw_tp", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
-	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_{list_head,rb_root} yet" },
+	{ "map_compat_raw_tp_w", "calling kernel function bpf_list_push_front is not allowed" },
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
 	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
diff --git a/tools/testing/selftests/bpf/prog_tests/map_btf.c b/tools/testing/selftests/bpf/prog_tests/map_btf.c
index 2c4ef6037573..1313f680fcda 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_btf.c
@@ -7,6 +7,7 @@
 
 static void do_test_normal_map_btf(void)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct normal_map_btf *skel;
 	int i, err, new_fd = -1;
 	int map_fd_arr[64];
@@ -15,12 +16,10 @@ static void do_test_normal_map_btf(void)
 	if (!ASSERT_OK_PTR(skel, "open_load"))
 		return;
 
-	err = normal_map_btf__attach(skel);
-	if (!ASSERT_OK(err, "attach"))
-		goto out;
-
 	skel->bss->pid = getpid();
-	usleep(1);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.add_to_list_in_array), &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto out;
 	ASSERT_TRUE(skel->bss->done, "done");
 
 	/* Use percpu_array to slow bpf_map_free_deferred() down.
@@ -55,6 +54,7 @@ static void do_test_normal_map_btf(void)
 
 static void do_test_map_in_map_btf(void)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	int err, zero = 0, new_fd = -1;
 	struct map_in_map_btf *skel;
 
@@ -62,12 +62,11 @@ static void do_test_map_in_map_btf(void)
 	if (!ASSERT_OK_PTR(skel, "open_load"))
 		return;
 
-	err = map_in_map_btf__attach(skel);
-	if (!ASSERT_OK(err, "attach"))
-		goto out;
-
 	skel->bss->pid = getpid();
-	usleep(1);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.add_to_list_in_inner_array),
+				     &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto out;
 	ASSERT_TRUE(skel->bss->done, "done");
 
 	/* Close inner_array fd later */
diff --git a/tools/testing/selftests/bpf/progs/map_in_map_btf.c b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
index 7a1336d7b16a..eb4d009b8a62 100644
--- a/tools/testing/selftests/bpf/progs/map_in_map_btf.c
+++ b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
@@ -41,7 +41,7 @@ char _license[] SEC("license") = "GPL";
 int pid = 0;
 bool done = false;
 
-SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+SEC("syscall")
 int add_to_list_in_inner_array(void *ctx)
 {
 	struct map_value *value;
diff --git a/tools/testing/selftests/bpf/progs/normal_map_btf.c b/tools/testing/selftests/bpf/progs/normal_map_btf.c
index a45c9299552c..90ac1ec365b9 100644
--- a/tools/testing/selftests/bpf/progs/normal_map_btf.c
+++ b/tools/testing/selftests/bpf/progs/normal_map_btf.c
@@ -29,7 +29,7 @@ char _license[] SEC("license") = "GPL";
 int pid = 0;
 bool done = false;
 
-SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+SEC("syscall")
 int add_to_list_in_array(void *ctx)
 {
 	struct map_value *value;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 61906f48025c..9a783693ce08 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -921,11 +921,10 @@ long rbtree_wrong_owner_remove_fail_a2(void *ctx)
 	return 0;
 }
 
-SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+SEC("?lsm.s/bpf")
 __success
 int BPF_PROG(rbtree_sleepable_rcu,
-	     struct file *file, struct kobject *kobj,
-	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+	     int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	struct bpf_rb_node *rb;
 	struct node_data *n, *m = NULL;
@@ -955,11 +954,10 @@ int BPF_PROG(rbtree_sleepable_rcu,
 	return 0;
 }
 
-SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+SEC("?lsm.s/bpf")
 __success
 int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
-	     struct file *file, struct kobject *kobj,
-	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+	     int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	struct bpf_rb_node *rb;
 	struct node_data *n, *m = NULL;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 024ef2aae200..c47fc9d8e27f 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -127,11 +127,10 @@ long refcount_acquire_list_node_offset(void *ctx)
 	return 0;
 }
 
-SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+SEC("?lsm.s/bpf")
 __failure __msg("function calls are not allowed while holding a lock")
 int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
-	     struct file *file, struct kobject *kobj,
-	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+	     int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	struct node_acquire *n;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
index 889c9b78b912..a87792353dfd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
@@ -87,6 +87,7 @@ __naked void in_bpf_prog_type_kprobe_3(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 == 0 goto l0_%=;				\
 	r1 = r0;					\
+	r1 += 4;					\
 	call %[bpf_spin_lock];				\
 l0_%=:	exit;						\
 "	:
@@ -110,6 +111,7 @@ __naked void in_bpf_prog_type_tracepoint_3(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 == 0 goto l0_%=;				\
 	r1 = r0;					\
+	r1 += 4;					\
 	call %[bpf_spin_lock];				\
 l0_%=:	exit;						\
 "	:
@@ -133,6 +135,7 @@ __naked void bpf_prog_type_perf_event_3(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 == 0 goto l0_%=;				\
 	r1 = r0;					\
+	r1 += 4;					\
 	call %[bpf_spin_lock];				\
 l0_%=:	exit;						\
 "	:
@@ -156,6 +159,7 @@ __naked void bpf_prog_type_raw_tracepoint_3(void)
 	call %[bpf_map_lookup_elem];			\
 	if r0 == 0 goto l0_%=;				\
 	r1 = r0;					\
+	r1 += 4;					\
 	call %[bpf_spin_lock];				\
 l0_%=:	exit;						\
 "	:
-- 
2.53.0

