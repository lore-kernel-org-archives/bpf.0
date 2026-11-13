Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566837;
	b=rXhAvr0PuRVkVq1iMtcSr/UA4earOGjconKX3K8aVRDOeAYZJLoyy4XGehAkqU3P93pF
	 REKWmKEXJ5qLXeI24bCoGCyct3yttzSXTA/dD6+J1avtpN+sC80FcZtN9esYa9+fPemOq
	 NoaaIRxXRzSzRzWU8weOCoT7qyKGRV4d1DTs696HMnV1KNXvYlAe60LoH5Ih9uzwgJa/l
	 UJYedC7FkEq8ukv9lehRihqejtEG+AaPeoVvUWmR/+s9keqpIGidFP+oKgpZub/8oL2oH
	 ackCYIyqlN0ekVAlzLYT4UA4GI6nkd6lfbVhsv8xIwxQJxVtbnlImgUvI0FGa9wJX4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566837;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zMesw8kMwAC7LSBr1G+/AHXBsUwq8J5ni4NAODg0BhM=;
	b=Dvvw+8RwuVDo8StyJCA3lo/8d5FiUwisdmK4lGt5iNdfML543EG+2VUBaqrClEwXLHJb
	 wP4U+OMCngmnuBz9khOTEqlig+Yrzw3XdTpejOKkAshSfL5j8wWaXUw/+bfZwE27YfUeA
	 Q4vumxfc+/BdcROh9oYPMWOJvseYX47IpNZiK9Gu4uplWbKWzEcohze1sj0sM0YWymaou
	 m6YoYoXzDOwOBQfeD0qQ1tkBzRz8wVK8DRJIQO8Dzfurgx89GrzhhzicK2qpViwNJdoM3
	 4WJF1dL8myl8EvgncKD4FJLk1HWU63svTwu/+k5aOJl9w0M2wjPE69+dmoUayO+fGhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=D0FcPnQl;
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B8606A323;
	Fri, 13 Nov 2026 10:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250B8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=D0FcPnQl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1794566812;
	bh=zMesw8kMwAC7LSBr1G+/AHXBsUwq8J5ni4NAODg0BhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0FcPnQlogKKniIyJQh+Ztq3fwe1MO29jmLwiUIR144YdmaTv+FEzHIt7QdYpFML3
	 vHud1j2qgpXff+XztrW35SWAFB6iIaH57DyoFis9gZK1fIEgSWgE+ltlbAwLJrKkgD
	 N0nMx8Mr6zkj3avosa6WqnqRUumV1i+vy3RWxtEI=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.174])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6ADAkoUp009632
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
Subject: [PATCH net 1/2] veth: wake a stopped peer txq beyond real_num_tx_queues
Date: Fri, 13 Nov 2026 11:46:47 +0100
Message-ID: <20261113104648.225983-2-simon.schippers@tu-dortmund.de>
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
that veth_xmit() stopped on a full ptr_ring. veth_poll() skips txqs at
or above the peer's real_num_tx_queues.

If the peer shrinks its TX channels while such a txq is stopped, nothing
wakes it. netif_set_real_num_tx_queues() keeps its state, so once the
channels are grown back, its first skb is requeued forever. With a single
root qdisc this blocks all transmission of the device.

Look the txq up below num_tx_queues instead. Waking a txq that is not in
use is harmless.

Reproduced in virtme-ng with a UDP flood from veth0 into veth1, which has
GRO, while switching veth0 between one and two TX channels: without this
patch veth0 stopped transmitting within 11 cycles in 3 of 3 runs, with
it veth0 kept transmitting through 30 cycles in 3 of 3 runs.

Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---

