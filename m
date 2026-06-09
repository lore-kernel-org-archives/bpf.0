Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD092BE034
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997850; cv=none; b=DbN4Yo2rthWJPER7aPIGqGcPkRbzYtcWnNBX4Ba0LyfV+u9B7TbMZQu3SYR1RkUY4nC5HYVPDYyFOnDR6qcYBQnxv7xx92Z01GlCf4U5yqmTfpbzxoWOKqSqC6tfrZd1+wr9eHLN5Z359Fs7yfuTC7pzTkmNsziT8kI1Ms1J0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997850; c=relaxed/simple;
	bh=E60PEvF8b/GhVdbiOH+su95Nyd8Z0lqGpVxPMzPkMoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6wghFh0QP9C6wo0pZ+MwblVFXJL/MDbkpbsjyQy0Hq7v0HVT1SOz5/vp1qnRxAFcDYA2UWXb3vAEmFFm14cFxLXaCx2nZtZLim7a6bDg68pxHduHAILQYZc5AKLR1DWD4PPN+et0TgUpFpYRbiE6yauFrnqGdSnxYXGjD8DaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm/f4/lW; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm/f4/lW"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso41808655e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780997847; x=1781602647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDDNl631Uxp17oTKNMP/mxzsb2F72nW0tI3DrJT9rwk=;
        b=Mm/f4/lWXrSLx4zgoHpOgw5kLSFZ7AJiJwcEFFWnM1hjR/N+rpniVf0D2LTgwtU8PM
         9mH6TSwZ4pR2YJke1tYW59AQJWdxIkJiiZj5LbJgugZk1HPKwqJHoY/fUvtZsVURnZcs
         hRjmJKUFlTH/x5UXw+dI43ULebSbJF9qAL7oRjwdnv2c5obMjf5XZ6L7Lle6HEozGu8q
         GJp58rxZlqfkgL7Hn2ci3IARscm3neAjamJi/bsWXCCiWR+jTt1LdjjfZAzQDyTsg8Kd
         0uU7n+T0lCt6uHaZzLCbh+46zBb01A/IfW6IUNIC9dOoPfEORmYZFBG9d1Uo008ZCGrK
         DABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997847; x=1781602647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDDNl631Uxp17oTKNMP/mxzsb2F72nW0tI3DrJT9rwk=;
        b=Bdyp5N1/Nq1HT9YR452xlP89ZWq4jHlJAxJHhIJHzf2X8vhKF6sDudphb0dD5ZhzJ9
         OKS4ZLf0Hl++GTdSWgZkBO0xeBSywSZA/vLpBJHzYF193rS/oKur5KRzT++iX4Kk5AUX
         CJ1wPz1SUerlaliFD+4/UBUyfG72SEG4dq4+cD594TJakg5ebSxz9kzYW/ZUNsZ+1113
         KR/BMh1u1ZLQvzcYHYGiorS3D/kghMdk8nA0zZOo8UNKkLPlBaoE63lyDqHwcKzao/uT
         7uq7oXOb8uCB6BT2mli0TZWFg30uqeQ6uX1ZdIEGS2zUe9fS3TKx0QmEZQZhLhipp2Z+
         hv5A==
X-Gm-Message-State: AOJu0YxEdAX3qPkY9Ki7+uFDXX62hCoLvl29egg/GBOG4zvxWrXiu+QO
	lFKyt8xGVloqHI245+zBAeSJ18wPLZHjx5fuBRgmCmFvERF1qgYz5WNS+a9UZerB
