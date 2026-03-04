Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4933F5A4;
	Wed,  4 Mar 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663068; cv=none; b=opRD2pL5xZoxA+IdwLclO6DAh0OOzmH+p+pfKQDwtv6g1dm5gbL9xKXJb59r0XyopRG8tuancrB0Q2BUUTYp+Vo1c80mjDa58jsWwKkJUN9W8663ebvkVEySjOo8Cu5nN+dFJQnvkB3vPa8VCHnlQaKcBYTn1hZDtHUan8XCULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663068; c=relaxed/simple;
	bh=1CN9ti/jGVGGPb/ksrdg7QFRmW8HRri2WATW2Z5XmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLOKn/MAxCITOtFeKK7Xr7mI/thsVOhUbHEWgEYcadGlbffMFk3R7XXnk74NYxdFqvD1lIFJk4bRNtLswF9mw/Xb+drjCxQVMalx5wtITdDXMHaMIN3urqaEoxwQw4ZzioviH52e6kaznxsPHnqKcSVaAg5rqGatgM/BkdTOui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYU/gBPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYU/gBPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B217C19425;
	Wed,  4 Mar 2026 22:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663068;
	bh=1CN9ti/jGVGGPb/ksrdg7QFRmW8HRri2WATW2Z5XmIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYU/gBPnopptOe1KlgLg3lVnbdB53XvuqybszWCTI/QRme6mOID9c3mwLO0zUodxK
	 nYCSTzF+Ac37s3qLuJOMlz8KQiITDj52odmZmEVqyFVPuka0mTaYwnUeTfgImwvEHr
	 BKs1+GT/56iilK9tGjgX+ObtX/Oy1m2mcEbtGz9y1NInaHqXBicmjvMW0nBv9Yqwev
	 GNo+CFvZw1DtCO3HYXrv/iexwcmw7LvQhVqnZdfcDI0p9Zz0ACbTpAi/jts73ElkSv
	 ofgQ5pbUFtncxgd6zs7c/ZAJcnnZBCHuH/HsIOKCI04inZe9qbbjdaJDup8Mkmn15l
	 nUEDRc5j6Ygeg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv2 bpf-next 15/23] libbpf: Add support to create tracing multi link
Date: Wed,  4 Mar 2026 23:21:33 +0100
Message-ID: <20260304222141.497203-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpf_program__attach_tracing_multi function for attaching
tracing program to multiple functions.

  struct bpf_link *
  bpf_program__attach_tracing_multi(const struct bpf_program *prog,
                                    const char *pattern,
                                    const struct bpf_tracing_multi_opts *opts);

User can specify functions to attach with 'pattern' argument that
allows wildcards (*?' supported) or provide BTF ids of functions
in array directly via opts argument. These options are mutually
exclusive.

When using BTF ids, user can also provide cookie value for each
provided id/function, that can be retrieved later in bpf program
with bpf_get_attach_cookie helper. Each cookie value is paired with
provided BTF id with the same array index.

Adding support to auto attach programs with following sections:

  fsession.multi/<pattern>
  fsession.multi.s/<pattern>
  fentry.multi/<pattern>
  fexit.multi/<pattern>
  fentry.multi.s/<pattern>
  fexit.multi.s/<pattern>

The provided <pattern> is used as 'pattern' argument in
bpf_program__attach_kprobe_multi_opts function.

The <pattern> allows to specify optional kernel module name with
following syntax:

  <module>:<function_pattern>

In order to attach tracing_multi link to a module functions:
- program must be loaded with 'module' btf fd
  (in attr::attach_btf_obj_fd)
- bpf_program__attach_kprobe_multi_opts must either have
  pattern with module spec or BTF ids from the module

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 309 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  15 ++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 325 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 34987ce7cdc8..8842adcf8c8a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7716,6 +7716,52 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attach_name,
 				     int *btf_obj_fd, int *btf_type_id);
 
+static inline bool is_tracing_multi(enum bpf_attach_type type)
+{
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI ||
+	       type == BPF_TRACE_FSESSION_MULTI;
+}
+
+static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
+{
+	const char *attach_name, *sep, *mod_name = NULL;
+	int i, err, mod_len = 0;
+
+	*btf_obj_fd = 0;
+	attach_name = strchr(prog->sec_name, '/');
+
+	/* Program with no details in spec, using kernel btf. */
+	if (!attach_name)
+		return 0;
+
+	attach_name++;
+	sep = strchr(attach_name, ':');
+	if (sep) {
+		mod_name = attach_name;
+		mod_len = sep - mod_name;
+	}
+
+	/* Program with no module section, using kernel btf. */
+	if (!mod_name)
+		return 0;
+
+	err = load_module_btfs(prog->obj);
+	if (err)
+		return err;
+
+	for (i = 0; i < prog->obj->btf_module_cnt; i++) {
+		const struct module_btf *mod = &prog->obj->btf_modules[i];
+
+		if (mod_name && strncmp(mod->name, mod_name, mod_len) == 0) {
+			*btf_obj_fd = mod->fd;
+			return 0;
+		}
+	}
+
+	/* Specified module was not found, let's bail out. */
+	return -EINVAL;
+}
+
 /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
 static int libbpf_prepare_prog_load(struct bpf_program *prog,
 				    struct bpf_prog_load_opts *opts, long cookie)
