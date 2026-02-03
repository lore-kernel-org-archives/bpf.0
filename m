Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC05396D09;
	Tue,  3 Feb 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111599; cv=none; b=BzQ8bWF8VwXODHVHa+nZTDReJdyrkKQv6sZEPIOee86OcVY7JBLDDvUXrbaQIxc1TLwIK72KKqoM7K3hfd1gqWlZn6wieRx8YVw8ycDJWqEWJWHqYdnaOoDDUuQGuihJF6QmiJcTrwaC2V6eT6cbodNxXAF5p2DOHxNlHEoOhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111599; c=relaxed/simple;
	bh=kZu+SSQDBT2V2LKXbOy4/q56K0pnhnO4CKWfwwwT5QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAgtylYojyPWxGmXFZpIlyO1qRa2sL4MQBOMW2kDNqKNLvfAO/5PeuvG33SVoTaOpySLTO160aLJSDCYlyhJ9A5Hhkp252+j1Ke0GJgp6L3XIJTnHxmSHS+lN6RjClFXMpavGXGtIoYF36wy7SApDaHELVbtmbdNJfYjz8guksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF8AugBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF8AugBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7436C116D0;
	Tue,  3 Feb 2026 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111599;
	bh=kZu+SSQDBT2V2LKXbOy4/q56K0pnhnO4CKWfwwwT5QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YF8AugBn4i7deEfjS5olATUvy+E5h8ChNnbplR1xFAT1L3AqRfeZZk9bMZjGdkLZW
	 7l2f84rAAYIlCGZBuMZ61mX4khQoKB9dlvUUdel7QA+HR8rn/HN4BHFTQMCgS/2MQW
	 l8YCbQeQuPJimdOC9qFfJWFGPXAC2EYyzC+1ih4gz7svV6aJb9y+A9vWnFxZT64bxm
	 IE1yA7xBmXS52tz0LP+IxGjRcbXgyyhVY5R60tFznyI1JbkY2FKAw/vRP5plfsqfMf
	 asPkm16rH6hADCwRvE3p3UNpfLQYmHVONyOgnx6QGMNKGoJrLO04mMrqzavn/ySr0c
	 jj85fB60eu3jw==
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
Subject: [RFC bpf-next 09/12] libbpf: Add support to create tracing multi link
Date: Tue,  3 Feb 2026 10:38:16 +0100
Message-ID: <20260203093819.2105105-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new interface function to attach programs with tracing
multi link:

  bpf_program__attach_tracing_multi(const struct bpf_program *prog,
                                    const char *pattern,
                                    const struct bpf_tracing_multi_opts *opts);

The program is attach to functions specified by pattern or by
btf IDs specified in bpf_tracing_multi_opts object.

Adding support for new sections to attach programs with above
functions:

   fentry.multi/pattern
   fexit.multi/pattern

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/bpf.c      |  7 ++++
 tools/lib/bpf/bpf.h      |  4 ++
 tools/lib/bpf/libbpf.c   | 87 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 14 +++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 113 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5846de364209..cee1fc6bbfd6 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -790,6 +790,13 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+		attr.link_create.tracing_multi.btf_ids = (__u64) OPTS_GET(opts, tracing_multi.btf_ids, 0);
+		attr.link_create.tracing_multi.btf_ids_cnt = OPTS_GET(opts, tracing_multi.btf_ids_cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..005f884f9a0c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -454,6 +454,10 @@ struct bpf_link_create_opts {
 			__u32 relative_id;
 			__u64 expected_revision;
 		} cgroup;
+		struct {
+			__u32 *btf_ids;
+			__u32  btf_ids_cnt;
+		} tracing_multi;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..a16243300083 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -136,6 +136,8 @@ static const char * const attach_type_name[] = {
 	[BPF_NETKIT_PEER]		= "netkit_peer",
 	[BPF_TRACE_KPROBE_SESSION]	= "trace_kprobe_session",
 	[BPF_TRACE_UPROBE_SESSION]	= "trace_uprobe_session",
+	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
+	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -154,6 +156,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
 	[BPF_LINK_TYPE_NETKIT]			= "netkit",
 	[BPF_LINK_TYPE_SOCKMAP]			= "sockmap",
+	[BPF_LINK_TYPE_TRACING_MULTI]		= "tracing_multi",
 };
 
 static const char * const map_type_name[] = {
@@ -9814,6 +9817,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -9862,6 +9866,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fsession+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fentry.multi+",	TRACING, BPF_TRACE_FENTRY_MULTI, 0, attach_tracing_multi),
+	SEC_DEF("fexit.multi+",		TRACING, BPF_TRACE_FEXIT_MULTI, 0, attach_tracing_multi),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
@@ -12237,6 +12243,87 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return ret;
 }
 
+struct bpf_link *
+bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
+				  const struct bpf_tracing_multi_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	__u32 *btf_ids, cnt, *free_ids = NULL;
+	int prog_fd, link_fd, err;
+	struct bpf_link *link;
+
+	btf_ids = OPTS_GET(opts, btf_ids, false);
+	cnt = OPTS_GET(opts, cnt, false);
+
+	if (!pattern && !btf_ids && !cnt)
+		return libbpf_err_ptr(-EINVAL);
+	if (pattern && (btf_ids || cnt))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (pattern) {
+		err = bpf_object__load_vmlinux_btf(prog->obj, true);
+		if (err)
+			return libbpf_err_ptr(err);
+
+		cnt = btf__find_by_glob_kind(prog->obj->btf_vmlinux, BTF_KIND_FUNC,
+					     pattern, NULL, &btf_ids);
+		if (cnt <= 0)
+			return libbpf_err_ptr(-EINVAL);
+		free_ids = btf_ids;
+	}
+
+	lopts.tracing_multi.btf_ids = btf_ids;
+	lopts.tracing_multi.btf_ids_cnt = cnt;
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-ENOMEM);
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
+error:
+	free(link);
+	free(free_ids);
+	return libbpf_err_ptr(err);
+}
+
+static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	const char *spec;
+	char *pattern;
+	bool is_fexit;
+	int n;
+
+	/* no auto-attach for SEC("fentry.multi") and SEC("fexit.multi") */
+	if (strcmp(prog->sec_name, "fentry.multi") == 0 ||
+	    strcmp(prog->sec_name, "fexit.multi") == 0)
+		return 0;
+
+	is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/");
+	if (is_fexit)
+		spec = prog->sec_name + sizeof("fexit.multi/") - 1;
+	else
+		spec = prog->sec_name + sizeof("fentry.multi/") - 1;
+
+	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
+	if (n < 1) {
+		pr_warn("tracing multi pattern is invalid: %s\n", pattern);
+		return -EINVAL;
+	}
+
+	*link = bpf_program__attach_tracing_multi(prog, pattern, NULL);
+	return libbpf_get_error(*link);
+}
+
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index dfc37a615578..fa74a88f6c4a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -701,6 +701,20 @@ bpf_program__attach_ksyscall(const struct bpf_program *prog,
 			     const char *syscall_name,
 			     const struct bpf_ksyscall_opts *opts);
 
+struct bpf_tracing_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 *btf_ids;
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
index d18fbcea7578..a3ffb21270e9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -358,6 +358,7 @@ LIBBPF_1.0.0 {
 		bpf_program__attach_ksyscall;
 		bpf_program__autoattach;
 		bpf_program__set_autoattach;
+		bpf_program__attach_tracing_multi;
 		btf__add_enum64;
 		btf__add_enum64_value;
 		libbpf_bpf_attach_type_str;
-- 
2.52.0

