Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609593B058A
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205622; cv=none; b=OH+6I8FkPCee3f7Pe7OsvbETdM59DpLMKohVDnXyaWXsUxleqlHfJEzuS6DjwYdzly8HfCMTiueWd31tvDoRim0d2rq0MszQSKKdRMUH/sq6rtzsdRIpGvY+9wNQHUlwrR+QgZDeGPc+hYpwlrxzhRh8dYZ6TI4Ud2TFSX8Z3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205622; c=relaxed/simple;
	bh=TDgFagPXkdd68BFgPw4Sh1umirosGKa5eNSMyrM/ZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVelJAPy7W7P3yGZ7/0OB3wLLajmRQbzqNteJRlYPciubosB3yAkPQuIyIbNFZddbLWxkkz3qgmlZ6kpmBp6p8X2CJ4lpNJkYKqfh3fjPfuoZgQGb0LQskqCNK6iID50+lrkXHr5x0Dixs0wXWepHa7gJNCh4Iu/8J6V1uLFJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 16BD531B3B0199; Fri, 16 Oct 2026 19:53:29 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 23/25] selftests/bpf: Add __set_global() and __ret_global() test tags
Date: Fri, 16 Oct 2026 19:53:29 -0700
Message-ID: <20261017025329.1932529-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A test that looks at a program's state after it ran needs a driver of
its own, though the loader already runs programs for __retval(). What is
missing is reaching their globals:

 - __set_global(var, value) writes one before the run, __ret_global(var,
   value) checks one after it. Both make the loader run the program;
   without __retval() it must return 0. Each may be given several times,
   up to MAX_GLOBAL_VARS.
 - The variable is looked up by name in ".bss" or ".data", and must be
   a four or eight byte int or enum.
 - A value is held to its variable's range and narrowed to its width,
   signedness taken from BTF as in veristat, so a negative literal means
   the same to both tags.
 - A value may be a '|' separated list, so a bitmask reads as it is
   written in the program.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  12 +
 tools/testing/selftests/bpf/test_loader.c    | 319 ++++++++++++++++++-
 2 files changed, 330 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
index d7f706c3bc4a..f5baeb979cc2 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -107,6 +107,16 @@
  *                   - POINTER_VALUE
  *                   - TEST_DATA_LEN
  * __retval_unpriv   Same, but load program in unprivileged mode.
+ * __set_global      Set a global variable of the program to a value bef=
ore
+ *                   executing it. The variable has to be an int or an e=
num,
+ *                   live in .bss or .data and be four or eight bytes wi=
de,
+ *                   and the value is a number or several joined by '|',
+ *                   without parentheses.
+ * __ret_global      Execute the program and check that a global variabl=
e
+ *                   holds the given value afterwards, under the same ru=
les.
+ *                   __set_global and __ret_global both make the loader =
run
+ *                   the program and check its return value; without
+ *                   __retval, the program must return 0.
  *
  * __description     Text to be used for display and as an additional fi=
lter
  *                   alias, while the original program name stays matcha=
