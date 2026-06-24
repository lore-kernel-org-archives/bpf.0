Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825C3998BE
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290533; cv=none; b=QHdF50itfU3AG8W0vc9wtz8vgWIs6Q3/iwwRDtKuSq7gP/9Zz9B2itQjQLwueZf96UeXKi9DUJ/jThqc2oqJddouzyoyxsQOaeG0rzSdp+kx5yN39OKKl8MkxPgC7yNwBvrlq4u/eoa36Ki8vvYlTFA28TQVMHr5k6Ll823t9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290533; c=relaxed/simple;
	bh=HNZpg/xHJqTSWZQlg89/3FcDfzRQN09lT4Z4fHDr8Fw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WqE4G1smCuVbuBesRBPyjXWhbAYPnkWYKTm4xbuHV5PWFe5e3qNux+COJJpKdR16kJuMc1YHxVeQK2EIlXXPT1gMuePd+LhE+4u3dWoG4wBWnoC5uErDTdmq2BfSz9MZSWF2J0BfEoQUw2Ko9nxQXhnMF6eZDKoQFxjqN1Pils4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xu8BNEiE; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xu8BNEiE"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-69763fd5cbcso618504a12.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782290527; x=1782895327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DLExDC59vueux7nw5wKkiU+KpHE7tOm4pNwHPghH8=;
        b=Xu8BNEiEFbaqf+rzbTRpeBdQ6YYtGS7j+tZHQrUjUDYIMmRZ1CYt540O1qdfsCsfF3
         uz6OwPhg6rvDkVF4u0tIwg3I4xrFxUS8v1uzIx/9DDFDpvIU8WZcQ2fzCPgTiAZzMgN8
         Ck/GBZQ0DoS/q6hFCMcVdylIxmcbXOAYSbKWqm4QRwkHnqgesaOuc8yyp6GIPMc7EY2b
         sEJ1yxSbddRiqGWA7A1omPjmy1lMV+JAg8gNOjnBKhgxWGZLC9cmI20HhXhMRcyIGoVi
         T4LHPgT+QoaNNo3YQ093MyaPkEXbQP3GI8lwGllRjbcuqKjNqEGP12FqASh3EG/PNCKm
         0pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290527; x=1782895327;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9DLExDC59vueux7nw5wKkiU+KpHE7tOm4pNwHPghH8=;
        b=BJHys9d4YcwPDdmxI3jjXdMMdiI+OTWrUUoSfhKkudbYI5WSFXqdziMBDLKDeCBB5B
         reLnAIPsbfDWCCgEYGBhhvL+lgS3ya7omlXqyyycLQga6B9hylOtWf2J7nKPO4oArdJn
         fiG6qbFj9sz+u30IVTy25VNt3pVjJor6XTbx//S3/U6x75WVlVuU0B5WskEd3tZ240bn
         DWNbRGbr+o6fhDBREzYu4KkghIVAg7damed1sqc4EpRc4Mpe+/WAvjHNKedfWpGCXthe
         oF6/VTulthKR5TmBzSHzLiwV0XwqwwlSlu5787R/IR36QVuZgTH6eE4qKj09CYnxh0/x
         pBxA==
X-Forwarded-Encrypted: i=1; AHgh+RoXWc9JMRQxN2mxIHxazDPKOZoL0eYG8cAUUa9My4SAvL5hjzfAmAol9/pi/BaRbwffwyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzI9ufC3FDkne3amZKDiXcjCwrQKjVobBnxYyOTJnReVzWQzv7
	9toFK4egLxD+xamvSsP1KFycEOk7SMhVkiaHctcTk3wPHmLMNWcPl0HKMaQMBsy1olhK7kpV/Gn
	iowdtzjhIV0gCQg==
X-Received: from edxu18.prod.google.com ([2002:a05:6402:652:b0:697:7bf0:5a7d])
 (user=clecigne job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2714:b0:697:d34f:2667 with SMTP id 4fb4d7f45d1cf-697f3aa4acamr1109823a12.13.1782290527068;
 Wed, 24 Jun 2026 01:42:07 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:41:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624084130.2382335-1-clecigne@google.com>
Subject: [PATCH] xsk: fix memory corruptions in net/core/xdp.c
From: Clement Lecigne <clecigne@google.com>
To: aleksander.lobakin@intel.com, edumazet@google.com, netdev@vger.kernel.org
Cc: clecigne@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kuba@kernel.org, sdf@fomichev.me, horms@kernel.org, john.fastabend@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Cl=C3=A9ment Lecigne <clecigne@google.com>

Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-copy
frames.

Note: Currently, this specific AF_XDP zero-copy conversion path is only
reachable from the drivers/net/ethernet/intel/ice driver.

When building an skb, xdp_build_skb_from_zc() uses the chunk size
(xdp->frame_sz) for the allocation. However, napi_build_skb() automatically
reserves space at the end of the allocation for the skb_shared_info
structure.=20

Most high performance UMEM applications use 4K chunks, where the
corruption cannot happen. However, if the UMEM is configured with 2KB
chunks (a very common configuration to maximize packet density in memory),
a standard 1500 MTU packet will trigger the corruption because the required
space exceeds the 2048 byte chunk size:

Headroom (256) + Packet (1514) + skb_shared_info (320) =3D 2090 bytes

Because 2090 bytes > 2048 bytes and __skb_put() does not perform bounds
checking, the memcpy() writes past the available linear data area and
corrupts the skb_shared_info structure. This can lead to arbitrary code
execution if pointers like destructor_arg are overwritten.

Additionally, in xdp_copy_frags_from_zc(), the allocation size is set
strictly to the fragment size (len), but the subsequent memcpy() uses
LARGEST_ALIGN(len). This mismatch results in an out-of-bounds write of
up to 7 bytes, which triggers KASAN warnings and is unsafe despite typical
page pool allocator padding.

Fix the skb allocation in xdp_build_skb_from_zc() by dynamically
calculating the exact truesize required: the sum of the headroom, the
packet length, and the skb_shared_info overhead, properly aligned via
SKB_DATA_ALIGN.

Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
the allocation request using LARGEST_ALIGN(len) to match the copy
operation.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
---
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..f36d1fb875ab 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -699,7 +699,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_b=
uff *skb,
 	for (u32 i =3D 0; i < nr_frags; i++) {
 		const skb_frag_t *frag =3D &xinfo->frags[i];
 		u32 len =3D skb_frag_size(frag);
-		u32 offset, truesize =3D len;
+		u32 offset, truesize =3D LARGEST_ALIGN(len);
 		struct page *page;
=20
 		page =3D page_pool_dev_alloc(pp, &offset, &truesize);
@@ -740,7 +740,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *=
xdp)
 {
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
 	u32 len =3D xdp->data_end - xdp->data_meta;
-	u32 truesize =3D xdp->frame_sz;
+	u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
+	u32 truesize =3D SKB_DATA_ALIGN(headroom + len) +
+		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct sk_buff *skb =3D NULL;
 	struct page_pool *pp;
 	int metalen;
@@ -762,7 +764,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *=
xdp)
 	}
=20
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+	skb_reserve(skb, headroom);
=20
 	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
=20
