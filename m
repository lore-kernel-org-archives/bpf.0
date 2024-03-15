Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9A17BAE
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535540; cv=none; b=QX4gVlIBlnZoG4kfg+r0q9VOU1NMzSCPmviO3+7zEmK0kEZxMmn21RrE1XxteHDocaMrYJwxebYjk+0+9sqCeUvoOoWNyDMJBVAyu+KUePG5dl09OEmHsnmnC5px63YyAX0KIJBL0iMvhaAB6abrCmiMyW0w4x2ZJfGB6C1R1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535540; c=relaxed/simple;
	bh=WXohfyNw+oq0vhflWbay1a6y3nkEj64hKIGK6Bbr9ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy/slA0AYSnYo0UG4TtwSMOLpxQbhkr7IVENt7NTBvAZAMl8ujq8gDdEwywU94Hlf5yllOipkDn8tHIp+X62PVaE9+LB1aDXhUe1p9zMT8qX36eh9dXa7LVdLNgyUPjW6P0wPvfKS38RpQu3bGDrAvLOX4BVjHjmj2NEaCGor20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSVXveRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSVXveRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D6AC433B1;
	Fri, 15 Mar 2024 20:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535539;
	bh=WXohfyNw+oq0vhflWbay1a6y3nkEj64hKIGK6Bbr9ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSVXveRb6GJPn91jynADHYVsguNj+eCjp6c1SIOKPZN7YnN4WfFq66wkM4IAp4yFf
	 3rv+URiLYACOixBcz0hlJJk+asouIjiQ7qj7TlmPo35Xn8drliOnba9x7sFStozxE8
	 F9FCmoex1lmR8B2xwsU2QN1zRlubwIqnHf4qgXF0O0ElTxJoDxSeBWZZJYcaagZ9YG
	 7zzPxPSW237sx0OUikzppBdLVXv4jJkcwdlZKmUHK689tBSL2pCXK5mkkCPuUsiO0o
	 jmRt6J0gvDYjqUXqR1j9o+Ulag8uHP4TI/Va/M4BWFRTCGp0gnsKx9bhx962BzmXs/
	 WkPybOv4RcOqA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/5] libbpf: add support for BPF cookie for raw_tp/tp_btf programs
Date: Fri, 15 Mar 2024 13:45:23 -0700
Message-ID: <20240315204524.967664-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315204524.967664-1-andrii@kernel.org>
References: <20240315204524.967664-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up BPF cookie passing or raw_tp and tp_btf programs, both in
low-level and high-level APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 16 ++++++++++++++--
 tools/lib/bpf/bpf.h      |  9 +++++++++
 tools/lib/bpf/libbpf.c   | 20 +++++++++++++++++---
 tools/lib/bpf/libbpf.h   | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 97ec005c3c47..65d25c3c6508 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -785,6 +785,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, uprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
@@ -1173,20 +1174,31 @@ int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info, __u32 *info
 	return bpf_obj_get_info_by_fd(link_fd, info, info_len);
 }
 
-int bpf_raw_tracepoint_open(const char *name, int prog_fd)
+int bpf_raw_tp_open(int prog_fd, struct bpf_raw_tp_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint);
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_raw_tp_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
-	attr.raw_tracepoint.name = ptr_to_u64(name);
 	attr.raw_tracepoint.prog_fd = prog_fd;
+	attr.raw_tracepoint.name = ptr_to_u64(OPTS_GET(opts, tp_name, NULL));
+	attr.raw_tracepoint.cookie = OPTS_GET(opts, cookie, 0);
 
 	fd = sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
 
+int bpf_raw_tracepoint_open(const char *name, int prog_fd)
+{
+	LIBBPF_OPTS(bpf_raw_tp_opts, opts, .tp_name = name);
+
+	return bpf_raw_tp_open(prog_fd, &opts);
+}
+
 int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, btf_token_fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index df0db2f0cdb7..bf8162fbccf9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -617,6 +617,15 @@ LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
 			      __u32 *prog_ids, __u32 *prog_cnt);
 
+struct bpf_raw_tp_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	const char *tp_name;
+	__u64 cookie;
+	size_t :0;
+};
+#define bpf_raw_tp_opts__last_field cookie
+
+LIBBPF_API int bpf_raw_tp_open(int prog_fd, struct bpf_raw_tp_opts *opts);
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 604368cfbf02..c4981e5c0bdf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12280,13 +12280,19 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 	return libbpf_get_error(*link);
 }
 
-struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
-						    const char *tp_name)
+struct bpf_link *
+bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
+					const char *tp_name,
+					struct bpf_raw_tracepoint_opts *opts)
 {
+	LIBBPF_OPTS(bpf_raw_tp_opts, raw_opts);
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, pfd;
 
+	if (!OPTS_VALID(opts, bpf_raw_tracepoint_opts))
+		return libbpf_err_ptr(-EINVAL);
+
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0) {
 		pr_warn("prog '%s': can't attach before loaded\n", prog->name);
@@ -12298,7 +12304,9 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 		return libbpf_err_ptr(-ENOMEM);
 	link->detach = &bpf_link__detach_fd;
 
-	pfd = bpf_raw_tracepoint_open(tp_name, prog_fd);
+	raw_opts.tp_name = tp_name;
+	raw_opts.cookie = OPTS_GET(opts, cookie, 0);
+	pfd = bpf_raw_tp_open(prog_fd, &raw_opts);
 	if (pfd < 0) {
 		pfd = -errno;
 		free(link);
@@ -12310,6 +12318,12 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 	return link;
 }
 
+struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
+						    const char *tp_name)
+{
+	return bpf_program__attach_raw_tracepoint_opts(prog, tp_name, NULL);
+}
+
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	static const char *const prefixes[] = {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 7b510761f545..f88ab50c0229 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -760,9 +760,20 @@ bpf_program__attach_tracepoint_opts(const struct bpf_program *prog,
 				    const char *tp_name,
 				    const struct bpf_tracepoint_opts *opts);
 
+struct bpf_raw_tracepoint_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u64 cookie;
+	size_t :0;
+};
+#define bpf_raw_tracepoint_opts__last_field cookie
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
 				   const char *tp_name);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
+					const char *tp_name,
+					struct bpf_raw_tracepoint_opts *opts);
 
 struct bpf_trace_opts {
 	/* size of this struct, for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 86804fd90dd1..53dbdaad0df1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -410,6 +410,8 @@ LIBBPF_1.3.0 {
 
 LIBBPF_1.4.0 {
 	global:
+		bpf_program__attach_raw_tracepoint_opts;
+		bpf_raw_tp_open;
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
-- 
2.43.0

