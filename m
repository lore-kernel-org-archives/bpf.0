Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965BC299943
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772169651; cv=none; b=bOQOWICl5IcLTPWJi5En4gGPsLaLow/UfXtFnjoI6Qii7xCRTnxXvZc0gL0f8RjUcsWLdZbNH/qLkcRqRCAbBFIMpyhJXm2HElv02akhWDKUB95Gc1vhiwag55sQUXop2AhX6F+Q+lq1tEFfBLSu3gINNtNqxul7skkiQSq7gG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772169651; c=relaxed/simple;
	bh=RFC1CHq8/ER3nYwkQRPu16GTh+aK+BiscoxalM2wN/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Snr1xo7ZKr3zhK3rfylpFSKjIw0gMkiISWztgCFk9mctl1gc34OSQ3TLpk6fotaIo/Pu01HwFHNGp0D42PA3fNW6BI179rzuI7me042mubIg2cIKAjiFoWZef1UHm27ybneVLnIOQ963jUxMrZGPxI+3Ws1Kfe/d5wRpi0rphEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR2GjD7a; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR2GjD7a"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1718500a34.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772169648; x=1772774448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyOsOaZcrYjhfBArliBedBowoBatvyksFbJ8t9bnACg=;
        b=bR2GjD7a06+rdu3wwctYqcrmYuE6Eor9+xifdyUaOns0CTfKIcMAnxNf+k4+7VhyhB
         n03G3uXgIJWmCcAmjQ8KrSN1+HwNgrQ+q1BwNQenQAy4Z56ExqbnCtN13qhlwmpNBpOV
         iZ8ByT54DQC4qb4ZhXhOGjuQhH2hFAJ4vMRcAvDrxWrVptzmkjoJfTuPVSZABRn2vH7A
         IO9r2Kr6lx+aSOr2ds4Awuw6lC9+acAHV3puLdd4YKEawGvNFIh1tDOCfIB/ITuBWgsO
         p0XCCPa2H86TR3+AMu5ht56iFQ8aXiNS15dx9JNZDg6nonsX3bF5C2L2B5F7un1HJ9oK
         DJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772169648; x=1772774448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyOsOaZcrYjhfBArliBedBowoBatvyksFbJ8t9bnACg=;
        b=XAntbORl98cPO2xHjJAH8614Nd9rOjZs3l0cgyvO9fptUoOb3OldDtbsnlvXm1Koxl
         lBO8lDtoJVv4VdwX+6Ccj3PqiOyRKLq3YaK/RCCQV6l44YttK1vuJayxeFGWnsjSEQjw
         XBZJ9EYwJskZGXmzJpYA0+XEXt2RmVG1StBuohOEeyz4fnG+6hYueMmMx8/zWId5zoaW
         Irw4LHa2/wDh+6xEw7yKiwEgBvf38v9ge2Nvk4NOeAFDe6JZnXFKEQ7WrBdWGUN2r1Ve
         OWal2GKAQ9qZ/U+zAICfg2rPqirc76QVTaEFmxorkUcDML3b0IxNP9Lhb1AaVKnYAgEe
         sisA==
X-Gm-Message-State: AOJu0Yy6m2W5FTR9G3bAyfOKASVZY76xE/4og14GMFZDO9PNjX61ui5L
	95Jx0uemufwiGvqOUspt669v5T7V4izwgUKKAoiYZ5sP4DonVgAhZEQpA1fG5YpI
X-Gm-Gg: ATEYQzznxEAEUzrK6cuW+ZooMeRSQHnhZAQAGcfkatNVPRs/0MOq8KmPcKwOz7gIxeG
	b/R6aIhLY9z7D8VZKy6Fcx5pbH5pUCTM0fbt0xM9lWLW7+cY403CLiFM6soBCfHAtrbqpSaMedt
	2D2ExBuabNbbGrpOmGVdcXbNX7fdo++K8A3JkZXc4pc3SPzvGLJgyaQxJWjYdgBsugeyvNY5Xt+
	krUldF9FAmzD9k1iZA9O5ZVYQ78nRo7ZUfhGfAuaWxhfAWZp5V+zLyxHY5xfNx/PVThI0OOl2kC
	W7xG04yg34VvAOwsbJkGmXQiSiL84Z1uaRlw61YBP+RCy9dSycmZw3JO5VpuuLB3YtCqq+ZuSbf
	ulgnjukLm0BHwcdEolkQm9Trqi8j8lMZFCoWUsiMTWPwrTPb9fNhQJjdnQFKKIVcslo4BsaUrWX
	9vG4dXHftYNN31Y6z9yFy1DHNbLSyBN/VfCIGdamIvVKnR
