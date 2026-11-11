Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401891;
	b=Zhfx6I30MBlr7xXsHCSNXmMdH8S5qaWiUla2v5ZNWpeJy4glORwgrK7wcYjIm10r2mNV
	 L3oHmnMyLFZfSUOrbIx0+wWuZbC+15tSEkXUQCYg81m2O+iyibsEOHqsZIg8IKggq/ej8
	 /LgloLVOmhyot4cM5vSEVQOnobZl/mbD3cYmwHf3yvaatK1ALpiqATydEaOMVMkss6pLH
	 6E/M7re8ZWEaZKbhHm4pJqW697vjGFZR97q+P1KW8RhSmTQ2wPGQF1qGYESRb4HNgXaHv
	 ZUyHKkIPefQsbyBQcNl8SAgzFn2b9FhoT/MWkIC4zfKYP8jl1aEnHsdtikJ1mGh7/5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=qFRk9eL5Eu5npdw+kR4GiYXH3/e3vn1qdk2727hrjxQ=;
	b=3D/Ww//i+4/dC2Ld6EEiAr3r9fQI75gEl+Y3ahTIxyHKlci88rsnQ/oPQBUvdZsikgfL
	 kq6Fod5VTq7iG+azDdvBx3ppR85PHniWN5NOFi+96FB1Li23nqG5atQAme1j0GS1PSNeC
	 aYa2SJXf1qtPi3sdJdx6i9pIT+RQcQ4eO5f7BWWWtg/RKTj4ENnkHVeSx7Dy4m89pU7xC
	 dEGFn93LryrtgVK8PjfIJVIMWBYoagnl1eBQ7Ns1p2iui0n2GQ60E/FgzOiN0ArFoDcb7
	 wCxeLEQ+AFif+K8XO/H7XbfSlqG/1lxTTtAiHZu2SCgcsshV9jwFD5+b0rh9YDVEARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPmoGCZ3;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A58606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A58606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPmoGCZ3
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-490ca655ba2so1430537f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401889; x=1795006689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qFRk9eL5Eu5npdw+kR4GiYXH3/e3vn1qdk2727hrjxQ=;
        b=XPmoGCZ3+y0KE1B6qwZm+Gh8gGz5dQnBJ+N5arRuQMljO9++UEj6gXWwvFVvS/vT1s
         YusNwvrRkt2DIFJob6FRwUwqGjkbn89A04n/Zn1TXgjSnbBsvUM0FmzoCdp69H/Crm6v
         RGBOvVRI+YMYh3P5LT+wY4Nr8Au3JXsdbU9FpJdy9IRhaDDVeY6IGRQtE5eGl1JoNufU
         FKR+eYZTF5aIRqX5qYfCQGCyuBSjwVJS/gNFYSTO6Qyb0B3ceOrU9WKezn9U43N/Ufmc
         CceNS5JuLasrAsQ5cpuK3wT8TAjaBHMOubxU45zhtSPk6DOHzZokagy9WSqyXysHPS7t
         e5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401889; x=1795006689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFRk9eL5Eu5npdw+kR4GiYXH3/e3vn1qdk2727hrjxQ=;
        b=Ktm7tW+O8MsRyNbBOMMFJ8pGs7diZt5tIDmDolrGDKKi4gomuogUXb4CpDeOrSZIns
         DHRtUnaPR6Xgcw55lmyteB487PP18lHxN2hLKEnxXiTSiorTPS+feHM4FpVQhKVCZKTp
         fR/sS93V8J1ttYdqmHFVFYBHqaaGjmGRVmsQTomMmA7ui/jdPWjQqtuqJ7Zc17KUthva
         EQ1jUqw0QEHfNNs/0iX8IWXwG0pTtMvs3LPybUi138ft96cuF3LiB5rSA6LV4aPHte3P
         rkEKYomhJpIQd8d439nnBxI9/n9usQBn8kXmeiioW04Y9H0QBxU1ltbQNYyiq73WKFfV
         D2nQ==
X-Gm-Message-State: APuU4Z9NXbpjRhGIlNakbsfV163TsLppOGxfjmbZ8/sxlIU2HyB+wZaY
	pH+3zJbB+9J6QB84stB54TBgk7y9xTJc0S1AM+Mhp86gL0WCCD58e/QyzBuFHjlba7M=
X-Gm-Gg: AYBFou2nJ8nPpxDvecITXLvMYWzvkRZqhrvGVNWbeOlr3B4BvRRy1dxdNECY6ZYKgry
	z37d1xDlfxw+LnZcWzFAlQWi7PuxO7edC8dO6KIIozv35ivDi2tuoEWSVW/JPrpxZLcW2WDtrn8
	JioO1SDUHNeUmio6+SchWGCx143yyFamYsZlkE+eeEGbRu2EV9JwFuYmwQ4tQ9aCz7GIfwa+PkL
	s3A26J8dqIzAS0twZuf8G66bTVB0cUZRqGimG+JH5QuKdLJqjHbC6wLhdTqgdZHyKrG6IFWOJ4/
	FdpDIdJlL2tbZrX3RMl9mMRMISN8a1WDUhLF5eMUt3vmZDN48utzJei3u9r+ewY8+igtly2pd+i
	r6Unhkjipl7Mq1gk/x0mdce2l6smJTBQy40uOv4pltUh4DWX12LpHOwBPGikKoMX3tIQobzDfZO
	GMy7652EMsAfXi+g6bzHzcz30s23XFijMfXsABYqyszZH7Pcoa79gs9LYHbUU3n0Xs730Q3yOGL
	Mfufa8OpZ/t7OUXBrvgZmyNypSV8fnWCeMuEo9JZiv8+UKM/782DR4wrKFUeo6acfsqEGdNkHxh
	EQ5lZgV9L1HlUoZxum3iJzTxGpb6svKn9xpbo7R6MvBzDZcENdWmKn/njI6GkN6lgSrvzcPjZXy
	HCTXQRwrLmERn7fbOkn30lJOzykMC6PBwKwTxS/4h4NbdBQBLqT2WtZKtpDvtQg3kNLwe9wGy0y
	VGUgYq4nkgofFZCw==
X-Received: by 2002:a05:600c:6218:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4ba091a73f1mr44068045e9.0.1794401887824;
        Wed, 11 Nov 2026 04:58:07 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba476sm168139655e9.2.2026.11.11.04.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 23/29] selftests/bpf: Test resource cleanup on bpf_throw()
