Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AB43C7C2
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144075; cv=none; b=MoqjlShOZXLNPoxtSEJRQBbCwmPXN0swp1+i/aFnkQSQEMeUYCGM9a+QSfsSaJqfSzVIORuhO225rpxKaYBTZIbGQhR8etnqpd1p6/G9Qg395+w7Fpwd+d9Cph2z2l48DePG+eGhtOZnopee4kYlxc+kaNSPX5clF6fPYKhc+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144075; c=relaxed/simple;
	bh=vsPFsbnszePTjw5EosWeramvK7rG2ERdLL6MSmBAX54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=im3SgJeFUYt9ze3ts0aqd6Y2NpMtJbg6uNtJIHYZmOC3cmw1Y0gjj3dpes9yJrZGJ7XTLZS4q7v1+jHYRRZO8ekIAPqSPTIZSVN4QRNiWA14yJtrm7PVPo9CU70iCfelE+mOig1MnuQQ6y3lB9iDOKvW3iXWHE/bT1apq4OFdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Ei/eANBM; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Ei/eANBM"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c3304833so303563a12.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790144069; x=1790748869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTnthqBs4OTj0tA1VcwZjvfqXkPrjXOvKKAEOEpZHSs=;
        b=Ei/eANBMDP45vI2jSfCViHUix7CjeaQ5C6teOG0FZJqt69KR+T9orPqc6h7q+RjxT0
         1+JGaZUUYGIKR2FdNw5AVAbUu1n5MuxAW0TOf17dR7ndoYznou+fxnTFp1reCQe1otbr
         ctLEncEhr4FQwSNvuoqZr38KXiGcUYHPDizzQ16NM5P1zjTXfKJ1ZSc+9Bs72+ACjZD0
         0TVUlfg56U8Lw79iWMLEhi2KlmrvGrnOBIQMui4quApJXRAgF7Pxr2wsGWIKdda4o6m1
         4SLO79Kx0gF9NM4y1KpmpEe7m7tuRpS4WidCJWL19xiKyBKkPzeymwMgGriSO4VwjxAa
         0iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144069; x=1790748869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTnthqBs4OTj0tA1VcwZjvfqXkPrjXOvKKAEOEpZHSs=;
        b=M8WO2WhXvmS9cFK+BonibTg3OiHfy34DpwGuQGZGOSE0kR2XKoZqylAsDW9H8pugLy
         bDjip6iNf6L3Q/2cE46X/UY10qJLQASgdFmiqW3uF+/4p8Kyre1mvhz+CHoNP+rDTnUT
         cywXMWNV3YY1Klg45fw0RDaM3dMAp2/nocpai7C3B1/2kahsXwP4vNIdzD9Eh44X4b0G
         fTXW7/euPbrJgqhVmLGF4PlKBXpCYhQ1UNxd2CGbtSlJBTMFRjVyV3dQaQ8y8rbqUg1k
         tXx9eHiN9QMqgcOaWbthllmw4KRPOi2GFZxBTNJehiCopvman1sKm6Ea+o2tnuGBNtKb
         6R+g==
X-Gm-Message-State: AFuF++mAl08bR2JDaisBvrhtx9Rq5IAadeiJfcmj7W3I2QHW3nQlmQ7g
	xDvDrx4sm8adFLU8lxFSC41Ty1uw77aMM3mu1ws1jkf88tgXl/QGJoqb8cNO7SdycH60mHWYUNz
	vPYhA3VLnUw==
X-Gm-Gg: AYBFou3qLZe+vCOaoE4KsxZ61bhSD2TLA6SeacqpcQPzlPOsBqf10NGygnEwNv5h6CA
	MuGhbkAHaVuxDGB0mhMsgWPBzl8YrZoOsJBjXRwSMBn3BspRb/OaOVrSfzRM68y5Nf3tfOEI9Bb
	ZM9L04Z+27pVZhlk6AeiIqbwvFt1dqxO02m8nlLxxsAQG3OlAPse6Ibt2p2FB3sfNZOjsBkUWDl
	PHx36oFFXQV1OxBbIYYOdKbpGw95sp3m5Swp7y34u6fEQB6kVQ9+MLCNB7bE92j2AENWMQDMmGR
	0wJ2Nus1n3F2KuzJFHHPSen4k+mkn7J275ojrrGMQv8qucwLDS7uV4+SSIt/KqdTvFgLSVnXtRJ
	KnuwIFbBX7qky1V/TZpEa95UjG+of3R4CN8z0F/ShbitoqhYWPDwpl6Xeln52aw8wcc/65dxWgV
	/cUjgS/CxstaNDn0DcQNbzzsGvMteEj5uSuewXimd4BoE44cpwkGOKoiwO7P1v5hrWDPlFuNeO5
	GMVWnu+yxt0h5PlZl3EZS4Zq+KzXNO5mJSyvc1NmA==
X-Received: by 2002:a17:90b:3d8e:b0:39e:6c69:34d7 with SMTP id 98e67ed59e1d1-3a07e7b1239mr1548947a91.59.1790144068801;
        Tue, 22 Sep 2026 23:14:28 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de57682sm3562652a91.16.2026.09.22.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:14:28 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 1/7] bpf: Update is_range_tree_set to work for consecutive ranges
Date: Wed, 23 Sep 2026 06:14:19 +0000
Message-ID: <20260923061425.7045-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923061425.7045-1-emil@etsalapatis.com>
References: <20260923061425.7045-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena range tree currently does not handle consecutive
ranges present in the tree. This is by design: Consecutive
ranges get merged into one by default. However, this design
only lets us track a single bit's worth of state for each
address range, encoded by whether the range is present in
the tree or not (i.e., is it allocated).

We require more fine-grained state tracking for each range.
This means possibly having in the tree consecutive ranges
that cannot be merged because they have different states.
However, existing code implicitly assumes that this scenario
is not possible in its logic.

Expand the logic of is_range_tree_set to handle consecutive
ranges in the tree. The logic change does not affect existing
users and amounts to a defensive check until we enable unmergeable
consecutive ranges in subsequent patches.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/range_tree.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 2f28886f3ff7..fdf7ba7aefe0 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -180,12 +180,22 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 {
 	u32 last = start + len - 1;
-	struct range_node *left;
+	struct range_node *rn;
 
-	/* Is this whole range set ? */
-	left = range_it_iter_first(rt, start, last);
-	if (left && left->rn_start <= start && left->rn_last >= last)
-		return 0;
+	for ((rn = range_it_iter_first(rt, start, last)); rn != NULL;
+		rn = __range_it_iter_next(rn, start, last)) {
+		/* Make sure the range covers the start */
+		if (rn->rn_start > start)
+			return -ESRCH;
+
+		/* If it covers the entire range we're done. */
+		if (rn->rn_last >= last)
+			return 0;
+
+		start = rn->rn_last + 1;
+	}
+
+	/* No range to cover [start, last] */
 	return -ESRCH;
 }
 
-- 
2.54.0

