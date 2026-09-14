Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40E49EC54
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424733; cv=none; b=VA51OL1LG0FAy0ulZ7e+RazqAZG5pn+3U7MqlST9DrXq7FCqIQURPXySP8VkGmAEO+co66ywPy5GpPP/QSdF30K9gMWbUQBvD8Veeh2KqiG97af5kW2gystwhiYtm1F+IzEEFMR0vv+k2UVSRBhuW+1Iix2+XjdrExhP2tSRCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424733; c=relaxed/simple;
	bh=JIrYCQUVKUk560+R4Z3OJg+lO34upRZld/mwJHn4V1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUwvKEdPELYtxXyGVJk/2+BZDiN4lBReJhTr59VqcgorcEnZBdWLIie293Gl1KZ+ADXJa4OZFuNbvaKeWzGpkI08TkJJIhTw+tun8k1lvauontUZ60ksvBgp/Fs/N/Tdlo88HfLCMPQjNbr/zfqjBovFlmgUY1BXPY9GBindhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU4BzlXW; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU4BzlXW"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso12421005e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424730; x=1790029530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXcLSHH35OWRapgVtDMftnE6kms58XO6F9CpqVDJO2o=;
        b=IU4BzlXWYssWvvBUG+p9DVCnWorAtZfdAo8gB4r6SVSTWjVESpwkvGLtCPDWWXHJOU
         2ojNepZ3nMTPTo96EY7zyub6jeU9JSfedajTi5k1DUiYF/mTZ0AB7g1oXv07/EmsBhiO
         IPJ7IN/aEOrfnzXSqTmyVYIecz6qUFIAeROLVHztiHPg/duIlsabV2GSHrszSJjC3ck7
         FrD1FUgZpLgPbXBChcicX3+hAzs3M1LDh6LCwLPVuK/ggE3xG1D5lFDfOmWBAUl0vWIL
         Z1a2NvOrL6ftfQprDVHptN+7FYb8RmV1kY+uZ7MsSc8Mqj7XBRNOTdRl8+/mKWMAgqRq
         C/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424730; x=1790029530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXcLSHH35OWRapgVtDMftnE6kms58XO6F9CpqVDJO2o=;
        b=cs3wxTXwv4JiqWR0xlrmGjnaU6itG21zMWCHBPWOJFMdCiYQotf0PEzcjxS3+A24ht
         6xbR0Q3JwfjXY8fORVpVQrs73bS/MihLFMMnOYlBz2WQZkwGFCdewqrpdqT5BeiAXtpD
         HdV2T5876yUXSNra1QFu4IQdcsMzV5oBlksob1S37nAMEdwuvssFo1Q+ojA5w3VgtSxi
         qXs1KJ2kfmTqscknGaCqH66g2xhR6pv5f0ooJ4/n3gO+Ibf1uQ5qQv25VamK1PSEY6bD
         YEzJfHyHayxFO9soyz1d1j9URp+FTLtjV4kvry+gsiPifGlYHsjozUFq7xbYuHIRahMu
         ltpw==
X-Gm-Message-State: AFuF++nvCEX3bV+v0tSwlTFf6HC3Gt99KwA08CwqUISs+asth3Z1d41X
	LgOUNA6QvvtzhUyGzdSRmVCC46ZY4TH5MSBeOQLFfdJHGKzy7jeSQ0NkcxZNilt3QM4=
