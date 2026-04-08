Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936BE3D565E
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661060; cv=none; b=iK7xPTvbXuN3t5yM9az1OyWOa5rbqDmiRBocgjq5FFPMS3u/VMkEDykS40ImlTbMUxb6Mp59j3z0lnrVAYsIjtuTlVRClLdS7BUAe4opYyMmZXnWBr0vxNbc8+zTUqvNt7G1BzG8vk09HL5R3m/JKCqbvxS6V6WyA/D4bE8uwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661060; c=relaxed/simple;
	bh=QYqEWkzRlIMWWnfGW0ie20+wl97L2UTlc7oxRGha2sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlJwNOVMi6KFZoyF87YQoyGihqjemGDDK29XkoNXQhL5R8gkM5TmUaNLlfC+rNNikdCTOewOx4rb4OBFUX2UmQNQAmgfQwskWSVfAm6YouRBU0jC7YAMXKDc7XJ/IZu4VOuyGX3FClYChzjV6qGuO0Q5ColmqXGwRj0QlYI8vJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srp5rMSm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srp5rMSm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488c2690057so17329745e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661057; x=1776265857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k91ko9xju6eDkOhLcConPpwi578BClc4bE4DO/WimiY=;
        b=Srp5rMSmo35ZWMNeE4WYvz73pHm7gJ4kUl+0/3m3aTPt5dxmPPhqeIAuFbXvPQUwM7
         3eKlLRamZQn8+D5KEGmfT72mLKbNYzeXnTFhdJh1QIB/asiy3rFpUM3wHPVBraDnbFGl
         Uxam8xozhMpOujiQ/f1rD1S4FpHKVISSIfOqnER6Dgns01oRS9vXAsL+4VZId7F7bCbw
         ItY37/q78npN2xLgorCBV/DxbLqgG5RCHhr53rCvDXZf0WIkwI55lcg5dvdqqgiyYgdY
         FIGlyY+38SEoW5Hdrf0NpEurEP6Des5RG5PE/0HaUbL43hJQZfPZ5vZd2WMJOtWs+YCq
         Mv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661057; x=1776265857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k91ko9xju6eDkOhLcConPpwi578BClc4bE4DO/WimiY=;
        b=hdTNnbxgNc666IDAmEj3hxMoeK7QMim7iy+6WJZbxSZrqtYdxnuH9lf6laXTJpJ2LC
         f1M69AaUkzYb2fxHhQF6pyTcqXK6mIuBgobUoslNyeveLjlAgCyg+6kgkyiBT8ItyC2G
         qm4gXVX0wRiJelpV7BW25NwRU1AWZ6dC9u2E7CjHfbpFPmd+fjI/amNNrwLtrGbhO1ls
         PIQCFfm7zI9oSs20VflQEXs82gCZihmqCxYZdjeLoMRXWdagHdJxGzJ0bqxfElMnIRwu
         n4NzD3MJJj0Q7gopOYuXL5DQQmUnEC2UuBX1O7QyP8FEYi3GY7B/RHhehIjPMDixEBr1
         eDXQ==
X-Gm-Message-State: AOJu0YyAse2qmHcpfNc8tXr1Fk1c+ToZYQNAlUGjgIEUNmFpSFJkBi96
	qYhMFscv30t/TH2+8xHPkJ0g+m7G/roT6PFzV0/1F0sBZdKS8Y+3giw4
X-Gm-Gg: AeBDietg0QeaZ5xzMdu47dW0edeQfKjppdxafNCvTYWwAZa5a+2crjPX+0hcaIaFDKa
	btOaHQlybBzoV1F0Vit65m7RT/4tMAOrjva/O9gJl2zSa+Jkt+plu8mACBhzO4fefs96QD9+IMr
	1EvYpb5RIqiAom0x3krsmbZIoKjZR3H7L3SUBfFmgxYg1rGUYPsp3tPqcgkFEeEwd+xsGdibmqy
	LoG6dzrQjmBN6a/AxMWSyQAYCdifqy8/T60zsX2ka2OzYnnrtWPfLXtShlSzrI87CyGAFWolF1x
	KjFNfIIuX3G9HiZlpdPrZHs4u/P/aZCtFF5rlCoRSMNbrOsnChqxni9tD8F0UtyH/QSt+89G3uj
	VSQusOMCKrjmRl/IgLfZH29P/8GI5XIeZKLzN4hVRhTfSKdp9bE8LGpiMcWrxsGlN9kDqUuQK4Q
	FWxB4RcTvq0oqZoA==
X-Received: by 2002:a05:600c:c0dc:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-488ccf3a0fcmr1656105e9.3.1775661056840;
        Wed, 08 Apr 2026 08:10:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:47::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm436587535e9.12.2026.04.08.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:56 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:19 -0700