@@ -7779,6 +7825,18 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		opts->attach_btf_obj_fd = btf_obj_fd;
 		opts->attach_btf_id = btf_type_id;
 	}
+
+	if (is_tracing_multi(prog->expected_attach_type)) {
+		int err, btf_obj_fd = 0;
+
+		err = tracing_multi_mod_fd(prog, &btf_obj_fd);
+		if (err < 0)
+			return err;
+
+		prog->attach_btf_obj_fd = btf_obj_fd;
+		opts->attach_btf_obj_fd = btf_obj_fd;
+	}
+
 	return 0;
 }
 
@@ -9835,6 +9893,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -9883,6 +9942,12 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fsession+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession.multi+",	TRACING, BPF_TRACE_FSESSION_MULTI, 0, attach_tracing_multi),
+	SEC_DEF("fsession.multi.s+",	TRACING, BPF_TRACE_FSESSION_MULTI, SEC_SLEEPABLE, attach_tracing_multi),
+	SEC_DEF("fentry.multi+",	TRACING, BPF_TRACE_FENTRY_MULTI, 0, attach_tracing_multi),
+	SEC_DEF("fexit.multi+",		TRACING, BPF_TRACE_FEXIT_MULTI, 0, attach_tracing_multi),
+	SEC_DEF("fentry.multi.s+",	TRACING, BPF_TRACE_FENTRY_MULTI, SEC_SLEEPABLE, attach_tracing_multi),
+	SEC_DEF("fexit.multi.s+",	TRACING, BPF_TRACE_FEXIT_MULTI, SEC_SLEEPABLE, attach_tracing_multi),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
@@ -12258,6 +12323,250 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return ret;
 }
 
