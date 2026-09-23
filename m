Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A54A0928
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190701; cv=none; b=JMVx/cIKSfwKhGaSBG9idr+sbOeHj4j0hhKuJwshabkB1vxXegnU09MKiuE3w9vOOlkCZ3VK4ZrSFUtJlfDRVbnTLbhYMJ/ue81CZu0Jhpl34FfzlK4oguRAKyZdQ2l2TGeu69eVKrb07tZ+WWQOPc9kxblAaiYr6RmanqkwFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190701; c=relaxed/simple;
	bh=UAtZ6JWgyZ7GNifxsXsDvfXuc9QIUSPVuFG6st0SUWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHKaI8nkDnzV7FxA8d+w8AGtHkHWf0hVmr4JbKiWqOPykWL/fh+vnrWrUhuo1fpz3RJC3SjBs+mJYV6dof0jrc3j+/MQtSdZSwsgAguNvZrao4OWsE4I7555mSWI2slMpX4BTvkFWy4DQbKM0uuizrhfjdvsUGk2vimiwRVQHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=RThzJnoh; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="RThzJnoh"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so1065877f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790190697; x=1790795497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rI3KPI3Xx0raBduIymOvDHoIDFvqlX212iIq8iJe6jM=;
        b=RThzJnohLLYjs5aW1KaZiSGm+deAZNjWray1pVnAE1wBZ12m5C+ISRagf52XG2mKa7
         LlVAij1xLCjvf2KrnP4Oe1I358ETG5o5hHLhfrXWDAJXf+iGNw2o/Fj6P4Kyqrlotd5q
         YB6pxWzRxcTpTYhHL5L1c0tYTF5S7g70C4PQs1ag8v/nwqtTTHp+YcHCMJNtYUjdj3Ah
         T+l58K6+/blTBw1GRdFnFeY/HJabf57eiyXuW9Lz7uqWZ1c3qlCwJC9S4w2nXSbSMM7M
         gEotumFJ4uT74pLl5sDmIlwBcoHkP+XRHS5b8ZXfdXJm1PMwca6luqcGE4TICbUXvJ/P
         BfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190697; x=1790795497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rI3KPI3Xx0raBduIymOvDHoIDFvqlX212iIq8iJe6jM=;
        b=0bZ/6b/HAXxv7Xa4f7l4F3HOJVxpl3E4mjQRiqveKP2d+z6DNOn/sHk58dlsg6xeWx
         ihmUP1wnwgQ09HudLBj2N8ghmQ4np9lXNH22Xuf36Wa2HhsrbkGkH6uTV5ux3/NR95Nz
         s/13FTUyfUlaZfp94edvYo+iyKaaZ8s5+jVN1ba9LkhWp5Nbyn2i2iwnPJ2qrNKiiOVt
         7HM48HJbPGDfjPSo3K/kLqwRseolJpOfnOZnP/vUVmmJ8jdnRL+bSuOuDGyqyZsYzgxY
         tvc9pwT6v/N1ItxEHmlNPfskkTHIoefw8pFSrwKZ036Xbu3o7bz5CXnRxzlrpXmyRHiQ
         b37w==
X-Gm-Message-State: AFuF++lWMrug+t3Uvt137wvyI3gTdRUnJN49xDtddBXo2bQEm1MBuT6U
	ixmPmX2UIOtWGu5pGk7AmzeU7wV79ITKrffomD13CfEwAAUZXcdE1tpTGgd0rrkvC/GeWgPXCDy
	ndob0tsT1XA==
X-Gm-Gg: AYBFou3I5dhjZHzWbt+lSILFN35KCjfXbS4rvF6B9AgcmIjf8jIyuGbt9SkDsAL8+tk
	qU0sAJVy347IHha8rPxAA636UtKUAa/9ujfcSdqsFAmvccW+uL4p3keach/9wnIJL6dE7M/pvLF
	D8EXDK7LiE8c8o4+XlN7rtAs7Q50FPbJR3biz/qZs2mpostK5Zzvd4ZMVMRHmqNsfU85FfX9jhS
	6RJ/3A73/KLGZzrwo0mDU+ne9xQHOf8SV/7WMPWsEg0thPCmrQ6ZqiM8N08H3qytxxBLyhnsjoz
	8FZFt99o81LHzUXS+ysr8OAO7kA4IONMm5vtyN60cL2XjHfvUYLqyu4nTQ0Q9R5pCL7GYFHbzMK
	JtQt8Glf36FM3J8A0jspi5HZd0pTyp+souaACXwxJrxt2XAuEcFm7y7W7AAVSAn4oiyVSYlXIfl
	fK1dhziAMaWnDGs85gl/+QYaGALHGVzZtBl7btKHgZo5JJilPGTmxoeqjnDnw=
X-Received: by 2002:a05:6000:2908:b0:487:27f9:828 with SMTP id ffacd0b85a97d-488716f76acmr143682f8f.29.1790190697458;
        Wed, 23 Sep 2026 12:11:37 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2f89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2a5sm9473563f8f.26.2026.09.23.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 1/6] bpf: Update is_range_tree_set to work for consecutive ranges
Date: Wed, 23 Sep 2026 19:11:20 +0000
Message-ID: <20260923191125.5311-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923191125.5311-1-emil@etsalapatis.com>
References: <20260923191125.5311-1-emil@etsalapatis.com>
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
2.52.0

