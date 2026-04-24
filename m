Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F53F9F27
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060286; cv=none; b=GurNBlpMxRMnisYIxCAjO1wezF2dBR2uas834iSr34vDz0Aea/W+yKGDQHpRpPWCltAoIhUY4OYi0tG8K24CyZUApzH+dlfx2dfikZbcZMcihBXKDv1ma5LSy9nFh36D6/HHKU49F1ZDn+aA5KP36NUWMR4Lgzzopzdm3M32hf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060286; c=relaxed/simple;
	bh=o6E2LrTNZwPGWJaHoxz7JfIY4W8qxLud6mBtJ09dIXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9EV623oSSjvaOcjdp997xVOQEz5I5NSZ0k4yuzW0nHHeeZtYb8IpJ0GUnEOpCkH58UEWToQxkcpjhwgSSWEjGe33b+JA97dX6UTOB7Un0j/fgehDVKBNICI6uKpzBBLos1ersKyWdKDwHMJEzDF5aNjBhCv2d1hLapmC2GJPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpE7b4kG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpE7b4kG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf7683a28so5574676f8f.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060277; x=1777665077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37XspHqex1g3vD+quLvytjU4xDrr5KuYmrcNp9ArTjU=;
        b=jpE7b4kGX67c+ouQYeoyEcniypBFnJDRD+GwisqCSf6z/nEcFDJN5S1IRWptGpqu4u
         /E2GO8KW5A+q0Fu3fwzWEbFdrK/GxKzcMTzCoQCUwAdgYZ7J4icfZrKb2lprJsX/QS5p
         cTFHwYlJBeT07rF7cV3BsM2X8D9A1HWcYtQDREvAMj70Cl9MfRaGM5B2xfUwCWp2VK/a
         pKoMTHjjfNnYYvqWG1BBozY8/uLtQW9qG9p0vhURL5vrEMCvwIo/Z5rhw9t7xyHFV/Bd
         nGgDoxcdj/eEsbcxU7wLt6JnlLTcIRKYhfR0w4G5Dd4WmjjTsSM7V8/LtKzrhTZaCinV
         JuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060277; x=1777665077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=37XspHqex1g3vD+quLvytjU4xDrr5KuYmrcNp9ArTjU=;
        b=JgO/UOu68VcJ8Q+oAJe/zNgewSbb1rbfBRBW2YYnu6SqcrrLfdqlbPRYqvuOdDyvpb
         EX5joQEh8WYoQuBGWguOqv+Z9Nq+qnEqEygW1jzw5pjxS28W2gPDKmHt10SUpbFzrwht
         lY5kCWG3IZHEbWxyHpSnzCcgaEGg28YrF/hIo6JkyjtfyX3QeDjseE1pRLDVeYME6pab
         6RU5dQtMvf5WLjiyKXHSxS0FZAk1LGetiXrE0/qv2ytx9CbKUX3dq4a/nKwqkb2hRXLL
         qpST3/pufYTIDIDMln3FhfIedZXGEi2mL07GRd/YijwZwIvc/aQCWd4AZQY4VVG0wpey
         Hwiw==
X-Gm-Message-State: AOJu0YzI4m0mb/xeab709nIlOvInLSx6i3Nr+h4s7iF0ile0djBg4spJ
	94zh32GDrgiKZ/xvUYZc2Mtl/5sRLLLb2ZsBpMyJ5xJf2ibhOv29pbNv
X-Gm-Gg: AeBDievcPxgVAhF0O92mEXkWvMmlUQ073DuXHz6dlxA++p9M6zrbDXx84Ov1Yl94qQL
	QwFuBWoATgeDs4HV4Ph5WAT0NIjChuHU+KQaC/svM3D4+ltJF5lTCYpzM+oitxPqPUB7hJBmBCv
	oEIaVoEHPv5sw3OE5bWRrdPJCjeT7CM6J/mnTuPn5R0VsSm2FZJPFOS5KmnmNFYn/BD/cyFVtBH
	FjoA3fhv6NIu0mmtSgnBa5SL+JNuIfq/mOW8hX0y/zwBpFu61QI4e8IaylYtRsklXMtCrXavEHT
	uRVO//0+kXXC7IcSh3xQujJb9jXQ/wDWRHfMCQApx0Q6nW5x8WqjLFP1y+qjVH2+irhhElpqBvi
	rIzoSLVIZkAqBgw75O5wigofgly2zm/J0tUOGvpzueCNKiC7A3UxYX7+5pgsw4N4yP+DM+Eo4gu
	v8z3CqKUmsfpWMhyJLySx2b+oeljz9eQbygsk=
