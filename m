Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228D4B8263
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687963; cv=none; b=msfuXsgOuanPoHCtDSTqMC+uKQHi0Mqy0Lub3ObO+OzkR5POOa4eW/eVa51CwwkXq2aqgSn4usc8fIiE3KSTxF/a7z3kbdK+IiAXC9+J6D73Xts5sawb+6LoPvgQuKz/YwGQ4PoDXFzxW6m1+5WY+cvrayzkG6PfFStjzEyE1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687963; c=relaxed/simple;
	bh=CVvBwQ6lBFpXUIViOPlSjh6YvjLdL28clTzxDTwNpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0ImzqbiTwSR5y7g4XgFpjJb2VwA/akevTnRaCKeTgTUKmttaNPIfVd2+IQEdZDzRCWyLWArVsHHhi0z3o0B7pjEgm4ZQcjUEUXHVuEUTFYFRjM+gMOGa+FiPJkcWn+rjhrURAlSoliUoukjHjMBpG8bGNuyoK9Jezi8G7kK64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmH/8H+T; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmH/8H+T"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so341215e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687958; x=1790292758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOK0pbhs8LqYyqOZ8qS4jhEzO9kJE2NNBpncYu3M/ko=;
        b=KmH/8H+TxXK4jbsBr95YQimeD5r7T2YhDOmKUJpfk0KzkbNAfiTIqwHfV3QlMH/Bd/
         Ddu9QffL4lZ6fUJG1JbbJzND1SZZuf0fHOEN8bS5RnNhgxXoMPo4iiqclZQx8yXDChmk
         ASTY4BW+u59fESOyYqrv9D64qwyfl3lQtqJmTtAob0a+OVlf8ulwWwJBH9eb3OeVKVC+
         WpLhgjDeJSo0G3Xo5Dq+D5EFWS3orEuRYMtcsG9UtHV+b0FfVVFLxyxHSgj9Zq7KGvfT
         LobGHkYIBBWHqIvOFHF+162U6S2P4MK4ECEvc+dG3Moi6saTLdr1UDgaCxj5C9rOdFHY
         3Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687958; x=1790292758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOK0pbhs8LqYyqOZ8qS4jhEzO9kJE2NNBpncYu3M/ko=;
        b=gXoAntiNmR0C0OuMlYgBVFn7ArgLwlLsEt5M2ECtnUL1oQdGVp7WQNjGcmUIn7kal3
         YBYqxh9RUsT4coIH7myt6+yU3dtpbr14/KYAcMtFqGjIaWioRDv6ctFi4SoqI6CIvmXC
         NGNQUt4zw0KezBg6UZNnNjr5IPWESRpRvhlEy8LjfDwTD77LNFxFHqsdmE0m9x6a/8Na
         7UyCy+SOCqJCva01aNdDVs32mMMzgtss7fGFJAbO+yFz+/rm5Mm/gg6O1k+CAzwO33y0
         rYIeSM2FOjXyJvuZI7CqQ0EcpqKohfpwR5Sv89l7wINDMXmxpzFW2ekyHQFZiMTZw/EA
         Z7Cg==
X-Gm-Message-State: AFuF++lm8nXJIg/3ExBRGvgoGuQFFxvvmiboBSDWCZsDYANi1hoYForG
	qRzziIcHOWKQT7rw1hN0GRDJ4K+2jEbz6bDhf+lOQriGGceNOS1/zlMvfg5GCRLl
X-Gm-Gg: AYBFou0ezR8ah9OmGykKsUvg2UF+fW1f8mcRxT/YMDNu018eNEAW1YXwsHiDIBshyQw
	DtGpSycJuAVBVr6A6Yhl38907C4zh/XsXaXA5JjORxgMUXeUyz4at29+CZjm6zlX2tFglQ+KFOl
	68c/PdNfM9Jk69jKqApzNsXdMocH1BDa4RVlzP44UWzK56v+oFIuK+Vlx0THw4mjkc8OBEYUVPX
	y5NS3T6HXUByPHmxC0LPgRROUhfpWFoa9rGWeIP7dqok9CEcv41CQITMCHuMlvvpepWy6quj7un
	QcdZCqK0NmW8eRH/d6vo/BoAGZssNjXyS3BQrZV/WLu9Np+ORBXbwpM1e+joE0JWcIftTRmrG12
	/eMlxBjZTpgEEmNNEjDiEpWUS71CRvzKR+N9zwVTGEO4DbXk4KZ62sFgP9YwGfT48j3+NyJkDn/
	u8vLGp571SRg4K7vMU0IVgKr6u2Lcu0RytzgfsDvreqkRFCXblayfl3bHpkFDjM7gcOFYVKrn9l
	WVRce5IjgRNG3FxUzCGaMwda/+cEVg8QFiNQMKhnj1IVx7WvXaaA01aPpzvOwzP0bHoQlf1H/QF
	UdwD7VO+BpYzb+JPDIUHkQdTwCwRN+qiRuUf8Q==
X-Received: by 2002:a05:600c:4ecb:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49fc5754e06mr4787055e9.26.1789687958329;
        Thu, 17 Sep 2026 16:32:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7ce0050sm1717595e9.4.2026.09.17.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:37 -0700 (PDT)
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
Subject: [PATCH bpf v7 09/10] selftests/bpf: Check callback map value lock identity
Date: Fri, 18 Sep 2026 01:32:17 +0200
Message-ID: <20260917233222.2542500-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234; i=memxor@gmail.com; h=from:subject; bh=CVvBwQ6lBFpXUIViOPlSjh6YvjLdL28clTzxDTwNpCE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRdYDgYmPCu/X6R5mZNU+u/XmByWN0y9dXpm3tLQ1l j4O2/Cqo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPZ9YHhv2fVInfHeQ7WLnNe b2aeEBZ36dT6WnPx2ckHeWRiP0yTSmJkmOkyW+R0QOlJo8inGftjehpK4w52Z0Z+Fd8o0yy4RVe QCwA=
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

