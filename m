Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8836129E7C
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426512; cv=none; b=DuA9k23+52orPjrFrShh0FrCuLCBRPtOPCEHvzmhk3bMiKhx+UYxYB62i6Yw0VYz3Ig//jKNagJPqVFipOG8hLv+JQGKVy5Xl216NWhqGudn3Jx6ffQ4yRRxeQeMZsxDc6OEi52kNFEWxDryHoRKthj3q551T0Mfg6B3SB7VsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426512; c=relaxed/simple;
	bh=jvVI6dcLOjArs6sYSbsfvG7YbnNfdLYFql6upkku8Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA9FOv0/R4mDplh+do79ZGeCtq4RblschIMcX4ptcT8HTrUZn7+zxKv+i15zkVKXfR2r8UyVgDcY3b5Pio8QhkVFMRk7ZiSdzyLJWFv186LvGi4fJuNTrCKWsyVOWXFJIV062jIckWN7jVkjvcQX+zP4mEL7XCarGU97dFgtPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5C97624E70BE; Mon, 25 Mar 2024 21:14:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/8] libbpf: Handle <orig_name>.llvm.<hash> symbol properly
Date: Mon, 25 Mar 2024 21:14:58 -0700
Message-ID: <20240326041458.1198161-1-yonghong.song@linux.dev>
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
is used in bpf prog as a ksym but 'bpf_link_fops' does not
match any symbol in /proc/kallsyms.

To fix this issue, libbpf needs to understand that suffix '.llvm.<hash>'
is caused by clang lto kernel and to process such symbols properly.

With latest bpf-next code base built with CONFIG_LTO_CLANG_THIN,
I cannot reproduce the above failure any more. But such an issue
could happen with other symbols or in the future for bpf_link_fops symbol=
.

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

>  diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/te=
sting/selftests/bpf/prog_tests/ksyms.c
>  index 6a86d1f07800..904a103f7b1d 100644
>  --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
>  +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>  @@ -42,6 +42,7 @@ void test_ksyms(void)
>          ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_=
fops");
>          ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
>          ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
>  +       ASSERT_NEQ(data->out__fake_dst_ops, 0, "fake_dst_ops");
>          ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per=
_cpu_start");
>
>   cleanup:
>  diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/te=
sting/selftests/bpf/progs/test_ksyms.c
>  index 6c9cbb5a3bdf..fe91eef54b66 100644
>  --- a/tools/testing/selftests/bpf/progs/test_ksyms.c
>  +++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
>  @@ -9,11 +9,13 @@ __u64 out__bpf_link_fops =3D -1;
>   __u64 out__bpf_link_fops1 =3D -1;
>   __u64 out__btf_size =3D -1;
>   __u64 out__per_cpu_start =3D -1;
>  +__u64 out__fake_dst_ops =3D -1;
>
>   extern const void bpf_link_fops __ksym;
>   extern const void __start_BTF __ksym;
>   extern const void __stop_BTF __ksym;
>   extern const void __per_cpu_start __ksym;
>  +extern const void fake_dst_ops __ksym;
>   /* non-existing symbol, weak, default to zero */
>   extern const void bpf_link_fops1 __ksym __weak;
>
>  @@ -23,6 +25,7 @@ int handler(const void *ctx)
>          out__bpf_link_fops =3D (__u64)&bpf_link_fops;
>          out__btf_size =3D (__u64)(&__stop_BTF - &__start_BTF);
>          out__per_cpu_start =3D (__u64)&__per_cpu_start;
>  +       out__fake_dst_ops =3D (__u64)&fake_dst_ops;
>
>          out__bpf_link_fops1 =3D (__u64)&bpf_link_fops1;

This patch fixed the issue in libbpf such that
the suffix '.llvm.<hash>' will be ignored during comparison of
bpf prog ksym vs. symbols in /proc/kallsyms, this resolved the issue.
Currently, only static variables in /proc/kallsyms are checked
with '.llvm.<hash>' suffix since in bpf programs function ksyms
with '.llvm.<hash>' suffix are most likely kfunc's and unlikely
to be cross-file inlined.

Note that currently kernel does not support gcc build with lto.

  [1] https://lore.kernel.org/bpf/20240302165017.1627295-1-yonghong.song@=
linux.dev/
  [2] https://github.com/llvm/llvm-project/blob/release/18.x/llvm/include=
/llvm/IR/ModuleSummaryIndex.h#L1714-L1719

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1f5581b9d11b..370818849e37 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1966,6 +1966,20 @@ static struct extern_desc *find_extern_by_name(con=
st struct bpf_object *obj,
 	return NULL;
 }
=20
+static struct extern_desc *find_extern_by_name_with_len(const struct bpf=
_object *obj,
+							const void *name, int len)
+{
+	const char *ext_name;
+	int i;
+
+	for (i =3D 0; i < obj->nr_extern; i++) {
+		ext_name =3D obj->externs[i].name;
+		if (strlen(ext_name) =3D=3D len && strncmp(ext_name, name, len) =3D=3D=
 0)
+			return &obj->externs[i];
+	}
+	return NULL;
+}
+
 static int set_kcfg_value_tri(struct extern_desc *ext, void *ext_val,
 			      char value)
 {
@@ -8025,8 +8039,13 @@ static int kallsyms_cb(unsigned long long sym_addr=
, char sym_type,
 	struct bpf_object *obj =3D ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
+	char *res;
=20
-	ext =3D find_extern_by_name(obj, sym_name);
+	res =3D strstr(sym_name, ".llvm.");
+	if (sym_type =3D=3D 'd' && res)
+		ext =3D find_extern_by_name_with_len(obj, sym_name, res - sym_name);
+	else
+		ext =3D find_extern_by_name(obj, sym_name);
 	if (!ext || ext->type !=3D EXT_KSYM)
 		return 0;
=20
--=20
2.43.0

