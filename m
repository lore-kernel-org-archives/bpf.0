Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A604963CA
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717108; cv=none; b=VuPrNVLB3qJMQuCLDTNAPwas56J1LeZpvYMvEDBFizZ6HyH8KzePu56WOaqgGaMI48OEXT8H7aM0ukbxd9GdKJhX82lZ2zuvrKKJrJ4cqqfN+EqOz1+OidOcjAkwiaqc6vV9gnGyNwe5OF4c0NYsc+eU/AUVmsEcc2KKs1WPGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717108; c=relaxed/simple;
	bh=fmndcjanViGcYEADoEdhV6jm9+Kn08sQMnFyvTnMC8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7Wi8MeWW9Fuz33P8EOB8SyFMNzNX3sktvmz/Tj0MPK0ecSWZ/8oeivoQ8cvhl5pzHj/thhg8VfkMevLtHEC1pC27jUZ69fqrXuGmvc00vAkAJbaXQn/SiRVkfjtIZSKtEkq6NWNi3Av+sEZ50d+cU6OCiHcqSMlPuJtlvIx1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff//GPZt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff//GPZt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955de8797cso19963985e9.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717105; x=1785321905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bXbm3wjsqVGwtNUtH3eqoaK9MP9AOKrO2JGwf5Teq3o=;
        b=Ff//GPZt5Gj6XaSXRxCsrwQS5miKytkRw7b9aDh3oNYKX0EnUE2GNUQfRoMSf5GhGm
         zGxa7y8IarI9NUQYfVbtC5yaihSVvsFl9czpdEJujoVDfl/jsZQDA6clg/3178S7Kk2z
         t5mHutB+FVacBLtqYEe+J0lXUC7D3+dzWsqHkJQxVBnRXmoostYSW+F5w8yPaofMfhYm
         LOjvsRwNwwdxljItpvJLeymbtLaX3GTArFKdHNUfKBLzWKd0vwwQbbZTcT2NdM8Xhc/l
         MAj4UQ9jDB1gM/lkbUBIKW7UbGe6GZ12JkkFmN1BmnTNwGYG80iQXciVDzfIw82Tpso1
         CKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717105; x=1785321905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bXbm3wjsqVGwtNUtH3eqoaK9MP9AOKrO2JGwf5Teq3o=;
        b=i/OplFQLu807XmzAcC2vWjhcxNgibcdaNgzvuAmbdxhuJCey/ooH7ZD3oiPfGIK+qx
         b6dTbVt0Smrqnu8d3M7TE9qXi90LdDNrDkq5/UkC1HPoOMAAZMD33cSg4Jc5KIQrjopu
         eU80p50moGHi9Lsalm/DSfnV/ufboE/342YpWkTZi/6nG4BRqtLi51Z1E5XECT8fgSXM
         DtejjIA/maqsnbKOBMKgVXqbfijz9H/XhhU965j/nWy3+/kMXFl5KN2Py+weyfArFDvg
         XkAgXiLmskgMP0yC/7yeGq5f5c9SNEPB9KjbaSo6ltBTo23xy+yRgTMUSF3J7AdfGcWx
         iDUQ==
X-Gm-Message-State: AOJu0YzZy9QmqjpkPwotZvtyTiLkdSs088GdA0rjOlqUGOXlb5oD5OhC
	bxfY+p/5ebZUlfRzzdGlIgT9GLiaxRE7U3bXOw+S2Ie1Dkm1TqpWBZPTQ3yCNuRGKEc=
X-Gm-Gg: AR+sD122y+aL3/4iY69xXrK9JSwg7kLP4kfwbN5mHI4VJmzp2rcmQXhFtbL66NPblNJ
	jDQ5XplS0QQfRBePbDzt3myAL1styjas8agq3RSPJfQe/idCBFGRFHnClfPyr6ClOazq75i672+
	xhJHpfqz2QTybDMbNFbPqmYSWgEhADPncIuxqLJ2ZKkOUC9rj2icd1DvHt4is2R2nNn/9ypj1jS
	NFHwGHuJBxL3WVsBGr0cl5uT9FXd8SKIPxafUi7EjhkwBMGUswe89I2D4+/+42IYOTYyiB3Beqx
	Oy3HewE24FiJAKXsFLkad83vBsQ6LNZtyjufDuGGhe8EwL2DHljEKR9U4k59ZLZ3ncb+cS0tc0g
	pg0T9ZTT/SAFFVB+TO+nFtwNq05YdxTkakiWp6TvLaaxAeK+HQ4XprqulOFXAPn2v/osUS4TQou
	a/TmH13pBRVj2iCtxsuDCP3GNjk5liGiROgifcfweOsziCg2c=
X-Received: by 2002:a05:600c:1554:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4954a3dc7bcmr285551285e9.16.1784717104528;
        Wed, 22 Jul 2026 03:45:04 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm111090575e9.8.2026.07.22.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:45:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Wed, 22 Jul 2026 10:44:54 +0000
Message-Id: <20260722104454.165911-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722104454.165911-1-mahe.tardy@gmail.com>
References: <20260722104454.165911-1-mahe.tardy@gmail.com>
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
index 000000000000..184b134f3823
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
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
+				     &opts);
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

