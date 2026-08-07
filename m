Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508133688A
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122957; cv=none; b=skhmHV37r7mOxUeMHD2Mx8A5spA8iPn60rPAfPSPIxMttJfCvCC7B3fOXI2uDqMd4ych/ZewV17ueko+vLUInH9bn/pC6zcjsEY4fzjtlE9LQ/61dGgSzYT6gED1U6Vz7smDxOuyttwH4A1JCVekj+wq+eFflKdlfM8mrlNLa30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122957; c=relaxed/simple;
	bh=Tbb25sGeZrNe8qfMPaAkIA3bkftbTcqapPEA5L4Nj5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnSolSk4bf9KaQ2JOYV5xx5EBZ0YMpv80JiGEMdNwcIOe3/JUwdAcN18Pz1dtbMUDNFAo9zYUsMoB3xNJIAkgtV7iLxeb52O6CPQ541ZxeLJ790azxmjFhk9tdvL37oneGeiOl5qxL/2JPJKxyf3ZCcYi7V8czIWpPVfXJFSUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YofaiE+j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YofaiE+j"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso23771485e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122954; x=1786727754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=YofaiE+j5vHnviJXoNx/VMAxHIfR7wjURLazqF6hM7sjgk0N5gap3HRM0Rqq3geJoz
         ng0fpgVDe6azDIV93cJmtXc8CET1y2jdlMeZVRKdJtimBnHdNfvUvsHVVzOtgkC1SiEO
         WLgHMNXuMq5e1639FeaNftQDje+qB4RUUC9S2wcDDISogWVhpyAVY3sUB26h+LHIZ1Aw
         3rjcoE/PA13+Ny24IdttUenThEx+0UgYsvVOSWMK2rFufQ0hwyHK9J14lVPxh8FBwV3W
         QXv2g2+CsXo8RkJ93IpcQsJ1mZzEojJ7vH0hYZflHmz7Bq7iau+eGu2a8rBdAZiGI+6h
         encg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122954; x=1786727754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=gx6lI2HZIC4X5Sm//vThjnATLcEOOw+PA/+3XoNEaLQNSffQJnKlcVYSf/co4EvpaG
         PfihLBJERg3OV1Q4/HZvaQnjELIs6MFgFEbi7/DG0KBheHXtTgHLQiqITQrLJuHNyDe2
         ruSYyKDyx0cyu/lrhoCQV+PTMhNMmVJVwTaDNFI3vvCJPA42qqonR5+rh3atwK5HiZL+
         3v/wHxyHxrpJIi+FPdcLIyeBWwL+W4CEukKf6+8J+c00xpcbs/pGZimDKETQnhB/N3LG
         9zhyhpWBcs7any4weaEixnFTimEetywKyFRgQgI5C37xL/BMUVU6IAMnaS1LjNmJioVP
         NMSg==
X-Gm-Message-State: AOJu0Ywkhqf/TWrENCNuUPYjPRM2lqlKnw+kjuDvedEGK7c/iHIggn2q
	532JW/HdVhjD4XePHUgIrRWukxsM+ImZdDxPY8bthN/a5ae2DeAvCvY5NsBziut6Hkd/sw==
X-Gm-Gg: AR+sD10hK4lUICuhquQiu2cn7laa8kV4HISmFJGa/JrLJj4IBgYLRRvE4Lq5227NTeh
	JsOWtLTFiS8nm+zHe4kj6dpWizCrWJ2DNAAhAFoIeEZxhdkXsuSl3BNs/7fUvu3Ztr1EQ8DeO7Q
	55I85i+ROBlH3FzF/9p+3wj8Ii7aAuib+KDsTKxttr7YtwTS2tYNnQf4y0fyvk6N+mgNa+b11nr
	gJ9p7F1ZIsXOwcGt49hSMMR0lSMUXD8+GvaxdOZ3VXt4MAFdnJIjIXI2r2FdDNKOg+uUmLuU5Hy
	IqbpArURaEPT6ylHHSb2/I9WitFULdtVqffjx9qoW3inaBrEMt982IA4QqaWz1q9zcXi8jF6vbn
	Uo2dxMc/ovqMVdLt31xN7omZDMjrrRMxTFsZqRuQgBctiksDZx6EIgvf5DT5tpAsZhw+7w/fMru
	daPYObiNf22K2mrCPRlVX0oPE3PfUKwfdMS2RBJGQZhxOa3FNwxEyTCai+DCjv6lFZQ9H9kPjXr
	8s9Y78OvcB1fpOTqxOIFRwzYAhJsdoeEA==
X-Received: by 2002:a05:600c:4f4d:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4994e7cb0e8mr322414875e9.14.1786122954140;
        Fri, 07 Aug 2026 10:15:54 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995d85b96csm27737425e9.2.2026.08.07.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:15:52 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Fri,  7 Aug 2026 17:15:32 +0000
Message-Id: <20260807171532.125149-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807171532.125149-1-mahe.tardy@gmail.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
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

