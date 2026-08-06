Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2048C8AE
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040571; cv=none; b=N4IBm3GX4or0+bkn5ywhjLkha4lzbQtJWrRrL/ZX4PGNMPe2PZrX2h97YA/bbQiCvf2gD5wlvbmvwRvahcsqkw9W+sRgeufGvj1nlniem4Axo2ctopHNYd1IsfNh/yUtBo/VljtUvuM3Ev0TZ90rma7LP5tFWOfMcIHVxKeSDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040571; c=relaxed/simple;
	bh=Tbb25sGeZrNe8qfMPaAkIA3bkftbTcqapPEA5L4Nj5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ohu9JbSv6GYAe1XnsdxaUGCJWnK7bcpAc+iplbkG4ThzSILE9GoW/7+q+VAePRGjUIgqUlK3Da3PBAwCMkuoIhWCnGtKgJ7l4x0YelfzqqJooPPi/xWwB+5nwcwUYh2G/mnNHJ2llxeX8wcSo3bbpcD1S5ToB+p1TNtNM28Y1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSDCYDiL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSDCYDiL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4957eefd361so18874205e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786040567; x=1786645367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=BSDCYDiLF8bgEmX8yBmLem71D4k4eJSjefO/H1wWsr9VzVvkCCN13mxCadrz7dm9rx
         FpvTQ4VMp7HVS6nCY2oEO7BXYkMV49o5t6pFF08b0tGcPYmq0Ke+QvECS50wuMeKQr4I
         DA+qTXCyR3Mthr8198e48novJr2QIGqCVj7hva/vvuq3jrtfbrC10NCOfnHBpEYTA41Y
         fEH+e7eEY/0/jC7Hao0d/9YjdQV+4rdfj7Jin4PSRCQARHJI+NI9bha7Zln4kE1+/5UL
         fSHrhLkENqGXWzprFhUOXTPxhYC3qWEIGtXPMFrNegWRGpCyoFb1xputjl64dYtzdZHr
         xaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040567; x=1786645367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=kXO98zCEIG/P+06ykQz8yIyGhuuCCZLjIgDLebh8AstlBEkkAOwjA3iHtYykwQDbVS
         mbhwbmNBKrx9nuIAabVx6fSrvqHElQTlfY8WbLzTFMxXmAnQWI+t3pIk6WYdhPQ4Sr1B
         5xbd7X67wmzUuSoN7wztmjPtULNoU5I4uaNRqpilfr7RL1Sk086gFPJoCpYO/Ft2Jb4C
         rlsTiEbqUw0roR2kAyOvkh6n+ieUOeo+rWHneg2YgrDXibL+x+ZXA8UcPrEzMlNrn2Td
         w1pBDaZNmsA44/y+Xyx0yIKhuqjxC5sq9LwsFVra8QGEFnvyGjxACOJX1lxxYOOQmokn
         LzKg==
X-Gm-Message-State: AOJu0YwfFCVKxyyAKSjO2tXyGdMPwpdsks8slcn6mGz0UvL/s0SRkEew
	QUSXKw4Pb0JTwEI6sXfV30KiNLq2+4ySjAGN/NymPgpTHVwnD1TTc1/SGt6t2EANxuqmBw==
X-Gm-Gg: AR+sD11d0uQw2SWEIBi1rJX0n79mHegZx0Ynu/XUxwcs/IrNzNaVF0gQbaoNFBm4D/Q
	yDVzEnS1fsh8IFXUgJMffi2L5ya0nG0NzUtriSN9EwNeoOlOUZg5v9xpYsC3eafhTLUnQf6kAVj
	9oQAmvj5Q1VetyEMDi9U6gVn0pH0SMNMNYcstYNJzXFus0MMzwjHMTvy1mkI1tDfhym45ZJhkyK
	ailCg331aEWqM5Nqli/Y3afS/6ehc/JfLW1+fKXd81hV6I5G3ohi2/TN0X8qX46wriGMCRJLdY/
	NZaPaxvd0tUYb36aXIeRe0wYVAOwqA/XWHzGOi/w0tpy8oxd501jT2EKibnZdpphtB+3iaHDcf5
	oMSHfOCvyeRB5GHoXMbyDoxAAdC/Ns5ob5/8L/2o2p+wuGA7kvHLip5As32EXv1+VToiDaTyVrR
	MOoqgYzweBaDaY91QOn7aJiyzWi8elLqE5KpwF3KDzLiVJN6NpNfQl6+UNrxVt8B56Za1V8q0Gl
	1Jq1Fk6O4WB8KHIk+2A+HdgApMGd9SfTQ==
X-Received: by 2002:a05:600c:354a:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4994e7b72dcmr230219655e9.9.1786040566829;
        Thu, 06 Aug 2026 11:22:46 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm82214425e9.3.2026.08.06.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:22:46 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Thu,  6 Aug 2026 18:22:34 +0000
Message-Id: <20260806182234.380833-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806182234.380833-1-mahe.tardy@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
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

