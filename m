Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446980;
	b=nPrlOn9zCU3PcrBbtG1pZPdTrlBy8HlyFSQpDIPD760Ylc4hvL10+UuAVwqbhmLmMIqO
	 JUFzlVTcgOPj4L7LFpCUHPIDwddkaVguXV8e2+pMJZOEYxCgkFiI6imKgLUdUPNM9TIGl
	 y5cka9aEf3x1PW0RVkLV7t2ZDGSu5xNrRu7xOpcEl6DrE8LBj5vDTQ6OsbbUiOXXSTfbf
	 KeBG7z06VLBWpzvf8SN70U0EJ8+795jSh2SQjokDvq/a6rVSXlkinUDVFvy0t8dEQy+t7
	 C2VQI5NFQ3CCXUCfTCtb4AJhWjXYSuiGAnjk+kxz0r+5fXohb85MJWhAWRwQKlup1Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nDAJ7mIuB5uD244mZde2uExZXuHZUNDxbR1OeqSkOYA=;
	b=VrElvTrnA6Gm3/d2FcfIvp5dsaxO3XfG5uzRgLgqqE3DrGlTaRVP533y9RjCxwmLwf5K
	 cELl3KLrOcvIpg1fDWMBOlOOh8N87zYBX7KGdX7A6Gpk4QRs5MfhRrd/nBtFnTepZMk7G
	 Ym7xmuh7KHEjsvOQJBoH5NPOLpJdA7buJGKxJ8krZc1RctmdSWwC4XEQueiuPTQ4+97Kj
	 94wzqptXsCwtBIAne0af4UH2CevlOKlvxUSIHaFt5DLscHaX49EHxnXUGBnTDrSVUARzc
	 ccigIwXFl5TS2JNk7c/S9W8TPVicKlptiH13YmS76ptA8GlPugeMK3YlqpMdzF5kIjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ltVyhdMR;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5B606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C5B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ltVyhdMR
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-862b090e3c3so1834238a34.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446979; x=1796051779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDAJ7mIuB5uD244mZde2uExZXuHZUNDxbR1OeqSkOYA=;
        b=ltVyhdMRU2yhl9rS4TcAmztHbSKspUxh4pzSPGRc9NCIxWGULDgGbDqQsYGI4ScO+F
         ZAN2BY4MD+2+Zc8AVWyTS4kS2FwwFQkKv1wbblEwoDCsxiEKqlbsmgD9tngIs7qnCbOG
         2bBiK4FWbl6HXn0a2uHY/XTbcGAwS79qNZriTBVoTVYp2JXaQPNEF89hXXG0WNNDLbfJ
         yFCbtWtc8sqmVijsfl6u6pHSLW+syTZOlT+SY/h31vd6GSB0dL58zgWTARzs2EVVmlsl
         0B+cGBPN+LGWs7OQXIMzXSZJyDiSPrWqPsP8OYdncalDgSHzhcVZFxfb1R1uM91WQ2X0
         9N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446979; x=1796051779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDAJ7mIuB5uD244mZde2uExZXuHZUNDxbR1OeqSkOYA=;
        b=eOdx8M1qlwGH4F0Ix1OWINIBF0GvLU8iTDZDieCDcoFuvYLqF8ilqDO1GpdkGlc0hq
         y87w7kZaDs4l1aL9kKUd8iwh6JRsIgetf+sX0Y3Pge5Doz3PiUhtmgDSP7134Kr8KC+t
         ZQI903FJjcBZeRXbfM68irOSyDWt13yjB9DFhYZ1WnFiu5UUeUPVOw2lOGv2D6iStj5K
         zIr1XRrz6SUx0p2vvzEl41CxrOU/x7bsdX6W1GmqBO9lQFAsx56Xj07xlej7w+SySCJg
         2PIgwngAjhgAb2N1RrIgI76Yo/unc3N+z5hzIPh4WrVwBN1u7SujREsIkdke3F8BLNnz
         aqqA==
X-Gm-Message-State: APuU4Z+/LzQ/mvfjCQigZnC5yzl6zYX0JRol1dhCs6/qg0hQVQ1jXdxZ
	y3FRLw29aw3m0nOfvVmSjxhNjP3tG5E5VIR5NA0BeZBHs1ak+gPUYPlIrb7hFT12/Og=
X-Gm-Gg: AZFdTZe0WOl1Ev2EXHxtyIPit/kjvS7vJyKPrjwO6zVZwJkrB4oulfHT5rtLcPnOhyA
	pR4twM4M0SAqKAii4Z+AFIUyYyWFjZWa91CWoqsjjK55Rs0ezh8PtqaocgLD7PypmKBinecTqQg
	rQVvPBHlXo046Ir88OYYe1r8Xm4TKVFqO8uS+QuuM1y0VvY2fNh7tTZdwcn9A5eSM5jwymeuSqU
	ERgYPGrjQi0U+cBM6jkzASvr4CAzsG6LbgRJXkAlQHSOtQH39dvlODMeRQk8rRY4qnSbxOpkmSS
	4HAb9FVKVceK+QdQOLiCafZuRSMLIP7T6E4BAGxdyOVpL6MMqBd7FJbb61UOlfrDN/8CgnjT6oy
	89cCgWnHGzFqL+fGts2OgKkk+39azl64E910PzcaQBnFtw2g2VkQBa1Yir0pw/OrYNcC85B70Oo
	ek7S9ai0O2JuWROgYSwBPumgVPQ/FoLXL/9pq1weLKLq4etk5CZ8GMnfrRpXsEAysRsN8WAKicj
	UZ3iN+KAfqYxwCyJMlb45+NjI8ZnsEIdITWC0zOX/DzBsUE01F8NoTCaR5o5PcTM+ickwfkujhF
	uwAd0xpSXoX7zmsCM2SIgA==
