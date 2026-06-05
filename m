Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153254D98FA
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659709; cv=none; b=HoeX6zsJYNyjK64PyM/GF+w4FBN97pNlgP0UPKtAn7o4yF123O4aRalx7/MRPG4hQUcPi5G2BM2j5tECwXAFapx1VEqy2yb6Oh6coQBq/fereDF7t56BmY/s59pF17Ymepl+12NUnZI1Oh+AlRgMgcsGKS6YzoOYxk4Th25Z0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659709; c=relaxed/simple;
	bh=7juQfQfVjR9Y07yNtBIV2PKviwsbqCYjnXtLGRWmYVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkR/5khOJr4JI/GaQ6abjHo/6/KCLrk7anR+0iIphdbjfpEl9bcJivVCWQNPCtCquhZUqIlSEwYdckZ/Z1ql2NF87Vn9Y7mPg3zUMf4fm+CL4GEQgOlGnPJw2V72lcrJTjMbxF2yNPT6WrgnYgTZt+OctlxOssUFpftVUReBDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLqBOO4d; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLqBOO4d"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso15782715e9.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659705; x=1781264505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYYdaMTWWXEwVcTgFOUZZfop63pu+qT3MethQQOAlFg=;
        b=dLqBOO4d8aTO+N+hHdIxZHWbJSE5UL5jmoOukq9HmcRdFab5EDf7vamQMAFlR1EJn8
         6NM26nUkHsIfFoER9RvlgvXJCARRir9PCZx/RL/YyZNP5X7U6uS/p5g/QowIZyQj+zij
         SQt7c2F+jJl36iR3/JzjgC026LnrZGxcxR0GhYB4JgEpxnvJ3FzkQpwCS1JsXbNchi6M
         8+33XLQXBTMGwz2yI4dbUiKyU6fBl6IlfPbWqpIyOWGxI3y2wIS+ISv+Gu9OohB4GESI
         ff235EYBKMA8w3unr9hVfHw1vxRviMjSLM37vo6s59hHwrw8D3acWGPHX081XQQqPOS4
         rMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659705; x=1781264505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYYdaMTWWXEwVcTgFOUZZfop63pu+qT3MethQQOAlFg=;
        b=g8ZrT2xoBjKfjFzEbsn4suvjhQkAX2YUkdD5gumYDqAG3fxgBmj0IfJAid66IXftaj
         da8k9WLxvHRFQXBbSklQU1IoSxrZOQRtg6WLcyGEaf5za3gQw/x3kE4XiP+YVlK7xGw1
         9Cq2v4TIkJKUWGtzYbMkbLrs91TVIVb7a9jSynCQTn7Ma+pFy92KFV3YOshGJ4LrPvFK
         KGIsFC8nnGVpMbGb8u1RmmhQfDWVBvNhTNmOggG23VtbCiDSv36LftjpX1/3Xwh+4wQz
         mzG9KqgiMep+/9w8VKej3g1EbPYyrTO+VbCjJCciYD0rvpOrCYeytUFkxKZz5fTxcNiP
         Q14w==
X-Gm-Message-State: AOJu0YxJmibcSHtBaJ0PE/mFaM1fsFJGFi/jVX7pQrxhpiTuv2mLD5CO
	7KnDlJDq+usLKqneRc7hdaqu1KNPstM1/L351Wu3Oy27oQOb9Pe+iQZ1
X-Gm-Gg: Acq92OE42vdcLSs8e85J8I20N/sFSNsA84+0ssbiPM/2fobFwhLuhIKFJMlKYeQOu+v
	Y3RZabN8J2sUU0VxrDnu737/Myk8SCh+0uLptutyOdRv5fkhhr1lJ0Rv/m29YjFzTasovsPVFgj
	RhKvnI/U4QepBN107XE0dcMMzjO8uEPhhx3kfJ+K+sXDpSZFDeyXCvF8Q69TevBBiAatwmrrf7a
	jiq38NxN/ezdiEA3FGF+dpoe4J36FSMCckX9WwRDU5kHv/W+YqJAljNaVy2cnqnfSfp5cabHo59
	JmCqc5MX1ASd929OVhT3mNm/m86tBF1lUi+aV2lx4HXSIiJQBsqYb0ajGLip0l5+0rXaa9rquTK
	obqglvNintPOHo7qB00OdAPExCzcXyWgl8K6SV9CKdUHTocwC0trHEF5/hEAz0I8BlAxP6sl55P
	wRgiEXeUML+sF/jLNAastHmaOL
