Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A83E6392
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463957; cv=none; b=DBdFHXZBvetqIcqKOSz6NzVIoRXR83Dp1oNjVpKIUzaGJVSUE5kMozq3G9xDM1IwnzKymn4HuHFd+KFkBGZQg0SQjot4wr3tj8bs/h9KDMqMUUchl5LGz/PT5baEc4E3BcFGsO4T4JtRdYnwglaEf9fGR/8BPKZEQvkmQDJeaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463957; c=relaxed/simple;
	bh=4Q4kwEItPghZptzI7w7yAwAaOy5jEDXFyh70cxxpS7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZT2P7KlawKtAHPyJi5ihdjlPXEjXZp0HC8nmT4EcwvBh1YTl5wgE9DzHMyOjguw1fA93uAAlwaLbzZn4vkLLh3SCUF5iKN1pm2RPK7fXX90l7Wxn3M0IL1qol6cw1bfe+uMD3bQJzmG3Eob5yjiEQ9ot5u1bxZkVMFIoo7bXh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toOW+/kz; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toOW+/kz"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-697df3655d8so688601a12.2
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782463953; x=1783068753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMQwGfZ+4fg0c6+aiBQoHL3kx0Z8EfvRBL6AIlt5U1s=;
        b=toOW+/kz+DBojB5RjZ2MgxrATvqJDfThot/OuWoeHvoFYeFqK/lWMgxXSuuw6+P2yf
         aqGLZCuEpCLNJXZ12rELl935upCpYQxGidZQokYuzHQMDC1V68U58Wyk9RBn7mRq/OPs
         /KC9S8b+cPrnHdlNKmI6VSOcbwyAAUbxmeGUciUueIfhJTb4D8/BfJ8G7RchAQU+Oy8v
         TFF9msCFWnTcpuIOMHEEukNUagWTZWj2kDLqEakxI572s3p2UqCX6dKAFgYbXoP5abee
         Ka5766O7Os/c9ttVnvnKiJBobS/iRB/yldtEwBy21DtWgbmG6kOaPcknUYPRsDgmBpMf
         +pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463953; x=1783068753;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMQwGfZ+4fg0c6+aiBQoHL3kx0Z8EfvRBL6AIlt5U1s=;
        b=W/sDMxUaVOP60IhKS6djZLPveuxf+LBKuCpG32laTy/GF9IzeZcT6tBiwW+al1uD9M
         VYewRk9JIFErCHz7+gOfSPiKYVjPEWB5qyxVhs+mlisfg7Js1U2ZIh6AcCc7wd+Oty0Q
         q//3cWFBuTNL/jHLBAkOL9ivormZdKoj018pjYJVd2ajMb6QbgkAeytANYq1eLwYEfmE
         yw93sTvWgZZzzAf8zisBDqJRsfgsbug/NM5oG31HSBDVLOCnTnINCChwXetnjj1ua7US
         /jinU5xa/xwFO1GnidMEzHCiIzykzgavRtPVI8yHHyi2jQf9ITMHItwNWt6UX2PISOcd
         jbVA==
X-Forwarded-Encrypted: i=1; AHgh+RoRXdd58KCfarv7HM/gSY6V9YetgFs2KBdRMBhfgouRCd5Zj6Gh6jPDCvfcFWcuydF915w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7U6PcLo4zmjwHovK+LwgycCwcCwp1kLVEiA01tt0MX6XLfc3r
	hhnwJybe5Xq5JRpFPmnVQIz95Tzroamh6BuE4hIiJiEiy4TEfc8w4dss4dBE3OcpBoiDcS4oSRj
	v/68XD5DqUWSjrQ==
X-Received: from edsx13.prod.google.com ([2002:aa7:dacd:0:b0:696:5e7:d0af])
 (user=clecigne job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:51d2:b0:697:750e:e9f5 with SMTP id 4fb4d7f45d1cf-69810ae06c1mr1512484a12.23.1782463952731;
 Fri, 26 Jun 2026 01:52:32 -0700 (PDT)
Date: Fri, 26 Jun 2026 08:52:25 +0000
In-Reply-To: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626085226.1765180-1-clecigne@google.com>
Subject: [PATCH v2] xsk: fix memory corruptions in net/core/xdp.c
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
properly account for the headroom, the packet length, and the
skb_shared_info overhead.

Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
the allocation request using LARGEST_ALIGN(len) to match the copy
operation.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
---
Changes since v1:
 - Used SKB_HEAD_ALIGN to properly calculate the required allocation size
   including the skb_shared_info overhead.
 - Re-ordered variable declarations.

---
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..52546746378a 100644
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
 	u32 len =3D xdp->data_end - xdp->data_meta;
-	u32 truesize =3D xdp->frame_sz;
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
