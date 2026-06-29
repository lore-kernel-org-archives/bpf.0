Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5453CF054
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717805; cv=none; b=VkiZmM0nurauJIJhTZ7Yp+P+HBq10zBHBBS3bQl5hpd/M0ybCtZmY6KiDmwyMeql/C8xy6w7DnxzlpwFiUzjS7Rai/U82hM3bemMNRCDpnlnHMT7EDkW/Xen5FWx6Ldc06+eT1gEVb6UYo8YCaWxUzTU+aGgw+dcEKKlzIB2BU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717805; c=relaxed/simple;
	bh=F4mUr5fBW1c1Axigt0EZGxBodn37EyWGG5Bvapzj6BA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LOHw9L2g6FfQIEUBQv1pTTSTV38uLrq+VeJXzMGCO46hz4N9DPLMS6VGsMVokxIHijvBT/2FxJR524u1QYh6ozGGWhELWret+1T7RX4ia2nCCsrDUNQIEU2Emb5lokFLIkbcyMVWH68icyqz0HR9TeAvSeVtVfQcYxnNs/RMyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFoMNT+Z; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFoMNT+Z"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-69843ac68d0so1543882a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782717801; x=1783322601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esIyG5vSRRrObBzd9FBYvLdlPmWTHEKEhlqipjb5aLM=;
        b=KFoMNT+Z3IUv44V2WDO4nmwk0jVWhc2avf3twLkEiT0zC+bo+OV5BorxbIRkAtr4Se
         wJMhGJM4b7eDiIvkabthe7LoUzlt/UuiFddM+e0tI5O5eKxMffGjqxQ4Ukf4lVaXIWzQ
         myNLd55O2h5efC5BE4jh4pp06AtSTl0+4oiemVCIgEi9E1+UzitUohSj1QqWWLLqS8vV
         QCk1DLwtaDzCB15iIn4PEUgtKinmBz1/03vLlQ1ahFukJYepsjfuja2q1r7grmCfmh6T
         VnXNiH5qYiUg2ibLbFEUKX6ruy9Dv3vGTU99cavVObLewmbm0fzStxbY93vHFc7kzHoF
         Y4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717801; x=1783322601;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esIyG5vSRRrObBzd9FBYvLdlPmWTHEKEhlqipjb5aLM=;
        b=YHUDq4vm6nM0P0YwLNf3xLPvC2cW8iaqkvsASWUdYsXXEV9MPN5u9P1FHfuHmAfN9b
         IbgY7meP1y/1lMYJczerNLWPT2bEQcq9fWoV0RzmR+ejqRs4RvYoDAfdn2zr1lv8rSxV
         tqx6AyYDDVqAKJo7eXvo6v2y/Lu8/k5HQC4ur82tPLNScMJrlwru0eoPkGatnp1pjQXK
         teUIGw2LuVLAJJDpPLgxkf11iWU0UQCn/ERlb6YRFhkG8gRDEENwXMpJaUa2r6jkoG/P
         SaxpaBsIzMqad1HVc7nDuHPqJW5SIcM3TOPmSxXDCMUPamr+uqIatFdpbd8kOVpj3wYB
         UUOw==
X-Forwarded-Encrypted: i=1; AHgh+RpssvpFG0hAMkrtxE4MwGRAg3hn/hshPzXkbXVWn6eyVo/wfVInwQ07kiOB1nWF8/Azstg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Gp3PcrSeE1Fjqj1v4Kc5wZO+Q1hEgkSi3CmEypVdsTXQkxW5
	8gHoM4osH4k0fffYuqN4cjTOXjjRFt+12MUo/PSSmxj1HG9Tts8HWpE+xxDwlhLzDJSQcAlL+Ri
	mpG6vy2QxtqjVGA==
X-Received: from edyd4.prod.google.com ([2002:a05:6402:784:b0:698:3f24:d08a])
 (user=clecigne job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:190b:b0:697:c0f6:394c with SMTP id 4fb4d7f45d1cf-69810a44a6dmr5463438a12.9.1782717800656;
 Mon, 29 Jun 2026 00:23:20 -0700 (PDT)
Date: Mon, 29 Jun 2026 07:22:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629072300.1664622-1-clecigne@google.com>
Subject: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
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
reachable from the drivers/net/ethernet/intel/ice and
drivers/net/ethernet/intel/idpf drivers.

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
calculating the exact truesize required using SKB_HEAD_ALIGN() to
properly account for the headroom, the LARGEST_ALIGN(len), and the
skb_shared_info overhead.

Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
the allocation request using LARGEST_ALIGN(len) to match the copy
operation.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
---
Changes since v2:
 - Used LARGEST_ALIGN to calculate the len to account for the aligned memcp=
y.
 - Fixed the commit message to include the idpf driver.

Changes since v1:
 - Used SKB_HEAD_ALIGN to properly calculate the required allocation size
   including the skb_shared_info overhead.
 - Re-ordered variable declarations.

---
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..7e39f17ad407 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -698,8 +698,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_b=
uff *skb,
=20
 	for (u32 i =3D 0; i < nr_frags; i++) {
 		const skb_frag_t *frag =3D &xinfo->frags[i];
-		u32 len =3D skb_frag_size(frag);
-		u32 offset, truesize =3D len;
+		u32 offset, len =3D skb_frag_size(frag);
+		u32 truesize =3D LARGEST_ALIGN(len);
 		struct page *page;
=20
 		page =3D page_pool_dev_alloc(pp, &offset, &truesize);
@@ -738,9 +738,10 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_=
buff *skb,
  */
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 {
+	u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
-	u32 len =3D xdp->data_end - xdp->data_meta;
-	u32 truesize =3D xdp->frame_sz;
+	u32 len =3D LARGEST_ALIGN(xdp->data_end - xdp->data_meta);
+	u32 truesize =3D SKB_HEAD_ALIGN(headroom + len);
 	struct sk_buff *skb =3D NULL;
 	struct page_pool *pp;
 	int metalen;
@@ -762,7 +763,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *=
xdp)
 	}
=20
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+	skb_reserve(skb, headroom);
=20
 	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
=20