X-Received: by 2002:a05:6870:41cb:b0:404:1a57:de8d with SMTP id 586e51a60fabf-41627062b9dmr1268046fac.45.1772169648110;
        Thu, 26 Feb 2026 21:20:48 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9906dsm3831609fac.6.2026.02.26.21.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:20:46 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 5/5] selftests/bpf: Add tests for special fields races
Date: Thu, 26 Feb 2026 21:20:31 -0800
Message-ID: <20260227052031.3988575-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227052031.3988575-1-memxor@gmail.com>
References: <20260227052031.3988575-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12108; h=from:subject; bh=RFC1CHq8/ER3nYwkQRPu16GTh+aK+BiscoxalM2wN/k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoSmPkDKQAVCM3jXYmtrwHi1//KnzLP87NcA2wjtz EdTc84OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaEpjwAKCRBM4MiGSL8RyqYyD/ 9LvTtNKKcFiQCXCSSNOPllX5qlNduP8k8DRw0g+lzLo7lQIrMlBNY3CrVHrLedtB9bH7WIF3e4CdLp Mx2ltZ/9Kr2E1eovdm4dEv7wXO3nmgLVH826c4yMO9mF9AruFug7AVzKJa9TsjkU8gqr5M5uHSOp/r Na/LOS7JYtTuOEr2+bHbJJTwMTglhG18nuhM0Gi2Tbjx3ohv2FahC/pHi9NqtvUYa2VDVCXxsC2Wba qFDEnv39c1+Bqlqw9YIi+fssmcVaYS26XTd6ws9bbYo5SoWr14/yHzUij+mmBtpheOVFEdacjmU09C pSmvDNjYf/xyMJkiDwMv9NW/5tocyNZh7/rgIL4Zib0cajj8AixoJjtQPnDM5nghourYxL7860u6xe 1j1eVKJSoFgqtYO3j3jr6TTjMppu1OpBMMTxI22JkEM4OnMLBVHAu9UhSalYOWcHSbzViBhQvwIBw0 MLTnjaNqZMKkhbgoz0I71rk3cllV2rN/haBYbl5dATU4oPdy6jQCgMZVdQ/2UMZfKZwbWIGiwRUopj wRloDMrLnrkyoFZQiVPr9Jf+WRBQgMzETYPHGU+gooxKV8eZ7j7HTjrsyuWUh2etIH5QRRHguqRCdQ SB3FEQGN5tZTKEyQYjnlkcv+Jm79/cslTp7JTLjv62IygXRTkxlESPmt4wPw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a couple of tests to ensure that the refcount drops to zero when we
exercise the race where creation of a special field succeeds the logical
bpf_obj_free_fields done when deleting an element. Prior to previous
changes, the fields would be freed eagerly and repopulate and end up
leaking, causing the reference to not drop down correctly. Running this
test on a kernel without fixes will cause a hang in delete_module, since
the module reference stays active due to the leaked kptr not dropping
it. After the fixes tests succeed as expected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr_race.c  | 218 ++++++++++++++++++
 .../selftests/bpf/progs/map_kptr_race.c       | 197 ++++++++++++++++
 2 files changed, 415 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
