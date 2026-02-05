Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF932BF4C
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323234; cv=none; b=svKlmtB01AHVbmTt2cocrIwTtl+b2QJh2MPWnOu6n5TRk9s8Q3DVmq/yt7j1fg+EL2Swn+Gx/HhpHlD0jf8JeoYqpaZiN2pdJgzMpLrfNDKYxnwHi8xTpjGD7vto/TH3oePT3LlOfj07xXw1i6eO3ur1JUzvntn7D+d42vqRsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323234; c=relaxed/simple;
	bh=1ta+ZYnRm55AbSDPjeSE3DOwO95+UnFmvNmIe8ZA2ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kikSofj6IcARLwj6ScLuKF94glLaADjngt4gOWk0fN6EMfBY7hXyW74HZ3vtVbA+JmjofUuHsNpzI7XZgWDulQ721Np7FH5e/FhRg0EEGFyJjfj7q41rPIdE9OdcJmIwlYO0vFFWW7t/MH7FMP+3Fwv7xErM/mTiyfODNY2F294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdMDY6F2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdMDY6F2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so15378745e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323232; x=1770928032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8xP1aGbLe/riITsCH3+/fuQ/t4PzWSufshnVXKy80k=;
        b=QdMDY6F2BS5UNX3Z3HghGDQrz1ber+k62xeOHrKuT31aBySTnRXwU5y4CJkLQfO2hj
         mKKaI/Do2nIJp89g4sD4m83KSeyCR8yxjwgA7lfBNkawFaGC/iBs40p2piszfrPZw4Hf
         WNAN5SwpRJmGjmGXvoNV6F2FbsqrMevHV38NGObmta8BGVu/H8u/E9ahr12kurE0iwCJ
         YzOH8/MYy2RzRRiEApBlHOHXQovOAM/3gW/LJH/SGPjyNpk5maphl5IIpCLLJU6Cb5De
         CMiewnWf4fJlWUz610zmwuTM9lPaoG274utxXROhM/7QUP4lzxFuAvEh3KLLFtmI9kxu
         rjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323232; x=1770928032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w8xP1aGbLe/riITsCH3+/fuQ/t4PzWSufshnVXKy80k=;
        b=eEZ1RwuppJG2oWGHpzbSqJwcMSCAyUD/QKqBRho/qFN7ODWugYFkwLXCefBSkWe4Ma
         MZcF9SowxVBEcevjIIZrWi/k5LU+VVi+dO3jlYgrMkLsIjlwj6EWTlmtQYcC3OKuQYKB
         Q+ZwHy4Uw49Q+xnOodlcGypDec7ujKb8m1fuIuRB/phGLmzQ51yj4bo9ZxzXKWWj/7sg
         QjT+ErdVIJnwTdWE4CY6tn7XiPRfsBpLj6COXF1vIu0kIQAYpKJ3E2YfyhNq/sndMDZX
         tG/DBvbg6JqIadpReRE3fCxAsN5ByQNEeEdqMcXEbkG76eERvOCEgd6WG1TjBRZGc3vh
         K5sA==
X-Gm-Message-State: AOJu0Yz86cJcaTlW3RoXv+RR6Np4mPGezS9kpmdyQBtV+c9jDQ4qX2uA
	2wWzT99A08SGShcYYicVSGx8IXjIQ7gMsuxgxq5+4bkroHzXPPtT/c+W
X-Gm-Gg: AZuq6aJ32RAYnuwxrHnbPQMwRaxNjShbBLFwSiBQcjDD9um8LsxV5/dOHj1r0UElZ4z
	mTUQm23g/dPyJAxr5YCD/60ki7yWxW9GEW3Z0pnWqaXH/aWPPtuzpKqfHbFg4YHO3HOH+r8vU5V
	j9DC0qIcZ5iwn4RIhhpB319OA4pqrFqpLb4SmOPOnpm39LgUMFO8T6U5Shlzlwh9SZt9f8Z9eVS
	OP/2vWWWnCdxr7hY/sQmuHAkZdsIfpF4Atkpz/0TKZxEB8dnN1+RNOxnehsY1ANBoFEI9xPuku/
	g5z0mta6dQ+lAPQlvd9bJmQIIVvVlQWtz5aTssvq2LPB0DeVH/jQtwgkpvVRHsAqYjL4jcqr89e
	80iGCF7nN/K1Bvwo3y9nlnuUSzwMps/cTBuyTiNbUznK1qxJomUjXw6awHLFQ8i9QbqEokZw=
