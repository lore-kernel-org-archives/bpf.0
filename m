Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614563A3E9A
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829020; cv=none; b=k2od+Li60Ls8fr+gf5UVtZBKO0pLTAwT7ZEJOIQfO1mg5Y9F7AOymry2xI01mflqOvw9866sSENWFIrWmcduun85mGkXezuJXccG58xWlhdQxsHRxFsgFDjmH0VUyQ6N63jDDUh6pCeIoWRyPQdHJbgOWU9DtpjLs1E20tFCjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829020; c=relaxed/simple;
	bh=SqobOYcr+p6ZEe1n5wRVQPGdL4P3Hm39eN3EOFs5zkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TL475c/bKuDR8Li1dRu9BVfiXXVUsIqTiz/c8+HkflrGgO2B8J8n6euman9JUP0n0FLBBCPHBfFykx2/IaQOO1V8wlcJxPT4MrZ1xXXsgR4btaperdOnUDi9mwkjsj/v/Ecpz0OXMnPLm4K6ofk4GqqgEUP5IDcNPha20yNv4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyEUNVGT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyEUNVGT"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f351ca23cso2465991b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829019; x=1777433819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epvGnzFq8uZMGM4fcIZGE8+8PvZa4WBZ1uiBJMM4bHQ=;
        b=fyEUNVGThNvZJyvpWgt1DzI9t+/FqAk+A6duRpmN0X6oM65Bb3+ue4utn6o1TaFvsl
         ah3G1+0gGqWac0Wflqi9Q0YJMUogggMQnuzAJ/3qkjjgv2S/P5j0wBD6krb171VwNpAl
         WCH+8E3E+8QBlpX4WZqS6p7/2k0xbBhri3fWHlw9xEnlRHaClVwbactplUpUHj5/NycM
         Ec3Xd9Tnoc9+tW31CalSVwmY0JECIEjejwzQAxdzamBBcHUJLWDvS6WHdoCjUmgmcYa9
         +i05fZ/qjLl5qzOTKERHMl/yNABr4k8LKfRFEXIRT8Bl5HqUznEURR2mHTeVQRxY7Iy+
         4iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829019; x=1777433819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epvGnzFq8uZMGM4fcIZGE8+8PvZa4WBZ1uiBJMM4bHQ=;
        b=MFsyzWnECi939xBdfFgrzcW8SDmyNP4S5hqo2Ki2fTd6Zht8A3rJ+ZSpzbXeqTBdtj
         Y3m8sGg8Kp2F9sJQYGDsaeJGNeDLXq3xZwFM00R4dzW8NB7S7soZeSNxWXm2IQ9ALtMF
         /YqW8hKE7EivCfsQNLMUlc7iXMob90ZhW0nDQ8L36fcJhwHefPSz0MOuIY6MXbl+o18k
         BvKqYB5txaAUhImywA/Dft8MrJ5IxuhX5NC5SoXITaJBOTsI53SkXUOGjR4+wUkrImUe
         wzOCKUCxAeffcQ9ZCsoT7pOF8tTz2ryHj5w9FadSVcgtu5E5ep4XPFmrsknrAtYboLKX
         W4nw==
X-Gm-Message-State: AOJu0YyT2DiQB/l40zMIphPVjecSZyRcF6rRbwXWdTn3tX/TBWAVHYIP
	3bjmK2cCjaYIXgxma78u76ytrdG/ZfTIRlX4MvBgxVx1TZtLGJOVLyh8
X-Gm-Gg: AeBDiesVH6X9tGdp4UcsS3gHeAveXMe2auBhp+UaicYikrvCWeUgmrjHlUvvdYDjUDb
	Gg4aopA/vMVSVip3+X4NBMqnV4SXyPcEiOgDWQOoDx82Wzi+V72LNek9V0fnk6eI+u77RzJLPir
	8ITMKBbR5+pKSHupJDd2rNyYehGQECvLjQdYc3MaNhM6F0njMFlHBZrCoZ2MPRVHYjdeud1Yx5l
	pmUoRR59HWr3hmgsGYfdpLxKVvrL0XLJ/xcHAju2rp4tah9lTk/hn8hqdXZgC2MNOPdR87EGoaS
	mMkYm+AtxM2KrMWrElGEr0Duyfwxi1LvGs9WqReVXHUNf2LwQjgz4xsAS17OEaJqyMU7NbQPpk8
	aejORkxHHFxkSKS76GzTM2tPTfGKNmfRa/Z+F0JrMaDeNkl56VXl8bsq3TwK7wtKMvm8Mt3KNf9
	yalx0eQFJgkGorLZgcshKVl6AOwqZqy0vAN7Nm/aMkxoXZeBwbyRD3d4QmKso8CCrO9dYc7e/HQ
	3ih1RTl
X-Received: by 2002:a05:6a00:4b56:b0:82f:5154:d1d9 with SMTP id d2e1a72fcca58-82f8c82e20dmr19444119b3a.6.1776829018589;
        Tue, 21 Apr 2026 20:36:58 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:36:57 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 0/8] xsk: fix bugs around xsk skb allocation
Date: Wed, 22 Apr 2026 11:36:42 +0800
Message-Id: <20260422033650.68457-1-kerneljasonxing@gmail.com>
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
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
  xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: fix xsk_addrs slab leak on multi-buffer error path
  xsk: don't support AF_XDP on 32-bit architectures

 net/xdp/Kconfig         |  2 +-
 net/xdp/xsk.c           | 31 ++++++++++++++++++++-----------
 net/xdp/xsk_buff_pool.c |  3 +++
 3 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.41.3

