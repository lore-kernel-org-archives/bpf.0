Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488D3E172E
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186945; cv=none; b=FNE28VhmZE8FdHXTikGE5XKITju3smP7Und/XSh3JAbULLwvKyfPo9Bjdu6I9nrGJVQG9SOovv2nBl7Nb5ccEPdgNAOUv3xmICuULWLjU8QVtOI+epFIl67QogQoqXyvHvzTH8nihug31JRc+DEDzbbyeYNp+eiT3DXbiSTi9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186945; c=relaxed/simple;
	bh=62QewY8KkfyjdPNNnQBNYJvt2p5rQ2ylV0efsEeoc9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2UPn0w+R4rwuVpRK52EcPLl7OyMZPRo3ij8hcDthWgDmH6if1N913Cg+rcpMvy3tevHIsYHCx7GDbPacIp4OTDzg8yY++YJZZJ+PumyUhBvEvRdtWoEUTTRn7bxtCAGzjCz975JLrxn+BEuKiqLd31HYSG+qRWc2Gep3jMlBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wl2J2jC3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Wl2J2jC3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so5074995e9.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792186942; x=1792791742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBnYf4wt1Qj8g48kRKmfziM0ACqZw9/m994SOb4UJnU=;
        b=Wl2J2jC3MR89eD6z64m5FVmY5gtFPWEjdp5uGjsNsyRFl7oC25Gvt17g7+ZuiaLnYS
         kJwCaG1aK7WTTGeNKfKHz6I+/VpYzYJi/wi/2XU3VtLiiLYz4lN3RU7TlvPoHZWlvy0H
         AmQdhqoDXfB05yoo5elqENjlQe4McrTef3+bz2Es/VGgc4phKfbDE96zoTLbmIHCkI3w
         v7q2V4mbw+3tskcywZhZwoj/gspfWeAfM8d9Fpfk1pks8OJvJZmMkMDeMUUncj30G28H
         ZaORms6QFaMHz/JQ+ge1Lih7l/HkxcP5SRMuqMVdgwVuj49U1jftoIvbdFP5ZY2k7Vm1
         wxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186942; x=1792791742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBnYf4wt1Qj8g48kRKmfziM0ACqZw9/m994SOb4UJnU=;
        b=q473aWAYuWoegnMBinxaEO2oSjc8dWsCKwo4r86xhaTVgabN/9r7Kquig9D207Imfd
         gOzgNhZLd8v3IuwJ1m+IOk2FLJe+ZBnfOxtkcpovwimDyKe/6h4oZgDJ8wl3zAW/Mol5
         Kh4CjE3HboSBbQaIiT1LV6onJqBS/3MrrktP8rcvc/W3GxX/FAXjswIl7+KjWumFQ2kW
         jxMxqPoUz1sAycUMOlhopAn+5w4t+60tvg2kTENjp2b0YVtRB+xCsIccmeBEoww6p8dP
         IYSgiDuK1YZML9mhadz5+B2tnFt1l9woRAb95fWMpgxxbo0HN4IF8F7al97GGbOicblX
         Ee2A==
X-Forwarded-Encrypted: i=1; AKwUvBw4WdIQwVKG9BsMn8T66D3cqylUmcVkxOLGE1BVPl7I+qI1zvrj7eYdRmvTnca3cT86CwM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpUtYHK0PKn4ucD8nQK1OLJdWSFHMtaETKwbuw7vA2KG0ehHCD
	+MuQ3ZFRbswsCuOVoi0bNBkHRx4g4zaM0aHg7iXi3FmX4+mpjj3E9TjGUxKDln1Hxp8=
X-Gm-Gg: AYBFou2O4PS0L4wo8EorZCsPvFvi/381NGsJeJr/DqtyvdgVUOInxtTGDycLu/Sjr2q
	8A8bXwKEe3xgEQ9F67CLiopshwPXJNdwUhLwsmS0qTZrmIHpjm23FbxLJhXvJ2gDbFfbJAY7l+v
	xiEYsRzNjHGKXZs9YXvRMAKTWe4Zfz4BLJss3w1OJScdPMm36KV4EGv0iYlUHDD/Zge4kq8OI+9
	7zdp6OJzOxcTNhZzHqaPf5jZgR3gPNti9ggD4GzT/ubAqAdeNzUXaFqdvWp3z5fllrqFWvWnwvf
	3xlcbOFZVlhMPtLPGpcx02CpvZVrOQYMbXoUVOEUI72oIozJF9Kt0/EkRG2PaH77hSIPrfDmCfo
	8XBihq9kJYVQSfDcgitsoCUNFErluxcqgU+bSRH5JPeb0FTEuoHSJ3hGrlFo3RBCVXKGcsZOgMS
	6R6YosGooxNL3WXwa9CDWpe/2HGEEriIb4MGc0oI5oNCucQcPGgcR2TPw3ThWCBsoaRPA5SN6Im
	9tE7BUIg6rziDNgcQ==
X-Received: by 2002:a05:600c:1d10:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4a1d75ce2e7mr23926225e9.1.1792186942188;
        Fri, 16 Oct 2026 14:42:22 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:ec8::179:190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm7975417f8f.34.2026.10.16.14.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 14:42:20 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	bochaolucky@gmail.com,
	toshiaki.makita1@gmail.com,
	lorenzo@kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 0/2] veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled
Date: Fri, 16 Oct 2026 22:42:15 +0100
Message-ID: <20261016214217.16942-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an XDP program on a veth device returns XDP_TX and the peer has
GRO enabled but no XDP program, the frames are queued on the peer's
ring, but the peer's NAPI is never scheduled to process them. Once the
ring is full, every XDP_TX frame is dropped.

Commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before
xmit of XDP frame") made such a peer work as an XDP_REDIRECT target,
where veth_xdp_xmit() both queues the frames and schedules the peer's
NAPI. XDP_TX queues its frames through the same function but schedules
the NAPI in veth_xdp_flush(), which still checks xdp_prog.

The usual workaround is to load a dummy XDP program on the peer [1].
That turns off TSO on the device, and every skb it sends then goes
through the peer's XDP path, where most of them are copied. In our
tests, TCP sent from a namespace dropped from 22.1 to 14.8 Gbit/s with
the dummy program. With this fix the program is no longer needed.

Patch 1 makes veth_xdp_flush() check the peer's napi pointer, as
veth_xdp_xmit() does. Patch 2 adds a test for this case to veth.sh.

[1] https://lore.kernel.org/all/fb2d324b-35fb-802d-2e1d-1ee1aa234c16@gmail.com/

---
Bochao Cao's migration of the XDP feature test [2] skips XDP_TX on veth
when the peer has no XDP program, which is the case patch 1 fixes.

[2] https://lore.kernel.org/netdev/20261010-xdp-v5-send-20261008-v5-0-de687cb67c40@gmail.com/

Tianyi Gao (2):
  veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled
  selftests: net: veth: test XDP_TX to a peer with GRO enabled

 drivers/net/veth.c                            |  2 +-
 .../testing/selftests/net/lib/xdp_dummy.bpf.c |  6 +++++
 tools/testing/selftests/net/veth.sh           | 25 +++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)


base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
-- 
2.55.0

