Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD43803DE;
	Fri, 28 Aug 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935766; cv=none; b=VsQcFNwn3Symy+0leEPUQv3E/5bki/JacG5REyZDjf9N2iYnLsQt1mpr664Ti/pboErE7vAx4orzycSzAPozFkQ7HXoVtKCsK3ApERiL3lzobKMsJONTxCfcj0GU+jfGfN42AD3YYsjPNiZIWJN2cDRRc+YGa/3mY7j7HBtVB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935766; c=relaxed/simple;
	bh=qXJ06c3eEgLhEnOe/kfReUDcIX+s7YLsjluOyG6BYIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ugJF8sneH3b1bQ24xadbnbsPVIMhSH4wCXztt9YpA0wBwNGdcMptcWzRPYuu7TAjulyqLujMV9/ZzRBtFR/qweAAfFZvI2laoTFS8HvKBGXx7sq4Cg7jGuEgWr7sX0LVVCODbewzZTv9fQ4fYmBfMC4LHg0UFcvSQANSMMd9Du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJOde2Ss; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJOde2Ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787935765; x=1819471765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qXJ06c3eEgLhEnOe/kfReUDcIX+s7YLsjluOyG6BYIw=;
  b=NJOde2Ss4NZDzZp+qgJJ3FE30GJgL+J6gW8/YEMu1yk1X5ohRcnoHDwY
   UN9TPSGNmRlbV4BmDZGWpEpQdh1kPkj6ICxgF+9Xx0A07wWVqBNAwUfY8
   ucO2SyHwxbLJrZvyqCUz+P9gSq/7YvhhY3Wq2wy/itor4mNFb4lHBpF3X
   UghH9pOdBxW8cRX06+O4ym2CkSEby7z4PDGB8XZYKsYRXFo7E05ND9sQq
   HpH+AqSAWJpQeJJ1/Cqa66lAsTij0yDKEIwz4iSkAsKikiNZWcitYJQwE
   +BaZov8gI6kyG8+bJjR39krl+IeWZoepQC3m4gHDgsUb4NhpBsKTYBaVC
   A==;
X-CSE-ConnectionGUID: euI7xSocTPW/isoVRzFhsw==
X-CSE-MsgGUID: 6ovw0a9sQ0S5sqmuFRXP7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99111466"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="99111466"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 09:49:24 -0700
X-CSE-ConnectionGUID: 0m7b2WMsS/+ki5vVG/qRMA==
X-CSE-MsgGUID: vnSq7n9pTBuQbipPldK4rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="262071662"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2026 09:49:22 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	magnus.karlsson@intel.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net] ipvlan: unregister upper devices outside pnodes_lock
Date: Fri, 28 Aug 2026 18:49:18 +0200
Message-Id: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following circular locking dependency:

  xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex

The pnodes_lock -> net->xdp.lock edge is recorded when
ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.

Keep pnodes_lock only while marking the upper devices as dying, removing
them from port->ipvlans, and queueing them for unregistration.  Once the
devices have been detached from the protected list, release pnodes_lock
before unregister_netdevice_many() invokes notifier callbacks.

The port remains alive across unregistration because
ipvlan_device_event() holds the reference acquired by ipvlan_port_get().
The dying flag prevents a concurrent ->dellink() callback from deleting a
queued device again.

Fixes: 35add1093e2f ("ipvlan: Protect ipvl_port.ipvlans with mutex.")
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v2: avoid list_empty() check as unregister_netdevice_many() already does
    it for us (Kuniyuki)
---
 drivers/net/ipvlan/ipvlan_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ee46a55f73d1..2d4340627ca6 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -846,7 +846,6 @@ static int ipvlan_device_event(struct notifier_block *unused,
 				__ipvlan_link_delete(net, ipvlan->dev, &lst_kill);
 		}
 
-		unregister_netdevice_many(&lst_kill);
 		break;
 	}
 	case NETDEV_FEAT_CHANGE:
@@ -895,6 +894,9 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 	mutex_unlock(&port->pnodes_lock);
 
+	/* Avoid invoking nested netdevice notifiers under pnodes_lock. */
+	unregister_netdevice_many(&lst_kill);
+
 	ipvlan_port_put(port);
 
 	return ret;
-- 
2.43.0

