Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375664BCADD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643522; cv=none; b=NVkyA+txyZG1wurjN7YfZ8+MkKGdig3Qv4ZBhGHSuOR3pQXcw20VsKkusPHMj/qaGBJTmaFuvgzKC2xY29K9j0M1R9Q95FED+WjoOURm+w3S3X2sj/BGXOEF0IBg6nZs6ivatyx/Q+2BkV2rh0EuTo0ozfjztXZaFwut+9sT3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643522; c=relaxed/simple;
	bh=CVvBwQ6lBFpXUIViOPlSjh6YvjLdL28clTzxDTwNpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzervdOpVN6cor5sDTu4QdijQSgPX1Z8jztCcoX+g1clIYW6Uva8VkE9XouJu//Qz9DReQ0Aj9zn2TTeMka+wYWqRRcSzyl7JtFbAbaoGdMAzmJwf4voWTut7ZcOf18rksEYun0T2eKMmpuw9Encgmdj3RbMDga9IIMZIhkTrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdFQAKAe; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdFQAKAe"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso2607795e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643504; x=1790248304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOK0pbhs8LqYyqOZ8qS4jhEzO9kJE2NNBpncYu3M/ko=;
        b=AdFQAKAePtJ+4dquIoLdfzAczZ+vsR5NuxWZcFpvbk43ev3h1zM8z+8Vwp2VBV2Kyw
         oae9n6hSQhN92ApUhvY6NxRSvOiV9bVVEceIwvsJN5XcdtZahmFavtKnDQHeuquW1IK+
         G7eDkXTLPeXI2z8/oa1ly8UakqaSW6SkEHwsMkhPsPb/ObpuxY/f+OQTLq/3tVlLFHfg
         nULwB5fNt68AGqu2AFULhcUpWjDY/OxwoSnshtxTN7CfksloC/oBWFAo/A0ClQJzr2ua
         dH4c5mMgUY71gjIlcOqggnXDzoD6L0R7Q4N0jsDlb3ue1wSAyaoEck/8c1TpPCs1OtoH
         aAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643504; x=1790248304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOK0pbhs8LqYyqOZ8qS4jhEzO9kJE2NNBpncYu3M/ko=;
        b=n+xZNYWpk9Yc0PK+4h6+4Gh6Sdp2xhi+thubMPE2KpSyVrx/sYiXCUDTgFUBbHGC9d
         39wRV/5QJJHI3S5WQaJ7Rw1UwrTVXyKEpdJt7d4OPOiGXSpAnnfL++7ZyiGuHpQ7DDug
         UuXBqg213rC+RaM4045ZW4/bnK2d1NAnFhHzWk/QVhy5k6p+fRuKHUgacfXxUB46UoCU
         Zx5DX4z4WPUV0C0x5yIjfpq5b+9vmMSEa0h62pivnUrXt52L6Mb31dcBMZMAMVtTUsCq
         /b6TzMhahOM4/VwJN0Km1QojTo2at4VQgJZsRlJ/FYCcYdygFGBFR1OPJ+ktedmGCOgB
         Rw8Q==
X-Gm-Message-State: AFuF++mv/WmURey6TwLAU2meW2VU2ywAEK0VSxYl0nDLLLSaSgsrnfev
	UT3JedMP75Qwdj9SnthN+tk2RMCO4fgxhlgXWQENSnKKgX2wWAWzirzQDLcz9gLg
X-Gm-Gg: AYBFou09rBwZAJocltXIBjjWRhK630oylrpTNIBv66XfzF/hgDV8zqFVoubbACXo8wZ
	X2iX4b2/S3Wr2xVQGI2qlQ8rKdS38DTUr7UxWoXVgNh8i6a4TK+SfbOCIZAEvb5dkNHndt+MqTN
	2qAGlEf0Wv/pgKxtZY3cOB1baKLxlCj0Il78ZWiGiG25U08/7f6NuI7VWU+HR8cuvJHuVTDvb2R
	zz1PmiD6scq309zlMgw0S6cy5BA0UcD41h5m3ZisTDtgUPLF1DKj9/BdvQvWelIfUDXAIKDbFim
	v27Nyl0ENkisxubkrO/MT+V3I2D0ZwSevbnyX3KufQ8CXb5NItPh+DTxNVlwCHORuuGBy9NMPoF
	sm/xVeBC6XBd/XurUDOvu4RtYmi+9pQkONs6bvY0wLv2lSOV4JA9ta9Q5yuVJICygqDewEgTauL
	yq2bvd9okHrprCsav5qs/2FTCbdvTa8HYJEVw2VS6t9X0ag40qLfT2DSfw9mTUdx+tRGBTXs5T7
	Zp3cthpbv6z7Idip3LRhWlZpCbXl9isZKRb+grqFHvYPthlI94zKNZvQpe6XkUonI6L0/Tz/1l1
	eZ39nL36yPvAf2+S/0VJjlqTmBrCAbFcj86dVA==
X-Received: by 2002:a05:600c:4ed2:b0:49e:8184:f617 with SMTP id 5b1f17b1804b1-49eb732e21emr75535065e9.22.1789643504323;
        Thu, 17 Sep 2026 04:11:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm14884091f8f.13.2026.09.17.04.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:43 -0700 (PDT)
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
Subject: [PATCH bpf v6 09/10] selftests/bpf: Check callback map value lock identity
Date: Thu, 17 Sep 2026 13:11:21 +0200
Message-ID: <20260917111127.3780880-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234; i=memxor@gmail.com; h=from:subject; bh=CVvBwQ6lBFpXUIViOPlSjh6YvjLdL28clTzxDTwNpCE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qZQHAhMfFd6v0z3MyKp9duvND0oap1+6vDJvaWlrL H0ctuFVRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZSbMnwz3zKn/Wnlsl9rNrw QeJn0r6lfm7H/D+eO/3EP5fjmEirQBsjwynT+1ekzA46xFlFf1SxZtBfa/rx9Naklpn746T+Wmw v5gAA
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