X-Gm-Gg: Acq92OHudEXeFbpxOQnP77ZMbuwMC7aqsJ94Dm6IUvMVHV7OsQoa6gCXtDeb0MV9HlK
	jQTyeS2WOYwScwjCrjke9IGGzC5JwS900tRsDJi9EZarWi98mO/wDGMZ+WH0Ty3Q4HxeMwXhRP9
	6VHXD+kpvk1J3iBe5AUrkOsTvvmADs1S+tC55MvdZePAyEd7ssE6PRDtV/1hwp6yko8MBCE6zMz
	4miUj2iwmiuZMKqZAmQHmE33vw7xyPYUSdleK3ofrBj4ZBxCLF3Kx7i30QKijy0jNRUKynWdPr7
	iEVlOdqWMSqI6Z2FHGj0l/Ea2E0YShYc8Tz0HDBpZi5P1g+9dVlB+8XHq8ZR89nr4gnRPzm3d7F
	/PO29/Q90pdZVcLlc7j38ka/wQIA6ad5BfAP4UoPO7t7c/UHeDfJh4ktAGJq+H/mu7HFt7FWPwM
	fmVrgrNiDr22KFCOFF0O07wOzfgH/VJVRVrlOj100Gwx6NjC8bD56gsZC7qtViu9zAAZ473H7E3
	pvtvCYJlM/W/bChzVpd2bnWAWu1eHOsz8buFPJc1LwLzTpaSruMRrh9EGrUZZQxWOZohHzGDxtS
X-Received: by 2002:a05:600c:8010:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-490c2cba8e7mr251489585e9.4.1780997847363;
        Tue, 09 Jun 2026 02:37:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm472879675e9.6.2026.06.09.02.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:37:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Justin Suess <utilityemal77@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Exercise kptr map update lifetime
Date: Tue,  9 Jun 2026 11:37:17 +0200
Message-ID: <20260609093719.2858096-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609093719.2858096-1-memxor@gmail.com>
References: <20260609093719.2858096-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5596; i=memxor@gmail.com; h=from:subject; bh=E60PEvF8b/GhVdbiOH+su95Nyd8Z0lqGpVxPMzPkMoQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUv93srNiiFB11hSus3+39RYt2dDbJ1U7KJ9mxr1+Ld+D 6n7/WNDRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACai9J+R4c7+SXPuzVvTd/Hx 6Ren2K9xX/539fdadSceK1ajtO1PvKcwMjwtirnjlrI06/z8j/cUlmzP8fn2kavwYWTsJQ1daQ0 rXlYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add focused map_kptr coverage for BPF-side map updates that touch values
containing referenced kptrs.

The new syscall programs stash the testmod refcounted object in an array
map, a preallocated hash map, and a no-prealloc hash map, then update the
same map from BPF. The refcount must remain elevated after the update,
while the userspace runner destroys the skeleton and reuses the existing
refcount wait to confirm map teardown releases the kptr.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       | 56 ++++++++++++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 89 ++++++++++++++++++-
 2 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index ec6f2f2e8308..17e707dddda8 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -143,12 +143,68 @@ static void wait_for_map_release(void)
 	map_kptr__destroy(skel);
 }
 
+enum map_update_kptr_case {
+	MAP_UPDATE_KPTR_ARRAY,
+	MAP_UPDATE_KPTR_HASH,
+	MAP_UPDATE_KPTR_HASH_MALLOC,
+};
+
+static struct bpf_program *map_update_kptr_prog(struct map_kptr *skel,
+						enum map_update_kptr_case test)
+{
+	switch (test) {
+	case MAP_UPDATE_KPTR_ARRAY:
+		return skel->progs.test_array_map_update_kptr;
+	case MAP_UPDATE_KPTR_HASH:
+		return skel->progs.test_hash_map_update_kptr;
+	case MAP_UPDATE_KPTR_HASH_MALLOC:
+		return skel->progs.test_hash_malloc_map_update_kptr;
+	}
+
+	return NULL;
+}
+
+static void test_map_update_kptr(enum map_update_kptr_case test)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct map_kptr *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = map_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
+		return;
+
+	prog = map_update_kptr_prog(skel, test);
+	if (!ASSERT_OK_PTR(prog, "map_update_kptr_prog"))
+		goto out;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(ret, "map_update_kptr"))
+		goto out;
+	if (!ASSERT_OK(opts.retval, "map_update_kptr retval"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->num_of_refs, 3, "refs_after_update");
+
+out:
+	map_kptr__destroy(skel);
+	wait_for_map_release();
+}
+
 void serial_test_map_kptr(void)
 {
 	struct rcu_tasks_trace_gp *skel;
 
 	RUN_TESTS(map_kptr_fail);
 
+	if (test__start_subtest("update_array_map_kptr"))
+		test_map_update_kptr(MAP_UPDATE_KPTR_ARRAY);
+	if (test__start_subtest("update_hash_map_kptr"))
+		test_map_update_kptr(MAP_UPDATE_KPTR_HASH);
+	if (test__start_subtest("update_hash_malloc_map_kptr"))
+		test_map_update_kptr(MAP_UPDATE_KPTR_HASH_MALLOC);
+
 	skel = rcu_tasks_trace_gp__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "rcu_tasks_trace_gp__open_and_load"))
 		return;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index e708ffbe1f61..3fbefc568e0a 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -489,8 +489,7 @@ int test_map_kptr_ref3(struct __sk_buff *ctx)
 
 int num_of_refs;
 
