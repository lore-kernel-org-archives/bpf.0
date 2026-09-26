Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB038C426
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398918; cv=none; b=G9rBLvmXvfEpo9M5Xw639qa4Rxzje/arercB1l84Wci07+Sv+YyGi3ZfOUjhSX4IngnHLZljcxo4t5azHf+U6eV7XuYXvfFD42D8c2CV1t0pCG+uvpaA2VvoihjR7roSArOBq4OoOKn8jpAeYM49J2rJEPJ6+yeBKL9nPx4NBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398918; c=relaxed/simple;
	bh=7KBHTEeU6siGYoaKnd1srrlgcN/ekdAF3FJ1vEukyPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUc3mYws7KQL3DbohwULPt1DJ+jhttZUPpt8LGPTqUHO4BOkz7fCkzwoRN+jqSO0j7sIpwzUu9gr3YOi8hgHADDeNd9Xx+J2HHhpbDy4KLrjTERzDtrDJsUI0faDe7JUGnNWktLEBjsCTmWGjCWFZMs35Ys1e9yS2dtaTyKRBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B21F32D45970CA; Fri, 25 Sep 2026 22:01:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 19/21] selftests/bpf: Add __set_global() and __ret_global() test tags
Date: Fri, 25 Sep 2026 22:01:43 -0700
Message-ID: <20260926050143.2222664-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A test that has to look at a program's state after it ran needs a driver =
of
its own: open and load a skeleton, set an input, call
bpf_prog_test_run_opts(), read a variable back, destroy the skeleton. The
loader already does all of that for __retval(), and the only thing missin=
g
is reaching the program's globals.

__set_global(var, value) writes one before the run and __ret_global(var,
value) checks one after it, both of them implying the execution __retval(=
)
asks for. The variable is found the way veristat finds one: the map whose
name ends in ".bss" or ".data", the datasec of that name in the object's
BTF, then the variable within it. Four and eight byte variables are
supported, which is what a counter or a bitmask needs; anything else is
refused rather than read at the wrong width.

The value may be a '|' separated list of terms, so that a bitmask reads i=
n
the test the way it is written in the program.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |   7 +
 tools/testing/selftests/bpf/test_loader.c    | 207 +++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
index f3dbc3b59bff..9afa163fac5a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -93,6 +93,11 @@
  * __failure         Expect program load failure in privileged mode.
  * __failure_unpriv  Expect program load failure in unprivileged mode.
  *
+ * __set_global      Set a global variable of the program to a value bef=
ore
+ *                   executing it.
+ * __ret_global      Execute the program and check that a global variabl=
e
+ *                   holds the given value afterwards. The variable has =
to
+ *                   live in .bss or .data and be four or eight bytes wi=
de.
  * __retval          Execute the program using BPF_PROG_TEST_RUN command=
,
  *                   expect return value to match passed parameter:
  *                   - a decimal number
@@ -160,6 +165,8 @@
 #define __log_level(lvl)	__test_tag("test_log_level=3D" #lvl)
 #define __flag(flag)		__test_tag("test_prog_flags=3D" #flag)
 #define __retval(val)		__test_tag("test_retval=3D" XSTR(val))
+#define __set_global(var, val)	__test_tag("test_global_set=3D" #var ":" =
XSTR(val))
+#define __ret_global(var, val)	__test_tag("test_global_ret=3D" #var ":" =
XSTR(val))
 #define __retval_unpriv(val)	__test_tag("test_retval_unpriv=3D" XSTR(val=
))
 #define __auxiliary		__test_tag("test_auxiliary")
 #define __auxiliary_unpriv	__test_tag("test_auxiliary_unpriv")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
index 25eeb1c1248b..65b55f7fa907 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -62,6 +62,12 @@ struct test_subspec {
 	int retval;
 	bool execute;
 	__u64 caps;
+	char *set_global_var;
+	__u64 set_global_val;
+	bool has_set_global;
+	char *ret_global_var;
+	__u64 ret_global_val;
+	bool has_ret_global;
 };
=20
 struct test_spec {
@@ -129,6 +135,15 @@ static void free_test_spec(struct test_spec *spec)
 	free_msgs(&spec->unpriv.stdout);
 	free_msgs(&spec->priv.stdout);
=20
+	free(spec->priv.set_global_var);
+	free(spec->priv.ret_global_var);
+	free(spec->unpriv.set_global_var);
+	free(spec->unpriv.ret_global_var);
+	spec->priv.set_global_var =3D NULL;
+	spec->priv.ret_global_var =3D NULL;
+	spec->unpriv.set_global_var =3D NULL;
+	spec->unpriv.ret_global_var =3D NULL;
+
 	free(spec->priv.name);
 	free(spec->priv.description);
 	free(spec->unpriv.name);
@@ -311,6 +326,142 @@ static int parse_caps(const char *str, __u64 *val, =
const char *name)
 	return 0;
 }
