Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA73115A2;
	Thu, 27 Aug 2026 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836933; cv=none; b=RzLXmGkW0+u40sigdOFo/58RXSmwEt3Re/hBo3XWEBS3v2aKmIGbLkpFm+xYvACV5yILRY9PTQUNpamKDjYhoezRyb++xrpTq5j4eQloVH1V+IAE0L5Njqk9OYB4ZBlhxY+oy8rxPYNiTa4oDWhEgFZtmVqUiIbfHN50gDKyNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836933; c=relaxed/simple;
	bh=Ahfvl98Kni8h2pddJBVCx/9exawY9HcW1u6INwcL3TM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u2raxI1oJkefIhUbLqC7HzM8ca8FIAIDt4vzFUYO33+6PFHxIno/2gWQ5kjJtSBHmoVqi17vS0S42xIOZFxpV7QWBOX+kzibadxbICQFrn/F/au3xU0mvOtEpzbwLDm+bBI455NaeBkMDk4XUR3ecgIgy7NC0roLhwv4iCLZLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aleW7UDg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aleW7UDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787836917; x=1819372917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ahfvl98Kni8h2pddJBVCx/9exawY9HcW1u6INwcL3TM=;
  b=aleW7UDgQUydfRJ/WW1TereOqRuDQR4vo4sH46AHux/4juwO0qlMQj//
   3+oaJ/xR/iOLuX8PWKPG0rkaF0sexAyYRFeL6EMKWmWMwBNtynmQ4vt53
   fW5OvXdCccUEsJz+mbGNx9eyuHnvLsbLNhTCD9NJFo3ZnPa7V5K1GEKeh
   C/7omfND5eRzsZl7W4We3ufkOA0fnapj6Fo9Utf9lOIvFX0mmcXHlrH48
   Xb84yJPsYDx+lxxBC2VOvnjF9PcsvBAxhUGTSGqLc42bEvxcqwIbLGmWb
   p2kcFOOg1UPCWvkH6bkVgJyyJhbca7WtESMbhnQ74a6A16cC00pg6VeNB
   Q==;
X-CSE-ConnectionGUID: 0orarIURTPG01TsyYYPVhQ==
X-CSE-MsgGUID: US9RhKnEQZioLvaZmTmL/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88458775"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88458775"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 06:21:50 -0700
X-CSE-ConnectionGUID: QWVjZ9mpSWeDneGYAg3UWQ==
X-CSE-MsgGUID: r6+9rxErQO2TIRo0KT3Rtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="264628482"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2026 06:21:48 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	magnus.karlsson@intel.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net] ipvlan: unregister upper devices outside pnodes_lock
Date: Thu, 27 Aug 2026 15:21:33 +0200
Message-Id: <20260827132133.439890-1-maciej.fijalkowski@intel.com>
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
 drivers/net/ipvlan/ipvlan_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ee46a55f73d1..2730581e0a56 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -846,7 +846,6 @@ static int ipvlan_device_event(struct notifier_block *unused,
 				__ipvlan_link_delete(net, ipvlan->dev, &lst_kill);
 		}
 
-		unregister_netdevice_many(&lst_kill);
 		break;
 	}
 	case NETDEV_FEAT_CHANGE:
@@ -895,6 +894,10 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 	mutex_unlock(&port->pnodes_lock);
 
+	/* Avoid invoking nested netdevice notifiers under pnodes_lock. */
+	if (!list_empty(&lst_kill))
+		unregister_netdevice_many(&lst_kill);
+
 	ipvlan_port_put(port);
 
 	return ret;
-- 
2.43.0