X-Received: by 2002:a05:6830:6a88:b0:863:3a1a:91e0 with SMTP id 46e09a7af769-8633a1aa039mr4446139a34.10.1795446979308;
        Mon, 23 Nov 2026 07:16:19 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631682200esm8511648a34.2.2026.11.23.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:19 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:49 -0800
Subject: [PATCH bpf-next v2 09/13] bpf: Show inline values in sk diag
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sls_f1-v2-9-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=4419;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=qVaGxnL+1ZGqT15snfvZALGtg2UVwKDUE7JcBxbzFw4=;
 b=meBPWPdwKV+wARQVz5JnTuoB+pwUJVcfD/3mnH501uqdb458nuMpFYu1bgNsmCY/OeUCHw659
 5KvM5ymNNK1Bm+ZnBS4yOMIo/rnysjM6ApO7hTbU8bVqHSHs09IPvI/
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Inline values have no selem, and the list of an object can be empty when
all its values are inline. A request that names maps finds them with the
lookup, so it must not stop at an empty list. A dump of all maps walks
the list only: let it also walk the table of live inline maps. Both walks
skip a map that goes away (id 0): user space cannot name it.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 net/core/bpf_sk_storage.c | 48 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d0eaf4de8090..cae3606609ae 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -529,7 +529,17 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 }
 EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
 
-static int diag_get(struct bpf_local_storage_map *smap,
+/*
+ * Map free can set the map id to 0 at any time, so read it once. User space
+ * cannot name a map with id 0: skip it.
+ */
+static u32 diag_map_id(struct bpf_local_storage_map *smap)
+{
+	return smap ? READ_ONCE(smap->map.id) : 0;
+}
+
+/* id is the map id that the caller read once */
+static int diag_get(struct bpf_local_storage_map *smap, u32 id,
 		    struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 {
 	struct nlattr *nla_stg, *nla_value;
@@ -541,7 +551,7 @@ static int diag_get(struct bpf_local_storage_map *smap,
 	if (!nla_stg)
 		return -EMSGSIZE;
 
-	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, smap->map.id))
+	if (nla_put_u32(skb, SK_DIAG_BPF_STORAGE_MAP_ID, id))
 		goto errout;
 
 	nla_value = nla_reserve_64bit(skb, SK_DIAG_BPF_STORAGE_MAP_VALUE,
@@ -572,16 +582,19 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 	/* stg_array_type (e.g. INET_DIAG_BPF_SK_STORAGES) */
 	unsigned int diag_size = nla_total_size(0);
 	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_data *sdata;
 	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage_map *smap;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
+	u32 i, id, nr;
 	int err = 0;
 
 	rcu_read_lock();
 
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage || hlist_empty(&sk_storage->list)) {
+	/* The list can be empty when the values are inline */
+	if (!sk_storage) {
 		rcu_read_unlock();
 		return 0;
 	}
@@ -594,15 +607,34 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 	saved_len = skb->len;
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		smap = rcu_dereference(SDATA(selem)->smap);
-		if (!smap)
+		id = diag_map_id(smap);
+		if (!id)
 			continue;
 		diag_size += nla_value_size(smap->map.value_size);
 
-		if (nla_stgs && diag_get(smap, SDATA(selem), skb))
+		if (nla_stgs && diag_get(smap, id, SDATA(selem), skb))
 			/* Continue to learn diag_size */
 			err = -EMSGSIZE;
 	}
 
+	/*
+	 * Inline values have no selem: find them through the inline maps. A
+	 * plain object holds no slot.
+	 */
+	nr = bpf_local_storage_has_inline(sk_storage) ?
+	     BPF_LOCAL_STORAGE_INLINE_MAPS : 0;
+	for (i = 0; i < nr; i++) {
+		smap = rcu_dereference(sk_cache.inline_maps[i]);
+		id = diag_map_id(smap);
+		sdata = id ? bpf_local_storage_inline(sk_storage, smap) : NULL;
+		if (!sdata || !bpf_local_storage_inline_valid(sdata, smap))
+			continue;
+		diag_size += nla_value_size(smap->map.value_size);
+
+		if (nla_stgs && diag_get(smap, id, sdata, skb))
+			err = -EMSGSIZE;
+	}
+
 	rcu_read_unlock();
 
 	if (nla_stgs) {
@@ -644,7 +676,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 
 	rcu_read_lock();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage || hlist_empty(&sk_storage->list)) {
+	/* The list can be empty when the values are inline */
+	if (!sk_storage) {
 		rcu_read_unlock();
 		return 0;
 	}
@@ -665,7 +698,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 
 		diag_size += nla_value_size(diag->maps[i]->value_size);
 
-		if (nla_stgs && diag_get((struct bpf_local_storage_map *)diag->maps[i], sdata, skb))
+		if (nla_stgs && diag_get((struct bpf_local_storage_map *)diag->maps[i],
+					 diag->maps[i]->id, sdata, skb))
 			/* Continue to learn diag_size */
 			err = -EMSGSIZE;
 	}

-- 
2.53.1-Meta

