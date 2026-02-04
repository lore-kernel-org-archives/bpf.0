Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275336AB49
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184316; cv=none; b=rEs7QF2bHEpdHL5kD8m500A6Yei16+J3btNgpFDfe5xMKE2eyAMKkSnhkBmSlj8htKPoZLCpLBHzz9YNGQMpQn7HNGcabZlGCiYbGYAyLseRVXxQdWZaQXTZdVuglol3I4Gxw+9nPRpAyGaNr6p1nEP+eXSUP4rTf7AhJcUoqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184316; c=relaxed/simple;
	bh=nPjYYnHQxObuB0Ahuo6+NDJE4IlnvfXBohhhY94UzTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvXabMHNFBvplGrNGnhw8oLgnt+KOLacsfqUiCatBhLYtfrcAb/+YlhqtjtEFfmB7pa6KoqrPkis5LS4d4VWePxXdW2R9DmbsJbewWK7W76+ZtgqqErmDbZXiiGk9FZXirV3dEn9/xCPOvPkcNjwd6YAJka1yj6isOAKrPtFIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkF7/fPo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkF7/fPo"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82318b640beso3610851b3a.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 21:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770184315; x=1770789115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w//PdEvEK79u4CG5EQr9wEDM4RdGRC8XJ2Jm/hb6SdA=;
        b=JkF7/fPo75dQhRVS9pl2boPMSB8U2sVlvISKDFhcRRFQi5ihVzyYLuIDiLs9zRqj8w
         b8WdXruBh0JfuTNMnFAlCWS4fD+jkHdTbCAy3DDEbkuJSwVjPRL+BNPyAJfUyNXd72aA
         dM4UyCbKjzcfHZdiNjdTiCH/cy8yEhRTML5gh84AN969M00vzjjjfPJmhx40fgtvT0He
         itz7gcxHb3+wfJtaziAI8Ci2mJno3Kge8HoHlsT8Jb8nKFh0KrTbQZdlN7oY1eBIrI27
         sbd4MAwOK9ghHkVO6jyioaCslSQUkTbmHyyI0mWouzkPa2b0FEF37S/g8GkjYlyj4SDo
         90zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184315; x=1770789115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w//PdEvEK79u4CG5EQr9wEDM4RdGRC8XJ2Jm/hb6SdA=;
        b=Pbzf25BVXUR5Ad/FDYZAE9mioONK4EFlEXAgP8HVz89TYcE7p0qqqEyAjxszV78uWf
         DVNWtdVIcVTZEBhF6ian4OgR/PAlA2lBu5VUoWe9xbOQCgzyMrbf7BLqkNruoYwxoAJk
         0Lx0+ji/Ej9G0NN+9RZrXNSvDaWyP46dntSNc6Yg2y9HXNI1LzTNCwNqVjrKzShZYlmP
         CRZCtQQHUG8UXZFlg0G2Dnf/LfsGRrinzrVT/Oc0HOh9IKn3idKGHchVB9DhPyNJqSwc
         9lNeFD52tTobNAm+A6XwzLlaY1v5GPwKKgcofW3NElU7eOUI68EPdijhPUHrJqItbuLH
         Fmww==
X-Gm-Message-State: AOJu0YzltJSy1/0zyddnYq5TX93Rla5aT6XeBnwJjeOk1RIPPnsnjVmb
	h8AOhZOmQYczZqiy3wArReQUgiAU/VTbKaBKhHrzi0PQzmfZLWNvN7/dpsOKTg==