=20
+static int parse_global_var(const char *str, char **var, __u64 *val, con=
st char *name)
+{
+	const char *colon =3D strrchr(str, ':');
+	char *end;
+
+	if (!colon || colon =3D=3D str) {
+		PRINT_FAIL("expecting '<variable>:<value>' for %s, got '%s'\n", name, =
str);
+		return -EINVAL;
+	}
+
+	*val =3D 0;
+	for (const char *term =3D colon + 1;;) {
+		__u64 v;
+
+		errno =3D 0;
+		v =3D strtoull(term, &end, 0);
+		if (errno || end =3D=3D term) {
+			PRINT_FAIL("failed to parse %s value '%s'\n", name, colon + 1);
+			return -EINVAL;
+		}
+		*val |=3D v;
+		while (*end =3D=3D ' ')
+			end++;
+		if (!*end)
+			break;
+		if (*end !=3D '|') {
+			PRINT_FAIL("failed to parse %s value '%s'\n", name, colon + 1);
+			return -EINVAL;
+		}
+		term =3D end + 1;
+	}
+
+	free(*var);
+	*var =3D strndup(str, colon - str);
+	if (!*var) {
+		PRINT_FAIL("failed to allocate %s variable name\n", name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int find_global_var(struct bpf_object *obj, const char *name,
+			   struct bpf_map **map, __u32 *off, __u32 *sz)
+{
+	static const char * const secs[] =3D { ".bss", ".data" };
+	struct btf *btf =3D bpf_object__btf(obj);
+	int i, s;
+
+	if (!btf) {
+		PRINT_FAIL("no BTF for object\n");
+		return -ENOENT;
+	}
+
+	for (s =3D 0; s < ARRAY_SIZE(secs); s++) {
+		const struct btf_var_secinfo *vsi;
+		struct bpf_map *m =3D NULL, *iter;
+		const struct btf_type *sec;
+		size_t slen =3D strlen(secs[s]);
+		int id;
+
+		bpf_object__for_each_map(iter, obj) {
+			const char *mname =3D bpf_map__name(iter);
+			size_t len =3D mname ? strlen(mname) : 0;
+
+			if (len >=3D slen && strcmp(mname + len - slen, secs[s]) =3D=3D 0) {
+				m =3D iter;
+				break;
+			}
+		}
+		id =3D btf__find_by_name_kind(btf, secs[s], BTF_KIND_DATASEC);
+		if (!m || id < 0)
+			continue;
+
+		sec =3D btf__type_by_id(btf, id);
+		vsi =3D btf_var_secinfos(sec);
+		for (i =3D 0; i < btf_vlen(sec); i++, vsi++) {
+			const struct btf_type *var =3D btf__type_by_id(btf, vsi->type);
+
+			if (strcmp(btf__name_by_offset(btf, var->name_off), name))
+				continue;
+			if (vsi->size !=3D 4 && vsi->size !=3D 8) {
+				PRINT_FAIL("'%s' is %u bytes, only 4 and 8 are supported\n",
+					   name, vsi->size);
+				return -EINVAL;
+			}
+			*map =3D m;
+			*off =3D vsi->offset;
+			*sz =3D vsi->size;
+			return 0;
+		}
+	}
+
+	PRINT_FAIL("no global variable '%s'\n", name);
+	return -ENOENT;
+}
+
+static int access_global_var(struct bpf_object *obj, const char *name,
+			     __u64 *val, bool set)
+{
+	__u32 off, sz, zero =3D 0;
+	struct bpf_map *map;
+	size_t vsz;
+	void *buf;
+	int err;
+
+	err =3D find_global_var(obj, name, &map, &off, &sz);
+	if (err)
+		return err;
+
+	vsz =3D bpf_map__value_size(map);
+	buf =3D calloc(1, vsz);
+	if (!buf)
+		return -ENOMEM;
+
+	err =3D bpf_map__lookup_elem(map, &zero, sizeof(zero), buf, vsz, 0);
+	if (err) {
+		PRINT_FAIL("failed to read '%s': %d\n", name, err);
+		goto out;
+	}
+	if (!set) {
+		*val =3D sz =3D=3D 4 ? *(__u32 *)(buf + off) : *(__u64 *)(buf + off);
+		goto out;
+	}
+	if (sz =3D=3D 4)
+		*(__u32 *)(buf + off) =3D *val;
+	else
+		*(__u64 *)(buf + off) =3D *val;
+	err =3D bpf_map__update_elem(map, &zero, sizeof(zero), buf, vsz, 0);
+	if (err)
+		PRINT_FAIL("failed to write '%s': %d\n", name, err);
+out:
+	free(buf);
+	return err;
+}
+
 static int parse_retval(const char *str, int *val, const char *name)
 {
 	/*
@@ -557,6 +708,24 @@ static int parse_test_spec(struct test_loader *teste=
r,
 			spec->mode_mask |=3D UNPRIV;
 			spec->unpriv.execute =3D true;
 			has_unpriv_retval =3D true;
+		} else if ((val =3D str_has_pfx(s, "test_global_set=3D"))) {
+			err =3D parse_global_var(val, &spec->priv.set_global_var,
+					       &spec->priv.set_global_val,
+					       "__set_global");
+			if (err)
+				goto cleanup;
+			spec->priv.has_set_global =3D true;
+			spec->priv.execute =3D true;
+			spec->mode_mask |=3D PRIV;
+		} else if ((val =3D str_has_pfx(s, "test_global_ret=3D"))) {
+			err =3D parse_global_var(val, &spec->priv.ret_global_var,
+					       &spec->priv.ret_global_val,
+					       "__ret_global");
+			if (err)
+				goto cleanup;
+			spec->priv.has_ret_global =3D true;
+			spec->priv.execute =3D true;
+			spec->mode_mask |=3D PRIV;
 		} else if ((val =3D str_has_pfx(s, "test_log_level=3D"))) {
 			err =3D parse_int(val, &spec->log_level, "test log level");
 			if (err)
@@ -742,6 +911,25 @@ static int parse_test_spec(struct test_loader *teste=
r,
 			spec->unpriv.execute =3D spec->priv.execute;
 		}
=20
+		if (spec->priv.has_set_global && !spec->unpriv.has_set_global) {
+			spec->unpriv.set_global_var =3D strdup(spec->priv.set_global_var);
+			if (!spec->unpriv.set_global_var) {
+				err =3D -ENOMEM;
+				goto cleanup;
+			}
+			spec->unpriv.set_global_val =3D spec->priv.set_global_val;
+			spec->unpriv.has_set_global =3D true;
+		}
+		if (spec->priv.has_ret_global && !spec->unpriv.has_ret_global) {
+			spec->unpriv.ret_global_var =3D strdup(spec->priv.ret_global_var);
+			if (!spec->unpriv.ret_global_var) {
+				err =3D -ENOMEM;
+				goto cleanup;
+			}
+			spec->unpriv.ret_global_val =3D spec->priv.ret_global_val;
+			spec->unpriv.has_ret_global =3D true;
+		}
+
 		if (spec->unpriv.expect_msgs.cnt =3D=3D 0)
 			clone_msgs(&spec->priv.expect_msgs, &spec->unpriv.expect_msgs);
 		if (spec->unpriv.expect_xlated.cnt =3D=3D 0)
@@ -1532,6 +1720,13 @@ void run_subtest(struct test_loader *tester,
 			}
 		}
=20
+		if (subspec->has_set_global) {
+			__u64 v =3D subspec->set_global_val;
+
+			if (access_global_var(tobj, subspec->set_global_var, &v, true))
+				goto tobj_cleanup;
+		}
+
 		err =3D do_prog_test_run(bpf_program__fd(tprog), &retval,
 				       bpf_program__type(tprog) =3D=3D BPF_PROG_TYPE_SYSCALL ? true =
: false,
 				       spec->linear_sz);
@@ -1540,6 +1735,18 @@ void run_subtest(struct test_loader *tester,
 			goto tobj_cleanup;
 		}
=20
+		if (subspec->has_ret_global) {
+			__u64 v =3D 0;
+
+			if (access_global_var(tobj, subspec->ret_global_var, &v, false))
+				goto tobj_cleanup;
+			if (v !=3D subspec->ret_global_val) {
+				PRINT_FAIL("Unexpected %s: 0x%llx !=3D 0x%llx\n",
+					   subspec->ret_global_var, v, subspec->ret_global_val);
+				goto tobj_cleanup;
+			}
+		}
+
 		verify_stderr(bpf_program__fd(tprog), &subspec->stderr);
=20
 		if (subspec->stdout.cnt) {
--=20
2.53.0-Meta

