Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783773FFAD1
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990479; cv=none; b=asaTYMpX5D9sWDMt+YiVPs6iw3wXobb5WZVBB10RJS/jRTeQrF45csTtKbH/pxWwpcbi9pQsNcrHU0wwcCY4DqCjrCghmiIw6DoiVtzxGuYSf5h+OHqZ92fTsHZDHspyhKx/b0vSP5j7b2lEMWEHFGRZhZv124Wqds1kq52SxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990479; c=relaxed/simple;
	bh=qhh+njwWnEu/sCLW7EOMvq6pdGV91QlOJN+mf98JXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgIgXak3BnSXSDtiO+LeA7kjrR/gdAJluX3kvFJ3uOgSO1mt03MHNjNEMC+uv6Cyx1ukIeIwYjvmdd4erXqeoQnsYeonwZSXRa+4qU1UIjXnRbWsdYOxG+QZ53cqF60AkTdxO248myevHr5P+kl+s52hyBtiYL67zBcvNWUGMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRja9EHV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRja9EHV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso10288598f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990470; x=1780595270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=VRja9EHVfYEHTBmcNVFxA05bd28s7M1SBJJlKPiQ36SCtNVAzvZ/SBFH8m7cMqCKgH
         eAo1FqyOP2KoqvMX8DBkTHEh6RM80ImzHLqPz26E51l56A5dnyXFYG/dCvr23+9aXOwd
         i6RAyLqi0jKlcsC/kqUs3Ty1NdUTSr7xlubUnGF52Dw8ekHlgmyzca5CsuxxbewgUjMU
         Kd3VTGUOgj+TNhRhoWld/D3tnkjXTR7j8EQPSJVbIqnvz8gvfXW0BcN4POiSaKxpxe6N
         GmEzVqm9FiTjlOT3AqZ4Zxk2HSaiV7BjR5dKPbXOCZI5rnuEORH/ZNBfl3+6yiCquu6F
         U3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990470; x=1780595270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=Iaqv30mS9krHz2QseD4hWffp4W2EFrDCvkb9zAiC4PR192+aYTTBNImxfxS+qzUfZX
         PAGrjxic4Q8fUAm2hU5FkZipmDysgWJPZqI8cKEMsVo4MWiFrKp7j8ymA7caJA2w7YVe
         O/MarEBIIw0dnC5+em57bKtdtCH3bao2C5SG3Njca0p6DhhdAjc/UcjHl8yD0mv9szzd
         4acTN9+jermdcGpP5RWRXMgve+kSKqrzP6buJmzTXTruWy0f4bB20NgkPH3Wxc5UhuQn
         y6pJXLZL2sSZDHo/7gCPcPkrO+GdX2kNJ6klwd574REbPqFo9b29M7uDLxHWDAzO/Pma
         13Hw==
X-Gm-Message-State: AOJu0YzAWRgXQXTJXZQIU5WMuV/Ra4/apfeaPoZ0kFr9Gp3q7Y2KniqP
	VKwmgMaOR1Y6icKsv1zmY+zJNiZfGElqh9J3ejk8JRcZvSSw22BgRbIz
X-Gm-Gg: Acq92OFC7hpj2oX3iVMFWa8RIEwIfE819zoL/7CTuJ6zjKIVB8pu6oLD1QNOCQkStdm
	GWk6Puij3xkFIviuYGJHxN9T1/NFS7vPjdKoZq0SO9q/W+Oj06m7k11jCbrrQlaUhxEG/YLTMSR
	nv02i/LCTr/H/C1JgA5xYQAqtxifc/S7JyhePul0a8067s74Q7pL9o5K5qxc+KW4QmRP7W3Oyjc
	0DZ/MzRzdf5cYqVJ9QG9K++QtqDtxKz/K9e2PeSb/D6hpODoLs4z6njN4L3P37iV1rdIFIJqmMU
	tusBJ31bTM7clkYFfqM01Wog4HnQOS9z0nvGeBjzjkH8OYMSQRUfmuC0oSLN5QlWfFd4epqOLPR
	LHaW1ad6t8X3zS2XpxdwnusHkXjuNX/vxj2JplMkFzuGbe+y3X7kDdaeJNZcxubzAr1D1M9enPv
	FvWFCpVfSiSgTDpw1iIJ44K80=
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490426cd8c4mr490461925e9.20.1779990469640;
        Thu, 28 May 2026 10:47:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a82ea2sm94870915e9.9.2026.05.28.10.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:20 -0700
Subject: [PATCH bpf-next v5 09/11] selftests/bpf: Add BPF iterator tests
 for resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-9-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=3793;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=WW2MVEXp29YEvzgCgsQ+UGSLkNX57jGpDeBQdSI34ME=;
 b=unU9y80nopFzjpyGcs92Vo1zblOmb9LcbqJhaGrTbfGDfvuEd9fVElZOLGn0s4dUl8ctfbZ+E
 45p4aV1q2BVCo0YkWh7VtibZt7Fu+1gN4JXmeFyPmwmbsKDigi8UsIC
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
index 69686bf69ba5..98bb66907b7f 100644
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
@@ -89,6 +90,65 @@ static void rhash_map_extra_too_big(void)
 		close(fd);
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
@@ -117,4 +177,7 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_map_extra_too_big"))
 		rhash_map_extra_too_big();
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
2.53.0-Meta

