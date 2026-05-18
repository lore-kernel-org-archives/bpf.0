Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0991DE2D3;
	Mon, 18 May 2026 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105459; cv=none; b=uHAFi7UkC5gnicw5IlR+CQ1eOCYj6va99/hgtj0kqXxhY1s3bBIO4oVeXoXJQ2sCCfi0+K7p3Ieof0n1F+3YSlkPruCuhRa6ZMnmMIwdPLkYzTZPIuPphPR3/XQEOS8Rg54Hwn0fBGnWc45M/ymXeO1tgWsaeQv7MhrduD0OA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105459; c=relaxed/simple;
	bh=W3cyeDLtkZm6PdKqV7BPnQGyExABO6MiNvVjLa2v1ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLyvczMn6V4SkGP/RP16kdDeyWco3e5/Rk9LqePuXMMO9iDYd4CiKIvpR+VNhbYt0EXh+YcFXJ+hB8IXyketBxH3xC0QnlRAmFdea/FoiFm1sqt+bidm3zDsyiMusn00+PbNMSUj00DAGoiJT1XL+KPGP7iDaW4J/Ni/1TMqhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KO8n2eIG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KO8n2eIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779105457; x=1810641457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W3cyeDLtkZm6PdKqV7BPnQGyExABO6MiNvVjLa2v1ag=;
  b=KO8n2eIGVQlB0jZYblz3PyoBTgupv8QePOPy+IkbXDfJ6Ctgon2LOEru
   Kta3gdsi9HZED2S/fBxT0Q20XhAaoGuHGqGt8ZUF1ricnqGMadscxeAI3
   yBLq1aXw73+e3O7LHYdWsgqz+GiGJRhp33Pum8ygnEiWzCqfNkbMIx6TL
   CgJ07RUh5Jel9wVI1GJr1lu2X32/mWWhN4ZCkDm+sAGJyi66NJEOQompv
   aLpHhuxYRfI+J1s/hf6fBkA38yCLj5khOi8I3lwk5S41vg9w9/nuHuzMZ
   dBQaccRdD2FKiB3HblRwP1zZiFWit9HT1FtUbrYdm9Xfx9cSo/VGlpZ1a
   g==;
X-CSE-ConnectionGUID: jLfiGRfITk+aha4vbsYh8Q==
X-CSE-MsgGUID: /8FIM+KwQZigal7PIAlGnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90536454"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="90536454"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:57:36 -0700
X-CSE-ConnectionGUID: fFMM4JefRKOR7eRPBBHuRQ==
X-CSE-MsgGUID: imDZ3k3fSYqAcabYJ7+yvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="235165872"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 18 May 2026 04:57:32 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4681A284E3;
	Mon, 18 May 2026 12:57:31 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] ixgbe: do not configure xps for XDP queues
Date: Mon, 18 May 2026 13:15:04 +0200
Message-ID: <20260518111506.65284-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_set_xps_queue() should not be called for an XDP Tx queue, since such
queues are not netdev-exposed. On systems with number of CPUs >=64, on E610
adapter, netdev is configured with maximum number queue pairs being 63
(due to MSI-X assignment), but configuring XDP results in 64 XDP queues.

So, during XDP program load, when netif_set_xps_queue() is called for the
last XDP queue, we get a WARNING with a call trace and KASAN report
afterwards (if enabled).

[ 2012.699800] WARNING: net/core/dev.c:2854 at __netif_set_xps_queue+0x116a/0x1e40, CPU#36: xdpsock/103668
[...]
[ 2012.700029] RIP: 0010:__netif_set_xps_queue+0x116a/0x1e40
[ 2012.700035] Code: b6 34 06 48 89 f8 83 e0 07 83 c0 01 40 38 f0 7c 09 40 84 f6 0f 85 03 0a 00 00 0f b7 44 24 40 66 43 89 44 6a 18 e9 01 fb ff ff <0f> 0b e9 f2 ee ff ff 44 8b 44 24 44 45 85 c0 74 50 4d 85 e4 0f 84
[ 2012.700040] RSP: 0018:ffff8882369aeb28 EFLAGS: 00010246
[ 2012.700046] RAX: 0000000000000000 RBX: 000000000000003f RCX: 0000000000000000
[ 2012.700050] RDX: 1ffff1111da3d891 RSI: ffff888120e34250 RDI: ffff8888ed1ec488
[ 2012.700054] RBP: ffff888913281560 R08: 0000000000000000 R09: ffff8888ed1ec000
[ 2012.700058] R10: ffff8888a2e83180 R11: 0000000000000000 R12: 0000000000007fa8
[ 2012.700061] R13: 000000000000003f R14: ffff888120e34854 R15: ffff8889132817c8
[ 2012.700065] FS:  00007fc8ea9ff740(0000) GS:ffff88884cefe000(0000) knlGS:0000000000000000
[ 2012.700069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2012.700073] CR2: 00007f81c8000020 CR3: 00000002299f8006 CR4: 00000000007726f0
[ 2012.700077] PKRU: 55555554
[ 2012.700080] Call Trace:
[ 2012.700084]  <TASK>
[ 2012.700087]  ? ktime_get+0x61/0x150
[ 2012.700097]  ? usleep_range_state+0x133/0x1b0
[ 2012.700108]  ? __pfx_usleep_range_state+0x10/0x10
[ 2012.700114]  netif_set_xps_queue+0x31/0x50
[ 2012.700119]  ixgbe_configure_tx_ring+0x472/0x920 [ixgbe]
[...]
[ 2012.700486]  ixgbe_xdp+0x38f/0x750 [ixgbe]

[...]

[ 2012.701094] BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x1ac5/0x1e40
[ 2012.701100] Write of size 4 at addr ffff88888d43cff8 by task xdpsock/103668

Skip XPS configuration for XDP Tx queues.

Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e0a986f1c96a..bd689dc8201e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3964,7 +3964,8 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter *adapter,
 	}
 
 	/* initialize XPS */
-	if (!test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, ring->state)) {
+	if (!ring_is_xdp(ring) &&
+	    !test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, ring->state)) {
 		struct ixgbe_q_vector *q_vector = ring->q_vector;
 
 		if (q_vector)
-- 
2.52.0