X-Gm-Gg: AYBFou1NOHYsWoefr6LeuT0OizGzX2rUa1yOPTocybDZAEq82LOGmT9JMdX71vS9ssQ
	5gYjYNcf5N4slwFm8SX47QjUN90QAlNHGD91vNQAITNgy0Q0dr0g1k9m9MivZe970YeTFqg/Nso
	YMgDc9MYNGEts4mVfvJUEMlYiw+2gCjDO2hlXna/ldg7agYfIY1sAhzStc/ECw2mal658S//Ezy
	ecM2WZ3Bw2TwXskPND5hogSzOyrXLdN/QlqsvZLd8vgN5tIIcxZ5GpL4TFcANh+xLVLyRr5A/u+
	r1p7RA7TKXFf94kbSe1vc7GMBXW0rPjBXWpDCGU4iS0awA0DUUm6ozxghsqQEVg73cSKNyU9U7m
	gU5EZJdhlQ9by1BByvBKzD3N3jv5QvmaLSJk4AyO8Iu6hoDwZD4E4t985GqPuUnoX5N4t9xna4M
	QC+GXR9u0TBVo0vgpUdE4ZcMAhrbKApG3Mh5r5jmxdq24EIgr2anTaijMTFxmBzlF6KeXOK7XWk
	ohKUZC7Kc//Z8cI6Zi7o9WWCtm1pLzJf5+nS+8bTintlJ8VOfe4erBfktoIjPN1ST4+J/b5GF51
	2bzgJetUm/JxFU2BKzFgVSRPje/x/9luzjw4hw==
X-Received: by 2002:a05:600c:4693:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-49e7a66b714mr58683875e9.19.1789424729908;
        Mon, 14 Sep 2026 15:25:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d69f6d6sm23639395e9.8.2026.09.14.15.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 09/11] selftests/bpf: Check callback map value lock identity
Date: Tue, 15 Sep 2026 00:25:06 +0200
Message-ID: <20260914222514.1635018-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10569; i=memxor@gmail.com; h=from:subject; bh=JIrYCQUVKUk560+R4Z3OJg+lO34upRZld/mwJHn4V1k=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFif6F8k0MmYZeHpGT2a4e2rL2Rn5IiE+L/XOF+EzWC LWJW5g6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJHOFwz/DPcyzTu36Mecw3NF +vQ+ZESnC7/S86udbW37LerYjpO3GBn+cGp/6plemeGd1D9Hv+bfmbLuysVLxKQXicux7//fUeD GBAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier test which retains a map value from an outer callback and
then acquires a lock through an inner callback value before attempting to
release the outer callback value. Both values can denote different elements,
so the verifier must reject the mismatched unlock.

Also exercise callbacks reached through two inner-map lookups. The lookup
results share inner_map_meta but may refer to different one-element
arrays, so their callback values must retain distinct lock identities.

Keep nested and one-element array callbacks as positive controls for
balanced locking through one callback argument.

For timer, workqueue, and task-work callbacks, lock and unlock the value,
then pass it to bpf_this_cpu_ptr() to expose its ID in the verifier error
log. Require a nonzero ID, following the existing lock identity tests.
Balanced locking alone would still succeed if a constructor stopped
assigning an ID.

Extend the existing spin_lock test table and reuse its array and inner-map
fixtures to keep the callback cases alongside the other lock identity tests.

