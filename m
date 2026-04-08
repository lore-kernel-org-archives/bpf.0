Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348513D567E
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661051; cv=none; b=hr2dSEvZ100zZwNAQhp0tpkv30uK5uspK20xP9i1HrrExEfQy4EaAt+C0cvsSX3vZ0i3IJI/FULMUse/aLFcjzK2QclkdzbMDdNjKcHidfk/4OnmoPcnEI2IsDJ1k+sSPfm7342CI+IZLiSg6AKxIXB+I4iuOqNI6PPJU4as7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661051; c=relaxed/simple;
	bh=Z5J04Sii4C0TM7cabTVcSm0mgdlaY0TiKiarUWuLHbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSFwCiy5mZd4sb93GYrrdg98B40nJgLcWyYv58pQ9ACg+4FayvuI+khPPr3KDpjXYFKu68fuBlFkos3lgdy/eJojHkn417ORDZXcPCrS/QHXPR0DdkYK/n/tpzIkHKxe8fA6Y753q77iIbZJMBAWBzf65a1q4BBFIa0IXEGV2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhz82Ddg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhz82Ddg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b87970468so4917230f8f.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661049; x=1776265849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYa5oJbR3t1CIHF+/NuU7moPGEsajMvZ7kZ53ymL1SA=;
        b=Nhz82Ddgm9e1UkN8z04Ft413xOEk8HAZRvA/mVxwL46z1SNas+lameOE/9mi2i2clA
         LAXobuuhq/gDxV+bMrpIAYtnu7tRmI1wMpXuc/vnNPiKkNJaQMH9QFpfQJZGR+ChCZv0
         yeYQn3q4qytsIoqnQo9xhZtTrAausaQK9I8M0EhXM3/Pg9ef4ewWAF8CY2+pjHPcuttL
         yscYfwcasaKFvqB3Sq8tD3SMh/YzXbJS5MDs6ZBu3I7juckKvEegs0L0dMT6/qzr1vPE
         OrrCn0kbl+b3iBsyjJ9DORFngxIzWgw0oDp2p32YGNdDxjE1eTTbkbremBKGdBiK56IU
         NPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661049; x=1776265849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYa5oJbR3t1CIHF+/NuU7moPGEsajMvZ7kZ53ymL1SA=;
        b=UeDfSKhCfuo3aase/5HroI7yxYVMo5hF4yjjyogZnaKF0fW/E/CkzHQOug9fHmNcZU
         V9dnNq4MDrxl8bjAe8qwoy5tyL5x6Kv84tfY3OmvLG1UoQb0Bh10h4lPFCdMwPZCB7bR
         cxJ39DuOFVOxeRHiVOCtMZTltwvMPXJO334PQ1NC9KQtgcTyEE4NxG1TX/5HgBgkCBAe
         mwebyNXy8WlRfLcg27MFkPR3rdchxSl/cmrGMpuZnlpq8lOaFW8uAnnM8G/xCisvy79R
         2jt7EvKHP+6x9BYdwds7EvNxlRhA5+OR9u9Qv86wrHUpmcgqCwpAsEHlpd1DIfFjLnYQ
         /Y2Q==
X-Gm-Message-State: AOJu0YwJzG+vyXHl4Bm6EFZtx47HQAL/6u5PgjlTjw0q+OZ4OpxDXQWu
	e54Po1i2r3jts/ZJQEw9Gx0KvIhmAiFpox11UjtfqgnOlWzMkISsiCZ3
X-Gm-Gg: AeBDievnLcUEmKfRPkzzDdDyvTL4ROV187ovtjWJlx1xCvnj7O+VcrRqWXfg4gTcf26
	a+UdTDZ+2j/n1apsteJmqo8dgadxgH5ipVdSpemYqzBRY1jfYsa/331oKNiDdtMbTHSMdrEWcGj
	5bzKOxG8rsq3RvHkRIc4A7UVKKrDPx78sqR0Pkc0zoHfmjb13gJZOPRhlgKaUgGbE9dheJ2c5gw
	SJrWSrSN7oTlesu3xWBinIt/3fZOTeMknBwT72fGIJVQswWoRyxLsvS7hzk5bsXdiok3eSyQtRM
	ZNNQDgMhncBRS9/9qp2ztFGjFS32gutWMSpQxCXolxmv/9oOueI5iudjgVlzhp3G66MSXbykqlp
	4vV7RSQ99zNBj6RNAMAHmONFr0zPk+KxofVpBBXkTxs/UVG2H+WdeqzIt1dPYrPqvDz59rShh+p
	KUUbA+nrZkYqNCsw==
