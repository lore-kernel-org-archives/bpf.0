Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CA3D648F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661062; cv=none; b=MZBRS2pypNvhTL5sI6IvwF9EHMUkMx3O546Ya7DwVzahyLo2sKaEZvW5XQgWqM/nUqv37p6AOy/JtowRI/hwsKRTJePlgw408x2cByuaCZyNsZzTZ2jVfd6qvahYmq+H+RrsCMC+vxOJtKk3uLckWvecmtWwDLYKmrs0ielCxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661062; c=relaxed/simple;
	bh=Jb8CFCP+sDuaoub3BY9aWPa9qatle3OTO/F8qXWi/Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfbneopdJSKTrqVQJaYBazVQL9dg79QSXmo3737cyjie912gndp+RZkblih5c3D2UpSA+LZ46aJaQQTQZeRf50LV7+WxFGL1C7frGCowHUVTm4ouv8zRVCJ5UV8Pb/mTjznxUZ1DDPc0hvYBmTxJJwFmjg+f5FYHgIGFCjHzzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+Wfw3HB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+Wfw3HB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso44225035e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661059; x=1776265859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmNCPqIaKsRX0T3nsGnRXUlrAFfrc4EkgV/kOoRvWQI=;
        b=K+Wfw3HBsubnsAyZ3vqjzOUmzKMzEDs9++m8TuXT52uUNZTwnolBvHzTXKF+MP4Hi/
         Absn8ZNarHiCmKMObT9Z8G8L3nb2rpnqsteImTr+oeJoYbJeT+BBZTIbWUipx2n4oM+e
         6XJC1CKjBQ2HDaGh90KCq7LDAAfl5auvx1a+4Y1rOhlEmimAWVvLOQQVKfm1mSg7EJpG
         BjxKr4xZLYMkDRD0daEfiMJ7frO8u4cM3913f3tit1g+aWXhDxzf2mUvKQU9hHh5ZEDb
         OHihqtgRBsWeXqtb5Kr4tsyp6yGmb+a3DNSdY1QgoMdDslgXHISicz6psBdoWBjlCg1F
         62LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661059; x=1776265859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmNCPqIaKsRX0T3nsGnRXUlrAFfrc4EkgV/kOoRvWQI=;
        b=Epe8+CCXi00jV27F99GarboSpljUKzcW4k7uHSVBeEuhKUO89QJwvAPFW26BebXkAS
         WAXb2cWNYPFEP/tfwGcM9g/3eNh3Ims+4VbAwP7x8jYMJLjX9/0GSOv0xMh5TuQmdvEV
         OXMaXxTMJUnuZV8ng5s6KD4ZYttaQ4LhzsfopxF7Dbff8AXwjThv7kqhYLrn4VPTR/u3
         gsImVWt/yvRmdBIMgxFz7lG2GbjrJtGBjLvFlxbt/JzbOufMKGFk2YjJb6z9VeFHx1+p
         INnnWW1Mhno3Z/jutnqrt+VGIwdWLUlFW0uBI777nOI8D02QWYCo8mchX9XqN8jKC0cN
         6KJw==
X-Gm-Message-State: AOJu0Ywp6rVJNqTPRSyrxlCP//EFRuThcL50PArsHlhNlCK9IOvDqZiZ
	+vvjtS3xCqnxwnQjH7GPVjJLUQNZJtj3MNqYRRYRKPAyqX96OXXnPZLV
