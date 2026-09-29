Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831D4F5E0
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641070; cv=none; b=TftVD/CIgM+T7hel4MyGljOpZsVL/gJCP8/Uo7jC5nihb9It4sEnnKr1ctobIbIBw4YeOWroWrt6937atzqgATAwgTE/u7+PiaxBr7um9cnW/Z3cCIYtd7YI4ve7DIC8AKy21tUuYuCw4uaVb5He1b8hiyJxM/BRmbcqMWGqyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641070; c=relaxed/simple;
	bh=jrk75JDt8Yv5LMOPbhkC2+a3gzVVYergLTrak0U9be8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVHIZF5v6vRxUBspIiPj0H0q8i3J9mYPncTOQxdTlj6mAgKEHsOjdY4IySwj3JxklMaUlZ/KsiWKj4xMd3U+Y1TaPOYIMqFfQdxQGd5xA/f9sIWDyFWh7/64vfvF8USyR4qDbtFxhLE0pHuIPijHxg987iCCldOmvMiTYEwrmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E57C52DE076A3A; Mon, 28 Sep 2026 17:17:46 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 20/22] selftests/bpf: Add __set_global() and __ret_global() test tags
Date: Mon, 28 Sep 2026 17:17:46 -0700
Message-ID: <20260929001746.3256138-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
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
asks for. Either may be given more than once, for a test with more than
one input or more than one thing to look at afterwards; past
MAX_GLOBAL_VARS a tag is refused rather than quietly replacing the one
before it.

The variable is found the way veristat finds one: the map whose name ends
in ".bss" or ".data", the datasec of that name in the object's BTF, then
the variable within it. Those are two lookups that nothing so far has mad=
e
agree on a size, so where the variable lands is checked against the map i=
t
was found beside. Four and eight byte variables are supported, which is
what a counter or a bitmask needs; anything else is refused rather than
read at the wrong width.

A value is held to the range its variable can represent, signedness taken
from the BTF the way veristat's set_global_var() does, and narrowed to
what is stored. Both tags use the one rule, so a negative literal means
the same to each: without it __ret_global(err, -22) on an int could never
match, the tag parsing 64 bits while the read gave back 32. Unlike
veristat this takes no enum names and runs native-endian only.

The value may be a '|' separated list of terms, so that a bitmask reads i=
n
the test the way it is written in the program.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |   7 +
 tools/testing/selftests/bpf/test_loader.c    | 314 ++++++++++++++++++-
 2 files changed, 320 insertions(+), 1 deletion(-)

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
index 25eeb1c1248b..2492841f7a49 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -50,6 +50,13 @@ enum stack_mode {
 	SMALL_STACK	=3D 1 << 1,
 };