Subject: [PATCH RFC bpf-next v2 14/18] selftests/bpf: Resizable hashtab
 BPF_F_LOCK tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-14-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=4614;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=GjiMXbx5OQgmu7kp5eWkRsIprxNXc/gqhJnmqlBwxV4=;
 b=0Dl3vQb3BtHL9U2g1XMciqXJb0NBw9vyMZWE0zb3FZUyc/QqcE7+1wnBYbVPniSVUstKmjyib
 skjNPF7529qDxxr1PXxiL1J3XFAeyeGP8QUbJAMO6OOR8yfY2jdy95t
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add tests validating resizable hash map handles BPF_F_LOCK flag as
expected.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c | 99 ++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c      | 35 +++++++++
 2 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 40f30ce69190..4fa8ef582b01 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -7,6 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
 #include <sys/syscall.h>
+#include <network_helpers.h>
 
 static void rhash_run(const char *prog_name)
 {
@@ -39,6 +40,100 @@ static void rhash_run(const char *prog_name)
 	rhash__destroy(skel);
 }
 
+struct lock_thread_args {
+	int prog_fd;
+	int map_fd;
+};
+
+struct lock_elem {
+	struct bpf_spin_lock lock;
+	int var[16];
+};
+
+static void *spin_lock_thread(void *arg)
+{
+	struct lock_thread_args *args = arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 10000,
+	);
+	int err;
+
+	err = bpf_prog_test_run_opts(args->prog_fd, &topts);
+	if (err || topts.retval)
+		return (void *)1;
+
+	return (void *)0;
+}
+
+static void *parallel_map_access(void *arg)
+{
+	struct lock_thread_args *args = arg;
+	int i, j, key = 0;
+	int err;
+	struct lock_elem val;
+
+	for (i = 0; i < 10000; i++) {
+		err = bpf_map_lookup_elem_flags(args->map_fd, &key, &val, BPF_F_LOCK);
+		if (err)
+			return (void *)1;
+		if (val.lock.val)
+			return (void *)1;
+		for (j = 1; j < 16; j++) {
+			if (val.var[j] != val.var[0])
+				return (void *)1;
+		}
+	}
+
+	return (void *)0;
+}
+
+static void rhash_spin_lock_test(void)
+{
+	struct lock_thread_args args;
+	struct rhash *skel;
+	struct lock_elem val = {};
+	pthread_t thread_id[4];
+	int err, key = 0, i;
+	void *ret;
+
+	skel = rhash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rhash__open_and_load"))
+		return;
+
+	args.prog_fd = bpf_program__fd(skel->progs.test_rhash_spin_lock);
+	args.map_fd = bpf_map__fd(skel->maps.rhmap_lock);
+
+	/* Insert initial element with BPF_F_LOCK */
+	err = bpf_map_update_elem(args.map_fd, &key, &val, BPF_F_LOCK);
+	if (!ASSERT_OK(err, "initial update"))
+		goto cleanup;
+
+	/* Spawn 2 threads running BPF program (uses bpf_spin_lock) */
+	for (i = 0; i < 2; i++)
+		if (!ASSERT_OK(pthread_create(&thread_id[i], NULL,
+					      &spin_lock_thread, &args),
+			       "pthread_create spin_lock"))
+			goto cleanup;
+
+	/* Spawn 2 threads doing parallel map access with BPF_F_LOCK */
+	for (i = 2; i < 4; i++)
+		if (!ASSERT_OK(pthread_create(&thread_id[i], NULL,
+					      &parallel_map_access, &args),
+			       "pthread_create parallel_map_access"))
+			goto cleanup;
+
+	/* Wait for all threads */
+	for (i = 0; i < 4; i++)
+		if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join") ||
+		    !ASSERT_OK((long)ret, "thread ret"))
+			goto cleanup;
+
+cleanup:
+	rhash__destroy(skel);
+}
+
 void test_rhash(void)
 {
 	if (test__start_subtest("test_rhash_lookup_update"))
@@ -61,4 +156,8 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_delete_nonexistent"))
 		rhash_run("test_rhash_delete_nonexistent");
+
+	if (test__start_subtest("test_rhash_spin_lock"))
+		rhash_spin_lock_test();
 }
+
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index 2cd41324bcb9..0b30d0ec779d 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -240,3 +240,38 @@ int test_rhash_delete_nonexistent(void *ctx)
 	err = 0;
 	return 0;
 }
+
+#define VAR_NUM 16
+
+struct lock_elem {
+	struct bpf_spin_lock lock;
+	int var[VAR_NUM];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct lock_elem);
+} rhmap_lock SEC(".maps");
+
+SEC("cgroup/skb")
+int test_rhash_spin_lock(struct __sk_buff *skb)
+{
+	struct lock_elem *val;
+	int rnd = bpf_get_prandom_u32();
+	int key = 0, i;
+
+	val = bpf_map_lookup_elem(&rhmap_lock, &key);
+	if (!val)
+		return 1;
+
+	/* spin_lock in resizable hash map */
+	bpf_spin_lock(&val->lock);
+	for (i = 0; i < VAR_NUM; i++)
+		val->var[i] = rnd;
+	bpf_spin_unlock(&val->lock);
+
+	return 0;
+}

-- 
2.52.0

