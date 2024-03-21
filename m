Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB7134422
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051299; cv=none; b=sYiFcZ6K9acfXsSeGMy4hjLftZyMRhO1W6Wa1vZYlnLmBWmCfUZbTbfiWHLDUHHR9ETGK48Z8Jjji1APzoH9T3R1f5t5SJxaA95uKuAzR9nGGZAnhO+yh1bmvLNTAq1Zq6RgvM9ptX8i42rkngYj3t1FnxEAvh8PfSagE/jE0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051299; c=relaxed/simple;
	bh=lwzIDjBWH2bW/fI6EM1MkhMhVQjwWu2r+y47owZB/Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRWkb3/0Cys54B+SdpVXZcBZhDSQs+fIba5B2XRTtzecqk9V8osiOx+XVbgkuoKPeWSzDyy1LyStLegKM0n6b7AgIUJfOx/Z2kjwIwNwkctUWKfh+9Y6rz9qAL3Ivmktd6O9KtWXUwhfwZ9VnrXQD36VZkt3z19iwDb16CU4jFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4483A22190C3; Thu, 21 Mar 2024 13:01:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Add a selftest with available_filter_functions_addrs
Date: Thu, 21 Mar 2024 13:01:24 -0700
Message-ID: <20240321200124.2220345-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321200058.2218328-1-yonghong.song@linux.dev>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current kprobe_multi_bench_attach/kernel test
reads sym names from /sys/kernel/tracing/available_filter_functions.
Some names do not agree with the corresponding entries in /proc/kallsyms
since the corresponding /proc/kallsyms syms have suffix '.llvm.<hash>'.
Actually, if we pass symbol names in /proc/kallsyms,
kprobe_multi_attach will be okay.

This patch added a new subtest where addresses are retrieved from
/sys/kernel/tracing/available_filter_functions_addrs, and use the
address to consule /proc/kallsyms to get the function name.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index f6130f4f3d88..142309ced146 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -438,6 +438,102 @@ static int get_syms(char ***symsp, size_t *cntp, bo=
ol kernel)
 	return err;
 }
=20
+static int get_syms_from_addr(char ***symsp, size_t *cntp)
+{
+	char *name =3D NULL, **syms =3D NULL;
+	size_t cap =3D 0, cnt =3D 0, i;
+	struct hashmap *map;
+	struct ksym *ks;
+	char buf[256];
+	FILE *f;
+	int err =3D 0;
+	void *addr;
+
+	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+		return -EINVAL;
+	/*
+	 * The available_filter_functions contains many duplicates,
+	 * but other than that all symbols are usable in kprobe multi
+	 * interface.
+	 * Filtering out duplicates by using hashmap__add, which won't
+	 * add existing entry.
+	 */
+
+	if (access("/sys/kernel/tracing/trace", F_OK) =3D=3D 0)
+		f =3D fopen("/sys/kernel/tracing/available_filter_functions_addrs", "r=
");
+	else
+		f =3D fopen("/sys/kernel/debug/tracing/available_filter_functions_addr=
s", "r");
+
+	if (!f)
+		return -ENOENT;
+
+	map =3D hashmap__new(symbol_hash, symbol_equal, NULL);
+	if (IS_ERR(map)) {
+		err =3D libbpf_get_error(map);
+		goto error;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (strchr(buf, '['))
+			continue;
+
+		if (sscanf(buf, "%p$*[^\n]\n", &addr) !=3D 1)
+			continue;
+
+		ks =3D ksym_search((long)addr);
+		if (!ks)
+			return -EINVAL;
+
+		name =3D ks->name;
+
+		/*
+		 * We attach to almost all kernel functions and some of them
+		 * will cause 'suspicious RCU usage' when fprobe is attached
+		 * to them. Filter out the current culprits - arch_cpu_idle
+		 * default_idle and rcu_* functions.
+		 */
+		if (!strcmp(name, "arch_cpu_idle"))
+			continue;
+		if (!strcmp(name, "default_idle"))
+			continue;
+		if (!strncmp(name, "rcu_", 4))
+			continue;
+		if (!strcmp(name, "bpf_dispatcher_xdp_func"))
+			continue;
+		if (!strncmp(name, "__ftrace_invalid_address__",
+			     sizeof("__ftrace_invalid_address__") - 1))
+			continue;
+
+		err =3D hashmap__add(map, name, 0);
+		if (err =3D=3D -EEXIST) {
+			err =3D 0;
+			continue;
+		}
+		if (err)
+			goto error;
+
+		err =3D libbpf_ensure_mem((void **) &syms, &cap,
+					sizeof(*syms), cnt + 1);
+		if (err)
+			goto error;
+
+		syms[cnt++] =3D name;
+	}
+
+	*symsp =3D syms;
+	*cntp =3D cnt;
+
+error:
+	fclose(f);
+	hashmap__free(map);
+	if (err) {
+		for (i =3D 0; i < cnt; i++)
+			free(syms[i]);
+		free(syms);
+	}
+	return err;
+}
+
 static void test_kprobe_multi_bench_attach(bool kernel)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
@@ -521,6 +617,47 @@ static void test_attach_override(void)
 	kprobe_multi_override__destroy(skel);
 }
=20
+static void test_attach_kernel_addrs_to_sym(void)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct kprobe_multi_empty *skel;
+	struct bpf_link *link;
+	char **syms =3D NULL;
+	size_t cnt =3D 0;
+	int i, err;
+
+	err =3D get_syms_from_addr(&syms, &cnt);
+	if (err =3D=3D -ENOENT) {
+		test__skip();
+		return;
+	}
+	if (!ASSERT_OK(err, "get_syms_from_addr"))
+		return;
+
+	skel =3D kprobe_multi_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
+		goto cleanup;
+
+	opts.syms =3D (const char **) syms;
+	opts.cnt =3D cnt;
+
+	link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_=
empty,
+						     NULL, &opts);
+
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+
+cleanup:
+	kprobe_multi_empty__destroy(skel);
+	if (syms) {
+		for (i =3D 0; i < cnt; i++)
+			free(syms[i]);
+		free(syms);
+	}
+}
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -550,4 +687,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_override"))
 		test_attach_override();
+	if (test__start_subtest("kernel_addrs_to_sym"))
+		test_attach_kernel_addrs_to_sym();
 }
--=20
2.43.0

