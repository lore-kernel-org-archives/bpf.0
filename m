Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.241
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403255;
	b=5lkqVglphDrNMDdbpua7VPZlRb4TbLdQQSezhG8rmVHCKMoZ76dy0UFOoJ9Ar1qi1BtL
	 2VYaF4NhH83saS6t6tzeOqgCSpZC6Qar0Ra8Fzlijv+g/ZW3jiPSZAroai17Anj/HJR2J
	 IcX62m+cGEUqIGgH0VXvj9gTU8fmBx6J6vdvgUNltpOnfvzp5JZ9JYc2mVOo0+BQ8m1CL
	 JHrVEkR3ccbU/Nb/3WmyE1hQ4fpicwlpEkPqiVFBqJ/YNctgODlJEjTxNzAPwI3UAAtaP
	 d6+k42k8t1J7YMZLZgbaktAdmTpUK0P6FIcBsXyPu8x+DPENfYwziCfHR0Uag57U6rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403255;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H8/NYbp+Nd3F65sdejDq1wglbQaMWNH2+Ant5BwsApM=;
	b=UjAep/L+1aujS9lCncz0a14gfh5YdYch4qWHNl3Vez6O3XdY/aIXBLFoaLuzAOYvqF1F
	 fSWKis7ZQshTmGp32aTBbTS/F8rG6q/hEWaTH9F/Pj/Dqgk0Uwt6tJ22Pj6UJic3HByGl
	 jsFRWAtZGZcNpY9UBGeZSgrBzrbrd2SLKBr05cn6ZXPcw3Sq0JCjMeCvUU9PGrLHwrWn+
	 RFoMQJG11KAofA+s+tJNDJnB9QZEm2a52+xH2WVPiQxixbgRAq1QYF2NMdrEzDUj7Xf6M
	 aOFRObTnagQ2rhuRSqYm9zF/TbOfG7JAFZ0r0xdbedjLwghOuzJPo4OLfYT1AgrXBiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lbORuZih;
	arc=none smtp.remote-ip=91.218.175.241
Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FE606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33FE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lbORuZih
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ExIFrPPy71wHVY1eT2nJ5LwJ0NamPJjJ+06dpy5RLJw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403251; v=1; x=1794008051;
 b=lbORuZihXBNYvfCiBv4T7ibKJdVU7mWdVtnCT3gIg624ofe6zAY8TSenRn1EdyIstsBtXEqS
 S1xZelhOVpERR+6uu1m/9C3VbT6MfLgRAYlaHSWqYvdV77V2rqa6ZzUWKtNd0tKBImmIV57xmUO
 /OGGlx5csn9IPx9tk8eJLNVU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 49366713bf841172;
	Fri, 30 Oct 2026 23:34:11 +0000
X-Mizu-Trace-ID: 49366713bf841172
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
Subject: [PATCH bpf-next v3 01/13] libbpf: Look up BTF strings without making BTF modifiable
Date: Fri, 30 Oct 2026 16:33:43 -0700
Message-ID: <20261030233355.1836749-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
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
 tools/lib/bpf/btf.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d2ff6f5d6d5b..47a04be0a55a 100644
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
@@ -1258,9 +1259,9 @@ void btf__free(struct btf *btf)
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
@@ -2042,6 +2043,21 @@ static void btf_invalidate_raw_data(struct btf *btf)
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
@@ -2049,7 +2065,6 @@ static void btf_invalidate_raw_data(struct btf *btf)
 static int btf_ensure_modifiable(struct btf *btf)
 {
 	void *types, *layout = NULL;
-	struct strset *set = NULL;
 	int err = -ENOMEM;
 
 	if (btf_is_modifiable(btf)) {
@@ -2077,18 +2092,14 @@ static int btf_ensure_modifiable(struct btf *btf)
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
@@ -2107,7 +2118,6 @@ static int btf_ensure_modifiable(struct btf *btf)
 	return 0;
 
 err_out:
-	strset__free(set);
 	free(types);
 	free(layout);
 	return err;
@@ -2130,8 +2140,7 @@ int btf__find_str(struct btf *btf, const char *s)
 			return off;
 	}
 
-	/* BTF needs to be in a modifiable state to build string lookup index */
-	err = btf_ensure_modifiable(btf);
+	err = btf_ensure_strs_set(btf);
 	if (err)
 		return libbpf_err(err);
 
-- 
2.56.0

