Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BF3988E9;
	Tue,  3 Mar 2026 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579526; cv=none; b=HpKGzYNAAUJw+nrrI5QxKoDiM+gZfSKT6VeJzbmFJU8fQtDjMlDqd1zNLrp6J98nXzCfas2iI7RCUsu4TL42potnCXTEBzEADQ7nwvIvP8a4HI1Qz0B6djwBZb0F5BU3O2ZI1tsgBZ0669+noeHpZ4HkwN+qM5/jOPFzqPu0xWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579526; c=relaxed/simple;
	bh=4lj6Mv86DOUniLAjUedxKmqRrWgLF398XXuyJ71yUPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1wEW3Df96SPdN2MH2HXk8i+Uypl9Y+pINaVf9kBrFwxFBqFsPZWQBqCxrQbuSZcMa/TRySkNdr/6B6QVKdKbO2nIdBI21obnTeQfy9BdT/SONFfu83erlSbHOv9TIhiARF3sDEUnTH8WTQxLYU6fXCSDR0BQ3NygMAzNX279g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjS6XIng; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjS6XIng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579523; x=1804115523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lj6Mv86DOUniLAjUedxKmqRrWgLF398XXuyJ71yUPw=;
  b=ZjS6XIng0TyNgL1DTYNQ7qoMsNKAEnA/TP1THVHOKQSoUl0SUoM2MpgC
   3Ri87MFmdgk371Q0wEzQ++nzmDyBLHrqvF9adl2hP8rb1GCvyPtXH9LFj
   zjZmJYgfWBScd2FB8/gSUM1vQWwD+tBceHhj+U51cbq75gVSAXrTgIJc3
   iklfYMUjL4gjyfNKyi5hs2irYo37K4s46TAXgW1gkFHEwocdFIKt+OrAu
   XFgj6mBZqBR1dgunkHXrfDA41dgg3IbdEUG+zkXFygmsPAwhEOjQwwojZ
   lUh2y6Mb5+4XzfO5N+Xjux3kkqSajdeJJJWjE5G8Z7mUFOntYprh2UDhh
   Q==;
X-CSE-ConnectionGUID: 6QuBnbghSW22Wm/MlA0tqQ==
X-CSE-MsgGUID: DXL6ly/TQwW8Xqi0wdetgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238809"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238809"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:11:59 -0800
X-CSE-ConnectionGUID: 0sKhPT93SlSm3z4dAMeNRA==
X-CSE-MsgGUID: tVP1ahfcT9mb0uoxTF1oaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633807"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 15:11:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Zilin Guan <zilin@seu.edu.cn>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 4/8] ice: Fix memory leak in ice_set_ringparam()
Date: Tue,  3 Mar 2026 15:11:50 -0800
Message-ID: <20260303231155.2895065-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zilin Guan <zilin@seu.edu.cn>

In ice_set_ringparam, tx_rings and xdp_rings are allocated before
rx_rings. If the allocation of rx_rings fails, the code jumps to
the done label leaking both tx_rings and xdp_rings. Furthermore, if
the setup of an individual Rx ring fails during the loop, the code jumps
to the free_tx label which releases tx_rings but leaks xdp_rings.

Fix this by introducing a free_xdp label and updating the error paths to
ensure both xdp_rings and tx_rings are properly freed if rx_rings
allocation or setup fails.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Fixes: efc2214b6047 ("ice: Add support for XDP")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 29e341251754..b9be10b58856 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3332,7 +3332,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	rx_rings = kzalloc_objs(*rx_rings, vsi->num_rxq);
 	if (!rx_rings) {
 		err = -ENOMEM;
-		goto done;
+		goto free_xdp;
 	}
 
 	ice_for_each_rxq(vsi, i) {
@@ -3359,7 +3359,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 			}
 			kfree(rx_rings);
 			err = -ENOMEM;
-			goto free_tx;
+			goto free_xdp;
 		}
 	}
 
@@ -3411,6 +3411,13 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	}
 	goto done;
 
+free_xdp:
+	if (xdp_rings) {
+		ice_for_each_xdp_txq(vsi, i)
+			ice_free_tx_ring(&xdp_rings[i]);
+		kfree(xdp_rings);
+	}
+
 free_tx:
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
-- 
2.47.1

