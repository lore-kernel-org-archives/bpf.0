Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F83C5526
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744702; cv=none; b=OKZ9YY76LRoxnlCEldgjep+4Tp6f2ZN/DWYxgkJjvfsD5o2DhsrhJgtop9icHLhfWYV8/HnzEYWJRpQTz+JGig7tDWbWmGkWEbc1frr0Ce7RIu9Tsi1Wp5dCZqNIMkq96ocTlPKb9e//rBprivXw/BlhKmavD7UbrMaLKdsKzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744702; c=relaxed/simple;
	bh=QS3Jv6MUzir8hTy8tPJNf/0zmVhxNF9Y0lDzB8ilc9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBx2djdcGYbaVWRRIu3Iktl0nsLnq+reNqQDMrspg0XkK803QrDd20KJser0MM7oBCaYR4dh/JjgEMQDtBpg9RoEgoSAMJBTEBTgGWgru51dOoIWj9sfUR01giCrWQ8F5DTyTRa50p0zsvmKLGjNCvO13cNXr7W7A7maH+iBOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbPT8jY4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbPT8jY4"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3664df32e91so6526206a91.3
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778744700; x=1779349500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUYx++8YBTX2DlfF04vUSCiM+tkndDmmadb9Al0o1Kw=;
        b=rbPT8jY4gFj2XWGiCOzPUs6gIFF2gH4tAYtiFj2vxJZEw+54ygqSbAHvl2XX5FtjPY
         LS5wdUNRH4IaizY92sfEFBMQkKTF2Fw6qUkF1egL9WSyXOGfJoxZ+TxnosnYRzNMcz3u
         l5QfAbks5UPOxiegFDzAY1IBXNfZ+nBM4ZZeQN/b30yks591skiwCUxlf7SBhmMNjlO9
         2k6yb0q5F+r5p7P24ataN2bwxANTi19eAME+rcV9hDiQNGWS6IbIqglKXhvKx0uJpoNv
         /vssPGWd9Uus8ltnLZDdlbFAXp7I4SlcWHKoKL2pfL/I5r4dgT+xB+fkWifm2Grl3SN1
         kfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778744700; x=1779349500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUYx++8YBTX2DlfF04vUSCiM+tkndDmmadb9Al0o1Kw=;
        b=QPMWqpYui1THx0mw/AOCo1I82UWf4Dj3y5qNOcDziWKGwdSZCbW+lM1WrDMwL8jMs/
         maD2joQ2PREY8qI8sGwKueMbvZ0sRpN9KIpqLtaXI5FTpqpkykPCUhbSo7DOhNNxCd+S
         bA7i1RYsh81P0/69GgZ/bd4mwqnN8ssH6C7xEXSLmz/rs+hEUOXfSPVA6QFh/vbMcU6c
         VPl8fBp3He1zyNv4klFXd0efVolELfgZU2JCgyvGIBRO0rgm6pNWgzT6rV/oTZXg0pNS
         vdDhFmDC1HxXeAM1fnImZLggf5iYYO5J7mZ0NqdJlU+GfhwZV+QSXxzo6sXCT2Lvj99u
         xYGw==
X-Gm-Message-State: AOJu0Yznk12MN3hGplrUW6ehpuOu4NyyYinVy9WlI4wQZHu9+uHHL0Qo
	jbo/tJG5diflfcSYz2+Is40LpVmSnVvg3EPxfye+4z1rLXYRuM2h8g7e6meaGaOpS0EIRg==
X-Gm-Gg: Acq92OHyBMy98gpEJhKMKSiWNm3vRyrFcM05NRhqdVszRildjztvPrqi5wayv7lWoBw
	kh75c2G+ytpSK2w18nPadULC+0tuRTAL3EoXklLjq572p/at0OmhDx39lA2nMpAqjl17NGzYpe0
	9ndfQWS0yJFbuUDZKu5Gfamy6/TyXGBd1w+ZupuDE8TdviIFYbIuFXI0ZEHbO7bT2JU4434xueq
	YPLACpb/1jAFjbQ7vikXMtOkX+V+YlPtgyvgtHgnUOnKljGK+IEmYJte3EC9QHy9a4R1L5/OiWx
	vYMqYx9CxGADj8z0dkbVNkHqOsmDNZCJmANxXrFBHuq7w+WQfYnkmre//HZD1HEf+TAyaMsOLQl
	fKb9Rfe9KHlJavwLr1zuI+Ztr4020tvpzHTiG/c2MRpeT55iKCe2HMmhLtQgaEgh5REj5DBc/V1
	LzBQemkA5LCw2YHwMQ/MRKQURwqTVwZ9a3fnN3kC9tcwg=
