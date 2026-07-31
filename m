Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2034CFAB
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532222; cv=none; b=d5EZlPOrz35xqNgAg4tE6WS7pSIsVBpErMQQMzswdCBDqJuef7kYTGsLyOfkEVXw6nwmK35eYpHv94e03UZkEkibqw9QiXx2YQvOYe3MdpLpQEdN6txudqCZmCjCEs/6VzIIKfU/V/kqrO8wfh6Ahy4tpU+oMpBW962P3fBRsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532222; c=relaxed/simple;
	bh=PR3Bp73vI05mAx1F44n3FY+ldtWj56/O2LK2iDCPS9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cJ+qOFG0m8ZaEQHpISFNlRp0r2iCwnVN7NZyO58azlJaPhemjVeMCHdZJohFMhXe6eWwbN7rM0U+GwSppyfokgbCYtYsj4FVtO5uKq7k5TiTI3udQ0BB+lldzwfWfGvtHszVyzbP1TwXrya8i1SOds5nE5hcQdomcPkpBSlbXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=MzL31+xk; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="MzL31+xk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+fT83rzR21uNlU8Xnb/Naf86VNYyO6YnJkXHXsyBP4c=; b=MzL31+xkJBTRejIbslGAnsQzEC
	5U1PNNaFgKtGrhiMUqH2fROAWlbtOhRIYEt8LYqBDmHbQ/XAb+wQ1yPXDTqmxocETnyiQbFKjXW+v
	cECCnYgTWwJban2aI85MLy1HY+jY6o6d7rKGgoL52P6nwKXTyQTXAzg88Ju8aJggD8VYw3NK2uEQv
	1stfkTPt+vzhy/vOIBsz5ld3VukmZz7XVbQoowTc4DJknXIaNlAhwy8a2w4EB1KNQZn3aHC2R/9U4
	Lj6DTOLfxHD9h1m4c/qdfHCVqf+gcVGvAFHfGtptOOPsEXhDV3vK2hsd/zOu3wHX3kEKurZb85gvN
	Jj0tiAeA==;
Received: from [151.115.150.205] (port=50974 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wpuAZ-0000000GSix-45DW;
	Fri, 31 Jul 2026 22:49:26 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: bpf@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH bpf] bpf: harden bloom filter allocation sizing on 32-bit kernels
Date: Fri, 31 Jul 2026 20:48:53 +0000
Message-ID: <20260731204917.3845309-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-scw-domain: oss.cyber.gouv.fr
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

bloom_map_alloc() can under-allocate bloom filter storage on 32-bit
kernels when the bitset size reaches the U32_MAX fallback case.

BITS_TO_BYTES(U32_MAX) is evaluated with 32-bit arithmetic and wraps to 0,
while bitset_mask remains U32_MAX. As a result, later bloom filter updates
can write beyond the allocated object.

I reached local privilege escalation using only this bug from a binary with
CAP_BPF.

Compute the bitset size from bitset_mask in u64 and check the final
allocation size before calling bpf_map_area_alloc().

Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")
Cc: bpf@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/bpf/bloom_filter.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index b73336c976b..8e6532fa418 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -94,9 +94,10 @@ static int bloom_map_alloc_check(union bpf_attr *attr)
 
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
-	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
+	u32 bitset_mask, nr_hash_funcs, nr_bits;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_bloom_filter *bloom;
+	u64 bitset_bytes, alloc_size;
 
 	if (attr->key_size != 0 || attr->value_size == 0 ||
 	    attr->max_entries == 0 ||
@@ -127,23 +128,21 @@ static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 	if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits) ||
 	    check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
 	    nr_bits > (1UL << 31)) {
-		/* The bit array size is 2^32 bits but to avoid overflowing the
-		 * u32, we use U32_MAX, which will round up to the equivalent
-		 * number of bytes
-		 */
-		bitset_bytes = BITS_TO_BYTES(U32_MAX);
 		bitset_mask = U32_MAX;
 	} else {
 		if (nr_bits <= BITS_PER_LONG)
 			nr_bits = BITS_PER_LONG;
 		else
 			nr_bits = roundup_pow_of_two(nr_bits);
-		bitset_bytes = BITS_TO_BYTES(nr_bits);
 		bitset_mask = nr_bits - 1;
 	}
 
+	bitset_bytes = BITS_TO_BYTES((u64)bitset_mask + 1);
 	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
-	bloom = bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_node);
+	if (check_add_overflow((u64)sizeof(*bloom), bitset_bytes, &alloc_size))
+		return ERR_PTR(-E2BIG);
+
+	bloom = bpf_map_area_alloc(alloc_size, numa_node);
 
 	if (!bloom)
 		return ERR_PTR(-ENOMEM);
-- 
2.47.3
