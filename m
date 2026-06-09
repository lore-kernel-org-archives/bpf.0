Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE03F4DF7
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001790; cv=none; b=nHswvb/kt+cT5jDdza7XZjpWzQJLeguFNyEiASebj17yL52WgUqw2g7Jw1PuV3p+9ptHwEbfrkf4vM7hYVX913pBvwE2inhCt2pruE6gny4TVKEZnGpSwk2TKDhzSOUJ++xENYgkMesTsOsXRv/oXB40dPGCmkUHzcFxdXi6g30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001790; c=relaxed/simple;
	bh=vwFoteblCza/rtdJS0/cOMah7NF5qBFHgGcpp6qUWcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV2H1s7+DpE5LgKD2rsGDUGO2Q9GmyW2KjGDF0LHPJLOwk9a/m/xN27KMd7U+mcKJ2HY2tO2mCZQO5+SeS7wxwjH4xVFVb/bzZMaiied1/ftOkrEeY6GAqufuPHlBj8YIRrqaAWRb2dX1cUQ/8ZIqV/Clh9JcbxGNuuuasVAyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVesNbyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVesNbyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F0F1F00893;
	Tue,  9 Jun 2026 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001789;
	bh=CWYXro05Rinp6K3c6cpl1Yeg5RvNbRyBASljr0qYMUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVesNbytrDe88M2Q3F9h+WKpEuO5wmZiD/ONUC/wXvpTQY3gR96naZ3+Mn1cBe0yG
	 TZUzNJdDcbvdrdEwWtyYRKVw6CGMhrn2NOXjDW8g9833rX43af3A6IitAeqNji8lxw
	 PVfVxKC7YcdxAoIort+tOvAT//odi9A3fwo9l0lHF8dG3HAd0YP4m+VyVx1ZgUuOcN
	 bHl9ANyKd2QtVakk83dJWQARbIpXrDtH1RwkzYsRYmREOWaa1KeWjEXxckdTEejPTB
	 /ZOkKO2rLKNl8b6fm6XP+y8n6JJgag5TzOm+e9Ub+Hy04KrMp9drJtNirLmGs1YT4Z
	 fdOEzDzB+2gQw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi target via file descriptor
Date: Tue,  9 Jun 2026 12:42:40 +0200
Message-ID: <20260609104244.588321-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609104244.588321-1-jolsa@kernel.org>
References: <20260609104244.588321-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow uprobe_multi link to identify the target binary by an already
opened file descriptor.

Adding new BPF_F_UPROBE_MULTI_PATH_FD flag and the path_fd field for
the attr.link_create.uprobe_multi struct.

When the flag is set, we resolve the target from path_fd, without the
flag, we keep the existing string path behavior.

I don't see a use case for supporting O_PATH file descriptors, because
we need need to read the binary first to get probes offsets, so I'm
using the CLASS(fd, f), which fails for O_PATH fds.

Assisted-by: Codex:GPT-5.4
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  7 ++++++-
 kernel/bpf/syscall.c           |  4 ++--
 kernel/trace/bpf_trace.c       | 37 +++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |  7 ++++++-
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 11dd610fa5fa..89b36de5fdbb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1327,7 +1327,11 @@ enum {
  * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
+	/* Get return uprobe. */
+	BPF_F_UPROBE_MULTI_RETURN     = (1U << 0),
+
+	/* Get path from provided path_fd. */
+	BPF_F_UPROBE_MULTI_PATH_FD    = (1U << 1),
 };
 
 /* link_create.netfilter.flags used in LINK_CREATE command for
@@ -1864,6 +1868,7 @@ union bpf_attr {
 				__u32		cnt;
 				__u32		flags;
 				__u32		pid;
+				__u32		path_fd;
 			} uprobe_multi;
 			struct {
 				union {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d4188a992bd8..cef9bd6316a5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3475,7 +3475,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_KPROBE_MULTI_RETURN ?
 				   "kretprobe_multi" : "kprobe_multi");
 		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
-			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+			seq_printf(m, "link_type:\t%s\n", link->flags & BPF_F_UPROBE_MULTI_RETURN ?
 				   "uretprobe_multi" : "uprobe_multi");
 		else
 			seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
@@ -5835,7 +5835,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.pid
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_prog *prog;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 970ce7bbf99e..4965006d58ee 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/key.h>
 #include <linux/namei.h>
+#include <linux/file.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -3240,29 +3241,51 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
-	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
+	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN|BPF_F_UPROBE_MULTI_PATH_FD))
 		return -EINVAL;
 
 	/*
-	 * path, offsets and cnt are mandatory,
+	 * offsets and cnt are mandatory,
 	 * ref_ctr_offsets and cookies are optional
 	 */
-	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
 	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
 	cnt = attr->link_create.uprobe_multi.cnt;
 	pid = attr->link_create.uprobe_multi.pid;
 
-	if (!upath || !uoffsets || !cnt || pid < 0)
+	if (!uoffsets || !cnt || pid < 0)
 		return -EINVAL;
 	if (cnt > MAX_UPROBE_MULTI_CNT)
 		return -E2BIG;
 
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
 	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
+	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
 
-	err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
-	if (err)
-		return err;
+	if (flags & BPF_F_UPROBE_MULTI_PATH_FD) {
+		/*
+		 * When BPF_F_UPROBE_MULTI_PATH_FD is set, the executable is identified
+		 * by path_fd, and upath must be NULL.
+		 */
+		if (upath)
+			return -EINVAL;
+
+		CLASS(fd, f)(attr->link_create.uprobe_multi.path_fd);
+		if (fd_empty(f))
+			return -EBADF;
+		path = fd_file(f)->f_path;
+		path_get(&path);
+	} else {
+		/*
+		 * When BPF_F_UPROBE_MULTI_PATH_FD is not set, the path is resolved
+		 * relative to the cwd (AT_FDCWD) or absolute  using the upath string.
+		 */
+		if (!upath)
+			return -EINVAL;
+
+		err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
+		if (err)
+			return err;
+	}
 
 	if (!d_is_reg(path.dentry)) {
 		err = -EBADF;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 11dd610fa5fa..89b36de5fdbb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1327,7 +1327,11 @@ enum {
  * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
+	/* Get return uprobe. */
+	BPF_F_UPROBE_MULTI_RETURN     = (1U << 0),
+
+	/* Get path from provided path_fd. */
+	BPF_F_UPROBE_MULTI_PATH_FD    = (1U << 1),
 };
 
 /* link_create.netfilter.flags used in LINK_CREATE command for
@@ -1864,6 +1868,7 @@ union bpf_attr {
 				__u32		cnt;
 				__u32		flags;
 				__u32		pid;
+				__u32		path_fd;
 			} uprobe_multi;
 			struct {
 				union {
-- 
2.54.0