X-Received: by 2002:a05:6000:18a6:b0:43b:445f:3177 with SMTP id ffacd0b85a97d-43fe3e0712emr51328446f8f.31.1777060276802;
        Fri, 24 Apr 2026 12:51:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm61823645f8f.12.2026.04.24.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:16 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:50 -0700
Subject: [PATCH bpf-next v3 08/10] selftests/bpf: Add BPF iterator tests
 for resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-8-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=3818;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=lsD9IJ+KDml1lAm2IOA7dvqbc3uB7MrwuXo+YO3LDV8=;
 b=3vig8aFl930ZZDsi/fLSfp/uSLbw9S/DdTWXg6RvPsjeQCAi85nanGHY1SKWxVrfE2gUznRKE
 p8djDQuqP77DU85sXDheo0r2S7nWDEtGvMZjzB6jGrS20YahmChvwt3
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test basic BPF iterator functionality for BPF_MAP_TYPE_RHASH,
verifying all elements are visited.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c     | 63 ++++++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   | 34 ++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 0f6eec4fe1fe..7e5a5fbd70c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <stdio.h>
 #include "rhash.skel.h"
+#include "bpf_iter_bpf_rhash_map.skel.h"
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
 #include <sys/syscall.h>
@@ -39,6 +40,65 @@ static void rhash_run(const char *prog_name)
 	rhash__destroy(skel);
 }
 
+static void rhash_iter_test(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct bpf_iter_bpf_rhash_map *skel;
+	int err, i, len, map_fd, iter_fd;
+	union bpf_iter_link_info linfo;
+	u32 expected_key_sum = 0, key;
+	struct bpf_link *link;
+	u64 val = 0;
+	char buf[64];
+
+	skel = bpf_iter_bpf_rhash_map__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_rhash_map__open"))
+		return;
+
+	err = bpf_iter_bpf_rhash_map__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_bpf_rhash_map__load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.rhashmap);
+
+	/* Populate map with test data */
+	for (i = 0; i < 64; i++) {
+		key = i + 1;
+		expected_key_sum += key;
+
+		err = bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "map_update"))
+			goto out;
+	}
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.map.map_fd = map_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.dump_bpf_rhash_map, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto out;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
+		goto free_link;
+
+	do {
+		len = read(iter_fd, buf, sizeof(buf));
+	} while (len > 0);
+
+	ASSERT_EQ(skel->bss->key_sum, expected_key_sum, "key_sum");
+	ASSERT_EQ(skel->bss->elem_count, 64, "elem_count");
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+out:
+	bpf_iter_bpf_rhash_map__destroy(skel);
+}
+
 void test_rhash(void)
 {
 	if (test__start_subtest("test_rhash_lookup_update"))
@@ -61,4 +121,7 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_delete_nonexistent"))
 		rhash_run("test_rhash_delete_nonexistent");
+
+	if (test__start_subtest("test_rhash_iter"))
+		rhash_iter_test();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c
new file mode 100644
index 000000000000..86f6c0d5eadb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 64);
+	__type(key, __u32);
+	__type(value, __u64);
+} rhashmap SEC(".maps");
+
+__u32 key_sum = 0;
+__u64 val_sum = 0;
+__u32 elem_count = 0;
+__u32 err = 0;
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_rhash_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	__u32 *key = ctx->key;
+	__u64 *val = ctx->value;
+
+	if (!key || !val)
+		return 0;
+
+	key_sum += *key;
+	val_sum += *val;
+	elem_count++;
+	return 0;
+}

-- 
2.52.0

