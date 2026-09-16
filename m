Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912984252B7
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593684; cv=none; b=nl2L4uvbhmJ43DFX66NPnuADCpYYxe/Q4TkvfVzBL2gceqh8xNmCbH06w738+pgYpGxAJpSJopIsVY1litRqWXaqAvpCbsniWqKKcM65GXXR2sXUlqPwdqSZQVCSPPU1/sK1EovsxLTj18uUqca4g19TvSGUwzDYcTGm0Y7L2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593684; c=relaxed/simple;
	bh=CVvBwQ6lBFpXUIViOPlSjh6YvjLdL28clTzxDTwNpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsxWzKNrhsjLKP8U11XeNKvzMbktVKkBVOLQWyYPkz9lnX5rKH7MSi/vvMgN5rod/WMFwCFlzamYQOJ1c+4IGFhvt3mIe3JqO/VvHEo7GhsbGiDJbVFdWQI8vlaNhkV9HKy+cgflewjFMlMqoecxrmosHLD3uOKc2gl0VIXyxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e94U3myi; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e94U3myi"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso442505e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593679; x=1790198479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOK0pbhs8LqYyqOZ8qS4jhEzO9kJE2NNBpncYu3M/ko=;
        b=e94U3myiSlV7Cttv/qHJ7tU+YTewgDbroXHKGUhw4DLaQE+AWWEUuhk6UgTyhg314o
         x/JcJpj69q9quleDUoNqcSRN6Ynqr695o9tTMjUHRqfC0RVtuc0mFLA3kQxfO/0oVbPA
         gl6MQQUMWNbPTaVzg/h/Xszk1giOZKMtPUQNf71QVPKXlpUSGpfDmW0b7UVFI6NIjGBw
         Xjmv6YIe8kNUV0BPI23L4IUU8Plf5YATrxpvdkIH2vzYivtIjZpPxXUHkM0fCmJ8yBLm
         k5S1tLXNyZgFTj3tzLw55HZSGXXLVg7HpUxx2n6jN7+NMjHddzWOLaNlfUQ1q8HW/2iz
         yHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593679; x=1790198479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOK0pbhs8LqYyqOZ8qS4jhEzO9kJE2NNBpncYu3M/ko=;
        b=EBII8nPUl1gsDuZ2wsQ5wYgwV/LT0E64vrkjLDFtbp677A416d1giYZonX1RBSsP+i
         LpY297dM7K5uhcPN0NW62JV4MZmQCz5oL0zWv/q8Pt2fnfPB3quYHby6WTawdNP9admF
         B11AIaPHEYUHhMiI5wk5+kPkykPJLwhE72zTNcseusBhDuz8ZC73ZR7Nx6N1bvILDbcq
         BLlUh8Us9WT3RI1EroxiwuC6+qpDZ5SceDi2l+ZWofPE5ebHiseVEYlG8GDJX0dEqcEx
         Sx0J8fFXX7rx6qJdWG+uh8R5ooOUUr57ZcwJDgZgmx4nv20yUmOF/UUYLzE0DD5AR54U
         YFgg==
X-Gm-Message-State: AFuF++lK2ftXgUx9AwveT9LfbM3ib0+E/xD3+Od+Z3MPImSMjXQMCmi8
	d0jFyt4vNPrqVGS9YeG87I61JZChJUO+V6tfWVgHj22pQwb3Hi71ciykPqthC1zc
X-Gm-Gg: AYBFou1ab8jrOvee9AM74vJl+I2siyiutnXfWLGd9upwSkILh9S0AUG4sLH3fvrA1ub
	+6Sj2lkdT0X5sSEq08YyrnQXGzClW9zKgTyh6WbkspwUeaqM/cdcB4Vv3rJIbJ1PWCvSXK5UFEZ
	z9fYbGTzNSwtaVyHBEIp68uFx377Ve6+BKgu67zzmPz0PVc3dsZv+Hq9VnG2PTNYdqHzuzIKARx
	IrevSOO/rguMU+sVVP0InvP+CBvBKYNrs4SGbMnCqphEf8QFqCzpClFtLyNfjhBfTicYaTrkhm6
	ubIkkeju9dD0E1nnCLb1xFKLvFQGLbLHcAHAHugKc2WyyeXI+/cJ4FO56FxExsivtUmg98GO6Hr
	tzlNizLNkRG5cS1iTNtxBE/2WerGClDy8Oh708KVorhGTtpWPqIWCwb/9tet58UtvAHGZVc8ft+
	wKtUMfZds35ES/LmPUT1ake03zH6Wo1wEoj82tPftVrm2QJvLmk8c3ZzKzsiuXz6d4ZZg3fjV7b
	dEHbggnTaiO/Y3jq+FAkMAOKbaoTkERxHp2DVIJ6lqsdA+MQWX+oIQUZ+dsUyjEeLXTl/SX6YT2
	31e1IXov7RK79kE5tWI9DhU7B85GGMPiApmgtg==
X-Received: by 2002:a05:600c:a47:b0:49e:719e:e215 with SMTP id 5b1f17b1804b1-49eb732eeacmr46401285e9.26.1789593678875;
        Wed, 16 Sep 2026 14:21:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27df9sm9633178f8f.19.2026.09.16.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 09/10] selftests/bpf: Check callback map value lock identity
Date: Wed, 16 Sep 2026 23:20:56 +0200
Message-ID: <20260916212102.597335-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234; i=memxor@gmail.com; h=from:subject; bh=CVvBwQ6lBFpXUIViOPlSjh6YvjLdL28clTzxDTwNpCE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h/wDgYmPCu/X6R5mZNU+u/XmByWN0y9dXpm3tLQ1l j4O2/Cqo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN5n87wvyoxI+Trrpk+V9mO no3wjBTmOyaUzMYgkJ/TuuPW3C61AIb/5eyRXJkumVMffY2yO7omNFZ17YpWiUN7SzYvixa2T7r IAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier test which retains a map value from an outer callback and
then acquires a lock through an inner callback value before attempting to
release the outer callback value. Both values can denote different elements,
so the verifier must reject the mismatched unlock.

Also exercise callbacks reached through two inner-map lookups. The lookup
results share inner_map_meta but may refer to different one-element arrays,
so their callback values must retain distinct lock identities.

Extend the existing spin_lock failure table and reuse its array and
inner-map fixtures to keep these cases alongside the other lock identity
tests. Update the nested callback reference-leak expectation for the extra
callback value ID.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/cb_refs.c        |  2 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
 .../selftests/bpf/progs/test_spin_lock_fail.c | 67 ++++++++++++++++++-
 3 files changed, 68 insertions(+), 3 deletions(-)

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
index 5c3579438427..e368370262c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -54,6 +54,8 @@ static struct {
 	{ "lock_global_sleepable_helper_subprog", "global function calls are not allowed while holding a lock" },
 	{ "lock_global_sleepable_kfunc_subprog", "global function calls are not allowed while holding a lock" },
 	{ "lock_global_sleepable_subprog_indirect", "global function calls are not allowed while holding a lock" },
+	{ "callback_value_lock_identity", "bpf_spin_unlock of different lock" },
+	{ "callback_inner_map_value_lock_identity", "bpf_spin_unlock of different lock" },
 };
 
 static int match_regex(const char *pattern, const char *string)
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index f678ee6bd7ea..55282f20fa32 100644
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
 
@@ -314,4 +315,66 @@ int lock_global_sleepable_subprog_indirect(struct __sk_buff *ctx)
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
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

