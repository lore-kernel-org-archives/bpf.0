Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0934D91F
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437768; cv=none; b=tBFaw5lZnkygixtZsIMeyq7tyrEfRjw7X5Oe/u4+xyxFMUfmB69icXLReEux6zc/HhZfKQL/0hCPTaor0fTDf08f/+Kq4oh6LelGNDnR0QBYOihfra3I1YaKQwKA9cPdlLXXhQ9Ok9xL0x3zeWOZvzICa5xhRDwPX0v4Iv0gTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437768; c=relaxed/simple;
	bh=mKsrCh3EyX3MUTl4GQOQjkWr281KRW5O9fMV2Rz1s3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rzVyV9ep6998i090agtsPMWgq5n2mfOPVQBVgQlOFtxUfpKW9cn8XMvZBfL5ajFZ+KYXO29Ab6C3z8wg0iGAza3ox3j6lfB5WblXxbRCs6+0rWRxr3IGZFhXLAyjnXJeIdTDnKf4Nj8D4G4fpkaxkZnxytzQijhGJBM3C4lOaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pqa2F3R3; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqa2F3R3"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-80032c08611so1393045a34.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437759; x=1791042559; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OTM22SPEfYbup+eJl54RMv9g4/2KoGUSINo9By/OkIU=;
        b=Pqa2F3R3b7sAw+DnrFnDwhoDPKcL9Nq3tTNzzct1OP/y+2Uw0Ej/krbccGnA8lxaIC
         B8WCF1H946xm4YAEUxo/ZBLrXoeOM2yxmFkIFWXTf5+2oMRyLjEbBa1f/NcxLVmsvqNx
         gcMfG6hE95jkuPzL/G63qyJMqjk157CueMncAzphlH2GcZq2cYkC72zLfnp2KTxvMZ4i
         Q2iLNG98gEPyXU4LschLtqjd1G6fsNDsl0jjayA/Nu99XAVb4GrOzbgrsvejH8kxHq2D
         qTcIM8HJkJy6AXiUJc37Lcp9TOwSPLzrHbOqmo6jm4g2g/wHG3OmZRJ1ib/LkpMPniM7
         xmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437759; x=1791042559;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OTM22SPEfYbup+eJl54RMv9g4/2KoGUSINo9By/OkIU=;
        b=qY9xCun7ZcuIZftj+8/cc58aUftK44zrEzcsQfA/ht9AfzPSEQ4xcbZQTFiS08gplr
         tUiQrEwJJ/5cjv5n5zsmu1/6NlcgjB32YCrRHJkuBZYgIjxDdGxw9MEk5z/fnpNNDZjH
         2oT2mYl/Bywfr/TLe+Udwl582Ti/UKv/7SulMDitNO/zf4saC31ZgartdETlnNEsX3aU
         ghTae6pbZyf6I/reJaRFnexcFR+vPJ0an50wJoyyI0VioTh4YmRdcLmf7F1dJoDyOVV1
         OCogFgky6Shd2OoOsjN5WhT9rXsGZJY3FDf/G8LvPn1cTkuRsH+PecfWWLyBYoQLAmF6
         Cjcw==
X-Forwarded-Encrypted: i=1; AKwUvBwEIUbgb39yd4dMYffNssW8y7AsTns0DsCNq5yt7fMAxlY7o2JaqaQxJOOqzvteUAGYxF8=@vger.kernel.org
X-Gm-Message-State: AFuF++kRkbnZB2N3gq8SbivzSca07PykfbdjZ9NCZ+PtjxEb5MSEToLw
	Sw9ecibsynxpgjjR5HA09EXUjk877Nkffd99WWHWxNrxqca+VeidfFBz
