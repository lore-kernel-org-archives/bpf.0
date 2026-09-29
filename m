Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730630EF9A
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641090; cv=none; b=A2USbPPBmlbJeoh9Yru190zQS8WDUO6iQCilrMaqDjRY88ABiajviJDcOAu+hka3i0tl6JCKB/vivXN29SRhjLqEEcRq7Mtp7yOMf/B2oQEReiJn8atk2Kowxza/ActRePxDbhtD4B73iqkzE9dyx1U7Kex3DRBPCuGYVGAc8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641090; c=relaxed/simple;
	bh=y/9JHQGbbicI8zgewkOK6/UdQpxtGUxM4eIPn+xHYnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTWpk7cETxU2uuz4B9Z3B69vSsWvr5uKi71aV8sdU+dUe1hhZJpXQBmuHx3pj5A5zyBsDiYXh4ajODG0STgmfOLwi2SgMmtPRsiJDPCsnw3+6cvQWjlgm5e8U16dGx4jSydogCdrqpkIAYIzIQ8yoWurO/IHn6oUJ2QpUKdkbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 30C172DE076A7F; Mon, 28 Sep 2026 17:17:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 22/22] selftests/bpf: Load an exception cleanup program from a light skeleton
Date: Mon, 28 Sep 2026 17:17:57 -0700
Message-ID: <20260929001757.3256926-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For a light skeleton, libbpf hands the records to bpf_gen__prog_load(),
which writes them into a blob and emits a loader program that issues
BPF_PROG_LOAD from inside the kernel. Nothing about that is shared with t=
he
ordinary path: the attr is built field by field, and the kfunc names are
resolved by the loader program when it runs.

exceptions_cleanup_light.c is the smallest program that can tell whether =
a
table survives that trip: one record covering the bpf_unwind() call itsel=
f,
one pad that sets a bit and resumes. If the table arrives, the pad runs a=
nd
sets its bit; if it does not, the program does not load at all, because t=
he
pad is then reachable from nothing.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/Makefile.skel     |  2 +-
 .../selftests/bpf/exceptions_cleanup.h        |  3 ++
 .../bpf/prog_tests/exceptions_cleanup.c       | 28 +++++++++++++
 .../bpf/progs/exceptions_cleanup_light.c      | 39 +++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
light.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/se=
lftests/bpf/Makefile.skel
index 2e22bb901bf3..41575e180efb 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -33,7 +33,7 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_func=
s.skel.h		\
 LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c =
	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
-	test_ringbuf_overwrite.c callx_rodata.c
+	test_ringbuf_overwrite.c callx_rodata.c exceptions_cleanup_light.c
=20
 LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
=20
diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
index 616b479238c7..f3dac2048f06 100644
--- a/tools/testing/selftests/bpf/exceptions_cleanup.h
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -22,6 +22,9 @@
 #define RAN_CALLX		0x100
 #define RAN_HELD_REF		0x200
=20
+/* progs/exceptions_cleanup_light.c: the one pad it has. */
+#define RAN_LIGHT		0x1
+
 #define CLEANUP_REC(begin, end, landing_pad)			\
 	".pushsection .bpf_cleanup,\"a\",@progbits;"		\
 	".long " begin ";"					\
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index c06ec10359b9..d251148279bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -5,6 +5,7 @@
 #include "exceptions_cleanup.skel.h"
 #include "exceptions_cleanup_fail.skel.h"
 #include "exceptions_cleanup_shapes.skel.h"
+#include "exceptions_cleanup_light.lskel.h"
=20
 /* foo3 unwound: every frame that has a pad ran it. */
 #define PADS_FOO3_UNWOUND \
@@ -37,6 +38,30 @@ static void run(struct exceptions_cleanup *skel, __u64=
 input, __u32 retval,
 	ASSERT_EQ(skel->bss->pads_ran, pads | RAN_BUMP, "pads_ran");
 }
=20
+static void test_light_skeleton(void)
+{
+	struct exceptions_cleanup_light_lskel *skel;
+	__u64 ctx =3D 0;
+	int err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in =3D &ctx,
+		    .ctx_size_in =3D sizeof(ctx),
+	);
+
+	skel =3D exceptions_cleanup_light_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "light open_and_load"))
+		return;
+
+	err =3D bpf_prog_test_run_opts(skel->progs.entry_light.prog_fd, &topts)=
;
+	if (!ASSERT_OK(err, "run"))
+		goto out;
+	ASSERT_EQ(topts.retval, 0, "retval");
+	ASSERT_EQ(skel->bss->pads_ran, RAN_LIGHT, "pads_ran");
+out:
+	exceptions_cleanup_light_lskel__destroy(skel);
+}
+
 void test_exceptions_cleanup(void)
 {
 	char log[8192] =3D {};
@@ -82,6 +107,9 @@ void test_exceptions_cleanup(void)
=20
 	exceptions_cleanup__destroy(skel);
=20
+	if (test__start_subtest("light_skeleton"))
+		test_light_skeleton();
+
 	RUN_TESTS(exceptions_cleanup_fail);
 	RUN_TESTS(exceptions_cleanup_shapes);
 }
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c=
 b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
new file mode 100644
index 000000000000..19d53569bbda
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "exceptions_cleanup.h"
+
+static __used __noinline void __kfunc_btf_anchor(void)
+{
+	bpf_throw(0);
+	bpf_unwind();
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_unwind_resume(NULL);
+}
+
+__u64 pads_ran =3D 0;
+
+SEC("syscall")
+__naked int entry_light(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_LIGHT),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

