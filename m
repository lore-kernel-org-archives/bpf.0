Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152318;
	b=wli+WlHcX6mvdH2HujnF7WLdTXdh9O84E277MxTc+csPB5FVWFq6O/TdTiR/ibPsw5sz
	 aZ00ODllPhcnR7G5bcwxQrQPkKrA6P8jorfsKhY9ZNAYqgkzwD0r4RLPHUG/lcXlTCq/j
	 AJ6MvqshVT67bupHytHiiEuQ9PqrofgAieYyauzNkEM0HGOiQuPu4FGYAXBwRCF205QLg
	 3jX6qpPfNu6ndP7j+PReOCn6tTJ+djHd3G+cA+aQ5pj4qC2bvAfPGVYfD62yW170iz80e
	 D630Ul6sqVkqtEFEzvEkPHDbKYv7/jfjLN5j7SUMmV6yFM2cvgfHf6khg7fozDmdEMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1EFsKWp2XtW7dMnPZN2QZWdMIX8qfnxCprGrpWZSQls=;
	b=ypmmwmbG9kz59OLlJkq0wB1zofR7tyQo/v29ioWOTBEFhUSsaWeHUyJJ/06OIwszUrtT
	 15C2bhk2e2rcj/3MBY5gpqRCCBgGNY7AgaRkiLJnBzvD2TlI/wRE5un4cRtzWUkYqAa3h
	 4/23037MaCw7NCWJslpMu2wOvDUyxf09pLuxTrojoPW25K21ImIVHP0xEQmjAYbBHtECV
	 FABmMoeLd/RQeqvr6BG2bXRjfFAscXVWiufc/kwtx6G8bG3YAnSdrNKXsDJwYld5HGpMP
	 4L654slmIz+98YOYCpVv2tYOHfG6PTZWiX2pkPwoYPioQ4GDzrvqur7np5jJuu2KysQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=s3ZeePoU;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308A606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3308A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=s3ZeePoU
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48df54150dfso266869f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793152316; x=1793757116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EFsKWp2XtW7dMnPZN2QZWdMIX8qfnxCprGrpWZSQls=;
        b=s3ZeePoUKlCG7AbkgEYatps+hlHPeBLU6qXVQpdjyykgbta4MwLjWKWQ3Q53479fYk
         0bhYCVO95MbSaaL6MgSTLHyzd4rnS9Lu/TXuwnUIrmIPW+LRfVKl+LqYj7BqVKMbpOk7
         HiO8S3G2iPNsALPCFBCQgsQ3P52yFkxaTljFsKHQt+xxEtc2zJTaU+1KIwAxkOSao7OA
         T+fnXcfzjNS/ptyxSsdK/vb1nlAyw0l6A61iNCGYmwIM/KUpeKoLcR8eHJadSpF+02cv
         fXdgsT9Kmjby/G/vr/c4iN8pvqrBSFBRZ5sq3vW0ZmVY+6Eq8SRrQ+iOSF/HQnz/2f89
         QJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152316; x=1793757116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1EFsKWp2XtW7dMnPZN2QZWdMIX8qfnxCprGrpWZSQls=;
        b=gjomIrlL442hE0uXcSUlXUqst6/1eSMWtEw9amWrrWM7mpleRbjvasUYirNlfK8zYS
         FS1uIwgaDXU4iobVlfbLZJYmvqu9B50NEhvoZ1s0XgEF/l1PX0/QYC8tlxSP5TGstlCj
         RoRQcQNMaiGAeSyc6WDZtIBY035GgkiB7zd137R89N2w9XsTF3pxOjT66wLMDOdVm97M
         Rl4/q1RHq4FtTAza6lYoUOBd5JEddE8QjCywuf3NtZNV2764wYdag9XDakIdWU558Odp
         oWebSWV1v/JqJS4QGU2ww+V7oDRIGGQBtN9NjwvXkAoRkDddN8wEGowgLAYfB6uHc0yl
         hmCA==
X-Gm-Message-State: AFq9FYKvmGh9ZFbBwujRrxhERJvSedx0a0XgicqU0ItvTkxGh08HJAX/
	3B4ylIb669tgtUjovxMc5IQNt0HmYtAEANjZHaRYH32RIZxNtngNMeGN5GPAODlrxlO3zwM5uHC
	GrrfPrz+cxQ==
X-Gm-Gg: AYBFou2IoMWHupuYhItr2xhdcZhAy2ARc79xAUkxHyG26MdgqVaRg5sANIzUaPOVuWr
	gjmzv/LQgNfUk9c54lMKiJQy5XYXvt7ofg23pD/2YvaYrLZnZKpMjnaMz/LKfHuDW370cXwvBTl
	x2kAHboZ0FG+95l9Oq8sU3ct2qcP4PvXdASwDso6Xsh7YnpLfOqc+uyblpIyOw1ES8WCEB+Ns2W
	z3DBRG042r7cldrTg7hlgkwQ43bVBHO5CPHODYbyy6Rnrj08AuKvoGERE/2njAZGCDabk02bKfF
	ouc/69AHTuowkEp2cheBoczCEvGZKNtfDhB71V8ll7Fhg1iSrLhRybK2cFOB2JHUxitpiddaAwU
	9XubMpEM+Wxp+WqVWR3NRF7PdME45+dX5Q/5EmZjqXylaQ6ajinhCglE8NGwJJyDo3cxh60yQ2m
	Z55VYoa/qp4i6EwQ0M5ZRe9za30LH1KhvSNF6wp63vDQDYtVW3KPrE+D6/OZ7eLNl0Fe5xpTdz2
	DHItN3+xZRPYa9N3hsv3aCr/FuvTl57B+YTzdb9QiCejgyRbs07H3yMR/aQpcVVQWqg/JfkSOka
	91X89GbaD0eR0jrd6m8=
