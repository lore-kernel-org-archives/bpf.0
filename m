Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4312A170
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426524; cv=none; b=o487Ym0BjGc1N+FcWoGVQtWdc6F2jtdy8v/jGpaMT8q1M714P+quXZUjLcKaLn3E2jMzGsfMG+tuVXayl5okUAyXDavG3ui/OFMZiNs59tBwEM0tk8MjBL7r9LwPEDM+7eZxjdlIKT6eCIR3+CCz/BJ2jYKgtVXVyb3eBcyTJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426524; c=relaxed/simple;
	bh=ReS0VdniNIrU9GDgeJigokQ02rF06djnvoUKR4sGNrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDGgmIQZuy7BS25wuymwF7QbsUe5C2c6RD+NmGJU9sU9E5UZmikOjGZjwFIEGnG7X1kXmkF+ItkT/yNF/murvXF+c+LEfLKCbe3f4fr7HYhGa/KO1IhiV+/PihyAIJaE5SCHc07I1+pOYQLPV3ChssqfBRXMpJ7qI8Yp4WBQYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C94B224E7150; Mon, 25 Mar 2024 21:15:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: Fix kprobe_multi_bench_attach test failure with LTO kernel
Date: Mon, 25 Mar 2024 21:15:18 -0700
Message-ID: <20240326041518.1199758-1-yonghong.song@linux.dev>
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

In my locally build clang LTO kernel (enabling CONFIG_LTO and
CONFIG_LTO_CLANG_THIN), kprobe_multi_bench_attach/kernel subtest
failed like:
  test_kprobe_multi_bench_attach:PASS:get_syms 0 nsec
  test_kprobe_multi_bench_attach:PASS:kprobe_multi_empty__open_and_load 0=
 nsec
  libbpf: prog 'test_kprobe_empty': failed to attach: No such process
  test_kprobe_multi_bench_attach:FAIL:bpf_program__attach_kprobe_multi_op=
ts unexpected error: -3
  #117/1   kprobe_multi_bench_attach/kernel:FAIL

There are multiple symbols in /sys/kernel/debug/tracing/available_filter_=
functions
are renamed in /proc/kallsyms due to cross file inlining. One example is =
for
  static function __access_remote_vm in mm/memory.c.
In a non-LTO kernel, we have the following call stack:
  ptrace_access_vm (global, kernel/ptrace.c)
    access_remote_vm (global, mm/memory.c)
      __access_remote_vm (static, mm/memory.c)

With LTO kernel, it is possible that access_remote_vm() is inlined by
ptrace_access_vm(). So we end up with the following call stack:
  ptrace_access_vm (global, kernel/ptrace.c)
    __access_remote_vm (static, mm/memory.c)
The compiler renames __access_remote_vm to __access_remote_vm.llvm.<hash>
to prevent potential name collision.

The kernel bpf_kprobe_multi_link_attach() and ftrace_lookup_symbols() try
to find addresses based on /proc/kallsyms, hence the current test failed
with LTO kenrel.

This patch consulted /proc/kallsyms to find the corresponding entries
for the ksym and this solved the issue.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 62 ++++++++++++++-----
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 46e28edda595..3b9059164360 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -367,15 +367,49 @@ static bool skip_entry(char *name)
 	return false;
 }
=20
+/* Do comparision by ignoring '.llvm.<hash>' suffixes. */
+static int compare_name(const char *name1, const char *name2)
+{
+	const char *res1, *res2;
+	int len1, len2;
+
+	res1 =3D strstr(name1, ".llvm.");
+	res2 =3D strstr(name2, ".llvm.");
+	len1 =3D res1 ? res1 - name1 : strlen(name1);
+	len2 =3D res2 ? res2 - name2 : strlen(name2);
+
+	if (len1 =3D=3D len2)
+		return strncmp(name1, name2, len1);
+	if (len1 < len2)
+		return strncmp(name1, name2, len1) <=3D 0 ? -1 : 1;
+	return strncmp(name1, name2, len2) >=3D 0 ? 1 : -1;
+}
+
+static int load_kallsyms_compare(const void *p1, const void *p2)
+{
+	return compare_name(((const struct ksym *)p1)->name, ((const struct ksy=
m *)p2)->name);
+}
+
+static int search_kallsyms_compare(const void *p1, const struct ksym *p2=
)
+{
+	return compare_name(p1, p2->name);
+}
+
 static int get_syms(char ***symsp, size_t *cntp, bool kernel)
 {
-	size_t cap =3D 0, cnt =3D 0, i;
-	char *name =3D NULL, **syms =3D NULL;
+	size_t cap =3D 0, cnt =3D 0;
+	char *name =3D NULL, *ksym_name, **syms =3D NULL;
 	struct hashmap *map;
+	struct ksyms *ksyms;
+	struct ksym *ks;
 	char buf[256];
 	FILE *f;
 	int err =3D 0;
=20
+	ksyms =3D load_kallsyms_custom_local(load_kallsyms_compare);
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_custom_local"))
+		return -EINVAL;
+
 	/*
 	 * The available_filter_functions contains many duplicates,
 	 * but other than that all symbols are usable in kprobe multi
@@ -408,7 +442,14 @@ static int get_syms(char ***symsp, size_t *cntp, boo=
l kernel)
 		if (skip_entry(name))
 			continue;
=20
-		err =3D hashmap__add(map, name, 0);
+		ks =3D search_kallsyms_custom_local(ksyms, name, search_kallsyms_compa=
re);
+		if (!ks) {
+			err =3D -EINVAL;
+			goto error;
+		}
+
+		ksym_name =3D ks->name;
+		err =3D hashmap__add(map, ksym_name, 0);
 		if (err =3D=3D -EEXIST) {
 			err =3D 0;
 			continue;
@@ -421,8 +462,7 @@ static int get_syms(char ***symsp, size_t *cntp, bool=
 kernel)
 		if (err)
 			goto error;
=20
-		syms[cnt++] =3D name;
-		name =3D NULL;
+		syms[cnt++] =3D ksym_name;
 	}
=20
 	*symsp =3D syms;
@@ -432,11 +472,8 @@ static int get_syms(char ***symsp, size_t *cntp, boo=
l kernel)
 	free(name);
 	fclose(f);
 	hashmap__free(map);
-	if (err) {
-		for (i =3D 0; i < cnt; i++)
-			free(syms[i]);
+	if (err)
 		free(syms);
-	}
 	return err;
 }
=20
@@ -472,7 +509,7 @@ static void test_kprobe_multi_bench_attach(bool kerne=
l)
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
 	struct kprobe_multi_empty *skel =3D NULL;
 	char **syms =3D NULL;
-	size_t cnt =3D 0, i;
+	size_t cnt =3D 0;
=20
 	if (!ASSERT_OK(get_syms(&syms, &cnt, kernel), "get_syms"))
 		return;
@@ -488,11 +525,8 @@ static void test_kprobe_multi_bench_attach(bool kern=
el)
=20
 cleanup:
 	kprobe_multi_empty__destroy(skel);
-	if (syms) {
-		for (i =3D 0; i < cnt; i++)
-			free(syms[i]);
+	if (syms)
 		free(syms);
-	}
 }
=20
 static void test_attach_override(void)
--=20
2.43.0

