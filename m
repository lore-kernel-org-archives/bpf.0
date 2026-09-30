Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BB3F86EF
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762375; cv=none; b=tUd7MyjGKT9pO+Z70tb8ACbjotDBpuQcxlLxc+k6/4vW9cwIX6qVOeqSTgciYo4bPPIyjD465v2ApJ1GfDFPGFHUdf+YvaX2la9odq5MHHqTKlSygk2kIOmR4lfyW3D+zy1Hh7X+m1jgjxs7+1R3IbgCjs0dKtAu/jO69qwenxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762375; c=relaxed/simple;
	bh=Uze1lSNK8mzeUO6tnnnxWt+QiE0SLNzjGMCvngKtSu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbyuIFyjWLGta1k0DX3sJpz2RpZpm6NzrkQrKfuIJr5mhxAuFVd36O7VYK9pic6w2QwlyRLcYDoycrsrQyIND1B2vJvSI1jvl9K7thjV0BAidrZj9b05QliTs6hMwnXH6uSTDRStnsGe6Tr2XoVjxQs5iImOgP5WQN6f0UT+/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rW/6LtN6; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rW/6LtN6"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so2970142b3a.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762371; x=1791367171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhIdjL5E2FCgFGQnZNNB655Rlqun+pELJaLoQUvveqk=;
        b=rW/6LtN6V3crrDfV0euem5H4opPrQG9gkmcs234me5txTX5D+3J8EAutMBW8e/V8ex
         DNxpO/tLLkyL4MaP8zgnZYEf+/1cpPYygEr/eljtxZ0a4q1aIL7B1UkOSI4+91h6lRzN
         47+lz7HmlDWwyuXa3pFzcmNQVTwYSDaliBYciMOmzjdenJeBV/GnasDZGi8eV0+8HW3v
         qzBImyrKY6Q20M5D7+Kua+oRORmpWZVoUGJLb4jLw5lnxgfkClWSWXum26dWkCRNseHF
         xphcJH0zCYoE74p9vtybqlsCNYPCPY+/abyyuHHmgzBWj+BYYN1TdDZGBa741tkiT+eD
         gF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762371; x=1791367171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhIdjL5E2FCgFGQnZNNB655Rlqun+pELJaLoQUvveqk=;
        b=gqLJS9jDVNJyxEF6GGW3m2qB8fuVALwvI0ed5BzScSLybABeDRWq+O7x+gdc15k8fl
         OK3ti9cwNH9cxSolJ0V5l0JA9L551ZyIbKU4W2FrbQAYaxsiXXINu6giswm9Au8I4zo8
         RTlgFs52fIJBhCwCBLc2NVgs2yLvHpnITZuAPB/E1SWbHhHO6DuREBIlfU7ftImUFsvw
         3YvrxSLFjsyuHxqrSMSN16NxDaqqG4t+lFxW2XKNmGNgUtTQ1x2Riku4gGCOTgdk0FOa
         F+uMi3SakaSKoFEGQ33dlJnju5MOFs0+FEcWAg1fkV4OFZu9wuO1fs5i+oEnXycOeS9X
         V+Fg==
X-Gm-Message-State: AFuF++lxWHgEHAFPCvIZg+Gn7+8akofpXX38Nphriv3tzAJQiHZ14aj3
	gwUVM4DCiA1bdSkBzJ8aoMhK8DpQlz/3xkoSZdRo38wgnG/879B6ZPJ8bm7knZUh
X-Gm-Gg: AYBFou0d8NlNXodckzCgllnrlFceMiKst1ywHYls76nwL3lJpg/cvq6q/eMaoTp7paA
	LY+a2FmRHK+uEn4M0ZZApr3KEI0yS1CQuFZtorxzljIlDOAY3iRI9xOmVkkjCR0jKYFa0Z2T4iY
	JkoJhaSWR7J4rF0mxa8ugKVcn7uo38+g+ami5cmKsQGrXSOmFQO+rUJvIFJ1Y3Gp1wRfCxkfjJ4
	7yAYym5evmKC1Ybaaxk1m3Qdgpi0NUuCayoZBzyjb36fvCO6PgRlRa/bTpqDMF9Ni41PReafA66
	QLmPrxrFkMYjgNtWU7Y4/a8cXQx9WgT5Gjs4m3NqxFFqu5MyLdvOc2ntLbthazpzd4RGxqYuH5G
	YGm5HGMkk4LPzF/iGTw/Vg0wuqQ7J1PhlYtMFyVzpQ4CndBHcbLnI8TNTZ1j06nyRVSCTno9isN
	XJIXYynEAGLpHG2LCK3Hpa7262Vs+a/o4JiqEByHRKFXdwWM+/AXLafA4wVYr3ODbUZqbgZRpNQ
	aRMoHdSeh4L0chttb0GPeGHVWvM4QmELbPN+lVg7SkJ9ldRx0kflLOph55/dpOtEWrs/4pXnHVB
	aFkgo49trkYd32Dopc9wDLvl3wueeCWW+yv25smDZqApLj93I2lIhg==
