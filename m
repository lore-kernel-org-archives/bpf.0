Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693938;
	b=msV6U1uOJVFihz8WFuUsO21k0SSffFBgAa4zGnekpWSeVRL0ZCidgmcPj1sRf+CJoP0N
	 zYdRgyUlAZqVh7sHtoQnSObYKOPPgV2JZEwIPJeBHN92UA0YKIIWXJUoIhQGPGSBcE+Nk
	 Xn5RM7X73WU38QOhwyB3BZVbcCvbLf4O8bRx23jUKV0/tNFwHn49ZJmA2zPLN8XYWLIjV
	 V+7NKA+GnavDB4ltctyIdi6Yp+3qcDBoG4kcL3k9jtuZVsahWsuumjeeW41PIA+bG+rre
	 DjdDmX6TOwTI+zlf2MgZf718tfpO4+RytP7r8t6PER2Nw9n+CSHGgij+resJapXN8BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693938;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q9qNvJLwCf7x1Jx3yj2W8Xx3AQDRF1mMWWisAr7uXyI=;
	b=CdDBb8K4xDtRqbyABE377CHhLgenqrOFFcRmtl89/nkjqgczwP5j2zFyhvEBeUdd5djq
	 hD/r99CjMXk5Hz5miKvbA7adSvVXCH4JvjtBO7Fy/Y+jFR2fNyZFf57mb6EC97DDakC/R
	 IRIEnj09GJFzS2DvSLsewvIhwwVs0SiVyBnbguqRdZiZnGSCRJo0Y0HaNT2zSqq/E4v+z
	 1ybHlgwERDKFBmvlakkqCjATWR+FLrXH+ISfAbNd+QhNLaMlv22x73zPtGNOH7T7ZFtCm
	 m4e9EpffvjczFQdlBGlwnK2IU0Uwz5p3TXnJKZlVjiKhHQHeGO0eu1X3YfdpRt+zrXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mxEZC+k2;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07966606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07966606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mxEZC+k2
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8fFpOJ/BSEAomJCGeqs5M8Cl6EgDVyeQJlq5nmvCZ3I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793693933; v=1; x=1794298733;
 b=mxEZC+k2sZE1IehcTR85AGmBUk94LoZISx2dXGooGSfDzc6Y1F6CFs5vSvQMnwjY8WZjl3K8
 JGiBnXWXA3R5JcRrV1NMFWJQrVqqSNZ8peBPXubwwxAb7kBgbL2S3f+8elH/Fw2AffstBQXsSi0
 esdIYFnyU5xsVBrKSwQ3Vbns=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 129aeac7966a988c;
	Tue, 03 Nov 2026 08:18:53 +0000
X-Mizu-Trace-ID: 129aeac7966a988c
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	=?UTF-8?q?=E6=B4=9B?= <wanghai8081@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] libbpf: Fix stale raw data after btf__relocate()
Date: Tue,  3 Nov 2026 16:18:35 +0800
Message-ID: <20261103081836.381430-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

btf_relocate() rewrites type ids in place but doesn't drop the cached
raw_data, so btf__raw_data() after btf__relocate() returns the old
bytes with pre-relocation ids.

Only modifiable BTF keeps raw_data as a cache. For read-only BTF, e.g.
module BTF relocated in btf_parse_elf(), types_data points into
raw_data and is already rewritten in place, so it must not be freed.
Make btf_invalidate_raw_data() tell the two apart and call it from
btf__relocate(). Also recompute named_start_id since start_id changes
after relocation, like the kernel does.

Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
Reported-by: 洛 <wanghai8081@gmail.com>
Closes: https://lore.kernel.org/bpf/455f7257-25b9-4070-8313-42af8005b948@linux.dev/T/#t
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2:
 - Free raw_data only for modifiable BTF and call btf_invalidate_raw_data()
   from btf__relocate() instead of btf_ensure_modifiable(), per Alexei
 - Recompute named_start_id after relocation
 - Drop the selftest since it is contrived, as Alexei pointed out
 - Target bpf-next
v1: https://lore.kernel.org/bpf/20261101155615.324501-1-jiayuan.chen@linux.dev/
---
 tools/lib/bpf/btf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d2ff6f5d6d5b..d67f78d76750 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2033,7 +2033,8 @@ struct btf *btf__load_from_kernel_by_id(__u32 id)
 
 static void btf_invalidate_raw_data(struct btf *btf)
 {
-	if (btf->raw_data)
+	/* types_data and strs_data of read-only BTF point into raw_data */
+	if (btf->raw_data && btf_is_modifiable(btf))
 		btf_free_raw_data(btf);
 	if (btf->raw_data_swapped) {
 		free(btf->raw_data_swapped);
@@ -2099,11 +2100,11 @@ static int btf_ensure_modifiable(struct btf *btf)
 	if (!btf->base_btf && btf->hdr.str_len == 1)
 		btf->strs_deduped = true;
 
+	btf->modifiable = true;
+
 	/* invalidate raw_data representation */
 	btf_invalidate_raw_data(btf);
 
-	btf->modifiable = true;
-
 	return 0;
 
 err_out:
@@ -6642,8 +6643,12 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
 {
 	int err = btf_relocate(btf, base_btf, NULL, NULL);
 
-	if (!err)
+	/* types are rewritten in place, some of them even on error */
+	btf_invalidate_raw_data(btf);
+	if (!err) {
 		btf->owns_base = false;
+		btf_check_sorted(btf);
+	}
 	return libbpf_err(err);
 }
 
-- 
2.43.0

