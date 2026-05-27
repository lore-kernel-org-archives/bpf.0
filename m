Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE13FC5DD;
	Wed, 27 May 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882204; cv=none; b=lQ3zki4Z9CNuayFpl74Msef3qLLjTC3OwPs2fp+T/lVsZdj1Gn72TpPHB9qB/c9hUJLp0YbhGqMhj5PVYhpLcBP7MFQt/C/0paVxlVQH1qtGK6hjYs3KcryQ0Nr1DMYGLBKSftJpAMMhKQyRhDqmFNyBS79uXZq4Ay3X7/odrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882204; c=relaxed/simple;
	bh=SD7DkcOMZiWgHS/xBJ/KgLzUAoTlYWzZO10PxvEIUH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xcn2uo+mE77SEQywNqCks6JJzRTvddPFdxFIoAfRzCn/TQSWq94vnBXOCZGZUCakV6RCa8lkzGddHaUDUTNn9XMP+/vehMYj+ctoNFUFXGO1Hhf3HflLtWcbydcJrHsXZLiXeoKYZ9Dq6uPSC4Tog5Z2slwQ2hRfsYaUzKpvAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z96u8Jwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z96u8Jwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4F31F00A3A;
	Wed, 27 May 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882200;
	bh=gdbMMiCp0v5ZfuR/eGaZoK1YWf6FX57jGdukU4zLtlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z96u8Jwm33YXY3NbyinCrJnE7UaE2+ks0J0NDIrd+Vt3rqKGVzEu8jfLgurUtUVOP
	 yzYlOQPgxcfTSBxXJOARm+C1jqfKIw1DnkB68oZI/U5RLKku29DiEiHRzE2ZmmGx5B
	 Tk4q+ADEJO8nh/pVEtqjNvSA5F/MIkx/9wwOqlbf+4c7MeMaW8bKBv7wbfQ4OubyXq
	 671al74PcuDnomM4dR4y5mWzML8tSj9NYe5PiY09CMs05YdftX9ZmAg8VlVB7HrbXQ
	 PQ7x/GU9VoY3ad7TQHOcqeYtOQeXXmYYon2BVFTD+7m/fUypzlQM/tfcQBvIW7Peq2
	 dNi89V2CDglRg==
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
Subject: [PATCHv6 bpf-next 19/29] libbpf: Add btf_type_is_traceable_func function
Date: Wed, 27 May 2026 13:39:41 +0200
Message-ID: <20260527113951.46265-20-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
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
 tools/lib/bpf/libbpf.c          | 79 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  1 +
 2 files changed, 80 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 240cc37fe621..df833ddda0ea 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12449,6 +12449,85 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
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
+#define MAX_RESOLVE_DEPTH 32
+
+static int btf_get_type_size(const struct btf *btf, __u32 type_id,
+			     const struct btf_type **ret_type)
+{
+	const struct btf_type *t;
+	int i;
+
+	*ret_type = btf__type_by_id(btf, 0);
+	if (!type_id)
+		return 0;
+	t = btf__type_by_id(btf, type_id);
+	for (i = 0; i < MAX_RESOLVE_DEPTH && t && btf_type_is_modifier(t); i++)
+		t = btf__type_by_id(btf, t->type);
+	if (!t || i == MAX_RESOLVE_DEPTH)
+		return -EINVAL;
+	*ret_type = t;
+	if (btf_is_ptr(t))
+		return btf__pointer_size(btf);
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
+	if (!btf_is_func(t))
+		return false;
+	proto = btf__type_by_id(btf, t->type);
+	if (!proto || !btf_is_func_proto(proto))
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
index 7d93c6c01d60..04cd303fb5a8 100644
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
2.54.0

