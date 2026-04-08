Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660213D565E
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661057; cv=none; b=rbFVNPYA6n9TFRrglVedbcUBQhWAwQobIuMkS86OhxPUVGMB0Kole3bATtKCu5t2QyZTsrw1Ad1VCP7sDofmgDzmIQxolfVpJUufC4eZU1PDUGJLc/D/qEHSPr6aUfzaH6huBTegsR/WASfrxx2AYdAy7bubbu7FTtfKhxtdb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661057; c=relaxed/simple;
	bh=Kluu8tI+6zVWKBRO95bkthCKfpUSSegxG5NnUulbN1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvozyvSkvTvMp39RfzHTYTGxd/tlbajvTbo6KtUWjG+l0UCIYlz7dvMFZ3pbHTfH3w5JjBlZmCbJmJv5QrOUz5qw+rH2H8cEwPHWUj6v+8czDlWFzhvYGzCTl7XqD3R9Gfoou6RUR2PtNqakitGY4zkiXgBEKUhW8oOkd3XumNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iohpnM1w; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iohpnM1w"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso5460812f8f.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661054; x=1776265854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fjU6v+xZdIiDqk/kGWJEfJXp0VIJBDSVh5MCjKY7D4=;
        b=iohpnM1wSe54HTe0ys0+QzaL9O4rNok9jBCdcqEt3WjejYdkv27WDtbYiVwvlww1zj
         Ivr1tjxWgC1DxfXklSwQ/1EZ8rY4GtCRbA0VuTSVh3W9iblLWap4fYo+AIvwMLYt/EQf
         b64blm/p410dV+NqdTE0l5LM4v/2soAAe9IHTzXzz05KXwyn6oS3dooU5xwkIe95+t7y
         FGJ7HLL+zlCHUGforWdF+XVFd1eBwkBLN366rexCTU50c8KtPxbvVl010duvDqGV8Geq
         WPLEkzdUJH/+ThjxgcGjfj9TouPMUYlwk/eMtZ0FhiqMhjQOIkWMkbK6NVT6+FBEGiKB
         a4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661054; x=1776265854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9fjU6v+xZdIiDqk/kGWJEfJXp0VIJBDSVh5MCjKY7D4=;
        b=WI1d+wUxsefg0u/CloinQbI85oQUPzPs+CNUv5DJb8sSEXfmGstfBjj4wgCPhIqSIv
         fpWRjfQA7RXzuYytzMIFGXARup5M6vYpLyJxqHkQASJosmYGzQCJsRnidthqxgp8Z/zh
         z45XyIHxR8AzKqPEx1YY4hwahkYGOGt8Jw7XzXTyg/0WowUG6Ygojna4d53dqpAtgqS0
         7EBWWwbxete7M093Esh/pvgUf2vUm86eRkkwbUIWVSxsffAYD3Ri8e1FKvCpVDc1PKwL
         QvUb+/l1XI/Y0n4ZFpK26Vl2GB4K+uFsnXGqHTK5waf0Oyh8JG4Adq7FsMldfBNTSJyP
         W63w==
X-Gm-Message-State: AOJu0YwzX3FWfKYgfNNkRO/3aLrNVJeSaNreSOxpt7747+DiNsse9ZDR
	84kZo3BRIf5PqsfUGEk7YOs2wVR7Zu4GcgO65nfLpCJcMBwE+SRbwdEb
X-Gm-Gg: AeBDieuqbQaPUI1OltROBfKmUIr/Iiu1Tce6+lWlFBY1yKOWjNdPvtiXAT/j59F/WWY
	Ypam5kiK2XMRLB4LOkpCMg4WFlJsuqp6KQLbl0nAUgl2p/LGty5Gi66Vp6jePawoA2JleUomzN6
	TlVPH3n4cm2iCqbw9xc+4IpNWqZmGoIFqUDXefnwPVNgEJmC0FjlT2ziYs0QgYtbL4asv1KYEQz
	BTFX4Pnx3QQB5mq4rUucQMpS0K41DZ0PTMIpTQ1AWz+3sB5uRO94N3sYovype6tBgxzu6cQZ/Lj
	LB9UFars+CdyTt/++uStLT2ViCVj4YTCsk6qA58ykE+K+2QKgdXANVzfPGLeCdwuRDiA1QHUsvF
	9gI3Bkl0BXjNY++fUbtC2puKsa4CdU1+xOLdwZkn1CIUxPhlKH8ca4WIPYnfZEq6Chi7KUwWGdu
	w+OdX/IsyzYLK2Qg==
X-Received: by 2002:a05:6000:22c7:b0:43b:9cff:e32c with SMTP id ffacd0b85a97d-43d2929a11amr33022065f8f.18.1775661053594;
        Wed, 08 Apr 2026 08:10:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:49::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c637asm56483811f8f.14.2026.04.08.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:17 -0700
Subject: [PATCH RFC bpf-next v2 12/18] selftests/bpf: Add basic tests for
 resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-12-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=7617;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=G+KR/DauFYkpDAznENFVf/89L2XfHkGLhxDOhsfi3RQ=;
 b=f7pNHtdhxpI///sIFKgGoEEtXCXc2ztFH8yVlz35/Ej++4og1SftV4CbTZhm3CT0cUwPB/7lD
 HZHczuA+sbCCjqOkPh7dFQ9V3uSeJ5t0FIvZJAM1h1QI4+4yWoDNv53
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test basic map operations (lookup, update, delete) for
BPF_MAP_TYPE_RHASH including boundary conditions like duplicate
key insertion and deletion of nonexistent keys.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c |  64 +++++++
 tools/testing/selftests/bpf/progs/rhash.c      | 242 +++++++++++++++++++++++++
 2 files changed, 306 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
new file mode 100644
index 000000000000..40f30ce69190
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -0,0 +1,64 @@
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
index 000000000000..2cd41324bcb9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -0,0 +1,242 @@
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
+	if (err)
+		return 2;
+
+	err = bpf_map_delete_elem(&rhmap, &key);
+	if (err)
+		return 3;
+
+	e = bpf_map_lookup_elem(&rhmap, &key);
+	if (e)
+		return 4;
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

-- 
2.52.0

