Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794440;
	b=lvWIEtDjkjeWJhwjX4mRNY3T/kQ2LluB1ApO9PG3q6Esh3mH4VatXPN/Fs3JIbx/Dfsd
	 rWBC2RHPS6+xS4pqhF3U5JfZHLAmSqE8L+8AEY1JHL4Aw84AJcRxngUGeskOlG3npuZ5w
	 cAJ0PcH4/DHwll1eOyef7OLyb1NuNIXr/YTp27G8CemM3tgSjWj9WC6B5WuEFdGYOcStK
	 UatLPrA2CA/IcSP1icOuHtyhWh2lbTeDNzY5768F4xZI4Y1NJ5OCQ27SvJLr2KSzage8m
	 qIPU5z4sihUBRZe7fUU/KIWYmajS04CqWVEARkG1IDRrjT7Mte4hAPV/wFsyHxq/2aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794440;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F8QjwYYOERsVlx8wSfewFG1QNWj8XmS2pbah2E2XFhY=;
	b=tKTkIpq23GR22CDQpEcqy+DwwVnq9mvgjLux1cjYu5rmY9X1XCVH5PEQVDF6kuHnaVTD
	 9JjTjSAZEKmUh0WZJt9clwTeqYEyR40I3WJ4uLdxx+Us+SNKy8oowlLXb8rYIsTG/lXH4
	 EHRQqYNAJZXYIhuWHQvYzI3kHI+U2FXndSkB+oNZ90s3/PP2E/1hwBL7HethOw6wSR+fX
	 fYM9WbT1kzJCm4TVYV0iMtA0tgn+pOWOJRWgEsoaLKMfRoQfxEyYJaGTfO8oG/9t32Jdf
	 nLGc46fiGDYBBgfW28Vb8ZxXAJuYZk2KOPYllaYaPt6Ym7pzocaqkf+/c6hDN8ljIvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DuSPWZav;
	arc=none smtp.remote-ip=91.218.175.166
Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A05606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DuSPWZav
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iqplr58JFPVVk7W6u+yMUpnlrUQcQiHYVwR1y12ovRs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794437; v=1; x=1793399237;
 b=DuSPWZavIFpxc4rU53Sx91WP6w6EV57HrY+ImsZ9haYtB3O7dARh4zqU/ghkWgfN2vUZcXcI
 FDiDGpFD2nLI52MpEvQZzPpIY+wGyknfhrNADUO/LOoI6DLifEE2boP3UMPE5NXtr8Nu7PK5UjC
 cZofqG3D9N0ThMcCuiENwxWQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f7e2f564baada6d3;
	Fri, 23 Oct 2026 22:27:16 +0000
X-Mizu-Trace-ID: f7e2f564baada6d3
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oracle.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2 1/8] libbpf: Look up BTF strings without making BTF modifiable
Date: Fri, 23 Oct 2026 15:26:45 -0700
Message-ID: <20261023222652.3927736-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf__find_str() needs a hash index of the string section, and gets one
by making BTF modifiable. That copies types and strings out of the raw
data, and fails with -EOPNOTSUPP on BTF with unknown extension bytes.

btf__add_str() and split btf__dedup() look up strings in the base BTF
first. So adding a string to split BTF, or deduping it, makes the base
modifiable as a side effect, and fails if the base comes from a newer
kernel with new header fields.

Build the string index without making BTF modifiable, and reuse it if
BTF becomes modifiable later. The index can now exist on read-only
BTF, so btf__free() frees it unconditionally.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/btf.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d2ff6f5d6d5b..d8907281c0ef 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -153,9 +153,9 @@ struct btf {
 	 */
 	int start_str_off;
 
-	/* only one of strs_data or strs_set can be non-NULL, depending on
-	 * whether BTF is in a modifiable state (strs_set is used) or not
-	 * (strs_data points inside raw_data)
+	/* strs_data points inside raw_data until BTF becomes modifiable,
+	 * then strings live in strs_set. Before that, strs_set may exist
+	 * as a lookup index for btf__find_str().
 	 */
 	void *strs_data;
 	/* a set of unique strings */
@@ -1258,9 +1258,9 @@ void btf__free(struct btf *btf)
 		 * which will be unconditionally freed below.
 		 */
 		free(btf->types_data);
-		strset__free(btf->strs_set);
 		free(btf->layout);
 	}
+	strset__free(btf->strs_set);
 	btf_free_raw_data(btf);
 	free(btf->raw_data_swapped);
 	free(btf->type_offs);
@@ -2042,6 +2042,21 @@ static void btf_invalidate_raw_data(struct btf *btf)
 	btf->named_start_id = 0;
 }
 
+static int btf_ensure_strs_set(struct btf *btf)
+{
+	struct strset *set;
+
+	if (btf->strs_set)
+		return 0;
+
+	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr.str_len);
+	if (IS_ERR(set))
+		return PTR_ERR(set);
+
+	btf->strs_set = set;
+	return 0;
+}
+
 /* Ensure BTF is ready to be modified (by splitting into a three memory
  * regions for types, strings and layout. Also invalidate cached
  * raw_data, if any.
@@ -2049,7 +2064,6 @@ static void btf_invalidate_raw_data(struct btf *btf)
 static int btf_ensure_modifiable(struct btf *btf)
 {
 	void *types, *layout = NULL;
-	struct strset *set = NULL;
 	int err = -ENOMEM;
 
 	if (btf_is_modifiable(btf)) {
@@ -2077,18 +2091,14 @@ static int btf_ensure_modifiable(struct btf *btf)
 		       btf->hdr.layout_len);
 	}
 
-	/* build lookup index for all strings */
-	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr.str_len);
-	if (IS_ERR(set)) {
-		err = PTR_ERR(set);
+	err = btf_ensure_strs_set(btf);
+	if (err)
 		goto err_out;
-	}
 
 	/* only when everything was successful, update internal state */
 	btf->types_data = types;
 	btf->types_data_cap = btf->hdr.type_len;
 	btf->strs_data = NULL;
-	btf->strs_set = set;
 	if (layout)
 		btf->layout = layout;
 	/* if BTF was created from scratch, all strings are guaranteed to be
@@ -2107,7 +2117,6 @@ static int btf_ensure_modifiable(struct btf *btf)
 	return 0;
 
 err_out:
-	strset__free(set);
 	free(types);
 	free(layout);
 	return err;
@@ -2130,8 +2139,7 @@ int btf__find_str(struct btf *btf, const char *s)
 			return off;
 	}
 
-	/* BTF needs to be in a modifiable state to build string lookup index */
-	err = btf_ensure_modifiable(btf);
+	err = btf_ensure_strs_set(btf);
 	if (err)
 		return libbpf_err(err);
 
-- 
2.56.0