Update the nested callback reference-leak expectation for the extra
callback value ID.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |  33 +++-
 .../selftests/bpf/progs/test_spin_lock_fail.c | 167 +++++++++++++++++-
 3 files changed, 192 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 78566b817fd7..490e15e7126d 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -13,7 +13,7 @@ struct {
 } cb_refs_tests[] = {
 	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
 	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
-	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
+	{ "nested_cb", "Unreleased reference id=5 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 5c3579438427..d49f52a8f822 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -10,8 +10,8 @@ static char log_buf[1024 * 1024];
 
 static struct {
 	const char *prog_name;
-	const char *err_msg;
-} spin_lock_fail_tests[] = {
+	const char *err_msg; /* NULL if loading should succeed. */
+} spin_lock_tests[] = {
 	{ "lock_id_kptr_preserve",
 	  "[0-9]\\+: (bf) r1 = r0                       ; R0=ptr_foo(id=2)"
 	  " R1=ptr_foo(id=2) refs=2\n"
@@ -54,6 +54,22 @@ static struct {
 	{ "lock_global_sleepable_helper_subprog", "global function calls are not allowed while holding a lock" },
 	{ "lock_global_sleepable_kfunc_subprog", "global function calls are not allowed while holding a lock" },
 	{ "lock_global_sleepable_subprog_indirect", "global function calls are not allowed while holding a lock" },
+	{ "callback_value_lock_identity", "bpf_spin_unlock of different lock" },
+	{ "callback_inner_map_value_lock_identity", "bpf_spin_unlock of different lock" },
+	{ "callback_value_lock_identity_same", NULL },
+	{ "callback_single_value_lock_identity_same", NULL },
+	{ "lock_id_timer_preserve",
+	  "R1=map_value(id=[1-9][0-9]*,map=async_lock_map,[^\n]*\n"
+	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=map_value expected=percpu_ptr_" },
+	{ "lock_id_wq_preserve",
+	  "R1=map_value(id=[1-9][0-9]*,map=async_lock_map,[^\n]*\n"
+	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=map_value expected=percpu_ptr_" },
+	{ "lock_id_task_work_preserve",
+	  "R1=map_value(id=[1-9][0-9]*,map=async_lock_map,[^\n]*\n"
+	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=map_value expected=percpu_ptr_" },
 };
 
 static int match_regex(const char *pattern, const char *string)
@@ -74,7 +90,7 @@ static int match_regex(const char *pattern, const char *string)
 	return rc == 0 ? 1 : 0;
 }
 
-static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
+static void test_spin_lock_prog(const char *prog_name, const char *err_msg)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
 						.kernel_log_size = sizeof(log_buf),
@@ -94,6 +110,10 @@ static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
 	bpf_program__set_autoload(prog, true);
 
 	ret = test_spin_lock_fail__load(skel);
+	if (!err_msg) {
+		ASSERT_OK(ret, "test_spin_lock_fail__load");
+		goto end;
+	}
 	if (!ASSERT_ERR(ret, "test_spin_lock_fail__load must fail"))
 		goto end;
 
@@ -166,10 +186,9 @@ void test_spin_lock(void)
 
 	test_spin_lock_success();
 
-	for (i = 0; i < ARRAY_SIZE(spin_lock_fail_tests); i++) {
-		if (!test__start_subtest(spin_lock_fail_tests[i].prog_name))
+	for (i = 0; i < ARRAY_SIZE(spin_lock_tests); i++) {
+		if (!test__start_subtest(spin_lock_tests[i].prog_name))
 			continue;
-		test_spin_lock_fail_prog(spin_lock_fail_tests[i].prog_name,
-					 spin_lock_fail_tests[i].err_msg);
+		test_spin_lock_prog(spin_lock_tests[i].prog_name, spin_lock_tests[i].err_msg);
 	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index f678ee6bd7ea..a27bbbe3523f 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -14,17 +14,18 @@ struct array_map {
 	__type(key, int);
 	__type(value, struct foo);
 	__uint(max_entries, 1);
-} array_map SEC(".maps");
+} array_map SEC(".maps"), array_map_b SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__type(key, int);
 	__type(value, int);
 	__array(values, struct array_map);
 } map_of_maps SEC(".maps") = {
 	.values = {
 		[0] = &array_map,
+		[1] = &array_map_b,
 	},
 };
 
@@ -314,4 +315,166 @@ int lock_global_sleepable_subprog_indirect(struct __sk_buff *ctx)
 	return ret;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct foo);
+} callback_array_map SEC(".maps");
+
+struct callback_ctx {
+	struct foo *value;
+};
+
+static long lock_different_value(struct bpf_map *map, int *key,
+				 struct foo *value, struct callback_ctx *ctx)
+{
+	bpf_spin_lock(&value->lock);
+	bpf_spin_unlock(&ctx->value->lock);
+	return 0;
+}
+
+static long nest_lock_different_value(struct bpf_map *map, int *key,
+				      struct foo *value, void *data)
+{
+	struct callback_ctx ctx = { .value = value };
+
+	bpf_for_each_map_elem(&callback_array_map, lock_different_value, &ctx, 0);
+	return 0;
+}
+
+SEC("?tc")
+int callback_value_lock_identity(void *ctx)
+{
+	bpf_for_each_map_elem(&callback_array_map, nest_lock_different_value, NULL, 0);
+	return 0;
+}
+
+static long nest_lock_different_inner_value(struct bpf_map *map, int *key,
+					    struct foo *value, void *data)
+{
+	struct callback_ctx ctx = { .value = value };
+	int inner_key = 1;
+	void *inner_map;
+
+	inner_map = bpf_map_lookup_elem(&map_of_maps, &inner_key);
+	if (!inner_map)
+		return 0;
+	bpf_for_each_map_elem(inner_map, lock_different_value, &ctx, 0);
+	return 0;
+}
+
+SEC("?tc")
+int callback_inner_map_value_lock_identity(void *ctx)
+{
+	int inner_key = 0;
+	void *inner_map;
+
+	inner_map = bpf_map_lookup_elem(&map_of_maps, &inner_key);
+	if (!inner_map)
+		return 0;
+	bpf_for_each_map_elem(inner_map, nest_lock_different_inner_value, NULL, 0);
+	return 0;
+}
+
+static long lock_same_value(struct bpf_map *map, int *key,
+			    struct foo *value, void *data)
+{
+	bpf_spin_lock(&value->lock);
+	bpf_spin_unlock(&value->lock);
+	return 0;
+}
+
+static long nest_lock_same_value(struct bpf_map *map, int *key,
+				 struct foo *value, void *data)
+{
+	bpf_for_each_map_elem(&callback_array_map, lock_same_value, NULL, 0);
+	return 0;
+}
+
+SEC("?tc")
+int callback_value_lock_identity_same(void *ctx)
+{
+	bpf_for_each_map_elem(&callback_array_map, nest_lock_same_value, NULL, 0);
+	return 0;
+}
+
+SEC("?tc")
+int callback_single_value_lock_identity_same(void *ctx)
+{
+	bpf_for_each_map_elem(&array_map, lock_same_value, NULL, 0);
+	return 0;
+}
+
+struct async_lock_value {
+	struct bpf_spin_lock lock;
+	struct bpf_timer timer;
+	struct bpf_wq work;
+	struct bpf_task_work task_work;
+	int counter;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct async_lock_value);
+} async_lock_map SEC(".maps");
+
+/*
+ * Expose the callback value ID in the verifier log, as in lock_id_mapval_preserve().
+ */
+static int async_lock_id_preserve(void *map, int *key, void *data)
+{
+	struct async_lock_value *value = data;
+
+	bpf_spin_lock(&value->lock);
+	value->counter++;
+	bpf_spin_unlock(&value->lock);
+	bpf_this_cpu_ptr(value);
+	return 0;
+}
+
+SEC("?tc")
+int lock_id_timer_preserve(void *ctx)
+{
+	struct async_lock_value *value;
+	int key = 0;
+
+	value = bpf_map_lookup_elem(&async_lock_map, &key);
+	if (value && !bpf_timer_init(&value->timer, &async_lock_map, 1))
+		bpf_timer_set_callback(&value->timer, async_lock_id_preserve);
+	return 0;
+}
+
+SEC("?tc")
+int lock_id_wq_preserve(void *ctx)
+{
+	struct async_lock_value *value;
+	int key = 0;
+
+	value = bpf_map_lookup_elem(&async_lock_map, &key);
+	if (value && !bpf_wq_init(&value->work, &async_lock_map, 0))
+		bpf_wq_set_callback(&value->work, async_lock_id_preserve, 0);
+	return 0;
+}
+
+static int task_work_lock_id_preserve(struct bpf_map *map, void *key, void *data)
+{
+	return async_lock_id_preserve(map, key, data);
+}
+
+SEC("?tc")
+int lock_id_task_work_preserve(void *ctx)
+{
+	struct async_lock_value *value;
+	int key = 0;
+
+	value = bpf_map_lookup_elem(&async_lock_map, &key);
+	if (value)
+		bpf_task_work_schedule_resume(bpf_get_current_task_btf(), &value->task_work,
+					      &async_lock_map, task_work_lock_id_preserve);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

