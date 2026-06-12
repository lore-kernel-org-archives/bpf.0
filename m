Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA023C51D
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226923; cv=none; b=l6QxicnPL7W/SkxCr1rhsCtdD/YwdJw8hK4ZMgzRBWInYzxq0t+l+fuqhG81E7vKag6lmXnVtx9rfA5B//1mwOw3RgOUbsXnlIDh7kclmalrJCem7JIgGuM8Y8y3HMKoOGWnXR8u7qXqqX86w+1c9/eqUV8kp2QV/l8+BC2abk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226923; c=relaxed/simple;
	bh=V5Ji/NbotjurvNaHKkaocD+v8CNqcnqv7GAUeTEbeKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrGbz6bECaxeqdFT4f/J4B7SwvuURP55ZE/UzJleQ7mWUYAi1Gk+HNwCNKNpATeIrEMA+QPEamKv+YeGYrHkT9zAW4jASmbdGikNCs3/wpiN2n8ke316OGopP7I1Vr6tCuqBkX9ld578SZbRr/r5tIP8Gsha/CVZqpMoHzJ6FPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S20/LuN8; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S20/LuN8"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13832028e9fso413944c88.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226920; x=1781831720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lq4yPWnUXbIU2vFF9P4WExiS18HxKoN6rV5qe+S+suM=;
        b=S20/LuN8PPgMvvnqfxT7/IK+q/Cga3NYPnU8pbVahqvR+zZpKnpilHMKvvHoGR6E0C
         gCt+xyEOJc6mDX4BivJlq3slLuSCfYpTVkTaRC+l4rcOwdpBTl8Q9wW+Mmkeqbb5R0G2
         7r22pXT6gag65obcK/9G9GHX5uzkXLiaN0Hn7rNAugs/HCpw/sLq+kpqeDyPKmI683Ph
         Kwu3SONNpLPuFa+LZw8MmAtypuDX7LArdTlS6PXEBQ2/UXxaU75PUCsJnu43JvokPOzf
         91GMioutnhXO2mbuhZnY2vZ2ttk93L3iuPLNj3ui1Z2/R04e+j8LMHfZB7XGOoX6w2Wc
         i1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226920; x=1781831720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq4yPWnUXbIU2vFF9P4WExiS18HxKoN6rV5qe+S+suM=;
        b=VxVnUjuE6EZKXBPGNsZE2tYQWg3WrkHOPiOq4tjxNiZ+7OJI8Pxm96/VCVjL3jmZuM
         EDt5rdxqTy5olnJYAlZYt17Q1OoLYm9vtQdCoqLHJY40FCkFzjOy8nrYXJNzK2F4GmIn
         0BSLafByE0wMp3tOx+vfxhLdelcOLHdhb3NDdBOmtm6nDbM6xXauoJct4xk+bU5UjcSA
         r0x2x/TYFnti7EiLyqMW2GlScxv232TiGsYd1O3Bmj8jUBVxfHBlQ1tiexuP8rzQtoXT
         +msXzdwYvsz41KF1Q4WA06PcOzmV1ZYn4GVCAu/QKozfxl6UYWhanAjqg07PV2hsXU13
         wEvA==
X-Gm-Message-State: AOJu0Yzipua4TImHj8M8vDVZV0xbNflWXzIzhCc2GlL+qWJN29n86b2T
	y8JfG3cXDnP1v9F0gj9O/PHROItjW7uCX0fJweHCJ2HzLmqk//f6xZxo
