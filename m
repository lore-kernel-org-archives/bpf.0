Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523523375DF;
	Fri, 20 Feb 2026 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582167; cv=none; b=rtBd2nuSm15Gs7Dx1+KyRSOtnWNT1o8/ftP2T0/CR1+9egJ46lA6rFYDJsKOC+xE9yXsD4VFpgcim8BYvbzjjAL5O4n8FZOBovqCT+m6pq1Sxd0a/Aizz2/jlDKj/kqE0EosYnjpnqUhmq9kPvr41D1Dj4Ld9z3ZPJd7zXiBbs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582167; c=relaxed/simple;
	bh=yEYJ8l2dmkbG+CyRs+froMQQrPIoWRejJx8B++q5lUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbfEs6Cs7t9ykEApPLWAuUiLoxmkY18sDmpt8nn/3LNipl0Pujh3Dvr0EiGXRAEajtEhm6XToCP5ULZy2ZkqLh836JS5eMMdByQbG0b/ugEnGK59t+u3u981awDuP5oRf1W14Q5Fu8qFIkxWC3BPEdcNwa+lMIS+gxs2UbVm2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fegWUCvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fegWUCvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1EEC116C6;
	Fri, 20 Feb 2026 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582167;
	bh=yEYJ8l2dmkbG+CyRs+froMQQrPIoWRejJx8B++q5lUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fegWUCvk6NcqSTMkzkpr6DH/0yE8+8HHwGcJsO5KDXSUg6Y0mD8u83ZSG4lM8huHP
	 9TRTrlY1pomhLUA3uhlrthUnpCOUNwmULI62JG/E4KeRRF3mYIl5RPC/LOGS6LNBU/
	 94qOs/mR5S7//RJRq1lzEF+RnyHDWRAEiKctN7m2TrfkGi3uswdzv/H4OLE4GsWuZR
	 Lf8Oeg5P0XT2qFnsMBZmRhBUESXXKLRQEuyLmb2vcLFnz0NdUcrBWTXtwfGBX/JCuo
	 P1p8N39z5aV+ZWOw3Mg35gbJSg8JAVmIfTxGCz7N8WJhc8SPiozJsmsIdxasOHdwe5
	 CP3tOohIkSRbw==
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
Subject: [PATCH bpf-next 11/17] libbpf: Add support to create tracing multi link
Date: Fri, 20 Feb 2026 11:06:43 +0100
Message-ID: <20260220100649.628307-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c      |   9 ++
 tools/lib/bpf/bpf.h      |   5 +
 tools/lib/bpf/libbpf.c   | 196 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  15 +++
 tools/lib/bpf/libbpf.map |   1 +
 5 files changed, 226 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5846de364209..6c741df4c311 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -790,6 +790,15 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION_MULTI:
+		attr.link_create.tracing_multi.ids = (__u64) OPTS_GET(opts, tracing_multi.ids, 0);
+		attr.link_create.tracing_multi.cookies = (__u64) OPTS_GET(opts, tracing_multi.cookies, 0);
+		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..726a6fa585b3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -454,6 +454,11 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} cgroup;
+		struct {
+			__u32 *ids;
+			__u64 *cookies;
+			__u32 cnt;
+		} tracing_multi;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1eb3869e3444..82eca31a8cc2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9827,6 +9827,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -9875,6 +9876,12 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -12250,6 +12257,195 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
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
+struct bpf_link *
+bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
+				  const struct bpf_tracing_multi_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	__u32 *ids, cnt, *free_ids = NULL;
+	__u64 *cookies;
+	int prog_fd, link_fd, err;
+	struct bpf_link *link;
+
+	ids = OPTS_GET(opts, ids, NULL);
+	cookies = OPTS_GET(opts, cookies, NULL);
+	cnt = OPTS_GET(opts, cnt, 0);
+
+	if (!!ids != !!cnt)
+		return libbpf_err_ptr(-EINVAL);
+	if (pattern && (ids || cookies))
+		return libbpf_err_ptr(-EINVAL);
+	if (!pattern && !ids)
+		return libbpf_err_ptr(-EINVAL);
+
+	if (pattern) {
+		err = bpf_object__load_vmlinux_btf(prog->obj, true);
+		if (err)
+			return libbpf_err_ptr(err);
+
+		cnt = collect_btf_func_ids_by_glob(prog->obj->btf_vmlinux, pattern, &ids);
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
+	bool is_fexit, is_fsession;
+	const char *spec;
+	char *pattern;
+	int n;
+
+	/* Do not allow auto attach if there's no function pattern. */
+	if (strcmp(prog->sec_name, "fentry.multi") == 0 ||
+	    strcmp(prog->sec_name, "fexit.multi") == 0 ||
+	    strcmp(prog->sec_name, "fsession.multi") == 0 ||
+	    strcmp(prog->sec_name, "fentry.multi.s") == 0 ||
+	    strcmp(prog->sec_name, "fexit.multi.s") == 0 ||
+	    strcmp(prog->sec_name, "fsession.multi.s") == 0)
+		return 0;
+
+	is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/");
+	is_fsession = str_has_pfx(prog->sec_name, "fsession.multi/");
+
+	if (is_fsession)
+		spec = prog->sec_name + sizeof("fsession.multi/") - 1;
+	else if (is_fexit)
+		spec = prog->sec_name + sizeof("fexit.multi/") - 1;
+	else
+		spec = prog->sec_name + sizeof("fentry.multi/") - 1;
+
+	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
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
2.52.0

