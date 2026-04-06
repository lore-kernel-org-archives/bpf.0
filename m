Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072BDF59;
	Mon,  6 Apr 2026 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775464598; cv=none; b=iNYNiFtxuyLbBKrcqUOm6rHEjd6UZJHpxPj5reDGdGyiQzziAooXmxO5XpNxtO4ZCSEoq8KUdJ/5fohwluhvyDMh9nq2SINdB/WPoJaXXO1bYtsDJ+CsNI4TWep691aHgsubMWxjeAku/bFv0fxiNdc6EaYrMM9k4pkoQ0Qn5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775464598; c=relaxed/simple;
	bh=OeLB3u3hU0cSTmDTYfAGoOEaiP5YiR8JOo7wSL7r33A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhDbpqvblA0kHpNbdX5ZbTJnNXVTE01ssTXEkUN3SxHXHx1kfdzYFSrj3L/GlPbSbWGZfPVjr/9Sk8UIUtaKZaT5drObdF6dqGr3EwEzJtzIISX7yZfhRWIPXBRbXpoQMCoJsVmh+6oCgqAhNL3ixOW179lWZdS8nSijTWlvFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cEHCjmo9; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cEHCjmo9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A750A26FD;
	Mon,  6 Apr 2026 10:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775464589; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=gywS/cJqCcJZuCFcZd+ncFv6nmplC2clIcSgdxsA4ng=;
	b=cEHCjmo9QwIg/+7Ng8YrnskaPO6izfQ1Q2M2QkOyTB9R7TQlfDdPWPnim8QselPbsKXZgy
	cChnrlS4DhcBjRSjzD0CnulcwDJnY1L+s8tsB5RtUdLK9eo464E1Bo1AnBGffkVAfPrCgu
	IRSqVqq/Y/PKTs7t+IR3RqprtfgTtvXSaDYuxS2ub+EYq801AL4cPmKdU+wezJGaQ88rjc
	FL/jrR5fP5AuWRUrT4/MMRqd0Cqz4JVAnpwj05yX8lgdcxSAPCoN76fe3jGOesyvByuR2l
	IPTW4MXYPqo17m5NtphgBf065tUWTCxBvqlrDybNd1NAkftiy0dojEyzFWSemg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v6 0/7] net: bcmgenet: add XDP support
Date: Mon,  6 Apr 2026 10:35:24 +0200
Message-ID: <20260406083536.839517-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.

The first patch converts the RX path from the existing kmalloc-based
allocation to page_pool, which is a prerequisite for XDP. The remaining
patches incrementally add XDP functionality and per-action statistics.

Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
- XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
- XDP_PASS latency: 0.164ms avg, 0% packet loss
- XDP_DROP: all inbound traffic blocked as expected
- XDP_TX: TX counter increments (packet reflection working)
- Link flap with XDP attached: no errors
- Program swap under iperf3 load: no errors
- Upstream XDP selftests (xdp.py): pass_sb, drop_sb, tx_sb passing
- XDP-based EtherCAT master (~37 kHz cycle rate, all packet processing
  in BPF/XDP), stable over multiple days

Previous versions:
  v5: https://lore.kernel.org/netdev/20260328230513.415790-1-nb@tipi-net.de/
  v4: https://lore.kernel.org/netdev/20260323120539.136029-1-nb@tipi-net.de/
  v3: https://lore.kernel.org/netdev/20260319115402.353509-1-nb@tipi-net.de/
  v2: https://lore.kernel.org/netdev/20260315214914.1555777-1-nb@tipi-net.de/
  v1: https://lore.kernel.org/netdev/20260313092101.1344954-1-nb@tipi-net.de/