Date: Wed, 11 Nov 2026 13:57:21 +0100
Message-ID: <4235a68eb5ec0201b7893c6567a648b7aa2485c4.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=50315; i=memxor@gmail.com; h=from:subject:message-id; bh=8c+ZN+Peohdzam4B3PjvCSA1nyjNcvN6Fw3qCpVSDZc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzGKha3y1mcuvSPaGhuaceaairWB4PpKT6TDX/QuFc mLltz07SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJFpwQz/7Na93T47+FMr26Xr Z00VS9/tvvNM6v1iw1fxitZJyxc8lGZkuJbtf2dy/65Je33D1Q9e/b1tA8PT02X1bM85j26+/7V wIwMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add exceptions_cleanup. It runs programs that throw while holding
resources, and checks which resources the unwinder released and in which
order.

Each program records the handle of every resource it acquires. Tracing
programs attached to bpf_unwind_release() record every release during an
unwind. The test compares the two.

The programs cover:

 - the kinds of resources: local objects, ringbuf records, tasks, sockets
   and their casts, iterators, a file dynptr, spin locks, saved IRQ
   flags, RCU read and preemption disabled sections, and the referenced
   argument of a struct_ops program;
 - throws from the main program, from static and global subprogs,
   through an indirect call, and out of a recursion, with every frame
   holding resources;
 - a reference that a subprog returns to its caller;
 - registers that hold the handle at the throw only on some paths, or on
   none;
 - one releasing instruction shared by two acquisitions;
 - acquisitions that can fail and leave the slot empty;
 - the release order: locks and IRQ flags first, then sections, then a
   destructor that sleeps.

For the struct_ops program, bpf_testmod calls test_refcounted() with a
reference to current when the struct_ops is registered.

The suite runs a second time with bpf_jit_harden set, so the test is
serial.

Add verifier_frame_desc. It checks the number of hidden slots and
inserted instructions that the verifier reports for a few programs, and
that two records reserved by the same instruction and held at once are
rejected.

Both tests run on x86-64 and arm64 only. Elsewhere a program still cannot
throw while it holds resources.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/exceptions_cleanup.c       |  257 ++++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/exceptions_cleanup.c  | 1200 +++++++++++++++++
 .../selftests/bpf/progs/verifier_frame_desc.c |  200 +++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |    8 +
 5 files changed, 1667 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_frame_desc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
