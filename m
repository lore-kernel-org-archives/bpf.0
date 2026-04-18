Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EA2EBB9E
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488235; cv=none; b=GNCkKQLX/bKMJq3rUimCh+ZdpFh0Q8r++fOqPzZRwUbW5q1YExrd0CAYaoVvaVhtEZWL3N45PEWEwTPDaQxeT//3+rRi/5dSdifEonITEQi8Bu1dblF3s7PAXFLu7+BnVzUkfs91Q58v24AWcBp1N4MzoiGq54hXh8Gwa9YbpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488235; c=relaxed/simple;
	bh=tcfCsgbnieg6qkiA/a4ucXj2rJyFJzVtLJ7GffKDqEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zlulvs/4JXXL9r8rhK3T7PJbeQJ6G+sRVVdVjUuwm8n4FPo1aCI+0S8PHLRcWvKhiXCJvdmeHDUFH22EEl9Poes7HhrtB/4ZjIkrjQKVI/2eLyYaKt0kxorZGqsZDGSDBgvWpwlndkEp2pmUt2TkBVtsSqywPe895otPE1WXkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8lxyOUL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8lxyOUL"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so959323a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488234; x=1777093034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJp6qysCzD93Sv185skue5qBzMtZ0Zel+Y3yR5NUr/s=;
        b=C8lxyOULxRXG98sejbPiF7xQCQWO7FipsqmyYMMqTN1YEqXoaf04cBcisOpL7af2yT
         t7h7T+nuvdFiomckY7YjhghJX/ru65fLsV1J4HJ/qUUj3WN0zsZX6RVOIXMhJwYJKpd5
         rNU676TSE/dLOZKhwwpHA53ylTcqVyhuMBBC67pk8Bnl21NDixIo46Byia/zZ0Zk+Yt2
         Xtu8/GX9CtWKNUz9GFC8Q4rvNf1r1OyGP2FVWeU2ZAYB8En2xHqczTrhmWZqw7JGuX7J
         QOdGBw2tCzbrA8oJVr4q3eh9k+YeW8F/IT3c0j5V6EAPiYkICt7tECOQ03MgrqjWXJ7t
         8nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488234; x=1777093034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJp6qysCzD93Sv185skue5qBzMtZ0Zel+Y3yR5NUr/s=;
        b=czoX468ZE5gA2v3VOFKq1r5svQP0djIBzj4eMol5eI/X1/NR3Jx1QrnltS8cwJn3V4
         ds2JstyVDD0cte537iOJY12KMA5F5MYAI7p6KHufKD7miqg4bUYdxkvVdtbevYW6Pv2F
         7Ya4SBFwl5lOdWBgB4DvyWCUJOCuB5ybgmTCTE/U9Cdv2aM2g2aaRlEDkAWENJCif9nm
         dJuL1xt87mkYI2S3q7rWq/500qHuNkNVswgcb34yi7GHttrJfFytqJeGn5RCGUNze8Nn
         nJzQE0Bu2QQq8lY2jsjW5g8n9bKknUT5TMrBm0bIiN07yTokXjCLOItWA/bYzWNL8q3b
         qDsA==
X-Gm-Message-State: AOJu0YxLVwQtnz/9Gdw6b7plkxNUXlkdBPu9iYjlbvzq6dJslTekEm28
	ebreZrPJsrCGqaWTRNN2To5P0EfCEkG9a+2dBDRZDq9BPSfMGeRcD+tO
X-Gm-Gg: AeBDiesz+f1TblablWrkHXeOwx5j9Sgnmm9PrYParOkDNA9FbK1XCSilOkbHEXX+ZBn
	LQF0ssiSTD0lqeN1FV34BHNWrgYgAJ/RDYNk+9FsLu37eOhHFv5HOb5dap44AANoA8iGEbYmVHD
	dGIAwg5BD6v5X24Q1F7OCBtLF4pxRkkQPu6bPw2dcqIkm0nyo9Q+b/+KOXN/R9DpPYZkwa7Y4a1
	My2Q1oQfWLhuyDWKDcxgrEZIIVlghow2yCGfKVLq+q0aMcUlx3q71vggiIpMJSwUI6MYWwiO686
	lUAtaUz0HG2V7xuevX0Of7LEkdgOZH6RKZ7NUwZG6AdhzK1wCVQSMyiM7HSuOkMq0PY8WWOUo1N
	UYojJq+EvxI274ehK+dCJMJeLELmuVs3VAmtCWvx4rM2zCRcQza7o9c9STa05grhdfh/4K5ccBg
	kw5j0oOLA1EphCOhUKJqoGUZnFjDx+3VfqXmctHikcYmkMh8t7ZASnMZ+EM/uFNDPAZav0p2WyV
	GTWO7NtpA==
X-Received: by 2002:a17:90b:5845:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-36140473f70mr5833835a91.14.1776488233557;
        Fri, 17 Apr 2026 21:57:13 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:12 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Sat, 18 Apr 2026 12:56:41 +0800
Message-Id: <20260418045644.28612-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means no frag and xs->skb is
   NULL) and users enable metadata feature.
2. xsk_skb_metadata() returns a error code.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
4. there is no chance to free this skb anymore.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..8fcde34aec7b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -743,8 +743,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				kfree_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3