X-Received: by 2002:a05:600c:1387:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-4832022a235mr10333415e9.35.1770323232317;
        Thu, 05 Feb 2026 12:27:12 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc543sm3277705e9.4.2026.02.05.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:11 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:36 +0000
Subject: [PATCH RFC bpf-next 06/12] selftests/bpf: Add basic tests for
 resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-6-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=7752;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=2Ch4/l2GSpYdYhdbHWV83Apg3X/P5PKHggzZK4IOqmQ=;
 b=jRePI8wgthnpW1tbVfpUnXr4HeDG/Xbj/5knShi90GC423nuqmTQdm51d1tvNtJhmGkm/AHwP
 YEL1Lt7zrEIDS4LqunXP3I69KiBagCVg/LIpbBM41OoFl+OfsmoO9Y0
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test basic map operations (lookup, update, delete) for
BPF_MAP_TYPE_RHASH including boundary conditions like duplicate
key insertion and deletion of nonexistent keys.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c |  62 ++++++
 tools/testing/selftests/bpf/progs/rhash.c      | 249 +++++++++++++++++++++++++
 2 files changed, 311 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
new file mode 100644
index 0000000000000000000000000000000000000000..be6e5e01bde6b127268f313d0ef25dcb33373b97
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <string.h>
+#include <stdio.h>
+#include "rhash.skel.h"
+#include <linux/bpf.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+
+static void rhash_run(const char *prog_name)
+{
+	struct rhash *skel;
+	struct bpf_program *prog;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	skel = rhash__open();
+	if (!ASSERT_OK_PTR(skel, "rhash__open"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	bpf_program__set_autoload(prog, true);
+
+	err = rhash__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(err, "prog run"))
+		goto cleanup;
+
+	if (!ASSERT_OK(skel->bss->err, "bss->err"))
+		goto cleanup;
+
+cleanup:
+	rhash__destroy(skel);
+}
+
+void test_rhash(void)
+{
+	if (test__start_subtest("test_rhash_lookup_update"))
+		rhash_run("test_rhash_lookup_update");
+
+	if (test__start_subtest("test_rhash_update_delete"))
+		rhash_run("test_rhash_update_delete");
+
+	if (test__start_subtest("test_rhash_update_elements"))
+		rhash_run("test_rhash_update_elements");
+
+	if (test__start_subtest("test_rhash_update_exist"))
+		rhash_run("test_rhash_update_exist");
+
+	if (test__start_subtest("test_rhash_update_any"))
+		rhash_run("test_rhash_update_any");
+
+	if (test__start_subtest("test_rhash_noexist_duplicate"))
+		rhash_run("test_rhash_noexist_duplicate");
+
+	if (test__start_subtest("test_rhash_delete_nonexistent"))
+		rhash_run("test_rhash_delete_nonexistent");
+}
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
new file mode 100644
index 0000000000000000000000000000000000000000..246cc4538c493902c720498bf7ab9bc5587d4643
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <string.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+#define ENOENT 2
+#define EEXIST 17
+
+char _license[] SEC("license") = "GPL";
+
+int err;
+
+struct elem {
+	char arr[128];
+	int val;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 128);
+	__type(key, int);
+	__type(value, struct elem);
+} rhmap SEC(".maps");
+
+SEC("syscall")
+int test_rhash_lookup_update(void *ctx)
+{
+	int key = 5;
+	struct elem empty = {.val = 3, .arr = {0}};
+	struct elem *e;
+
+	err = 1;
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (e)
+		return 1;
+
+	err = bpf_map_update_elem(&rhmap, &key, &empty, BPF_NOEXIST);
+	if (err)
+		return 1;
+
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (e && e->val == empty.val) {
+		bpf_printk("All good look up!");
+		err = 0;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int test_rhash_update_delete(void *ctx)
+{
+	int key = 6;
+	struct elem empty = {.val = 4, .arr = {0}};
+	struct elem *e;
+
+	err = 1;
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (e)
+		return 1;
+
+	err = bpf_map_update_elem(&rhmap, &key, &empty, BPF_NOEXIST);
+	if (err) {
+		bpf_printk("kkl 2");
+		return 2;
+	}
+
+	err = bpf_map_delete_elem(&rhmap, &key);
+	if (err) {
+		bpf_printk("kkl 3 %d", err);
+		return 3;
+	}
+
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (e) {
+		bpf_printk("kkl 4");
+		return 4;
+	}
+
+	err = 0;
+	return 0;
+}
+
+SEC("syscall")
+int test_rhash_update_elements(void *ctx)
+{
+	int key = 0;
+	struct elem empty = {.val = 4, .arr = {0}};
+	struct elem *e;
+	int i;
+
+	err = 1;
+
+	for (i = 0; i < 128; ++i) {
+		key = i;
+		e = bpf_map_lookup_elem(&rhmap, &key);
+		if (e)
+			return 1;
+
+		empty.val = key;
+		err = bpf_map_update_elem(&rhmap, &key, &empty, BPF_NOEXIST);
+		if (err)
+			return 2;
+
+		e = bpf_map_lookup_elem(&rhmap, &key);
+		if (!e || e->val != key)
+			return 4;
+	}
+
+	for (i = 0; i < 128; ++i) {
+		key = i;
+		err = bpf_map_delete_elem(&rhmap, &key);
+		if (err)
+			return 3;
+
+		e = bpf_map_lookup_elem(&rhmap, &key);
+		if (e)
+			return 4;
+	}
+
+	err = 0;
+	return 0;
+}
+
+SEC("syscall")
+int test_rhash_update_exist(void *ctx)
+{
+	int key = 10;
+	struct elem val1 = {.val = 100, .arr = {0}};
+	struct elem val2 = {.val = 200, .arr = {0}};
+	struct elem *e;
+	int ret;
+
+	err = 1;
+
+	/* BPF_EXIST on non-existent key should fail with -ENOENT */
+	ret = bpf_map_update_elem(&rhmap, &key, &val1, BPF_EXIST);
+	if (ret != -ENOENT)
+		return 1;
+
+	/* Insert element first */
+	ret = bpf_map_update_elem(&rhmap, &key, &val1, BPF_NOEXIST);
+	if (ret)
+		return 2;
+
+	/* Verify initial value */
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (!e || e->val != 100)
+		return 3;
+
+	/* BPF_EXIST on existing key should succeed and update value */
+	ret = bpf_map_update_elem(&rhmap, &key, &val2, BPF_EXIST);
+	if (ret)
+		return 4;
+
+	/* Verify value was updated */
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (!e || e->val != 200)
+		return 5;
+
+	/* Cleanup */
+	bpf_map_delete_elem(&rhmap, &key);
+	err = 0;
+	return 0;
+}
+
+SEC("syscall")
+int test_rhash_update_any(void *ctx)
+{
+	int key = 11;
+	struct elem val1 = {.val = 111, .arr = {0}};
+	struct elem val2 = {.val = 222, .arr = {0}};
+	struct elem *e;
+	int ret;
+
+	err = 1;
+
+	/* BPF_ANY on non-existent key should insert */
+	ret = bpf_map_update_elem(&rhmap, &key, &val1, BPF_ANY);
+	if (ret)
+		return 1;
+
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (!e || e->val != 111)
+		return 2;
+
+	/* BPF_ANY on existing key should update */
+	ret = bpf_map_update_elem(&rhmap, &key, &val2, BPF_ANY);
+	if (ret)
+		return 3;
+
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (!e || e->val != 222)
+		return 4;
+
+	/* Cleanup */
+	bpf_map_delete_elem(&rhmap, &key);
+	err = 0;
+	return 0;
+}
+
+SEC("syscall")
+int test_rhash_noexist_duplicate(void *ctx)
+{
+	int key = 12;
+	struct elem val = {.val = 600, .arr = {0}};
+	int ret;
+
+	err = 1;
+
+	/* Insert element */
+	ret = bpf_map_update_elem(&rhmap, &key, &val, BPF_NOEXIST);
+	if (ret)
+		return 1;
+
+	/* Try to insert again with BPF_NOEXIST - should fail with -EEXIST */
+	ret = bpf_map_update_elem(&rhmap, &key, &val, BPF_NOEXIST);
+	if (ret != -EEXIST)
+		return 2;
+
+	/* Cleanup */
+	bpf_map_delete_elem(&rhmap, &key);
+	err = 0;
+	return 0;
+}
+
+SEC("syscall")
+int test_rhash_delete_nonexistent(void *ctx)
+{
+	int key = 99999;
+	int ret;
+
+	err = 1;
+
+	/* Delete non-existent key should return -ENOENT */
+	ret = bpf_map_delete_elem(&rhmap, &key);
+	if (ret != -ENOENT)
+		return 1;
+
+	err = 0;
+	return 0;
+}
+

-- 
2.53.0

