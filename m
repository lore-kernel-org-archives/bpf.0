Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2F370D7B
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332566; cv=none; b=Z9jp7HFlrjCjlmRbAvX7O+dMLrv+5kz01pC/NQjIgHzlTci4c/JNG5hq6B/MHXZwNR7lJt6InStNLBc7lNPTyJey3QQkog74SLEUdWGWpRy/R7gkKZaL3o3rKMKiCJSvbPVHQ6eMNuAPdRpGFOCfz9jDoZWOYHtmN9Oqjv+6Gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332566; c=relaxed/simple;
	bh=iq2PxxHdyMJy3rk1Z9BImdOqBkXxUNe3MwlBg9D/s0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4occwcCRXkP8Z4okDOVK3rFsvWh+K22L7StCaYBVjKPRUaPEF+fEjyhfjbzplXnpQ0Y9Y4Z64tpPHGDV9CZNMAkIDMTpbtWcOZ8kArejjgpz6Awd26WOeHWxE98pKk5I/zItLX9kkUEEjzYOaN/kpccjK41jGN2j3C0zv5VT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=IM8GtGK+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="IM8GtGK+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d71a50caa9so9060555ad.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788332563; x=1788937363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZN0b+dg5PmHPIs0+u2W0y7H4fQKWAIwao4RWUJJy+xQ=;
        b=IM8GtGK+GK6hHIg4z0xjEFOfu30mGhIdlT9RRaiYkRL7cMlwLFVWTQpIVA34QuNdv2
         Qbdm4fGWhQQEfqTZfIecevssFw5gtk/+zYphaE/pkJZTYNAcObOMP3HXWwKa1g2McQjc
         wNXVk2ox4YlMrNN8+BksrCObBELgQx1RJiIocvGXgj2Un4J4RUQL2S5LtkhmrYbLyXEE
         9G52toqzjrgKxAcJmczehl44P1Bg6UTf1c3+lmGCLUuwyONxoTMdslM2LrBG3vgjfmzc
         0UH1a7WOzMTOsYzAp8o9ClHmcRGLi7SHjIp2Bv5GvcMrn8c0y8XFKmNhcsDBlvOfHh77
         7ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332563; x=1788937363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZN0b+dg5PmHPIs0+u2W0y7H4fQKWAIwao4RWUJJy+xQ=;
        b=Mg1p1NStsfMxVcarg1f+gT/AFSg+YSJl0qqTVpbVVbjAVxUcuACmUXFgSBAINthVIh
         ANL9qSdApsJaWuh158/9DBW/JaG3bSFza94GEROAGlbp3XudpqX9dIBmrD+JUnDLtDKB
         v2dg1xuMpXPkZpMO/byCjUpV4Wq6vQdliK1CHfX0CHBn1sbT4b+q0Wrly4DzUuN+bFww
         H5Rb8Q2b/mGglo0l19k4J45HCuKTZOo+XcsgwD/iG4SLM+SfeDXvvTZ5BZVCkK5pVj+z
         jstoHy5+y9Ap57VJWMuaHJmVabVLdm94DM8WYGjmbD7l8pl8p/HrleuCP2ZVrAvoUzj4
         +IQA==
X-Gm-Message-State: AFuF++njtJ/bwmYJm4VVrhkn+DfRU1TPzxJNb/AANgYowVYErUJxNmCY
	3G3NuSiv7WBYYT1ImaejkLon3YXBso3B0X2f28EGmUY/yKDcD+9H/KNCLzpWMRnhGlRSCVE6Fsl
	NZeiXtAk=
X-Gm-Gg: AYBFou3ZLDDPffRHhxrjfvP4OFym1tbyRfDvRNNEW5Cy+njEjuelq+8Hn28kEJMahmp
	MMLEXJMDvn9td+zkNjqceSAoSNeQDhsRrTpVs4cRT+/j8wTiE77159IZpLZ/P900m7sIeeFIdDe
	LiUTut0Ys2o7bbwhV34hZX+N64dT6QRZgjsx1lZ05wWe+WD43mvEHL8XlCbgdDmVmpilaD6Mi/e
	0+rYADSYeLsJc7JZLJV0VkVR9Z1PgfdvZZyxCJ0t+b2WyAX5VMnBAKAiA0y16k0xb/w8x2XNr/n
	oJQpFXaXzDMMsvVSzihQdEIvXrNLrYCk6SO6Csxo/XHgOMx7ujlTz3NgZ4yMItEnohB4uBStApv
	cpwdDwe2Qak/3KtETdl5U0EoUClv6irqZm8FjtiwnDu4ZTPouFUVCaURwbvyATtx0VkG2swexQT
	5WcrmzKL7uG8yucuil2ba/El/RAak8aHftKk1jL4GaOZDZhmIb55pP86dMwDhMDCTtr5zq7sw+4
	tzK9cB464xE51ExO/BybKk=
X-Received: by 2002:a17:90b:4fc5:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39aedfe18c0mr4475999a91.8.1788332562881;
        Wed, 02 Sep 2026 00:02:42 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae05e21bcsm3793352a91.0.2026.09.02.00.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:02:42 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	nickolay.lysenko@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 1/5] bpf: Update is_range_tree_set to work for consecutive ranges
Date: Wed,  2 Sep 2026 03:02:35 -0400
Message-ID: <20260902070239.16968-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070239.16968-1-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
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
 kernel/bpf/range_tree.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 2f28886f3ff7..6f6ba718887c 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -180,12 +180,21 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 {
 	u32 last = start + len - 1;
-	struct range_node *left;
+	struct range_node *rn;
 
-	/* Is this whole range set ? */
-	left = range_it_iter_first(rt, start, last);
-	if (left && left->rn_start <= start && left->rn_last >= last)
-		return 0;
+	while ((rn = range_it_iter_first(rt, start, last))) {
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
2.55.0

