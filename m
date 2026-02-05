Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499732B9AA
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323236; cv=none; b=SqO+r8gCQdDL3NG85PLZn3NwptndhA8wbXGcuYbTwpJK5njStwSTwUheNPSSVsECbJ5Ljjgw3aR0Dba+P6ZDlBJglts973NjuJ1uXK/FlxiDN1O2BRXCdVa/X+8Xwd4DkvPQe0mBpFeIh76otwDue0uOgdA6bZxwQ8Pyj7jvfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323236; c=relaxed/simple;
	bh=yPwoFy2F52etMS82189nfwaU76dHE0K/kk+mi8ToBBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LH6LQJPDqux42VMoSTC+R+lI0faXohugIp7/527zMJpAAz5NsbDe/l9HpuuSIyAmhLJjAZPjI0djjLksADXIrmbUV0BrP3lfa1KH+42TsiIAmnuIzQDExZ28Crr+weILJYjaDqVLygu5RsQAX8zcQxcNtQnvwT8CcHb8PC1r+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewcEzq0m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewcEzq0m"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso14446325e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323234; x=1770928034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZEBQkAk32l632d1vVadsVwBeTU0gWKua83dEQl0cvo=;
        b=ewcEzq0mxGGhEnmfOu0OnIJqjiVG2w8zlyelpnKbxscCp8qB5nYsB8b6viYDiIWHOC
         YyBo0iwmKX84XUF/2ezlip0T7KRy02ZrBN8TcKWwEj4zOX/LulfYh0Au9rTPnuE+F4dw
         ToK2ZYm3cJggWUouiW/RH278P/B2R8yX/727H2eBUwiXPXrJZm09OCYkALKk1luuFD6E
         yT+iQXhLyiE0L2xk6nuJOE9ptLKSHanK1+PFMdh1MFVNSwDPB8USSAhq+prxLoR3tJHF
         vZrxHCe/w1O8VYo/uXgbu+zOmgcveKeskT52jYE4Kk9cpY6U1i5puMWSlhLa+hHJK1ag
         8E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323234; x=1770928034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bZEBQkAk32l632d1vVadsVwBeTU0gWKua83dEQl0cvo=;
        b=oyYNAheaOhs295aPGsQ8WR8atlGldMneWtnMb5FD77wnQP7PoSpGWU45j4FLyRWwja
         Xbs/0XVQAXDVmn3b+IRa/swoYgHferLqHDpjBx/e07cB6Wz0Ukv2TJJQu+B2KYXV2jJc
         V/qgMo3iWeMyPR89UcJ9TDgx05yEapDmwapHvA8Lz39XgwyjvKpmB+WpXaMUGe8B2SlQ
         d8lcbw1lQOYP3B6UbZBiW7TQLWt+4EGaG6nXbMJtO/4fE6UYfFvzqub6Igi8Aw6jbKSl
         4+OJQW/VByqqaZnuBrVBPWHacasw6vTt60ryrghnBCrjI0lrgxtSfTwEJYOdPtfzrp8z
         oz7w==
X-Gm-Message-State: AOJu0Yw63evWG089dOJHF0zIVMLFh2zv8i1xyiZNXUzRfbxGcIBJkelO
	4AbV0qUBV1+aeIV93sg7O6ZdJjhPKChie3uDoCe9m4eKUCw8WX3YJGgG
X-Gm-Gg: AZuq6aIrovchHxW75tg0tzlR07CA6RijOyoCEUqUGL6fGzx3CV8WIrZSz40w3UyJqo6
	yHj/v7GKBXQs6jNbD0lITdXqEYuNimWakyX17QUGQTZ6z7nl4xSc66jw4LnHaeBrVAf8b4QcHzA
	5wdScpYmxJPtCVvmHZ6BAqzs7wJta7FB2xroQNpPDrv3f82JoXoZKQcysvE9cUpC3Pv7XBR5KsM
	RCl7vBSeKaGZT1HdXuqsWh8zB/605hCPTiDl6yj3jBKu8KVwyYFFh/jOwK0EasQtP2rMiC1pRQm
	FdHmnO8CFvsVPkbWOGTmBJImNRT+I7V1YC1TrYh7q17YW3Q832yhb+qQ4qLasFycY/6sYhshvZO
	AcdBKUy29XAn/55FrOBfd75kBQgK5TF02VDi5W3KS8fWx5530M6JXq04gvPFvINJjh1G/aYo=
X-Received: by 2002:a05:600c:a15:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-4832021fe42mr9590005e9.27.1770323234317;
        Thu, 05 Feb 2026 12:27:14 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040a3cesm5432265e9.3.2026.02.05.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:38 +0000
Subject: [PATCH RFC bpf-next 08/12] selftests/bpf: Resizable hashtab
 BPF_F_LOCK tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-8-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=4717;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=pj+BbcAV0W5HxY/HENSfxOB+qVcUOOuZuo2EyFr0Cqk=;
 b=0A5wt71SepdaBahKK+K0AhIu7BV7VjIEBh3s+qCQXFPMRZ1vENfREUJxxPow7LLB+QQqUAwJL
 Iu9mJYegVaxD7COqLurwczjlCbusS+tNdcomjevLfMXAlB0ll4iv7CQ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add tests validating resizable hash map handles BPF_F_LOCK flag as
expected.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c | 99 ++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c      | 35 +++++++++
 2 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index be6e5e01bde6b127268f313d0ef25dcb33373b97..d1557405e062851ba2ad3d7378049c93395e7943 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -7,6 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
 #include <sys/syscall.h>
+#include <network_helpers.h>
 
 static void rhash_run(const char *prog_name)
 {
@@ -37,6 +38,100 @@ static void rhash_run(const char *prog_name)
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
@@ -59,4 +154,8 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_delete_nonexistent"))
 		rhash_run("test_rhash_delete_nonexistent");
+
+	if (test__start_subtest("test_rhash_spin_lock"))
+		rhash_spin_lock_test();
 }
+
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index 246cc4538c493902c720498bf7ab9bc5587d4643..fba55b5d9ed2575a1a31c4d2247c1d76f10d6bb1 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -247,3 +247,38 @@ int test_rhash_delete_nonexistent(void *ctx)
 	return 0;
 }
 
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
+

-- 
2.53.0