-SEC("syscall")
-int count_ref(void *ctx)
+static __always_inline int read_ref_count(void)
 {
 	struct prog_test_ref_kfunc *p;
 	unsigned long arg = 0;
@@ -500,11 +499,95 @@ int count_ref(void *ctx)
 		return 1;
 
 	num_of_refs = p->cnt.refs.counter;
-
 	bpf_kfunc_call_test_release(p);
 	return 0;
 }
 
+SEC("syscall")
+int count_ref(void *ctx)
+{
+	return read_ref_count();
+}
+
+static __always_inline int stash_ref_ptr(struct map_value *v)
+{
+	struct prog_test_ref_kfunc *p, *old;
+	unsigned long arg = 0;
+
+	p = bpf_kfunc_call_test_acquire(&arg);
+	if (!p)
+		return 1;
+
+	old = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (old) {
+		bpf_kfunc_call_test_release(old);
+		old = bpf_kptr_xchg(&v->ref_ptr, NULL);
+		if (old)
+			bpf_kfunc_call_test_release(old);
+		return 2;
+	}
+	return 0;
+}
+
+static __always_inline int check_refs(int expected)
+{
+	int ret;
+
+	ret = read_ref_count();
+	if (ret)
+		return ret;
+	return num_of_refs == expected ? 0 : 3;
+}
+
+SEC("syscall")
+int test_array_map_update_kptr(void *ctx)
+{
+	struct map_value init = {}, *v;
+	int key = 0, ret;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 1;
+	ret = stash_ref_ptr(v);
+	if (ret)
+		return ret;
+	ret = check_refs(3);
+	if (ret)
+		return ret;
+	ret = bpf_map_update_elem(&array_map, &key, &init, BPF_EXIST);
+	if (ret)
+		return 4;
+	return check_refs(3);
+}
+
+#define DEFINE_HASH_UPDATE_KPTR_TEST(name, map)			\
+SEC("syscall")							\
+int name(void *ctx)						\
+{								\
+	struct map_value init = {}, *v;				\
+	int key = 0, ret;					\
+								\
+	ret = bpf_map_update_elem(&map, &key, &init, BPF_NOEXIST); \
+	if (ret)						\
+		return 1;					\
+	v = bpf_map_lookup_elem(&map, &key);			\
+	if (!v)							\
+		return 2;					\
+	ret = stash_ref_ptr(v);					\
+	if (ret)						\
+		return ret;					\
+	ret = check_refs(3);					\
+	if (ret)						\
+		return ret;					\
+	ret = bpf_map_update_elem(&map, &key, &init, BPF_EXIST); \
+	if (ret)						\
+		return 4;					\
+	return check_refs(3);					\
+}
+
+DEFINE_HASH_UPDATE_KPTR_TEST(test_hash_map_update_kptr, hash_map)
+DEFINE_HASH_UPDATE_KPTR_TEST(test_hash_malloc_map_update_kptr, hash_malloc_map)
+
 SEC("syscall")
 int test_ls_map_kptr_ref1(void *ctx)
 {
-- 
2.53.0

