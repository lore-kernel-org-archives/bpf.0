Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620227;
	b=zT6exuN8NV12Sg2qLjCFKC0mY2ts34CYCPHdl/+sXnc1ya1JbP4Ph7Z/RxGcMIrun8RI
	 TZdoq+SOR6mLNhVOmpT/Xrj9a/UuR2/0od3EbbZW0jr62kW4KtR4xh63LwJz5W764/57U
	 9NFMt1EEUdIS599U7W0XL7ak7pqX0VpE/FFytXYl1i1T/iKKszD5swVfuBWZn18Oo5Qtf
	 1kbURPYMiOgZn/wGxBUjzC2w5NZSvi08Q5yZnYmFKcLt0QxQV4uEf2LEG8GHOHw8QPCQt
	 rHByRqWNzTvzCgaaq1JcKPPMk2OIIt2je9znq8eNXQJrlKmo+aA0M8XJTY6bJ+3uGLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620227;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CA1LadP7NKMAaaB5YYb8cCVZscktvlEkvfaKa5ylWwg=;
	b=jX1kgcHgsK4xcVhadRMlH+3eRJOuWymNypHYEEgpLhkZAM1gnrdyqGeqves3bCcx7I3d
	 s3dGxn+VN0+btEiY28pTwPZNCESun2HDc+xjs51oiojmx31c7nr4yO6hqHpZolEviiUC7
	 9IkXDKH6nriUUpm48THKBrolorKjshS1ODSa80YidMBPu9PKUvgka6q00YzNjW2C9Of9C
	 1HqD/9MwzmnS8CsBQVuQJC7cnETPZeKCSDTmDYWO3QvcFOng+tvZ7e2NPKaUlsL86LsMq
	 sBZzjZda4IfvJDizaLgz6kGrcUqqeoQVB5E2g7fy21Z3L+WUfaYa22Q4nK93WP/TRFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=O2t5jpJS;
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6A606A326;
	Wed, 25 Nov 2026 15:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA6A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=O2t5jpJS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1795620197;
	bh=CA1LadP7NKMAaaB5YYb8cCVZscktvlEkvfaKa5ylWwg=;
	h=From:To:Cc:Subject:Date;
	b=O2t5jpJSHFSf2aPvggx1b43/Nf/2Fgw46VfpEoUKsgtAouupnOW+I5Z3JQmun/lKB
	 cFTqZpl4h5a2OuNk0URSDnDpJqzDVfKjhaelScPaJVKD8zbD8WO9AzUn6KECaJ+6F9
	 iYKdIDThhLIwfGk6QemAB2/cqa//s0m9Vm7cFpvY=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.207])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6APFNERK004665
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:23:15 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net-next 0/3] veth: earlier txq wake and stop under backpressure
Date: Wed, 25 Nov 2026 16:23:08 +0100
Message-ID: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
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

While working on the veth BQL series [1], I noticed that veth was
sometimes faster with BQL enabled than without it. Debugging this showed
two reasons, both in how veth handles a full ptr_ring since commit
dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce
TX drops"):

- With BQL, the completions inside the NAPI loop wake the txq in the
  middle of the poll. Without BQL, veth_poll() wakes the stopped peer
  txq only at the end of the poll. The wake raises NET_TX_SOFTIRQ on the
  consumer CPU, which then refills the ring from the qdisc itself
  instead of consuming. Patch 2 wakes the txq in the middle of the poll,
  so that the producer refills the ring on its own CPU. Patch 1 adds
  PTR_RING_BATCH, which sets the wake point.

- With BQL, veth_xmit() stops the txq after a successful produce.
  Without BQL, it stops the txq only after a produce has failed, so
  every refill ends with NETDEV_TX_BUSY and a requeue, which adds up to
  many requeues under a flood. Patch 3 stops the txq as soon as the
  ring is full, with a __ptr_ring_check_produce() right after the
  produce, as in my tun patch [2].

Here are some highlights for the whole series against net-next, with
fq_codel on a veth pair with GRO on and TSO off, so that all traffic
takes the NAPI ptr_ring path, as with an XDP program on the peer. In a
virtme-ng VM on isolated host CPUs at a fixed frequency, 95% confidence
intervals over 50 boots per kernel, 40 boots for two senders:

  one sender, threaded NAPI     net-next        series
  pktgen, 64 byte UDP           1078122 pps     +24.8 +-0.5%
  iperf3 TCP                      32682 Mbit/s   +1.4 +-0.6%
  iperf3 UDP, 64 byte               362 Mbit/s   +1.4 +-0.5%

  two iperf3 senders, one queue
  TCP, softirq NAPI               25798 Mbit/s  +51.9 +-0.8%
  TCP, threaded NAPI              22480 Mbit/s  +15.0 +-1.2%
  UDP, threaded NAPI                701 Mbit/s  +15.2 +-0.5%

With a single sender and softirq NAPI the consumer runs on the sender's
CPU and the ring does not fill. iperf3 stays within 0.4% there, and
pktgen is 1.8% slower, which I could not separate from a shift of the
code layout, see patch 3. No other regressions were found.

With two senders and softirq NAPI, TCP through fq_codel was 36% slower
than with noqueue. With this series the gap is 2%.

The measurement setup, the test scripts, the isolation of the host CPUs
and the benchmark runs, were done with Claude Code (Claude Opus 5.5).
The scripts are in [3].

[1] https://lore.kernel.org/netdev/20260612083530.1650245-1-hawk@kernel.org/
[2] https://lore.kernel.org/netdev/20260803183641.96882-1-simon.schippers@tu-dortmund.de/
[3] https://github.com/simoschip2000/veth-txq-wake-bench

Simon Schippers (3):
  ptr_ring: add PTR_RING_BATCH
  veth: wake the peer txq in the middle of the NAPI poll
  veth: stop the txq as soon as the ptr_ring is full

 drivers/net/veth.c       | 52 +++++++++++++++++++++++++++++++++-------
 include/linux/ptr_ring.h |  7 +++++-
 2 files changed, 50 insertions(+), 9 deletions(-)


base-commit: 612848d37e68b858e15815175f1c5e609e09d719
-- 
2.43.0

