Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982374C81;
	Sat,  6 Jun 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749793; cv=none; b=R7L6JhB2hxg1VFlSS07uTKOAmwhSGmFUfHYcyZkqMUhdWCTsB0bszELvql48/fJCo30vXvN+eTP/ORPslhV3B5PtIeVDD0tH2/c59b22S4ph7HXmFEVd4Bc2p3mWdCGVlR/F/tWQH+Jab9e3I67XmPAag+FK9ugP6VFYPNCxh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749793; c=relaxed/simple;
	bh=0espHjd5KuqOkBi6Z6xKeVsQuEa3EPPcP8Op0oBTT70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knLswCOaWZ4VkcotXJo5O3mQdSeEQs45wguc+RKIHzQMPdkLSNF1Fn99zM/n2mKar7MkleXFIcp2/QMCIJyBTIg9KmgUyBpGQhx/pcX06+VZY5QBrWuJrrkUctjRZvN5PYh+yHoJd5PVLZrD+iEMSnhw1adX5M3hkyEqlMFlvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyNfIP/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyNfIP/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C741F00893;
	Sat,  6 Jun 2026 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749792;
	bh=LpC1VfdpmhyFJqCWppxN01ffuh69bj8R8Nk+SqJP5lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyNfIP/rxxID7GA/OI7a9nHdjfHIE+sGsrBrgf7v25H3PKwtWVaUmCqXbp8AdF8XV
	 1S4JiSL21ptG1pflULKF3nxYRghaPf6c9QMo1NMQ247WcVsedGfDYXi2HBO2CoVY2h
	 gZwMFzU2h/YMjtMVHnQDoUaCaC4LV6ZE+3GGM485sb9x/L55EzFLPJRSbngRtvKnL3
	 nj5JjkAHdyKadEpxUfhK9F3gHE8XJI3qrkrsiLiDdgicJh+uNHOWsm4gt7sM5iUToB
	 2Wev/jBb+ArAw5MFBrhF/YLYaUxxVelqyME4BEctEDMGyfWB9NhQqU86pzqmxo9DKm
	 yy0KwKNAx0UeA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 19/29] libbpf: Add btf_type_is_traceable_func function
Date: Sat,  6 Jun 2026 14:39:44 +0200
Message-ID: <20260606123955.345967-20-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
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
index 5bdaa5eb1f50..42f0efd70327 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12450,6 +12450,85 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
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

