Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD513DFC9B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930130; cv=none; b=IqJ7yiHVZaA0GKWqBImN+ytqUFjheYrsTaLSJ1Zeu9YB/xZ9msomNdngHGBYkBfm/CE5pF8vS9u06LPWOkwoMBKTaB47ssi5pV94ZfPH1ji2hJHIf+MBRN2rEK+5/r3SzWRjIkSjySCzGLQYKJmGQkYjmj/nzMVtHBbAvx+cbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930130; c=relaxed/simple;
	bh=E60PEvF8b/GhVdbiOH+su95Nyd8Z0lqGpVxPMzPkMoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+xIBMijgMnIA6Tk7n14p8cuRJ5z7CWqXp4Y6vSUnw9iVsJBeRZa3LVeJ6U6QWhxiVvoPBr/Pz7Ge1HEosKCntEdjKSkrDv+BKXnLLRgOnUdvSuPNF0+Yr8JXkyRPpaaEnjKGX2LT2Yu8Ljpu1wejSivUrJzg11ipdZp3jvI1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE7ViPKm; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE7ViPKm"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b7866869so51325445e9.2
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930127; x=1781534927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDDNl631Uxp17oTKNMP/mxzsb2F72nW0tI3DrJT9rwk=;
        b=NE7ViPKmbGgqQChRe3MNuGp4mlEFGA7Ga/y2NMo1v1dADAj9AoplsoY1fiGI05O382
         4GHGB5evdWL9n3LCCxZv5jNBVEYrOJuHqCZ99niu+dH66p+Lp5mbml0MxJcW3iOSrWuG
         m2qm7wOTeM3iaiO5x6o5odHg0y3lLz0GCsqkHAQADthk46jdzOAdTLlbhMCV1tmcszUu
         7KVVxz4NjjZGc34TWnwlVhwm4SZVQQGe79HZSIS74X5UEnDIOox/ga8F0Nj4KwYfAf+1
         7IF698GM4fQHlKs8WqZHOkwa4+aadJHo8OgT/x0TuKXrWpiEQ69lWvU3PEan2tXktsvL
         ef5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930127; x=1781534927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDDNl631Uxp17oTKNMP/mxzsb2F72nW0tI3DrJT9rwk=;
        b=oaEfKEgy9umn2YaieLc1l74AykUqhfmnCXXZoMfqhlGIhSFzeYdlLzGaWQ9KxI4Z5N
         OAOwNNosS1Meue/ygmBkX4oQwXMy41iYu7xty2wZmbL2pB0X6bwRp+4Gao3kISNKhebl
         f2NMlWoial41hK2XC4mir3I6+uwsM2fJNhq5jJLL8HRoiRohbgnQplsNA31tUog5igil
         ZmaFZml5ALLypJxjdQMHEa3Ln2jpRjgrZcsbYaVQyaYzYGMZ7fgIjQSB/vosgAeIv8py
         dNtzUBQMqzLmDn7NHDoafWKF2RUZ2FTkUlR+14RJ40gGeQ1ujpx/a+Gk2hZn25fS70Ph
         ZZgg==
X-Gm-Message-State: AOJu0YxJ8XPV5fb5EWZWLxbqtA+00lLJJxpK3YQibSS4IvbELvvDqHSE
	0yYvEhJT5B+GzLoInEGZf/iN++hPmJqcMkiTAVz7Jo/+R4sZ2kwlUCoW+l7eG2h+
X-Gm-Gg: Acq92OFnYZ6wjJ1OV+RMtwtzZ93C8fNAA8O6jObRRR+P5aRUE2mtP2nTd2koFBdyVjA
	ecRis7R5EedoPC4pzHOSHsWP8fg+ViM/q2QwWHpFww8YlakybRBExwqkWw5NcO5F4Fe1+7Crftz
	skOMHOjXB/WKnkLeNRpMSYG8f6SKjsazUTlqHdSu4YxVAjETGK3vIYk+EXFgLqQzbxNDDdFhaYm
	+CHUjonMptUi85leiBW4aY+O+fdSj1OCmKUxM0GedZPtkKMV1XpTQPAbupoJxWTnhNMyJgB8Cis
	QbQN50sFbB1lXO4C9HBSkUbEoo5z0wIFO2TL4QtZRYMLbCQjPbdh2jNflewHddQViccYWkaCyb3
	r/4z27/lY5zk67AjePbQ0YENCOWmOoV4WUPAc8VV/nd4GZIY8IPGN3L8MK1yOp/lHgxtQz5NwSi
	OHsU5035dalxUICOu7Ye7T9uvaEUHC+aAfxGCH8zt8snR+hLcJIeGrKv+8ASgCPabD2F6IDNZ6Z
	w3X8h1X2rvNhmroJMg9522eYjtfL5ZOZ5wCeO6RePzlDOwK65j4awbAqa3U80LwrpGrahED3r6r
X-Received: by 2002:a05:600c:6995:b0:490:9d1b:f06a with SMTP id 5b1f17b1804b1-490c25dae8dmr248970825e9.10.1780930127259;
        Mon, 08 Jun 2026 07:48:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm479039865e9.9.2026.06.08.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:48:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 5/5] selftests/bpf: Exercise kptr map update lifetime
Date: Mon,  8 Jun 2026 16:48:38 +0200
Message-ID: <20260608144841.1732406-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144841.1732406-1-memxor@gmail.com>
References: <20260608144841.1732406-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5596; i=memxor@gmail.com; h=from:subject; bh=E60PEvF8b/GhVdbiOH+su95Nyd8Z0lqGpVxPMzPkMoQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUvtmvRmxZCgaywp3Wb/b2qs27Mhtk4qdtG+TY16/Fu/h 9T9/rGho5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN50MzIcPnziVnl6ef7H391 UtVYGlfQ8WSW02yTj9Jr/hQcFMy0mMvIMEv5zLFaVbFdm6uV+v8/UDpkpdcSXeZQJzC52nfd1Ip prAA=
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

