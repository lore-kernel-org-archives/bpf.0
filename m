Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F546E005
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518545; cv=none; b=ZU+b+KJa5t5PfxsX9koITRGzG4VCzk4vnuphKXTLvXkRVI9fFPNPpxXCI2eYyD1poZng13qR6qdW4MJUdzGddHBMceQgpckYZPvFyi1JWYhYvBAbSVXNXZmESqw7e9mphiz2tW5KDoOBT6Rnv0n9WLy7JNJKK6dPIWfF3dYdtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518545; c=relaxed/simple;
	bh=aJjbBBpoCRJCEu20JwRB5Rp9r+Jsz4MhltCNwI20Ubo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rny7ozvrNsJ0xV9YK98uZoTVe8ZDvJ86yYGWzS4fjW1JVNUUZiQzKbk5ljcqV2Dy0dFOTB930qa7iiLFWglIAkgWStCLOmnJI8okJWnvEldbaqz4RwuWeEVXxFMbf0mCQgLioKeYNGaL54UCpcKPN6trr9IPy5Rma4OF1I8nJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPw7stCw; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPw7stCw"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so4651875e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518538; x=1789123338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+kN6d8+z8YVefS1D8RjSJPe3FWLFTdlv+E+aX4t1tOY=;
        b=MPw7stCwETN0m3uJYltjiDcFqK0whpf7J2cnp/LJLybJ5AVbAHw6tV/XyMKvQSZWcG
         lFtHuuluSV0h4vtCbfYWL0qRr9KYaMA3I0ienU+espf8xsjUnhYatIuB8qfmW3PcNfCS
         s6Z4LKu0fGMSBNEKrUiQ8GpvCUszIgoksvHv5UcikDYCUJD2SzAyQsVI+OUmYer8hiCx
         LmmQUYHEowr0wa9yjii9/6Z7qCcDwQv4Ds4RX5Jn08FA9Y7W6YjHOL78IOf4MDJbNoXk
         jw/7WEmB2VKOL2dmMz2uP4UZkQLMR/5TRtqIRI1hKDROYZxgBC7hBbbyC6a/FsH+acgP
         Y1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518538; x=1789123338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+kN6d8+z8YVefS1D8RjSJPe3FWLFTdlv+E+aX4t1tOY=;
        b=K/2ZN0JltCz8esim0s8E/9APf2Op+uBNG35sB6C3sSqawXvKiW/qhjul+sO//zbO+f
         YpMVnPqU6GSrG4Tnfgg03uV2vCvFcPKeWLXgIr6UHpnaHre17OUgnvFG0o2SeQVIm50J
         86VForOAqQyRMNLtQ4jUbjLJH14t7FQktfPfRcoEFOUy2H3Ey3KcFxwHnn4LhGyTAzxv
         eztnD8ugCHq7DqpqOwRalc387Rfl6iR63Xs/+xHcqXqENiVKLaEr41usI8UKvaQOdsJo
         a6om6xlW4zyxcIzb6mo9Jl9hBn6+lHx3oRePVh5dsSepivlJzISHWhoDe8ChPWbxfhic
         8Upg==
X-Gm-Message-State: AFuF++mCDv+QqELUwPbNBjZ1mzvJo5rUXcPhiVqpzKMFwXyHiyrXG3RG
	AbYsTBdoL4FTOvk32QZYHnFfN7mnQd86WCTfecefbEMUJmWQc2zvA9fsUzsnlEd1
X-Gm-Gg: AYBFou17rIEiW/IuGJYuxybbUWLzwP6x6ixw6R4InavECVzGJpqPIUKuupmWc1jdw1u
	4gs5BAEeSHq4/Hdq719jtaT1KuqE8Z7KJ1ePMdM63hxV/bNHrug/uCdUB0CAFbhphoZMEZIOUQC
	oC962j+OhMZ/CtpROkdljXCWBhAJbxZQIotA5JmVnDdGLoFLRoksXvoNiqHyjn9Nt/WNOu/gPXg
	PM7Be5cbvComrRWm7Ig/23Xvx6xRno0imHIzSzXb+W2215flc6Jo86qY0RRxoF+NLvveVQz44FO
	zxXgaYJb4EPaa/yBs0EX5e3kcJVC+QoU/EfCZP9j/k7uhUumV3Tztb+EBImNE6FAEjGmhx6UYVp
	xe++NZJZOk7ng+IHcuB/iZkVVl8YOa12TqxmKqR8LrQALWaP64QrkiBfTkjp1H6zbQx1ZwEzjJm
	p9NJSA7vYvq1nwoLuP+T9OA6hQ/dO8LnQXZjK6D3DNHhwid15o8Be2aew+WnjC1QNI27RWQbOHZ
	SFuARw3GTJF6RwDliY69ANDgqf0eaxjNFrQpk/vGpuLan/2Sj/TXmxU4cU6Uf8xONgigLAW8Ix0
	RLh/5D0iWavvHG6bDmytWSai764=
