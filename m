Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4543E4B5
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051490; cv=none; b=bv8D7YyDNKK03f0hyQeCZPDs8twkiVJ6GtJd/bH6pRmywSUSXpXHI4EXTZpVsQSIkvYcHxHbw80JY0q1UZnlE60uLUAAmcnviMqPs4HseOfjNXhTIXJ9N5bl8zQ2+26zt54bedFQLB2ySYpoIrL4ZPrGjSt/KIPeMXUNwbAPhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051490; c=relaxed/simple;
	bh=Sd9zI2EA0uCDr74JSidztJdoEmOSTeH7u4fmBUWp+R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMPXD03xqxAoLJIRlu2EeipoWnyeqdm7BXMIkuck8DTLdD7n/oNv5QBwiONM9ejTB4wwNZxCVzrEVLr7udYRRPa7U0LDLYVMqYGhC22svOtLmQU+mMQCknS6GJoaWsEsipmPPzmxXWkT5sAfhvlDP4dTAPzjo+2iT7waNBSluag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFvQs3Ho; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFvQs3Ho"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso72142385e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051487; x=1775656287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlDc15n9CnH9/7ZZq79mDzIhfp3FolgPLoIIgSfE6Zc=;
        b=oFvQs3HoTrs+kDaz8H2lSVlJXanU8axc9rfHG1aRpApWM1XbjDsRZvGNe6nBFsgg8H
         ynJLFv6+WPZPaI7tsLfBnn0dLQ/Coza6BrVkjpOhPEDABZrU0jIfFfC1sf5mh1Z8N2Xz
         lGqTxUlwq2xvndY1Mopa9u5BOQv7qGzO6VFyabz1dDG9DNNWXVgZPiyzhvz5eaHrrWtW
         jn1hDg5keDUSUc1TENn0FeWkEihFu7E4cWc220AjxMTxvfzVGIbruGu5zZrsePFLiWvq
         2WqkC3wwxz/EFg9l65Hb5S3iIfHJjU6guyngrDfpYtN7yDcCuZ3zGagBo+itrULtySjl
         11nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051487; x=1775656287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NlDc15n9CnH9/7ZZq79mDzIhfp3FolgPLoIIgSfE6Zc=;
        b=IqIsVwuZJG03jvgETqlvNF8mmCjhAEv7aOVDuhhtesau8q+gVpqMhaRStv45g9+wS6
         BdD6Cof+v5pcJk8VF1MhC1FzImQ8ksna/Ztqok/BmLXGnjwVW0mK3uh6wg8gZXoHdHyv
         GJovw04PBOhJO7J2ibWHNX5xhO+ifQMF0OXh3JHRUOB7E2qMBPm1d1t2teitcR6Ngr2Z
         5uSshgQVB6ISBhHMu4AsvajMhU9eojJy0untharU9Bj8m6WRhq/geoCVH2MoOklWf+Tv
         AmHfBE+mJbwk/MHxfSkLrRYtDJG+OhJYJCtdTo+dkaJAd7m694q5XCf49xiQ9DWXYwRo
         nz2A==
X-Gm-Message-State: AOJu0YxzaHXw9ZfIrxQ7myLH2Xz3jQBoRU8ZniJjSyj43Yqyj2fuWryp
	zXvxvasnyKIeR0Cvj2AIOLY/wxcqiYyaRo8fmivezbzPBC9BgtpbcAeH
X-Gm-Gg: ATEYQzw2+FEGaW+0zzbCIIIjiA/pQ83kz69eo+H/G+p1GfBeE1TSAZWdLYg11Qs76I+
	kxET4Ljm/13lTbt8T7l94EXx0ONvOxhFCINsR2x2odx34J+KSwVo4i1L22k7qcT8bS6WMyMW+p3
	OdAr6Dyz+tTtJNN4XXFTqs6rrOfdQGuBnnI8fU1urGOLAbqycrwbnLZ/cKMQotpJ5Nvvj11jFcq
	eBOOeW8236xbeBhEYu05bb6SnK3+nVnxR+ZyvMZUwku1QWFgzROO3/eGFEIx3ZqJNnoWCvACDbw
	bxI4duyZBLevsJirMPVLbJ73IWsx9tgWAwxF9fCo8VAinGqZ2CRKJWPCQr1Ot0vimutNQ1WilQT
	Za4bbYg6mtMiudMMgXhqshzJ5nGHdzSVJr5OdfQQvQXoajd7OBaHIdH/Btguu32YcKSTkh88IUM
	uM89RUBu9I3M86wA==
X-Received: by 2002:a05:600c:4594:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-488835cd3bcmr62697995e9.31.1775051486766;
        Wed, 01 Apr 2026 06:51:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c883b96sm41882375e9.17.2026.04.01.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:51:26 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 01 Apr 2026 06:50:36 -0700
Subject: [PATCH 1/2] bpf: Use copy_map_value_locked() in alloc_htab_elem()
 for BPF_F_LOCK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-bpf_map_torn_writes-v1-1-782d071c55e7@meta.com>
References: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
In-Reply-To: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Aaron Esau <aaron1esau@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775051483; l=1571;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=dP62lTz156Am1GZHsbkPrxsgR/2qcgCzCZPG1yCR5jc=;
 b=0xqU49u+h1S6PODcAYbBByjFP8WdC1Y/jUvRY4Lp+73AQqWValCt661DJ9isg5XFO8+SraKLP
 ZRgHt2vrblzCfq3yjWqSEvWu7SVnBHhjgXIOAgd6YMTs7166+6EswO0
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

When a BPF_F_LOCK update races with a concurrent delete, the freed
element can be immediately recycled by alloc_htab_elem(). The fast path
in htab_map_update_elem() performs a lockless lookup and then calls
copy_map_value_locked() under the element's spin_lock. If
alloc_htab_elem() recycles the same memory, it overwrites the value
with plain copy_map_value(), without taking the spin_lock, causing
torn writes.

Use copy_map_value_locked() when BPF_F_LOCK is set so the new element's
value is written under the embedded spin_lock, serializing against any
stale lock holders.

Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
Reported-by: Aaron Esau <aaron1esau@gmail.com>
Closes: https://lore.kernel.org/all/CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com/
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bc6bc8bb871d..f7ac1ec7be8b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1138,6 +1138,10 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	} else if (fd_htab_map_needs_adjust(htab)) {
 		size = round_up(size, 8);
 		memcpy(htab_elem_value(l_new, key_size), value, size);
+	} else if (map_flags & BPF_F_LOCK) {
+		copy_map_value_locked(&htab->map,
+				      htab_elem_value(l_new, key_size),
+				      value, false);
 	} else {
 		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
 	}

-- 
2.52.0