X-Gm-Gg: AYBFou2acJt+remfJOGcsXpD1LQo4/NSkotpmS7LZO38yUR5jXsYQw+ETnUqMyYkWIm
	/bU3d5AYqlQUf58aaPlfw/+0EG7IHOH6shTVUrDKvg/LaVMmTWXt+tAZwrSJ6dHnWQSxU59425N
	yG9nQ7spy5N7JPizLOC5mGxhHHEShaoC4q5ejV6KSG4PdHrx7r99QXRfO0B3dtkmkk/FarzRQoc
	1e4F5JbW40XKbD9dsKF+PPKOkq1niK0jypwxDz6H4Ca1mowIEtY6KM+RBCVVXh+qB0mC1ekmDY0
	hzGl7AZgTt/R9g0xEzyDL6RKsO9MihoFEISOHDRRseXZwqaNEGoJeNmlpoXyu7k7UeqfymG7Loa
	rBfF0sjz0lZOKoj24+q4iMojuHOL5tjNtoxOfok7lyjzeRrK6evwValoNO8m868OKHf1eVIJ1dY
	R6xllJmrYzMRxPZkjfjfTyWF11ibrhCIAmSpNeWBG5v3LRmGIeoY8XEf13EU6uMJZ+JudmlaeVp
	33gbUg8iOE5dSjSRPmASFofaqxjSbObNeViTELCh9aQUE35e/p4zLBN31eaRKjVOeDjQDNJ/qTt
	o7RRt5/ilwE0kBllT24kzK30lLmvNHL5sA0W8jN7J7lQ13gxoO1q8rVD3W9Wk0dbiNls9esyOiT
	vdx9GLBt1o9ZlJqW4yiy3
X-Received: by 2002:a05:6830:6202:b0:815:831e:af5d with SMTP id 46e09a7af769-81780d8fcd1mr8845185a34.5.1790437758611;
        Sat, 26 Sep 2026 08:49:18 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v4 00/15] net: stmmac: preserve datapath state across
 MTU and resume failures
Date: Sat, 26 Sep 2026 09:48:55 -0600
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwQ6CMAwG4FchOzszOgLMk+9hPIxRYMaB2SbRE
 N7dghfiBZNe2v752okF9BYDOyUT8zjaYIeemuyQMNPpvkVua+oZCMiFgpSHZ+Vs5CE6pw33GDD
 yxr4w8DHlhVFlpaAGpRUj4uFx3ZFwYT1Gdv0OCbmhiQu8xDob4uDf6xNjuob/u0cleFnoDDOZI
 gpxbp2296MZ3HpqhC0GOxgQVitAylaoVP6LyS2W7WCSMCPoK9lIDSVssXmePxmEzJZ5AQAA
X-Change-ID: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>, 
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.15.2

Keep the stmmac datapath coherent after failed MTU changes or hardware
resume without changing the interface's administrative state. Retain the
working MTU configuration for rollback, and allow ordinary down/up recovery
when hardware cannot be restored.

The fifteen patches put independent fixes and lifetime prerequisites ahead
of the retained-ring MTU transaction:

  1. Correct the WoL/safety IRQ unwind order.
  2. Reuse the MDIO reset GPIO across repeated resets.
  3. Allow phylink_stop() to finish a suspended instance.
  4. Freeze deferred AF_XDP pool teardown before device system suspend.
  5. Serialize PHC changes and cache reset-sensitive timestamp settings.
  6. Keep normal-size MTU changes running, including supported AF_XDP MTUs.
  7. Unwind partial DMA allocations and fix saved RX skb ownership.
  8. Keep DMA configurations and IRQ contexts at stable addresses, and
     drain timer producers before cancelling their timers.
  9. Track datapath and power ownership across MTU, XDP and ethtool reopen
     failures, including noirq clock handling and unpowered-access guards.
 10. Use the tracked restart for XSK pool changes.
 11. Restore TC filters, steering, preemption mapping and EST before DMA.
 12. Allow independent references to AF_XDP DMA mappings and UMEM pages.
 13. Retain DMA memory until hardware confirms shutdown or reset.
 14. Prepare device-local interrupt masking and DMA-handler quiescence.
 15. Retain rings and IRQ registrations across jumbo MTU replacement.

