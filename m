Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00118386443
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433181; cv=none; b=RUwo/pam5/12gNWrt3aC6wyNC8uqJq8b20LlbMBk1uh7yOc9Qq+OqysrcF9NrzuG6ebBSw0CewqGcoFd/ODwhsXe3HssZHliBva5x/A8NtJjNVHQ1NxRw4nwBsQ2Rdx0ZrjnhRy+rkzJSfWJBalsan2lm/UY9bcV22TYGIs5iys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433181; c=relaxed/simple;
	bh=qhh+njwWnEu/sCLW7EOMvq6pdGV91QlOJN+mf98JXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1YsmykBzXZ3VMnZkHfMm1EPtPQMMuMKK1PwUXS6UcByAYum4p559/73Ti6T6BoiFsOhgyUUhmeo88DpnC7BotwCorIE3/Mg3lG/W0kZgexrhJcHNItVUbT4oiey/I9ut1dbBbQ9hMCLs9zpBvxAkrocBpw/2bVFrGERuWfgez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIsekhdA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIsekhdA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so90136425e9.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433178; x=1781037978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=RIsekhdABv7/j9/jvyp1BRTmOry0W6Oo88fefMGxJnUYpqFKhCH/7hzeRbLtEGKEit
         xQJ46a0wIsyAT3wpdSZ5xWarOsx2crugxYap8FrtToq+2nzfXqASrqE2C4OEFMOCQmUg
         aAUPbziaz0O62LAG1M8BpMJUeuaTzgUZ26502kCxuCciyt6AuHFRuG/wbX+115u1FK3v
         yprGsfsK8buv1zX14Dy913Bbje7LGRVto0NykxW96xl8FuxqpexnBzX089I2TnUqCbeC
         sUG8g8Ei50GI9RiwEbCWNrm533JJrFYNVkhA2zolvw4OGBHUe0YRMjkrrY6Dj2qOWJ/6
         hrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433178; x=1781037978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=qKnaLed6sV6tMiD1lbRm+2wbawV7897qbBSjv1U1v10gvB3kCffFHO23McTIpUoY3p
         nKKHS3bRzHMV4qQbox2Nu0nYI0xmVCuUHYuT9DeXZREqPsODEAoSgGpJJ9mrOINpqh9x
         KozDu07rAtrk+4n6NgpI9BYohXz2podipmdWqAehP8Sr5CKYO3Z2fO71v8AgWBF6H43G
         5fME8d/7my78fD2OoDs17LC3NmJUdpi3w8wdcju6/0xZ833IeHE7y69gUlSi4uTGTSBn
         k5onr+LSJIs9tNJdXdyw2Bgzu0U1ACTm5Wz6rHReu9Ihl5tzl6/n8Ezc3KIe+AMYW+Z0
         VU5g==
X-Gm-Message-State: AOJu0Yw25IUurtpNJSQM1EO5H0vVzgHCMlbjhpP+lbacYUbRoRB3ByR2
	uJvx2bHpfzAvU1WoNlDRGJnOSFGd/ubCal4zGGqVaB3BfflAwJ7sLZIL
X-Gm-Gg: Acq92OFOtxZ/Q/MBOnzl3Gvr5iJI/9JgNBI0Fr5yuhOhxdjHMhbKXXdNugiBoej7gmn
	7VSnJ1IRoW5WFTAIoGmHbIiEXDbGniIz9UE/NN7kTm1VRRJYpGVltegeRLTyF3xFmWKSJcoLyW8
	1H/zsUUnUWwBAwNcckUiwph3ay7raunH1mQPPIwC7laMghLHZ+eEsjvOJEDGgoQ4jEQzIbvzOLq
	x1uJz+DMgdZdY4+YCoXcew4rk9ZQypkkS7bRihhtX8sJA5vEqIbpPJhB3yag7hsUrrLJ/Vvr9bA
	OSIPT8U/YG4kXyTFg3OBX3CYocySO3Ra8l6a8ee0kq/XFMO73xVUUeBt+jIYIi1MP3IEuXBo6KK
	eyLSZB4HyC/BXM2kJWanyZV9qDVqtvkC9Z6vuOiqw7k8iKEpfD6WupH0UCmkDAHMRkdcUOkuNUf
	w3yAh2OwZ9CfT3ESwJO/NvX30aJ+F1LZlOxXw=
X-Received: by 2002:a05:600c:3596:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-490b5edd71amr6425065e9.24.1780433178372;
        Tue, 02 Jun 2026 13:46:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm2155285f8f.1.2026.06.02.13.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:46:18 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 02 Jun 2026 13:45:38 -0700
Subject: [PATCH bpf-next v6 09/11] selftests/bpf: Add BPF iterator tests
 for resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-rhash-v6-9-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
In-Reply-To: <20260602-rhash-v6-0-1bfd35a4184f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780433165; l=3793;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=WW2MVEXp29YEvzgCgsQ+UGSLkNX57jGpDeBQdSI34ME=;
 b=KZNBgQoVNiGd2avyIe/etkJuPmFUquiZ1aUhRxzt8PePaWEo2/GFIWsKh73iNLXsHbeIqKxDJ
 HZxHsGjLfp3DXtGhnQiQmlkYFDnCbQo+kNChYsd/dplo5wLrfqoGKAK
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