X-Received: by 2002:a17:90b:2f43:b0:366:479c:59e8 with SMTP id 98e67ed59e1d1-368f3abd2b6mr7095329a91.8.1778744699982;
        Thu, 14 May 2026 00:44:59 -0700 (PDT)
Received: from KEENANWANG-MC7 ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f287sm21257955ad.24.2026.05.14.00.44.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 May 2026 00:44:59 -0700 (PDT)
From: Guannan Wang <wgnbuaa@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	gregkh@linuxfoundation.org,
	ast@kernel.org,
	andrii@kernel.org,
	xlabai@tencent.com,
	Guannan Wang <wgnbuaa@gmail.com>
Subject: [PATCH bpf] bpf: Use array_map_meta_equal for percpu array inner map replacement
Date: Thu, 14 May 2026 15:44:54 +0800
Message-ID: <20260514074454.77491-1-wgnbuaa@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

percpu_array_map_ops.map_meta_equal points to the generic
bpf_map_meta_equal(), which does not compare max_entries.  When a
percpu array serves as an inner map, replacing it with one that has
fewer max_entries bypasses the check.  Since percpu_array_map_gen_lookup()
inlines the original template's index_mask as a JIT immediate, a lookup
on the replacement map can access pptrs[] out of bounds.

Point percpu_array_map_ops.map_meta_equal to array_map_meta_equal(),
which already enforces the max_entries equality check.

Add a selftest to verify that replacing a percpu array inner map with
a differently-sized one is rejected.

Fixes: db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps")
Signed-off-by: Guannan Wang <wgnbuaa@gmail.com>
---
 kernel/bpf/arraymap.c                         |  2 +-
 .../bpf/prog_tests/percpu_array_inner_map.c   | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 5e25e0353..dfb2110ab 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -827,7 +827,7 @@ const struct bpf_map_ops array_map_ops = {
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-	.map_meta_equal = bpf_map_meta_equal,
+	.map_meta_equal = array_map_meta_equal,
 	.map_alloc_check = array_map_alloc_check,
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c b/tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c
new file mode 100644
index 000000000..2a8b23813
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+/*
+ * Test that replacing an inner percpu array map with one that has different
+ * max_entries is rejected.  percpu_array_map_gen_lookup() inlines the
+ * template's index_mask, so allowing a smaller replacement would cause OOB.
+ */
+void test_percpu_array_inner_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int outer_fd, tmpl_fd, good_fd, bad_fd, err;
+	int zero = 0;
+
+	/* Create template: percpu array with 8 entries */
+	tmpl_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "tmpl",
+				 sizeof(int), sizeof(long), 8, NULL);
+	if (!ASSERT_OK_FD(tmpl_fd, "create_tmpl"))
+		return;
+
+	/* Create outer array-of-maps using template */
+	opts.inner_map_fd = tmpl_fd;
+	outer_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "outer",
+				  sizeof(int), sizeof(int), 1, &opts);
+	if (!ASSERT_OK_FD(outer_fd, "create_outer"))
+		goto close_tmpl;
+
+	/* Insert template as initial inner map */
+	err = bpf_map_update_elem(outer_fd, &zero, &tmpl_fd, 0);
+	if (!ASSERT_OK(err, "insert_tmpl"))
+		goto close_outer;
+
+	/* Replacement with same max_entries should succeed */
+	good_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "good",
+				 sizeof(int), sizeof(long), 8, NULL);
+	if (!ASSERT_OK_FD(good_fd, "create_good"))
+		goto close_outer;
+
+	err = bpf_map_update_elem(outer_fd, &zero, &good_fd, 0);
+	ASSERT_OK(err, "replace_same_max_entries");
+	close(good_fd);
+
+	/* Replacement with fewer max_entries must fail */
+	bad_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "bad",
+				sizeof(int), sizeof(long), 2, NULL);
+	if (!ASSERT_OK_FD(bad_fd, "create_bad"))
+		goto close_outer;
+
+	err = bpf_map_update_elem(outer_fd, &zero, &bad_fd, 0);
+	ASSERT_ERR(err, "replace_smaller_max_entries");
+	close(bad_fd);
+
+close_outer:
+	close(outer_fd);
+close_tmpl:
+	close(tmpl_fd);
+}
-- 
2.50.1 (Apple Git-155)