+#define MAX_BPF_FUNC_ARGS 12
+
+static bool btf_type_is_modifier(const struct btf_type *t)
+{
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool is_allowed_func(const struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_type *proto;
+	const struct btf_param *args;
+	__u32 i, nargs;
+	__s64 ret;
+
+	proto = btf_type_by_id(btf, t->type);
+	if (BTF_INFO_KIND(proto->info) != BTF_KIND_FUNC_PROTO)
+		return false;
+
+	args = (const struct btf_param *)(proto + 1);
+	nargs = btf_vlen(proto);
+	if (nargs > MAX_BPF_FUNC_ARGS)
+		return false;
+
+	/* No support for struct/union return argument type. */
+	t = btf__type_by_id(btf, proto->type);
+	while (t && btf_type_is_modifier(t))
+		t = btf__type_by_id(btf, t->type);
+
+	if (btf_is_struct(t) || btf_is_union(t))
+		return false;
+
+	for (i = 0; i < nargs; i++) {
+		/* No support for variable args. */
+		if (i == nargs - 1 && args[i].type == 0)
+			return false;
+
+		/* No support of struct argument size greater than 16 bytes. */
+		ret = btf__resolve_size(btf, args[i].type);
+		if (ret < 0 || ret > 16)
+			return false;
+	}
+
+	return true;
+}
+
+static int
+collect_btf_func_ids_by_glob(const struct btf *btf, const char *pattern, __u32 **ids)
+{
+	__u32 type_id, nr_types = btf__type_cnt(btf);
+	size_t cap = 0, cnt = 0;
+
+	if (!pattern)
+		return -EINVAL;
+
+	for (type_id = 1; type_id < nr_types; type_id++) {
+		const struct btf_type *t = btf__type_by_id(btf, type_id);
+		const char *name;
+		int err;
+
+		if (btf_kind(t) != BTF_KIND_FUNC)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (!glob_match(name, pattern))
+			continue;
+		if (!is_allowed_func(btf, t))
+			continue;
+
+		err = libbpf_ensure_mem((void **) ids, &cap, sizeof(**ids), cnt + 1);
+		if (err) {
+			free(*ids);
+			return -ENOMEM;
+		}
+		(*ids)[cnt++] = type_id;
+	}
+
+	return cnt;
+}
+
+static int collect_func_ids_by_glob(struct bpf_object *obj, const char *pattern, __u32 **ids)
+{
+	const char *mod_name = NULL, *sep;
+	int i, err, mod_len = 0;
+	struct btf *btf = NULL;
+
+	err = bpf_object__load_vmlinux_btf(obj, true);
+	if (err)
+		return err;
+
+	/* In case we have module specified, we will find its btf and use that. */
+	sep = strchr(pattern, ':');
+	if (sep) {
+		mod_name = pattern;
+		mod_len = sep - pattern;
+		pattern = sep + 1;
+
+		err = load_module_btfs(obj);
+		if (err)
+			goto cleanup;
+
+		for (i = 0; i < obj->btf_module_cnt; i++) {
+			const struct module_btf *mod = &obj->btf_modules[i];
+
+			if (!strncmp(mod->name, mod_name, mod_len)) {
+				btf = mod->btf;
+				break;
+			}
+		}
+		if (!btf) {
+			err = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		btf = obj->btf_vmlinux;
+	}
+
+	err = collect_btf_func_ids_by_glob(btf, pattern, ids);
+
+cleanup:
+	bpf_object_cleanup_btf(obj);
+	return err;
+}
+
+struct bpf_link *
+bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
+				  const struct bpf_tracing_multi_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	__u32 *ids, *free_ids = NULL;
+	__u64 *cookies;
+	int prog_fd, link_fd, err, cnt;
+	struct bpf_link *link;
+
+	cnt = OPTS_GET(opts, cnt, 0);
+	ids = OPTS_GET(opts, ids, NULL);
+	cookies = OPTS_GET(opts, cookies, NULL);
+
+	if (!!ids != !!cnt)
+		return libbpf_err_ptr(-EINVAL);
+	if (pattern && (ids || cookies))
+		return libbpf_err_ptr(-EINVAL);
+	if (!pattern && !ids)
+		return libbpf_err_ptr(-EINVAL);
+
+	if (pattern) {
+		cnt = collect_func_ids_by_glob(prog->obj, pattern, &ids);
+		if (cnt < 0)
+			return libbpf_err_ptr(cnt);
+		if (cnt == 0)
+			return libbpf_err_ptr(-EINVAL);
+		free_ids = ids;
+	}
+
+	lopts.tracing_multi.ids = ids;
+	lopts.tracing_multi.cookies = cookies;
+	lopts.tracing_multi.cnt = cnt;
+
+	link = calloc(1, sizeof(*link));
+	if (!link) {
+		err = -ENOMEM;
+		goto error;
+	}
+	link->detach = &bpf_link__detach_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	link_fd = bpf_link_create(prog_fd, 0, prog->expected_attach_type, &lopts);
+	if (link_fd < 0) {
+		err = -errno;
+		pr_warn("prog '%s': failed to attach: %s\n", prog->name, errstr(err));
+		goto error;
+	}
+	link->fd = link_fd;
+	free(free_ids);
+	return link;
+
+error:
+	free(link);
+	free(free_ids);
+	return libbpf_err_ptr(err);
+}
+
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	static const char *const prefixes[] = {
+		"fentry.multi",
+		"fexit.multi",
+		"fsession.multi",
+		"fentry.multi.s",
+		"fexit.multi.s",
+		"fsession.multi.s",
+	};
+	const char *spec = NULL;
+	char *pattern;
+	size_t i;
+	int n;
+
+	*link = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
+		size_t pfx_len;
+
+		if (!str_has_pfx(prog->sec_name, prefixes[i]))
+			continue;
+
+		pfx_len = strlen(prefixes[i]);
+		/* no auto-attach case of, e.g., SEC("fentry.multi") */
+		if (prog->sec_name[pfx_len] == '\0')
+			return 0;
+
+		if (prog->sec_name[pfx_len] != '/')
+			continue;
+
+		spec = prog->sec_name + pfx_len + 1;
+		break;
+	}
+
+	if (!spec) {
+		pr_warn("prog '%s': invalid section name '%s'\n",
+			prog->name, prog->sec_name);
+		return -EINVAL;
+	}
+
+	n = sscanf(spec, "%m[a-zA-Z0-9_.*?:]", &pattern);
+	if (n < 1) {
+		pr_warn("tracing multi pattern is invalid: %s\n", spec);
+		return -EINVAL;
+	}
+
+	*link = bpf_program__attach_tracing_multi(prog, pattern, NULL);
+	free(pattern);
+	return libbpf_get_error(*link);
+}
+
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index dfc37a615578..b677aea7e592 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -701,6 +701,21 @@ bpf_program__attach_ksyscall(const struct bpf_program *prog,
 			     const char *syscall_name,
 			     const struct bpf_ksyscall_opts *opts);
 
+struct bpf_tracing_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 *ids;
+	__u64 *cookies;
+	size_t cnt;
+	size_t :0;
+};
+
+#define bpf_tracing_multi_opts__last_field cnt
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
+				  const struct bpf_tracing_multi_opts *opts);
+
 struct bpf_uprobe_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d18fbcea7578..ff4d7b2c8a14 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
+		bpf_program__attach_tracing_multi;
 		bpf_program__assoc_struct_ops;
 		btf__permute;
 } LIBBPF_1.6.0;
-- 
2.53.0