Notes:
    Reproducer (needs >= 4 CPUs, no debug hook needed). Run as root:
    
      ./repro-veth-chan-shrink-txq-stall.sh 30
    
    repro-veth-chan-shrink-txq-stall.sh:
    
      #!/bin/bash
      # SPDX-License-Identifier: GPL-2.0
      #
      # Reproducer: a veth txq stopped on a full ptr_ring stays stopped after the
      # device shrinks its TX channels and grows them back.
      #
      # veth0 (init netns, 2 txqs, pfifo qdisc, UDP flood) -> veth1 (netns rx, GRO
      # on, threaded NAPI). The ring fills, veth_xmit() returns NETDEV_TX_BUSY and
      # stops a veth0 txq until veth1's veth_poll() wakes it. veth0 is switched to
      # one TX channel and back to two. If txq 1 is stopped at the shrink,
      # veth_poll() skips it as it is beyond real_num_tx_queues. Once it is back in
      # use, its first skb is requeued forever and blocks the qdisc.
      #
      # Needs at least 4 CPUs. No debug hook needed.
      #
      # Usage: repro-veth-chan-shrink-txq-stall.sh [cycles]
      #
      # RULES (default 1000) nft rules in netns rx slow the consumer down.
      #
      # Exits 1 if veth0 got stuck, 0 if it survived all cycles, 2 if the ring never
      # filled.
    
      ITER=${1:-30}
      RULES=${RULES:-1000}
    
      cleanup() {
      	kill $(jobs -p) 2>/dev/null
      	wait 2>/dev/null
      	ip link del veth0 2>/dev/null
      	ip netns del rx 2>/dev/null
      }
      trap cleanup EXIT
    
      sent() { tc -s qdisc show dev veth0 | awk '/Sent/ { print $4; exit }'; }
      requeues() { tc -s qdisc show dev veth0 | sed -n 's/.*requeues \([0-9]*\).*/\1/p' | head -1; }
      rx() { ip netns exec rx "$@"; }
    
      ip netns add rx
      ip link add veth0 numtxqueues 2 numrxqueues 2 type veth \
      	peer name veth1 numtxqueues 2 numrxqueues 2 netns rx
      ip addr add 10.0.0.1/24 dev veth0
      rx ip addr add 10.0.0.2/24 dev veth1
      ip link set veth0 up
      rx ip link set veth1 up
      tc qdisc replace dev veth0 root pfifo limit 1000
      # veth only takes skbs to the ring without TSO, unless the peer has UDP GRO
      ethtool -K veth0 tso off
      rx ethtool -K veth1 gro on
      rx sh -c 'echo 1 > /sys/class/net/veth1/threaded'
      for p in $(pgrep napi/veth1); do taskset -pc 3 "$p" >/dev/null; done
    
      # Slow down the consumer so that the 256-entry rings fill up
      rx nft add table inet slow
      rx nft add chain inet slow in '{ type filter hook input priority 0; }'
      for i in $(seq 1 "$RULES"); do
      	echo "add rule inet slow in meta mark $i drop"
      done | rx nft -f -
      ping -c 1 -W 1 10.0.0.2 >/dev/null
    
      # One socket per flooder, so that they hash onto both txqs. Unlike pktgen they
      # keep sending while set_channels turns the carrier off.
      for f in 1 2 3 4; do
      	taskset -c $(((f - 1) % 3)) python3 -c '
      import socket
      s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
      s.setblocking(False)
      while True:
          try:
              s.sendto(b"x" * 18, ("10.0.0.2", 9))
          except OSError:
              pass' &
      done
      sleep 2
    
      echo "kernel $(uname -r), cycles $ITER"
      echo "after 2s flood: sent $(sent) pkts, requeues $(requeues)"
      if [ "$(requeues)" = 0 ]; then
      	echo "ring never filled, raise RULES"
      	exit 2
      fi
    
      for i in $(seq 1 "$ITER"); do
      	ethtool -L veth0 tx 1
      	ethtool -L veth0 tx 2
      	# give linkwatch time to bring the qdisc back after the carrier toggle
      	sleep 2
      	a=$(sent); sleep 1; b=$(sent)
      	if [ $((b - a)) -lt 1000 ]; then
      		echo "STUCK after $i TX shrink/grow cycles: sent $a -> $b in 1s"
      		sleep 3
      		echo "3s later: sent $b -> $(sent), $(ip -br link show veth0)"
      		exit 1
      	fi
      done
    
      echo "OK: veth0 kept sending through $ITER TX shrink/grow cycles," \
           "sent $(sent) pkts, requeues $(requeues)"
      exit 0

 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a61842b2585b..62a60a033675 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -984,7 +984,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	/* NAPI functions as RCU section */
 	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
-	peer_txq = (peer_dev && queue_idx < peer_dev->real_num_tx_queues) ?
+	peer_txq = (peer_dev && queue_idx < peer_dev->num_tx_queues) ?
 		   netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	xdp_set_return_frame_no_direct();
-- 
2.43.0