The ownership transition and its XDP, ethtool and PM consumers land
together, so resource cleanup does not precede the power-access guards it
requires. The larger DMA shutdown change precedes MTU rollback, rather
than leaving early retained-ring commits with unsafe teardown paths.

The ownership states remain distinct: DOWN owns no IRQs or enabled NAPI;
RUNNING has active queues; SUSPENDED retains rings and IRQs; HALTED retains
rings but has released IRQs after failed MTU rollback. Collapsing the last
two states would make close free IRQs which it no longer owns. DMA memory
ownership is tracked separately: a failed shutdown can retain allocations
even in DOWN until hardware acknowledges a successful reset.

Jumbo rollback allocates no new buffers or IRQ registrations. RX holes are
filled before reset without changing the old descriptors; descriptors are
rebuilt or retired only after reset succeeds. If rollback also fails, the
interface remains detached until down/up recovery. This cannot guarantee
recovery from indefinitely failing hardware.

Failed interfaces still receive hardware/PHY sleep handling. A failed
datapath with MAC WoL configured rejects suspend with -EBUSY because its
wake path is unusable; PHY-only WoL is not rejected. Timestamp filters and
PHC registration survive an MTU change. Replay the platform PTP clock selector,
frequency correction, PEROUT and EXTTS settings after reset; continuous PHC
time across the reset is not preserved.

Live XDP and ethtool failures leave the administratively-up interface
detached for ordinary down/up recovery. Program attachment failures return
an error without consuming the proposed program. BPF-link and XSK-pool
removal still complete if their datapath restart fails, so teardown can
release the program or pool safely. AF_XDP pool reconfiguration now pauses
all queues and replays the MAC link while rebuilding the rings. Successful
reconfiguration leaves the PHY running rather than powering it down and
restarting autonegotiation. All queues and other sockets are still paused
while their rings are rebuilt. A failed restart stops phylink without
reconfiguring the failed MAC, then permits ordinary down/up recovery.

Close and live XDP/XSK release now require stopped DMA process states
or a completed global reset before releasing DMA memory. Unsupported
idle-register layouts, including XGMAC and GMAC4 with more than three
channels, use the reset fallback. Replay cached L3/L4 filters, EtherType
steering, VLAN priority, preemption/TC mapping, PTP settings and EST before
starting DMA. Replay failure enters the existing rollback or detached
recovery path. Reset does not preserve continuous PHC time.

If shutdown and reset both fail, retain rings, mappings and backing memory.
AF_XDP pool teardown still completes, with independent references keeping
its DMA mapping and UMEM pages alive. A later successful down/up reset
reclaims them. There is no generic isolation guarantee for permanently
unresponsive hardware: removal reports and retains unsafe DMA allocations,
which may therefore remain pinned until reboot.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Reorder prerequisites ahead of their consumers. Separate the independent
  MDIO GPIO fix and PHC/IRQ preparation, and combine datapath ownership with
  the XDP, ethtool and PM paths which must observe it. Keep MTU rollback last.
- Replay cached TC filters, steering, preemption mapping and EST after reset,
  with DMA held stopped until replay succeeds. Preserve the previous cached
  rule on installation failure and advance EST base time by whole cycles.
- Validate TAPRIO replacements without modifying the installed schedule;
  reject failed PHC reads and retain a valid cache after setup failure.
- Keep control operations from accessing unpowered registers after close
  reattaches the netdev. Permit software-only VLAN, qdisc and TC filter
  removal, and preserve open-time power recovery. Remove cached flower,
  steering and u32 rules while down or detached so reset cannot replay
  filters which TC has already deleted.
- Use phylink link replay for live XDP/XSK updates, leaving the PHY running
  on success and balancing replay with phylink_stop() on failed restart.
- Require a hardware idle acknowledgement or completed reset before DMA
  memory retirement on close, XDP/XSK replacement and failed open. Retain
  failed configurations for recovery, and defer IRQ TX recovery and resume
  descriptor rebuilding until shutdown/reset is confirmed.
