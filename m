Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1924E4AF;
	Mon, 16 Mar 2026 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647665; cv=none; b=opkmg1rcVlWQ6EVawQiFT1dLY8zeOEZsUdilrQ++F+Se4xf1JJS1IXtesAnGzIapsFEGdBzR2eb6i1X0aWq46YmCC4S/JaNEimOA0zkTsw/Ku2+6T5ujR/JfL6JsITaZg8xBZt3LIQJqlI0xBILpIg7WgivMmaXwYiACT32Mczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647665; c=relaxed/simple;
	bh=nhKYyZkCfBPVT+LCf7PjUxobqrpTZSRjC9bUIwY4qoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0t6hsqBffFgC2UJvvWTf05E93DO9n5eMBd4S0TzTpv/KRhnswRE0bnlNGldsd/wgq2/5N9G04ATbOBXTwxlZWI1XAUfY+0Gm31EuP8C/qgNPixbaL9/mQsMPWQO/qXBvkMYZxvQE+FGHqA1ODtZL7iFdSHK0Ylo3lqJkCmS9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAXH1CSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAXH1CSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5ADC19421;
	Mon, 16 Mar 2026 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647665;
	bh=nhKYyZkCfBPVT+LCf7PjUxobqrpTZSRjC9bUIwY4qoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAXH1CSIjw8ztgRIrB2WK4xshnW8VRHiSyekQ14TtOAuoXS8wgwpJFuuWaMrvejvb
	 uYa+9vPXmyIDCYXdxgnj/XUUjcmTQt5n19rO86qCcq7KheiibMSP/mrYXLHa+2iWRa
	 8wPfoJkMMjJ33OWAdwJjgvdViEUcmzusx/PRr11V5OC/E9UAwbi0QCsXkvnvNlXeWJ
	 VrTWcnYqtdhYBWeT8IILhY9oJ6y5SsgrK2CShXFFVPzdzsN9FVqXB8MR2akw5xZwCy
	 CamjRBCGSsmeRPJADWqATxjF41Ce3IVaolgx21dcJW+bs2yjWQ0H2jhs4U859KMH96
	 o1DHhX3cfTOLw==
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
Subject: [PATCHv3 bpf-next 15/24] libbpf: Add btf_type_is_traceable_func function
Date: Mon, 16 Mar 2026 08:51:29 +0100
Message-ID: <20260316075138.465430-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
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
 tools/lib/bpf/libbpf.c          | 54 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 64c1ab005e6d..084699448a94 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12275,6 +12275,60 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
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
+bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t)
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
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4bcb6ca69bb1..1b539c901898 100644
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