ble.
@@ -167,6 +177,8 @@
 #define __flag(flag)		__test_tag("test_prog_flags=3D" #flag)
 #define __retval(val)		__test_tag("test_retval=3D" XSTR(val))
 #define __retval_unpriv(val)	__test_tag("test_retval_unpriv=3D" XSTR(val=
))
+#define __set_global(var, val)	__test_tag("test_global_set=3D" #var ":" =
XSTR(val))
+#define __ret_global(var, val)	__test_tag("test_global_ret=3D" #var ":" =
XSTR(val))
 #define __auxiliary		__test_tag("test_auxiliary")
 #define __auxiliary_unpriv	__test_tag("test_auxiliary_unpriv")
 #define __btf_path(path)	__test_tag("test_btf_path=3D" path)
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
index 18d47e925400..06a01a967b33 100644
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
@@ -311,6 +355,236 @@ static int parse_caps(const char *str, __u64 *val, =
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
+
+	if (!btf) {
+		PRINT_FAIL("no BTF for object\n");
+		return -ENOENT;
+	}
+
+	for (s =3D 0; s < ARRAY_SIZE(secs); s++) {
+		const struct btf_type *sec, *vt;
+		const struct btf_var_secinfo *vsi;
+		struct bpf_map *m =3D bpf_object__find_map_by_name(obj, secs[s]);
+		int id;
+
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
+/* The value of @map's single element, which the caller frees. */
+static void *global_data(struct bpf_map *map, const char *name, size_t *=
vsz)
+{
+	__u32 zero =3D 0;
+	void *buf;
+	int err;
+
+	*vsz =3D bpf_map__value_size(map);
+	buf =3D calloc(1, *vsz);
+	if (!buf) {
+		PRINT_FAIL("failed to allocate %zu bytes for '%s'\n", *vsz, name);
+		return NULL;
+	}
+	err =3D bpf_map__lookup_elem(map, &zero, sizeof(zero), buf, *vsz, 0);
+	if (err) {
+		PRINT_FAIL("failed to read '%s': %d\n", name, err);
+		free(buf);
+		return NULL;
+	}
+	return buf;
+}
+
+static int read_global_var(struct bpf_map *map, const char *name, __u32 =
off,
+			   __u32 sz, __u64 *val)
+{
+	size_t vsz;
+	void *buf;
+
+	buf =3D global_data(map, name, &vsz);
+	if (!buf)
+		return -EINVAL;
+	*val =3D sz =3D=3D 4 ? *(__u32 *)(buf + off) : *(__u64 *)(buf + off);
+	free(buf);
+	return 0;
+}
+
+static int write_global_var(struct bpf_map *map, const char *name, __u32=
 off,
+			    __u32 sz, __u64 val)
+{
+	__u32 zero =3D 0;
+	size_t vsz;
+	void *buf;
+	int err;
+
+	buf =3D global_data(map, name, &vsz);
+	if (!buf)
+		return -EINVAL;
+	if (sz =3D=3D 4)
+		*(__u32 *)(buf + off) =3D val;
+	else
+		*(__u64 *)(buf + off) =3D val;
+	err =3D bpf_map__update_elem(map, &zero, sizeof(zero), buf, vsz, 0);
+	if (err)
+		PRINT_FAIL("failed to write '%s': %d\n", name, err);
+	free(buf);
+	return err;
+}
+
+/* Write a __set_global() value into the program's global variable. */
+static int set_global_var(struct bpf_object *obj, const struct global_va=
r *var)
+{
+	__u64 val =3D var->val;
+	struct bpf_map *map;
+	__u32 off, sz;
+	bool is_signed;
+
+	if (find_global_var(obj, var->name, &map, &off, &sz, &is_signed) ||
+	    fit_global_var(var->name, sz, is_signed, &val))
+		return -EINVAL;
+	return write_global_var(map, var->name, off, sz, val);
+}
+
+/* Check the program's global variable against a __ret_global() value. *=
/
+static int check_global_var(struct bpf_object *obj, const struct global_=
var *var)
+{
+	__u64 want =3D var->val, val;
+	struct bpf_map *map;
+	__u32 off, sz;
+	bool is_signed;
+
+	if (find_global_var(obj, var->name, &map, &off, &sz, &is_signed) ||
+	    fit_global_var(var->name, sz, is_signed, &want) ||
+	    read_global_var(map, var->name, off, sz, &val))
+		return -EINVAL;
+	if (val !=3D want) {
+		PRINT_FAIL("Unexpected %s: 0x%llx !=3D 0x%llx\n", var->name,
+			   (unsigned long long)val, (unsigned long long)want);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int parse_retval(const char *str, int *val, const char *name)
 {
 	/*
@@ -567,6 +841,22 @@ static int parse_test_spec(struct test_loader *teste=
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
@@ -754,6 +1044,23 @@ static int parse_test_spec(struct test_loader *test=
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
@@ -1369,7 +1676,7 @@ void run_subtest(struct test_loader *tester,
 	struct cap_state caps =3D {};
 	struct bpf_object *tobj;
 	struct bpf_map *map;
-	int retval, err, i;
+	int retval, err, i, j;
 	int links_cnt =3D 0;
 	bool should_load;
=20
@@ -1545,6 +1852,11 @@ void run_subtest(struct test_loader *tester,
 			}
 		}
=20
+		for (j =3D 0; j < subspec->set_global_cnt; j++) {
+			if (set_global_var(tobj, &subspec->set_globals[j]))
+				goto tobj_cleanup;
+		}
+
 		err =3D do_prog_test_run(bpf_program__fd(tprog), &retval,
 				       bpf_program__type(tprog) =3D=3D BPF_PROG_TYPE_SYSCALL ? true =
: false,
 				       spec->linear_sz);
@@ -1553,6 +1865,11 @@ void run_subtest(struct test_loader *tester,
 			goto tobj_cleanup;
 		}
=20
+		for (j =3D 0; !err && j < subspec->ret_global_cnt; j++) {
+			if (check_global_var(tobj, &subspec->ret_globals[j]))
+				goto tobj_cleanup;
+		}
+
 		verify_stderr(bpf_program__fd(tprog), &subspec->stderr);
=20
 		if (subspec->stdout.cnt) {
--=20
2.53.0-Meta

