Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FB33F8CA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009127; cv=none; b=pkJgMVZVVcq8yzAXcvj49ajOBn91qU6ex2omtjPi9PitRtSLIt42Wnap4j8YT/i4oKvhwF8tEcFnbdORbKCjlem4hoQr4DAIu36jAYaeGIAwCwWVjaAv0mLZ1tJk/atER+lIbDb4wSEJ7L7ytEzMeCHv9MgCkc9ppl4DxQJtmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009127; c=relaxed/simple;
	bh=fO8jrrKrL3//RQFLKox8KTxmstVGkIWBmewzmec/Pj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxX8X9MTwUrzZn52ipm2GfRsWGJDk37F8gBGT62J7S+IFeCZImc67Iy4QJTuvqA2sBNvfuQEJma8QpcAuCaBbGlon26wvh9A7I96wb+6s4mMP1U44Yo7FJE0sVLFVYHVfbTDM6wJryWkJkISoXibvOPKVRZRL0iiS0hbdVSyHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFwKF2Aw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFwKF2Aw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad4d639db3so37928865ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009125; x=1777613925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DEVP4Wy5pIi1F+YdVvQMkTO7AT88wSCJdPYFga9Kt0=;
        b=EFwKF2Aw1Urvf/b/jjGXFxMfcF+6GOtO/3fBfsS0JjViNE819nc1u7ZrKgMqyVWxwG
         1HxFJT92KKYyaFEmk5sk9zW2XucMUUEv5Rm+w5SBku1TgCOF16yAPS8H3BlKnm7Er1SE
         cl8smqkxi6RFqWABMgPbwDRpnZgmZ46pam4XjUNSpAVhiER7Sx2Bl3unotlm5QH7ulAr
         SGRur0Uk/f947CR6wOM6KnrhUpvYLZutpIz8U22bQXOYeJxYxvCRTXp/MBqknFGU/jgj
         rGYwZvf1T4SL2GnGvxqiaOe0xR/UlzBdkpHHwSsWBxcfAAewy6txY2wkkhLzOFMNFRAv
         nJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009125; x=1777613925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DEVP4Wy5pIi1F+YdVvQMkTO7AT88wSCJdPYFga9Kt0=;
        b=F4U76OrVsuQBgLdtBxPdvLfQUrjgib7n7iWyVk/rtQYtgiFoAxw7cLuaziuk02ub1X
         1kQdjORL4Zgs251foZ0VOBWw/LUAtkfvXoUulhy2Gs1+rOKE8RNI8eThxjdD0hIt0+ZP
         VwpxFCE2RZxeks92/cj1LJfvSzqFscI4EE51GtfytKFGYzebMluafTEGa81cHtVtP8Fs
         BrW9CkuhhjEESOE8Ls/Qz/EEQqQvrtWHbJ6XLR9SpGqYC0UA9pcuvbdJX0bqObcFrJIW
         CX9sKUYlB3KmTg17kVrJPoTtqnxsXYR+PUkmd8RVidH3Wo7iwZs2qIg23QlPGBx0xAOg
         nVVg==
X-Gm-Message-State: AOJu0YxsaK3E24hPx2ERe21UM7uGeVlmvNQCbGeKfb5ZPJXN23Fgr/6l
	QZ4qbIUCnVyj2eiTZflNE44TIBKoPvp5CdGZDENC6Gw5zG10AHFVCKGY
X-Gm-Gg: AeBDiesPosyMAWc4vZW9cbZU0slYH1KwzFT/3kQy/u6QcRpc6ILa/+z7/zcWUxZo5lq
	WZIH9O9WzvA44Dyh7qg/J7ZCwfYPiTccx280jkN0mW5OM2JCE5xR/lp+XiI1rMHmL/WrlBvDqhP
	JVkr1Ciq64yvL+tT5SF7Fcm7rJHeRtPpDqDyA8Wwpnk/RlW3BTNSFLzHSx+fdJpfhfmFV0aki57
	GN/xEL5Nxli4wtmHdpQ1AFNIhcyTp5Uj6MVozAliVW3FT0tSx2y4931AzJNNYpaXkGaCFN5vRjT
	Sqs0fJwBFt84+850GuqGydUvEIjp6QbIKgXv0d9GQ2h2xgIphSjYNiq4Saq8q/JAKDkLhYfQSHu
	EHohRRYIVJPuO5ghwbwYj69yKAaxdRZyG738NYP5a/ngweL0aHgQzgvh60E1Otk3ottvqhaAM7U
	8r9+cENhI0CA4HTnhf0OR7RWsa90Xprtvn6Dp9nH2xCColFCQG8b4fzg6IQKHIPAojZ6TRyApRI
	oY2MGtcBfKq9r7S4SaN+5pjPpt69u3nWE4D0cO/
X-Received: by 2002:a17:903:2acb:b0:2ae:450c:951e with SMTP id d9443c01a7336-2b5f9f08968mr321477595ad.17.1777009125221;
        Thu, 23 Apr 2026 22:38:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:44 -0700 (PDT)
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
Subject: [PATCH net v4 4/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Fri, 24 Apr 2026 13:38:12 +0800
Message-Id: <20260424053816.27965-5-kerneljasonxing@gmail.com>
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

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Postpone the init phase when we believe the allocation of first frag is
successfully completed. Before this init, skb can be safely freed by
kfree_skb().

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index d23d1b14b8b4..88ec6d2cbbcf 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-
-		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -834,7 +832,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -884,6 +881,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
+	if (!xs->skb)
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3

