Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C6129E62
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426518; cv=none; b=mZn+8ldlYHeXJoZqzuJieuEHEkU6/dGjhTlAyoWx2hCAmg4Fky4mTgUuQpfoj14COewT0+Dg4DdbVoCw8xQo8TOEUPWWR2b/CyDlHNImgUNb0S9QbRvhISk0VXErroj08yF6UqZW/hAhEsWIc0ioF31RC/aNSVQRCEIjNjtsJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426518; c=relaxed/simple;
	bh=pzKJRZwm/JMlwtvmNQNMHIvEArg46gHOinusFNFmd9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+gJJc3JFHWK0X6Uglw/tG5/ieuAFZD3uwOSpWb7ea+dTzT/RZypCKscVQwwUPQ4qVtS7W5s2hkLguQVRH2K96FAH799BIca9ndqDaVjOP2QNlWPBWPY6tKs1BkBDlVhA0zOpFxSgkFX7SmUXh9mL2VseobsQIvbUQphQjcTNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 753F524E70FB; Mon, 25 Mar 2024 21:15:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 4/8] selftests/bpf: Refactor some functions for kprobe_multi_test
Date: Mon, 25 Mar 2024 21:15:03 -0700
Message-ID: <20240326041503.1198982-1-yonghong.song@linux.dev>
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

Refactor some functions in kprobe_multi_test.c to extract
some helper functions who will be used in later patches
to avoid code duplication.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 94 +++++++++++--------
 1 file changed, 57 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 05000810e28e..46e28edda595 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -336,6 +336,37 @@ static bool symbol_equal(long key1, long key2, void =
*ctx __maybe_unused)
 	return strcmp((const char *) key1, (const char *) key2) =3D=3D 0;
 }
=20
+static bool is_invalid_entry(char *buf, bool kernel)
+{
+	if (kernel && strchr(buf, '['))
+		return true;
+	if (!kernel && !strchr(buf, '['))
+		return true;
+	return false;
+}
+
+static bool skip_entry(char *name)
+{
+	/*
+	 * We attach to almost all kernel functions and some of them
+	 * will cause 'suspicious RCU usage' when fprobe is attached
+	 * to them. Filter out the current culprits - arch_cpu_idle
+	 * default_idle and rcu_* functions.
+	 */
+	if (!strcmp(name, "arch_cpu_idle"))
+		return true;
+	if (!strcmp(name, "default_idle"))
+		return true;
+	if (!strncmp(name, "rcu_", 4))
+		return true;
+	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
+		return true;
+	if (!strncmp(name, "__ftrace_invalid_address__",
+		     sizeof("__ftrace_invalid_address__") - 1))
+		return true;
+	return false;
+}
+
 static int get_syms(char ***symsp, size_t *cntp, bool kernel)
 {
 	size_t cap =3D 0, cnt =3D 0, i;
@@ -368,30 +399,13 @@ static int get_syms(char ***symsp, size_t *cntp, bo=
ol kernel)
 	}
=20
 	while (fgets(buf, sizeof(buf), f)) {
-		if (kernel && strchr(buf, '['))
-			continue;
-		if (!kernel && !strchr(buf, '['))
+		if (is_invalid_entry(buf, kernel))
 			continue;
=20
 		free(name);
 		if (sscanf(buf, "%ms$*[^\n]\n", &name) !=3D 1)
 			continue;
-		/*
-		 * We attach to almost all kernel functions and some of them
-		 * will cause 'suspicious RCU usage' when fprobe is attached
-		 * to them. Filter out the current culprits - arch_cpu_idle
-		 * default_idle and rcu_* functions.
-		 */
-		if (!strcmp(name, "arch_cpu_idle"))
-			continue;
-		if (!strcmp(name, "default_idle"))
-			continue;
-		if (!strncmp(name, "rcu_", 4))
-			continue;
-		if (!strcmp(name, "bpf_dispatcher_xdp_func"))
-			continue;
-		if (!strncmp(name, "__ftrace_invalid_address__",
-			     sizeof("__ftrace_invalid_address__") - 1))
+		if (skip_entry(name))
 			continue;
=20
 		err =3D hashmap__add(map, name, 0);
@@ -426,34 +440,20 @@ static int get_syms(char ***symsp, size_t *cntp, bo=
ol kernel)
 	return err;
 }
=20
-static void test_kprobe_multi_bench_attach(bool kernel)
+static void do_bench_test(struct kprobe_multi_empty *skel, struct bpf_kp=
robe_multi_opts *opts)
 {
-	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
-	struct kprobe_multi_empty *skel =3D NULL;
 	long attach_start_ns, attach_end_ns;
 	long detach_start_ns, detach_end_ns;
 	double attach_delta, detach_delta;
 	struct bpf_link *link =3D NULL;
-	char **syms =3D NULL;
-	size_t cnt =3D 0, i;
-
-	if (!ASSERT_OK(get_syms(&syms, &cnt, kernel), "get_syms"))
-		return;
-
-	skel =3D kprobe_multi_empty__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
-		goto cleanup;
-
-	opts.syms =3D (const char **) syms;
-	opts.cnt =3D cnt;
=20
 	attach_start_ns =3D get_time_ns();
 	link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_=
empty,
-						     NULL, &opts);
+						     NULL, opts);
 	attach_end_ns =3D get_time_ns();
=20
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
-		goto cleanup;
+		return;
=20
 	detach_start_ns =3D get_time_ns();
 	bpf_link__destroy(link);
@@ -462,9 +462,29 @@ static void test_kprobe_multi_bench_attach(bool kern=
el)
 	attach_delta =3D (attach_end_ns - attach_start_ns) / 1000000000.0;
 	detach_delta =3D (detach_end_ns - detach_start_ns) / 1000000000.0;
=20
-	printf("%s: found %lu functions\n", __func__, cnt);
+	printf("%s: found %lu functions\n", __func__, opts->cnt);
 	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
 	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
+}
+
+static void test_kprobe_multi_bench_attach(bool kernel)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct kprobe_multi_empty *skel =3D NULL;
+	char **syms =3D NULL;
+	size_t cnt =3D 0, i;
+
+	if (!ASSERT_OK(get_syms(&syms, &cnt, kernel), "get_syms"))
+		return;
+
+	skel =3D kprobe_multi_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
+		goto cleanup;
+
+	opts.syms =3D (const char **) syms;
+	opts.cnt =3D cnt;
+
+	do_bench_test(skel, &opts);
=20
 cleanup:
 	kprobe_multi_empty__destroy(skel);
--=20
2.43.0