X-Gm-Gg: Acq92OH6Jyn6dUDcNWK/ISWWlPJCXg53HwuBUCg8sNfQm5Mz89mi4P+3rmo2Qsi7jYo
	xga+YeD2uPtTRxavIpI6H5Oa4Qr3rE/QWl99aFzRsvn5TY3bgH1HEETeJyb+lXXr/+HlzYO0Tgg
	V8UP99DI/Vc+V8tyOS48GAK38wwcoGJmnJ2+9ZWNzMklfQeTS2j1DGIyLeDHCl+6qAWtT3cCSSj
	UhIccy6AXojDXV3+mn6kS69JIfbwXlzN6GK8ciZyvIfjnFyLs901tGFMRGDbbTdhtTA/yz9uiG7
	RimCUPd2+NDJqeQqdn5rI1DtKu8GUu5ZhO1KwEzrsBQyV/bgV7YbkR6mg1W8hL8Xfqlbuux0zR/
	W4UDFLw8P5onmIDmLpeo5enbD1SsTcWS6o7oYwDmhTebS1loBupgz+99Byr/O2Begw/Vb9dZKZi
	Pwm1ovj9a34JtBh16g7VCIJ7pE37XLxGfhlvFGygZdVmobijQO0xgHZ2QjejibHOqf1A==
X-Received: by 2002:a05:7022:41a1:b0:136:5c88:d928 with SMTP id a92af1059eb24-1384bb74299mr276844c88.19.1781226919626;
        Thu, 11 Jun 2026 18:15:19 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:19 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for BPF-paired sockets
Date: Thu, 11 Jun 2026 18:14:47 -0700
Message-ID: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an opportunistic "loopback splice" fast path for two
locally-connected TCP sockets that a sock_ops BPF program pairs at
handshake completion. Once paired, sendmsg copies the user payload into
a per-direction in-kernel byte ring and recvmsg drains it on the other
side; both copies happen in their own task's mm, so the fast path incurs
no skb construction, no softirq, and no TCP protocol-state processing.

The underlying TCP connection stays fully real: sequence numbers are
frozen at post-handshake values, so FIN/RST/keepalive keep flowing
through the normal paths and the pair tears down via a regular close.
Pairing is opt-in per flow and fallback is per-message - handshake-style
traffic takes the TCP path, the bulk phase takes the ring, on the same
socket. Nothing leaves the host and applications need no changes: no new
address family, no LD_PRELOAD, no source modification.

The target use cases are co-located endpoints that speak plain TCP:
 - regular TCP loopback (127.0.0.1) between processes on the same host;
 - container sidecar deployments - e.g. a service-mesh sidecar proxy and
   its application in the same pod, talking over loopback or a veth pair -
   where the per-skb veth+bridge cost is exactly what the ring sidesteps.

Highlights (TCP_RR, 1 KB request/response, netperf, pinned CPUs,
baseline TCP vs splice; full tables across message sizes and TCP_STREAM
in patches 1 and 2):

  loopback (127.0.0.1):
    without busy-poll:   105.8k -> 235.1k tps  (2.2x)
    with busy-poll 50us: 106.1k -> 713.0k tps  (6.7x)

  container (netns + veth + bridge):
    without busy-poll:    99.9k -> 233.9k tps  (2.3x)
    with busy-poll 50us: 100.4k -> 704.9k tps  (7.0x)

Synchronous-RPC (TCP_RR) at a 1 KB message wins ~2.2x without busy
polling and ~6.7x with it (the win grows toward smaller messages and
narrows toward 64 KB), because the ring removes the per-cycle kernel TCP
receive-path cost and the receiver can spin on the ring directly -
loopback delivers via the per-CPU backlog and exposes no pollable
napi_id, so the generic sk_busy_loop() is a no-op there. Bulk streaming
is roughly neutral on bare-metal loopback but wins decisively (up to
~6x) container-to-container, where per-skb veth+bridge cost dominates
the path the ring sidesteps.

---
Cong Wang (5):
  tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback
    splice
  tcp_bpf: busy-poll the splice ring before parking the receiver
  selftests/bpf: add tcp_splice basic round-trip test
  bpf: allow SO_BUSY_POLL in bpf_setsockopt()
  selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog

 include/linux/skmsg.h                         |   9 +
 include/net/tcp.h                             |   8 +
 net/core/filter.c                             |   1 +
 net/core/skmsg.c                              |   3 +
 net/ipv4/tcp_bpf.c                            | 847 +++++++++++++++++-
 .../selftests/bpf/prog_tests/tcp_splice.c     | 206 +++++
 .../selftests/bpf/progs/test_tcp_splice.c     | 125 +++
 7 files changed, 1198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_splice.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_splice.c


base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
-- 
2.43.0

