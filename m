Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237F3D9041
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691318; cv=none; b=ZiQmCeei81W9NYdaqLJjH7KusQvk7i/2wccgbX/zdB+sCb+t5TKeybZYi7oai+lNAN+Z8Hlwdx2xWyfYX+00UffcwkyQ53hK5LiW9I6DYVOyBscnu36DOlZAS/Fyxmp1Aiv5JiLPqf0OfSQEr5YedMOBiCgPT44ejoMj0WyX5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691318; c=relaxed/simple;
	bh=2WB89QDw8cE2/cb54iwiO/q3GQykxGS9MdlqaBZthVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ90LdGLWU5Nz2PCkFwIalzr7nyfFWAOnbZKcqWBaoLGYpgf3Pp5iomwRXVX2E0nyPabNCG6u7sjF16LCpxbCpZoOPGcvn29cxtRZj2+ud0141fDwDLE+CkW1kmeDHb/Esy2Z0zpIp8hHEE7hGxsDF1Cvpej8rFRglxjYttnqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8D308268293E39; Tue, 25 Aug 2026 13:55:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 10/10] selftests/bpf: Test kfuncs returning arena pointers by value
Date: Tue, 25 Aug 2026 13:55:03 -0700
Message-ID: <20260825205503.1327012-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825205412.1320099-1-yonghong.song@linux.dev>
References: <20260825205412.1320099-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cover the by-value struct returns a kfunc may now make: two arena
pointers filling R0:R2, and an arena pointer beside a scalar. The
existing cases for a struct and a nested struct carrying a plain pointer
stay rejected.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  | 42 +++++++++++++++++
 .../bpf/progs/aggregate_ret_kfunc_arena.c     | 47 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 16 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        | 18 +++++++
 4 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
_arena.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
index e0b94ed10f94..07d9d6e1d6b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -1,11 +1,53 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include "aggregate_ret_func.skel.h"
 #include "aggregate_ret_kfunc.skel.h"
+#include "aggregate_ret_kfunc_arena.skel.h"
+
+static bool testmod_has_arena_tagged_member(void)
+{
+	struct btf *vmlinux_btf, *module_btf =3D NULL;
+	const struct btf_type *t;
+	bool tagged =3D false;
+	__s32 id;
+
+	vmlinux_btf =3D btf__load_vmlinux_btf();
+	if (!vmlinux_btf)
+		return false;
+
+	module_btf =3D btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!module_btf)
+		goto out;
+
+	/* prog_test_ret_arena::a is 'void __arena_tag *': PTR -> TYPE_TAG -> v=
oid */
+	id =3D btf__find_by_name_kind(module_btf, "prog_test_ret_arena", BTF_KI=
ND_STRUCT);
+	if (id <=3D 0)
+		goto out;
+
+	t =3D btf__type_by_id(module_btf, btf_members(btf__type_by_id(module_bt=
f, id))[0].type);
+	if (!t || !btf_is_ptr(t))
+		goto out;
+
+	t =3D btf__type_by_id(module_btf, t->type);
+	tagged =3D t && btf_is_type_tag(t) &&
+		 !strcmp(btf__name_by_offset(module_btf, t->name_off), "arena");
+
+out:
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+
+	return tagged;
+}
=20
 void test_aggregate_ret(void)
 {
 	RUN_TESTS(aggregate_ret_func);
 	RUN_TESTS(aggregate_ret_kfunc);
+
+	if (testmod_has_arena_tagged_member())
+		RUN_TESTS(aggregate_ret_kfunc_arena);
+	else
+		test__skip();
 }
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.=
c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
new file mode 100644
index 000000000000..f68deae6c900
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+void __kfunc_btf_root(void)
+{
+	asm volatile (""
+	:
+	: "r"(&bpf_kfunc_call_test_ret_arena),
+	  "r"(&bpf_kfunc_call_test_ret_arena_mixed));
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+__naked int aggregate_ret_kfunc_arena(void)
+{
+	asm volatile (
+	"call %[bpf_kfunc_call_test_ret_arena];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_arena)
+	: __clobber_all);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+__naked int aggregate_ret_kfunc_arena_mixed(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"call %[bpf_kfunc_call_test_ret_arena_mixed];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_arena_mixed)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 76acbe29054a..81fb93ea466e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -981,6 +981,20 @@ __bpf_kfunc struct prog_test_ret_ptr bpf_kfunc_call_=
test_ret_ptr(u64 tag)
 	return r;
 }
=20
+__bpf_kfunc struct prog_test_ret_arena bpf_kfunc_call_test_ret_arena(voi=
d)
+{
+	struct prog_test_ret_arena r =3D { .a =3D NULL, .b =3D NULL };
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_arena_mixed bpf_kfunc_call_test_ret_are=
na_mixed(u64 tag)
+{
+	struct prog_test_ret_arena_mixed r =3D { .p =3D NULL, .tag =3D tag };
+
+	return r;
+}
+
 __bpf_kfunc struct prog_test_ret_nested bpf_kfunc_call_test_ret_nested(u=
64 tag)
 {
 	struct prog_test_ret_nested r =3D { .in =3D { .p =3D NULL }, .tag =3D t=
ag };
@@ -1553,6 +1567,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_fastcall, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arena)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arena_mixed)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_nested)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 52227129a49e..aebf88102dc6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -26,6 +26,12 @@ struct prog_test_ref_kfunc {
 };
 #endif
=20
+#if __has_attribute(btf_type_tag)
+#define __arena_tag __attribute__((btf_type_tag("arena")))
+#else
+#define __arena_tag
+#endif
+
 struct bpf_iter_testmod_seq;
=20
 struct prog_test_pass1 {
@@ -70,6 +76,16 @@ struct prog_test_ret_ptr {	/* 16 bytes: contains a poi=
nter */
 	__u64 tag;
 };
=20
+struct prog_test_ret_arena {	/* 16 bytes: two arena pointers */
+	void __arena_tag *a;
+	void __arena_tag *b;
+};
+
+struct prog_test_ret_arena_mixed {	/* 16 bytes: an arena pointer and a s=
calar */
+	void __arena_tag *p;
+	__u64 tag;
+};
+
 struct prog_test_ret_nested {	/* 16 bytes: the pointer hides one level d=
own */
 	struct {
 		void *p;
@@ -179,6 +195,8 @@ struct prog_test_ret_pair bpf_kfunc_call_test_ret_fas=
tcall(__u64 a, __u64 b) __k
 struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b) __ksym;
 struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(__u64 tag) __ksym;
 struct prog_test_ret_nested bpf_kfunc_call_test_ret_nested(__u64 tag) __=
ksym;
+struct prog_test_ret_arena bpf_kfunc_call_test_ret_arena(void) __ksym;
+struct prog_test_ret_arena_mixed bpf_kfunc_call_test_ret_arena_mixed(__u=
64 tag) __ksym;
 struct prog_test_ret_deep bpf_kfunc_call_test_ret_deep(__u64 v) __ksym;
 struct prog_test_ret_big bpf_kfunc_call_test_ret_big(void) __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
--=20
2.53.0-Meta

