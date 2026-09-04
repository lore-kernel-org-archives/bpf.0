Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43C3BED30
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518555; cv=none; b=PtFN14r7kvXrdPyBEQsUrlFZKeILGdEO6yk02CfV3PAr7AS4tA/Z+w4eIMm65BhIYMsjVUtW8w1FMyutpLrOQD/yFdkjLG6Fbk8eB2FZ+h46xPTlluzq/v7iHv2YMfxZNoNb0i15l0XVKYnCRONAo+xr+LybKqcmxFU4SCGZGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518555; c=relaxed/simple;
	bh=UGJhFqwOrXlRxF4tUiYYLSRCrvTLHq3yaZu35mzHrXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK62Ldu7/v9AtvKGJIpjqBa1Z7lPRdNdM0zjBKbXdHTqZeuAw943azJfCr65FE6w2g2cnrUk5glKu9MOzSjqiP02MpECWXAM0+VksSATCofnrYMbFWjeoN2jFIZ8t3I7ewYVBDmBzHYAU5kAxxneuakqiPXiTPBkiOmNpDxy3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGXwHJp9; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGXwHJp9"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so4653005e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518548; x=1789123348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YH19Y9VNjGJ2KdRS90CB9ub8k/jYTDp8dN6+qf1X5GE=;
        b=gGXwHJp93KRZs2cbh3UwWF3c8EXoSa+FzcuENMWhEs5ZvUV5viczTouK+B6IHdI8lr
         xXOYxBax0v+npGl7uCNXyv4Ot+avguSVPYbBUasnl2ou09mlmyBTOvAMbQrzXzIlDTJ0
         +12Y2z8wYDUcOAaYHDOfgbMxYZMm4vZZ/2h+R8MXMP4rlk6qxjaAJAAM1/kqPAE0bapC
         vatUItJih8l3WdK+E60d0gWU9qZLSBLTdyEu0wDfRZnmsEpaLOn21ThQJwyJo4yrwZ0y
         i+ZHFiFetJBZ3wxgZv5q8KdO1AshDu4S/RlbcX8LFdYDorD20dkOzM4JgKCZWqF+4A+S
         1KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518548; x=1789123348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YH19Y9VNjGJ2KdRS90CB9ub8k/jYTDp8dN6+qf1X5GE=;
        b=HgXeEgC9i3d46Wr8qtPivRY8GKL/gJxFmJQi39M/ug4s2v8gwp6355Bbd2e8GePpF/
         9cyrOPEzLRI2Lj8jEuxUDteyMUgsb+6ShTHEufrrC3aPRWgwSC1/KI4zAgbg4De6qTlk
         e1t4q83QLSMqYakS0UHa19Vr3J6VbM6vItZhhGnxJdhFojrS99xNr9wc2/O0rm47ABZ9
         XogFgY65D4pqAZFT0kXoafjE9cxhO3YNQdfzJqX2KKG7hC5oL9d4ArQ1JEIIJRMP2P3s
         SHL+yjMLNZcz8UkIRnPYnxKJoaAAt3YQR4eKVF7SWP0XflkLMlUFM8U0iRlGbpEqrSfS
         npbw==
X-Gm-Message-State: AFuF++lJK9yA68XxSvaff87lLR6LABsQNTO8oLwtIIvb9aEWXVkJuDxk
	y9LBzf2D6vN90504MG3xLzyCSYEZjB0KMOWvQZcPIV98IpecjuZwyrBV46iC6OYB
