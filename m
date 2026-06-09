Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049463B775A
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036757; cv=none; b=udtg1Vih03w4i7Zpk7jV4tkwYGwEHHZm7EXPAPSjc9sSaNv7rVcGTYLz5oMbCrDmXS842jcdtpgTNUv9B7HxG6QSRYufDE7J2l+rlxoO0iUnT1wL+PcONREZ1/c3P4WFPBVVVIacpn+ZrCipi1mR1rhSUDCWGLnyFacB9ZwS29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036757; c=relaxed/simple;
	bh=E60PEvF8b/GhVdbiOH+su95Nyd8Z0lqGpVxPMzPkMoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6NhZ4g8vLKlRkx8Ep0sG5Lk0pvp/3QZI4cRjIq86dwISzjykK+4InVEeSlHMFbzUYl2jertKejnCkjJLBFgnAEzAkt5FFKxzCm20Va2aZ7VEqM0o2wyvhi8fq9M+a4FYd88jnTFe5F+GenHBsfMeZAXK7O4Z0GBGIirnsAQ+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn7aRG8x; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn7aRG8x"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4164473f8f.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781036754; x=1781641554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDDNl631Uxp17oTKNMP/mxzsb2F72nW0tI3DrJT9rwk=;
        b=Jn7aRG8xxcXivys5/GN8d7nwc6/xhB4IJ/Gwv7stBe85gDdEi0ot4T9xv+WgZJzRFw
         ZY4ZwN0aZD3eAKeGgKc6nEJXvC+Rhmn3kdKzvevtKSiYQNgb5t0u5ABAlIqqLKSeKq0U
         wtpTW4kgGzzJ49Ch4MuGnuo/GHwAZT2SbPVStb8NwCwqwxXHfyT4UgiIm6BCxlHnElgA
         Jqgz6/k1PkJw2i7965NXcwzCKRSlOIlhIzD+4xEOv2dgdj9ZTrcH0LUJHa8uW3NFJXTo
         p9+eLIHpjXve/J4DA8kjpqJf8+DSMFE3ijO19ziUY+80gu7DRZ01ynZ8de1boSKnWZio
         nyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036754; x=1781641554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDDNl631Uxp17oTKNMP/mxzsb2F72nW0tI3DrJT9rwk=;
        b=UNOqRVWbzA4gU6SDmRb/8enDJ/smylYbShb/Nq5uwnQGJTf7B3FVodK+kx1aeXOg+0
         ZinY1C6mf6a0mSbDF19O6J8qmEKna5+DLMeL91qJQJ27ILr4SHSLqtuyIxqrjzF6cPui
         WP+WPelGnIokyucez+/lCqSkYKl3BDASeueBrFcWtbU+j0gxPM7B0+CSNIHf/TDOrNiz
         vwMC8MY+2cTZeC5OQ6vEYLBHCUZCyl90uNz6CHKOkbYq9ZLqpaaAaKq8OeEpd+fOzMSw
         HKxrBeN3jBGIcsqYTk5cLu/aMZGnJyzn5QQMoFbQIR0cyTMFrF/fQKsCQX132tKz5EQ7
         xUkQ==
X-Gm-Message-State: AOJu0YxgWp5DvJuzwkEGz3tSN2m9H3qdxNTsqi92zdIyWWVS9rflmS9h
	X1ohoQYcxQmBpFwo7nYcckxs5Uo0I8CUzmvbIUOZnTHZH6x4bIKRepCQPMYaT0N7
X-Gm-Gg: Acq92OFb1z4EwPDwY6ldOit2c+0BMIKaedUOpWB3djy7lUktmeoDNrZIAwgsTKOEq7R
	sKmx7HTiS1qtakO0luuy9Tdl6gpOu3q1Uq2ehV3s4x5Gyguf+7IAVMvD4xR8Kvcg2cSQgx1ho77
	iqHpKQ8qd0rVPNxpHFIIA0iehdOEWI1TYwNFIm3tyr2lPbUNiaCvITtvy9lilbtH1dGgBrc9r1e
	tBwqMo9OO9uFEj24aLdspvGnLb6Sq6fFSR+rrTNPQF2oNX5IF+toXdXGVij3I4+wa6vruXeOrTv
	m0z1OvW7n6f0IyjCtDQaM5ASV+gDwkIFemLw8c1XUUy7zhuRqfZblC7U6+j1tdVBjerBSfcSvZy
	B+fqGGhUwmq+WBEIZDGnoeejAkuuDRkjTUnF/zHRx3DfWK1vr1SHEaoIEKBbu5/qI4mCAPBAjgE
	SNCYejKVklsdZiVtgINgcbk7dsoT2Ld8lnbmHfJfVTTwRhZVAZBVihU/wkg9IgTPaIqFlhZMwei
	8xCYpx7wzcAm8B5ir6cQw6h2PmQ+3MtyA8aZtjZdU9l7EGzycxltA8AZ9j4uFUmGnlANa/YTVDh
X-Received: by 2002:a05:6000:1241:b0:460:2ee5:67b8 with SMTP id ffacd0b85a97d-46030640671mr23748593f8f.36.1781036754280;
        Tue, 09 Jun 2026 13:25:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm71706218f8f.24.2026.06.09.13.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:25:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Exercise kptr map update lifetime
Date: Tue,  9 Jun 2026 22:25:46 +0200
Message-ID: <20260609202548.3571690-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609202548.3571690-1-memxor@gmail.com>
References: <20260609202548.3571690-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5596; i=memxor@gmail.com; h=from:subject; bh=E60PEvF8b/GhVdbiOH+su95Nyd8Z0lqGpVxPMzPkMoQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUujLG6zYkjQNZaUbrP/NzXW7dkQWycVu2jfpkY9/q3fQ +p+/9jQUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlIdjD8D+fYn/d7n6DibM6l 943lGj/++z/1oZpcNa+72OH5J+yvbGFkmPVR1r79koDoJemcLcWpMvyTWHe52p8vvFA7b5F//c5 6RgA=
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

