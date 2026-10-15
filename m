Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7703EEAE9
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037047; cv=none; b=lTwCdoqXRoiWihIG7n+HkTgywKLbIEpLPqTu32I2xXCAFVVJq47GwOEsUU2WIQ0BOfPKbt3UGQZGRmAsLiFc0JXX4PM90lUIfKby68U0qZTYxoQmZjSLQYKQ5oeeyno+vYKQlb3p96AGyiBvM1qc+1pqYWahbVXRxlPPpy1YhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037047; c=relaxed/simple;
	bh=pZPahUcekHAXybNxNvJDPWND/tddFl4vVE55tSQvVzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhkZ/wZ3OraK+t2Etvs0vFr/P1Y9UlIseQ9ll59u9XiqLy50sTXv7KqRwnLzG1Nns9T67CO7Cm1XYww53GCUwnNve2hHMrpxdbSLJcOCkjs8kX0KBtNxkHd6Wdhu6band7MJaTIR3gg8VgPt0q1iVmYQttZuVeaLR1jgc3fOBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C95D8314995B6C; Wed, 14 Oct 2026 21:03:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 26/26] selftests/bpf: Load an exception cleanup program from a light skeleton
Date: Wed, 14 Oct 2026 21:03:56 -0700
Message-ID: <20261015040356.867513-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A light skeleton loads a program by a path of its own: its loader
program builds the attr and resolves kfunc names when it runs. Build
progs/exceptions_cleanup.c as a light skeleton too, and run the case in
which every pad runs: a table that lost records or came out at the wrong
offsets would fail to load, or run the wrong pads.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/Makefile.skel     |  2 +-
 .../bpf/prog_tests/exceptions_cleanup.c       | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/se=
lftests/bpf/Makefile.skel
index 06e297a17156..d9cbe8ac85b7 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -40,7 +40,7 @@ LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
=20
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
-	kfunc_call_test_subprog.c test_global_percpu_data.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c exceptions_cleanup.=
c
 SKEL_BLACKLIST +=3D $(LSKELS) $(LSKELS_SIGNED)
=20
 test_static_linked.skel.h-deps :=3D test_static_linked1.bpf.o test_stati=
c_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index 76fdb3355420..b8581716bbd4 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -6,6 +6,7 @@
 #include "exceptions_cleanup_fail.skel.h"
 #include "exceptions_cleanup_shapes.skel.h"
 #include "exceptions_cleanup_tracing.skel.h"
+#include "exceptions_cleanup.lskel.h"
=20
 /* foo3 unwound: every frame that has a pad ran it. */
 #define PADS_FOO3_UNWOUND \
@@ -89,6 +90,33 @@ static void test_tracing(struct exceptions_cleanup *tg=
t)
 	exceptions_cleanup_tracing__destroy(skel);
 }
=20
+static void test_light_skeleton(void)
+{
+	struct exceptions_cleanup_lskel *skel;
+	__u64 ctx =3D 0;
+	int err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in =3D &ctx,
+		    .ctx_size_in =3D sizeof(ctx),
+	);
+
+	skel =3D exceptions_cleanup_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "light open_and_load"))
+		return;
+
+	/* foo3 unwinds, so every pad runs: the whole table has to arrive. */
+	skel->bss->input =3D 101;
+	err =3D bpf_prog_test_run_opts(skel->progs.entry.prog_fd, &topts);
+	if (!ASSERT_OK(err, "run"))
+		goto out;
+	ASSERT_EQ(topts.retval, 0, "retval");
+	ASSERT_EQ(skel->bss->pads_ran, PADS_FOO3_UNWOUND | RAN_BUMP,
+		  "pads_ran");
+out:
+	exceptions_cleanup_lskel__destroy(skel);
+}
+
 void test_exceptions_cleanup(void)
 {
 	char log[8192] =3D {};
@@ -137,6 +165,9 @@ void test_exceptions_cleanup(void)
=20
 	exceptions_cleanup__destroy(skel);
=20
+	if (test__start_subtest("light_skeleton"))
+		test_light_skeleton();
+
 	RUN_TESTS(exceptions_cleanup_fail);
 	RUN_TESTS(exceptions_cleanup_shapes);
 }
--=20
2.53.0-Meta

