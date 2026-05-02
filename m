Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF835DA6C
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752451; cv=none; b=cbceJccAAbGVIdcNnQj3tRrs5rOJ8UOsV9WDiwjrQkrokhdwnLJG51Xb9aYTbCuZOEMmON8Ujr6hmN1Y9IVpp+8n3eOJuRtdCvkjH69UDZOwFF5LtvSSEG7GbdWCAB2d1QxcH3pFT/yxucadt/jAxF3t/G44MQqe2jn9YYFwjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752451; c=relaxed/simple;
	bh=TURl7kKo2rz7v+LlDTeZ01AGJ284PRpIn80ytw66Cxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=boPcKmiMF65GqqrbphGn0ERakPkH/V116D1HHtP08NUcALKCUC1bmtu5ClStcPyrpAvq9GBEB7x1pxXY47xDdox2MnDep/pb5/i7oIePUGUujMC0ydB0PFpfSwenW8P6a/rawkJk1Ws/rzATV3pMx0jCxcY7KJ7YsfrYEOLh4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4muSleW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4muSleW"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso3060075a12.2
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752449; x=1778357249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAg/0mIVowv8LOWrAsq6a7YduxLHVN0hmFUezp0XVPE=;
        b=J4muSleWHrfdFEtOuEqD1x0PgGfxM01KVbGNVMnLB7LDtpgZ3VYENet2Lj42xPRAyx
         pN3ZfQWJiDE0g0TbelIvs4fURGO81d5rlNdWtBDe72pgcqjr4sVSTOmWYLxygWQ+BdKy
         yxl9FDPDf46Wt11PJ+yOZMm0QOM4rUg3uXx50aVE+HTswzrCdbIbhihJRfuUTGBJgRmy
         C0r0OKShIkI+prp5yUzi12vuA+r31M9CCivTlxZh4hUBA6TIxbzcGYQgZuuJU/QyoLOG
         7YXbL84WWuUxO8dL03cX0PRz7V7AsfvV/8oKdhMA55ixNnq2e25ztEMfr6YDc+TZDoWB
         zjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752449; x=1778357249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAg/0mIVowv8LOWrAsq6a7YduxLHVN0hmFUezp0XVPE=;
        b=Py/ddG6rW2XRhQJ3rf/1d0fx6PgtenSX/6IcgOHIyX3RmvWI6xwDTmZysr+wa3tRyc
         JWrDE8XD4gF5JShB5GfvK01RINHj/7zsdFNMzBIcXBsPC3CmY+dpAYBcpVb42qVEAaE+
         8dNvkusBjqDMph0mKRUepGlxhplMD+5JuwylReRYGec9tSCcf9fk4viI2rd25ucRti1w
         fclJgQDvJA0jBOTH4Snf1IVRavFnkl2EudUDxyIF5u6wNLv0U1yLHB8AekmqM6+fbcS5
         Ba8Iao8VC50UWyg1RBABLLNzb7PH+Q4Ld1JlxNtRwU/mwuVkg8TMFW4Q7FduX3e1I0Yk
         nqjQ==
X-Gm-Message-State: AOJu0YwuFcFu9JVVeA2V77IGQ9H2SKxrxYyp/Y/LeaBm1W6HyYMjWF55
	noSoo6RRLtj0ygafm46tRTUhPQEELVak7l5q03PL7xWlv7YhkU++vzpS
X-Gm-Gg: AeBDiesPWIDGittVK6N9R1F4tuTIsfoEMoOIAli4esil5ci8XPA42O7rqh/2ip9P2nP
	QjVbTpteGmCzh/yTxAM8i9DCLMxaSvz2qeRDGOujgpXsSyiawSKbR9oKVqPK6v+1BLeIxAivEZ8
	WPcwcOOlrRz8BiouNRPfiRJ4esg1PVDHD2z32ZU8Npe4Fziawpw7QZON3cXdx4TRkoqqnk7pysc
	zdOmNevjuoLHfcJHWaOD4HZ6moo0ezPvS/VwfGlqoaECbgzynj+sTR5caNToHW6MtAYt01K5jJW
	Ja3VJ2ZjS0oT/9tEOhfpD1pyEk9NRIVIPe2n8aM5u4fPIzNzxwx3H2r0FUJZkD8jBWdJei7f6Wo
	1H3DHy/5ckl34xh+gp/B1qSxa5QbyAGtHWvkVjIp1QYNvXZO13gTQ7WaxfBqT+Lkn8wRgqFTdP7
	nxkJuvifDa52FSs5QCcBwTjJxwKsaOOwDkUh8N7K2hqn8AZv79+tmJDikVtvgcYDzbWtAWJLrq4
	kk2Pxyz1peHiZDKiveZjjYoaF9j
X-Received: by 2002:a05:6402:605:b0:671:a18b:32b8 with SMTP id 4fb4d7f45d1cf-67c150d2b76mr1186953a12.0.1777752448468;
        Sat, 02 May 2026 13:07:28 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:27 -0700 (PDT)
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
Subject: [PATCH net v5 0/8] xsk: fix bugs around xsk skb allocation
Date: Sat,  2 May 2026 23:07:14 +0300
Message-Id: <20260502200722.53960-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

There are rare issues around xsk_build_skb(). Some of them
were founded by Sashiko[1][2].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
[2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/

---
v5
Link: https://lore.kernel.org/all/20260424053816.27965-1-kerneljasonxing@gmail.com/
1. reword patch 3
2. adjust the order of patch 6 that is now moved up to be patch 2)
3. use helper in patch (Stan)

v4
Link: https://lore.kernel.org/all/20260422033650.68457-1-kerneljasonxing@gmail.com/
1. fix 32-bit arch issue in patch 8 (Alexander && Maciej)
2. add acked-by tags (Stan)

v3
Link: https://lore.kernel.org/all/20260420082805.14844-1-kerneljasonxing@gmail.com/
1. use !xs->skb as the indicator of first frag in patch 3 (Stan)
2. move init skb after it's allocated successfully, so patch 4,5,6 have
   been adjusted accordingly (Stan)
3. do not support 32-bit arch (Stan)
4. add acked-by tags (Stan)

v2
Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/#t
1. add four patches spotted by sashiko to fix buggy pre-existing
behavior
2. adjust the order of 8 patches.



Jason Xing (8):
  xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
  xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: fix xsk_addrs slab leak on multi-buffer error path
  xsk: fix u64 descriptor address truncation on 32-bit architectures

 net/xdp/xsk.c           | 115 ++++++++++++++++++++++++++--------------
 net/xdp/xsk_buff_pool.c |   3 ++
 2 files changed, 77 insertions(+), 41 deletions(-)

-- 
2.41.3