- Add independent AF_XDP mapping/UMEM references so pool teardown can
  complete without unmapping DMA-visible memory after a shutdown failure.
  Document reset fallback and permanent-failure memory retention.
- Keep shared IRQ controller lines enabled during MTU replacement. Mask DMA
  sources at the device, protect DMA-handler quiescence with the channel
  lock, and drain registered handlers with synchronize_irq().
- Preserve pending DMA status while quiesced, including when hardware setup
  restores interrupt enables. Restore saved masks on restart and leave DMA
  sources masked when failed rollback releases the driver's IRQ handlers.
- Reuse the final TX queue and timer drain after synchronizing IRQ handlers.
- Restore saved RX skb ownership immediately when taking partial receive
  state, including a budget-one completion and a DMA-owned next descriptor.
- Cancel the EEE software timer after draining NAPI, and make GSO feature
  checks use stable platform TBS capabilities rather than replaceable rings.
- Reuse the MDIO reset GPIO acquired at probe and reject TC queue work when
  the datapath is not running, except for software-only filter deletion.
- Let carrier-down XSK TX polls complete instead of continuously repolling,
  and remove the unused external XSK wakeup declaration.
- Stop a PHY powered by prepare_resume() after failed ethtool setup. Publish
  core queue counts transactionally only after the fallible open work.
- Initialize rollback RX addresses before publishing descriptor ownership.
  Restore the platform PTP clock selection, frequency adjustment, PEROUT and
  EXTTS settings; serialize PHC/devlink access across reset and reject access
  to a failed retained clock.
- Freeze deferred XSK pool teardown before device PM. Track platform power,
  pending clock restoration and actual PTP clock ownership separately from
  the datapath. Avoid unpowered MAC/MDIO accesses on failed close-time
  recovery and balance clocks even after a noirq resume failure.
- Check unusable MAC WoL before the pending-sleep shortcut, and update
  comments for HALTED ownership and the ethtool reopen path.
- Link to v3: https://patch.msgid.link/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com

Changes in v3:
- Snapshot debugfs queue counts under RTNL with the descriptor ownership
  check, so a reader blocked behind channel shrink uses the new topology.
- Complete pending core sleep state during close and retry restoration on
  open after runtime-PM acquisition. Use the installed wake state rather
  than mutable WoL settings, and retain the pending marker if restoration
  fails.
- Put the independent IRQ unwind fix first, ahead of the ownership changes.
- Correct the WoL/safety IRQ unwind order, fixing a repeated safety IRQ
  free and a leaked WoL handler.
- Account for live XDP release/reopen in datapath ownership. Stop DMA on
  late IRQ failure, propagate program-attach errors without losing program
  references, and allow BPF-link removal to complete after restart failure.
- Replace the void AF_XDP queue-enable helpers with the tracked XDP restart.
  Unmap a removed pool only after freeing its rings, undo failed pool
  attachment, and preserve TBS configuration while rebuilding the channels.
- Keep PHY/PM ownership across ethtool ring/channel changes, restoring the
  old configuration after failed reopening and leaving the interface
  detached for down/up recovery without a second runtime-PM put.
  Explicitly disable the MAC during release even when link resolution has
  not reached mac_link_up().
- Split the MTU work into normal-size MTU handling, allocation unwind,
  stable DMA/IRQ ownership (including timer lifetime), and the retained-ring
  transaction. Keep the ownership change and its open/error-path adaptations
  in the same patch.
- Restore the PHY advertisement reduced by phylink_suspend() when stopping
  a suspended instance, without restarting or reconfiguring the MAC, in
  response to Andrew Lunn.
- Keep suspend-owned PHY speed control separate from explicit driver
  speed-down requests, so close-time power saving does not overwrite the
  original advertisement and remains effective until the matching speed-up.
- Suspend a stopped PHY powered back up by phylink_prepare_resume() when
  stopping after a failed MAC resume, without repeating phy_stop().
