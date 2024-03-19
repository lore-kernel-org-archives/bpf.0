Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD435FB96
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891548; cv=none; b=nnyCDq+EFrM9h4zMM9v+8gWeXa4jqJBZbT0S1MwxqZsJ5wZMDfQAm83v70NwxmJCgS4nQb6da/VhNdzIlGR8lHNLhs2VHzrGUC1Fao+FGHPHnTHFEP0q3KZMsAHOrPfWrDwPXAH2rbWc3CfZfiiOrwID5lZHfjS8MQhSL55Ww3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891548; c=relaxed/simple;
	bh=lCFk8crLE4ajT7p9u08ZCP4Y94LUXpAQBwdHuOKfnos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saEw2ZRxOrx7ittTDoomZCqvOPUjrmRfPkIBMQZwFDAgVTlfi7folzFn79utTvE5A8ivzTYf8VneAhB8Qmax1NulwilZexIXyRqk6bxrU1xkHJs0OiWb9cEiF/2u++lMEPnPSnMpjJvliiI1YQwL+/9fX6sMnlK/6I6eES46pBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2a7CR6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2a7CR6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027D1C433F1;
	Tue, 19 Mar 2024 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710891548;
	bh=lCFk8crLE4ajT7p9u08ZCP4Y94LUXpAQBwdHuOKfnos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2a7CR6ndPycnMr7VM7+jGj3ZSnwK5lC1D2KexGyTPRa9Hc13hIgKMMUT0XUHd7qg
	 eN3lBZxQy2i+q3qac5mrHtx95rcQrMn8QScEYhV+YeoIFMp0dX5CGP3ocdyqk7hGKF
	 zT4jw6sYRdF0gKhiH3yX5prdCxu6iRsNjT6ZQICJAUcEuDOcnX4nc0SN7ZFWpQbWjt
	 Jl7iJghwWF8+TNtHI6/WxTnwPhRrk/OiQ6vMNMoH+uobwr5kiIrMIfEJxey1JPxYjq
	 H2m2sTVY1StrJ7WHLQcf9x6sWbTZmi3nfo+xCXB7YIOy9UGJi2ziPGJLcbbSQ8Csor
	 63rxGNbwxpqaA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Stanislav Fomichev <sdf@google.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 4/5] libbpf: add support for BPF cookie for raw_tp/tp_btf programs
Date: Tue, 19 Mar 2024 16:38:51 -0700
Message-ID: <20240319233852.1977493-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319233852.1977493-1-andrii@kernel.org>
References: <20240319233852.1977493-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up BPF cookie passing or raw_tp and tp_btf programs, both in
low-level and high-level APIs.

Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 16 ++++++++++++++--
 tools/lib/bpf/bpf.h      |  9 +++++++++
 tools/lib/bpf/libbpf.c   | 20 +++++++++++++++++---
 tools/lib/bpf/libbpf.h   | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 97ec005c3c47..c9f4e04f38fe 100644
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
+int bpf_raw_tracepoint_open_opts(int prog_fd, struct bpf_raw_tp_opts *opts)
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
+	return bpf_raw_tracepoint_open_opts(prog_fd, &opts);
+}
+
 int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, btf_token_fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index df0db2f0cdb7..972e17ec0c09 100644
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
+LIBBPF_API int bpf_raw_tracepoint_open_opts(int prog_fd, struct bpf_raw_tp_opts *opts);
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a756d61c120..86df0d50cba7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12309,13 +12309,19 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
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
@@ -12327,7 +12333,9 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 		return libbpf_err_ptr(-ENOMEM);
 	link->detach = &bpf_link__detach_fd;
 
-	pfd = bpf_raw_tracepoint_open(tp_name, prog_fd);
+	raw_opts.tp_name = tp_name;
+	raw_opts.cookie = OPTS_GET(opts, cookie, 0);
+	pfd = bpf_raw_tracepoint_open_opts(prog_fd, &raw_opts);
 	if (pfd < 0) {
 		pfd = -errno;
 		free(link);
@@ -12339,6 +12347,12 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
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
index 86804fd90dd1..51732ecb1385 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -410,6 +410,8 @@ LIBBPF_1.3.0 {
 
 LIBBPF_1.4.0 {
 	global:
+		bpf_program__attach_raw_tracepoint_opts;
+		bpf_raw_tracepoint_open_opts;
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
-- 
2.43.0