X-Gm-Gg: AeBDietMjtjgWt0mJlvzD4hUYbNu071bWpNtnzTDAdmtkFMXQx1T0UPMI0RIYN9Q1G+
	SpVBvoKbtkVdkUm2NJP4wlf7EahOjeerElL342Uq/rBd1P4l+b5j0/l1UHkE9kJ8XSMrptbzrFw
	+o2B7V3gk0mBltL7V+ajb11LEbPSl3JjpJ1oV2ZO1RKep+l2KyD4PMTE3v3/np9o4fLTXRn4dgK
	VCyOkp5Ns3Xg4Oe/5n++c3UBULEJIzMbklFvwvLH1I9Ch7AZDqortw80w3g3JpBJvFood+hLAlj
	U17UVA3wkoA14i1b2QF2Jse4NqgC5MkrjzAVry49cz+tUM25Iy1lXzzmRuvsocsSZC4x55EcEqH
	KDAgBHCBWtU74JUK69dzBR5wfQIZgr22ja8EeYlgjDLBcnTIXSXZd8ZGWi/hqWMjpFhTqxvM+z2
	2BKezXsc0dkC3pa9ScWzYJkCgC
X-Received: by 2002:a05:600c:8b52:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-4889978140bmr325558835e9.18.1775661058531;
        Wed, 08 Apr 2026 08:10:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83e906sm722884985e9.8.2026.04.08.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:20 -0700
Subject: [PATCH RFC bpf-next v2 15/18] selftests/bpf: Add stress tests for
 resizable hash get_next_key
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-15-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=6118;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=3ZLrDPKUuspuYUwxZ4JWsTXjDRc7dG9A7Izkt19jHNs=;
 b=0ODnN+KuDbi/9T4D4V9Ok3zlSdSR+tD0S9YSMNkbTn7SMC6+Ul0jTKWckivQU0wFoDwVTKaCW
 XP9AXFf7TvBC0iRs5+EYCnOca6Kjp1+d//ubnIj+q+fpZdUGgjouyKN
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test get_next_key behavior under concurrent modification:
 * Resize test: verify all elements visited after resize trigger
 * Stress test: concurrent iterators and modifiers to detect races

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c | 181 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c      |   8 ++
 2 files changed, 189 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 4fa8ef582b01..53ccc9366b5a 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -134,6 +134,181 @@ static void rhash_spin_lock_test(void)
 	rhash__destroy(skel);
 }
 