X-Received: by 2002:a05:600c:1d29:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-490c2597822mr51197105e9.5.1780659703440;
        Fri, 05 Jun 2026 04:41:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b82sm160307105e9.1.2026.06.05.04.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:26 -0700
Subject: [PATCH bpf-next v7 09/12] selftests/bpf: Add basic tests for
 resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-9-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659689; l=9128;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=dFzOBBxvWVN9XiN8zx8P4klFsM3fLUkiyGYSFR2OZe4=;
 b=MyyvwtDQr/eKM6kvq+oXqDGoVcvrYo+Th4CHkGCRf2uPg5+Vn2BP3F4to9eHNb1pmEBujLljb
 TdPkmIDeLbWD2POovsToXdRqYsCrzIqimajXRlTpAYZMV57+e54Y1wM
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test basic map operations (lookup, update, delete) for
BPF_MAP_TYPE_RHASH including boundary conditions like duplicate
key insertion and deletion of nonexistent keys.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c | 120 ++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c      | 248 +++++++++++++++++++++++++
 2 files changed, 368 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
new file mode 100644
index 000000000000..69686bf69ba5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
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
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
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
+	if (!ASSERT_OK(opts.retval, "prog retval"))
+		goto cleanup;
+
+	if (!ASSERT_OK(skel->bss->err, "bss->err"))
+		goto cleanup;
+
+cleanup:
+	rhash__destroy(skel);
+}
+
+static int rhash_map_create(__u32 max_entries, __u64 map_extra)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_NO_PREALLOC,
+		    .map_extra = map_extra);
+
+	return bpf_map_create(BPF_MAP_TYPE_RHASH, "rhash_extra",
+			      sizeof(__u32), sizeof(__u64), max_entries, &opts);
+}
+
+static void rhash_map_extra_presize(void)
+{
+	const __u32 max_entries = 1024;
+	const __u32 nelem_hint = 256;
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	__u64 val = 0;
+	__u32 key;
+	int fd, i;
+
+	fd = rhash_map_create(max_entries, nelem_hint);
+	if (!ASSERT_GE(fd, 0, "rhash_map_create presize"))
+		return;
+
+	if (!ASSERT_OK(bpf_map_get_info_by_fd(fd, &info, &info_len), "info"))
+		goto close;
+	ASSERT_EQ(info.map_extra, nelem_hint, "info.map_extra");
+
+	for (i = 0; i < (int)nelem_hint; i++) {
+		key = i;
+		if (!ASSERT_OK(bpf_map_update_elem(fd, &key, &val, BPF_NOEXIST),
+			       "update"))
+			goto close;
+	}
+close:
+	close(fd);
+}
+
+static void rhash_map_extra_too_big(void)
+{
+	int fd;
+
+	fd = rhash_map_create(1U << 20, 0x10000);
+	if (!ASSERT_LT(fd, 0, "rhash_map_create hint > U16_MAX"))
+		close(fd);
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
+
+	if (test__start_subtest("test_rhash_map_extra_presize"))
+		rhash_map_extra_presize();
+
+	if (test__start_subtest("test_rhash_map_extra_too_big"))
+		rhash_map_extra_too_big();
+}
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
new file mode 100644
index 000000000000..fc2dac3a719e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
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
+	if (!e || e->val != empty.val) {
+		err = 2;
+		return 2;
+	}
+
+	err = 0;
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
+	if (err)
+		return 2;
+
+	err = bpf_map_delete_elem(&rhmap, &key);
+	if (err)
+		return 3;
+
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (e) {
+		err = 4;
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
+		if (!e || e->val != key) {
+			err = 4;
+			return 4;
+		}
+	}
+
+	for (i = 0; i < 128; ++i) {
+		key = i;
+		err = bpf_map_delete_elem(&rhmap, &key);
+		if (err)
+			return 3;
+
+		e = bpf_map_lookup_elem(&rhmap, &key);
+		if (e) {
+			err = 5;
+			return 5;
+		}
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

-- 
2.53.0-Meta

