Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611342;
	b=rzg2/84qMz/+Ozzgv3/RhSz/n2pO3JUEN5pt5qVWlxP+eBVXeSGc2YlOmAHJgteU+iBz
	 h5cLynw7ryy0bmbAhQwFLnaMMKwV83bJDi+eYXUC5ew9KV5lY2h36FRq+fwuVYjHYkkJ5
	 99VbKQ2QmgSAn9pulVDQHLpyR6LTy88VjBV+41hWsBOHsbyUCt9iWv5vUu4l1gSsSbaSZ
	 hJxAU6oLgS4oxHQ+tr4tx9e2uCGAX/1wTZ7QZ5PR9aSs/aKjb9TaoV0jrqkoie9Prfsz9
	 ZjnYV4+85AzNNjAgscvCw0zwtKniEV0cxMydw4e32WjEjwjdkLcnE0r83Kn8ST2X2Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nDAJ7mIuB5uD244mZde2uExZXuHZUNDxbR1OeqSkOYA=;
	b=0U4/YbAfnU/ixScTjGJjJG9zJ4qHZymFOUNKTRklOllrPr6vK4vt6+8l1WdzYgrxmZGc
	 R4++NjYJ1rcRBkAn1tr2Jwq887+F2P8pgxIz8nmK3VgSxmVwuFk3z8MTrhT6A3BebC5ts
	 x68mJ/65j7MUBhsha3zdROz451gOeg2EJuddBcHk5GT89ilFK0VS5VEI9Em1gMiZb3Yqb
	 GNjtUg9tJu1Bl+WJ/jTJq4Q15UNvbSAnGJPYnG9QoglFn/0I5RyOz2rFN+npgnPDCm8Na
	 u4KlQ+OC0oha9+Kh6rfsUCpzJoVsC4wDBR5i87dCuCHN8Bd4Si/HMGhccldL44Ve4UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f2hIdu8b;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6B606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0C6B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f2hIdu8b
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b3541bb1a2so9383637b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611341; x=1795216141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDAJ7mIuB5uD244mZde2uExZXuHZUNDxbR1OeqSkOYA=;
        b=f2hIdu8brEL8inlZvwmpGuu927pjKuayoGfBl6XW/UMqJ5N44NZU38R5Upwj86zk6m
         3d7F7Bcg34UDXrEo10HNSHNZbTkmi0PdpqSL9OICZ/p+qaIigNG8fW5zxvMUoQA686jp
         w9r9WZ/BExMzojPRZ4pmlOd9ZbEMEnuTwwkris+70BfQgSDGVG5h2uPWTv+QxIOHvTsg
         xT9x1BYmnBDD/0chDYTyVqvQO7Ebn4n+NiyVJ8QZB1sZqWhS0xt6mtunmPM7OlkvkS3m
         x2cFscM/T2Vmb0EZKgQLdJ7xetMhqq4JS2vtGguYHYxAlwPzTV7U453kKMj0GamtJfEi
         WTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611341; x=1795216141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDAJ7mIuB5uD244mZde2uExZXuHZUNDxbR1OeqSkOYA=;
        b=boZq7OFyrK1QqK3I4s+w9f8khfapMRZcWUVpbme7AoFSKeMtV59pKNmXMenVMKoXr0
         YxVmDFvWLSxjZEof3eCxu2f53uHnFlg4ENURSgc7JYUFAmA18B8Xr1Rrxfl5lHTB4X1j
         NFuw4ALYfP0tFqieCHEk99c9c4Ut9/sOW16lAWJIDPFAleM3O1h1+6DL7bi4aVnhlCUa
         SlNKXFbu0tnIpwNyzGdz2LU1uRCluQRHrlh6JB1+C7MR+l12qe8ZOoKsL9O3sU/cmr0H
         OhcEZNYDBik81Y95x39xSojylyXPrH/if6jlMiDmOtNbbHUIBS/JpP7MBcJKUbhvekz8
         Jjdw==
X-Gm-Message-State: APuU4Z+rzyOHRp6VMssyc3GvmUK28u50yh8eMRRo0a6/7sGlYWxT9yrK
	7qbWi3AzeuBGQVLlBMzXt4YHRhPwAcyBnkb89CDuJHoCEEzjWVzR0cEM
X-Gm-Gg: AYBFou3Aex5ZNoV0Ou7K1A9YIp4DDcvPcNhpOzAt4ymE0oorbb/qQTrI0WhJbgdG8Qm
	5S3iFPPtL4DZhxYHCiXc/5f2dJIMudYDggTj1W7Op2n1ocjexKJ+wD1xKGSgiENeUsqoLiW2lDm
	nIDZqYOowG/wKfxfyL68scqLAjLGllfD447V5QkF57h3dmVVlrPzODeeHoTbWWt2zuN4G6f9Ijs
	JZ+a03Q5UDQCJK6CeUvNhiNNGEC3caFMGVpAAcENUYt6+2rzFdKri5MRz9LQmfaN3zCfVY+X6P2
	60ZKOsoIBX2vdtR+WTtsQmXCarrhFcCmZQA7zjdXmFmlEbCOtJzwwcyHQ3Tdm15urTKVUzNYDEK
	w0MfE7wtftwajFFlLSsJdOzW2dkUazm/uO0dRa+KJ5Hs7JrhmvOs/Ogzp744mLKgdwQdC2NbdCH
	TA3bZ0yB3AM8gURTasc99NMOesMfm1xYegQ6i7QGkzIe77e/kwreYhTqZQSw8fjz7kjvsxxWaDg
	qvtuarOvvDP/N3qOQcTmkeBL7etz5a3dsdG9DjfCVNdN9Ad3GUy0BBKAlyIsIlXLISRizI+wUTp
	lkjeySlkJHV8+4k70U4hIyjOFB9o5+QGdSD4HW31pg==
X-Received: by 2002:a05:690c:dc3:b0:8b0:a432:5686 with SMTP id 00721157ae682-8b4aa2da2f3mr22869877b3.44.1794611340933;
        Fri, 13 Nov 2026 15:09:00 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa957df4sm32490167b3.20.2026.11.13.15.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:09:00 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:32 -0800
Subject: [PATCH RFC bpf-next 09/13] bpf: Show inline values in sk diag
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
Message-Id: <20261113-sls_f1-v1-9-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=4419;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=qVaGxnL+1ZGqT15snfvZALGtg2UVwKDUE7JcBxbzFw4=;
 b=1r6xr9+SpdR415tc/CfTx/20IKNjtdRqbD7W7vtuu5shZ+lxgXZPtHwzwUsozu3W82pr3Levh
 kaxXMZlKv6kAP8zZvHK7w6+M+qbko8HJ6UA2qMUe+pUnTSjxRtCXwWA
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

