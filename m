Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901574;
	b=pnvRWndu9gEjaO3s7Ka6sv1FZe2TvUn0IRjZFV0C/NXe4eDuMF4z9u9llhBj0WlJ57bq
	 BMOQTnCRvthB6rMbLV2rklu0J3U9L8GU3qOLydTwT2K8Cp6PjkW5SSfaGHFIe+DBJB/dH
	 zzbimjsH+sBHg6ZKaQ4lQPWBVoQm1HsvG2qUCYDaybOUgMvNA9pt2dmENh33DHuWhswdR
	 Jx5uNFnIUqQuT869deFUU9MxL2W98xIV++/QuoRHmwJwrqqWa/m2/3UKlrTHJHcrGTAoH
	 zIJ9eLkcxEPhCOldt+6KtBaKCgRN5gIzWMnvl/ZEWoKGQMw54TYRsCAAfOvvfRuVr7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901574;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n8ZViMW1MawyefItBv1UZBmlgvNlGvjumGa9Cgcp5X0=;
	b=Opqz/xYucnqdjAmeHAQz6r7Pu1IO9z4dqXLIonFy7/bZGrN0V/Wkmq5Oxbh2WnsXBAVY
	 L3nIlZ9GcAzii+jLH84lWFxxFeqqtQ7KN4JLgpTzALwra6fVwFp5C3rWDGjb4Ec4W+AZ5
	 v9QG+X2xroqZYOHnmYJoFdTyIA44Vle/7gOoxqoVbWzDBry/0OXbdNZ4l3k/cjpNQiIBH
	 6uG4mLgWSiQturk6PjroKYeQlKcUdq2hls9/xhYtifbPuEYnyxtu5BqIMV6PzsoIGoiIH
	 AY7bZjen55df3ayq2om3YjSitscPLxc9YOREN4BVg7vbKMJ0cxZOCsNNqnCvAmkR6lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JOTiPaD9;
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57530606A329
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57530606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JOTiPaD9
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SL5JKr0sJ1cO/OzigGYQgubfvDLFwhYQYS19uBM4Xl4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901571; v=1; x=1794506371;
 b=JOTiPaD9sb7Q9H60TGAItwDIfwCe+D9NagsHcQDhi2XOM7cOZ5dFZv4ouRxSgWgsyNpJ3vV5
 M7u00jA+T//R/wnqq03dPvSzyxW0xRjFuMUxV75CZMFRtJwHmLtZkn5t0zuSuZVhqPmvd5pasM2
 2r2ZCbtgeEKmM/Qcud4wCrz0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f7df7c898d37275c;
	Thu, 05 Nov 2026 17:59:31 +0000
X-Mizu-Trace-ID: f7df7c898d37275c
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
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 02/17] libbpf: Look up BTF strings without making BTF modifiable
Date: Thu,  5 Nov 2026 10:58:30 -0700
Message-ID: <20261105175845.30357-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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
 tools/lib/bpf/btf.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e1ff97098ee5..5786232c1fea 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -153,9 +153,10 @@ struct btf {
 	 */
 	int start_str_off;
 
-	/* only one of strs_data or strs_set can be non-NULL, depending on
-	 * whether BTF is in a modifiable state (strs_set is used) or not
-	 * (strs_data points inside raw_data)
+	/*
+	 * strs_data points inside raw_data until BTF becomes modifiable,
+	 * then strings live in strs_set. Before that, strs_set may exist
+	 * as a lookup index for btf__find_str().
 	 */
 	void *strs_data;
 	/* a set of unique strings */
@@ -1252,15 +1253,15 @@ void btf__free(struct btf *btf)
 
 	if (btf_is_modifiable(btf)) {
 		/* if BTF was modified after loading, it will have a split
-		 * in-memory representation for types, strings and layout
-		 * sections, so we need to free all of them individually. It
-		 * might still have a cached contiguous raw data present,
-		 * which will be unconditionally freed below.
+		 * in-memory representation for types and layout sections,
+		 * so we need to free both individually. It might still have
+		 * a cached contiguous raw data present, which will be
+		 * unconditionally freed below.
 		 */
 		free(btf->types_data);
-		strset__free(btf->strs_set);
 		free(btf->layout);
 	}
+	strset__free(btf->strs_set);
 	btf_free_raw_data(btf);
 	free(btf->raw_data_swapped);
 	free(btf->type_offs);
@@ -2043,6 +2044,21 @@ static void btf_invalidate_raw_data(struct btf *btf)
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
@@ -2050,7 +2066,6 @@ static void btf_invalidate_raw_data(struct btf *btf)
 static int btf_ensure_modifiable(struct btf *btf)
 {
 	void *types, *layout = NULL;
-	struct strset *set = NULL;
 	int err = -ENOMEM;
 
 	if (btf_is_modifiable(btf)) {
@@ -2078,18 +2093,14 @@ static int btf_ensure_modifiable(struct btf *btf)
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
@@ -2108,7 +2119,6 @@ static int btf_ensure_modifiable(struct btf *btf)
 	return 0;
 
 err_out:
-	strset__free(set);
 	free(types);
 	free(layout);
 	return err;
@@ -2131,8 +2141,7 @@ int btf__find_str(struct btf *btf, const char *s)
 			return off;
 	}
 
-	/* BTF needs to be in a modifiable state to build string lookup index */
-	err = btf_ensure_modifiable(btf);
+	err = btf_ensure_strs_set(btf);
 	if (err)
 		return libbpf_err(err);
 
-- 
2.56.0

