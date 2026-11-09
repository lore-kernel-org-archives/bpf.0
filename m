Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248352;
	b=rOfIz/RMR2gUpTcaWmypWlvOkzZ6DYMmzTDjOyTWRB8TTrU1XD0QVZ2hp0ZNBeq0ZBHu
	 eJmQjlazgQfJHuGHqr1LCP6oy7ViL4csAWBC7S388QrTglu/1uGG69AOYBR2d9htmX2kI
	 H86GGZn8cuBpcDWiuhMiz1Vp02A7pzr4EXjghjp3Q2ZnVZyq2bd9OyQ8XHCd7Ts5jHnUB
	 IuY2ug+2N+T1TRvWOKcnjlpdLqrpLsTwA4CS7Ck+rT1QFD7DijqxZ1cAa4ksUrnhh37EK
	 YRTxJ3PF1kwBpWsKs4a+08WRdqEIzEvlXY6UzivMORCmqB9DgpKV5oOXQRUXEqf5E3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ze5Ez45dpI/3W58jQlo9WmoRmJZK5BlJaZyFSUVnITM=;
	b=MVy9IPc4dWv+FQvx51ZC9snEvuBCtV9Z2QG6AxGN/cHmbPwAjvjbwb9uQfKeBe9gZKos
	 uyq9h7YdqkDONTcsvTySl2rzjh23ElXmn3cObh8LnpxcIZS9UvZ3Q0vtsxVfDaa8/5tCB
	 Z5v/MNJnt98S/BIrw3aVCHZuoys1z7K/KimuETWvm5QvaYpdn7OIgcT2PZE/3NiJxSHvu
	 eEAddJbpCmSpqN1IouJJ2Ny/Gg+vMTHpUhLHWVaeRTva2tEb5stuUKKbZZX8m4mOneQmg
	 sPPrOeHoMGFbpvM4+D6WbdgYdybk3CHne1lvQxDTv2kDlmygzr0E8fs7e9CE5qG2BMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=GVieBLN4;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFC606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78FFC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=GVieBLN4
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed11653a91so5011175ad.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248351; x=1794853151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ze5Ez45dpI/3W58jQlo9WmoRmJZK5BlJaZyFSUVnITM=;
        b=GVieBLN4DseWsXUNvz5cLB59JFQt4b8sTRnc9+2LeEJkETlzA8CUE/yCDW22wn+Dtp
         ug0ZOc0rfmSUIw8/bY3Ac1nWmhHKsd1hCdm77SB9fUzMfcj+mWyKVm7wVEQ9eGfkz3y4
         w9Z+K3wTRlp2lMA+g4yDDVhvSqDEVoXGeTwuUjXQzLZvEPLEg3QVy7Mt54fkWxSU4KV9
         CreyeOq1dpFe0kQoLi7kV3mZAyP5bIpai32117P6Mk37dHoanJnBypZ/2w9aMG39ixAO
         d1iAlX0MLZVRYhgjTLebyXwAmwfsbnDYfovgA206F35HaLuId9CYFIe2W14ML7tbhu+h
         8cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248351; x=1794853151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ze5Ez45dpI/3W58jQlo9WmoRmJZK5BlJaZyFSUVnITM=;
        b=OgGBV1JpTxWaUysQYXpmHTPF7VL2Zq0XOIdDEAWBtMi6/pqqTQN/A9PDAlQLMk2Tar
         kjLZ7GVm+OzybtTxWmPMSU2xryYhVxyvzisPh5zadCC7UDBJ/9Kh6KgLiN60+VHD2YCG
         X0dynSvOx3H83qgBnPIuoatrmt3bqhtCGyt8lPrKuC3lYjEd2k+GBuqCS2t7VPUkYFvx
         TyQ8/PkMIFQIWbWOqZwPZ6ZE+vFmqmqdC/WPsQOxbaHaKs4O3nYeDUZR6DkGAp4gFbTi
         +zVzmD1LAADfGKcGyh+0ymUUZ/HWSujjQKz5GrYQdj+Axf7FyB1idjeOaZK2IEdDstCs
         kiSA==
X-Gm-Message-State: APuU4Z/KuQWv9u5ClscfHYYNvQ+8tL9aP8bAxcR35rwiFQ0y6sKNgf/i
	LcuzhcYq8GqMEZg72oi/QObMFlUqf6K8eSD8gU1P1j3Ywc1rLPTYIU4QwHnKkvQpWl6vvp2nwxr
	b0hFe2DE=