+struct iter_thread_args {
+	int map_fd;
+	int stop;
+	int error;
+};
+
+static void *get_next_key_thread(void *arg)
+{
+	struct iter_thread_args *args = arg;
+	int key, next_key;
+	int i = 0;
+
+	for (i = 0; i < 1000; i++) {
+		if (READ_ONCE(args->stop))
+			break;
+
+		if (bpf_map_get_next_key(args->map_fd, NULL, &next_key) != 0) {
+			WRITE_ONCE(args->error, 1);
+			continue;
+		}
+
+		key = next_key;
+		while (bpf_map_get_next_key(args->map_fd, &key, &next_key) == 0)
+			key = next_key;
+	}
+
+	return (void *)0;
+}
+
+static void *modifier_thread(void *arg)
+{
+	struct iter_thread_args *args = arg;
+	int key, value;
+	int i;
+
+	for (i = 0; i < 10000; i++) {
+		if (READ_ONCE(args->stop))
+			break;
+
+		key = i;
+		value = i;
+		if (bpf_map_update_elem(args->map_fd, &key, &value, BPF_ANY))
+			WRITE_ONCE(args->error, 1);
+	}
+
+	return (void *)0;
+}
+
+static void rhash_get_next_key_stress_test(void)
+{
+	struct iter_thread_args args = {};
+	struct rhash *skel;
+	pthread_t iter_threads[2];
+	pthread_t mod_threads[2];
+	int key, value;
+	int err, i;
+	void *ret;
+
+	skel = rhash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rhash__open_and_load"))
+		return;
+
+	args.map_fd = bpf_map__fd(skel->maps.rhmap_iter);
+	args.stop = 0;
+	args.error = 0;
+
+	/* Pre-populate map */
+	for (i = 0; i < 50; i++) {
+		key = i;
+		value = i;
+		err = bpf_map_update_elem(args.map_fd, &key, &value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "initial insert"))
+			goto cleanup;
+	}
+
+	/* Iterator threads */
+	for (i = 0; i < 2; i++)
+		if (!ASSERT_OK(pthread_create(&iter_threads[i], NULL,
+					      &get_next_key_thread, &args),
+			       "pthread_create iter"))
+			goto cleanup;
+
+	/* Modifier threads */
+	for (i = 0; i < 2; i++)
+		if (!ASSERT_OK(pthread_create(&mod_threads[i], NULL,
+					      &modifier_thread, &args),
+			       "pthread_create mod"))
+			goto cleanup;
+
+	/* Wait for modifier threads to finish */
+	for (i = 0; i < 2; i++)
+		pthread_join(mod_threads[i], &ret);
+
+	/* Signal iterator threads to stop */
+	WRITE_ONCE(args.stop, 1);
+
+	/* Wait for iterator threads */
+	for (i = 0; i < 2; i++)
+		if (!ASSERT_OK(pthread_join(iter_threads[i], &ret), "pthread_join iter") ||
+		    !ASSERT_OK((long)ret, "iter thread ret"))
+			goto cleanup;
+
+	ASSERT_EQ(args.error, 0, "no infinite loop");
+
+cleanup:
+	rhash__destroy(skel);
+}
+
+static void iterate_all(int map_fd, int num_elems)
+{
+	int *visited, key, next_key, i, err;
+
+	visited = calloc(num_elems, sizeof(int));
+	if (!ASSERT_TRUE(visited, "calloc"))
+		return;
+	memset(visited, 0, num_elems * sizeof(int));
+
+	for (err = bpf_map_get_next_key(map_fd, NULL, &next_key); err == 0;
+	     err = bpf_map_get_next_key(map_fd, &key, &next_key)) {
+		key = next_key;
+		if (ASSERT_TRUE(key >= 0 && key < num_elems, "key valid"))
+			visited[key] += 1;
+	}
+
+	for (i = 0; i < num_elems; i++)
+		ASSERT_EQ(visited[i], 1, "element visited");
+
+	free(visited);
+}
+
+static void rhash_get_next_key_resize_test(void)
+{
+	struct rhash *skel;
+	int key, next_key, value;
+	int map_fd;
+	int err, i;
+
+	skel = rhash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rhash__open_and_load"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.rhmap_iter);
+
+	/* Phase 1: small table, no resize - verify completeness */
+	for (i = 0; i < 4; i++) {
+		key = i;
+		value = i;
+		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "insert small"))
+			goto cleanup;
+	}
+	iterate_all(map_fd, 4);
+
+	/* Phase 2: trigger resize by inserting more elements */
+	for (i = 4; i < 100; i++) {
+		key = i;
+		value = i;
+		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "insert resize"))
+			goto cleanup;
+
+		/* Full iteration during resize - verify all code paths are safe */
+		for (err = bpf_map_get_next_key(map_fd, NULL, &next_key); err == 0;
+		     err = bpf_map_get_next_key(map_fd, &key, &next_key)) {
+			key = next_key;
+		}
+	}
+
+	/* Phase 3: after resize settled - verify completeness */
+	iterate_all(map_fd, 100);
+
+cleanup:
+	rhash__destroy(skel);
+}
+
 void test_rhash(void)
 {
 	if (test__start_subtest("test_rhash_lookup_update"))
@@ -159,5 +334,11 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_spin_lock"))
 		rhash_spin_lock_test();
+
+	if (test__start_subtest("test_rhash_get_next_key_resize"))
+		rhash_get_next_key_resize_test();
+
+	if (test__start_subtest("test_rhash_get_next_key_stress"))
+		rhash_get_next_key_stress_test();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index 0b30d0ec779d..ebbc1ba63d8b 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -256,6 +256,14 @@ struct {
 	__type(value, struct lock_elem);
 } rhmap_lock SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 65536);
+	__type(key, int);
+	__type(value, int);
+} rhmap_iter SEC(".maps");
+
 SEC("cgroup/skb")
 int test_rhash_spin_lock(struct __sk_buff *skb)
 {

-- 
2.52.0

