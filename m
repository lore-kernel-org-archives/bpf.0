Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AF377016
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477701; cv=none; b=LXi0ffaUeHMsG+HgIaNViOXY5lBk4dK3FPloGDxG0B8M5l9sg6nJYNkbn8ZCG1cpA7zhu0ul3DveyVD9OBJoMxk33xuuFbe/7t/ULGd4Pfc2iD2EwzzRrYIc61VvDq2kpfnKEYw49lmjwGQFGKdDlF0W1WmCnzb+t7U82LvZ9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477701; c=relaxed/simple;
	bh=Dh3Rs/E8ze7EL4C8Ysp6nBvYy8ylDxuctsIrc2O2/Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0ZzyRZtfzlVYf9lrNmEnwVNRXPkCZTp+eTwMAXEqNYjfMBrYwpUb1bigUpy4JEiqyFS2a0A6+kQ3Vb7Iae1OlfNL/aoVIzBEfcAuD04yyW2COFAzZff8bL+TidfzVGiWzLyAt0ExWKm0Rbeoh4lwb0KXvQwx+ff8CAY9jgHX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A787DA59DC7BA; Sun, 10 May 2026 22:34:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 19/24] selftests/bpf: Add BTF fixup for __naked subprog parameter names
Date: Sun, 10 May 2026 22:34:47 -0700
Message-ID: <20260511053447.1891270-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When __naked subprogs are used in verifier tests, clang drops
parameter names from their BTF FUNC_PROTO entries. This prevents
the verifier from resolving stack argument slots by name.

Add a __btf_func_path(path) annotation that points to a separate
BTF file containing properly-named FUNC entries. The test_loader
matches FUNC entries by name, detects anonymous parameters, and
replaces the FUNC_PROTO with a new one that carries parameter
names from the custom file while preserving the original type IDs.

The custom BTF file also serves as btf_custom_path for kfunc
resolution when no separate btf_custom_path is specified.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |   1 +
 tools/testing/selftests/bpf/test_loader.c    | 136 ++++++++++++++++++-
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
index a0d7b15a24b1..9eeb5b0b63d6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -152,6 +152,7 @@
 #define __auxiliary		__test_tag("test_auxiliary")
 #define __auxiliary_unpriv	__test_tag("test_auxiliary_unpriv")
 #define __btf_path(path)	__test_tag("test_btf_path=3D" path)
+#define __btf_func_path(path)	__test_tag("test_btf_func_path=3D" path)
 #define __arch(arch)		__test_tag("test_arch=3D" arch)
 #define __arch_x86_64		__arch("X86_64")
 #define __arch_arm64		__arch("ARM64")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
