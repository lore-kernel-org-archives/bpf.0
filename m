Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370840D57B
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768150; cv=none; b=kWFRewKzCQjgy2uIIsjkQn05ih8tKJMHvfxrtJv4lc16wlzuxqnDA+iWk5/DEay5tKOQyqCEAwMHgCmV2whXBU8aIDuwNdHXD6fp+GzlNz8lvJnI14R/pvS8JJvXBvIje91lYTQRUZNN9WiTFdyMnsrKDY0b4w+iIC7aUlJTuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768150; c=relaxed/simple;
	bh=xgPw6ftdu1+mrulGgm103/eGm9QVtDdDJdOqTJqnpQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2dmsL7aA0GmMkCtVDc8vNM0A9cwEVRrkX7SMD1dhy6XFym+u2snmtOYxNwuTYZbu8T331+TTkCihO8IFEhoYi5rtd/BrYdkCKhwl9ZxNauzm08x/1vTExFuF1GvQR0qcujpl7tRBb1C+j/7CXkV3/5YmcsxNW18P7UNdE7OnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StqEORJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StqEORJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7BA1F000E9;
	Mon, 29 Jun 2026 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782768148;
	bh=LoZumFHiezHerjc+2GyiHtwyPqwTDeclYsOVhYYP/8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StqEORJzI49LdVgcuuNV5qPTfvOWZx1Gu/HDnFjSc9e1ut8Fdci3oA07v8fQbo8EZ
	 w1aH+p5/7QTFf1Z8TbVmOfve3NN4smfKBO22y+VipIxHNxrptbxXs0QHf2hwoa8z6T
	 VP+kFcX6FSVUS48ixDW3cXAMVrRnDSemfmiZ30GOhhJC9G1uuDAycdGvZoudfyXex8
	 VFSwyXsFgXbqxCYxax3G7QdLa/HqkBWj1KV8k/NJMxM0RMY2UjZ0OPSmPNjJCaDldl
	 etto5IYFIhaIxXRYw8sgn1MfcqMxwGC5rIRMlS++x+PFNhY0tGeSk/jaeu4Zz5LRgu
	 /sHYq1xOFh3jw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCHv4 bpf-next 1/3] bpf: Add tracing_multi link info support
Date: Mon, 29 Jun 2026 23:22:06 +0200
Message-ID: <20260629212208.895962-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629212208.895962-1-jolsa@kernel.org>
References: <20260629212208.895962-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding BPF_OBJ_GET_INFO_BY_FD support for tracing_multi links.

We expose following tracing_multi link data:
- attach_type of the program
- number of ids
- array of BTF ids
- array of its related kernel addresses
- array of cookies

The change follows the kprobe_multi and uprobe_multi link-info convention
of optional output arrays with an in/out count,

On top of standard tracing link data we also expose addresses, because they
are useful info for user (especially when the attachment was done via pattern).
This data is hidden when kallsyms does not allow exposing kernel pointer values.

Assisted-by: Codex:GPT-5
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  9 ++++++
 kernel/trace/bpf_trace.c       | 55 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  9 ++++++
 3 files changed, 73 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..4180262814e7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6839,6 +6839,15 @@ struct bpf_link_info {
 			__u32 flags;
 			__u32 pid;
 		} uprobe_multi;
+		struct {
+			__u32 attach_type;
+			__u32 count; /* in/out: tracing_multi target count */
+			__u32 btf_obj_id;
+			__u32 :32;
+			__aligned_u64 ids;
+			__aligned_u64 addrs;
+			__aligned_u64 cookies;
+		} tracing_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
 			__u32 :32;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 82f8feea6931..0711810f4562 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3699,6 +3699,60 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	kvfree(tr_link);
 }
 
+static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
+						 struct bpf_link_info *info)
+{
+	u64 __user *ucookies = u64_to_user_ptr(info->tracing_multi.cookies);
+	u64 __user *uaddrs = u64_to_user_ptr(info->tracing_multi.addrs);
+	u32 __user *uids = u64_to_user_ptr(info->tracing_multi.ids);
+	struct bpf_tracing_multi_link *tr_link;
+	u32 ucount = info->tracing_multi.count;
+	bool has_cookies, show_addrs;
+	int err = 0;
+
+	if ((uids || ucookies || uaddrs) && !ucount)
+		return -EINVAL;
+
+	tr_link = container_of(link, struct bpf_tracing_multi_link, link);
+
+	info->tracing_multi.attach_type = tr_link->link.attach_type;
+	info->tracing_multi.count = tr_link->nodes_cnt;
+	info->tracing_multi.btf_obj_id = btf_obj_id(tr_link->link.prog->aux->attach_btf);
+
+	if (!uids && !ucookies && !uaddrs)
+		return 0;
+
+	if (ucount < tr_link->nodes_cnt)
+		err = -ENOSPC;
+	else
+		ucount = tr_link->nodes_cnt;
+
+	has_cookies = !!tr_link->cookies;
+	show_addrs = kallsyms_show_value(current_cred());
+
+	for (int i = 0; i < ucount; i++) {
+		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
+		u64 addr, cookie;
+		u32 id;
+
+		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &id);
+
+		addr = show_addrs ? mnode->trampoline->ip : 0;
+		cookie = has_cookies ? tr_link->cookies[i] : 0;
+
+		if (uids && put_user(id, uids + i))
+			return -EFAULT;
+		if (uaddrs && put_user(addr, uaddrs + i))
+			return -EFAULT;
+		if (ucookies && put_user(cookie, ucookies + i))
+			return -EFAULT;
+
+		cond_resched();
+	}
+
+	return err;
+}
+
 #ifdef CONFIG_PROC_FS
 static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
 					  struct seq_file *seq)
@@ -3729,6 +3783,7 @@ static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
 static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
 	.release = bpf_tracing_multi_link_release,
 	.dealloc_deferred = bpf_tracing_multi_link_dealloc,
+	.fill_link_info = bpf_tracing_multi_link_fill_link_info,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = bpf_tracing_multi_show_fdinfo,
 #endif
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 89b36de5fdbb..4180262814e7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6839,6 +6839,15 @@ struct bpf_link_info {
 			__u32 flags;
 			__u32 pid;
 		} uprobe_multi;
+		struct {
+			__u32 attach_type;
+			__u32 count; /* in/out: tracing_multi target count */
+			__u32 btf_obj_id;
+			__u32 :32;
+			__aligned_u64 ids;
+			__aligned_u64 addrs;
+			__aligned_u64 cookies;
+		} tracing_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
 			__u32 :32;
-- 
2.54.0