X-Gm-Gg: AYBFou3c7Ciddh5zfQlK9n6OOAwv7WL/5iXxZZ4eGWLPxvGfVohTAtUEeu+FJs0aRrG
	fmqHMBViuvKecIG9jHif3qJ/atOUldhyCmSwDFIEbQ6fWS4iyMlPzLesmY6aPV8ieOw4n9U4HYK
	5y71EgoBApok2Gy0rMYAKktDqltCkvSuTuKtu1V9N5ljMQoS5eqVg6TDjVNu3gZdtVPq9OplDNN
	VxDPISe8606owy0uStXqHIOju2+tH/hCJC0aLuaBBvdgVSXeIH/e0Erq2K/1gmSeOR4iiC1ThyU
	yJNXQDkLHI2kWvOAybhs0fJEIpCEAJ3lbFqf4iPBv9ZM3U0gAH04G6o59j4mBCAwG+IaRCBvzFu
	U5ckYV7UqvfvT0wEPSa8j2s9fqpqVOI8Y+pCmlZ274NAplqCo+GdOe8ucpOjAmsOjnkD6BEi32Z
	cvzo8ChMFjJfOnVQPtXmrrbHMaCdapZJmm/+6C6phl/bM91720vNQyLIZB4E5K45iZC+tordQqu
	WTljhCsUTRtfs/en0OpTBNOuS2xIPSpJgONbJFOvizqVQO3/IZopuY1aatRg3nx+wTnNY+Yesmp
	Bu6w/fx2o6F6b3HmkVkacsENmhpoHRytc3Sgna790gcFXZI6rrLKd5yv6AfQ5BWtt+AMdikzr/4
	MomLYLF4PkPPERsy/OUqbpTcUbtLHKwG2XJvqLCsX6i0XST+j
X-Received: by 2002:a17:90b:4a8d:b0:3a4:bd4e:6d15 with SMTP id 98e67ed59e1d1-3b166f9ebc9mr440133a91.34.1794248350724;
        Mon, 09 Nov 2026 10:19:10 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769b937sm481075a91.4.2026.11.09.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:19:10 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add arena fault recovery tests
