Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8883CCA11;
	Wed,  3 Jun 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484981; cv=none; b=CuW+l90aoWYFPwaqJ88VgUXoDWwq8w9grReyDeN2mKFQHoW7S6GlnG3O/GszKCd8zDUqtjT/D+bnz1xgmLLtIXr7PekIa3pq4dOyDMrLZg7vDeRGACwcE2IhkFNZuUE/UarhQoYVjF9GeK9x0eMPDmFvA9eLpjFUni8w/WHz3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484981; c=relaxed/simple;
	bh=Q6n0zO3xhpvT+8EvV8IBvFru2tUNIw9xiBUosZ1d3eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu8Iix+wuCJ0dSkKBp5///HCBhwwPwmXK2oogTjl8SmQ6Nspp0E4DKWlUZyNfY+d35fqWcZmfM5ZJyzxY1cVNmPYLPiHJEr2SjhWQ+GDLJs6tLsSSEgDJT/fvWatE9DaM4Jz6Vtrjrg7IEmgrR5RNNEkFp8ykhXtHs5QYYpl+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNiOiN/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNiOiN/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3741F00893;
	Wed,  3 Jun 2026 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484979;
	bh=jDtfhtIQITj7iFmcio5HhvWRmsGz1idEDmc2EDjolj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNiOiN/yyWp9ZqzxdDRef7MRVPMLML6rYRDCuETovUdO6+wG6jSsqXo4hLm72YXNf
	 OsB2DUsRKDugpidMYxeGjXyx2MEZ7BIxqfels3zeWERgJ+OQjS4aPu7ERYdmKjVzs4
	 0eYqBsNR1j5ACOijcFrGKwXXLgyf4+Q5VYn4V48wCvQQSVB0UuuiNT0XHgBFWUOJtH
	 /ETVgPc25My5ytTnJFHqD+BUsCnwUMFvAQ1hIadHyMsxFvcHOwd6C9gL1oVrO7Go79
	 p90u69t28HyMNhNRXwKvNkHdAlrt/tSqSHXJMkhtSkcoyi4iTJ5jegst8CJXAITwCQ
	 wj3xsZW0YeW/g==
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
Subject: [PATCHv7 bpf-next 20/29] libbpf: Add support to create tracing multi link
Date: Wed,  3 Jun 2026 13:05:44 +0200
Message-ID: <20260603110554.29590-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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
- bpf_program__attach_tracing_multi must either have
  pattern with module spec or BTF ids from the module

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 276 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  15 +++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 292 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index df3fe00f8b6f..d92eb3e2975c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7771,6 +7771,69 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attach_name,
 				     int *btf_obj_fd, int *btf_type_id);
 
+static inline bool is_tracing_multi(enum bpf_attach_type type)
+{
+	return type == BPF_TRACE_FENTRY_MULTI || type == BPF_TRACE_FEXIT_MULTI ||
+	       type == BPF_TRACE_FSESSION_MULTI;
+}
+
+static const struct module_btf *find_attach_module(struct bpf_object *obj, const char *attach)
+{
+	const char *sep, *mod_name = NULL;
+	int i, mod_len, err;
+
+	/*
+	 * We expect attach string in the form of either
+	 * - function_pattern or
+	 * - <module>:function_pattern
+	 */
+	sep = strchr(attach, ':');
+	if (sep) {
+		mod_name = attach;
+		mod_len = sep - mod_name;
+	}
+	if (!mod_name)
+		return NULL;
+
+	err = load_module_btfs(obj);
+	if (err)
+		return NULL;
+
+	for (i = 0; i < obj->btf_module_cnt; i++) {
+		const struct module_btf *mod = &obj->btf_modules[i];
+
+		if (strncmp(mod->name, mod_name, mod_len) == 0 && mod->name[mod_len] == '\0')
+			return mod;
+	}
+	return NULL;
+}
+
+static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
+{
+	const char *attach_name, *sep;
+	const struct module_btf *mod;
+
+	*btf_obj_fd = 0;
+	attach_name = strchr(prog->sec_name, '/');
+
+	/* Program with no details in spec, using kernel btf. */
+	if (!attach_name)
+		return 0;
+
+	/* Program with no module section, using kernel btf. */
+	sep = strchr(++attach_name, ':');
+	if (!sep)
+		return 0;
+
+	/* Program with module specified, get its btf fd. */
+	mod = find_attach_module(prog->obj, attach_name);
+	if (!mod)
+		return -EINVAL;
+
+	*btf_obj_fd = mod->fd;
+	return 0;
+}
+
 /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
 static int libbpf_prepare_prog_load(struct bpf_program *prog,
 				    struct bpf_prog_load_opts *opts, long cookie)
@@ -7834,6 +7897,18 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
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
 
@@ -9995,6 +10070,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -10048,6 +10124,12 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -12528,6 +12610,200 @@ bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t)
 	return true;
 }
 
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
+		if (!btf_type_is_traceable_func(btf, t))
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
+static int collect_func_ids_by_glob(const struct bpf_program *prog, const char *pattern, __u32 **ids)
+{
+	struct bpf_object *obj = prog->obj;
+	const struct module_btf *mod;
+	struct btf *btf = NULL;
+	const char *sep;
+	int err;
+
+	err = bpf_object__load_vmlinux_btf(obj, true);
+	if (err)
+		return err;
+
+	/* In case we have module specified, we will find its btf and use that. */
+	sep = strchr(pattern, ':');
+	if (sep) {
+		mod = find_attach_module(obj, pattern);
+		if (!mod) {
+			err = -EINVAL;
+			goto cleanup;
+		}
+		btf = mod->btf;
+		pattern = sep + 1;
+	} else {
+		/* Program is loaded for kernel module. */
+		if (prog->attach_btf_obj_fd) {
+			err = -EINVAL;
+			goto cleanup;
+		}
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
+	int prog_fd, link_fd, err, cnt;
+	__u32 *free_ids = NULL;
+	struct bpf_link *link;
+	const __u64 *cookies;
+	const __u32 *ids;
+
+	if (!OPTS_VALID(opts, bpf_tracing_multi_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach BPF program without FD (was it loaded?)\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
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
+		cnt = collect_func_ids_by_glob(prog, pattern, &free_ids);
+		if (cnt < 0)
+			return libbpf_err_ptr(cnt);
+		if (cnt == 0)
+			return libbpf_err_ptr(-EINVAL);
+		ids = (const __u32 *) free_ids;
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
index bba4e8464396..b965ad571540 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -726,6 +726,21 @@ bpf_program__attach_ksyscall(const struct bpf_program *prog,
 			     const char *syscall_name,
 			     const struct bpf_ksyscall_opts *opts);
 
+struct bpf_tracing_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	const __u32 *ids;
+	const __u64 *cookies;
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
index dfed8d60af05..b731df19ae69 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_program__attach_tracing_multi;
 		bpf_program__clone;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.54.0

