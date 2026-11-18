Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044268;
	b=bjc4wCYk6/yS5gxKjQZLXidh2sIsEvv/gvoNoE0YOxci46p3CkrlidFsdQbEL1467KQe
	 Gv4nP/Jd3F88sYCPoeryopEEVoSG1OZ50/v3c+gHEUZxqqmX1CBQuQCA4xTdNAS9bhhg0
	 h/uSAd++lNwnht6uCx41OmZomm5MqLbISWewSCDkgSmiXdCuyqVjasZMfzVacn/IqXkud
	 u+BKtnyEy6nN8CSEFsnEv0dO6eV3XAWSG8A2BrZVIBHfZSgjnVTuRXeE55K72kDkVDZRm
	 I/T+vOX1IiXdFx+TRs7c5m0TRONkVW9u22yhC3loGFsL5rAA4WFGKdW+tanURkNa5VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044268;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7ESInaSDuDYul1nQI9PNiMra/oVQ5owBjeZDU6MC7kA=;
	b=NllKV29Dqk050bBVkPecIcNdXOgZTC4DJEx2wq5RUoMLsxNyqH4FoYpLuA7/76J12yv4
	 gv7jTP0cRSKnR+btr3UTWUcv5fFT+1ig735qpy/uMfKiadRzzG+Vzk0OBSeGl1yKxoHGz
	 ZnbldJe8DoHfchLH+WHUtyPgDOXSXxxDyvVSyVpShafT2jEmwoFyb5Ro/Js+iokDGuaCV
	 hfr3XDxgaGvHLrjF4UpvPFrpZKyDSjUQCT5kI0CoARZBUvJhGo6to+61R2f8kgrLBSUIj
	 J5dePT0wpK8WuFVVlNr0ecdMjqZpNsD62PmVCpQJ+pE0rwXVu6hNd5D1rbaOvOCpfRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMc0ZYoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5515606A320;
	Wed, 18 Nov 2026 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMc0ZYoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82E11F000C5;
	Wed, 18 Nov 2026 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044268;
	bh=7ESInaSDuDYul1nQI9PNiMra/oVQ5owBjeZDU6MC7kA=;
	h=From:To:Cc:Subject:Date;
	b=SMc0ZYoSNyPsW/NvIz8/KsSGEgjcgioN1VbZ8ucaSuOBhZiXnyxS+59OehD3bMelD
	 neSbr6iAhs84QFbcTcbeNPRjGaO3wpLNzTbyzdcGk6sWktv/8ggJVD3KQRS5+DBd7j
	 V/D9J842EiyWLxefv4fetGhsL2xJZqqndpNszI2epYp2OhKRXoM56fQbzkg+jT320/
	 r9XUEOj0z/TqhvQq3XrEoWiTOBn1h7Er9zu0Nwh0kgIbqMv9kO+jG3ZwB6eUalhISn
	 VJlXnVxZAu42iMOLW01GQs88aqjF3BsCuJP7+ix63IY5O39iVM83f5UQax/iySmZPe
	 hHQGxhc8EPuOA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	manishc@marvell.com,
	joshwash@google.com,
	hramamurthy@google.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	daniel@iogearbox.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	przemyslaw.kitszel@intel.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/8] net: adjust HW GRO and LRO feature handling
Date: Wed, 18 Nov 2026 15:23:07 -0800
Message-ID: <20261118232315.3593731-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP has no understanding of GSO frames. GSO frame looks to XDP
like a large packet. Pushing / popping headers cannot be reflected
in GSO metadata. XDP redirect is completely blind to GSO since
struct xdp_frame carries no GSO fields.

For those reasons most (read: all well behaved?) drivers disable
LRO and HW GRO when XDP is attached.

This series lifts the auto-clearing of HW-GRO and LRO from drivers
up to netdev core. This gives us uniform behavior - previously some
drivers would reject XDP attach w/ HW-GRO and others would auto-
-clear the HW-GRO features.

More importantly (for me) after this series the HW-GRO/LRO features
should consistently remain in wanted_features, and get re-enabled
after XDP is detached. I started looking at this because XDP generic
tests in NIPA unintentionally clear HW-GRO, which in turn makes devmem
tests fail / skip on mlx5.

Note that XDP generic mangling GSO state is its own can of worms this
series doesn't try to address. There are multiple paths (xdpgeneric,
tun, veth...) which end up calling XDP on skbs, with varying level
of assurance that the skb is not a GSO super-frame...

Jakub Kicinski (8):
  net: stop making HW-GRO depend on SW GRO
  selftests: drv-net: drop the generic XDP hack from the HW GRO setup
  net: state the "XDP excludes HW-GRO" rule in the core
  net: state the "XDP excludes LRO" rule in the core
  eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling
  eth: bnxt_en: don't clear HW-GRO and LRO for XDP in ndo_fix_features
  eth: qede: drop the now-dead HW-GRO vs XDP handling
  eth: gve: drop the now-dead HW-GRO vs XDP interlock

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdev_features.h               |   6 +
 include/linux/netdevice.h                     |   6 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c    |  12 --
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  32 +-----
 .../net/ethernet/qlogic/qede/qede_filter.c    |  12 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c  |   1 -
 net/core/dev.c                                | 107 ++++++++++++++----
 .../testing/selftests/drivers/net/gro_lib.py  |  21 +---
 .../selftests/drivers/net/hw/gro_stats.py     |  18 ---
 12 files changed, 104 insertions(+), 119 deletions(-)

-- 
2.56.1

