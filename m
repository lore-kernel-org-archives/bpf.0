Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D62D8DC2
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673698; cv=none; b=isGlX9o7GAVbmMqz5giyKDVedpqfbW59UYj9XhUqUc6xLrjmnKW5u6ttjRQvyNGU0fXAr8Rj8Udd0bukt2lQfPnnqxBk7lZt4+X0VnulmNAqSGZqcJrUHh6GD3aR+4MGhCGR0Vr7JSuvhyaNgdKzyorCVhoFsFV/n0olKNS6wEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673698; c=relaxed/simple;
	bh=HzJCBFT618+qO9u307LUokE8hHZ7DtCp7Z25T9rzeHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAH8wI9TV1D4eg45FhwUEcCjZZdDAPTF9SSX+QKRirYUHreEct5Sdr/svZc70FVWHLQPw2yfktrwXWPqwrHo2KYm38ywvKoDJXhq8/t34HmPcghP6+ijOo5P0+Z/uahdfSu44lE6lhESgCw/r19DkL/JlNMfCZXbGuti97g/7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg84gioy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg84gioy"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76b6abdb73so1798588a12.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673697; x=1777278497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2Br3MhZ3tKCh5Kc8JUM53z1zA2qqK3E/yJuKpA65Yw=;
        b=Eg84gioyvG/GF5wOt5LQ3IhvyhhQdbuCGC3jR1EO1SshNKxbQaBlJKfNwKMa0+kwI9
         cTbeH82es78ryuOH9ZpJ1BTr3ZCVbvR16DCpeOqVHskUx5+kReDY1iAiDOWNXsqoHgzu
         hxGD76fd/y2tjUHWNOrBX//O6mokJ4SxTyAS2P2gaiBKB8XEVsxfBVKBWm+YokbBP2f+
         ey9oi3bkdiULRoNsgevRbSfjxeaUPupvCLmL0EoTVYSeVhBChV4KNEa9/VaCqXDWpZBs
         dXIADndaFTWoFcaYRpznIznCjZsgDwli+wv9+ESMwvH/PUZDnrfKK5TaT0JtM9ys7Ecx
         1+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673697; x=1777278497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Br3MhZ3tKCh5Kc8JUM53z1zA2qqK3E/yJuKpA65Yw=;
        b=PubgPXu88vx1g19aiPQbro3YaO0ZAJzv22xNdxK5HT2elCfK8Gph4IWn+9miaRSGpp
         s5DvyzFP2hAsWYzOGpR8lMEtTkS0lMyMh0J1oDCf/egXru9LQZO6yipsWK0B9EGu2Gr9
         i3s6vYUPbUCI40kRSz7yazM+uTLgteTFywj2MNqQbE/v1qBtyMGJ8PsfSaspyWcAGcy2
         y+EkvawyuWlKLiuFt9oI3DWX5L7U9/5AU42RjandEezc/s2ZDY1nJZQkHUywoGIQCrVT
         ACGqlj0ZPCpnLng0HZiUAiecUbT6izTtRNS14TtV3qnKUjEPU05Em+qbcWFjbjT+Mzcv
         f8gw==
X-Gm-Message-State: AOJu0Yzl1p2fPi/67TKylosBYlU6fdDYQ91nEtOKLj9zQ1Gd0muUgxJO
	YmprDPZJgMmgKr3+c3tSQ1sKMpXP0XOn14TkdMlWAV4BoLGuZgcfxxLd
X-Gm-Gg: AeBDievRXlp6Zha2GxRHFFLHRFcve5XHNXJ572um3ZPI3GK3kx7MUxidqXpFUKtoCA9
	dUN6sJeMCdzJH/Esyf6S+oVfIUhpVDvuJliBkRXgTOaVBFAQPasMDCHuBsfwOo6e0zaySpyw1KK
	A4b3owRWQMel2CzFGVbsYApmiLdatejHORsv2sS9sGWhw4I09qq4+itRspbcxVblUzrpV+yXa+T
	r1IBwlQOUb03WzFDjErLHPCCi5MoFTlAeKOB5ntz/AH/ctpNoU63eDdq+/wW3IrPadKRGXWiw+w
	UARKpRXDur6z1Go8/ooPw6PqEYJyMUZZubQtiNep4Mm2b98Fq4vOkhlTAxmEqX6KmP5q43lR9XB
	uJPXRil6xUhAFKAi/8K/IrMWmTmoOWK3EGSih9lK+VQcOPuf5ZMgElQRDdRnKoXwvXo4DOXYh8o
	mq1FMe6UpXn4GRL0q7KspG7VQhC0HHd+iI3cWJ61eyBKyD2LWD797jX4IFNJyu7j+HRKKy9HSbG
	4pHRhWK
X-Received: by 2002:a05:6300:210d:b0:39b:a48e:6a77 with SMTP id adf61e73a8af0-3a08d8e9ce8mr13593889637.37.1776673696624;
        Mon, 20 Apr 2026 01:28:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:15 -0700 (PDT)
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
Subject: [PATCH net v2 0/8] xsk: fix bugs around xsk skb allocation
Date: Mon, 20 Apr 2026 16:27:57 +0800
Message-Id: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
  xsk: fix u64 descriptor address truncation on 32-bit architectures

 net/xdp/xsk.c           | 88 +++++++++++++++++++++++++++++++++--------
 net/xdp/xsk_buff_pool.c |  3 ++
 2 files changed, 75 insertions(+), 16 deletions(-)

-- 
2.41.3