X-Received: by 2002:a05:6000:606:b0:488:5852:6ee3 with SMTP id ffacd0b85a97d-48e5d5c41c9mr2168217f8f.34.1793152316507;
        Tue, 27 Oct 2026 18:51:56 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:8dfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm26852693f8f.27.2026.10.27.18.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:51:56 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 2/2] selftests/bpf: add arena fault recovery tests
Date: Wed, 28 Oct 2026 01:51:41 +0000
Message-ID: <20261028015141.10710-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028015141.10710-1-emil@etsalapatis.com>
References: <20261028015141.10710-1-emil@etsalapatis.com>
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
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/arena_fault.c    | 91 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fault.c | 55 +++++++++++
 .../selftests/bpf/progs/arena_fault_noarena.c | 17 ++++
 .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
 .../bpf/test_kmods/bpf_test_arena_fault.c     | 55 +++++++++++
 .../bpf/test_kmods/bpf_test_arena_fault.h     | 10 ++
 7 files changed, 230 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault_noarena.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1e4af62e8312..97d4a266abed 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -47,7 +47,7 @@ TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_test_arena_fault.ko
 TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fault.c b/tools/testing/selftests/bpf/prog_tests/arena_fault.c
new file mode 100644
index 000000000000..7134ece16a31
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_fault.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <testing_helpers.h>
+#include "arena_fault.skel.h"
+#include "arena_fault_noarena.skel.h"
+
+#define ARENA_FAULT_MOD "bpf_test_arena_fault"
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
+	stash_skel = arena_fault__open_and_load();
+	if (!ASSERT_OK_PTR(stash_skel, "open_load_stash"))
+		return;
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
+	if (stash_skel)
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
+	stash_skel = arena_fault__open_and_load();
+	if (!ASSERT_OK_PTR(stash_skel, "open_load_stash"))
+		return;
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
+	if (stash_skel)
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
+	if (!ASSERT_OK(load_module(ARENA_FAULT_MOD ".ko",
+				   env_verbosity > VERBOSE_NONE),
+		       "load " ARENA_FAULT_MOD ".ko"))
+		return;
+
+	if (test__start_subtest("wrong_arena"))
+		test_wrong_arena();
+	if (test__start_subtest("no_arena"))
+		test_no_arena();
+
+	unload_module(ARENA_FAULT_MOD, env_verbosity > VERBOSE_NONE);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_fault.c b/tools/testing/selftests/bpf/progs/arena_fault.c
new file mode 100644
index 000000000000..1967b128fdf6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_fault.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+#include "../test_kmods/bpf_test_arena_fault.h"
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
+SEC("syscall")
+int stash_and_free(void *ctx)
+{
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 42;
+	bpf_test_arena_fault_stash((u64 *)val);
+	bpf_arena_free_pages(&arena, val, 1);
+	return 0;
+}
+
+SEC("syscall")
+int fault_stashed_wrong_arena(void *ctx)
+{
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 1;
+	observed = bpf_test_arena_fault_load_stashed();
+	bpf_arena_free_pages(&arena, val, 1);
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
index 000000000000..7fa8814808b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_fault_noarena.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_test_arena_fault.h"
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
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 031c7454ce65..e611e71fcef1 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -19,7 +19,7 @@ Q = @
 endif
 
 MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_test_arena_fault.ko
 
 $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.c
new file mode 100644
index 000000000000..0b3dbf80344d
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/module.h>
+
+static u64 *stashed_ptr;
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc void bpf_test_arena_fault_stash(u64 *ptr__arena)
+{
+	WRITE_ONCE(stashed_ptr, ptr__arena);
+}
+
+__bpf_kfunc u64 bpf_test_arena_fault_load_stashed(void)
+{
+	u64 *ptr = READ_ONCE(stashed_ptr);
+
+	return ptr ? READ_ONCE(*ptr) : U64_MAX;
+}
+
+__bpf_kfunc void bpf_test_arena_fault_clear_stashed(void)
+{
+	WRITE_ONCE(stashed_ptr, NULL);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_test_arena_fault_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_test_arena_fault_stash)
+BTF_ID_FLAGS(func, bpf_test_arena_fault_load_stashed)
+BTF_ID_FLAGS(func, bpf_test_arena_fault_clear_stashed)
+BTF_KFUNCS_END(bpf_test_arena_fault_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_test_arena_fault_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_test_arena_fault_kfunc_ids,
+};
+
+static int __init bpf_test_arena_fault_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					 &bpf_test_arena_fault_kfunc_set);
+}
+
+static void __exit bpf_test_arena_fault_exit(void)
+{
+}
+
+module_init(bpf_test_arena_fault_init);
+module_exit(bpf_test_arena_fault_exit);
+
+MODULE_DESCRIPTION("BPF arena fault selftest module");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.h b/tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.h
new file mode 100644
index 000000000000..1657c445a0fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __BPF_TEST_ARENA_FAULT_H
+#define __BPF_TEST_ARENA_FAULT_H
+
+void bpf_test_arena_fault_stash(__u64 *ptr__arena) __ksym;
+__u64 bpf_test_arena_fault_load_stashed(void) __ksym;
+void bpf_test_arena_fault_clear_stashed(void) __ksym;
+
+#endif /* __BPF_TEST_ARENA_FAULT_H */
-- 
2.54.0