index ee637809a1d4..abdb9e6e3713 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -63,6 +63,7 @@ struct test_spec {
 	struct test_subspec priv;
 	struct test_subspec unpriv;
 	const char *btf_custom_path;
+	const char *btf_custom_func_path;
 	int log_level;
 	int prog_flags;
 	int mode_mask;
@@ -590,6 +591,8 @@ static int parse_test_spec(struct test_loader *tester=
,
 			jit_on_next_line =3D true;
 		} else if ((val =3D str_has_pfx(s, "test_btf_path=3D"))) {
 			spec->btf_custom_path =3D val;
+		} else if ((val =3D str_has_pfx(s, "test_btf_func_path=3D"))) {
+			spec->btf_custom_func_path =3D val;
 		} else if ((val =3D str_has_pfx(s, "test_caps_unpriv=3D"))) {
 			err =3D parse_caps(val, &spec->unpriv.caps, "test caps");
 			if (err)
@@ -1175,6 +1178,123 @@ static int get_stream(int stream_id, int prog_fd,=
 char *text, size_t text_sz)
 	return ret;
 }
=20
+/*
+ * Fix up the program's BTF using BTF from a separate file.
+ *
+ * For __naked subprogs, clang drops parameter names from BTF. Find FUNC
+ * entries with anonymous parameters and replace their FUNC_PROTO with t=
he
+ * properly-named version from the custom file.
+ */
+static int fixup_btf_from_path(struct bpf_object *obj, const char *path)
+{
+	struct btf *prog_btf, *custom_btf;
+	__u32 i, j, cnt, custom_cnt;
+	int err =3D 0;
+
+	prog_btf =3D bpf_object__btf(obj);
+	if (!prog_btf)
+		return 0;
+
+	custom_btf =3D btf__parse(path, NULL);
+	if (!ASSERT_OK_PTR(custom_btf, "parse_custom_btf"))
+		return -EINVAL;
+
+	cnt =3D btf__type_cnt(prog_btf);
+	custom_cnt =3D btf__type_cnt(custom_btf);
+
+	/* Fix up FUNC entries with anonymous params.
+	 * Save all data from prog_btf BEFORE calling btf__add_*,
+	 * since those calls may reallocate the BTF data buffer
+	 * and invalidate any pointers obtained from btf__type_by_id.
+	 */
+	for (i =3D 1; i < cnt; i++) {
+		const struct btf_type *t =3D btf__type_by_id(prog_btf, i);
+		const struct btf_type *fp, *custom_t, *custom_fp;
+		const struct btf_param *params, *custom_params;
+		__u32 ret_type_id, vlen;
+		__u32 *prog_param_types =3D NULL;
+		const char *name;
+		int new_proto_id;
+
+		if (!btf_is_func(t))
+			continue;
+
+		fp =3D btf__type_by_id(prog_btf, t->type);
+		if (!fp || !btf_is_func_proto(fp) || btf_vlen(fp) =3D=3D 0)
+			continue;
+
+		/* Check if any param is anonymous */
+		params =3D btf_params(fp);
+		if (params[0].name_off !=3D 0)
+			continue;
+
+		/* Find matching FUNC by name in custom BTF */
+		name =3D btf__name_by_offset(prog_btf, t->name_off);
+		if (!name)
+			continue;
+
+		for (j =3D 1; j < custom_cnt; j++) {
+			const char *cname;
+
+			custom_t =3D btf__type_by_id(custom_btf, j);
+			if (!btf_is_func(custom_t))
+				continue;
+			cname =3D btf__name_by_offset(custom_btf, custom_t->name_off);
+			if (cname && strcmp(name, cname) =3D=3D 0)
+				break;
+		}
+		if (j >=3D custom_cnt)
+			continue;
+
+		custom_fp =3D btf__type_by_id(custom_btf, custom_t->type);
+		if (!custom_fp || !btf_is_func_proto(custom_fp))
+			continue;
+
+		vlen =3D btf_vlen(fp);
+		if (vlen !=3D btf_vlen(custom_fp))
+			continue;
+
+		/* Save data before btf__add_* calls invalidate pointers */
+		ret_type_id =3D fp->type;
+		prog_param_types =3D malloc(vlen * sizeof(*prog_param_types));
+		if (!prog_param_types) {
+			err =3D -ENOMEM;
+			break;
+		}
+		for (j =3D 0; j < vlen; j++)
+			prog_param_types[j] =3D params[j].type;
+
+		/* Add a new FUNC_PROTO: param names from custom, types from prog */
+		new_proto_id =3D btf__add_func_proto(prog_btf, ret_type_id);
+		if (new_proto_id < 0) {
+			err =3D new_proto_id;
+			free(prog_param_types);
+			break;
+		}
+
+		custom_params =3D btf_params(custom_fp);
+		for (j =3D 0; j < vlen; j++) {
+			const char *pname;
+
+			pname =3D btf__name_by_offset(custom_btf, custom_params[j].name_off);
+			err =3D btf__add_func_param(prog_btf, pname ?: "", prog_param_types[j=
]);
+			if (err)
+				break;
+		}
+		free(prog_param_types);
+		if (err)
+			break;
+
+		/* Update the FUNC to point to the new FUNC_PROTO (re-fetch
+		 * since btf__add_* may have reallocated the data buffer).
+		 */
+		((struct btf_type *)btf__type_by_id(prog_btf, i))->type =3D new_proto_=
id;
+	}
+
+	btf__free(custom_btf);
+	return err;
+}
+
 /* this function is forced noinline and has short generic name to look b=
etter
  * in test_progs output (in case of a failure)
  */
@@ -1231,13 +1351,27 @@ void run_subtest(struct test_loader *tester,
 		}
 	}
=20
-	/* Implicitly reset to NULL if next test case doesn't specify */
+	/* Implicitly reset to NULL if next test case doesn't specify.
+	 * btf_custom_func_path also serves as btf_custom_path for kfunc resolu=
tion.
+	 */
 	open_opts->btf_custom_path =3D spec->btf_custom_path;
+	if (!open_opts->btf_custom_path)
+		open_opts->btf_custom_path =3D spec->btf_custom_func_path;
=20
 	tobj =3D bpf_object__open_mem(obj_bytes, obj_byte_cnt, open_opts);
 	if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
 		goto subtest_cleanup;
=20
+	/* Fix up __naked subprog BTF using a separate file with named params *=
/
+	if (spec->btf_custom_func_path) {
+		err =3D fixup_btf_from_path(tobj, spec->btf_custom_func_path);
+		if (err) {
+			PRINT_FAIL("failed to fixup BTF from %s: %d\n",
+				   spec->btf_custom_func_path, err);
+			goto tobj_cleanup;
+		}
+	}
+
 	i =3D 0;
 	bpf_object__for_each_program(tprog_iter, tobj) {
 		spec_iter =3D &specs[i++];
--=20
2.53.0-Meta

