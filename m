Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB238F237
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232500; cv=none; b=KyWQx5ZHWihJW7RosC8fl4BdQUQyyJdIPHqYQEYgqfMjdFj9gScrWpt5/SyuzBPiBiko8119XevvnBkw9bgJJiIE8vVYAgq1lrKBjVwfZNiX/uage+qUblEvO7I6++M671Ny+5TOiAVCbOcppK5iJwKDcsfcDi+pAsvusfbVjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232500; c=relaxed/simple;
	bh=fWhQaMr0fikl0GiSot7tWTi/FJ6XoTx3G4LBYUpTxk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhXn3GTxnxiqAgp8gSkYmbMFTuEs7ox8yUvM9wnwaiKijt24rWsSZAeoc70NRCaRjGj9iPOyIUhshWOjjo2XxApxEtp9+DNSB8eoO/UDKzZAH75MOaadWgeSkGftMIP8qykikttCkPuDPNOG/+XZWEZMpkzzBtBJuX0mJexLips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ysxu5p7K; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysxu5p7K"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-4645dde00a7so3899400b6e.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232498; x=1772837298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scz0WwKWQxf6uZ+Q1oA35hvOITxnAWrYWNgvErOexoI=;
        b=Ysxu5p7KE21NfPdFWloVEfgeQB4XXPQI8q6Ba6xkwjuX5Ly8D96vPWo6AWymtZMUtx
         HT4o0O77L6cwAwSWOyeswm8PZoSGsNuyvgqZNY9JlsX6XKa5yjLvtVtI4ZxM4yDB4JpJ
         iiYWG/qaZVyKvg5S1Wvl3ww05HLsyWOWB8zQc0cP027RxRHiFOE32b9grlw10rZ4WFm6
         RL0O3JQ9/3VPfy/PbGBGfHXYkuoFo7m0UY9iec7fQKtmyoLHpv5brW6UGeM+jnWvZLBs
         +QdUIIlI4SfsNWT0xFaXbbGavyCS2ScQSdzB4BGQG3YdMtI5HrDh76SVyCYtgzdwdTWO
         aIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232498; x=1772837298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scz0WwKWQxf6uZ+Q1oA35hvOITxnAWrYWNgvErOexoI=;
        b=Bz30kSbggCU061bVwi5jBPetYgwdBIBC43Oo8kzvl2EV7ftPnkRrac/ezOFotl1zmT
         KbWE4HIMAqBLJLVb1+SDzGNB35UUgNzU/hWse75RCpWD0rJwZyD/Hnvc/ETB1FsORdT1
         wyQjqYOlCoc8mS0xF8bQx0jcFwsrhGcSNlDJEFMscZSGgowD1eaA9Zvr4UohC+l2uFFG
         BGCjzituUsOvbdrj4NGwvEzAg7bgUdleaaK2P8n+mrPyW7ZxuOh3Pt7tlOC6rxD6Q3g6
         keaLj1UQVVL5MF4+1Vhel1twvdsULm7qgsNHARCnhh47kdqF4V/2Uo+H36ylNKOX1pBc
         ZV9Q==
X-Gm-Message-State: AOJu0YzL4NX5wZ/IyNglTq7lAzSYVBT0/vxDI2TD9H758c3gUpFL/LYv
	xr4UHWrf4/yGK0XN41MejHrRMa8DYF6VSC4NS2MzgqAfcKtHTr2jwAbMHKj47HOwSXI=
X-Gm-Gg: ATEYQzz7NQ89cXOy3mxa4mst9QATlqk5DkB/WI8Aq0wTVOqlUCUPrCd3MNpTOOBPbMx
	DdDAiyXUXB3PrGkXfRPgAilkBuRocKQ1E3JkKl5QNRwlZoHXOxvCIyGbd3rDKcd5BmR82CWtm7u
	0ouOp09O2OulErJtS61fRmuivMBnrDumECF4Xa55sG//VPxTkfG/6WCqZ1oGEB+wTVFNAJiHRfd
	MAn0Vak5We0rl4bPnG2fQAFqx4lFj1VEXm1yD9KFcE1LNBu+C66ZAf+Kn4P1a4PoWfrLz+Oul91
	5gwCCpLnfGp3SNgZ9MzmckPX/84JpuW7z7E8esani5L0opxJ4Nkj8cgWmfN+5251cve7Iqbhp00
	0W1JiVSv9H+YnZ/hVPSTFWnZuIMf3O/2hvgnb8DxhTPNxg7BUneqgd1Ozmd2CTeT66i6ilOfRUp
	R/JFty6vld18jEbj21fLNEd8GGIOwtJ1wjUolbnJCe4srpjE0/xPPZHHA=
X-Received: by 2002:a05:6820:4b8f:b0:677:f82a:6258 with SMTP id 006d021491bc7-679fb470a34mr2676235eaf.14.1772232497691;
        Fri, 27 Feb 2026 14:48:17 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bcbf22sm4393232eaf.2.2026.02.27.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:48:16 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 5/5] selftests/bpf: Add tests for special fields races
Date: Fri, 27 Feb 2026 14:48:05 -0800
Message-ID: <20260227224806.646888-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227224806.646888-1-memxor@gmail.com>
References: <20260227224806.646888-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12155; h=from:subject; bh=fWhQaMr0fikl0GiSot7tWTi/FJ6XoTx3G4LBYUpTxk0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoh0soZjIntQv6kEGoNohZ9DszArqPxHa7RZHzpFq V57SmfmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaIdLAAKCRBM4MiGSL8RymgVEA C6Pvllz9r0LdXZcIK5EtreFBAbiBmw1de2mwMTnFiBQ2PtU0y+NWGjieg7UQVqyAZMvbYd/UZmfxKQ hZ5BOP0zlKcmF3RSleBAUkufitqYRs8Vpnye+IWV6EUby87ysHFPrSYYvQG41O8XDpgtELLIJsAsnH CClAE0kUtqKJvXmdShl7+1miKqB6c3GFfLyy8sVNr2IcQkEGRwOnJFf/wWFGnGmSEzlvFECabX7vpg hmIhtO4R8XX9sm5fQKhRGDbzOTNP3VzFxSp2TwQBJ+Qitc1N1nvhUJUWeMKiD7GlQLt08Meo4djfb5 lhMOPNziluHH2sCC0/S+MfC+Di0jekE2jy092+Z+XL3lyurfRlC3zocsuq15znbaCEHHWzZe8RCpIF WUXfEUM/h2mZeE7uhrfuUvQhUfNGKm7psErZCJRWoBHWNw3mAi4Ag/E+nQEoNdl/h4gw6eJSY5rTP6 1ca+VzVN1En0lfoEUBzCj7Lx7swlMht+OeBiwrFYtU5G5sb18DPSOr3TqJetH0U6pnEhAlxyKvQqgI Uic9MGVipCLzMVAcxLMomjTwOm5v+5bW9LyeLJv67ze7DoFVxr/s4fufNEwfMgLMiPrKqG0FjxQYtF uGkMmz1mXaLlvZWisN+egQPDLsEw1G8qt9bTulg3T/5tVL4xbTQEf6a68YIg==
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

Reviewed-by: Amery Hung <ameryhung@gmail.com>
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

