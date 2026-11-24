Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.127
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527708;
	b=dME6WbFC0AUpCG004xG1DnDlIPBf8ojad7hQhAU3JkrnHUK+fTSiXh5AhdU7OgNquCnV
	 QKc2hpFXbrw0eazqFbKVYFUwrzeZ8AwDZr0hawkQ/oz0uC3gNxj11hzhCmnMI9bjFKAAV
	 MW84b+lEQ4O1oa/wqdiIH7GqEyn9bWn58KThomuSXlzu3F23ujuwwtdBrnwqMcMLk0Tg6
	 vF17QJJ54uPd3iP6bdcX0jFVN2n5v419ZqFXeU5yxyZpMlW2lhNU2yhmRJ7DLkYU6bQcX
	 TcRt2OTqOO4N3Fcf/9Dhsitw8DiDfEqAs6Wh8kobNpf3CdCEwZ2jOfzYyW+1j2IXBZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527708;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=mATZzJIHu6yt8XD7wpZlPFJzWv/fQBeRjT0G1Txh/Qs=;
	b=CySFdtijCUX+XZRgJMdV8HPyPxYgR5BjefrwlGYK3CF+P/8cU+mSJsHxT9Bz3RFq0sYK
	 1QmjeEc3pdYTqHwWmiXWGV0typBtV2eou8Ej1zWdp2ACq4gY8/dvCp85bwAtJPySmgcFz
	 Oz/ENV9c5ubPbJZULSdzNouYG6CX3tnSA1ezf7BpPaxfLG+1tKGfqqZPnC++BK0ocF2x3
	 /27Hd9WrvifOq+YPTuoHcXb+qeWQZBJpuZnTRg05iFgHVUzPHZd1FoYbaZJaL0dXgawcP
	 PJc3df7+rkDJQCtG1Hk40a1DOpGZ3CyO+iBGqXFzvtpRdnvKM2+3aeoum9LCUKabmjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AWsjD24M;
	arc=none smtp.remote-ip=95.215.58.127
Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46034606A6B4
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46034606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AWsjD24M
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lG1NKyQUrSoB367kFlxf8SnY+K7LrS0Pb3rtvPqARQM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795527705; v=1; x=1796132505;
 b=AWsjD24MFhVZQwtmonGr2eNU0yMPb10ZdSVh3cHHTN21ACFbskAESiVGvJYJ6Dddp7ReZ+wH
 jZ2vBXmuo3OYil3KcMaQZcSb+jHaWVPyxwBujNUeP+Sndu7MGL/tGREZcUraRtHWHM9rXUtUgTW
 iq3OqHWsOHSjxlX0+/UKLkVI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3ad78350b41956a4;
	Tue, 24 Nov 2026 13:41:45 +0000
X-Mizu-Trace-ID: 3ad78350b41956a4
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Tue, 24 Nov 2026 21:41:16 +0800
Subject: [PATCH net-next] bonding: check XDP support before enslaving
 changes state
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQqDMBBEf0XmbMDE6qG/UkSMWdvtYZUkSkD89
 27b0/BmmHciUWRKuFcnIh2ceBUFW1eYX5M8yXBQhmtcb627Gb9KGEvYxoWLaZeOfN+1mg30skX
 S+qd7QCgboZIx/Je0+zfN+WvDdX0AiVNhw3oAAAA=
X-Change-ID: 20261124-bond_xdp_fix-3f5eb6533f50
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <hangbin.liu@linux.dev>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

The XDP capability checks in bond_enslave() - ndo_bpf/ndo_xdp_xmit
presence and the slave XDP program count - run only after the slave
has been opened, linked and published to the datapath. On failure the
slave may already be bond->curr_active_slave or reachable through
bond->slave_cnt and the upper device list, so a lot of state has to be
undone, and bond_xdp_xmit() can observe the slave before its
capability was ever verified.

Move both checks to the validation section at the top of
bond_enslave(), before the first state change, so a rejected slave
returns directly with nothing mutated. The dev_xdp_propagate() setup
stays in place and still uses the err_dec_slave_cnt error path.

Moving the checks alone is not enough. Without a bond xdp_prog they
are skipped, and a slave without ndo_xdp_xmit can be enslaved while
the bond still advertises NETDEV_XDP_ACT_NDO_XMIT built from the
other slaves. __xdp_enqueue() then accepts frames and the bulk-queue
flush hands them to bond_xdp_xmit(), which may pick the new slave and
call a NULL ndo_xdp_xmit in softirq context.

Check the selected slave in bond_xdp_xmit() and fail the frame with
-ENXIO instead. The check happens at xmit time, so it also covers
frames enqueued before bond_xdp_set_features() clears the flag, and
the bulk-queue flush path that never rechecks xdp_features.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Target this patch to net-next as it depends on f564749b3b26 ("net: record
XDP programs propagated to lower devices"). Please tell me if anyone
think it should be post to net.

For Sashiko: please ignore the bond's promiscuity/allmulti/ns maddrs
leak issue when xdp setup failed. It will be addressed in another patch.
---
 drivers/net/bonding/bond_main.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 776afdb9df43..0149bd7764e7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1951,6 +1951,20 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		return -EPERM;
 	}
 
+	if (bond->xdp_prog) {
+		if (!slave_ops->ndo_bpf || !slave_ops->ndo_xdp_xmit) {
+			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
+				     "Slave does not support XDP");
+			return -EOPNOTSUPP;
+		}
+
+		if (dev_xdp_has_own_prog(slave_dev)) {
+			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
+				     "Slave has XDP program loaded, please unload before enslaving");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	/* set bonding device ether type by slave - bonding netdevices are
 	 * created with ether_setup, so when the slave type is not ARPHRD_ETHER
 	 * there is a need to override some of the type dependent attribs/funcs.
@@ -2314,15 +2328,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (!slave_dev->netdev_ops->ndo_bpf ||
-	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
-		if (bond->xdp_prog) {
-			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
-				     "Slave does not support XDP");
-			res = -EOPNOTSUPP;
-			goto err_dec_slave_cnt;
-		}
-	} else if (bond->xdp_prog) {
+	if (bond->xdp_prog) {
 		struct netdev_bpf xdp = {
 			.command = XDP_SETUP_PROG,
 			.flags   = 0,
@@ -2330,13 +2336,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			.extack  = extack,
 		};
 
-		if (dev_xdp_has_own_prog(slave_dev)) {
-			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
-				     "Slave has XDP program loaded, please unload before enslaving");
-			res = -EOPNOTSUPP;
-			goto err_dec_slave_cnt;
-		}
-
 		res = dev_xdp_propagate(slave_dev, &xdp);
 		if (res < 0) {
 			/* ndo_bpf() sets extack error message */
@@ -5681,7 +5680,7 @@ static int bond_xdp_xmit(struct net_device *bond_dev,
 		xdp_convert_frame_to_buff(frame, &xdp);
 
 		slave_dev = bond_xdp_get_xmit_slave(bond_dev, &xdp);
-		if (!slave_dev) {
+		if (!slave_dev || unlikely(!slave_dev->netdev_ops->ndo_xdp_xmit)) {
 			err = -ENXIO;
 			break;
 		}

---
base-commit: a4c450594f5d1dc0fc4daacfb95d40554d99dead
change-id: 20261124-bond_xdp_fix-3f5eb6533f50

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

