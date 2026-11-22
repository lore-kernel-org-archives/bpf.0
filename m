Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309278;
	b=1Qxdcelnd72ZYAEaFMD9BLZzFjBYR3F/X00HevZb1J7MvPxegAHhMAlFF5UF/xsIhdmn
	 gVw3eEPBzEudlxsr019BK/kujeJw5yWR0YV5yBlRQpg+a48DybsoDkB8WKJjMz8PUk8oh
	 95b1WXu0v10etTFkfT0rJqFoTqZqiUAB/g6FTFVU8L1Cfpka1FPgdgr3WfOgPb4mZl72T
	 0plDrLeBThb+0DCEF3F2nOQQpiUN2u8dTXsUfzkiQzO9YUj5viU5a5efSaFkJHuUEHT9d
	 nvORImSwYsy9SXMmkNBsTGBlg2e79uI7WilyLSPkpoY0A8P8PHyWly+nT5nsosVjCXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/4I+mO5uLZShMj+Us0JKP+cnbfvpvxCJyIdSkhVTXVc=;
	b=tYhSnUnw63EQTqg56rgx3F2rnOHHn/HbhqkcjJYsIUB+bstyAOeq6Hy6sPwRxy2WHnGj
	 bh3XNSKadDmo+IfD/MZ9eW4TPETB+Ca5w41XxPU74qQ2GML2jzYxy+r/vyGpPDWdLFR/d
	 pebgkN7szb6+5OVpg1jLMDsmBhKOpDe6+2ZR7XNifDe8SjyIvG+JKxkajyw60YGX+xUS6
	 wSJ+vgrr44xhYpyMa77wzRVwjwtRIWWvJQchiILpVNSRoMkBcZX2wW21L1PLd/SxmT0/A
	 TAiY6BIAY4i3GPNyp4Q6hBCBgb4gq+6IszZW6vPdKPx/Idpq3lOk3fSJZO8UB70oDcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyRKjL2P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E765606A32A;
	Sun, 22 Nov 2026 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyRKjL2P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7894D1F000C4;
	Sun, 22 Nov 2026 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309278;
	bh=/4I+mO5uLZShMj+Us0JKP+cnbfvpvxCJyIdSkhVTXVc=;
	h=From:To:Cc:Subject:Date;
	b=RyRKjL2PPyit7kFoUJKFBHri9Ez99gpMtKV+3fy5h2Wrq9AcY/7rO33TGXJU8No+M
	 vyEQcHJ7uDIFXDyA4fPHeuzyxhhzaxXP9OzeZ24sG0kOKY4hmAaXF/PxIdw4Xw4LQO
	 1lOMUEt8xRmEM/LG2nE+kIw69jLh2K4GsWzuQxd3IOXdaPlBGPqEkHCSvD5oSsSHaX
	 +cRqdFMz4TNFh36ll4dv2YM5hUyn6aKPI0dZFnDTQGU2c6zgjXq7GtGBBrm3G6W9J5
	 dXWnrJuIRMbOQceVLo+wIrNKb9jv3ykG2UymZMNjsCiuxCUKNO7z8XAZSFxMwx1bkX
	 uyftLYjUAnVQA==
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
Subject: [PATCH net-next v2 0/9] net: make core auto-disable HW-GRO and LRO when XDP gets attached
Date: Sat, 21 Nov 2026 17:01:03 -0800
Message-ID: <20261122010112.1471146-1-kuba@kernel.org>
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
after XDP is detached. I started looking at this because XDP tests
in NIPA unintentionally clear HW-GRO, which in turn makes devmem
tests fail / skip on mlx5.

Note that XDP generic is its own can of worms this series doesn't
try to address. There are multiple paths (xdpgeneric, tun, veth...)
which YOLO skbs into XDP without worrying about GSO state.
And HW-GRO disabling w/ XDP generic is not propagated down to lowers.

v2:
 - new patch 2, convert gro_stats.py to the shared set_ethtool_feat()
 - mlx5: drop the netdev_update_features() call from mlx5e_xdp_set(),
   key XDP features off tcp-data-split
 - qede: keep clearing NETIF_F_GRO_HW in qede_alloc_mem_rxq()
v1: https://lore.kernel.org/20261118232315.3593731-1-kuba@kernel.org

Jakub Kicinski (9):
  net: stop making HW-GRO depend on SW GRO
  selftests: drv-net: gro_stats: use the shared set_ethtool_feat()
  selftests: drv-net: drop the generic XDP hack from the HW GRO setup
  net: state the "XDP excludes HW-GRO" rule in the core
  net: state the "XDP excludes LRO" rule in the core
  eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling
  eth: bnxt_en: don't clear HW-GRO and LRO for XDP in ndo_fix_features
  eth: qede: drop the now-dead HW-GRO vs XDP handling
  eth: gve: drop the now-dead HW-GRO vs XDP interlock

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdev_features.h   |   6 +
 include/linux/netdevice.h |   6 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c|  12 --
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  40 +------
 .../net/ethernet/qlogic/qede/qede_filter.c|  12 +-
 net/core/dev.c| 107 ++++++++++++++----
 .../testing/selftests/drivers/net/gro_lib.py  |  21 +---
 .../selftests/drivers/net/hw/gro_stats.py |  54 +--------
 12 files changed, 118 insertions(+), 156 deletions(-)

-- 
2.56.1