X-Gm-Gg: AZuq6aLUNfHrrD09D2tfhepqPlfjqbQYtM5UaroixkGr0020zTJVqUbl2cSGSuwXFGb
	U+c0FreCvEdNU21ZdndbSJXQBoO+oFV/L7Fqfd29aa5fpNkIau7vZYn6vfjSyO9N2H8etSR4w5+
	4WAaMCjj/F/RWK9Gu3bE3npQXWvhe0p9k36Sudkb5mM/RDVIKx4ad1VecUKzBHygO/NfhqaRFYZ
	kYPh5MaERgfkBaKfB6xzQN/bVTOTwF80b/sNcpwU0C+9GMKm3SZbiJfHPkdGaR/y6pO+TFSjTiM
	gb6NhWZG26UsHywTk6afh9TEert/X6hBlgT9AIrv3fzGYtYgSQ2I87hSvIFo/rC/aLCQVycMYCX
	MovmyFjNmye0crW9rkTXFlcBXbtGGW6RoiCfSCdh2pQY7GFfjzh35zDvplUvELSoDWlLEGNNnpK
	ShvFj8l2aoUUCYJEfRMehV/Ih9hqVL9m3uWiehD45uuBT90dJOJRJd246THCfh8iW1Ap43a+LK7
	vdfQfZl/sYpRoDMOuwtY/bi5c1wjPv7hMyPsxGnFXXVZhNvYGrCYQFzsLIz
X-Received: by 2002:a05:6a20:938a:b0:361:63eb:d017 with SMTP id adf61e73a8af0-393724bf77amr1905256637.58.1770184314986;
        Tue, 03 Feb 2026 21:51:54 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e635sm11466765ad.52.2026.02.03.21.51.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 21:51:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v3 bpf-next 2/4] selftests/bpf: Add a testcase for deadlock avoidance
Date: Tue,  3 Feb 2026 21:51:45 -0800
Message-ID: <20260204055147.54960-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
References: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a testcase that checks that deadlock avoidance is working
as expected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/timer_start_deadlock.c     | 33 ++++++++
 .../bpf/progs/timer_start_deadlock.c          | 75 +++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_deadlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c b/tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
new file mode 100644
index 000000000000..9f1f9aec8888
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "timer_start_deadlock.skel.h"
+
+void test_timer_start_deadlock(void)
+{
+	struct timer_start_deadlock *skel;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	skel = timer_start_deadlock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = timer_start_deadlock__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.start_timer);
+
+	/*
+	 * Run the syscall program that attempts to deadlock.
+	 * If the kernel deadlocks, this call will never return.
+	 */
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(err, "prog_test_run");
+	ASSERT_EQ(opts.retval, 0, "prog_retval");
+
+	ASSERT_EQ(skel->bss->tp_called, 1, "tp_called");
+cleanup:
+	timer_start_deadlock__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_start_deadlock.c b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
new file mode 100644
index 000000000000..368563747a46
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define CLOCK_MONOTONIC 1
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer_map SEC(".maps");
+
+volatile int in_timer_start;
+volatile int tp_called;
+
+static int timer_cb(void *map, int *key, struct elem *value)
+{
+	return 0;
+}
+
+SEC("tp_btf/hrtimer_cancel")
+int BPF_PROG(tp_hrtimer_cancel, struct hrtimer *hrtimer)
+{
+	struct bpf_timer *timer;
+	static bool called = false;
+	int key = 0;
+
+	if (!in_timer_start)
+		return 0;
+
+	tp_called = 1;
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+
+	/*
+	 * Call bpf_timer_start() from the tracepoint within hrtimer logic
+	 * on the same timer to make sure it doesn't deadlock,
+	 * and do it once.
+	 */
+	if (!called) {
+		called = true;
+		bpf_timer_start(timer, 1000000000, 0);
+	}
+	return 0;
+}
+
+SEC("syscall")
+int start_timer(void *ctx)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	/* claude may complain here that there is no NULL check. Ignoring it. */
+	bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, timer_cb);
+
+	/*
+	 * call hrtimer_start() twice, so that 2nd call does
+	 * remove_hrtimer() and trace_hrtimer_cancel() tracepoint.
+	 */
+	in_timer_start = 1;
+	bpf_timer_start(timer, 1000000000, 0);
+	bpf_timer_start(timer, 1000000000, 0);
+	in_timer_start = 0;
+	return 0;
+}
-- 
2.47.3

