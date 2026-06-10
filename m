Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5F40B394
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102212; cv=none; b=QTgN6ajyK391oHRQdZh56qSRhXv0sxQI5E1QEiZJmZuGDNlOFoCpzhAVgUZ4T27lXTbwRNn+l5pnqtOS7svo+3WoLBIExnP9fOQsqqfbIQi6Yr1uQNiohNBI5oYJ9Mc76x3iAJpbPTsRPThbcTloAQU+qZQgsboGfpJibUS6T0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102212; c=relaxed/simple;
	bh=c+5OFsK3P8uvkCR0wOVB5vj8eKbLwaGtmS4aV6XjJqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXY5Y5eei+yRdEia05F8RpH7BoohzOifvHSoWL5oS2696DiprUfMOXmCzrxsyExWY9a3hXJfKYPFJD3Bmo0G3cTJNbO4eYTpszLOXIyNCdGGWTFxQrx1/+db8u/pYeO28eV5BrIf370b12+YR9aangB7GOhDvSPKkyvifWinBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZgX09XO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZgX09XO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52941F00893;
	Wed, 10 Jun 2026 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102211;
	bh=NAiaBipP8BmTV7ieHZ0SIAPS9RBjYhEdJk0xe4PwL4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZgX09XOKWDOvXB0p7eDeqt7yAFhrL3QKz3G65zRodX9D8imtqexujJKzmqKSx30t
	 Hz5emX/tYk9guu9S7UJd0qgKAg6WJ+8rTtOxsgQ7ItX9BWdJY0/FY7RWRR/Pkl+IB9
	 G9YIT5H1Ac9tC+LkO/+cf8UX0Z1Mhf4l+j9sKKAjaZBJ4CnHNbxNUYQFfBsTj8iYBJ
	 DOeatKbROWcimYCCCeQm9WLt8tWKCdvUH2kGTytqIjjtEDkWndRMz8+THInhfr3HMb
	 rbocIu13dKpjQ0qq5r/RGEqNRIpt/d0voEdjOAaZ/lCef2s+KtbcT14xy32bQWc16v
	 1srrC3G1Kr+Ng==
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
Subject: [PATCHv2 bpf-next 2/6] bpf: Add support to specify uprobe_multi target via file descriptor
Date: Wed, 10 Jun 2026 16:36:23 +0200
Message-ID: <20260610143627.804790-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610143627.804790-1-jolsa@kernel.org>
References: <20260610143627.804790-1-jolsa@kernel.org>
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
we need to read the binary first to get probes offsets, so I'm using
the CLASS(fd, f), which fails for O_PATH fds.

Assisted-by: Codex:GPT-5.4
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  7 +++++-
 kernel/bpf/syscall.c           |  4 ++--
 kernel/trace/bpf_trace.c       | 43 +++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |  7 +++++-
 4 files changed, 51 insertions(+), 10 deletions(-)

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
index 970ce7bbf99e..f5d68f6d90f3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/key.h>
 #include <linux/namei.h>
+#include <linux/file.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -3214,6 +3215,38 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
 	return run_ctx->uprobe->cookie;
 }
 
+static int bpf_uprobe_multi_get_path(const union bpf_attr *attr, struct path *path)
+{
+	void __user *upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
+	u32 path_fd = attr->link_create.uprobe_multi.path_fd;
+	u32 flags = attr->link_create.uprobe_multi.flags;
+
+	if (flags & BPF_F_UPROBE_MULTI_PATH_FD) {
+		/*
+		 * When BPF_F_UPROBE_MULTI_PATH_FD is set, the executable is
+		 * identified by path_fd, upath must be NULL.
+		 */
+		if (upath)
+			return -EINVAL;
+
+		CLASS(fd, f)(path_fd);
+		if (fd_empty(f))
+			return -EBADF;
+		*path = fd_file(f)->f_path;
+		path_get(path);
+		return 0;
+	}
+
+	/*
+	 * When BPF_F_UPROBE_MULTI_PATH_FD is not set, the path is resolved
+	 * relative to the cwd (AT_FDCWD) or absolute using the upath string.
+	 */
+	if (!upath || path_fd)
+		return -EINVAL;
+
+	return user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, path);
+}
+
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_uprobe_multi_link *link = NULL;
@@ -3223,7 +3256,6 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	struct task_struct *task = NULL;
 	unsigned long __user *uoffsets;
 	u64 __user *ucookies;
-	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
 	pid_t pid;
@@ -3240,19 +3272,18 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
-	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
+	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN | BPF_F_UPROBE_MULTI_PATH_FD))
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
@@ -3260,7 +3291,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
 	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
-	err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
+	err = bpf_uprobe_multi_get_path(attr, &path);
 	if (err)
 		return err;
 
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

