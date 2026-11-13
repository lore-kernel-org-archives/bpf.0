Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.127
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578766;
	b=mNz/pBH6AfSS+COtoBqY8qlr3GWX9aKGMWuWVzPbckp3AuSXr96fLrdMxQuEeYgX670y
	 CLlRMTxyZEXGJFWpx6/uOZri/oHTkoAIAqXZHpW4brAjdQtY/AMXU+9p1vfAROjhBW+bB
	 EulBCBNUUiyaq98U43Qa5IYCdllm7uQBFIUmg16SDkLIf3kZq4cBTNqBO8MfXkMhsY5NE
	 wBMierVv+ifSrRBgbjd5KVqO20lDCQqw5uAKZzK7myLxRpOc3WkDPVFL3w+8NVRnlK4QU
	 giMyXut5g2w0HW9aOG9WQIF/YDvtL/13NAwATjO2Ps2BOGskiMMupqET/maJ3pQMijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578766;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=C0kDAcJ25HEa7l+lmxjvOALQB9PoPJwZxNqhGvdBIOo=;
	b=UbgQsAtEUa/tz2Cmfhuc3yQzJmxCFKDmnp9ws3+taW2CqegZs+Og0JhvhEN2MXqYwrJi
	 DpmrlH6B6M5oEG3fL9jOU9MMxhzyYKE/6yJ0Op1SyzjG6MBxSKEf8WOkasKZ3lcX0AyMp
	 /JVAj7b0nikDC6E5FcMzcQG5rMZOUli5t6m81dWqb45Zl1NbsvCHWesPJD9o02sDMgMVX
	 ONyKFoR0OTJAO1dkHByL/0J151BVr9W8lhQP9EC8ruFydY4tXNakVSx89KtJnLDuYJ6uH
	 BX0ha5PnLP4hyQv41h/zwP2PmQr7LGOc9MPZ1K8oBI8ewIXL8OfkD0AoaNrErRMsidQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nr6uAWFN;
	arc=none smtp.remote-ip=95.215.58.127
Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF5606A335
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5CF5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nr6uAWFN
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S2jAsuhfj6x/gYRYbnNnnd58G4n/8un6QgXDeo7I9G4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794578763; v=1; x=1795183563;
 b=Nr6uAWFNQwj1pBY2WEsP80Ieo4Wu9Rj9OjFOObaEZrUW2oWIpu+xZochN8cb7cKNxDbybJFg
 5G6XoZ3DjgtZJ6V5Wr3wld1uJS5TaYVF72t674RaieMlvT9WPNRSuzUfH7ws829atSegVUKqju5
 0y3v6Sa1RWUJpw3IVNgXVE7A=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 19a0522a90f91ab5;
	Fri, 13 Nov 2026 14:05:59 +0000
X-Mizu-Trace-ID: 19a0522a90f91ab5
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 13 Nov 2026 22:04:19 +0800
Subject: [PATCH net-next 4/6] bonding: factor out slave publication
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
Message-Id: <20261113-bond_enslave_restruct-v1-4-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
In-Reply-To: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
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

Factor the publication step of bond_enslave() into bond_publish_slave()
so the infallible "commit point" of the function is explicit and cannot
be interleaved with new fallible code by accident.

No functional change.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 49 ++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f696a0d15034..bb3752683456 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1884,6 +1884,34 @@ void bond_xdp_set_features(struct net_device *bond_dev)
 	xdp_set_features_flag(bond_dev, val);
 }
 
+/* Make the fully prepared slave visible to the rest of the bonding
+ * code.  All fallible steps of bond_enslave() must have completed
+ * before this runs: error paths never undo the publication.
+ */
+static void bond_publish_slave(struct bonding *bond, struct slave *slave)
+{
+	/* Must called before bond_update_slave_arr() or bond_select_active_slave() */
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
+	netdev_compute_master_upper_features(bond->dev, true);
+	bond_set_carrier(bond);
+
+	/* Needs to be called before bond_select_active_slave(), which will
+	 * remove the maddrs if the slave is selected as active slave.
+	 */
+	bond_slave_ns_maddrs_add(bond, slave);
+
+	if (bond_uses_primary(bond)) {
+		block_netpoll_tx();
+		bond_select_active_slave(bond);
+		unblock_netpoll_tx();
+	}
+
+	/* broadcast mode uses the all_slaves to loop through slaves. */
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
+		bond_update_slave_arr(bond, NULL);
+}
+
 /* enslave device <slave> to bond device <master> */
 int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		 struct netlink_ext_ack *extack)
@@ -2341,26 +2369,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 	bond_xdp_set_features(bond_dev);
 
-	/* Must called before bond_update_slave_arr() or bond_select_active_slave() */
-	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
-	netdev_compute_master_upper_features(bond->dev, true);
-	bond_set_carrier(bond);
-
-	/* Needs to be called before bond_select_active_slave(), which will
-	 * remove the maddrs if the slave is selected as active slave.
-	 */
-	bond_slave_ns_maddrs_add(bond, new_slave);
-
-	if (bond_uses_primary(bond)) {
-		block_netpoll_tx();
-		bond_select_active_slave(bond);
-		unblock_netpoll_tx();
-	}
-
-	/* broadcast mode uses the all_slaves to loop through slaves. */
-	if (bond_mode_can_use_xmit_hash(bond) ||
-	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
-		bond_update_slave_arr(bond, NULL);
+	bond_publish_slave(bond, new_slave);
 
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
 		   bond_is_active_slave(new_slave) ? "an active" : "a backup",

-- 
2.56.0

