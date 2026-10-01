Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B34BE442
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861531; cv=none; b=JDXRdx1E7qe4MuU6FK/bCQPu9qhDY+Gg0MMBuhhaN1r4nGK8yO42z9jGXuBXWfvPDuqvc/gwaZj0rOjieFTIwoMcrBontaXRbSbkB7GjRI7gaUY6FEI4JCKOiF5tu8LnZosA6Gi2SGeWRd0Fbgu3mKTQi59TXq9q40G5Uy4htm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861531; c=relaxed/simple;
	bh=NiyrcRi1C7cZO/SXIeOC/pDghuLKf/UvDyuzph4dvFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QirCqu23VgoFqgUObsXogqU5952Ilo2TXf3Lk/nrHemMyf9V5i6njgzl4DypB871hfvkSusDMzcpxwirFzqYWYJjnhksmZU1tByT07JU3KeTcAwTPEpzfVbbjlMcuyGjd1NN2mZK6hbdZAkKsUHPLHob5V8uKXh/D5I0v3r22qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 86C9B2E6E12BEE; Thu,  1 Oct 2026 06:32:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 22/22] selftests/bpf: Load an exception cleanup program from a light skeleton
Date: Thu,  1 Oct 2026 06:32:01 -0700
Message-ID: <20261001133201.1347206-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001133006.1335369-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
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

So build progs/exceptions_cleanup.c as a light skeleton too, and run
the case where foo3 unwinds through it, which runs every pad. Its table
has several records, all inside subprograms: a table that loses some, or
lays them out at the wrong stride, does not load, and one whose offsets
come out wrong runs the wrong pads, which pads_ran shows.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/Makefile.skel     |  2 +-
 .../bpf/prog_tests/exceptions_cleanup.c       | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/se=
lftests/bpf/Makefile.skel
index 2e22bb901bf3..76cd4561dd7a 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -39,7 +39,7 @@ LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
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
index c06ec10359b9..bb2bb8976fd9 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -5,6 +5,7 @@
 #include "exceptions_cleanup.skel.h"
 #include "exceptions_cleanup_fail.skel.h"
 #include "exceptions_cleanup_shapes.skel.h"
+#include "exceptions_cleanup.lskel.h"
=20
 /* foo3 unwound: every frame that has a pad ran it. */
 #define PADS_FOO3_UNWOUND \
@@ -37,6 +38,33 @@ static void run(struct exceptions_cleanup *skel, __u64=
 input, __u32 retval,
 	ASSERT_EQ(skel->bss->pads_ran, pads | RAN_BUMP, "pads_ran");
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
@@ -82,6 +110,9 @@ void test_exceptions_cleanup(void)
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