X-Received: by 2002:a05:600c:35c3:b0:49c:fc6c:be10 with SMTP id 5b1f17b1804b1-49cfc6cc055mr23647675e9.22.1788518537966;
        Fri, 04 Sep 2026 03:42:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm130283925e9.15.2026.09.04.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/8] selftests/bpf: Test timer field on recycled rhtab element
Date: Fri,  4 Sep 2026 12:41:53 +0200
Message-ID: <20260904104203.345917-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7329; i=memxor@gmail.com; h=from:subject; bh=aJjbBBpoCRJCEu20JwRB5Rp9r+Jsz4MhltCNwI20Ubo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/LMm7sY35otkxc/fk6sb5fSyNpiBtbDz991T3JqP7 +YFlcztKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETmPWP479e0kmlu66ctVruT 7Vd2fljgM98xakEQn3ugoeqru+HB3xkZLn5l0vkVtOQ0l2CHwfNLr87eSfnKom/rp9azYt50a5G bLAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise the rhtab special-field lifecycle with the sequence from the
original report. A bpf_for_each_map_elem() callback deletes the sole
element, then initializes and arms a timer through the callback value
pointer while it remains valid.

Use a one-element map and pin userspace and BPF execution to one CPU.
Repeated delete-and-replace cycles drain the per-CPU allocator cache, and
periodic RCU synchronization makes the deleted units available for
recycling.

After each replacement, a second BPF program calls bpf_timer_cancel()
on its value. A successful cancellation proves both that a timer-bearing
unit was recycled and that insertion preserved the timer field. Without
the fix, insertion clears that field and cancellation keeps returning
-EINVAL. A long expiration keeps the timer callback out of the test, so
the regression is detected without accessing freed memory.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/rhash_timer.c    | 141 ++++++++++++++++++
 .../testing/selftests/bpf/progs/rhash_timer.c |  98 ++++++++++++
 2 files changed, 239 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhash_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhash_timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash_timer.c b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
