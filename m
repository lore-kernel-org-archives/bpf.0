Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D9481FBC
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549428; cv=none; b=JNiBQ8d/63znkxINZHHjC5pt12jeWAz2GIGizTiVGCGJPqhPMZ+sNfytlGyXzdGbR47tLagZrN06F93yYKSHsxnWM+48VcOAtDyNS0e4NKfD/j8D3V3O8H3Xdf4h+y7tqeW0wF+hWbmd0N8ipgeNUSy07/wotiMsBXXKMidDmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549428; c=relaxed/simple;
	bh=/1hRk1SHJ9bnOpJQiMwghltTnPfWErph9tS6P4+D/d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/NpwoSSRvIQ7m2y08LzaJWxPN37oYOcynvourmoe6DV3EDhz3CuhtoVDo38QSmOPMdGbTipCBs5UccPsHq6G4pBlXDOngIsBx74k+5TuhwLs4S1l2f4GSnoyJ3dxBxMzT65vO/DQCpQ5KJoBNKIq1ZG2DKUlJG3fEZ7vEvC5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq6t2aef; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq6t2aef"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso162105e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549425; x=1787154225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNDg/QiIFoN0GUxh1R/xojN+bAzAUI8KO6xiFja3BKM=;
        b=jq6t2aefEI7+to5e5cvWovtvmZAcC9vGe10dRr369W6gQW/OB6+9D4hqgZBZ90p3fN
         WfjPV8w4lUTcTUHt/P6vy1shwbnrC3Zg8XBfscLlJoVmEBT4blwGLpx0pP36RtpUtM2m
         1sFOv1a6GlNPcRfJ0XsRAphfBV4CETegdoW5ZIzg5ycQzBa0Eak4GNUsCLktXjg/AeNL
         XwkTbYJj/Qw1xTf8lP2GCHsa3+25zibU4MZbTdrarsgPJFInkup6LzCuzQQ7CNYn2SE8
         i7bm7MJMV5LSU0/YeQneOURW8K2nlx756h0nEGlcEZlnnEPdTKqEBVITkJVsSfqrR2U1
         ltww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549425; x=1787154225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNDg/QiIFoN0GUxh1R/xojN+bAzAUI8KO6xiFja3BKM=;
        b=pRmeJRLuWCFyfbkbDrlP4nYwEc7u336M7UEQEJQWS3Ao61awIRoJ0J0ebwjjSS6E9/
         k6+jl34HrZcxKMf8rCwjrW0dOow/GybGbroMh7CVEeIeTwFBzppIm+AJ2neSOIJSRrhA
         3fs1auNbHAumTFXZi2ySIZC0aE/aItwzJ9WWhL7S+viuHPZbmxC3BoSo77NjKzuIOr+g
         G56sfHXFqrrazc4vPizJB6YeNlxIt8AmKGeuf5mj/8drx15JXK+gz2wKZLbrG5OjYvma
         p7EiyZ8R02u4uAz8i9p74dervfdiwavchb9KQC8hMVmC0XMBt7At9q5EKVO5GLI+QTH1
         eGbQ==
X-Gm-Message-State: AOJu0YzUoDdwBNrs2YTZlq1dRoVHKxLYs6EOBA/5WqdkvJNCfArWwePb
	vDKHTWoyJajh+ihBrfZ8U5GUPVTr8HSsqv0ffAUgm0eHv0OsJAwHqLaL+DzgDK/4P9WOcg==
X-Gm-Gg: AR+sD13/xsc+FGMLMk++wvyV1yal9PEUwr9wBpBBgFaj3O1hFC3m9UioSRONX9aK1nw
	75DwuMJc2JsoAStFZgvbImZHS1Xjug5Qt/M+5g6n3n3FC+PLoQoV9SlSkqJ36mLZsKT2/jayWsd
	x38CW7N7jyLUyuXxpnf23y+jCkFeoz3WZlYTqy0zTS8gcyT8aQyey9YN5w3wW0wRjAxh1Xs7Et7
	DypJe9V44144Q4aPFsWA0AiVSxjxv7HvpmuoKj+Icykf/hu4Gyn5anguZTBFXOsZd9OuiH4BDe+
	enhCvsgNrBqnfV88iBWkUInmoAOCd/sXaNiDLVSSUfxeT9hBDCYlPSq/o88Tdsd289/cq3vXMar
	u2COXECqSaY+FohCqSURpqOzwicsKxBaYu1sjJTgpJIp9xTRlttPfO37aZGKPhTdN2wHfUIzxWe
	tDe0chNNSTbHSvy1CiWcnvkzBwyXdZ7WoXz9UjXM25nEvQt3aNo3qXuERZEi38DbgOe3/dB4Fzk
	TbsAF85nqjTN1qQF+OUmQtvegmPgjd3tQ==
X-Received: by 2002:a05:600c:8a1:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-49981a0aac8mr755085e9.8.1786549424755;
        Wed, 12 Aug 2026 08:43:44 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997c939574sm51584985e9.1.2026.08.12.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:43:44 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Wed, 12 Aug 2026 15:43:28 +0000
Message-Id: <20260812154328.72834-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154328.72834-1-mahe.tardy@gmail.com>
References: <20260812154328.72834-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the kfuncs are going through LSM hooks, allowing their use via
workqueue callbacks would expose the wrong credentials. This test
ensures the kfunc are preventing any use from these contexts.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_wq.c       | 34 ++++++++++
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 62 +++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
new file mode 100644
index 000000000000..5b9c6cc30392
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <unistd.h>
+
+#include "test_progs.h"
+#include "ksock_wq.skel.h"
+
+void test_ksock_wq(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_wq *skel;
+	int err;
+
+	skel = ksock_wq__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
+		return;
+
+	err = bpf_prog_test_run_opts(
+		bpf_program__fd(skel->progs.ksock_wq_start), &opts);
+	if (!ASSERT_OK(err, "run ksock_wq_start"))
+		goto out;
+	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
+		goto out;
+
+	while (!__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
+		usleep(1000);
+
+	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
+		  "workqueue create rejected");
+
+out:
+	ksock_wq__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
new file mode 100644
index 000000000000..16a1873d132e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_tracing_net.h"
+#include "errno.h"
+#include "ksock_common.h"
+
+struct ksock_wq_value {
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct ksock_wq_value);
+} work_map SEC(".maps");
+
+int create_err;
+u32 callback_done;
+
+static int ksock_wq_callback(void *map, int *key, void *value)
+{
+	struct bpf_ksock_create_opts opts = {
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
+	if (ks)
+		bpf_ksock_release(ks);
+	create_err = err;
+	__sync_fetch_and_add(&callback_done, 1);
+	return 0;
+}
+
+SEC("syscall")
+int ksock_wq_start(void *ctx)
+{
+	struct ksock_wq_value *value;
+	u32 key = 0;
+	int err;
+
+	value = bpf_map_lookup_elem(&work_map, &key);
+	if (!value)
+		return -ENOENT;
+	err = bpf_wq_init(&value->work, &work_map, 0);
+	if (err)
+		return err;
+	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
+	if (err)
+		return err;
+	return bpf_wq_start(&value->work, 0);
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

