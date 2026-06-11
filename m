Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B63E7BCD
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178185; cv=none; b=pQHK8Y4nZBbZyVkdD89ySht//vSP7DjTkexP3n8l0wTCI0yUaMy4vgKu+kQO/WHA76Zx/A7R0wJZqpipyF8c8MCcbzaGuePtpeqNhiPurDXGIIAPaBw46FQd5z+wNpL3wvvVf+7qfO2Wh+fPF1R3OErxpoc84ibAsbQIhLWFDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178185; c=relaxed/simple;
	bh=09+ze79N3Q6mq8va+gLAiZMJZZfJpAw3XLQ46bq0eh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpxQzkXObTvw0CEvH6drmeBMaBZvtHe4RXtkimIpCGbiMCvMkPF1FzBiaROWrQCs4QaTFwVNIouVpRW1RvvzQ5iew7WvcsEq2voPdB7W55anbIEXK8J/ZRsi7kXJ1dzHHMifuSslpOpG48ikeG2k0tADKLN9Bo6kUyFu95MFXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCH+pRVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCH+pRVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712541F00893;
	Thu, 11 Jun 2026 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178184;
	bh=MUYB3eoi7lHSD+w+SOHM9QhGjgbaEu2sSw8m0tf79sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCH+pRVABkXcTpYeEEyIfzJ7H2312wq9BpM5AYCHyPm1Ysr771C+0AIYUw8EjqDza
	 2+rVXymqUV9ghIa80D2VdEvvIpKtHQ7L2VjGsA6ucSN0YXooaf/gvjPVmIWAoA4taH
	 5xmWAoNCLoxgKrFkOSDQVLXO0BqCC7DZYjdGehm97vjFEdqB5hmwzeGpc4xlGoxDit
	 WyRgnZ6It+ouwlzGqEMcWDMejWkYEogAsdjjxlyzYnFQWQORpbc+r1rvszmneIUUWq
	 3Jdp956QQ0HfvRheN/Y0AjZyXCGjrF4WPEghjNsw/dXmK2bymisUZO1kJAXIY+Dhmz
	 QJRcAjUEqZ8tQ==
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
Subject: [PATCHv3 bpf-next 3/7] bpf: Add support to specify uprobe_multi target via file descriptor
Date: Thu, 11 Jun 2026 13:42:26 +0200
Message-ID: <20260611114230.950379-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611114230.950379-1-jolsa@kernel.org>
References: <20260611114230.950379-1-jolsa@kernel.org>
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
index 7ed949f70f82..b44106c8ea75 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3480,7 +3480,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_KPROBE_MULTI_RETURN ?
 				   "kretprobe_multi" : "kprobe_multi");
 		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
-			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+			seq_printf(m, "link_type:\t%s\n", link->flags & BPF_F_UPROBE_MULTI_RETURN ?
 				   "uretprobe_multi" : "uprobe_multi");
 		else
 			seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
@@ -5840,7 +5840,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.pid
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_prog *prog;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f8990bc6b64c..82f8feea6931 100644
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
 	unsigned long size;
 	u32 flags, cnt, i;
 	struct path path;
@@ -3241,19 +3273,18 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
@@ -3271,7 +3302,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	    !access_ok(ucookies, size))
 		return -EFAULT;
 
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

