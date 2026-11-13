Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566837;
	b=1/4yngowkaYHEgNnBIIP2FKbirfqVTF6YDuSvQ+ib04Hc88sIJHHj8gRG9618LONT26R
	 GbTHGn+KquEakkkxI8/CMesUWSOE0ED+o90gHoFUpmPB1ZNIFYzotMOCzPBwn1uPlOetx
	 hI6Qj7O1CozxFPMAv5K69UnHLZ6zPlInD8nQqk88JvkpWfko6SAbx5NzV9frvQIPMMQeF
	 Bhdr6B04Q9IlJj4NKdNSL6pC14JHSRayuUy8hcTBpt+tftyxwwPdCW3d2FhgFZwSPaCk8
	 XKvVwbQAB0suTiw6CjErFxc0Y2co2bqmYmxhvpp6RrW9U77xcNnyTbnU0JlJz7VWfUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566837;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/ahb376Rz+D6TMMsATtsk3gaJYuApWj7VVw0DDRorjA=;
	b=0TPynK4RipC8F+r/D9KYB0NCu8Ck0F3tXdZRc+alvokpfsJvqjvVfzCmkmIBZ+MxQ2A4
	 2lQxDySOu90YVKvy9bq2/BkHTNp1HDyiZi+G9u6EQ0qhAE9FIJnLbfT5TrdsCwSzc2JIJ
	 PF0tQYp1I8aguwf9w4wRZTOU1dzs9d7c8Nul97WNWUeJ+RvLfjjV8DUtb6hBQzeNN+nnz
	 DVQR4dmB79HM0Ndw0iM8mBjdOFtd5ZQ/8xmUVFe2lBtFKunB/OUTsjbsZMmhZwRF9/Alz
	 WvJTn1cpWUGNRjm2Z/JumE7M+d8ezilroGL+58n8pDrkVXdCv1lxs0Eo+LfAuPjh6Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b="pwRG6d//";
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25011606A321;
	Fri, 13 Nov 2026 10:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25011606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=pwRG6d//
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1794566812;
	bh=/ahb376Rz+D6TMMsATtsk3gaJYuApWj7VVw0DDRorjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pwRG6d//5gohfuT00uzskQKo2qiqylxw+uEsrHK2JrrtfARMaNrGeiDYOJhDHLJKR
	 hVfcRl8Ttk+3SQedQEgVjB/KsbDm5a761Q5cUYvxkRNmIPPySSeWCEH+O8+JkM7zMj
	 otxfjjZu/KLszbGEyielMqHbNr0h3vBi8KNwAqGI=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.174])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6ADAkoUr009632
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 11:46:52 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, simon.schippers@tu-dortmund.de,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] veth: wake the peer txq when deleting NAPI
Date: Fri, 13 Nov 2026 11:46:48 +0100
Message-ID: <20261113104648.225983-3-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
References: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
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