new file mode 100644
index 000000000000..506ed55e8528
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "map_kptr_race.skel.h"
+
+static int get_map_id(int map_fd)
+{
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+
+	if (!ASSERT_OK(bpf_map_get_info_by_fd(map_fd, &info, &len), "get_map_info"))
+		return -1;
+	return info.id;
+}
+
+static int read_refs(struct map_kptr_race *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int ret;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.count_ref), &opts);
+	if (!ASSERT_OK(ret, "count_ref run"))
+		return -1;
+	if (!ASSERT_OK(opts.retval, "count_ref retval"))
+		return -1;
+	return skel->bss->num_of_refs;
+}
+
+static void test_htab_leak(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct map_kptr_race *skel, *watcher;
+	int ret, map_id;
+
+	skel = map_kptr_race__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_htab_leak), &opts);
+	if (!ASSERT_OK(ret, "test_htab_leak run"))
+		goto out_skel;
+	if (!ASSERT_OK(opts.retval, "test_htab_leak retval"))
+		goto out_skel;
+
+	map_id = get_map_id(bpf_map__fd(skel->maps.race_hash_map));
+	if (!ASSERT_GE(map_id, 0, "map_id"))
+		goto out_skel;
+
+	watcher = map_kptr_race__open_and_load();
+	if (!ASSERT_OK_PTR(watcher, "watcher open_and_load"))
+		goto out_skel;
+
+	watcher->bss->target_map_id = map_id;
+	watcher->links.map_put = bpf_program__attach(watcher->progs.map_put);
+	if (!ASSERT_OK_PTR(watcher->links.map_put, "attach fentry"))
+		goto out_watcher;
+	watcher->links.htab_map_free = bpf_program__attach(watcher->progs.htab_map_free);
+	if (!ASSERT_OK_PTR(watcher->links.htab_map_free, "attach fexit"))
+		goto out_watcher;
+
+	map_kptr_race__destroy(skel);
+	skel = NULL;
+
+	kern_sync_rcu();
+
+	while (!READ_ONCE(watcher->bss->map_freed))
+		sched_yield();
+
+	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
+	ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
+
+out_watcher:
+	map_kptr_race__destroy(watcher);
+out_skel:
+	map_kptr_race__destroy(skel);
+}
+
+static void test_percpu_htab_leak(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct map_kptr_race *skel, *watcher;
+	int ret, map_id;
+
+	skel = map_kptr_race__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+	if (skel->rodata->nr_cpus > 16)
+		skel->rodata->nr_cpus = 16;
+
+	ret = map_kptr_race__load(skel);
+	if (!ASSERT_OK(ret, "load"))
+		goto out_skel;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_percpu_htab_leak), &opts);
+	if (!ASSERT_OK(ret, "test_percpu_htab_leak run"))
+		goto out_skel;
+	if (!ASSERT_OK(opts.retval, "test_percpu_htab_leak retval"))
+		goto out_skel;
+
+	map_id = get_map_id(bpf_map__fd(skel->maps.race_percpu_hash_map));
+	if (!ASSERT_GE(map_id, 0, "map_id"))
+		goto out_skel;
+
+	watcher = map_kptr_race__open_and_load();
+	if (!ASSERT_OK_PTR(watcher, "watcher open_and_load"))
+		goto out_skel;
+
+	watcher->bss->target_map_id = map_id;
+	watcher->links.map_put = bpf_program__attach(watcher->progs.map_put);
+	if (!ASSERT_OK_PTR(watcher->links.map_put, "attach fentry"))
+		goto out_watcher;
+	watcher->links.htab_map_free = bpf_program__attach(watcher->progs.htab_map_free);
+	if (!ASSERT_OK_PTR(watcher->links.htab_map_free, "attach fexit"))
+		goto out_watcher;
+
+	map_kptr_race__destroy(skel);
+	skel = NULL;
+
+	kern_sync_rcu();
+
+	while (!READ_ONCE(watcher->bss->map_freed))
+		sched_yield();
+
+	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
+	ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
+
+out_watcher:
+	map_kptr_race__destroy(watcher);
+out_skel:
+	map_kptr_race__destroy(skel);
+}
+
+static void test_sk_ls_leak(void)
+{
+	struct map_kptr_race *skel, *watcher;
+	int listen_fd = -1, client_fd = -1, map_id;
+
+	skel = map_kptr_race__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(map_kptr_race__attach(skel), "attach"))
+		goto out_skel;
+
+	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(listen_fd, 0, "start_server"))
+		goto out_skel;
+
+	client_fd = connect_to_fd(listen_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto out_skel;
+
+	if (!ASSERT_EQ(skel->bss->sk_ls_leak_done, 1, "sk_ls_leak_done"))
+		goto out_skel;
+
+	close(client_fd);
+	client_fd = -1;
+	close(listen_fd);
+	listen_fd = -1;
+
+	map_id = get_map_id(bpf_map__fd(skel->maps.race_sk_ls_map));
+	if (!ASSERT_GE(map_id, 0, "map_id"))
+		goto out_skel;
+
+	watcher = map_kptr_race__open_and_load();
+	if (!ASSERT_OK_PTR(watcher, "watcher open_and_load"))
+		goto out_skel;
+
+	watcher->bss->target_map_id = map_id;
+	watcher->links.map_put = bpf_program__attach(watcher->progs.map_put);
+	if (!ASSERT_OK_PTR(watcher->links.map_put, "attach fentry"))
+		goto out_watcher;
+	watcher->links.sk_map_free = bpf_program__attach(watcher->progs.sk_map_free);
+	if (!ASSERT_OK_PTR(watcher->links.sk_map_free, "attach fexit"))
+		goto out_watcher;
+
+	map_kptr_race__destroy(skel);
+	skel = NULL;
+
+	kern_sync_rcu();
+
+	while (!READ_ONCE(watcher->bss->map_freed))
+		sched_yield();
+
+	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
+	ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
+
+out_watcher:
+	map_kptr_race__destroy(watcher);
+out_skel:
+	if (client_fd >= 0)
+		close(client_fd);
+	if (listen_fd >= 0)
+		close(listen_fd);
+	map_kptr_race__destroy(skel);
+}
+
+void serial_test_map_kptr_race(void)
+{
+	if (test__start_subtest("htab_leak"))
+		test_htab_leak();
+	if (test__start_subtest("percpu_htab_leak"))
+		test_percpu_htab_leak();
+	if (test__start_subtest("sk_ls_leak"))
+		test_sk_ls_leak();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_race.c b/tools/testing/selftests/bpf/progs/map_kptr_race.c
new file mode 100644
index 000000000000..f6f136cd8f60
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_kptr_race.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+struct map_value {
+	struct prog_test_ref_kfunc __kptr *ref_ptr;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} race_hash_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} race_percpu_hash_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} race_sk_ls_map SEC(".maps");
+
+int num_of_refs;
+int sk_ls_leak_done;
+int target_map_id;
+int map_freed;
+const volatile int nr_cpus;
+
+SEC("tc")
+int test_htab_leak(struct __sk_buff *skb)
+{
+	struct prog_test_ref_kfunc *p, *old;
+	struct map_value val = {};
+	struct map_value *v;
+	int key = 0;
+
+	if (bpf_map_update_elem(&race_hash_map, &key, &val, BPF_ANY))
+		return 1;
+
+	v = bpf_map_lookup_elem(&race_hash_map, &key);
+	if (!v)
+		return 2;
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!p)
+		return 3;
+	old = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (old)
+		bpf_kfunc_call_test_release(old);
+
+	bpf_map_delete_elem(&race_hash_map, &key);
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!p)
+		return 4;
+	old = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (old)
+		bpf_kfunc_call_test_release(old);
+
+	return 0;
+}
+
+static int fill_percpu_kptr(struct map_value *v)
+{
+	struct prog_test_ref_kfunc *p, *old;
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!p)
+		return 1;
+	old = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (old)
+		bpf_kfunc_call_test_release(old);
+	return 0;
+}
+
+SEC("tc")
+int test_percpu_htab_leak(struct __sk_buff *skb)
+{
+	struct map_value *v, *arr[16] = {};
+	struct map_value val = {};
+	int key = 0;
+	int err = 0;
+
+	if (bpf_map_update_elem(&race_percpu_hash_map, &key, &val, BPF_ANY))
+		return 1;
+
+	for (int i = 0; i < nr_cpus; i++) {
+		v = bpf_map_lookup_percpu_elem(&race_percpu_hash_map, &key, i);
+		if (!v)
+			return 2;
+		arr[i] = v;
+	}
+
+	bpf_map_delete_elem(&race_percpu_hash_map, &key);
+
+	for (int i = 0; i < nr_cpus; i++) {
+		v = arr[i];
+		err = fill_percpu_kptr(v);
+		if (err)
+			return 3;
+	}
+
+	return 0;
+}
+
+SEC("tp_btf/inet_sock_set_state")
+int BPF_PROG(test_sk_ls_leak, struct sock *sk, int oldstate, int newstate)
+{
+	struct prog_test_ref_kfunc *p, *old;
+	struct map_value *v;
+
+	if (newstate != BPF_TCP_SYN_SENT)
+		return 0;
+
+	if (sk_ls_leak_done)
+		return 0;
+
+	v = bpf_sk_storage_get(&race_sk_ls_map, sk, NULL,
+				BPF_SK_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 0;
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!p)
+		return 0;
+	old = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (old)
+		bpf_kfunc_call_test_release(old);
+
+	bpf_sk_storage_delete(&race_sk_ls_map, sk);
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!p)
+		return 0;
+	old = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (old)
+		bpf_kfunc_call_test_release(old);
+
+	sk_ls_leak_done = 1;
+	return 0;
+}
+
+long target_map_ptr;
+
+SEC("fentry/bpf_map_put")
+int BPF_PROG(map_put, struct bpf_map *map)
+{
+	if (target_map_id && map->id == (u32)target_map_id)
+		target_map_ptr = (long)map;
+	return 0;
+}
+
+SEC("fexit/htab_map_free")
+int BPF_PROG(htab_map_free, struct bpf_map *map)
+{
+	if (target_map_ptr && (long)map == target_map_ptr)
+		map_freed = 1;
+	return 0;
+}
+
+SEC("fexit/bpf_sk_storage_map_free")
+int BPF_PROG(sk_map_free, struct bpf_map *map)
+{
+	if (target_map_ptr && (long)map == target_map_ptr)
+		map_freed = 1;
+	return 0;
+}
+
+SEC("syscall")
+int count_ref(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long arg = 0;
+
+	p = bpf_kfunc_call_test_acquire(&arg);
+	if (!p)
+		return 1;
+
+	num_of_refs = p->cnt.refs.counter;
+
+	bpf_kfunc_call_test_release(p);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

