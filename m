Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF2129E8A
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426504; cv=none; b=j2pD8JsHTvMDGwQHTnWsTkqMwHPKVkRYsSl9qAm2DXjCLUBDaJTbkz9gkdASfq17JCrl7uaCgcHBGLFXhLxYf4ILALfwFPuoF2P/tpAQE+rEws1vc6cTZ166GETrwayCIkN8z6zQv32/R8pFfRFkLT7RZig7Ob1iBRdaUYmKEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426504; c=relaxed/simple;
	bh=1/rwWLeTDkjr8fRQ5zQgVOA5bCsV15rmjBhxl0Z9koA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1jtqTBsRV+kUxsBpZegCsDoNWXHndcGZ+EcSHA+D4DCtCTK3bXUtf5svbWOoPLr9uvqWfeGWlwnfeeV0krAbf2JvUr/nN5DKexos+ntwQLc8bimXs7ZX6KmWzckBlOBelKaSGJm5Jn8ZIu8+7li76PYj3aR5gvn3wSF3fO5ST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2D1AC24E7089; Mon, 25 Mar 2024 21:14:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
Date: Mon, 25 Mar 2024 21:14:48 -0700
Message-ID: <20240326041448.1197812-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326041443.1197498-1-yonghong.song@linux.dev>
References: <20240326041443.1197498-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace CHECK with ASSERT macros for ksyms tests.
This test failed earlier with clang lto kernel, but the
issue is gone with latest code base. But replacing
CHECK with ASSERT still improves code as ASSERT is
preferred in selftests.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/ksyms.c  | 30 +++++++------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksyms.c
index b295969b263b..dc7aab532fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -5,8 +5,6 @@
 #include "test_ksyms.skel.h"
 #include <sys/stat.h>
=20
-static int duration;
-
 void test_ksyms(void)
 {
 	const char *btf_path =3D "/sys/kernel/btf/vmlinux";
@@ -18,43 +16,37 @@ void test_ksyms(void)
 	int err;
=20
 	err =3D kallsyms_find("bpf_link_fops", &link_fops_addr);
-	if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: %d\n",=
 errno))
+	if (!ASSERT_NEQ(err, -EINVAL, "bpf_link_fops: kallsyms_fopen"))
 		return;
-	if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'bpf_link_fops' not =
found\n"))
+	if (!ASSERT_NEQ(err, -ENOENT, "bpf_link_fops: ksym_find"))
 		return;
=20
 	err =3D kallsyms_find("__per_cpu_start", &per_cpu_start_addr);
-	if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: %d\n",=
 errno))
+	if (!ASSERT_NEQ(err, -EINVAL, "__per_cpu_start: kallsyms_fopen"))
 		return;
-	if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'per_cpu_start' not =
found\n"))
+	if (!ASSERT_NEQ(err, -ENOENT, "__per_cpu_start: ksym_find"))
 		return;
=20
-	if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
+	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
 		return;
 	btf_size =3D st.st_size;
=20
 	skel =3D test_ksyms__open_and_load();
-	if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "test_ksyms__open_and_load"))
 		return;
=20
 	err =3D test_ksyms__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "test_ksyms__attach"))
 		goto cleanup;
=20
 	/* trigger tracepoint */
 	usleep(1);
=20
 	data =3D skel->data;
-	CHECK(data->out__bpf_link_fops !=3D link_fops_addr, "bpf_link_fops",
-	      "got 0x%llx, exp 0x%llx\n",
-	      data->out__bpf_link_fops, link_fops_addr);
-	CHECK(data->out__bpf_link_fops1 !=3D 0, "bpf_link_fops1",
-	      "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0);
-	CHECK(data->out__btf_size !=3D btf_size, "btf_size",
-	      "got %llu, exp %llu\n", data->out__btf_size, btf_size);
-	CHECK(data->out__per_cpu_start !=3D per_cpu_start_addr, "__per_cpu_star=
t",
-	      "got %llu, exp %llu\n", data->out__per_cpu_start,
-	      per_cpu_start_addr);
+	ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_fops");
+	ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
+	ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
+	ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cpu_star=
t");
=20
 cleanup:
 	test_ksyms__destroy(skel);
--=20
2.43.0

