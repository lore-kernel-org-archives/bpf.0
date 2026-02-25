Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC62313537
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045497; cv=none; b=bLYY9Uv6f0cSkrEiXzanVKAFKqtdHlttMGIlHj7smHgz7xrcP+4Ocbx3l2i+rnmwEGe9ehGzQtZqlb/8jVN2HkIOgm3WSWefs6ZNDBVfH/WoqZTDM6bB9NgthQPPNPVHkitm7Qy08ZvLQFdLYMjTufRBGws94kyU4+ClmsFe118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045497; c=relaxed/simple;
	bh=EKYDu/wX3O1wBmI+zy5TeFFDDIKvsN8WJ2WI6YEIJDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePrSk1kI/QRtin7jW4+4GPOss4RkGnVm46DAbvdZao6hRdDODkU13wkXB1rzVVXfitXaKxSxeBjHSDHNN3LVSKPt8BbVZsNxiSk7KbZLHpspEIWTE2l4LtnF1zC4PezbpFkEW13g918d6/spP1GE8WIllACANy3uASx12Q68y/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvhDHVmL; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvhDHVmL"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d1872504cbso1385261a34.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045490; x=1772650290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGwr7JSsBS8q8t6kvg58ms9zCvnMXGezZMd6ktlCK44=;
        b=kvhDHVmLmI+B80cWz6P1V3WH1+dxBKJFK3UF++CmQYlGnailZ3IQl+LpgdDzpCvOYs
         oRI39/LZmSJP9z3bJzNiJqDy6KOc0n2N31lP39t70XrabqqFkej8RcLEBYWz8h6VhinB
         C0sBAEVcvICcrpgm0e6RGD2vN+DJ7pxYpSOQf2eJrtQQdfoAJ4RjkwZYwbniAuEEcBQj
         mwjJPYrOuSIpaPuTOxVG9BonlqdF6AhRuIo+fk3HF8uT7Uy5I3PwN4mn6Pd0UvH7OuRD
         V8qBr6wrmh3QS7qIO3M336DUnERhDMMRvHT1aHdRrceocuQ1Nt2IdpkHfDwVvX/4uF1i
         A5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045490; x=1772650290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGwr7JSsBS8q8t6kvg58ms9zCvnMXGezZMd6ktlCK44=;
        b=wEjgREdFEnX0/x4OPmSheQBgfhIKM3wVnVF/+LFU2IuR9M8XdA/Tm+pw8f9LCpNNqH
         sGGBAE5oNRU/0miC3wtHYExbxs5AIB4wfYcG/Dd5PaYJQ4V3Ag7eaj7aB8drPeh/Djuf
         f1xwvZFadyM3iPR6HTcczH/kKpKyj/nz3V4byVQALhbyuNXP4mkAwt+1o4de0WzbX1NV
         MyUXOmd4LUMKVrTbL4fm/GhbZVe0AUaefv4K+ZLAryEvn/m0JH+a/zbMtcSGtKqNvXRd
         nGiOuNIrr8y8/CqyoZskZ07VReOFDMp+vExdyn2Au083jSmlQ9UMLMh6pmvPOTEGMknL
         bgAg==
X-Gm-Message-State: AOJu0Ywt452FG/YGKC/mYtR49bgKt7RyPXgPK0MYoMQLSAQT2wuZErUO
	IcgP9+8vIwA2nipmw5HSrWYAsDOGFRrDmThHGjgIYQn1KuuxG1VIzaUuWTo/6MIkc5A=
X-Gm-Gg: ATEYQzxmVy7iup0UkOtrH85z/phP8LUyl2XjtZ/sxg0cXeHDk33lCQIHiU9o54X7cyx
	Pn8n0XSq3sdlyc1cRYFgKcUGo/sqLrK48Ft8Sn7hXDXnT8ekxVHa+RtcHMK+T97gW9IJVUSDtcA
	O+466lNHRl+xNuixX/yW2rUaWdtDNNUt67hB5BP8Ittmd/ikBqgWxdWugjVs03qkVYpVhloxFiv
	wl/sGFhz6NCUgipax3bK0VsuWnmbqoNRvLxPEALgSoyRcLclg1JU92JgU1PySu0ZZZthE9keXz8
	X0EaxQ89sX0Pv+GwZeKBbEIduUOHFi/1/60iC+sn0vbZEQEbW1NrSC/lXQ7UkdoVd3Tt23fud93
	imW9IkTl1tHju07sDOJk1mMfS4Ti3uK4nuXJdDe0rPFJXK8SC/HUP/o9n8T9LNu9ilIO/dJZw51
	wvjv1CiNdnMQGbYBm6CBNzXosXZILQE9NQSUXiTlYfPm4=
