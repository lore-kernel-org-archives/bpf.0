Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8924582FF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271879; cv=none; b=ijtjVtSNmWWYfWirGK83q+vffeR6yLQ45quj0m1cSNRCWlfXBqlkYhiRA4RO5j/DDtae+Vmv+VdZxVbyQlE9xpP4NQL7Ll1Mv0C130GKuWRQSEVEsCLDe+jhxjkW5tKrRgBZNMmR9eOt8C6y93Aq3swq/KO4rcyFP3onzmsFIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271879; c=relaxed/simple;
	bh=7XmKKcJx3+9gJOrs3+82dw4o/KYQ1Xfg/FTkZC0fgig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hUr2YZlpgvrjomBUmaHdbVxerXr00IEOoCjojU5e5Hu9gZ6c5YfnaGyvGyz/u2G95gZ6dN3UXt3xTGAR4jZge9ktuBDysw0BluwhoQI+E/LFccDOwDdGJw9p13Mu01Q5Nd5jOxr1tEh0YVxx1KRYNf9qVaH6dccpf9nh3OIM6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azfct/tU; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azfct/tU"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b9cb8883ecso76148eaf.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271875; x=1790876675; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m/yuadhswZztFZIXp8O1C3rG4scLLGx4YqdmEAm1GxE=;
        b=azfct/tUP8UKAlCNTtkHerRTzmzo5baoL+tG/sYCUY6g3BgLF3Clq1k8S/J0OnM79i
         iA5zlArFpHfJg2fZBM6kbhKV1g4MEMrcg9Ci2Ku9tjwM7KsB07t26p1kFvjOYe39kFrZ
         2N+TA8azK463/mWRZoIaYT6VRshc6PdvN2FfY4JbEPNNOBcQa6Bli+k4SktM3VQVCzSH
         SFnjfYDgqFsfg2MEqcu6VbHxkl2vSNM5fmy8XTTdHjx/4XGX0KIY1jMuS7Ys+XP6yjzi
         F7c3iy5cdNkDWiQFQyUHKJGhMkt9+hnuY9m2wzrZPVawc0X35wGRya8y0mLRJSXYW2qG
         czwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271875; x=1790876675;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m/yuadhswZztFZIXp8O1C3rG4scLLGx4YqdmEAm1GxE=;
        b=xzlHMJj2UcZPEp742Jk1S8qmh7Lj/+2iCcnB3CmzxGCnvwv3/lzhOHS3w1WP3AmvOq
         ntiMZaUPKoG37XLeZuyk1QTmIXrXef5iyLK0O72xdtCNbh4C5Ef7xuTJd24NCWuU2a/0
         mBL6Eh4P6WDdgwjNGbmiuFW+G8J91PePdXK8Ty+HbmSL2CnmHeMn9zVLcLWQAMT1aSB4
         lEkHWSWpU4jf6PXr352nNJ2aGdQR3GlwyxD65sXBAjMEq+4Tzkp3n2S7GNSUAi+966Xl
         7JaDHEkCcrWYGEjok6ZX40zxlx8H4f3zst5AMp6gtmv/TcJaGdo5RvQEPROKqpj2Dl+U
         wEJg==
X-Forwarded-Encrypted: i=1; AKwUvBwKrHOrOeFAJ8Pxo3IdfMRuF97oJQHIeRFmT2DaJBJ5sU+5H4ClgmkvKxxOAuGCFMIlJCs=@vger.kernel.org
X-Gm-Message-State: AFuF++n3Cn+8j026DgSVSTIL48bggVJiv71R8nfKAXd+qU2yJjUObief
	G17FGS7of+ICNAV/U6HBJxHgneatzCYbzJNbb4ROpTBtYsohYk7h8IoT
X-Gm-Gg: AYBFou08H9SUg7+WAo0/4asWGoAfk/UJrkU2xqMxpSxa9MEtEKnJbtbOJTgAERGaxup
	VzOiYFjKKsb7FJ5Et/QJIhEs8SFJ5aladIgW0rc4/FtrQlxOiOB+raLyITuRcYv50g6oq0i8cpc
	vFio5niF1LAVzvSaAsYR+LfHrCCWk6mNkpSgIfzs3LZ8MleSFtRS8v16F3i0N9C2ZSrCNLfP6Q4
	mAFqEnF1P+7oXH+5/6m7DvwRQWkB/sJKOUZqWrjzCpatSp1ch519zRXVoU+910wBDI//yQjrhCm
	otGFZ0lBZLmoa1lyWcp87D23uzG7P+7uYZkoWlQnEN9jOuS/ktRm7/PZKFLYJFCAa9P4wn641nj
	ZBo4zD4LL/EOh97w/5H8n/MQYNiF4b40nT32t/nFOJuGi+9r6H5tlP4xD91wZcPGCXcaxgmcQXb
	kNvPnQpcQo0nYrcBYVRCIKGGWNRbNHADeZK4prBmaKNR/AM4TSairiB66oI0+P1YadZlB30v0W/
	tVVI7+cFl6dHetPcJbZ5gzfUTLSeD3Ky/WlsmjQdHlJ4IYOR2UWJ7+dyxVsWOoa7G/vkphtXLpk
	l7FyGUMV20Fu1eaiF1w8CDno8lBg47bO00MaiL3BYcFVnh2DyCWraopFCcN/WLreyq2ymApYFTA
	LutErEogV6q6RVUXH3n5KGP1DxnCkmYeI