X-Gm-Gg: AYBFou0Xk/mZ7np9KLcF37zCz9h07YSgcIaSO0RWl3H2ixZrAQqM/0Gg24s+uqd7uM2
	tf3Ne1a7AVbSGui0AKt5mpVbaK9yH9KhJdZKPVKAXIXPWaAkV4emh6FJT5iVrIsOVn0aprueC+A
	sXJ5FH6LcXSduLmkbggq6vEj07fpCWD2fR5eAuzvshAzirr/5SZo+Lio8Iek9tXq2Llbms3vDJf
	y9mBDzp0uL3duimszucL0frc+lipjfURhqvKGNqI5cSKkdbccLoxPfmqQQcN3M1SRz/d8N2msBt
	mmoSgoyejB2hRzJNn5AebJ15SGpKJVKlo4Y3n6Gwiwohlh89RxVELVaSzhv64u6AtulQyixSLL9
	gy+SfCk2kqqKQjSuz9Jz0Qdf9i1u/el3ZSwZYO97m8mpOZOSSrBqsD/OqTx3v7uRB67EAZ9PfBu
	1wzhfB6Ayd6/17EaJStXHQOA9wnx1xw98KIxjcCOhrwyGaD9zIO4uf3u/g3DUqzM45bhuk+DOBn
	GFL4hBrX4iIzlSl44yxGHM1xTJQH1laPSswL8nalVVynbvswz6jRydhadJPzkP5yQsyJhw4oLcu
	Qt6oZ04tNDgiKnT9BUnqEvDX2Bg=
X-Received: by 2002:a05:600c:83c6:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49cf824328fmr63264025e9.8.1788518548426;
        Fri, 04 Sep 2026 03:42:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm160340745e9.13.2026.09.04.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:27 -0700 (PDT)
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
Subject: [PATCH bpf v1 8/8] selftests/bpf: Test inner map identities in callbacks
Date: Fri,  4 Sep 2026 12:41:59 +0200
Message-ID: <20260904104203.345917-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5605; i=memxor@gmail.com; h=from:subject; bh=UGJhFqwOrXlRxF4tUiYYLSRCrvTLHq3yaZu35mzHrXA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/PPFBuaud1oPN7m+OrxB5Mac6Bd3+n2ezzy78d4cY y3GvJ5NHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIhDXD/4o1rk6nmP/vPdM4 z7vhXCqPQWkf71NlHkfvw9YJPxcE2TH8lRLhez+jjUvCkePWjvyvHwxvJrrPD+uds5X/4s+pCrP 3swAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add load-only timer_mim coverage for inner map identities propagated
through nested timer and bpf_for_each_map_elem() callbacks.

The negative case initializes a timer in the second inner map with the map
saved from the first inner map timer callback. The positive case pairs the
timer value with the map supplied to the same for-each callback.

Without the verifier fix, the mismatched-map program is accepted while the
same-map control is rejected. Preserving map_uid reverses both verdicts.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/timer_mim.c      | 29 ++++++-
 .../selftests/bpf/progs/timer_mim_reject.c    | 84 ++++++++++++++++++-
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
index c930c7d7105b..fa7bb769ca31 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -59,10 +59,32 @@ void serial_test_timer_mim(void)
 	int err;
 
 	old_print_fn = libbpf_set_print(NULL);
-	timer_reject_skel = timer_mim_reject__open_and_load();
-	libbpf_set_print(old_print_fn);
-	if (!ASSERT_ERR_PTR(timer_reject_skel, "timer_reject_skel_load"))
+	timer_reject_skel = timer_mim_reject__open();
+	if (!ASSERT_OK_PTR(timer_reject_skel, "timer_reject_skel_open"))
+		goto cleanup;
+	bpf_program__set_autoload(timer_reject_skel->progs.test1, true);
+	err = timer_mim_reject__load(timer_reject_skel);
+	ASSERT_ERR(err, "timer_reject_skel_load");
+	timer_mim_reject__destroy(timer_reject_skel);
+
+	timer_reject_skel = timer_mim_reject__open();
+	if (!ASSERT_OK_PTR(timer_reject_skel, "callback_reject_skel_open"))
 		goto cleanup;
