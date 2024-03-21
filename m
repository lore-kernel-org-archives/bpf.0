Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06F13443B
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051292; cv=none; b=MW3Z/k4Hrac9peR1Eoxb07mVRewDpz9uUKXFHD3XJeJFL2J11YsIR62k3xC4x1mKsuFpFZeCYo2MYP7YqCMF89Lm/QaBkd6WHiZuKdisFPCdnzsXqNqdAGSd3ABofhTwT3Yw45uBcGLgGmmjTry1Vs/xqhCejHPjhPNVCh+OslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051292; c=relaxed/simple;
	bh=I8cHHkO582AlMXZEe/J+OllEfpdNGNHr16UWvH57zzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM4SmoELvFykJFQZYp2Ada79vWOZGiboxXNo1+HGGxsEatA2VzMKJ3YL9EJZmbhR2DvYN3iNOxVDO1S1ySZn+eTNJXpu+r8cn6OeyY0NgjA3zLDoonqzePJsTOH8m11TDsrxK3Lff7gQFnLXqhcaLm+AApmLvnBis6oUvA6YEGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2A4852219097; Thu, 21 Mar 2024 13:01:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Fix kprobe_multi_bench_attach test failure with LTO kernel
Date: Thu, 21 Mar 2024 13:01:19 -0700
Message-ID: <20240321200119.2220027-1-yonghong.song@linux.dev>
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

This patch removed __access_remote_vm and other similar functions from
kprobe_multi_attach by checking if the symbol like __access_remote_vm
does not exist in kallsyms with LTO kernel. The test succeeded after this=
 change:
  #117/1   kprobe_multi_bench_attach/kernel:OK

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/kprobe_multi_test.c     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 05000810e28e..f6130f4f3d88 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -345,6 +345,9 @@ static int get_syms(char ***symsp, size_t *cntp, bool=
 kernel)
 	FILE *f;
 	int err =3D 0;
=20
+	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+		return -EINVAL;
+
 	/*
 	 * The available_filter_functions contains many duplicates,
 	 * but other than that all symbols are usable in kprobe multi
@@ -393,6 +396,15 @@ static int get_syms(char ***symsp, size_t *cntp, boo=
l kernel)
 		if (!strncmp(name, "__ftrace_invalid_address__",
 			     sizeof("__ftrace_invalid_address__") - 1))
 			continue;
+		/*
+		 * In certain cases, e.g., clang lto kernel, the 'name' here
+		 * may be different from the one in /proc/kallsyms due to
+		 * /proc/kallsyms name might be "<name>.llvm.<hash>" instead
+		 * of "<name>". Exclude these 'name's since they will cause
+		 * later kprobe_multi_attach failure.
+		 */
+		if (ksym_get_addr(name) =3D=3D 0)
+			continue;
=20
 		err =3D hashmap__add(map, name, 0);
 		if (err =3D=3D -EEXIST) {
--=20
2.43.0