- Add a separate MTU transaction patch retaining old DMA resources and IRQ
  registrations until replacement succeeds, following Andrew Lunn's request
  to keep the old setup for failure recovery.
- Keep DMA configuration objects at stable addresses and use persistent
  channel objects for per-queue interrupt contexts.
- Drain transmitters and post-completion NAPI poll tails before cancelling
  TX timers.
- Avoid resetting normal-size MTU changes, including all supported AF_XDP
  MTUs, and stop rebinding live pools through temporary RXQ objects.
- Program the new MAC receive limit before activation and restore the old
  MTU on failure; refill old RX buffer holes before reset so rollback does
  not require allocation.
- Preserve coalescing, TBS state, PHC registration and timestamp filters;
  leave a failed rollback detached with old rings retained for close.
- Harden partial-allocation unwind.
- Separate core sleep completion from datapath ownership so failed MTU and
  resume paths still receive hardware PM handling, without disabling NAPI
  twice or restarting released queues. Address the skipped-suspend issue
  reported by Sashiko; reject an unusable MAC WoL path with -EBUSY.
- Balance platform noirq PTP clock handling against resources still owned
  after detached XDP cleanup.
- Link to v2: https://patch.msgid.link/20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com

Changes in v2:
- Drop forced netif_close() and retain the interface's administrative state,
  as requested by Maxime Chevallier.
- Separate queue quiescence from resource release and use explicit datapath
  state instead of a napi_disabled argument to the release helper.
- Handle repeated suspend/resume after failure, preserve PHY/PM ownership
  until ordinary close, and allow a fresh down/up recovery.
- Check XDP/AF_XDP cleanup, descriptor readback and asynchronous reset work
  while the netdev is administratively up but unavailable.
- Explain the generic phylink suspend-to-stop transition and why restarting
  phylink after a failed MAC resume is not a valid substitute, in response
  to Andrew Lunn.
- Combine the two stmmac error-path fixes so every user of the new state
  has consistent resource and NAPI lifetime handling in one patch.
- Link to v1: https://patch.msgid.link/20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com

To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Serge Semin <fancer.lancer@gmail.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: Russell King <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Joakim Zhang <qiangqing.zhang@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Richard Cochran <richardcochran@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ong Boon Leong <boon.leong.ong@intel.com>
To: Voon Weifeng <weifeng.voon@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Linus Walleij <linusw@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Simon Horman <horms@kernel.org>
To: Björn Töpel <bjorn@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
To: Jonathan Hunter <jonathanh@nvidia.com>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev

---
James Hilliard (15):
      net: stmmac: unwind the WoL IRQ after a safety IRQ request failure
      net: stmmac: reuse the MDIO reset GPIO on resume
      net: phylink: allow stopping a suspended instance
      xsk: freeze deferred pool teardown during system sleep
      net: stmmac: serialize and retain PHC configuration across reset
      net: stmmac: leave the datapath running for normal-size MTU changes
      net: stmmac: unwind partially allocated DMA configurations
      net: stmmac: keep DMA configurations at stable addresses
      net: stmmac: track datapath and power ownership across failed reopening
      net: stmmac: use the tracked datapath restart for XSK pool changes
      net: stmmac: restore TC offloads before restarting DMA
      xsk: allow drivers to retain DMA mappings independently of pools
      net: stmmac: retain DMA memory until hardware shutdown completes
      net: stmmac: prepare device-local DMA interrupt quiescence
      net: stmmac: retain DMA resources across MTU changes

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   28 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |    5 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    4 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |    8 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   29 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |    4 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |   30 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   11 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |    9 +
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |    4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   64 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   15 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |    1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 1720 ++++++++++++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   33 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |    3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   38 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  131 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  376 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |   83 +-
 drivers/net/phy/phylink.c                          |   51 +-
 include/net/xdp_sock_drv.h                         |   23 +
 include/net/xsk_buff_pool.h                        |    4 +
 net/xdp/xsk_buff_pool.c                            |   53 +-
 29 files changed, 2049 insertions(+), 702 deletions(-)
---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

