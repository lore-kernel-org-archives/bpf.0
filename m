Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2F2288D5;
	Fri, 17 Apr 2026 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454118; cv=none; b=tglBQoJhkx04VC8iYMIx/1aQ5FvZnLZz9n5JajFC8MCg+4A0TMJlYjQJrmovkdGZziz5SsSVX+6YCaBs+qWR/NAQnOXEoYm+v4BcUvA49t8nfv4XNfkdYsdmI2m4FdZwPTvQL3iGuxLEbImVpq8MAXeZERYrCAnxPfqj5uEurPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454118; c=relaxed/simple;
	bh=5dAhbMcdwsA1cikE4VTcLtFBJMbOSxmR6GIjD4R6tJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHzubsCHk/JwP9skAxoCMvCPu6tHIr9ptGvkfAFs4e6ztIzyKGJqyWpkeVt06u5817CsfQvRv79B0OhzHs2WRKcSoDZygyS10ggpeaxYL5TzaM9lUpQSxdJGEXcBPR1oNETZu5MIwKzwz1pE6zCml09+prxZmXArBUZhHg0HQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL8F80vm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL8F80vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385C5C19425;
	Fri, 17 Apr 2026 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454118;
	bh=5dAhbMcdwsA1cikE4VTcLtFBJMbOSxmR6GIjD4R6tJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL8F80vmNDGGrQaa9FMTju8zoWlg+G3Vp/yMumqM+/dgmqYv+btk2NkQcjma8bx8r
	 iBLEdPKg3czq+EAha8VsQgCSoPfkFLg73vQ8nW44oBVN0EtMqO7hak+u5kUOA3ombX
	 AToiYn8Frk2HjfyMFOziwWpayzHh1pOmuBqtwvtflc0VTEBslLx7TYoS9vrFgj/wH8
	 OOmxxb61OYU2Wl0Ou/twQaHG3Ksneav+8AEPMFtKKswOb9IoK/w268Hhoq+yPAH/av
	 RTISbmD8jKNbbdMj22YDpJHTrq4Xifkk7eK291PsuLmF9q7uXrKdU84rfkh4AgwqZZ
	 f6B5nD6TSNWoA==
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
Subject: [PATCHv5 bpf-next 19/28] libbpf: Add btf_type_is_traceable_func function
Date: Fri, 17 Apr 2026 21:24:53 +0200
Message-ID: <20260417192502.194548-20-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding btf_type_is_traceable_func function to perform same checks
as the kernel's btf_distill_func_proto function to prevent attachment
on some of the functions.

Exporting the function via libbpf_internal.h because it will be used
by benchmark test in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 74 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  1 +
 2 files changed, 75 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 59de338126fb..db038cfc7fde 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12439,6 +12439,80 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
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
+static int btf_get_type_size(const struct btf *btf, __u32 type_id,
+			     const struct btf_type **ret_type)
+{
+	const struct btf_type *t;
+
+	*ret_type = btf__type_by_id(btf, 0);
+	if (!type_id)
+		return 0;
+	t = btf__type_by_id(btf, type_id);
+	while (t && btf_type_is_modifier(t))
+		t = btf__type_by_id(btf, t->type);
+	if (!t)
+		return -EINVAL;
+	*ret_type = t;
+	if (btf_is_ptr(t))
+		return sizeof(void *);
+	if (btf_is_int(t) || btf_is_any_enum(t) || btf_is_struct(t) || btf_is_union(t))
+		return t->size;
+	return -EINVAL;
+}
+
+bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_param *args;
+	const struct btf_type *proto;
+	__u32 i, nargs;
+	int ret;
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
+	/* No support for struct return type. */
+	ret = btf_get_type_size(btf, proto->type, &t);
+	if (ret < 0 || btf_is_struct(t) || btf_is_union(t))
+		return false;
+
+	for (i = 0; i < nargs; i++) {
+		/* No support for variable args. */
+		if (i == nargs - 1 && args[i].type == 0)
+			return false;
+		ret = btf_get_type_size(btf, args[i].type, &t);
+		/* No support of struct argument size greater than 16 bytes. */
+		if (ret < 0 || ret > 16)
+			return false;
+		/* No support for void argument. */
+		if (ret == 0)
+			return false;
+	}
+
+	return true;
+}
+
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 3781c45b46d3..a9845f57e56c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -250,6 +250,7 @@ const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, _
 const struct btf_header *btf_header(const struct btf *btf);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
+bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.53.0