Changes since v5:
  - Refactored desc_rx: always prepare xdp_buff and use
    bcmgenet_xdp_build_skb for both XDP and non-XDP paths, treating
    no-prog as XDP_PASS. (Jakub Kicinski)
  - Removed synchronize_net() before bpf_prog_put(), RCU handles
    the grace period. (Jakub Kicinski)
  - Save status->rx_csum before running XDP program to prevent
    bpf_xdp_adjust_head from corrupting the RSB checksum.
    (Jakub Kicinski)
  - Tightened TSB headroom check to include sizeof(struct xdp_frame).
    (Jakub Kicinski)
  - Fixed reclaim gating: check for pending frames on the XDP TX ring
    instead of priv->xdp_prog, so in-flight frames are still reclaimed
    after XDP program detach. (Jakub Kicinski)
  - Removed dead len -= ETH_FCS_LEN in patch 1. (Mohsin Bashir)
  - Added patch 7: minimal ndo_change_mtu that rejects MTU values
    incompatible with XDP when a program is attached. (Mohsin Bashir,
    Florian Fainelli)

Changes since v4:
  - Fixed unused variable warning: moved tx_ring declaration from
    patch 4 to patch 5 where it is first used. (Jakub Kicinski)

Changes since v3:
  - Fixed xdp_prepare_buff() called with meta_valid=false, causing
    bcmgenet_xdp_build_skb() to compute metasize=UINT_MAX and corrupt
    skb meta_len. Now passes true. (Simon Horman)
  - Removed bcmgenet_dump_tx_queue() for ring 16 in bcmgenet_timeout().
    Ring 16 has no netdev TX queue, so netdev_get_tx_queue(dev, 16)
    accessed beyond the allocated _tx array. (Simon Horman)
  - Fixed checkpatch alignment warnings in patches 4 and 5.

Changes since v2:
  - Fixed page leak on partial bcmgenet_alloc_rx_buffers() failure:
    free already-allocated rx_cbs before destroying page pool.
    (Simon Horman)
  - Fixed GENET_Q16_TX_BD_CNT defined as 64 instead of 32.
    (Simon Horman)
  - Moved XDP TX ring to a separate struct member (xdp_tx_ring)
    instead of expanding tx_rings[] to DESC_INDEX+1. (Justin Chen)
  - Added synchronize_net() before bpf_prog_put() in XDP prog swap.
  - Removed goto drop_page inside switch; inlined page_pool_put
    calls in each failure path. (Justin Chen)
  - Removed unnecessary curly braces around case XDP_TX. (Justin Chen)
  - Moved int err hoisting from patch 2 to patch 1. (Justin Chen)
  - Kept return type on same line as function name, per driver
    convention. (Justin Chen)
  - XDP TX packets/bytes now counted in TX reclaim for standard
    network statistics.

Changes since v1:
  - Fixed tx_rings[DESC_INDEX] out-of-bounds access. Expanded array
    to DESC_INDEX+1 and initialized ring 16 with dedicated BDs.
  - Use ring 16 (hardware default descriptor ring) for XDP TX,
    isolating from normal SKB TX queues.
  - Piggyback ring 16 TX completion on RX NAPI poll (INTRL2_1 bit
    collision with RX ring 0).
  - Fixed ring 16 TX reclaim: skip INTRL2_1 clear, skip BQL
    completion, use non-destructive reclaim in RX poll path.
  - Prepend zeroed TSB before XDP TX frame data (TBUF_64B_EN requires
    64-byte struct status_64 prefix on all TX buffers).
  - Tested with upstream XDP selftests (xdp.py): pass_sb, drop_sb,
    tx_sb all passing. The multi-buffer tests (pass_mb, drop_mb,
    tx_mb) fail because bcmgenet does not support jumbo frames /
    MTU changes; I plan to add ndo_change_mtu support in a follow-up
    series.

Nicolai Buchwitz (7):
  net: bcmgenet: convert RX path to page_pool
  net: bcmgenet: register xdp_rxq_info for each RX ring
  net: bcmgenet: add basic XDP support (PASS/DROP)
  net: bcmgenet: add XDP_TX support
  net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
  net: bcmgenet: add XDP statistics counters
  net: bcmgenet: reject MTU changes incompatible with XDP

 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 643 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  19 +
 3 files changed, 565 insertions(+), 98 deletions(-)

--
2.51.0

