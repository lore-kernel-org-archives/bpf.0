Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93733D47DE
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661044; cv=none; b=nP9YDyZOUXtonWcBgLl0uhynI3Vn0c6y+EK8IydmktvX+A8O6yGPYDa800/NDl8gAUxj9a5OTZORvA6z9sQuIfUdzQWVan391yOH4q3IopF8sXbueQtl51dfRIEKSUO8UTPF/odXZS2kmgiGj9kPkfAFVKgte14FIVTVCsn8SDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661044; c=relaxed/simple;
	bh=ZfjIVk3gAy/RUhCx6KVF5Tu7i2txth3CT4UEtNA5gyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eO2a5GI6AirxjNs2mb/DkonFhJbkvEPcsQbz+UPAPKnYgKFwQx8AY/53fNktMrc4qKZXpJwBBtmE7sdVVkxo19g8CLLWhgkr0egoWraVQnR9ksZUsQRaLY80MoeTY+oiNPrE9NEeC8SronHidNvDX3Wd5ZTEmH4NQe3GXwpoDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0NAHjOo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0NAHjOo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a29e6110so45801585e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661041; x=1776265841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lk33fD0ri0RiVAA2BTvKZbt9Cw8mFJBHq3pDdcyppGM=;
        b=V0NAHjOo6BXom5IGcnl7jbYdw7EebtlsHPcLdLmQDK5HaJdxwg+NHnbAeDnffVq9lm
         ZHnUoQyk7xltZUw97iWtlQ6maiPIOpH1/TPuuAQK+N5/Bgu0ATbNWN+LP7HdZuQePdZu
         +wZypxpZmKJLWOp2RZPViQ39cleMGUCTomPeICGK0uv4SvumIyrKb7YidJnOcBvTkeYx
         QOMLoZ8LiWczffp4ASjKBlIwxqjFPgexV+hHwBhh+qJZCnq40HzlcEruTaa847bsYDTt
         Sx2D5VHw77+ee2xq3S3X9Vc0N2Kpo3ohLgXK9oiIcGj3fPbL9DvfgTtnQsGU6zTca7WZ
         gP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661041; x=1776265841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lk33fD0ri0RiVAA2BTvKZbt9Cw8mFJBHq3pDdcyppGM=;
        b=G8Abntb9rYj9kjVXO/vEgF56M68Xzh5l1Mc/+vzWqWtPmUya0BGP8GoHriNJnQlc1/
         uRJhJ9c09u7XGzM3RLrq9VlzBebpTlpPurkrkSmGHcfbvRH1Zsfnmi0NMQnADRE8BHDU
         nUJ6hoSuOrLcnhVr82mMDTFjNo9vjFtpS1UokCr5tyKMgGyoaZvmL9XvDT6iGIkULLBt
         y1hxO/5NOzHJvk3nXxVprWvKqw9+uy2Ct52+LpwDAQBZqgqPPyEKyfIPcM3z2ExN0/NN
         zVuk0UFzAW/8IYM7IyK3LVALCApkLA3em1tN98bGLxZ5FjM1qyDzsAXzAwB27DC/MZEh
         /oAA==
X-Gm-Message-State: AOJu0Yw8mwZKFRF8J0QfvOvECF/5Z3jPlF8Yng1FAi++hfx7+yiTZcoo
	go4A3M2o2zu6VzcgLoGlBzrgd6BLSZt46p0LLEsqASVcKeMxtEIPWrzN
