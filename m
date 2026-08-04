Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C63FC5B1
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862050; cv=none; b=mgpqjvb9invr+M7SQI7xVk3BgRmYru4yzoZlZA+sLQoeCA2Ann3iZ6mH+n/ENDu/Lg+tZopaZSVKtdcTkx++Lio5jJkBAzkq6Lz0V8ccj2VFjv9+wWqm9gXuP79Ro6ApQJSz3a2xRDF1sIc3SSs1Q8DDmV+8ja8ahJ4Ig5rvMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862050; c=relaxed/simple;
	bh=Tbb25sGeZrNe8qfMPaAkIA3bkftbTcqapPEA5L4Nj5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZiRpmfAFha3rgRPSAMNq6P4JbhwDgTQ6XMYFyUwoZs9hQeOyjBlYQTqo9PGEFp10Y6PNnq+tQfqGUBrShTG3JvmZOGkKXXEXNFGfimkxBhzbcz+HgBeP2ABBAJPobUwGRI4VLKJgpGBhr94JwhOrKH8zKsaWp/xYOxcXaCRBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9mjaudi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9mjaudi"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49553515a8bso345635e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862028; x=1786466828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=Z9mjaudilTRhoswaE+IateT5cMLZIgBxu91iFkfmDn1D398Qu7Yi8ISavFfHlNCMge
         3jWk6JUlXuUPIqOlijSAGWcokC3LRwY0siU5jRrUhO+a9T3Qgw3+4B9QGKsbUgMzXJvm
         7IOYGVyb7y0Be09eH87w6PhGlXk5ZNuIeNdH+9uttNM2540aiQ7OaKKHFWr6ASLwWX9f
         7Z/nWMwV7EoxumfXKrYaTORgNKfp0LE/24rE1iUMbN0PoRcTxPb0IGO+R+wDI0grX3lI
         En+9+BX8qhIiwnQqhvwnQH2kCM48Z6GWepv252Mzd8lJbF4IBdUf9m250wl491rLPRS5
         AuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862028; x=1786466828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=imR4MXSUqp5zeMvKZWlBWGrfh67I1WiIUCajE6Cnp4SwwxeRhqY60Czv+VImveQPd0
         7TJpa9+SEMV0Pvix9iZWJl2vi6XYgQ8sNge73PaPJtAJc8S1USEYJEg0vyGBLruruoM2
         lU3Yh5AblxmbihueMEeo8K0FdZNWWjNA6mY4hF8zqtHny1A3g/AjXqYASXbSR/flXJZz
         hVkZR5wQIR7qu+m8HhuVzCQ9XHDPeahb/XOaFjb/Km5+WuR3uA2tmLw5KbjOF2Flc9vX
         /7ojpbGeIoXDuEMP3kDl7/XevELlSjBTDaFG1ICILXiD1oxUGBzsI+c6HnRF7Ejhb4+H
         GrNw==
X-Gm-Message-State: AOJu0YyIyJGWZsLrMjUTaU+/PYmTroQVrKjNiqnruWHeSgiPssQw6WY2
	M7Uhw7RNTN72zvEa7OLx+cMe+tl7wWxE8Hy3gLRmtlehciZhQhGMH5U31Ass2fLS5ylK4g==
X-Gm-Gg: AR+sD12uN6VvuzNlZtPsZM1HdG/Kz3XH2Dpu/2v5hbLlg2yQYMV3jmkIIiEi8tLYuQ4
	J3xUYsikc5692qT8SmH2kZt6S0xoI/qYnuG4dYtsLdK/UJGNa0TC+UbcgVWhCIF7C9WHfwwv0Pf
	Zmd9f+rywSEd9jbxHQbEuIPVZb6IHMipf0al9LFEUauzuogBWQMsys6ix77l7nHCO05ZecJebu5
	Nd3tO2RsENhDUr7wMKQrgkNYQHwTQZKi/dwM+3nnc94f0By7fH+KHYqzMy4nSCmcNqfrOgmgmwG
	iR5A9+6nest2cmYDe9DWZSE6yL3Mg71Q7IKUyrbi45DJEhGwHgUYMA/AadMDsrYoMU+/g8P/dgU
	6jTHOf04qUsXWO5GCdesYQTV16hD43NARm3CjsEtmyFUaHWV+POKdjGSIplPD+5Oi12L8x5ntiw
	A6mvDVbL6TT0Oe3xinzdcO182Yu+IrmqW6O17r86B1LPSd+glfZLzifdHyTEEkQeMZueGpovDER
	anN29Aj8JeefayKIqeQk7owCzB+Jqv26Q==
X-Received: by 2002:a05:600c:4e8c:b0:492:3e69:a86f with SMTP id 5b1f17b1804b1-4980c66c82dmr298035625e9.1.1785862028307;
        Tue, 04 Aug 2026 09:47:08 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:07 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Tue,  4 Aug 2026 16:46:52 +0000
Message-Id: <20260804164652.296919-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804164652.296919-1-mahe.tardy@gmail.com>
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
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

