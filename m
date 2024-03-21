Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DD134422
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051289; cv=none; b=Vc2VTOCw8lG3KtbtRBDcg0J91lnGaD65d3N0NPQyvcwMmGaCVzElg4HwWYNJvOkmuqaL8LUMAgLhfJqyw0LgQ8D9554fvF+g+bZyiMivRPx1bRCcdzS+rGcnEGvKMqaxKMmRlkya0LQfKL5n3+O9R8kdot4vdvP7Wf7SlEuzhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051289; c=relaxed/simple;
	bh=q8NPCLOPfVlm2bsd4mI05T7XTDGqlOt8r7v23lwuuxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr1MUqNJlKNw+m/FP3IQQVufrTi4CCGwXP5eKs3Ep8VCKRAV1LXWb/9g+XslNoQgti98pj/Agd5sGsZzwCBaMQ55Li0vv77dfd6FwNOyIS4FygK1VQdVwUiat207GyunxmHq9oSnb7c4caNuwzsJzTHGvLTewUHpBTmOtSeuFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 10FFB2219081; Thu, 21 Mar 2024 13:01:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 3/5] libbpf: Handle <orig_name>.llvm.<hash> symbol properly
Date: Thu, 21 Mar 2024 13:01:14 -0700
Message-ID: <20240321200114.2219721-1-yonghong.song@linux.dev>
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

With CONFIG_LTO_CLANG_THIN enabled, with some of previous
version of kernel code base ([1]), I hit the following
error:
   test_ksyms:PASS:kallsyms_fopen 0 nsec
   test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
   #118     ksyms:FAIL

The reason is that 'bpf_link_fops' is renamed to
   bpf_link_fops.llvm.8325593422554671469
Due to cross-file inlining, the static variable 'bpf_link_fops'
in syscall.c is used by a function in another file. To avoid
potential duplicated names, the llvm added suffix
'.llvm.<hash>' ([2]) to 'bpf_link_fops' variable.
Such renaming caused a problem in libbpf if 'bpf_link_fops'
is used in bpf prog as a ksym as 'bpf_link_fops' does not
match any symbol in /proc/kallsyms.

To fix this issue, libbpf needs to understand that suffix '.llvm.<hash>'
is caused by clang lto kernel and to process such symbols properly.

With latest bpf-next code base built with CONFIG_LTO_CLANG_THIN,
I cannot reproduce the above failure any more. But such an issue
could happen with other symbols.

For example, with my current kernel, I got the following from
/proc/kallsyms:
  ffffffff84782154 d __func__.net_ratelimit.llvm.6135436931166841955
  ffffffff85f0a500 d tk_core.llvm.726630847145216431
  ffffffff85fdb960 d __fs_reclaim_map.llvm.10487989720912350772
  ffffffff864c7300 d fake_dst_ops.llvm.54750082607048300

I could not easily create a selftest to test newly-added
libbpf functionality with a static C test since I do not know
which symbol is cross-file inlined. But based on my particular kernel,
the following test change can run successfully.

  diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/tes=
ting/selftests/bpf/prog_tests/ksyms.c
  index 6a86d1f07800..904a103f7b1d 100644
  --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
  +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
  @@ -42,6 +42,7 @@ void test_ksyms(void)
          ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_f=
ops");
          ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
          ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
  +       ASSERT_NEQ(data->out__fake_dst_ops, 0, "fake_dst_ops");
          ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_=
cpu_start");

   cleanup:
  diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/tes=
ting/selftests/bpf/progs/test_ksyms.c
  index 6c9cbb5a3bdf..fe91eef54b66 100644
  --- a/tools/testing/selftests/bpf/progs/test_ksyms.c
  +++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
  @@ -9,11 +9,13 @@ __u64 out__bpf_link_fops =3D -1;
   __u64 out__bpf_link_fops1 =3D -1;
   __u64 out__btf_size =3D -1;
   __u64 out__per_cpu_start =3D -1;
  +__u64 out__fake_dst_ops =3D -1;

   extern const void bpf_link_fops __ksym;
   extern const void __start_BTF __ksym;
   extern const void __stop_BTF __ksym;
   extern const void __per_cpu_start __ksym;
  +extern const void fake_dst_ops __ksym;
   /* non-existing symbol, weak, default to zero */
   extern const void bpf_link_fops1 __ksym __weak;

  @@ -23,6 +25,7 @@ int handler(const void *ctx)
          out__bpf_link_fops =3D (__u64)&bpf_link_fops;
          out__btf_size =3D (__u64)(&__stop_BTF - &__start_BTF);
          out__per_cpu_start =3D (__u64)&__per_cpu_start;
  +       out__fake_dst_ops =3D (__u64)&fake_dst_ops;

          out__bpf_link_fops1 =3D (__u64)&bpf_link_fops1;

