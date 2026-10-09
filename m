Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4373AEF37
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519428; cv=none; b=NWB0AzTMUa4bP/PaL/S6W+xD3280rFLHjKlBcKRcc/8/bcqIL+bQ17KO4yzj5jwULGSYik3X8k/eQe/L/jXANUul1dWOR6L73o8gCpGRWbSUWyY2ma/rZxYQba1Sh6kDz2TALijYwmr9F6dWxn/d7b1Wd0kH+xYEPbTAYJWhb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519428; c=relaxed/simple;
	bh=ZbbFCxdWAOTqswtWkGonk/9nH3XFrthQ5f68rWvUynA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS8R8LPcZb71IAFlTvgNtUzP4btQRWUBM1yvB5FxCHfqN2AMeJwob/x53ct5r2qoRnzpITqx33OQ74nXWQKpvhiE3fCwZdz5JbCjrfZ4tDfGUzyeJsiOqENSHzzvv4wJ+cf2knVn8pHg3jOesGCZ/c/Q9nA7npb4+0zQAMj/A3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 55E553008CC21B; Thu,  8 Oct 2026 21:16:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v10 24/24] selftests/bpf: Load an exception cleanup program from a light skeleton
Date: Thu,  8 Oct 2026 21:16:51 -0700
Message-ID: <20261009041651.38562-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009041447.17092-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
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
index 7c5dffd4b861..1493c3efa599 100644
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
@@ -63,6 +64,33 @@ static int load_tracer(struct exceptions_cleanup *tgt,=
 bool fexit)
 	return err;
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
@@ -113,6 +141,9 @@ void test_exceptions_cleanup(void)
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