new file mode 100644
index 000000000000..3aad9fc02e06
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <test_progs.h>
+#include "rhash_timer.skel.h"
+
+#define MAX_ATTEMPTS 256
+#define RCU_SYNC_INTERVAL 64
+
+static int pin_to_first_cpu(cpu_set_t *old_mask)
+{
+	cpu_set_t new_mask;
+	int cpu;
+
+	if (sched_getaffinity(0, sizeof(*old_mask), old_mask))
+		return -errno;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++)
+		if (CPU_ISSET(cpu, old_mask))
+			break;
+	if (cpu == CPU_SETSIZE)
+		return -EINVAL;
+
+	CPU_ZERO(&new_mask);
+	CPU_SET(cpu, &new_mask);
+	if (sched_setaffinity(0, sizeof(new_mask), &new_mask))
+		return -errno;
+	return 0;
+}
+
+static int update_timer_map(int map_fd, __u64 key)
+{
+	__u64 value[3] = {};
+
+	return bpf_map_update_elem(map_fd, &key, value, BPF_NOEXIST);
+}
+
+static int run_prog(int prog_fd, struct bpf_test_run_opts *opts)
+{
+	int err;
+
+	err = bpf_prog_test_run_opts(prog_fd, opts);
+	if (err)
+		return err;
+	return opts->retval;
+}
+
+void test_rhash_timer(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct rhash_timer *skel = NULL;
+	cpu_set_t old_mask;
+	int map_fd = -1, arm_fd, cancel_fd;
+	bool affinity_set = false;
+	__u64 key = 1;
+	int attempt, err;
+
+	err = pin_to_first_cpu(&old_mask);
+	if (!ASSERT_OK(err, "pin_to_first_cpu"))
+		return;
+	affinity_set = true;
+
+	skel = rhash_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.timer_map);
+	if (!ASSERT_GE(map_fd, 0, "timer_map fd"))
+		goto out;
+	arm_fd = bpf_program__fd(skel->progs.arm_deleted_timer);
+	if (!ASSERT_GE(arm_fd, 0, "arm_deleted_timer fd"))
+		goto out;
+	cancel_fd = bpf_program__fd(skel->progs.cancel_recycled_timer);
+	if (!ASSERT_GE(cancel_fd, 0, "cancel_recycled_timer fd"))
+		goto out;
+
+	err = update_timer_map(map_fd, key);
+	if (!ASSERT_OK(err, "seed_timer_map"))
+		goto out;
+
+	for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++) {
+		err = run_prog(arm_fd, &opts);
+		if (err) {
+			ASSERT_OK(err, "arm_deleted_timer");
+			goto out;
+		}
+		if (skel->bss->armed != attempt + 1) {
+			ASSERT_EQ(skel->bss->armed, attempt + 1, "armed");
+			goto out;
+		}
+		if (skel->bss->timer_init_err) {
+			ASSERT_OK(skel->bss->timer_init_err, "timer_init_err");
+			goto out;
+		}
+		if (skel->bss->timer_set_callback_err) {
+			ASSERT_OK(skel->bss->timer_set_callback_err,
+				  "timer_set_callback_err");
+			goto out;
+		}
+		if (skel->bss->timer_start_err) {
+			ASSERT_OK(skel->bss->timer_start_err, "timer_start_err");
+			goto out;
+		}
+
+		if ((attempt + 1) % RCU_SYNC_INTERVAL == 0) {
+			err = kern_sync_rcu();
+			if (err) {
+				ASSERT_OK(err, "kern_sync_rcu");
+				goto out;
+			}
+		}
+
+		err = update_timer_map(map_fd, ++key);
+		if (err) {
+			ASSERT_OK(err, "replace_timer_map");
+			goto out;
+		}
+
+		err = run_prog(cancel_fd, &opts);
+		if (err) {
+			ASSERT_OK(err, "cancel_recycled_timer");
+			goto out;
+		}
+		if (skel->bss->timer_cancel_err) {
+			ASSERT_OK(skel->bss->timer_cancel_err, "timer_cancel_err");
+			goto out;
+		}
+		if (skel->bss->cancelled)
+			break;
+	}
+
+	ASSERT_GT(skel->bss->cancelled, 0, "preserved timer");
+out:
+	if (map_fd >= 0)
+		bpf_map_delete_elem(map_fd, &key);
+	rhash_timer__destroy(skel);
+	if (affinity_set)
+		sched_setaffinity(0, sizeof(old_mask), &old_mask);
+}
diff --git a/tools/testing/selftests/bpf/progs/rhash_timer.c b/tools/testing/selftests/bpf/progs/rhash_timer.c
new file mode 100644
index 000000000000..2e06a463c605
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rhash_timer.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+#define CLOCK_MONOTONIC 1
+#define TIMER_NSEC (60ULL * 1000 * 1000 * 1000)
+
+struct timer_value {
+	struct bpf_timer timer;
+	u64 data;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1);
+	__type(key, u64);
+	__type(value, struct timer_value);
+} timer_map SEC(".maps");
+
+u64 armed;
+u64 cancelled;
+long timer_init_err;
+long timer_set_callback_err;
+long timer_start_err;
+long timer_cancel_err;
+
+static int timer_cb(void *map, u64 *key, struct timer_value *value)
+{
+	return 0;
+}
+
+static long arm_timer_cb(struct bpf_map *map, u64 *key,
+			 struct timer_value *value, void *ctx)
+{
+	u64 key_copy = *key;
+	long err;
+
+	err = bpf_map_delete_elem(map, &key_copy);
+	if (err)
+		return 1;
+
+	err = bpf_timer_init(&value->timer, map, CLOCK_MONOTONIC);
+	if (err) {
+		timer_init_err = err;
+		return 1;
+	}
+
+	err = bpf_timer_set_callback(&value->timer, timer_cb);
+	if (err) {
+		timer_set_callback_err = err;
+		return 1;
+	}
+
+	err = bpf_timer_start(&value->timer, TIMER_NSEC, BPF_F_TIMER_CPU_PIN);
+	if (err) {
+		timer_start_err = err;
+		return 1;
+	}
+
+	__sync_fetch_and_add(&armed, 1);
+	return 1;
+}
+
+static long cancel_timer_cb(struct bpf_map *map, u64 *key,
+			    struct timer_value *value, void *ctx)
+{
+	long err;
+
+	err = bpf_timer_cancel(&value->timer);
+	if (err == -EINVAL)
+		return 1;
+	if (err < 0) {
+		timer_cancel_err = err;
+		return 1;
+	}
+
+	__sync_fetch_and_add(&cancelled, 1);
+	return 1;
+}
+
+SEC("syscall")
+int arm_deleted_timer(void *ctx)
+{
+	bpf_for_each_map_elem(&timer_map, arm_timer_cb, NULL, 0);
+	return 0;
+}
+
+SEC("syscall")
+int cancel_recycled_timer(void *ctx)
+{
+	bpf_for_each_map_elem(&timer_map, cancel_timer_cb, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

