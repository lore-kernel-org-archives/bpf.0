Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E3412BFA
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139644; cv=none; b=HazY0vGeSjniJLKkwXQMlHDWME1pM61i2yIxGcL0U3brpz4sn2ySVuxYROCglejt7lik+9nnetUGBXmHITSomSg7+xpgMVK4CQKIK9MeglPx2LeU+mUlZNXssD33ry3ymREgACDWNYeFhZvUBPRewLjXB4ZQSZtjxEkXx4ckP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139644; c=relaxed/simple;
	bh=2QHSia9+hFDSSIDIFtFp5COQhRmMOvKmOj0hzbQPAeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6xBfpXIZVHrc0SrhO/4X8118JEP7Wo5/OK0JDnzfrBqPYbtIB2AElD/WdA94oZ/A9BlngA1T16ZTiLQ9+KFBwCrCUO4z7Yh32NU22y1Zk9qOifem3fwtIV89MC15iG3EhD/GsvoWIBTZNF+G7DXMiZqkEaOtMa8ZugPoBjTddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 53D7E2C8DADF61; Tue, 22 Sep 2026 22:00:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 21/21] selftests/bpf: Load an exception cleanup program from a light skeleton
Date: Tue, 22 Sep 2026 22:00:34 -0700
Message-ID: <20260923050034.2427959-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
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
table survives that trip: one record covering the bpf_throw() call itself=
,
one pad that sets a bit and resumes. If the table arrives, the pad runs a=
nd
the cookie comes back; if it does not, the program does not load at all.

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
index 580d1d82c186..6d7518fa4018 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -33,7 +33,7 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_func=
s.skel.h		\
 LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c =
	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
-	test_ringbuf_overwrite.c
+	test_ringbuf_overwrite.c exceptions_cleanup_light.c
=20
 LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
=20
diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
index d6f63f147c4a..68f2d61a694b 100644
--- a/tools/testing/selftests/bpf/exceptions_cleanup.h
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -36,6 +36,9 @@
 #define RAN_GLOBAL_PAD		0x80000
 #define RAN_PAD_R0		0x100000
=20
+/* progs/exceptions_cleanup_light.c: the one pad it has. */
+#define RAN_LIGHT		0x1
+
 #define CLEANUP_REC(begin, end, landing_pad)			\
 	".pushsection .bpf_cleanup,\"a\",@progbits;"		\
 	".long " begin ";"					\
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index dbdb78b791e0..323ee8d72c91 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -8,6 +8,7 @@
 #include "exceptions_cleanup_freplace.skel.h"
 #include "exceptions_cleanup_pad_freplace.skel.h"
 #include "exceptions_cleanup_ext_table.skel.h"
+#include "exceptions_cleanup_light.lskel.h"
=20
 /* foo3 threw: every frame that has a pad ran it. */
 #define PADS_FOO3_THREW \
@@ -171,6 +172,30 @@ static void test_ext_table(struct exceptions_cleanup=
_shapes *skel)
 	exceptions_cleanup_ext_table__destroy(fr);
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
+	ASSERT_EQ(topts.retval, THROW_COOKIE, "retval");
+	ASSERT_EQ(skel->bss->pads_ran, RAN_LIGHT, "pads_ran");
+out:
+	exceptions_cleanup_light_lskel__destroy(skel);
+}
+
 static void test_shapes(void)
 {
 	struct exceptions_cleanup_shapes *skel;
@@ -487,6 +512,9 @@ void test_exceptions_cleanup(void)
=20
 	exceptions_cleanup__destroy(skel);
=20
+	if (test__start_subtest("light_skeleton"))
+		test_light_skeleton();
+
 	test_shapes();
=20
 	RUN_TESTS(exceptions_cleanup_fail);
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c=
 b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
new file mode 100644
index 000000000000..de7ae478d67f
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
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_unwind_resume();
+}
+
+__u64 pads_ran =3D 0;
+
+SEC("syscall")
+__naked int entry_light(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D %[cookie];"
+"1:"	"call bpf_throw;"		/* cleanup region */
+"2:"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_LIGHT),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

