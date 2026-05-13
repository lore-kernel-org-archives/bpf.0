Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C72BFC60
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711836; cv=none; b=YxOcsdZhtUK22Yor/9Qf27yWSQ7ooedDC8wES793nM4ODbSP6wie4PV/fnf3m0nYySsXx8A1AqHqjWVB320K/AQkKhXjgsAc5NPgUEfYpqr96pVZl49esYbQY8U+6LzO6REIrIjr5grgejH2zszhMBgJ3odIT0tGVvDePurlr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711836; c=relaxed/simple;
	bh=qhh+njwWnEu/sCLW7EOMvq6pdGV91QlOJN+mf98JXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOq+/nhNUWo2bCAauYrIzOP382OYWEbcJ2B7LbTwC7/ykCxR5mNFjkMszbv8Am7QaPw6yMYlVZVCbQ+4UqwpRvmjiT1FZMsIB52dppPQD2+ahAED6LAVtwk9PJ7GTaRACQJ6iI2MD0JX8qlW9pLVZV65tyFICqAd9qM98QTlavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX3xHdQK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX3xHdQK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso46060765e9.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711833; x=1779316633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=ZX3xHdQKtz5RJUAVwbwNuR9/SkbOK1swqZ7TFKZGHtted9LKFv3HITsN6rR165XNWY
         vNovudX4AufJHLNHtpIskhTn0mDOFXE8s/GxzSBPjxLEYcEm9uJ726UmEkH47CjmevNL
         fClsRUnfhCx+K6WxIfUGAs8qaO9fL3R5eITqvu1VmoxxzVQ88WkIfTi/0DRzYvX4HSFR
         0qmV9U3vMVKB9t1jEapn3EEf+LWnK/GF4mPqvLFglmKJAPMoUd7fFWYOA4zjW+X2HPwX
         +CVkmybKZOLjaK6JF0/OhGCe14mABV0BPA47OhVL8peos/umGzr88D7aQOnPxah0t7fT
         RfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711833; x=1779316633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=YzkRLc1DdqMyWaWUEU5gbE0NYQxna06CYE3V6YfjSOrZzwztugfJurm0IqwrHkSNi7
         kXG6MA1D1mb6G9NBA59TIaTbcRRx1ML0qQTerM12SyEw0guiXrdIO3p4DOtveGxtz1Te
         LvIqiGdeUd73yBMlgDyrcJTmA489k2s+r3cbVsXa3ico560Sm2yOEcR2TvhwBMCIMwMI
         qX7GO3sF8RQjuBBA45b21zktyxWLDpLJQYoh6e8qimYGYBQh/el/lb2+JxpHt/STceNW
         yjMAEdfTJr2djGTdwWm6Sprlwxsdd3ot5CbgWuWMNuYU6muHV8FptkABb/XqfguYKnX5
         7VoQ==
X-Gm-Message-State: AOJu0Yxd1S05jq9p0Ciaq+O3+2rWIDSC2iCMnuAAVXF+01+jGjqutATz
	mo4AFclH+yc9oYKjQWFHXBfSzXEh5Cfv9jLh3KAD/ZmtVQDEWSrLW92va7rLVkuo
X-Gm-Gg: Acq92OF5CYPkvr+nFf4MxZ7Q+UatkC0B6iZiC8eA89OWbAmqy/hf20a2Plu2kBmYmOm
	KM18lRUe+rvrKCPQc5PLJgANCfmaACKpyakq9ddn3N0EEnSiUp5vYeQAnmqIjjiPA8nAEFaylss
	jd4aA2cayB0166ZTlW3Kqq0DbTDHkmA8wBlTYOHc06DnAcDhr+0FwAxusK7fTGCZM+6ljuhOW+q
	hb5sQZsaZUdBN88ldNe12XXQbZ95l89SuvIARUUVDoYdTtQSm7a9tV7rzLKh0bE0RQtBBScC50d
	sJKFJCYZWNnlYN6l8iHUvuaPIfe17ipl52ToxIPu5Iy/Hjria8GHiaUK693+7MxjnFAZK4Q/KGc
	AnC7ajZzVNi+qoKHVn6ox/qpbUQI25oPEFEmYQIYd7+e4JM/yBZG1vwcu8kVoEchuUpL2UNXXn0
	g3hydft/bU0I/Tev2e4wozJMFr
X-Received: by 2002:a05:600c:811b:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48fc9a30a5cmr63478005e9.15.1778711833478;
        Wed, 13 May 2026 15:37:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62756e8sm9934045e9.0.2026.05.13.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:12 -0700
Subject: [PATCH bpf-next v4 09/11] selftests/bpf: Add BPF iterator tests
 for resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-9-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=3793;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=WW2MVEXp29YEvzgCgsQ+UGSLkNX57jGpDeBQdSI34ME=;
 b=Y4nPjOr2R268voqb+63S3rcIEqXO/9+ukZWoTBD+H8UEITfuZr0lu+Tqot8HfInigNugTo6ge
 rEsmqgxvZN+Cs2BdQTAAamkVzhI2d4EAF10uZfdKsUrgqGvQu6gz2jN
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