X-Received: by 2002:a05:6820:162a:b0:6b1:9b72:213c with SMTP id 006d021491bc7-6d43eedd850mr2506187eaf.3.1790271875445;
        Thu, 24 Sep 2026 10:44:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v3 00/10] net: stmmac: preserve datapath state across
 MTU and resume failures
Date: Thu, 24 Sep 2026 11:44:30 -0600
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwQ6CMAwG4FchPTuzFQLMk+9hPIxRZcaB2eaiI
 by7Y164adJL2z9fO4MnZ8jDoZjBUTTeTGNqyl0BelDjlZjpUw/IseYSBfPPzprAfLBWaebIU2A
 X8yLPomCNlm0nsUepJCTi4SjvknCCkQKcv8OE3EiHFV5jg/Fhcu/8RBQ5/N+9VJy1jaqoKgUR5
 8erVea+15PNpyJuMfyBYcJ6iZSyHUlZb7FlWT6VZXt+LAEAAA==
X-Change-ID: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
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
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Keep the stmmac datapath coherent after failed MTU changes or hardware
resume without changing the interface's administrative state. Retain the
working MTU configuration for rollback, and allow ordinary down/up recovery
when hardware cannot be restored.

The ten patches separate ownership and recovery fixes from the MTU
transaction:

  1. Correct the WoL/safety IRQ unwind order after failed IRQ registration.
  2. Allow phylink_stop() to finish a suspended instance, restoring PHY
     advertisement reduced by suspend without restarting the failed MAC.
  3. Track datapath ownership separately from administrative and hardware
     sleep state. Close and PM perform only the work still outstanding.
  4. Leave normal-size MTU changes running, including supported AF_XDP MTUs.
  5. Make partial DMA allocation unwind complete and leave freed queues empty.
  6. Keep DMA configurations at stable addresses, use persistent IRQ
     contexts, and drain timer producers before the final cancellation.
  7. Track live XDP release/reopen and propagate program-attach failures.
  8. Use that tracked restart for AF_XDP pool changes, handling failures
     without leaving NAPI active over missing buffers or unmapping live pools.
  9. Retain PHY and runtime-PM ownership during ethtool ring/channel reopening.
 10. Retain rings and IRQ registrations across jumbo MTU replacement,
     restoring the old MTU and rings if hardware setup fails.

The ownership states remain distinct: DOWN has no datapath allocations;
RUNNING has active queues; SUSPENDED retains rings and IRQs; HALTED retains
rings but has released IRQs after failed MTU rollback. Collapsing the last
two states would make close free IRQs which it no longer owns.

Jumbo rollback allocates no new buffers or IRQ registrations. RX holes are
filled before reset without changing the old descriptors; descriptors are
rebuilt or retired only after reset succeeds. If rollback also fails, the
interface remains detached until down/up recovery. This cannot guarantee
recovery from indefinitely failing hardware.

Failed interfaces still receive hardware/PHY sleep handling. A failed
datapath with MAC WoL configured rejects suspend with -EBUSY because its
wake path is unusable; PHY-only WoL is not rejected. Timestamp filters and
PHC registration survive an MTU change, but continuous PHC time across the
hardware reset is not preserved.

Live XDP and ethtool failures leave the administratively-up interface
detached for ordinary down/up recovery. Program attachment failures return
an error without consuming the proposed program. BPF-link and XSK-pool
removal still complete if their datapath restart fails, so teardown can
release the program or pool safely. AF_XDP pool reconfiguration now pauses
all queues and link resolution while rebuilding the rings; this trades
reconfiguration latency for one consistent ownership and failure path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org

---
James Hilliard (10):
      net: stmmac: unwind the WoL IRQ after a safety IRQ request failure
      net: phylink: allow stopping a suspended instance
      net: stmmac: keep datapath state coherent after reinitialization failure
      net: stmmac: leave the datapath running for normal-size MTU changes
      net: stmmac: unwind partially allocated DMA configurations
      net: stmmac: keep DMA configurations at stable addresses
      net: stmmac: account for failed live XDP reopening
      net: stmmac: use the tracked datapath restart for XSK pool changes
      net: stmmac: retain PHY and PM ownership during ethtool reopening
      net: stmmac: retain DMA resources across MTU changes

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |    4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   21 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 1036 +++++++++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   19 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |   83 +-
 drivers/net/phy/phylink.c                          |   51 +-
 10 files changed, 815 insertions(+), 423 deletions(-)
---
base-commit: 8e1937fed6738460554ec123c64839e2445e7d53
change-id: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

