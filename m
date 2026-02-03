Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B7396D34;
	Tue,  3 Feb 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111589; cv=none; b=jrgnUM7PKopUGWTJ3u6OuuiDZAL7OWs1QEiLmRBwCWq9vJ6Jsaf07ihpXrn0P0zPg6z7dwytZQYH3Nm9r3mkfUPu0fkkMKn8XLZPQ1RPhDpK1zdD2JpFSYQhM5zdyeIewPTlaVn2XL6+s+BpjtZeK7H+n39kgLKjOs6noDnOKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111589; c=relaxed/simple;
	bh=uzTuxMR8X3hrFqpP6588hv/1bT+QZabcv9LhcLTuOgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXncwEcm/r0ujOlvebKPTsHv1TXK79yfH7M/iL/kzDaVuzH0jvqrXrhBtmEoPOreRVizs3cmni+pECC908Jk9j9+ez6y42aCkVeOFscuj1BxiWy/Ts1iiSW6jEN/pOm5RKgQe0dBwCeVQzbEA1bW99rAHDUQwI3sfF1XIiXhkos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLw3rPCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLw3rPCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D728C116D0;
	Tue,  3 Feb 2026 09:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111589;
	bh=uzTuxMR8X3hrFqpP6588hv/1bT+QZabcv9LhcLTuOgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLw3rPCSVHGioCgyLtg4apuuNayygEBObInBf8DGoasXone1oY/kkT0m2s2Kwa3oy
	 PhQubXzwhTQDIe8aCR4i4P/Vyih0JvXNOdT7hEg9hhRIO7GEe37I+ETNlQlVzbe+xI
	 2kPlWYQO3rwh0fxf0s4KwKFCwwl3FcVK+rNv3M+wadgC5Jwyzi1Jp9h0PPSxunhKCS
	 YLm9suRmEOPmYwvxphiC5vHlmR4Ev15MDbNRNOAC/GYn4IR8XmH3ZyWGiod0D3vT//
	 WJWCUcBKQNw+OiU/GWUgp17uAeqKUMtmxaJUB2mHnLpj/9bWYn6Iw+DMwENNOdI/pD
	 qJHdnL6b97wmw==
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
Subject: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
Date: Tue,  3 Feb 2026 10:38:15 +0100
Message-ID: <20260203093819.2105105-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding btf__find_by_glob_kind function that returns array of
BTF ids that match given kind and allow/deny patterns.

int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
                           const char *allow_pattern,
                           const char *deny_pattern,
                           __u32 **__ids);

The __ids array is allocated and needs to be manually freed.

The pattern check is done by glob_match function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 83fe79ffcb8f..64502b3ef38a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 	return btf_find_by_name_kind(btf, 1, type_name, kind);
 }
 
+int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
+			   const char *allow_pattern, const char *deny_pattern,
+			   __u32 **__ids)
+{
+	__u32 i, nr_types = btf__type_cnt(btf);
+	int cnt = 0, alloc = 0;
+	__u32 *ids = NULL;
+
+	for (i = 1; i < nr_types; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *name;
+		__u32 *p;
+
+		if (btf_kind(t) != kind)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (deny_pattern && glob_match(name, deny_pattern))
+			continue;
+		if (allow_pattern && !glob_match(name, allow_pattern))
+			continue;
+
+		if (cnt == alloc) {
+			alloc = max(16, alloc * 3 / 2);
+			p = libbpf_reallocarray(ids, alloc, sizeof(__u32));
+			if (!p) {
+				free(ids);
+				return -ENOMEM;
+			}
+			ids = p;
+		}
+		ids[cnt] = i;
+		cnt++;
+	}
+
+	*__ids = ids;
+	return cnt;
+}
+
 static bool btf_is_modifiable(const struct btf *btf)
 {
 	return (void *)btf->hdr != btf->raw_data;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b30008c267c0..d7b47bb0ba99 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 	return (struct btf_decl_tag *)(t + 1);
 }
 
+int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
+			   const char *allow_pattern, const char *deny_pattern,
+			   __u32 **__ids);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.52.0