X-Received: by 2002:a05:6a00:180c:b0:880:4b56:dc2b with SMTP id d2e1a72fcca58-8874b352e3dmr606994b3a.30.1790762371437;
        Wed, 30 Sep 2026 02:59:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8874d493d27sm428757b3a.18.2026.09.30.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:59:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 3/3] selftests/bpf: Add a test for objects stuck in free_by_rcu_ttrace
Date: Wed, 30 Sep 2026 09:59:20 +0000
Message-ID: <20260930095920.601738-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
References: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Delete all elements of BPF_F_NO_PREALLOC hash map in one batch. The first
free_bulk() starts RCU tasks trace GP and the rest of the elements are
freed while it's in flight. Wait for call_rcu_ttrace_in_progress to clear
in bpf_mem_cache of every cpu and check that free_by_rcu_ttrace and
waiting_for_gp_ttrace lists are empty.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_ma_ttrace.c  | 60 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_ma_ttrace.c       | 50 ++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_ma_ttrace.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_ma_ttrace.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_ma_ttrace.c b/tools/testing/selftests/bpf/prog_tests/bpf_ma_ttrace.c
new file mode 100644
index 000000000000..a1d41b109940
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_ma_ttrace.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "bpf_ma_ttrace.skel.h"
+
+#define NR_ELEMS 4096
+
+/*
+ * The first free_bulk() starts RCU tasks trace GP. The rest of the elements are
+ * deleted while it's in flight. They should be freed without further alloc or
+ * free from this map.
+ */
+void test_bpf_ma_ttrace(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_ma_ttrace *skel;
+	__u32 cnt = NR_ELEMS;
+	long *vals = NULL;
+	int *keys = NULL;
+	int i, err, fd, nr_cpus;
+
+	skel = bpf_ma_ttrace__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "nr_cpus"))
+		goto out;
+	skel->bss->nr_cpus = nr_cpus;
+
+	keys = calloc(NR_ELEMS, sizeof(*keys));
+	vals = calloc(NR_ELEMS, sizeof(*vals));
+	if (!ASSERT_OK_PTR(keys, "keys") || !ASSERT_OK_PTR(vals, "vals"))
+		goto out;
+	for (i = 0; i < NR_ELEMS; i++)
+		keys[i] = i;
+
+	fd = bpf_map__fd(skel->maps.htab);
+	err = bpf_map_update_batch(fd, keys, vals, &cnt, NULL);
+	if (!ASSERT_OK(err, "update_batch") || !ASSERT_EQ(cnt, NR_ELEMS, "update_cnt"))
+		goto out;
+	err = bpf_map_delete_batch(fd, keys, &cnt, NULL);
+	if (!ASSERT_OK(err, "delete_batch") || !ASSERT_EQ(cnt, NR_ELEMS, "delete_cnt"))
+		goto out;
+
+	/* Wait for all __free_rcu() callbacks to finish */
+	for (i = 0; i < 300; i++) {
+		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.check_ttrace), &opts);
+		if (!ASSERT_OK(err, "test_run") || !ASSERT_OK(opts.retval, "retval"))
+			goto out;
+		if (!skel->bss->in_progress)
+			break;
+		usleep(100000);
+	}
+	ASSERT_EQ(skel->bss->nr_caches, nr_cpus, "nr_caches");
+	ASSERT_EQ(skel->bss->in_progress, 0, "in_progress");
+	ASSERT_EQ(skel->bss->not_freed, 0, "not_freed");
+out:
+	free(keys);
+	free(vals);
+	bpf_ma_ttrace__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_ma_ttrace.c b/tools/testing/selftests/bpf/progs/bpf_ma_ttrace.c
new file mode 100644
index 000000000000..31b2a962e339
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_ma_ttrace.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 4096);
+	__type(key, int);
+	__type(value, long);
+} htab SEC(".maps");
+
+extern const void __per_cpu_offset __ksym;
+
+int nr_cpus;
+int nr_caches;
+int in_progress;
+int not_freed;
+
+/* Look at bpf_mem_cache of every cpu that htab allocates its elements from */
+SEC("syscall")
+int check_ttrace(void *ctx)
+{
+	struct bpf_htab *h = bpf_core_cast(&htab, struct bpf_htab);
+	unsigned long cache = (unsigned long)BPF_CORE_READ(h, ma.cache);
+	const unsigned long *offsets = &__per_cpu_offset;
+	struct bpf_mem_cache *c;
+	unsigned long off;
+	int cpu;
+
+	nr_caches = 0;
+	in_progress = 0;
+	not_freed = 0;
+	bpf_for(cpu, 0, nr_cpus) {
+		if (bpf_probe_read_kernel(&off, sizeof(off), offsets + cpu))
+			return -1;
+		c = bpf_core_cast((void *)(cache + off), struct bpf_mem_cache);
+		if (c->unit_size)
+			nr_caches++;
+		if (c->call_rcu_ttrace_in_progress.counter)
+			in_progress++;
+		if (c->free_by_rcu_ttrace.first || c->waiting_for_gp_ttrace.first)
+			not_freed++;
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