Date: Mon,  9 Nov 2026 18:19:06 +0000
Message-ID: <20261109181906.7350-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109181906.7350-1-emil@etsalapatis.com>
References: <20261109181906.7350-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the arena fault handling code with two new selftests.
The first one confirms that a program without an arena (and
by extension a code path that doesn't involve BPF at all)
properly recovers after accessing an unbacked arena page.
The second test deploys the same configuration for a program
that has its own arena map.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/arena_fault.c    | 100 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fault.c |  65 ++++++++++++
 .../selftests/bpf/progs/arena_fault_noarena.c |  17 +++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  22 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   3 +
 5 files changed, 207 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault_noarena.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fault.c b/tools/testing/selftests/bpf/prog_tests/arena_fault.c
new file mode 100644
index 000000000000..8bde1f67e4b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_fault.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "arena_fault.skel.h"
+#include "arena_fault_noarena.skel.h"
+
+static int run_syscall_prog(struct bpf_program *prog, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(err, name))
+		return -1;
+	if (!ASSERT_OK(opts.retval, name))
+		return -1;
+	return 0;
+}
+
+static void test_wrong_arena(void)
+{
+	struct arena_fault *fault_skel = NULL;
+	struct arena_fault *stash_skel = NULL;
+
+	stash_skel = arena_fault__open();
+	if (!ASSERT_OK_PTR(stash_skel, "open_stash"))
+		return;
+
+	if (stash_skel->data->skip) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(arena_fault__load(stash_skel), "load_stash"))
+		goto out;
+
+	fault_skel = arena_fault__open_and_load();
+	if (!ASSERT_OK_PTR(fault_skel, "open_load_fault"))
+		goto out;
+
+	if (run_syscall_prog(stash_skel->progs.stash_and_free, "stash_and_free"))
+		goto out;
+	run_syscall_prog(fault_skel->progs.fault_stashed_wrong_arena,
+			 "fault_stashed_wrong_arena");
+
+out:
+	if (stash_skel && bpf_program__fd(stash_skel->progs.clear_stashed) >= 0)
+		run_syscall_prog(stash_skel->progs.clear_stashed, "clear_stashed");
+	arena_fault__destroy(fault_skel);
+	arena_fault__destroy(stash_skel);
+}
+
+static void test_no_arena(void)
+{
+	struct arena_fault_noarena *fault_skel = NULL;
+	struct arena_fault *stash_skel = NULL;
+
+	stash_skel = arena_fault__open();
+	if (!ASSERT_OK_PTR(stash_skel, "open_stash"))
+		return;
+
+	if (stash_skel->data->skip) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(arena_fault__load(stash_skel), "load_stash"))
+		goto out;
+
+	fault_skel = arena_fault_noarena__open_and_load();
+	if (!ASSERT_OK_PTR(fault_skel, "open_load_noarena"))
+		goto out;
+
+	if (run_syscall_prog(stash_skel->progs.stash_and_free, "stash_and_free"))
+		goto out;
+	run_syscall_prog(fault_skel->progs.fault_stashed_noarena,
+			 "fault_stashed_noarena");
+
+out:
+	if (stash_skel && bpf_program__fd(stash_skel->progs.clear_stashed) >= 0)
+		run_syscall_prog(stash_skel->progs.clear_stashed, "clear_stashed");
+	arena_fault_noarena__destroy(fault_skel);
+	arena_fault__destroy(stash_skel);
+}
+
+void serial_test_arena_fault(void)
+{
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	test__skip();
+	return;
+#endif
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("wrong_arena"))
+		test_wrong_arena();
+	if (test__start_subtest("no_arena"))
+		test_no_arena();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_fault.c b/tools/testing/selftests/bpf/progs/arena_fault.c
new file mode 100644
index 000000000000..89fde45217dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_fault.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+u64 __arena arena_pad;
+volatile u64 observed;
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+bool skip SEC(".data") = false;
+#else
+bool skip = true;
+#endif
+
+SEC("syscall")
+int stash_and_free(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 42;
+	bpf_test_arena_fault_stash((u64 *)val);
+	bpf_arena_free_pages(&arena, val, 1);
+#endif
+	return 0;
+}
+
+SEC("syscall")
+int fault_stashed_wrong_arena(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 1;
+	observed = bpf_test_arena_fault_load_stashed();
+	bpf_arena_free_pages(&arena, val, 1);
+#endif
+	return observed != 0;
+}
+
+SEC("syscall")
+int clear_stashed(void *ctx)
+{
+	bpf_test_arena_fault_clear_stashed();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_fault_noarena.c b/tools/testing/selftests/bpf/progs/arena_fault_noarena.c
new file mode 100644
index 000000000000..7bb0e6dbd260
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_fault_noarena.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+volatile u64 observed;
+
+SEC("syscall")
+int fault_stashed_noarena(void *ctx)
+{
+	observed = bpf_test_arena_fault_load_stashed();
+	return observed != 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 76fbe64755ef..f33a7345f9ce 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -344,6 +344,25 @@ __bpf_kfunc u64 bpf_kfunc_arena_mixed_test(u64 *a__arena, u64 *b__arena__nullabl
 	return *a__arena + (b__arena__nullable ? *b__arena__nullable : 0);
 }
 
+static u64 *arena_fault_stashed_ptr;
+
+__bpf_kfunc void bpf_test_arena_fault_stash(u64 *ptr__arena)
+{
+	WRITE_ONCE(arena_fault_stashed_ptr, ptr__arena);
+}
+
+__bpf_kfunc u64 bpf_test_arena_fault_load_stashed(void)
+{
+	u64 *ptr = READ_ONCE(arena_fault_stashed_ptr);
+
+	return ptr ? READ_ONCE(*ptr) : U64_MAX;
+}
+
+__bpf_kfunc void bpf_test_arena_fault_clear_stashed(void)
+{
+	WRITE_ONCE(arena_fault_stashed_ptr, NULL);
+}
+
 __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 				       struct bpf_dynptr *ptr__nullable)
 {
@@ -1048,6 +1067,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_arena_cap_nullable_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_args5_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_stack_arg_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_mixed_test)
+BTF_ID_FLAGS(func, bpf_test_arena_fault_stash)
+BTF_ID_FLAGS(func, bpf_test_arena_fault_load_stashed)
+BTF_ID_FLAGS(func, bpf_test_arena_fault_clear_stashed)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index e9902e651d72..9ec69fd57d98 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -212,6 +212,9 @@ __u64 bpf_kfunc_arena_args5_test(__u64 *a__arena, __u64 *b__arena,
 __u64 bpf_kfunc_arena_stack_arg_test(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
 				     __u64 *f__arena) __ksym;
 __u64 bpf_kfunc_arena_mixed_test(__u64 *a__arena, __u64 *b__arena__nullable) __ksym;
+void bpf_test_arena_fault_stash(__u64 *ptr__arena) __ksym;
+__u64 bpf_test_arena_fault_load_stashed(void) __ksym;
+void bpf_test_arena_fault_clear_stashed(void) __ksym;
 int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
 int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-- 
2.52.0