X-Received: by 2002:a9d:6515:0:b0:7d1:9183:c683 with SMTP id 46e09a7af769-7d585784820mr37917a34.16.1772045490017;
        Wed, 25 Feb 2026 10:51:30 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d55b9a8498sm6464153a34.28.2026.02.25.10.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:51:29 -0800 (PST)
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
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Add tests for special fields races
Date: Wed, 25 Feb 2026 10:51:21 -0800
Message-ID: <20260225185121.2057388-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225185121.2057388-1-memxor@gmail.com>
References: <20260225185121.2057388-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9090; h=from:subject; bh=EKYDu/wX3O1wBmI+zy5TeFFDDIKvsN8WJ2WI6YEIJDU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpn0QNFcFdtwdGdsmhwHtAmQrERM1zVm+zZlodUno3 IXd7Hd+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaZ9EDQAKCRBM4MiGSL8RyohVD/ 9JzHnW8Da31EfCXiTnG6k2UiTvM+yING2ZJHMpgIrcCIZdvNQaKaJKNJPhvq173Yvaf9b7jTem617S axQy6BG6obYyQX4zZivM7upHeZrc9/S7B9PdzZDwvVK8ejwMyyzp28TzfHvbOcWM9UJjWijeW9HvVP /51BHZASBf2aUbHw3T0iVSGM8aKoF3i//ndQ0BPgM1uFEGo482y45ah8OoXS2HQCA0e90Q8P9X+534 /YKq43BEo4w7X+8936sMpthie45cWyU5kE1gtwAd77mlG5HEmCNjIBUcxKFTFlWZP1Q8jX1BDnTa0t mmGIDvfkiFCo/PawQZeal8Dm6ioHv5+fXbe0GJOdvuAVE6cFlQTY/8UmhIDKq6Rrp6qk8PGxWbDJmn n52gRyaxrMp+021o2B6Y8HvoQ1Uyd7PgrVbKB9jrv7S+nYhBOTFi0pGEmUF4EMHE7BPeV03ydUJXGU +GoqJcqTNF98/UYrQw/Nhmj7G2VrekSAD2bEqqu6KaZK8GiFXSOhVh/w67s0FK0PEeZbyBXgSqHt57 XwObc61QULP9HeaD8tbDI9dWAe4DPnSgMKol5CbVbSf+wZFyJJlUW8Uivf5Hc2pSN5PEhUxPtQl5WT AMUcTQBMG0AkBeod6asb7CoGBSo7c1jWLfJpeCirpfY5yMy0N1hSctxkqsMg==
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
 .../selftests/bpf/prog_tests/map_kptr_race.c  | 155 ++++++++++++++++++
 .../selftests/bpf/progs/map_kptr_race.c       | 145 ++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
new file mode 100644
index 000000000000..941e3d9880ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
@@ -0,0 +1,155 @@
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
+	map_id = get_map_id(bpf_map__fd(skel->maps.sk_ls_race_map));
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
+	if (test__start_subtest("sk_ls_leak"))
+		test_sk_ls_leak();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_race.c b/tools/testing/selftests/bpf/progs/map_kptr_race.c
new file mode 100644
index 000000000000..1731f42bf5bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_kptr_race.c
@@ -0,0 +1,145 @@
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
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} sk_ls_race_map SEC(".maps");
+
+int num_of_refs;
+int sk_ls_leak_done;
+int target_map_id;
+int map_freed;
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
+	v = bpf_sk_storage_get(&sk_ls_race_map, sk, NULL,
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
+	bpf_sk_storage_delete(&sk_ls_race_map, sk);
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