Since commit dc82a33297fc ("veth: apply qdisc backpressure on full
ptr_ring to reduce TX drops"), only the peer's veth_poll() wakes a txq
that veth_xmit() stopped on a full ptr_ring.

If veth_xmit() stops the txq after the last poll before napi_disable(),
its __veth_xdp_flush() can no longer schedule NAPI. Nothing wakes the
txq, also not after NAPI is added back, so the device stops transmitting
for good. This can happen whenever the peer deletes its NAPI: when it
goes down, turns GRO off, detaches XDP or reduces its RX channels.

Wake the peer txq in veth_napi_del_range() once NAPI is deleted, also
when the peer is down, as opening it does not restart its queues.

Reproduced in virtme-ng with a pktgen flood while toggling GRO on the
peer, with a udelay() before netif_tx_stop_queue() to widen the race:
the txq got stuck within four toggles without this patch, and not in 300
with it. Without the udelay() it was not hit in 1200 toggles.

Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---

Notes:
    Reproducer (needs >= 3 CPUs). The race only triggers reliably with the
    debug-only hook below, which widens the window before
    netif_tx_stop_queue(). Run as root:
    
      # stuck within a few toggles without this patch, never with it
      ./repro-veth-napi-del-txq-stall.sh 300 2000
    
    Debug hook (not for merging, indented so git am skips it):
    
      diff --git a/drivers/net/veth.c b/drivers/net/veth.c
      --- a/drivers/net/veth.c
      +++ b/drivers/net/veth.c
      @@ -29,6 +29,11 @@
       #include <linux/net_tstamp.h>
       #include <linux/skbuff_ref.h>
       #include <net/page_pool/helpers.h>
      +#include <linux/delay.h>
      +
      +/* REPRO ONLY, never to be committed */
      +static unsigned int repro_delay_us;
      +module_param(repro_delay_us, uint, 0644);
    
       #define DRV_NAME	"veth"
       #define DRV_VERSION	"1.0"
      @@ -402,6 +407,8 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
       		__skb_push(skb, ETH_HLEN);
       		/* qdisc requeues the skb on the txq it points to */
       		skb_set_queue_mapping(skb, rxq);
      +		if (READ_ONCE(repro_delay_us))
      +			udelay(READ_ONCE(repro_delay_us)); /* REPRO: widen window */
       		netif_tx_stop_queue(txq);
       		/* Makes sure NAPI peer consumer runs. Consumer is responsible
       		 * for starting txq again, until then ndo_start_xmit (this
    
    repro-veth-napi-del-txq-stall.sh:
    
      #!/bin/bash
      # SPDX-License-Identifier: GPL-2.0
      #
      # Reproducer: a veth txq stopped on a full ptr_ring stays stopped after the
      # peer's NAPI is deleted.
      #
      # veth0 (init netns, pfifo qdisc, pktgen queue_xmit flood) -> veth1 (netns rx,
      # GRO on, threaded NAPI). Needs at least 3 CPUs. The ring fills, veth_xmit()
      # returns NETDEV_TX_BUSY and stops veth0's txq until veth_poll() wakes it. GRO
      # on veth1 is toggled off and on, which deletes and re-adds its NAPI. If the
      # txq is stopped after the last poll's wake check, nothing wakes it and veth0
      # stops sending for good.
      #
      # Usage: repro-veth-napi-del-txq-stall.sh [iterations] [delay_us]
      #
      # delay_us > 0 writes veth.repro_delay_us, a debug-only hook (not part of any
      # patch) that udelay()s between the ring-full check and netif_tx_stop_queue()
      # to widen the race window.
      #
      # RULES (default 50) nft rules in netns rx slow the consumer down.
      #
      # Exits 1 if veth0 got stuck, 0 if it survived all iterations, 2 if the ring
      # never filled.
    
      ITER=${1:-300}
      DELAY=${2:-0}
      RULES=${RULES:-50}
      PG=/proc/net/pktgen
    
      cleanup() {
      	echo stop > $PG/pgctrl 2>/dev/null
      	wait 2>/dev/null
      	ip link del veth0 2>/dev/null
      	ip netns del rx 2>/dev/null
      }
      trap cleanup EXIT
    
      sent() { tc -s qdisc show dev veth0 | awk '/Sent/ { print $4; exit }'; }
      requeues() { tc -s qdisc show dev veth0 | sed -n 's/.*requeues \([0-9]*\).*/\1/p' | head -1; }
      rx() { ip netns exec rx "$@"; }
    
      # Threaded NAPI pinned away from kpktgend_0 (CPU 0), so the consumer can poll
      # while the producer is between the ring-full check and the txq stop
      gro_on() {
      	rx ethtool -K veth1 gro on
      	rx sh -c 'echo 1 > /sys/class/net/veth1/threaded'
      	taskset -pc 2 "$(pgrep napi/veth1)" >/dev/null
      }
    
      ip netns add rx
      ip link add veth0 type veth peer name veth1 netns rx
      ip addr add 10.0.0.1/24 dev veth0
      rx ip addr add 10.0.0.2/24 dev veth1
      ip link set veth0 up
      rx ip link set veth1 up
      tc qdisc replace dev veth0 root pfifo limit 1000
      # pktgen skbs have no socket, so veth only takes them to the ring without TSO
      ethtool -K veth0 tso off
      gro_on
    
      # Slow down the consumer so that the 256-entry ring fills up
      rx nft add table inet slow
      rx nft add chain inet slow in '{ type filter hook input priority 0; }'
      for i in $(seq 1 "$RULES"); do echo "add rule inet slow in meta mark $i drop"; done | rx nft -f -
    
      [ "$DELAY" -gt 0 ] && echo "$DELAY" > /sys/module/veth/parameters/repro_delay_us
    
      echo "rem_device_all" > $PG/kpktgend_0
      echo "add_device veth0" > $PG/kpktgend_0
      for c in "count 0" "pkt_size 60" "delay 0" "clone_skb 0" \
      	 "xmit_mode queue_xmit" "dst 10.0.0.2" "udp_dst_min 9" "udp_dst_max 9" \
      	 "dst_mac $(rx cat /sys/class/net/veth1/address)"; do
      	echo "$c" > $PG/veth0
      done
      echo start > $PG/pgctrl &
      sleep 1
    
      echo "kernel $(uname -r), iterations $ITER, repro_delay_us $DELAY"
      echo "after 1s flood: sent $(sent) pkts, requeues $(requeues)"
      if [ "$(requeues)" = 0 ]; then
      	echo "ring never filled, raise RULES"
      	exit 2
      fi
    
      for i in $(seq 1 "$ITER"); do
      	rx ethtool -K veth1 gro off
      	a=$(sent); sleep 0.3; b=$(sent)
      	if [ "$a" = "$b" ]; then
      		echo "STUCK after $i GRO toggles: veth0 qdisc sent nothing in 0.3s"
      		gro_on
      		sleep 1
      		echo "still stuck with GRO back on: sent $a -> $(sent)"
      		echo stop > $PG/pgctrl; wait
      		sleep 0.5
      		ping -c 3 -W 1 10.0.0.2 >/dev/null 2>&1 &&
      			echo "ping: ok" || echo "ping 10.0.0.2: fails"
      		tc -s qdisc show dev veth0
      		exit 1
      	fi
      	gro_on
      	sleep 0.05
      done
    
      echo "OK: veth0 kept sending through $ITER GRO toggles," \
           "sent $(sent) pkts, requeues $(requeues)"
      exit 0

 drivers/net/veth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 62a60a033675..faa837acea7b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1087,6 +1087,7 @@ static int __veth_napi_enable(struct net_device *dev)
 static void veth_napi_del_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer;
 	int i;
 
 	for (i = start; i < end; i++) {
@@ -1099,11 +1100,17 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 	}
 	synchronize_net();
 
+	peer = rtnl_dereference(priv->peer);
+
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
 		rq->rx_notify_masked = false;
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
+
+		/* veth_poll() can no longer wake a txq stopped on a full ring */
+		if (peer && i < peer->num_tx_queues)
+			netif_wake_subqueue(peer, i);
 	}
 
 	for (i = start; i < end; i++) {
-- 
2.43.0