=20
+#define MAX_GLOBAL_VARS 8
+
+struct global_var {
+	char *name;
+	__u64 val;
+};
+
 struct test_subspec {
 	char *name;
 	char *description;
@@ -62,6 +69,10 @@ struct test_subspec {
 	int retval;
 	bool execute;
 	__u64 caps;
+	struct global_var set_globals[MAX_GLOBAL_VARS];
+	int set_global_cnt;
+	struct global_var ret_globals[MAX_GLOBAL_VARS];
+	int ret_global_cnt;
 };
=20
 struct test_spec {
@@ -115,6 +126,34 @@ void free_msgs(struct expected_msgs *msgs)
 	msgs->cnt =3D 0;
 }
=20
+static void free_global_vars(struct global_var *vars, int *cnt)
+{
+	int i;
+
+	for (i =3D 0; i < *cnt; i++) {
+		free(vars[i].name);
+		vars[i].name =3D NULL;
+	}
+	*cnt =3D 0;
+}
+
+static int clone_global_vars(struct global_var *dst, int *dst_cnt,
+			     const struct global_var *src, int src_cnt)
+{
+	int i;
+
+	for (i =3D 0; i < src_cnt; i++) {
+		dst[i].name =3D strdup(src[i].name);
+		if (!dst[i].name) {
+			free_global_vars(dst, dst_cnt);
+			return -ENOMEM;
+		}
+		dst[i].val =3D src[i].val;
+		(*dst_cnt)++;
+	}
+	return 0;
+}
+
 static void free_test_spec(struct test_spec *spec)
 {
 	/* Deallocate expect_msgs arrays. */
@@ -129,6 +168,11 @@ static void free_test_spec(struct test_spec *spec)
 	free_msgs(&spec->unpriv.stdout);
 	free_msgs(&spec->priv.stdout);
=20
+	free_global_vars(spec->priv.set_globals, &spec->priv.set_global_cnt);
+	free_global_vars(spec->priv.ret_globals, &spec->priv.ret_global_cnt);
+	free_global_vars(spec->unpriv.set_globals, &spec->unpriv.set_global_cnt=
);
+	free_global_vars(spec->unpriv.ret_globals, &spec->unpriv.ret_global_cnt=
);
+
 	free(spec->priv.name);
 	free(spec->priv.description);
 	free(spec->unpriv.name);
@@ -311,6 +355,216 @@ static int parse_caps(const char *str, __u64 *val, =
const char *name)
 	return 0;
 }
=20
+static int parse_global_var(const char *str, struct global_var *vars, in=
t *cnt,
+			    const char *name)
+{
+	const char *colon =3D strrchr(str, ':');
+	struct global_var *var;
+	char *end;
+	__u64 *val;
+
+	if (!colon || colon =3D=3D str) {
+		PRINT_FAIL("expecting '<variable>:<value>' for %s, got '%s'\n", name, =
str);
+		return -EINVAL;
+	}
+	if (*cnt >=3D MAX_GLOBAL_VARS) {
+		PRINT_FAIL("too many %s tags, at most %d are supported\n",
+			   name, MAX_GLOBAL_VARS);
+		return -E2BIG;
+	}
+
+	var =3D &vars[*cnt];
+	val =3D &var->val;
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
+	var->name =3D strndup(str, colon - str);
+	if (!var->name) {
+		PRINT_FAIL("failed to allocate %s variable name\n", name);
+		return -ENOMEM;
+	}
+	(*cnt)++;
+
+	return 0;
+}
+
+/* As veristat's is_signed_type(): anything not plainly unsigned is sign=
ed. */
+static bool global_var_is_signed(const struct btf_type *t)
+{
+	if (btf_is_int(t))
+		return btf_int_encoding(t) & BTF_INT_SIGNED;
+	if (btf_is_any_enum(t))
+		return btf_kflag(t);
+	return true;
+}
+
+static int find_global_var(struct bpf_object *obj, const char *name,
+			   struct bpf_map **map, __u32 *off, __u32 *sz,
+			   bool *is_signed)
+{
+	static const char * const secs[] =3D { ".bss", ".data" };
+	struct btf *btf =3D bpf_object__btf(obj);
+	int i, s;
+	__u32 vsz;
+
+	if (!btf) {
+		PRINT_FAIL("no BTF for object\n");
+		return -ENOENT;
+	}
+
+	for (s =3D 0; s < ARRAY_SIZE(secs); s++) {
+		const struct btf_type *sec, *vt;
+		const struct btf_var_secinfo *vsi;
+		struct bpf_map *m =3D NULL, *iter;
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
+			vt =3D btf__type_by_id(btf, btf__resolve_type(btf, var->type));
+			if (!vt || !(btf_is_int(vt) || btf_is_any_enum(vt))) {
+				PRINT_FAIL("'%s' is not an int or an enum\n", name);
+				return -EINVAL;
+			}
+			*is_signed =3D global_var_is_signed(vt);
+			/*
+			 * The map is found by the suffix of its name and the
+			 * section by its own, so nothing so far has made the
+			 * two agree on a size.
+			 */
+			vsz =3D bpf_map__value_size(m);
+			if (vsi->offset > vsz || vsi->size > vsz - vsi->offset) {
+				PRINT_FAIL("'%s' at %u+%u is outside '%s' of %u bytes\n",
+					   name, vsi->offset, vsi->size,
+					   bpf_map__name(m), vsz);
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
+/*
+ * A tag's value is parsed as 64 bits, but the variable may be narrower =
and
+ * may be signed. Hold it to the range the variable can represent, the w=
ay
+ * veristat's set_global_var() does, and narrow it to what is stored.
+ */
+static int fit_global_var(const char *name, __u32 sz, bool is_signed, __=
u64 *val)
+{
+	long long v =3D (long long)*val;
+	long long max_val;
+	__u32 bits;
+
+	if (sz >=3D sizeof(*val))
+		return 0;
+	bits =3D sz * 8 - (is_signed ? 1 : 0);
+	max_val =3D 1ll << bits;
+	if (v >=3D max_val || v < (is_signed ? -max_val : 0)) {
+		PRINT_FAIL("value %lld for '%s' is out of range [%lld; %lld]\n",
+			   v, name, is_signed ? -max_val : 0, max_val - 1);
+		return -EINVAL;
+	}
+	*val =3D (__u32)*val;
+	return 0;
+}
+
+static int access_global_var(struct bpf_object *obj, const char *name,
+			     __u64 *val, __u32 *sz_out, bool *signed_out, bool set)
+{
+	__u32 off, sz, zero =3D 0;
+	bool is_signed;
+	struct bpf_map *map;
+	size_t vsz;
+	void *buf;
+	int err;
+
+	err =3D find_global_var(obj, name, &map, &off, &sz, &is_signed);
+	if (err)
+		return err;
+	if (sz_out)
+		*sz_out =3D sz;
+	if (signed_out)
+		*signed_out =3D is_signed;
+	if (set) {
+		err =3D fit_global_var(name, sz, is_signed, val);
+		if (err)
+			return err;
+	}
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
@@ -557,6 +811,22 @@ static int parse_test_spec(struct test_loader *teste=
r,
 			spec->mode_mask |=3D UNPRIV;
 			spec->unpriv.execute =3D true;
 			has_unpriv_retval =3D true;
+		} else if ((val =3D str_has_pfx(s, "test_global_set=3D"))) {
+			err =3D parse_global_var(val, spec->priv.set_globals,
+					       &spec->priv.set_global_cnt,
+					       "__set_global");
+			if (err)
+				goto cleanup;
+			spec->priv.execute =3D true;
+			spec->mode_mask |=3D PRIV;
+		} else if ((val =3D str_has_pfx(s, "test_global_ret=3D"))) {
+			err =3D parse_global_var(val, spec->priv.ret_globals,
+					       &spec->priv.ret_global_cnt,
+					       "__ret_global");
+			if (err)
+				goto cleanup;
+			spec->priv.execute =3D true;
+			spec->mode_mask |=3D PRIV;
 		} else if ((val =3D str_has_pfx(s, "test_log_level=3D"))) {
 			err =3D parse_int(val, &spec->log_level, "test log level");
 			if (err)
@@ -742,6 +1012,23 @@ static int parse_test_spec(struct test_loader *test=
er,
 			spec->unpriv.execute =3D spec->priv.execute;
 		}
=20
+		if (spec->priv.set_global_cnt && !spec->unpriv.set_global_cnt) {
+			err =3D clone_global_vars(spec->unpriv.set_globals,
+						&spec->unpriv.set_global_cnt,
+						spec->priv.set_globals,
+						spec->priv.set_global_cnt);
+			if (err)
+				goto cleanup;
+		}
+		if (spec->priv.ret_global_cnt && !spec->unpriv.ret_global_cnt) {
+			err =3D clone_global_vars(spec->unpriv.ret_globals,
+						&spec->unpriv.ret_global_cnt,
+						spec->priv.ret_globals,
+						spec->priv.ret_global_cnt);
+			if (err)
+				goto cleanup;
+		}
+
 		if (spec->unpriv.expect_msgs.cnt =3D=3D 0)
 			clone_msgs(&spec->priv.expect_msgs, &spec->unpriv.expect_msgs);
 		if (spec->unpriv.expect_xlated.cnt =3D=3D 0)
@@ -1356,7 +1643,7 @@ void run_subtest(struct test_loader *tester,
 	struct cap_state caps =3D {};
 	struct bpf_object *tobj;
 	struct bpf_map *map;
-	int retval, err, i;
+	int retval, err, i, gi;
 	int links_cnt =3D 0;
 	bool should_load;
=20
@@ -1532,6 +1819,14 @@ void run_subtest(struct test_loader *tester,
 			}
 		}
=20
+		for (gi =3D 0; gi < subspec->set_global_cnt; gi++) {
+			__u64 v =3D subspec->set_globals[gi].val;
+
+			if (access_global_var(tobj, subspec->set_globals[gi].name,
+					      &v, NULL, NULL, true))
+				goto tobj_cleanup;
+		}
+
 		err =3D do_prog_test_run(bpf_program__fd(tprog), &retval,
 				       bpf_program__type(tprog) =3D=3D BPF_PROG_TYPE_SYSCALL ? true =
: false,
 				       spec->linear_sz);
@@ -1540,6 +1835,23 @@ void run_subtest(struct test_loader *tester,
 			goto tobj_cleanup;
 		}
=20
+		for (gi =3D 0; gi < subspec->ret_global_cnt; gi++) {
+			__u64 want =3D subspec->ret_globals[gi].val, v =3D 0;
+			bool is_signed =3D false;
+			__u32 sz =3D 0;
+
+			if (access_global_var(tobj, subspec->ret_globals[gi].name, &v,
+					      &sz, &is_signed, false))
+				goto tobj_cleanup;
+			if (fit_global_var(subspec->ret_globals[gi].name, sz, is_signed, &wan=
t))
+				goto tobj_cleanup;
+			if (v !=3D want) {
+				PRINT_FAIL("Unexpected %s: 0x%llx !=3D 0x%llx\n",
+					   subspec->ret_globals[gi].name, v, want);
+				goto tobj_cleanup;
+			}
+		}
+
 		verify_stderr(bpf_program__fd(tprog), &subspec->stderr);
=20
 		if (subspec->stdout.cnt) {
--=20
2.53.0-Meta

