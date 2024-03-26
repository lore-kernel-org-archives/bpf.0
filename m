Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8B129A83
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426673; cv=none; b=C+EspFWQHc6eU83e7PJ7KbMn64abNTlKP8kMaS4Qx+Dmlf83li/YFCHdiisYmCyQxlBForddZel4itUVNfYAtYzwElqNJjur5/aSFYPLxBZf/rlWWcVIxQz1Sllx5KXm+Xp3CMoFtAfT5gDmL+tGkHXHYJyebDkhuMX5EoWPKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426673; c=relaxed/simple;
	bh=LfmKLgVAxQqcsERLP9Q1EgRruvPuNvOP2njfdtBc6NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZN9b11BemDxq+ZdQLDa1BBISqhEr6dWSYK8rGeRMHswzg7SGzLxDv60JMNR87l4acnId/Iws/0dTd64sOl805T3Dms4oN3m8/g/ATSeD/k8XOanvXuMUvlSndma5639F7qBzlGWUz3o3SeIk+UWc8zrwgFXkBuqLNIw3gQqOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E43DA24E7180; Mon, 25 Mar 2024 21:15:23 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: Add a kprobe_multi subtest to use addrs instead of syms
Date: Mon, 25 Mar 2024 21:15:23 -0700
Message-ID: <20240326041523.1200301-1-yonghong.song@linux.dev>
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

Get addrs directly from available_filter_functions_addrs and
send to the kernel during kprobe_multi_attach. This avoids
consultation of /proc/kallsyms. But available_filter_functions_addrs
is introduced in 6.5, i.e., it is introduced recently,
so I skip the test if the kernel does not support it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 3b9059164360..51628455b6f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -477,6 +477,69 @@ static int get_syms(char ***symsp, size_t *cntp, boo=
l kernel)
 	return err;
 }
=20
+static int get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
+{
+	unsigned long *addr, *addrs, *tmp_addrs;
+	int err =3D 0, max_cnt, inc_cnt;
+	char *name =3D NULL;
+	size_t cnt =3D 0;
+	char buf[256];
+	FILE *f;
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
+	/* In my local setup, the number of entries is 50k+ so Let us initially
+	 * allocate space to hold 64k entries. If 64k is not enough, incrementa=
lly
+	 * increase 1k each time.
+	 */
+	max_cnt =3D 65536;
+	inc_cnt =3D 1024;
+	addrs =3D malloc(max_cnt * sizeof(long));
+	if (addrs =3D=3D NULL) {
+		err =3D -ENOMEM;
+		goto error;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (is_invalid_entry(buf, kernel))
+			continue;
+
+		free(name);
+		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) !=3D 2)
+			continue;
+		if (skip_entry(name))
+			continue;
+
+		if (cnt =3D=3D max_cnt) {
+			max_cnt +=3D inc_cnt;
+			tmp_addrs =3D realloc(addrs, max_cnt);
+			if (!tmp_addrs) {
+				err =3D -ENOMEM;
+				goto error;
+			}
+			addrs =3D tmp_addrs;
+		}
+
+		addrs[cnt++] =3D (unsigned long)addr;
+	}
+
+	*addrsp =3D addrs;
+	*cntp =3D cnt;
+
+error:
+	free(name);
+	fclose(f);
+	if (err)
+		free(addrs);
+	return err;
+}
+
 static void do_bench_test(struct kprobe_multi_empty *skel, struct bpf_kp=
robe_multi_opts *opts)
 {
 	long attach_start_ns, attach_end_ns;
@@ -529,6 +592,37 @@ static void test_kprobe_multi_bench_attach(bool kern=
el)
 		free(syms);
 }
=20
+static void test_kprobe_multi_bench_attach_addr(bool kernel)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct kprobe_multi_empty *skel =3D NULL;
+	unsigned long *addrs =3D NULL;
+	size_t cnt =3D 0;
+	int err;
+
+	err =3D get_addrs(&addrs, &cnt, kernel);
+	if (err =3D=3D -ENOENT) {
+		test__skip();
+		return;
+	}
+
+	if (!ASSERT_OK(err, "get_addrs"))
+		return;
+
+	skel =3D kprobe_multi_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
+		goto cleanup;
+
+	opts.addrs =3D addrs;
+	opts.cnt =3D cnt;
+
+	do_bench_test(skel, &opts);
+
+cleanup:
+	kprobe_multi_empty__destroy(skel);
+	free(addrs);
+}
+
 static void test_attach_override(void)
 {
 	struct kprobe_multi_override *skel =3D NULL;
@@ -569,6 +663,10 @@ void serial_test_kprobe_multi_bench_attach(void)
 		test_kprobe_multi_bench_attach(true);
 	if (test__start_subtest("modules"))
 		test_kprobe_multi_bench_attach(false);
+	if (test__start_subtest("kernel"))
+		test_kprobe_multi_bench_attach_addr(true);
+	if (test__start_subtest("modules"))
+		test_kprobe_multi_bench_attach_addr(false);
 }
=20
 void test_kprobe_multi_test(void)
--=20
2.43.0