+	bpf_program__set_autoload(timer_reject_skel->progs.callback_map_uid_mismatch, true);
+	err = timer_mim_reject__load(timer_reject_skel);
+	ASSERT_ERR(err, "callback_reject_skel_load");
+	timer_mim_reject__destroy(timer_reject_skel);
+
+	timer_reject_skel = timer_mim_reject__open();
+	if (!ASSERT_OK_PTR(timer_reject_skel, "callback_accept_skel_open"))
+		goto cleanup;
+	bpf_program__set_autoload(timer_reject_skel->progs.callback_map_uid_match, true);
+	err = timer_mim_reject__load(timer_reject_skel);
+	if (!ASSERT_OK(err, "callback_accept_skel_load"))
+		goto cleanup;
+	timer_mim_reject__destroy(timer_reject_skel);
+	timer_reject_skel = NULL;
+	libbpf_set_print(old_print_fn);
 
 	timer_skel = timer_mim__open_and_load();
 	if (!timer_skel && errno == EOPNOTSUPP) {
@@ -75,6 +97,7 @@ void serial_test_timer_mim(void)
 	err = timer_mim(timer_skel);
 	ASSERT_OK(err, "timer_mim");
 cleanup:
+	libbpf_set_print(old_print_fn);
 	timer_mim__destroy(timer_skel);
 	timer_mim_reject__destroy(timer_reject_skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/timer_mim_reject.c b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
index dd3f1ed6d6e6..83f31138336b 100644
--- a/tools/testing/selftests/bpf/progs/timer_mim_reject.c
+++ b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
@@ -43,7 +43,7 @@ static int timer_cb(void *map, int *key, struct hmap_elem *val)
 	return 0;
 }
 
-SEC("fentry/bpf_fentry_test1")
+SEC("?fentry/bpf_fentry_test1")
 int BPF_PROG(test1, int a)
 {
 	struct hmap_elem init = {};
@@ -72,3 +72,85 @@ int BPF_PROG(test1, int a)
 		err |= 8;
 	return 0;
 }
+
+struct callback_ctx {
+	void *map;
+};
+
+static int mismatch_iter_cb(void *map, int *key, struct hmap_elem *val, struct callback_ctx *ctx)
+{
+	bpf_timer_init(&val->timer, ctx->map, CLOCK_MONOTONIC);
+	return 0;
+}
+
+static int timer_mismatch_cb(void *map, int *key, struct hmap_elem *val)
+{
+	struct callback_ctx ctx = { .map = map };
+	struct bpf_map *inner_map2;
+	int array_key2 = ARRAY_KEY2;
+
+	inner_map2 = bpf_map_lookup_elem(&outer_arr, &array_key2);
+	if (!inner_map2)
+		return 0;
+	bpf_for_each_map_elem(inner_map2, mismatch_iter_cb, &ctx, 0);
+	return 0;
+}
+
+static int match_iter_cb(void *map, int *key, struct hmap_elem *val, struct callback_ctx *ctx)
+{
+	bpf_timer_init(&val->timer, map, CLOCK_MONOTONIC);
+	return 0;
+}
+
+static int timer_match_cb(void *map, int *key, struct hmap_elem *val)
+{
+	struct callback_ctx ctx = {};
+	struct bpf_map *inner_map2;
+	int array_key2 = ARRAY_KEY2;
+
+	inner_map2 = bpf_map_lookup_elem(&outer_arr, &array_key2);
+	if (!inner_map2)
+		return 0;
+	bpf_for_each_map_elem(inner_map2, match_iter_cb, &ctx, 0);
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(callback_map_uid_mismatch, int a)
+{
+	struct hmap_elem *val;
+	struct bpf_map *inner_map;
+	int array_key = ARRAY_KEY;
+	int hash_key = HASH_KEY;
+
+	inner_map = bpf_map_lookup_elem(&outer_arr, &array_key);
+	if (!inner_map)
+		return 0;
+	val = bpf_map_lookup_elem(inner_map, &hash_key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->timer, inner_map, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(&val->timer, timer_mismatch_cb);
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(callback_map_uid_match, int a)
+{
+	struct hmap_elem *val;
+	struct bpf_map *inner_map;
+	int array_key = ARRAY_KEY;
+	int hash_key = HASH_KEY;
+
+	inner_map = bpf_map_lookup_elem(&outer_arr, &array_key);
+	if (!inner_map)
+		return 0;
+	val = bpf_map_lookup_elem(inner_map, &hash_key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->timer, inner_map, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(&val->timer, timer_match_cb);
+	return 0;
+}
-- 
2.53.0

