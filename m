Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000273;
	b=ocoJ3b0Wknzq5JlppUT0o2ylJN1DAL58ZED9ZAd5C3VbEQyP+fPP25L/AyzN3I9KIlvr
	 58qFXCm0vyl+L7vnDi+8642Cupthh3m0RydKkqo7wYQSoZ1AxDuzmwR5zIhUF6mE9zaTU
	 oYDWM4qd+3Qj28HeyILvosMTsohr8DOuJoUM6f8qwB0MZWWCq+XYkic2SBwQq+U7pbECW
	 /8y9GJCoZ//9Pec6AjEkECLYQr6tmZwjofIJvkXspVqfpGCsNs8YxVvvI8sRmbJj4k/HU
	 BPTkPdgASQ4GMG2BSWPNfNH1CtCKuI0qWwvTXMwxxL4puoRcHGhgEQqoPzGdxbtz+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000273;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=sNH47+qhqvIkLJM70XO7X5MhEUEpHyY8xi1+x4fP4S8=;
	b=nS5Iu0YyZKAxLlExgGEqblnwwvDbLXb5GUFb6PEy9O6RhZwk7fIi64Ur9r/2ye5n5t6J
	 u5jJ3GQAjpZBX8GYrso578RxAal6/+PM9tGtNfmB3uuopjGU5ExiSM7QNke3WEkYCA7ot
	 x+SoLBww8rg6gOwSnitufVWw1GtzqzVTY5/yXpper7DA+EP5jLgqU4WLFO+iLjqGqXBQM
	 +XsoQLPFE4B25woXMA6nbqw0AZiEk29+BTE3n9wvJH9oRFIZU38xmzaQSGzOmUlSrtC1n
	 Yr3cyGKScizGVDNziyLQ1YhqsHgGRa2PRvuyE8ByPCKi9Vgjdb7egEvNGmJD1A8siCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oc5b+gSr;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B97606A31A;
	Mon, 26 Oct 2026 07:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B97606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oc5b+gSr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sN
	H47+qhqvIkLJM70XO7X5MhEUEpHyY8xi1+x4fP4S8=; b=oc5b+gSrnG596ADi/5
	v6LlHYEpRDq+lOpZx056lB4zM9HYvKqCc4OJinLty/ICF9ah4FDm9u82wGEWhIEx
	cKqXnPOFcVLHEOjwUBzdhrqH7W2OnU2aF+uo/066HBDOzYzfdZhhqC5ak3Rjq/9O
	klRZpEm+PQ25uKQAIOuOO2GmU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnhy0WA99qbWwVCA--.55172S2;
	Mon, 26 Oct 2026 15:36:55 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] bpf: Fix out-of-bounds btf->types write for split BTF
Date: Mon, 26 Oct 2026 15:36:54 +0800
Message-Id: <20261026073654.840705-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:PSgvCgDnhy0WA99qbWwVCA--.55172S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWxGFykKFWUXFWrtFy3XFb_yoW5Crykpr
	4rCFs5Cwsag3WxXa47ta45Wa18Kw1rC3y7JFZ0yrWFyF4j9r10vF1UGrW293sFvFn7GrWY
	yr4v9rZYgw48WrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxdY0GrfAxdEpQAA3Q

From: Feng Yang <yangfeng@kylinos.cn>

btf_add_type() bounds the btf->types array by BTF_MAX_TYPE, but for a
split BTF the type ids it registers are start_id .. start_id +
nr_types - 1, so what is actually left of the id space is
BTF_MAX_TYPE - start_id.  Two things follow from that:

 - the limit check is an equality test,
   'start_id + btf->types_size == BTF_MAX_TYPE'.  It is evaluated only
   when the array has to grow, with btf->types_size == btf->nr_types,
   and the growth (T' = min(BTF_MAX_TYPE, T + max(T / 4, 16)), starting
   from 0) is clamped to BTF_MAX_TYPE, which it lands on exactly (...,
   928143, then min(BTF_MAX_TYPE, 1160178)).  So unless
   BTF_MAX_TYPE - start_id is one of the 48 sizes that sequence hits,
   the check does not fire for a split BTF at all;

 - new_size is clamped to BTF_MAX_TYPE instead of
   BTF_MAX_TYPE - start_id, so the array can still grow to
   BTF_MAX_TYPE entries even though only BTF_MAX_TYPE - start_id type
   ids exist.

As a result nr_types can reach BTF_MAX_TYPE for a split BTF while its
type ids have already gone past BTF_MAX_TYPE; a type never validates its
own id, only the ids it references (btf_ref_type_check_meta()).  At that
point btf->types_size == btf->nr_types == BTF_MAX_TYPE and the growth
branch computes the same size again: it allocates a fresh BTF_MAX_TYPE
entry array, copies the entries, and the loop is left with
btf->types_size != btf->nr_types, so that branch is not taken anymore.
Every type after this writes btf->types[btf->nr_types++] past the end of
the array: BTF_MAX_TYPE * 8 == 8388600 bytes are requested, so the first
such write lands in the 8 byte rounding slack of the 8MB allocation, and
each further type writes another 8 bytes beyond it.

Fix both by bounding the array with BTF_MAX_TYPE - start_id and by
turning the equality check into a '>=' one, so that the array stops
exactly where the id space ends. Base BTF behavior (start_id ==
0) is unchanged.

Fixes: 951bb64621b8 ("bpf: Add in-kernel split BTF support")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 kernel/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ed1ff71a089..ca49c47f6a45 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1752,15 +1752,17 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
 		/* Expand 'types' array */
 
 		struct btf_type **new_types;
-		u32 expand_by, new_size;
+		u32 expand_by, new_size, max_size;
 
-		if (btf->start_id + btf->types_size == BTF_MAX_TYPE) {
+		if (btf->start_id >= BTF_MAX_TYPE ||
+		    btf->start_id + btf->types_size >= BTF_MAX_TYPE) {
 			btf_verifier_log(env, "Exceeded max num of types");
 			return -E2BIG;
 		}
 
+		max_size = BTF_MAX_TYPE - btf->start_id;
 		expand_by = max_t(u32, btf->types_size >> 2, 16);
-		new_size = min_t(u32, BTF_MAX_TYPE,
+		new_size = min_t(u32, max_size,
 				 btf->types_size + expand_by);
 
 		new_types = kvzalloc_objs(*new_types, new_size,
-- 
2.25.1