X-Gm-Gg: AeBDietRNpbW3vwdlmjGZlPWypUZF8oKJoectkpFJT5s2aDmxcPEmUPjZNAK+LIefdI
	/OZrjwM6QJTI7Ui472MG1b5x2+lEuWBv9A21CaFdyM7qSsaT9tWZtsQsUn4yMIkxleA5LMogHFb
	kM3rpmVNY7F6xMCkzNPMJUZsfK/jl4r2gW5rVq353leDRQZOX7NII+JrSfBBjG5Pw0hiCtk6iKy
	ogUnszxNIrwYo0NZOLyAVWWtpdz3iLz8A/V0sYeCHGQXhQGwFBhhoECoNss9hQ78AF+ju2AbRvv
	PcR7DVWU92IPbIDWB0G8itdBk+KmJcrYAwsu+3aGKtCBm+LFE3mOCalBxBtkRizwr6ctE2BTmri
	n/UC5zwoKnH+sW2aAEwgmPlUnyhB1cZn4oJCCuud3Q+vdTB3sdQRQ4tgG4wZyCueDFjD/RrGiln
	7o63vQEKilfMUhqw==
X-Received: by 2002:a05:600c:8b75:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-4889978c516mr315675425e9.17.1775661041045;
        Wed, 08 Apr 2026 08:10:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e9630ddsm650753445e9.13.2026.04.08.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:10 -0700
Subject: [PATCH RFC bpf-next v2 05/18] bpf: Implement get_next_key and
 free_internal_structs for resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-5-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661028; l=3086;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=swrrrgeeLBeoy5fNvkqUm0RNIBdMBZXGCZ/2PWSn44g=;
 b=blrxm6toiUVCUABFOLDu3edhmiFr7wHwXeII7nwZgMwnW8Qu1kFxwLEiXHoSV66Jn3HWXkQBK
 cHQwJBVk0L9Ag74bgrGcAAWZgXhBWRcgeK1zELBccDkR/VjaE59jJc5
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Implement rhtab_map_get_next_key() and rhtab_map_free_internal_structs()
of the BPF resizable hashtable. Both are only called from syscall, so
it's safe to use rhashtable walk API that uses spinlocks internally.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index ea7314cc3703..7eee450a321e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2921,13 +2921,89 @@ static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	return insn - insn_buf;
 }
 
+/* Helper to get next element, handling -EAGAIN during resize */
+static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
+{
+	struct rhtab_elem *elem;
+
+	while ((elem = rhashtable_walk_next(iter))) {
+		if (IS_ERR(elem)) {
+			if (PTR_ERR(elem) == -EAGAIN)
+				continue;
+			return NULL;
+		}
+		return elem;
+	}
+
+	return NULL;
+}
+
 static void rhtab_map_free_internal_structs(struct bpf_map *map)
 {
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhashtable_iter iter;
+	struct rhtab_elem *elem;
+
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	/*
+	 * An element can be processed twice if rhashtable resized concurrently.
+	 * Special structs freeing handles duplicate cancel_and_free.
+	 */
+	rhashtable_walk_enter(&rhtab->ht, &iter);
+	rhashtable_walk_start(&iter);
+
+	for (elem = rhtab_iter_next(&iter); elem; elem = rhtab_iter_next(&iter))
+		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_size));
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhashtable_iter iter;
+	struct rhtab_elem *elem;
+	bool key_found;
+	int ret = -ENOENT;
+
+	/*
+	 * Hold RCU across enter_from + walk_start to prevent the
+	 * element cached by enter_from from being freed before
+	 * walk_start re-acquires RCU.
+	 */
+	guard(rcu)();
+	rhashtable_walk_enter_from(&rhtab->ht, &iter, key, rhtab->params);
+	key_found = key && iter.p;
+	rhashtable_walk_start(&iter);
+
+	elem = rhtab_iter_next(&iter);
+	if (elem) {
+		memcpy(next_key, elem->data, map->key_size);
+		ret = 0;
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	if (ret == 0 || key_found)
+		return ret;
+
+	/* Key was not found restart from the beginning */
+	rhashtable_walk_enter(&rhtab->ht, &iter);
+	rhashtable_walk_start(&iter);
+
+	elem = rhtab_iter_next(&iter);
+	if (elem) {
+		memcpy(next_key, elem->data, map->key_size);
+		ret = 0;
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+	return ret;
 }
 
 static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)

-- 
2.52.0

