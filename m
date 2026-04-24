Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3112DB7BA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009123; cv=none; b=Q47/oB6ricI2Sjctc4OAb2xBJucLL/IBKoSZUwpnpm2IMFwyAmKw25Oq1+ll8u5Y9pNJkKmjDo6JcqpGIn/hrKJWHDKvH3PPRhTVQlG2s81QOC+jHyJ30ARHtqbsNk3Vl2jM3hq2qa9J9SV3BiOqUrfScO9Fe32gnKwjKdqayXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009123; c=relaxed/simple;
	bh=ZHcJ9yN10UQ1ZYtTyKaJpPQw8yGQuS+4FX46G62En70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5AQ6td0qCWuajWWpdUdnD9bIlN+rVOopKg4r3XMlv8mfZH0h1lcx7uV8ui7U7Aa3FnmauCeosWgmf4A5zW7ltDlhjytiZMt8Kw4hi+gtZoKHFMfc+CIgj0WF+pYnD608Frt9jUdrwV33Zu3MXp70sbk3oVCjAUj4PtClylegfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T76OSyCT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T76OSyCT"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7963df6f17so4969569a12.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009120; x=1777613920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oqds8RoH/84yfTSokzcPq2kMkpQyMQYgcBM/zS1eRPE=;
        b=T76OSyCT/NaFFkl1n1qZ4KAOTWQkoyVsWQ6b3vbSaKz45AIGuNyRem+ssC0UE/vi+p
         fjJW4vQ58vVkE9wiRMyAcQw/MMkg03cS4VvE74FTn1qvO65xAjEId2EvJm3aEjkH+2h5
         V2lrqZ8NoxMIAH07lCiGotvQ8lEZXVOJ6cfAQUy8QpWKuCrRac836a67gxQPAD8pBhpZ
         yRQtADUYFNQsT8WbOrdnReUp1E71vnQ2DqxYAdmLLkc7r2MC2Wfn3Sr/jckb0ihwP1bS
         nJsM1kwFK1f0PrAUuGzQV77sWox5oP3MyjF7nSIhtesgg1Nhb/EVAxIrBWdr0rVJ/S/D
         JXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009120; x=1777613920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oqds8RoH/84yfTSokzcPq2kMkpQyMQYgcBM/zS1eRPE=;
        b=mz4KnCczrRwdwZkIz7SufN5wa6oH+B+K2ivWZXPdZiZ4uWDSzwgFkshTZHMpK3KRbc
         qjuUIdOqHjvDvwMDV/2h41GQ49vk64XQDCweKEdHLckkMKLr4ZzVsAaXJJKI27U0+/ZQ
         3c8K88F3YIBVeuMGZZJEYc5x1V4xtf+pYTDxUzwMuMtqVvmJTGNbXChJUW7jFSGhwSFT
         jPfS5rQXtNylvog474c2zypwp6DEtReqBaBRyLNkHQrFSbJEJQfvKryUg2T8vF0iSg2L
         1yUv+wePg8hnB6I5LEKNogSVSAhseTJt/5nvJf1YuDinZYU9nPba3H2Sr17a/Fg8cVpJ
         kqWw==
X-Gm-Message-State: AOJu0YwWqtdLaxPNxNFlNb+FX0CtMMXD+NZhuvCuDi6thvg6lQCpHypD
	NYJv5dCLYIO7A2dD7JJ0vG/O3THJMnvReNhVD1i0Sb0FJUcun49Sd/nS
X-Gm-Gg: AeBDietrCxoQe/Dw8HslubPRAt0pi0RfqU3DFXmgNq2e08LHSPv3PLkKolpvY7/pHA/
	9MixKzF2B0YQcs4ck9jdVLSR2nz/b1/s7zgoG/ggW7ZR7GQIrVkXhnUfwTaIv3WZt+1g23v964u
	Vr4mP07ZeJ4C+23diWMuwR6i25K1QLibBjIYpbtKtNDVyVCipRYZLEDMKafp05Ad5UwWxij6WL1
	rxvmxvcUyalDSZDhpDgLsY2IJ8ykhA45l1iBrwGtN5j9hCgx/CC4bkuBmC33hGyh1Oy54S6G231
	wuP+w8X312rQEEUjrSBZxdDHHL20j1INO3IRg/2tJa3wtQqJ03licKjvICgbTq6euFhzmnnm1KX
	kHVmxS52A9yukpEb148QQiS3ZMlZPdW51uYVMvMcgbMQaTP/XF9ET6DaXufbKGaKbRy0njJPmfM
	rxzFfY+e6VOlFZUAcjyqZ6vRlG0Rv9bc4+IXXiOUsGlFf8yBQ/ZP0kH/mQr3vBDaXIKpStj78y6
	SuUwnlAAHeoIa3S7UIhzHNTmGFz9ONekHQTAKAU
X-Received: by 2002:a17:903:17cf:b0:2b0:52b7:e82 with SMTP id d9443c01a7336-2b5f9ed031amr305417545ad.16.1777009120528;
        Thu, 23 Apr 2026 22:38:40 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 3/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Fri, 24 Apr 2026 13:38:11 +0800
Message-Id: <20260424053816.27965-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
to accumulate subsequent descriptors.

If a continuation descriptor fails (e.g. alloc_page returns NULL with
-EAGAIN), we jump to free_err where the condition:

  if (skb && !skb_shinfo(skb)->nr_frags)
      kfree_skb(skb);

evaluates to true because nr_frags is still 0 (the first descriptor
used the linear area, not frags). This frees the skb while xs->skb
still points to it, creating a dangling pointer. On the next transmit
attempt or socket close, xs->skb is dereferenced, causing a
use-after-free or double-free.

Fix by using a !xs->skb check to handle first frag situation, ensuring
we only free skbs that were freshly allocated in this call
(xs->skb is NULL) and never free an in-progress multi-buffer skb that
the caller still references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6521604f8d42..d23d1b14b8b4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3