This patch fixed the issue in libbpf such that if clang lto kernel
is enabled and the symbol resolution is for ksym's,
the suffix '.llvm.<hash>' will be ignored during comparison of
bpf prog ksym vs. symbols in /proc/kallsyms, this resolved the issue.

Note that currently kernel does not support gcc build with lto.

  [1] https://lore.kernel.org/bpf/20240302165017.1627295-1-yonghong.song@=
linux.dev/
  [2] https://github.com/llvm/llvm-project/blob/release/18.x/llvm/include=
/llvm/IR/ModuleSummaryIndex.h#L1714-L1719

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 64 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a7a89269148c..8c3861192bc8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -664,6 +664,7 @@ struct bpf_object {
 	bool loaded;
 	bool has_subcalls;
 	bool has_rodata;
+	bool need_kallsyms;
=20
 	struct bpf_gen *gen_loader;
=20
@@ -8016,14 +8017,73 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb=
, void *ctx)
 	return err;
 }
=20
+static int check_lto_kernel(void)
+{
+	static int check_lto =3D 2;
+	char buf[PATH_MAX];
+	struct utsname uts;
+	gzFile file;
+	int len;
+
+	if (check_lto !=3D 2)
+		return check_lto;
+
+	uname(&uts);
+	len =3D snprintf(buf, PATH_MAX, "/boot/config-%s", uts.release);
+	if (len < 0) {
+		check_lto =3D -EINVAL;
+		goto out;
+	} else if (len >=3D PATH_MAX) {
+		check_lto =3D -ENAMETOOLONG;
+		goto out;
+	}
+
+	/* gzopen also accepts uncompressed files. */
+	file =3D gzopen(buf, "re");
+	if (!file)
+		file =3D gzopen("/proc/config.gz", "re");
+
+	if (!file) {
+		check_lto =3D -ENOENT;
+		goto out;
+	}
+
+	check_lto =3D 0;
+	while (gzgets(file, buf, sizeof(buf))) {
+		/* buf also contains '\n', skip it during comparison. */
+		if (!strncmp(buf, "CONFIG_LTO_CLANG=3Dy", 18)) {
+			check_lto =3D 1;
+			break;
+		}
+	}
+
+	gzclose(file);
+out:
+	return check_lto;
+}
+
 static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		       const char *sym_name, void *ctx)
 {
+	int lto_enabled =3D check_lto_kernel();
+	char orig_name[PATH_MAX], *res;
 	struct bpf_object *obj =3D ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
=20
-	ext =3D find_extern_by_name(obj, sym_name);
+	/* Only check static variables in data sections */
+	if (sym_type =3D=3D 'd' && obj->need_kallsyms && lto_enabled =3D=3D 1) =
{
+		strcpy(orig_name, sym_name);
+		res =3D strstr(orig_name, ".llvm.");
+		if (res) {
+			*res =3D '\0';
+			pr_debug("extern (ksym) '%s': use original name '%s' for comparison\n=
",
+				 sym_name, orig_name);
+		}
+		ext =3D find_extern_by_name(obj, orig_name);
+	} else {
+		ext =3D find_extern_by_name(obj, sym_name);
+	}
 	if (!ext || ext->type !=3D EXT_KSYM)
 		return 0;
=20
@@ -8322,7 +8382,9 @@ static int bpf_object__resolve_externs(struct bpf_o=
bject *obj,
 			return -EINVAL;
 	}
 	if (need_kallsyms) {
+		obj->need_kallsyms =3D true;
 		err =3D bpf_object__read_kallsyms_file(obj);
+		obj->need_kallsyms =3D false;
 		if (err)
 			return -EINVAL;
 	}
--=20
2.43.0