new file mode 100644
index 000000000000..b4213036cea7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "sysctl_helpers.h"
+
+#include "exceptions_cleanup.skel.h"
+
+/* The cookie the programs throw. */
+#define THROWN		0xeB9F
+
+/*
+ * What a run of a program has to show: its return value, the number of
+ * resources the program recorded acquiring, and the releases observed, in
+ * order, as a string: a digit names the acquired resource released at that
+ * point, 's' an RCU or preemption section, '?' any acquired resource not
+ * named elsewhere. @param is a choice the program reads.
+ */
+struct expect {
+	int retval;
+	int acquired;
+	const char *released;
+	__u32 param;
+};
+
+static void check_releases(struct exceptions_cleanup *skel, const struct expect *e)
+{
+	bool matched[ARRAY_SIZE(skel->bss->acquired)] = {};
+	int n = strlen(e->released), i, j;
+
+	ASSERT_EQ(skel->bss->acquired_cnt, e->acquired, "acquired");
+	if (!ASSERT_EQ(skel->bss->released_cnt, n, "released"))
+		return;
+	for (i = 0; i < n; i++) {
+		__u64 handle = skel->bss->released[i];
+		char c = e->released[i];
+
+		if (c == 's') {
+			ASSERT_TRUE(skel->bss->released_section[i], "section");
+			continue;
+		}
+		if (!ASSERT_FALSE(skel->bss->released_section[i], "not a section"))
+			continue;
+		if (c == '?') {
+			for (j = 0; j < e->acquired; j++)
+				if (!matched[j] && handle == skel->bss->acquired[j])
+					break;
+			if (ASSERT_LT(j, e->acquired, "released an acquired resource"))
+				matched[j] = true;
+			continue;
+		}
+		j = c - '0';
+		if (ASSERT_EQ(handle, skel->bss->acquired[j], "release order"))
+			matched[j] = true;
+	}
+}
+
+static void reset(struct exceptions_cleanup *skel, __u32 param)
+{
+	skel->bss->acquired_cnt = 0;
+	skel->bss->released_cnt = 0;
+	memset(skel->bss->acquired, 0, sizeof(skel->bss->acquired));
+	memset(skel->bss->released, 0, sizeof(skel->bss->released));
+	memset(skel->bss->released_section, 0, sizeof(skel->bss->released_section));
+	skel->bss->param = param;
+	skel->bss->test_pid = getpid();
+}
+
+/* Run @prog once and check what it returned and what was released against @e. */
+static void run_prog(struct exceptions_cleanup *skel, struct bpf_program *prog,
+		     const struct expect *e)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, ropts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	int ret;
+
+	reset(skel, e->param);
+	/* A syscall program runs on nothing: no input, and once, without a repeat count. */
+	if (bpf_program__type(prog) == BPF_PROG_TYPE_SYSCALL) {
+		ropts.data_in = NULL;
+		ropts.data_size_in = 0;
+		ropts.repeat = 0;
+	}
+	ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &ropts);
+	if (!ASSERT_OK(ret, "test_run"))
+		return;
+	ASSERT_EQ(ropts.retval, e->retval, "retval");
+	check_releases(skel, e);
+}
+
+/*
+ * Register the struct_ops whose program throws: the kernel calls it with a
+ * task reference in a __ref argument as it registers, see bpf_dummy_reg().
+ */
+static void run_struct_ops(struct exceptions_cleanup *skel, const struct expect *e)
+{
+	struct bpf_link *link;
+
+	reset(skel, e->param);
+	link = bpf_map__attach_struct_ops(skel->maps.throwing_ops);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		return;
+	check_releases(skel, e);
+	bpf_link__destroy(link);
+}
+
+/* Open a file, which runs the LSM program that throws with a file and a dynptr that reads it. */
+static void run_file(struct exceptions_cleanup *skel, const struct expect *e)
+{
+	int fd;
+
+	reset(skel, e->param);
+	skel->bss->file_armed = 1;
+	fd = open("/proc/self/exe", O_RDONLY);
+	if (!ASSERT_OK_FD(fd, "open"))
+		return;
+	close(fd);
+	ASSERT_EQ(skel->bss->file_armed, 0, "program ran");
+	check_releases(skel, e);
+}
+
+/* Run every program; @prefix names the pass in the subtest names. */
+static void run_suite(const char *prefix)
+{
+	struct exceptions_cleanup *skel;
+	int server = -1;
+	char name[64];
+
+	skel = exceptions_cleanup__open();
+	if (!ASSERT_OK_PTR(skel, "exceptions_cleanup__open"))
+		return;
+	/* registered by the subtests that run its program */
+	bpf_map__set_autoattach(skel->maps.throwing_ops, false);
+	if (!ASSERT_OK(exceptions_cleanup__load(skel), "exceptions_cleanup__load"))
+		goto out;
+	if (!ASSERT_OK(exceptions_cleanup__attach(skel), "attach"))
+		goto out;
+	/* The listener throw_sock_cast looks up, on an ephemeral port. */
+	server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_OK_FD(server, "start_server"))
+		goto out;
+	skel->bss->server_port = get_socket_local_port(server);
+
+/* Run program @pname as subtest @sname, expecting @ret, @n acquisitions and the releases @rel. */
+#define RUN_AS(pname, sname, ret, n, rel, ...) do {				\
+	struct expect e = { .retval = ret, .acquired = n, .released = rel, ##__VA_ARGS__ }; \
+										\
+	snprintf(name, sizeof(name), "%s%s", prefix, sname);			\
+	if (test__start_subtest(name))						\
+		run_prog(skel, skel->progs.pname, &e);				\
+} while (0)
+#define RUN(pname, ret, n, rel, ...) RUN_AS(pname, #pname, ret, n, rel, ##__VA_ARGS__)
+#define THROW(pname, n, rel, ...) RUN(pname, THROWN, n, rel, ##__VA_ARGS__)
+	THROW(throw_obj_reg, 1, "0");
+	THROW(throw_obj_two, 2, "??");
+	THROW(throw_ringbuf, 1, "0");
+	THROW(throw_task, 1, "0");
+	THROW(throw_sock_cast, 1, "0");
+	THROW(throw_iter, 1, "0");
+	THROW(throw_obj_maybe, 1, "0");
+	THROW(throw_obj_caller, 1, "0");
+	THROW(throw_obj_callx_caller, 1, "0");
+	THROW(throw_obj_origin_after_guard, 1, "0");
+	THROW(throw_obj_unconditional, 1, "0");
+	THROW(throw_obj_dead_caller, 1, "0");
+	THROW(throw_obj_subprog, 1, "0");
+	THROW(throw_obj_global_caller, 1, "0");
+	/* Locks and IRQ flags go first, sections next, objects last. */
+	THROW(throw_spin_lock, 2, "10");
+	THROW(throw_rcu, 1, "s0");
+	THROW(throw_irq, 1, "0s");
+	THROW(throw_obj_after_caller_lock, 2, "01");
+	THROW(throw_sleeping_dtor_after_section, 1, "s0");
+	/* References the program keeps in different places on different paths, or nowhere. */
+	THROW(throw_reg_conflict, 1, "0");
+	THROW(throw_dead_reg, 1, "0");
+	THROW(throw_lock_two_locations, 2, "01");
+	RUN_AS(throw_shared_release, "throw_shared_release_first", THROWN, 2, "1",
+	       .param = 0);
+	RUN_AS(throw_shared_release, "throw_shared_release_second", THROWN, 2, "0",
+	       .param = 1);
+	RUN_AS(throw_refcount_shared_release, "throw_refcount_shared_release_first", THROWN, 1, "0",
+	       .param = 0);
+	RUN_AS(throw_refcount_shared_release, "throw_refcount_shared_release_second", THROWN, 1, "0",
+	       .param = 1);
+	/* A callee overwrites the caller's copy of the pointer: the object is released, once. */
+	THROW(throw_callee_clobbers_slot, 1, "0");
+	/* What is released through one call or on one path and not through another. */
+	RUN_AS(throw_irq_order, "throw_irq_order_enabled_first", THROWN, 2, "10s", .param = 1);
+	RUN_AS(throw_irq_order, "throw_irq_order_enabled_last", THROWN, 2, "01", .param = 0);
+	/* A recursive subprog holding an object per frame: each frame owns its own. */
+	THROW(throw_recursion_holding, 4, "3210");
+	/* what the frames hold at call depth two */
+	RUN_AS(throw_ringbuf_depth2_split, "throw_ringbuf_depth2_split_held", THROWN, 1, "0",
+	       .param = 3);
+	RUN_AS(throw_ringbuf_depth2_split, "throw_ringbuf_depth2_split_free", THROWN, 1, "",
+	       .param = 1);
+	/* a throw reached by paths of different stack depth */
+	RUN_AS(throw_slot_unallocated, "throw_slot_unallocated_held", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_slot_unallocated, "throw_slot_unallocated_free", THROWN, 0, "", .param = 1);
+	/* a reference that may be NULL when a callee throws */
+	RUN_AS(throw_task_maybe_null, "throw_task_maybe_null_null", THROWN, 1, "", .param = 1);
+	RUN_AS(throw_task_maybe_null, "throw_task_maybe_null_held", THROWN, 1, "0", .param = 3);
+	/* a reference held as a pointer into the object */
+	RUN_AS(throw_pop_null, "throw_pop_null_popped", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_pop_null, "throw_pop_null_empty", THROWN, 0, "", .param = 1);
+	/* A spill the verifier removes is not where the unwinder looks. */
+	RUN_AS(throw_fastcall_spill, "throw_fastcall_spill_throw", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_fastcall_spill, "throw_fastcall_spill_discard", 0, 1, "", .param = 1);
+	/* A reference a subprog returns is the caller's from the call on. */
+	THROW(throw_obj_returned, 1, "0");
+	/* One call that takes the object on one path and NULL on the other. */
+	RUN_AS(throw_xchg_maybe, "throw_xchg_maybe_kept", THROWN, 1, "0", .param = 0);
+	RUN_AS(throw_xchg_maybe, "throw_xchg_maybe_given", THROWN, 1, "", .param = 1);
+	/* A file and the reader of its dynptr, which goes first. */
+	snprintf(name, sizeof(name), "%sthrow_file_dynptr_held", prefix);
+	if (test__start_subtest(name))
+		run_file(skel, &(struct expect){ .acquired = 1, .released = "s0", .param = 0 });
+	snprintf(name, sizeof(name), "%sthrow_file_dynptr_released", prefix);
+	if (test__start_subtest(name))
+		run_file(skel, &(struct expect){ .acquired = 1, .released = "", .param = 1 });
+	/* A reference the kernel passed in a __ref argument, held at the throw or released before it. */
+	snprintf(name, sizeof(name), "%sthrow_ops_ref_held", prefix);
+	if (test__start_subtest(name))
+		run_struct_ops(skel, &(struct expect){ .acquired = 1, .released = "0", .param = 0 });
+	snprintf(name, sizeof(name), "%sthrow_ops_ref_released", prefix);
+	if (test__start_subtest(name))
+		run_struct_ops(skel, &(struct expect){ .acquired = 1, .released = "", .param = 1 });
+#undef THROW
+#undef RUN
+#undef RUN_AS
+out:
+	if (server >= 0)
+		close(server);
+	exceptions_cleanup__destroy(skel);
+}
+
+/* Serial, because it sets bpf_jit_harden. */
+void serial_test_exceptions_cleanup(void)
+{
+	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
+	char old[16] = {};
+
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	/* elsewhere a program may not throw while it holds resources */
+	test__skip();
+	return;
+#endif
+	run_suite("");
+	/* Constant blinding rewrites the program, with the insns that keep the slots in it. */
+	if (sysctl_set_or_fail(harden, old, "2"))
+		return;
+	run_suite("harden_");
+	sysctl_set_or_fail(harden, NULL, old);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4d77b8fd4eab..466180400b15 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -58,6 +58,7 @@
 #include "verifier_div_const.skel.h"
 #include "verifier_div_mod_bounds.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_frame_desc.skel.h"
 #include "verifier_flow_keys.skel.h"
 #include "verifier_global_subprogs.skel.h"
 #include "verifier_global_ptr_args.skel.h"
@@ -267,6 +268,7 @@ void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_const(void)            { RUN(verifier_div_const); }
 void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_frame_desc(void)           { RUN(verifier_frame_desc); }
 void test_verifier_flow_keys(void)            { RUN(verifier_flow_keys); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
new file mode 100644
index 000000000000..af7c439c7e09
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -0,0 +1,1200 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "../test_kmods/bpf_testmod.h"
+
+#define MAX_RES 8
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+struct foo {
+	int data;
+	struct bpf_list_node node;
+};
+
+struct locked_foo {
+	int data;
+	struct bpf_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+private(A) struct bpf_spin_lock glock;
+
+/* Resources the program under test acquired, in order. */
+__u64 acquired[MAX_RES];
+__u32 acquired_cnt;
+/* The releases observed, in order: the handle of the resource, or none for a section. */
+__u64 released[MAX_RES];
+__u8 released_section[MAX_RES];
+__u32 released_cnt;
+/* The test process: the sections it leaves are the ones under test. */
+__u32 test_pid;
+/* A choice of the test, read by the program under test. */
+__u32 param;
+
+static __always_inline void mark_acquired(void *p)
+{
+	__u32 i = acquired_cnt;
+
+	if (i < MAX_RES) {
+		acquired[i] = (__u64)p;
+		acquired_cnt = i + 1;
+	}
+}
+
+/*
+ * Record a release: of @p, one of the resources the program acquired, or,
+ * as a @section, of what the program has no handle of: a section of the test
+ * process, or the reader of a file dynptr. The hooks fire for every unwind in
+ * the system, so releases of other programs are left out.
+ */
+static __always_inline void mark_released(void *p, bool section)
+{
+	__u32 i, n = released_cnt;
+
+	if (n >= MAX_RES)
+		return;
+	if (section) {
+		if (bpf_get_current_pid_tgid() >> 32 != test_pid)
+			return;
+	} else {
+		if (!p)
+			return;
+		for (i = 0; i < MAX_RES; i++)
+			if (i < acquired_cnt && acquired[i] == (__u64)p)
+				break;
+		if (i == MAX_RES)
+			return;
+	}
+	released[n] = section ? 0 : (__u64)p;
+	released_section[n] = section;
+	released_cnt = n + 1;
+}
+
+/*
+ * Observe every release the unwinder performs, identified like the program
+ * sees it: the handle is the pointer to an object or a record, the address of
+ * a stack object or of a lock; a section has none.
+ */
+SEC("fentry/bpf_unwind_release")
+int BPF_PROG(release_hook, struct bpf_resource *res, void *handle)
+{
+	mark_released(handle, res->kind == BPF_RESOURCE_RCU || res->kind == BPF_RESOURCE_PREEMPT ||
+			      res->kind == BPF_RESOURCE_DYNPTR_FILE);
+	return 0;
+}
+
+/* An object in a callee-saved register of the throwing frame. */
+SEC("tc")
+int throw_obj_reg(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_obj_drop(f);
+	return 0;
+}
+
+/* Two objects, one spilled to the stack by the compiler. */
+SEC("tc")
+int throw_obj_two(struct __sk_buff *ctx)
+{
+	struct foo *f, *g;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	g = bpf_obj_new(typeof(*g));
+	if (!g) {
+		bpf_obj_drop(f);
+		return 1;
+	}
+	mark_acquired(f);
+	mark_acquired(g);
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_obj_drop(f);
+	bpf_obj_drop(g);
+	return 0;
+}
+
+/* A ringbuf reservation. */
+SEC("tc")
+int throw_ringbuf(struct __sk_buff *ctx)
+{
+	void *p;
+
+	p = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+	if (!p)
+		return 1;
+	mark_acquired(p);
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_ringbuf_discard(p, 0);
+	return 0;
+}
+
+/* A task reference released through the destructor registry. */
+SEC("tc")
+int throw_task(struct __sk_buff *ctx)
+{
+	struct task_struct *t;
+
+	t = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!t)
+		return 1;
+	mark_acquired(t);
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_task_release(t);
+	return 0;
+}
+
+/*
+ * The task the kernel passes a struct_ops program in a __ref argument is the
+ * program's to release: the unwinder releases it when the program has not.
+ */
+SEC("struct_ops/test_refcounted")
+int BPF_PROG(throw_ops_ref, int dummy, struct task_struct *task)
+{
+	mark_acquired(task);
+	if (param)
+		bpf_task_release(task);
+	bpf_throw(0);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops throwing_ops = {
+	.test_refcounted = (void *)throw_ops_ref,
+};
+
+/* Set by the test before the open of a file that the program acts on. */
+__u32 file_armed;
+
+/*
+ * The file is a referenced object, and the dynptr holds a reader of it that
+ * the program has no handle of: the unwinder frees the reader, then puts the
+ * file.
+ */
+SEC("lsm/file_open")
+int BPF_PROG(throw_file_dynptr)
+{
+	struct bpf_dynptr dynptr;
+	struct file *file;
+
+	if (!file_armed || bpf_get_current_pid_tgid() >> 32 != test_pid)
+		return 0;
+	file_armed = 0;
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+	mark_acquired(file);
+	bpf_dynptr_from_file(file, 0, &dynptr);
+	if (param) {
+		bpf_dynptr_file_discard(&dynptr);
+		bpf_put_file(file);
+	}
+	bpf_throw(0);
+	return 0;
+}
+
+/* Port, in network order, of the listener throw_sock_cast looks up. */
+__u16 server_port;
+
+/*
+ * A socket acquired by a lookup and cast to its struct by a helper, which
+ * carries the reference under the struct's type: released as the socket.
+ */
+SEC("tc")
+int throw_sock_cast(struct __sk_buff *ctx)
+{
+	struct bpf_sock_tuple tuple = {};
+	struct bpf_sock *skc;
+	struct tcp_sock *tp;
+
+	tuple.ipv4.daddr = bpf_htonl(0x7f000001);
+	tuple.ipv4.dport = server_port;
+	skc = bpf_skc_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv4), -1, 0);
+	if (!skc)
+		return 1;
+	tp = bpf_skc_to_tcp_sock(skc);
+	if (!tp) {
+		bpf_sk_release(skc);
+		return 1;
+	}
+	mark_acquired(tp);
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_sk_release((struct bpf_sock *)tp);
+	return 0;
+}
+
+/* An open-coded iterator on the stack. */
+SEC("tc")
+int throw_iter(struct __sk_buff *ctx)
+{
+	struct bpf_iter_num it;
+	int *v;
+
+	bpf_iter_num_new(&it, 0, 10);
+	mark_acquired(&it);
+	while ((v = bpf_iter_num_next(&it))) {
+		if (*v == 3 && ctx->len)
+			bpf_throw(0xeB9F);
+	}
+	bpf_iter_num_destroy(&it);
+	return 0;
+}
+
+/* The object is NULL on one path and an object on the other at the throw. */
+SEC("tc")
+int throw_obj_maybe(struct __sk_buff *ctx)
+{
+	struct foo *f = NULL;
+
+	if (ctx->len > 1) {
+		f = bpf_obj_new(typeof(*f));
+		if (!f)
+			return 1;
+		mark_acquired(f);
+	}
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	if (f)
+		bpf_obj_drop(f);
+	return 0;
+}
+
+static __noinline int throw_in_subprog(struct __sk_buff *ctx, int x)
+{
+	/* Use callee-saved registers so the caller's are saved in this frame. */
+	__u64 a = x * 3, b = x * 5, c = x * 7;
+
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	return a + b + c;
+}
+
+/* The object is held by the caller of the throwing static subprog. */
+SEC("tc")
+int throw_obj_caller(struct __sk_buff *ctx)
+{
+	struct foo *f;
+	int ret;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	ret = throw_in_subprog(ctx, ctx->len);
+	bpf_obj_drop(f);
+	return ret;
+}
+
+/* The object is held by the caller across a call of the throwing subprog by its address. */
+SEC("tc")
+int throw_obj_callx_caller(struct __sk_buff *ctx)
+{
+	int (*callee)(struct __sk_buff *, int) = throw_in_subprog;
+	struct foo *f;
+	int ret;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	/* Hide the callee from the compiler, so that the call goes through the pointer: a callx. */
+	asm volatile ("" : "+r"(callee));
+	ret = callee(ctx, ctx->len);
+	bpf_obj_drop(f);
+	return ret;
+}
+
+/* Allocates at its first insns: the call that acquires is at the start of the subprog. */
+static __noinline int alloc_and_throw(void)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (f)
+		mark_acquired(f);
+	bpf_throw(0xeB9F);
+	return 0;
+}
+
+/* A count the verifier does not know. */
+volatile __u32 loops = 1;
+
+/*
+ * The loop gets a may_goto of the verifier's, in front of the subprog that
+ * allocates at its first insns: what the main pass named by instruction has
+ * to be told from the subprog starts as they are after that.
+ */
+SEC("tc")
+int throw_obj_origin_after_guard(struct __sk_buff *ctx)
+{
+	__u32 i;
+
+	for (i = 0; i < loops; i++)
+		;
+	return alloc_and_throw();
+}
+
+/* The throw is unconditional, so nothing after it keeps the object alive. */
+SEC("tc")
+int throw_obj_unconditional(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	bpf_throw(0xeB9F);
+	return 0;
+}
+
+static __noinline int throw_unconditionally(void)
+{
+	bpf_throw(0xeB9F);
+	return 0;
+}
+
+/*
+ * The callee's throw is unconditional, so the caller never reads the object
+ * again after the call: the object is released from the slot of the caller's
+ * frame, which the acquisition filled.
+ */
+SEC("tc")
+int throw_obj_dead_caller(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	return throw_unconditionally();
+}
+
+static __noinline int subprog_acquire_throw(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	bpf_throw(0xeB9F);
+	return 0;
+}
+
+/* The object is acquired and the throw raised in a static subprog. */
+SEC("tc")
+int throw_obj_subprog(struct __sk_buff *ctx)
+{
+	return subprog_acquire_throw(ctx) + 1;
+}
+
+__noinline int global_throw(struct __sk_buff *ctx)
+{
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	return 0;
+}
+
+/* The object is held by the caller of the throwing global subprog. */
+SEC("tc")
+int throw_obj_global_caller(struct __sk_buff *ctx)
+{
+	struct foo *f;
+	int ret;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	ret = global_throw(ctx);
+	bpf_obj_drop(f);
+	return ret;
+}
+
+/*
+ * R6 holds the ringbuf record on one path and a number on the other at the
+ * throw: the record is released from the hidden slot of the frame, which the
+ * acquisition fills and the release clears, whatever R6 holds.
+ */
+SEC("tc")
+__naked int throw_reg_conflict(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[len]);"
+	"r7 = 0;"
+	"if r6 == 0 goto 1f;"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"r6 = r0;"
+	"r7 = 1;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r7;"
+	"goto 2f;"
+	"1: r6 = 42;"
+	"2: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"if r7 == 0 goto 3f;"
+	"r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"3: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+/* bpf_throw() leaves a spin lock and a section too. */
+SEC("tc")
+int throw_spin_lock(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	mark_acquired(&glock);
+	bpf_spin_lock(&glock);
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_spin_unlock(&glock);
+	bpf_obj_drop(f);
+	return 0;
+}
+
+SEC("tc")
+int throw_rcu(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	bpf_rcu_read_lock();
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_rcu_read_unlock();
+	bpf_obj_drop(f);
+	return 0;
+}
+
+SEC("tc")
+int throw_irq(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	mark_acquired(&flags);
+	bpf_local_irq_save(&flags);
+	bpf_preempt_disable();
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_preempt_enable();
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+/*
+ * The record is read by nothing after its acquisition, and the register that
+ * held it is overwritten: the program keeps the pointer nowhere at the throw,
+ * and the record is released from the slot the acquisition filled.
+ */
+SEC("tc")
+__naked int throw_dead_reg(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/* Two elements, so that a lock of one is found through the pointer to it, not at a fixed address. */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct locked_foo);
+	__uint(max_entries, 2);
+} lock_map SEC(".maps");
+
+/*
+ * The lock of a map element is taken through the pointer in R7, which the
+ * path holding a record then moves to R9, leaving a number in R7: no
+ * register holds the pointer on both paths to the throw. The lock is
+ * released from the slot of the frame, which holds the address of the lock
+ * since the call that took it, and the record after the lock.
+ */
+SEC("tc")
+__naked int throw_lock_two_locations(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[len]);"
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r1 = %[lock_map] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 3f;"
+	"r7 = r0;"
+	"r2 = r7;"
+	"r2 += %[lock_off];"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r2;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r8 = 0;"
+	"if r6 == 0 goto 1f;"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"r8 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 8) = r0;"
+	"r2 = 2;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"1: r1 = r7;"
+	"r1 += %[lock_off];"
+	"call %[bpf_spin_lock];"
+	"r9 = 42;"
+	"if r8 == 0 goto 2f;"
+	"r9 = r7;"
+	"r7 = 42;"
+	"2: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"3: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(lock_map),
+	  __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len)),
+	  [lock_off]"i"(offsetof(struct locked_foo, lock))
+	: __clobber_all);
+}
+
+/*
+ * Two records, of which the one the test chooses is discarded at a single
+ * instruction. The paths discarding either reach the throw with the other
+ * record in its register and a dead pointer in the register of the discarded
+ * one: the frame has a slot for each record, and the discard clears the slot
+ * that holds the pointer it releases, whichever it is.
+ */
+SEC("tc")
+__naked int throw_shared_release(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r7 = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r6;"
+	"*(u64 *)(r1 + 8) = r7;"
+	"r2 = 2;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r8 = %[param] ll;"
+	"r8 = *(u32 *)(r8 + 0);"
+	"r1 = r6;"
+	"if r8 == 0 goto +1;"
+	"r1 = r7;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm_addr(param),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+struct refcounted_foo {
+	int data;
+	struct bpf_list_node node;
+	struct bpf_refcount ref;
+};
+
+/*
+ * Two references to one object, its allocation and a bpf_refcount_acquire()
+ * of it, hold the same pointer, and the one the test chooses is dropped. Each
+ * has a slot of the frame, and the two hold equal handles: the drop clears
+ * one slot holding the pointer, whichever it is, and the unwinder drops the
+ * object exactly once more.
+ */
+SEC("tc")
+int throw_refcount_shared_release(struct __sk_buff *ctx)
+{
+	struct refcounted_foo *a, *b;
+
+	a = bpf_obj_new(typeof(*a));
+	if (!a)
+		return 1;
+	b = bpf_refcount_acquire(a);
+	mark_acquired(a);
+	bpf_obj_drop(param ? a : b);
+	bpf_throw(0xeB9F);
+	return 0;
+}
+
+/* The node first, so that the pointer to it is the pointer to the object. */
+struct lfoo {
+	struct bpf_list_node node;
+	int data;
+};
+
+struct locked_list {
+	struct bpf_spin_lock lock;
+	struct bpf_list_head head __contains(lfoo, node);
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct locked_list);
+	__uint(max_entries, 1);
+} locked_list_map SEC(".maps");
+
+/* Pops a node under its caller's lock, and throws holding it. */
+static __noinline struct bpf_list_node *pop_and_throw(struct locked_list *l)
+{
+	struct bpf_list_node *n = bpf_list_pop_front(&l->head);
+
+	if (n)
+		mark_acquired(n);
+	bpf_throw(0xeB9F);
+	return n;
+}
+
+/*
+ * The callee's node was popped under the lock its caller holds. Locks are
+ * released before objects, whichever frame holds them: the unwinder unlocks
+ * the caller's lock, then drops the node.
+ */
+SEC("tc")
+int throw_obj_after_caller_lock(struct __sk_buff *ctx)
+{
+	struct bpf_list_node *n;
+	struct locked_list *l;
+	struct lfoo *f;
+	int key = 0;
+
+	l = bpf_map_lookup_elem(&locked_list_map, &key);
+	if (!l)
+		return 1;
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(&l->lock);
+	bpf_spin_lock(&l->lock);
+	bpf_list_push_back(&l->head, &f->node);
+	n = pop_and_throw(l);
+	if (n)
+		bpf_list_push_back(&l->head, n);
+	bpf_spin_unlock(&l->lock);
+	return 0;
+}
+
+/* Enters an RCU read section and throws in it. */
+static __noinline int rcu_and_throw(void)
+{
+	bpf_rcu_read_lock();
+	bpf_throw(0xeB9F);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+/*
+ * The destructor of a kmem_cache iterator sleeps, and the callee throws in an
+ * RCU read section: sections are left before objects are released, whichever
+ * frame holds them, so the iterator is destroyed outside the section. Only a
+ * sleepable program may create it: a syscall program.
+ */
+SEC("syscall")
+int throw_sleeping_dtor_after_section(void *ctx)
+{
+	struct bpf_iter_kmem_cache it;
+
+	bpf_iter_kmem_cache_new(&it);
+	mark_acquired(&it);
+	rcu_and_throw();
+	bpf_iter_kmem_cache_destroy(&it);
+	return 0;
+}
+
+/*
+ * Two paths save the same two sets of IRQ flags in opposite orders and meet at
+ * the throw, kept apart by the RCU read section one of them holds: the
+ * unwinder restores the flags saved with interrupts disabled first and the
+ * ones saved with them enabled last, whichever path ran.
+ */
+SEC("tc")
+int throw_irq_order(struct __sk_buff *ctx)
+{
+	int order = param;
+	unsigned long a, b;
+
+	mark_acquired(&a);
+	mark_acquired(&b);
+	if (order) {
+		bpf_local_irq_save(&a);
+		bpf_local_irq_save(&b);
+		bpf_rcu_read_lock();
+	} else {
+		bpf_local_irq_save(&b);
+		bpf_local_irq_save(&a);
+	}
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	if (order) {
+		bpf_rcu_read_unlock();
+		bpf_local_irq_restore(&b);
+		bpf_local_irq_restore(&a);
+	} else {
+		bpf_local_irq_restore(&a);
+		bpf_local_irq_restore(&b);
+	}
+	return 0;
+}
+
+/*
+ * Allocates, recurses while holding, and throws in the innermost frame: every
+ * frame of the subprog holds an object obtained at the same instruction, each
+ * in the slot of its own frame.
+ */
+static __noinline int alloc_recurse_throw(int n)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	mark_acquired(f);
+	if (n)
+		alloc_recurse_throw(n - 1);
+	else
+		bpf_throw(0xeB9F);
+	bpf_obj_drop(f);
+	return 0;
+}
+
+SEC("tc")
+int throw_recursion_holding(struct __sk_buff *ctx)
+{
+	return alloc_recurse_throw(3);
+}
+
+/* The object, in the stack of the frame that passes the struct to a callee. */
+struct slot_ctx {
+	struct foo *node;
+};
+
+/*
+ * Stashes the caller's object, overwrites the stack slot it came from with a
+ * number across the throw, and puts it back: the caller's stack holds no
+ * pointer to the object at the throw.
+ */
+static __noinline void clobber_slot_and_throw(struct slot_ctx *c)
+{
+	struct foo *f = c->node;
+
+	c->node = (void *)(long)param;
+	bpf_throw(0xeB9F);
+	c->node = f;
+}
+
+/*
+ * The caller keeps the object in the stack slot alone at the call, which the
+ * callee writes: the object is released from the hidden slot of the caller's
+ * frame, once, whatever the stack slot holds.
+ */
+SEC("tc")
+int throw_callee_clobbers_slot(struct __sk_buff *ctx)
+{
+	struct slot_ctx c;
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	c.node = f;
+	clobber_slot_and_throw(&c);
+	bpf_obj_drop(c.node);
+	return 0;
+}
+
+/* ---- what the frames hold at call depth two ---- */
+
+/*
+ * Reserves a record of its own and discards it before the throw when told,
+ * after it otherwise: its caller says so by a constant, and its frame holds
+ * the record at the throw through one call and not through the other.
+ */
+__used static __noinline int reserve_and_throw(const long *flag, int drop)
+{
+	void *rec;
+
+	rec = bpf_ringbuf_reserve(&ringbuf, 8, 0);
+	if (!rec)
+		return 1;
+	mark_acquired(rec);
+	if (drop)
+		bpf_ringbuf_discard(rec, 0);
+	if (*flag & 1)
+		bpf_throw(0xeB9F);
+	if (!drop)
+		bpf_ringbuf_discard(rec, 0);
+	return 0;
+}
+
+/* Two calls of reserve_and_throw() with a constant each, which clang would merge in C. */
+__naked static __noinline int call_twice(const long *flag)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r2 = *(u64 *)(r1 + 0);"
+	"r2 &= 2;"
+	"if r2 == 0 goto 1f;"
+	"r1 = r6;"
+	"r2 = 0;"
+	"call reserve_and_throw;"
+	"exit;"
+	"1: r1 = r6;"
+	"r2 = 1;"
+	"call reserve_and_throw;"
+	"exit;"
+	:
+	:
+	: __clobber_all);
+}
+
+/*
+ * The throw is at depth two, reached through either call of the frame below:
+ * the slot of the frame that throws holds the record or is empty.
+ */
+SEC("tc")
+int throw_ringbuf_depth2_split(struct __sk_buff *ctx)
+{
+	long flag = param;
+
+	return call_twice(&flag);
+}
+
+/* ---- a throw reached by paths of different stack depth ---- */
+
+/*
+ * A throw reached first by a path that never wrote fp-16, then by one that
+ * keeps the record only there: the record is in the hidden slot of the frame
+ * on the second path, and the slot is empty on the first.
+ */
+SEC("tc")
+__naked int throw_slot_unallocated(void)
+{
+	asm volatile (
+	"r6 = %[param] ll;"
+	"r6 = *(u32 *)(r6 + 0);"
+	"if r6 == 0 goto 1f;"
+	"2: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"exit;"
+	"1: r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 3f;"
+	"*(u64 *)(r10 - 16) = r0;"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"goto 2b;"
+	"3: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(param),
+	  __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/* ---- a reference that may be NULL when a callee throws ---- */
+
+static __noinline int throw_if_told(const long *flag)
+{
+	if (*flag & 1)
+		bpf_throw(0xeB9F);
+	return 0;
+}
+
+/*
+ * A call that throws between the acquisition and the NULL check: a lookup
+ * that returned NULL acquired nothing, and left the slot of the frame empty.
+ */
+SEC("tc")
+int throw_task_maybe_null(struct __sk_buff *ctx)
+{
+	long flag = param;
+	struct task_struct *t;
+
+	t = bpf_task_from_pid(param & 2 ? test_pid : -1);
+	mark_acquired(t);
+	throw_if_told(&flag);
+	if (!t)
+		return 1;
+	bpf_task_release(t);
+	return 0;
+}
+
+/* ---- a reference held as a pointer into the object ---- */
+
+private(D) struct bpf_spin_lock pop_lock;
+private(D) struct bpf_list_head pop_head __contains(foo, node);
+
+/* Pushes a fresh object into the list the pop below takes it from. */
+__used static __noinline int push_one(void)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	mark_acquired(f);
+	bpf_spin_lock(&pop_lock);
+	bpf_list_push_front(&pop_head, &f->node);
+	bpf_spin_unlock(&pop_lock);
+	return 0;
+}
+
+/*
+ * Pops a node, which points 8 bytes into its object, and keeps it in R6 on
+ * one path and a number on the other: the slot of the frame holds the object
+ * the node is in, which the throw releases. With param the list is empty and
+ * the pop returns NULL, which leaves the slot empty.
+ */
+SEC("tc")
+__naked int throw_pop_null(void)
+{
+	asm volatile (
+	"r1 = %[param] ll;"
+	"r1 = *(u32 *)(r1 + 0);"
+	"if r1 != 0 goto 1f;"
+	"call push_one;"
+	"1: r1 = %[pop_lock] ll;"
+	"call %[bpf_spin_lock];"
+	"r1 = %[pop_head] ll;"
+	"call %[bpf_list_pop_front];"
+	"r6 = r0;"
+	"r1 = %[pop_lock] ll;"
+	"call %[bpf_spin_unlock];"
+	"if r6 != 0 goto 2f;"
+	"r6 = 42;"
+	"2: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm_addr(param),
+	  __imm_addr(pop_lock),
+	  __imm_addr(pop_head),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm(bpf_list_pop_front),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/*
+ * The record is spilled around a helper the JIT inlines, a spill the verifier
+ * removes again, and sits in R6 at the throw: the unwinder takes it from the
+ * slot its frame keeps it in, not from the program's stack.
+ */
+SEC("tc")
+__naked int throw_fastcall_spill(void)
+{
+	asm volatile (
+	"r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 2f;"
+	"r1 = r0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r6 = r1;"
+	"r2 = %[acquired] ll;"
+	"*(u64 *)(r2 + 0) = r6;"
+	"r2 = %[acquired_cnt] ll;"
+	"r3 = 1;"
+	"*(u32 *)(r2 + 0) = r3;"
+	"r2 = %[param] ll;"
+	"r2 = *(u32 *)(r2 + 0);"
+	"if r2 != 0 goto 1f;"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"2: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm_addr(param),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+/* ---- a reference a subprog returns ---- */
+
+static __noinline struct foo *alloc_foo(void)
+{
+	return bpf_obj_new(struct foo);
+}
+
+/*
+ * The subprog returns the object it allocated: the call acquires it for the
+ * caller, which holds it at the throw.
+ */
+SEC("tc")
+int throw_obj_returned(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = alloc_foo();
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_obj_drop(f);
+	return 0;
+}
+
+/* ---- a call that releases on some paths only ---- */
+
+struct foo_value {
+	struct foo __kptr *f;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct foo_value);
+} foo_map SEC(".maps");
+
+/*
+ * The object goes into the map when the test says so, and NULL otherwise: the
+ * slot of the object is cleared when the call took the object, and still
+ * holds it at the throw when the call took NULL.
+ */
+SEC("tc")
+int throw_xchg_maybe(struct __sk_buff *ctx)
+{
+	struct foo_value *v;
+	struct foo *f, *old;
+
+	v = bpf_map_lookup_elem(&foo_map, &(int){0});
+	if (!v)
+		return 1;
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 1;
+	mark_acquired(f);
+	old = bpf_kptr_xchg(&v->f, param ? f : NULL);
+	if (old)
+		bpf_obj_drop(old);
+	bpf_throw(0xeB9F);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
new file mode 100644
index 000000000000..4a8280bc95cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+private(A) struct bpf_res_spin_lock rlock;
+
+/*
+ * A socket cast to its struct by a helper carries the reference of the
+ * socket a lookup acquired: the socket is in the slot the lookup filled at
+ * the throw, and the release through the cast pointer clears that slot.
+ */
+SEC("tc")
+__description("frame_desc: a throw with a socket cast to tcp_sock live")
+__arch_x86_64 __arch_arm64
+__success
+int sock_cast_at_throw(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+	struct bpf_sock *sk;
+	struct tcp_sock *tp;
+
+	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0);
+	if (!sk)
+		return 0;
+	tp = bpf_skc_to_tcp_sock(sk);
+	if (!tp) {
+		bpf_sk_release(sk);
+		return 0;
+	}
+	if (skb->len > 100)
+		bpf_throw(0);
+	bpf_sk_release((struct bpf_sock *)tp);
+	return 1;
+}
+
+/* Nothing reads the socket after the lookup: it is in the slot of the frame at the throw. */
+SEC("tc")
+__description("frame_desc: a socket read by nothing but the throw")
+__arch_x86_64 __arch_arm64
+__success
+int sock_dead_at_throw(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+	struct bpf_sock *sk;
+
+	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0);
+	if (!sk)
+		return 0;
+	bpf_throw(0);
+	return 1;
+}
+
+static __noinline int throw_unconditionally(void)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+/*
+ * The callee's throw is unconditional, so the caller never reads the socket
+ * again after the call and keeps it nowhere in its stack: the socket is in
+ * the hidden slot of the caller's frame, which the lookup filled, and the
+ * statistics line reports the slot and the insns that keep it.
+ */
+SEC("tc")
+__description("frame_desc: a socket nothing reads in the caller of a throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 2 sites 0 classes 1")
+int sock_dead_in_caller(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+	struct bpf_sock *sk;
+
+	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0);
+	if (!sk)
+		return 0;
+	return throw_unconditionally();
+}
+
+static __noinline struct bpf_sock *lookup_in_subprog(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+
+	return bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0);
+}
+
+/*
+ * The socket was acquired by a subprog that has returned: the call acquired
+ * it for the caller, whose frame holds it at the throw in the slot of the
+ * call. Nothing is unwound while the subprog holds it, so the lookup in the
+ * subprog has no slot.
+ */
+SEC("tc")
+__description("frame_desc: a socket a returned subprog acquired, held at a throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 2 sites 0 classes 1")
+int sock_dead_from_subprog(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk;
+
+	sk = lookup_in_subprog(skb);
+	if (!sk)
+		return 0;
+	return throw_unconditionally();
+}
+
+/*
+ * The throw is reached holding the lock, or without it when the lock failed:
+ * the address of the lock goes into the slot of the call in front of it, the
+ * slot is cleared again when the call did not return 0, and the unlock clears
+ * the slot. The statistics line reports the slot and the insns that keep it.
+ */
+SEC("tc")
+__description("frame_desc: a resilient lock that fails leaves its slot empty")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 1 insns 7 sites 0 classes 1")
+int res_lock_fails_leaves_slot_empty(struct __sk_buff *skb)
+{
+	int ret;
+
+	ret = bpf_res_spin_lock(&rlock);
+	if (skb->len > 100)
+		bpf_throw(0);
+	if (!ret)
+		bpf_res_spin_unlock(&rlock);
+	return ret;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+/* Discards the record in R1. */
+__naked __noinline __used
+static long discard_record(void)
+{
+	asm volatile (
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_discard)
+	: __clobber_all);
+}
+
+/*
+ * A loop the verifier walks reserves a record at one insn on each of two
+ * iterations, the first kept in R7 and the second spilled: the call has one
+ * slot in the frame, which cannot hold both records.
+ */
+SEC("tc")
+__description("frame_desc: two records reserved at one insn are held at once")
+__arch_x86_64 __arch_arm64
+__failure __msg("a frame holds two resources of insn 6 at once")
+__naked int release_one_of_several(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r6 = 0;"
+	"1: r1 = %[ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 5f;"
+	"if r7 != 0 goto 2f;"
+	"r7 = r0;"
+	"goto 3f;"
+	"2: *(u64 *)(r10 - 8) = r0;"
+	"3: r6 += 1;"
+	"if r6 < 2 goto 1b;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 4f;"
+	"r1 = r7;"
+	"call discard_record;"
+	"4: r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"5: if r7 == 0 goto 6f;"
+	"r1 = r7;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"6: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_get_prandom_u32),
+	  __imm(bpf_throw)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index db1a7073aee3..85ca4e8b5983 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -2093,6 +2093,14 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 		ops->test_2(4, ops->data);
 	if (ops->test_trampoline_stack_args)
 		ops->test_trampoline_stack_args(1, 2, 3, 4, 5, 6, 7, 8, 9999);
+	/*
+	 * The program releases the task, or the unwinder does when it throws:
+	 * with bpf_task_release(), which puts what bpf_task_acquire() gets.
+	 */
+	if (ops->test_refcounted) {
+		refcount_inc(&current->rcu_users);
+		ops->test_refcounted(0, current);
+	}
 
 	return 0;
 }
-- 
2.53.0

