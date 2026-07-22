Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1267437464
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763363; cv=none; b=i4rd4hDVRZHDBbXgo47cME4d8/sRBNSmee37g2fTHvsYDmaf7+WNVg0dZ3mbeqbSsCqcjz5JHTIsBH3qIsSj7eBmy/snAU1kPbOogE/KJWczPSw088/+1gjUpZp4y5/UQ9Inzux1QMDRJ4bRou+vtLG9MncZIBuWllyHEuc6MOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763363; c=relaxed/simple;
	bh=6dyZfEquXX1eoqPSu/KktcyXKEdPvQfExb4e/wVEqYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvAL974fV/qkaPf3qf1ios1T5cpcSBVDtZBgxmkHKOg7luKwKOlTsPFMQuedLVRWUfzENP987OP319ceq91sppoHPTE0bcs92ATDB3voIcYq4UISBNjYULJ7F8lhMgTmxG99oNl2MbTvOz4AT3XAdB2P4rTeP//3y+bB2wtJhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KcaBJN82; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KcaBJN82"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APFqKWBeT7g6YAOdNNRcwHzhLIjsoIsdQObLP86YxIc=;
	b=KcaBJN827QhS+pbEirrPfioVgBJ6rwEhZh3cMQwkt9E+XZwH76wOaC7Xfl+BwoUx7WWOh8
	vXDRF6hPRWGcg1gm09cdIcGpVEgsXaAnlTa2EFUwYeocnWZ/xvAM8+IBNBfUycGt1FqqNM
	DNOaJ6ScY8YMqd2P08XcD00ReC/4s28=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/8] libbpf: Export btf__find_by_name_kind_own()
Date: Wed, 22 Jul 2026 16:35:14 -0700
Message-ID: <20260722233518.778854-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260722233518.778854-1-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

btf__find_by_name_kind() searches the base BTF before the split BTF,
so in case of a name collision between base and split it always
returns a base type. Tools that process split BTF may need to restrict
a lookup to the split's own types.

The internal helper btf__find_by_name_kind_own() already does exactly
that. Make it a public API.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/btf.h             | 2 ++
 tools/lib/bpf/libbpf.map        | 1 +
 tools/lib/bpf/libbpf_internal.h | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 1a31f2da947f..587172c0de08 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -172,6 +172,8 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
 LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
 					const char *type_name, __u32 kind);
+LIBBPF_API __s32 btf__find_by_name_kind_own(const struct btf *btf,
+					    const char *type_name, __u32 kind);
 LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
 LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
 LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b731df19ae69..08ab2ea881fb 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -460,5 +460,6 @@ LIBBPF_1.8.0 {
 	global:
 		bpf_program__attach_tracing_multi;
 		bpf_program__clone;
+		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index d5b7db703b3f..7a74abb904f8 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -596,8 +596,6 @@ typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
 typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx);
 int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void *ctx);
-__s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
-				 __u32 kind);
 
 /* handle direct returned errors */
 static inline int libbpf_err(int ret)
-- 
2.55.0

