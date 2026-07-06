Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786243B6C5
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330553; cv=none; b=T3rsZvBUtvSn9k55IN9aSihrPIcUtGzkrWseGwBSkEmZGa9fWuEsrBEeLgiLqGtfDVlzhNQiaT5c37wVmRYhomvus33EzyrRgpHQKevKiDNiltuttQ/1M5NRvypqAobizyQUbokcuU5Lv90oiadkthB46h/JKj2UeRoBc4B32Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330553; c=relaxed/simple;
	bh=fmndcjanViGcYEADoEdhV6jm9+Kn08sQMnFyvTnMC8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGCh+IC/1HFkNRD/ba+/hDJa2/+VDlwUOYnYKV4NFYf36jCCxKX0lo29i2TL7T2R8FcTKGlkD8yEJNyEDFmvI777QUqrJWZB7cjNA2l00ZEPeuU+nr5+huWPBVjY4K2d4jNLtAjf5ekjdRuJthvEqqd7GLeUrsyqfKN7z0JSa2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhLvnx6C; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhLvnx6C"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1394839f8f.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330547; x=1783935347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXbm3wjsqVGwtNUtH3eqoaK9MP9AOKrO2JGwf5Teq3o=;
        b=WhLvnx6C/ARR+StkdzT1VHIyi8Gsd9WcT3TZ5BSxc4O0rktfzedQY4pJw7OluHx2z4
         A1lQGG/FXmK7sX5nLtunXErlLCfYDH7Cv7y8A1D4Hnk3o5gK+P4YzYn3NjPBBgZppVny
         ftqWWzqzVeP2rQEKuHUn/RaYL2XO+jvowwOD9msbcEoai0nX8jAWws7ubKvPaxHGhqu7
         K0uEt67uLNu6+nKtFxdlpQUtCkuerYVG0Y9N4zZqBU/VNA5jmb2Gqfp5kLf0cMinDUJz
         kkLLIKZYI9gm/OkUkJL4nzKBEPVu/0oAXdLjkv0O9t/q3cY4gGp4Hm8h7tM5KTmMGXly
         PT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330547; x=1783935347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXbm3wjsqVGwtNUtH3eqoaK9MP9AOKrO2JGwf5Teq3o=;
        b=Rhsn4Ja69n69ejRGjDxal0Hm6I9wg3iEsv0Ac15OeRGPXekriak0lONxfDm9haTBnl
         bZVieR9e7bShaMwljZnn6rA3pA22vZ3Cb+91swuA6xLNjmz6ZSJ6mf3yg6CpsuBYj0d6
         1KD1LtIdtIiOuqMonDUgOBNIyle2CnuMNqosXi6Db1tIkv3K+j8ZrNVRl8vmf+NuMZrL
         dH1WHOvU2o6cMB0zI4VrmK2+iVRehLP7n5UDvDBSYs36nz3BZ+4b82QuSqse8dLdi4Wa
         83HrXNF2+geJkOFUUkut/EaW5XNM7FrjTFJ4vVelFcfNvPWfGND60aGJ9QYOfCKF/M04
         CHdg==
X-Gm-Message-State: AOJu0YxkHh+acuHOKff8QrrL6sP04bHjHr9q2qGF1y+4jJHFTyGtK7UZ
	oxaOrqXWqmbIaM906W0nuxVNd6gFhehm1+JtlBrPM0/2qTRQkN583iaLXswoIb9A2xttPg==
X-Gm-Gg: AfdE7ckCOjg0Nchf6cLqfUK9IihK9Gfslzi5Z749NQRuhgEhjIiZ3Lf9nQTtRBWk+Wt
	U92sHe2MsC0YUJspEoYr95g9Xulg6W8yjmELzmwHwjzrxAXC3Dg08CBn4k+84enmLEESLwoSpBP
	/IW6NSWOgJg+CJnR6qj0XdydbcxdA1+ky3y1J864WnZUp2qcoF00qBLm/OWKIOjg796F4jlHBOI
	eukjCkP93tWdYuLDrBn7x7oMCtPUJqH9Bc6SK+HuWQc121JFULBLCQMiX2bTXxlYKwMhYmnRkVb
	j9Z4s7pOKyscyYeV92RLZY99AMbyeAfz6r48rl1EGEjBVnQvEbC4x4rh2HhVzC28g3kkpHW9QMH
	jObq6ITJjGcO3+8fiXCM9MDzdXgLfocXNwEc5DyMfjfd+W2cxRXlnmmO7xRk1bW3jJFOIhLSd1q
	fPLLZDwHmChYSmflv3OzvYVJKFp/Y=
X-Received: by 2002:a05:6000:2086:b0:472:f8b5:aaca with SMTP id ffacd0b85a97d-47aaa60d3cemr11695895f8f.15.1783330546444;
        Mon, 06 Jul 2026 02:35:46 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:46 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 6/6] selftests/bpf: Add ksock test for async callback guard
Date: Mon,  6 Jul 2026 09:35:25 +0000
Message-Id: <20260706093525.13030-7-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093525.13030-1-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
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

