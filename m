Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4344D90B2
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659708; cv=none; b=olj1AfPQAbkt5ZmA10kSV36YTnQghNNbHwksfxaMT/5sZ0nQjPwWnTmdHzM6EkYkWZoHWb5rcFuXKDxshcw9SvUupobzScYpwJoWpB3+wzkIg++YdhUrLUGaXWbm6v5zJk6s4ifgZ10w8LBUdYRQEcFz+r8FRCqQq9GUUU+yKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659708; c=relaxed/simple;
	bh=qhh+njwWnEu/sCLW7EOMvq6pdGV91QlOJN+mf98JXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVuoBsuh/hXCdS8z4qOwsilgoo3KDc7usnzdxq7qJLi3FW24HMlxvs7z3PQCSSom6m0248GGKwNwwm4UdSPDKsj2Hb42dktwTroQEkP+yV/2KwFez1zQAyubDdvb1Xm3g65qlhnF7RDrygXAeo9Csv5zBnf8LwUUhf+ufpwDCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBA/87rJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBA/87rJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a76757e5so12589785e9.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659705; x=1781264505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=aBA/87rJiHVZdK2Gi5YyL1SeU4gjDucbdluGKNP3aAu1rem+1TwMilVCcpaP1fksDS
         yFlVQ1MiMNuwVrj0haG+Ivst0d3JalxEv+ekVJqr2BSbAFQxks8OMpy+wEQ9izvzjo3a
         eV8g9CTPnzFbEE2HSNJ0ZGzY9X/0uCFu//SMV/Y8+we2QSdLUH2sgMaSyt4dqAIJXlht
         ui+F1kWj0L+SG11qOTIZCqLeUsCYSH4VLC1LwZXYLwqy6UMzVj6MQLvn5IElqGrSmJOE
         45kpwH8wbhzPrHw/ADVC31gFLG+S5AOlqC7Xl6YwiCufgfZWbcj+NfWzZBtY2u7Gp6XW
         Tncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659705; x=1781264505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cNXeyjOJXF5y1ldXXX9MmH3mijii0KjWT9V8IpAQgcI=;
        b=orGjB2RQ/oO0l/ofYE0wZsMwA4FEM+69Z7sggEqRuBk4+fBZqtOEVfcsnUPfa5iW4o
         0gFU5kHXu5vm9l6OUCoCAxpyof88PdiaU82cfo0SK0BpxcQY004uu4FN/GhYrrUFYcga
         6Tctk9nHIm+wSb8n9pOggkE9jfBvev+Divsv/rPVVjUGoc6JG8L8K73P57n3syye/co8
         la/b7oiSjcajy6qqp62OQVG/Yf1NMCIMEt48djBJDFJdN083IFVx5y3/ZkpXxKzHneiy
         vWy+RUU26fh2aIyjoWPK6VIcspoVGkjXioyX15eyCweeJL6aDLwuHlR2a33aRgztKU/R
         YFNw==
X-Gm-Message-State: AOJu0YzB+9eeZBurD7op20u+gSGA6kW7tTN8km3CnAzIA4GDv9dnLI9E
	wwAU6CpZMqBt2YOcMM9Af64XL3gEk3t/aGB1iDfAfjEs8V26GLr4MKbl
X-Gm-Gg: Acq92OFakZvTbTZeEF4CY+lLhW05sGTwL7Hy+xEwK51HrSuJrmJxQDzcuwartUaDte4
	eG3xpEih6GZ45fGsigv5abHGc4LJ3qbIdgCSeNn40jwFs0MyjVAB7PAayWwl/DLwsktzdL9ogcG
	DaiBMZK22q61/6QINnkUmBNI5fa/SOEovYaaYgf9iLi2d37sl8qMpAFKt7AJNCRyOSyQQHD+m0N
	4UzkAknfiwoDrLjU2FIIxZOYenmIcugYk1bzg+5PVdzm+i8ryxmAOVIPFcK4U3JeOZZGdqcw6Js
	QsBH37c9V4rMtdMl0/PzLM5NvkHA92DaVmzig2YLbgkASkmM8AtW5S/HtaTazld6cNRFPhW0lPa
	oJOM3DeJCh8ynd+dMhPxYu3SmiqUPubY4GR01L67pKnddivQlV+hHtG1qAf1mYYSMH5IfDdrK3D
	XaokOwtMLzTTEZiE4di8bNaqU3
X-Received: by 2002:a05:600c:5488:b0:490:9d1b:f07f with SMTP id 5b1f17b1804b1-490c25b1277mr57133795e9.12.1780659704752;
        Fri, 05 Jun 2026 04:41:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm24812539f8f.18.2026.06.05.04.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:27 -0700
Subject: [PATCH bpf-next v7 10/12] selftests/bpf: Add BPF iterator tests
 for resizable hash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-10-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659689; l=3793;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=WW2MVEXp29YEvzgCgsQ+UGSLkNX57jGpDeBQdSI34ME=;
 b=A2Nd2LbfDu//DDn4WevAoG2rT/wYNkrP/grHpwqvjgB+DmnyWA1Pup/F0Jf7w12+ijxMs5idn
 Xk55Mmaw6A1BJ237euHBnM0ez6WfCinBLKeAP+APgQtMwN1nQEV6Baa
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