X-Received: by 2002:a05:6000:2282:b0:43b:54c9:85f4 with SMTP id ffacd0b85a97d-43d292df407mr32677660f8f.39.1775661048452;
        Wed, 08 Apr 2026 08:10:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5016sm63659743f8f.33.2026.04.08.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:47 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:14 -0700
Subject: [PATCH RFC bpf-next v2 09/18] bpf: Implement alloc and free for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-9-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=2716;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=oua3NYidKNnpnmJ9PVTnM2BkaIykeng1J5VEFpn9tSw=;
 b=bOIsqqSMnrJmJmajOjjdPsCpNsufEsuTa9WTmS+to9AuxhepkL26Q4l9DGlOLqRlOO6aCRUNU
 vITBGNvwn5mAswn/QBU91S5Sz2Fh8CeIAVsJ0B2wR9QwHTywiXrP183
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Initialize rhashtable with bpf_mem_alloc element cache. Require
BPF_F_NO_PREALLOC. Limit max_entries to 2^31. Free elements via
rhashtable_free_and_destroy() callback to handle internal structs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 492c6a9154b6..a62093d8d1ae 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2762,16 +2762,74 @@ static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
 
 static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	struct bpf_rhtab *rhtab;
+	int err = 0;
+
+	rhtab = bpf_map_area_alloc(sizeof(*rhtab), NUMA_NO_NODE);
+	if (!rhtab)
+		return ERR_PTR(-ENOMEM);
+
+	bpf_map_init_from_attr(&rhtab->map, attr);
+
+	if (rhtab->map.max_entries > 1UL << 31) {
+		err = -E2BIG;
+		goto free_rhtab;
+	}
+
+	rhtab->elem_size = sizeof(struct rhtab_elem) + round_up(rhtab->map.key_size, 8) +
+			   round_up(rhtab->map.value_size, 8);
+
+	rhtab->params.head_offset = offsetof(struct rhtab_elem, node);
+	rhtab->params.key_offset = offsetof(struct rhtab_elem, data);
+	rhtab->params.key_len = rhtab->map.key_size;
+
+	err = rhashtable_init(&rhtab->ht, &rhtab->params);
+	if (err)
+		goto free_rhtab;
+
+	/* Set max_elems after rhashtable_init() since init zeroes the struct */
+	rhtab->ht.max_elems = rhtab->map.max_entries;
+
+	err = bpf_mem_alloc_init(&rhtab->ma, rhtab->elem_size, false);
+	if (err)
+		goto destroy_rhtab;
+
+	return &rhtab->map;
+
+destroy_rhtab:
+	rhashtable_destroy(&rhtab->ht);
+free_rhtab:
+	bpf_map_area_free(rhtab);
+	return ERR_PTR(err);
 }
 
 static int rhtab_map_alloc_check(union bpf_attr *attr)
 {
-	return -EOPNOTSUPP;
+	if (!(attr->map_flags & BPF_F_NO_PREALLOC))
+		return -EINVAL;
+
+	if (attr->map_flags & BPF_F_ZERO_SEED)
+		return -EINVAL;
+
+	return htab_map_alloc_check(attr);
+}
+
+static void rhtab_free_elem(void *ptr, void *arg)
+{
+	struct bpf_rhtab *rhtab = arg;
+	struct rhtab_elem *elem = ptr;
+
+	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
+	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 }
 
 static void rhtab_map_free(struct bpf_map *map)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+
+	rhashtable_free_and_destroy(&rhtab->ht, rhtab_free_elem, rhtab);
+	bpf_mem_alloc_destroy(&rhtab->ma);
+	bpf_map_area_free(rhtab);
 }
 
 static void *rhtab_lookup_elem(struct bpf_map *map, void *key)

-- 
2.52.0

