Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C473D525B
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661046; cv=none; b=jaEEuzGU+iyL5J4uZj1AfCw6kTWtUi6uJFMKdvtpet/+91SwqpGnV+ajiAWMNZsmWVjHBD3kjcWnTHE76/ePcR1OI2OfIAncXBt5PCe7dNCUE+nPB1w1azxFc0qRBQokajwq0BHhF3y+BInumIQgZ10ECjyqlHjVembpY7fwfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661046; c=relaxed/simple;
	bh=yjLaQEMTieHR7wobpATENYKpdO4CKpbIaMgWTNPOLkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1XTn9yquNTDjg6rKIKMcU9fAGLHFPWRLIepdtH/ECJUlI5Wenv5ilvwczVm12Wcf4qDWSz4M3pU8N9XPSq6njSPwxW6sy1cbBMFwa1RMpMsYg3LqRWlWB3WNVzAxdP4FpbJNfqC6t6FiNKbaZPyZa0aq+b2H4aiRjBd61Dc8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L44Zkt4p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L44Zkt4p"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso5455696f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661043; x=1776265843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6bi0znCzlSlJ1i3IghZ0eFkdO54f8beoh46qg2lkMk=;
        b=L44Zkt4pGuGxlN9BmbSmNEwkch5iqh6a/8ARNfB90/2EzFRkD3iT4QS21mEmpGuU0u
         Af7FE/3oiXelqBXMIEs2GHluf0DTlVI2zmWUZ99htlVVr80QyF4OTc8mqNGld6TqmZUU
         yzYrULf7uCxFayuN/xjq67lznzQsNKvFwaU9uE4ZBhqGPzAIqB5O82lDrLtsQyb9aWSG
         hYP0CWVqAV25W9awo88Kiqa/ZuLCEltTASa6hyEfi90KqDMNW3+VEKt3Wj2Gl9dpcv5y
         LV05tUNJLu86cbxsU7mbbKTtA0zFIP5BUUHnTtYH5ZPFGkcNqVj3kd9JCzCBZHfS8Ntm
         6Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661043; x=1776265843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a6bi0znCzlSlJ1i3IghZ0eFkdO54f8beoh46qg2lkMk=;
        b=iMmSXRBGYzkFz3lL96RFOZhq7smyt59WKMpLrO88moGyfEEhM26zp/xRtHN70PM5tb
         IkpLF8AsZNSO42LnR3oukJT5G1ITZdV0bLH1VXbEokHSZid1GdVc8N3qH7dtUmvSYiU+
         j0To2AogfRXpRIpk8B7wIXbVpKrV2DMy2VGT3DdGlO3fcwdRVqnMl4NnuCCsD8yowCkR
         Ix/cDe3hvJjAnsSw3nlrS3f6kDKePrahCvcm/8q+2q7B//SaY60Qm7JgAK4pwIjbcOKk
         WNwxCSmFe/6QiDsYTosHyxEMn9BdTdVRBC2Zso2vn6ThG5BO2tula2MNqwlII86XwLPT
         jlFA==
X-Gm-Message-State: AOJu0YxnHrJOjJOcF0L8pUxzBJyRulpce7X1NZrWUcwUCiKc9LiKnwI/
	8wttNckIi5r5iil8FN5Sw2rGP501F2DRlUVx1IvomA5SA4cFcxhPRCEd
X-Gm-Gg: AeBDietT2ALCrM88eKftDXVka8nnJBU+7fH6je3KdL4d5/gfw3BwVxTLUgjZ1cTeRF7
	mKKw/m7jxc/sgzZqBZ9p9GAT/OdXS7ghX2rNKwfHlkxsKEn6KJ/iMthtVEc/92tiiQ+dER7K4fC
	hxA8aGLtbMHhaqYmhoffzgK8cu+tz9dM76+1zfjICldlqZXjqHzvJU8rWycpD806Vs9kHhwGuHs
	/4EEtSmKcL37lR93L0Fc1zakLpcoGtM/72H+1SDlPH0m8fu8Zxi0juJ1v6H3VQKIiQocCjSWagj
	bOEtKujobq4V9Ermot8TAJeZbanAl/pmANibhhzUqzmP/t44J8UZrIQrhitINUt5KYU2J+GV17V
	xp9BSi0iatzTKCI4NotfhiKIrJQZCWoLh2c6RGNcTBxegZLFTzB188ar6Z0ksrV3qsGufRZOQm0
	h0l4TBVf2CptozS242DtUqH5I=
X-Received: by 2002:a05:6000:4387:b0:439:b3c5:ea1f with SMTP id ffacd0b85a97d-43d29298863mr31413062f8f.16.1775661042842;
        Wed, 08 Apr 2026 08:10:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm58112072f8f.31.2026.04.08.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:11 -0700
Subject: [PATCH RFC bpf-next v2 06/18] bpf: Implement bpf_each_rhash_elem()
 using walk API
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-6-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=1776;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=tO5/kLNmstrThUCW4HLHPHqYqd80qV17G5PZRXvEDhk=;
 b=3wIRBIak/DtJDNeV3Ptw3HKPe5cPmV+c8e89191Q2cEbPRI/omp0gWVrQMmYvpdFZFOHyB2Rt
 H+QpS8SDN0PAh/geYb4/YYeCKC6QWStkuyTaCLW2wt/GvcFVY7zL+64
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

rhashtable walk API takes spin_lock(&ht->lock) in start/stop,
making it unsafe in NMI and hard IRQ contexts. Guard with
!in_task() rather than open-coding raw RCU
iteration that would need to handle resize races manually.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 7eee450a321e..e79c194e2779 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3013,7 +3013,40 @@ static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_f
 static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 				void *callback_ctx, u64 flags)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhashtable_iter iter;
+	struct rhtab_elem *elem;
+	int num_elems = 0;
+	u64 ret = 0;
+
+	if (flags != 0)
+		return -EINVAL;
+
+	/*
+	 * The rhashtable walk API uses spin_lock(&ht->lock) in rhashtable_walk_start/stop,
+	 * which is not safe in NMI or soft/hard IRQ context.
+	 */
+	if (!in_task())
+		return -EOPNOTSUPP;
+
+	rhashtable_walk_enter(&rhtab->ht, &iter);
+	rhashtable_walk_start(&iter);
+
+	for (elem = rhtab_iter_next(&iter); elem;
+	     elem = rhtab_iter_next(&iter)) {
+		num_elems++;
+		ret = callback_fn((u64)(long)map,
+				  (u64)(long)elem->data,
+				  (u64)(long)rhtab_elem_value(elem, map->key_size),
+				  (u64)(long)callback_ctx, 0);
+		if (ret)
+			break;
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	return num_elems;
 }
 
 static u64 rhtab_map_mem_usage(const struct bpf_map *map)

-- 
2.52.0

