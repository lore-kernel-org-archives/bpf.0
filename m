Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605889;
	b=rsj+ftlDM4hDQd4BaFWtXIQWkCo/XrBTAUmmLV306dHunK+Vla8RVfB7BGSCg4Faxpyt
	 FtUMeCr95oqx3COdRWP5OqnBjpd5FAN1uUVrNSD2dxh4zBlMcqjIPhHI/e/pQL3Fj1Y8w
	 G2fAh9Lg+m+9KIjUftU3Tm2sZs18mVKKdbpleQBawNiB5MtZGwfHuiQ0FHAGcCEXmI6te
	 lZo6N3cCNubJkmfBR+JW1xWpqpyR3g8ecmJVePfPY0jwUIpXDSAfVH/XudWkoT8x4Hq8B
	 pm43KOvYhtMZmxoJkbVC/qsS7m4sx7uZ9iaBQQgFJVV5IqxOnrGY/GYsDVaTqvjNNJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IKh826oksAsnXOv/8mkzFjoflIikbvfEEGMxfs2JQRg=;
	b=j+DLPT1EiMVKHhhobf0vxpFE1tfJUAdocr9LxuQl091BLDmiCXt/UdkAbUCRfOadMDaS
	 ZzvGjFDKd+QlkxIj8HGCnMGuhIHJjUJG3UkmruTfMyqJ9RqWW4eBeHfuE1GQFZKm6y11i
	 VdVvAVaGZbXtGsXK01TSWFOes4HgAUyJ+N81AKUUC3Oc8MH/PR6h85wv6ie8rLnXAQR1w
	 Z0c18d3ULpUQHJv+uebC0bwyWIxk9FZ6aQFNEQ4ESfUt6c2HynJhMtSTzaCQrMb4en3ow
	 RX83//S+BZyHb/2+S9/xPSzsLsI3VAcNQISm56cjmdL1VcmTv/q/7yXDPQxPcKpnxpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWik3WnI;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B04606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35B04606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWik3WnI
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so1387835e9.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605886; x=1793210686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKh826oksAsnXOv/8mkzFjoflIikbvfEEGMxfs2JQRg=;
        b=CWik3WnIyChRkJiFjDby8AUm4P72t6GJlKKoLll9tcfUvy8nMdm6quUdw7bOp/Cdrj
         tnUONVfLRoDkwRY2U+J/41ipIVdLv2vw5v+ZP81cljtyAGPbU98VqDIbMpGcrWZjS+1h
         iUAag3s3ynMam7T5pk9UvjlcULGuIT4hot2neeVAts+OdV4zWf5icj27TPOMTMFi+iZX
         jPAWYgjWLqcSBjQ96JBu+RIbCpJosQCL8pYnhhq/MUw7dsvXQsFmorTyZz3NKMYKnfIF
         D/5TKGNf43tNXTrhdhCsVNVMvmn17vufPhh0YHUGqo7ej5u4G8muH4oukSj5wetRJ/l1
         quaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605886; x=1793210686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKh826oksAsnXOv/8mkzFjoflIikbvfEEGMxfs2JQRg=;
        b=OcTA7HFVpsN1AAkGBIDpPi+lpW6T/QVROhstblQViUfhId7D6hDfsnQn7XgJsnuBmz
         hoNrHYTafYG9be3CRJrMTam6Bpqjt/smzTEIdJ+FtKfGPzd5ARDCo9EOx8yexddzOGjp
         7nOHtC6lacgvWKGNNiyPSB/v68Mcjh8gkRFuNDD5F4NxaNXc65rCP95hhybtg5wR3wx8
         L1TToXeGncFLmNqy9c+o6rZ2VJSLS9U4PJ+0rZ8jqcSl0OHCTuQCPnX7lCwig8GP8vtR
         L2c9lsyiT2tkxTSaCTLDArhAkCWVeeFdoV9t39rDESJndmgL7DjO+/lNpcShjJ4ujEDE
         vhGg==
X-Forwarded-Encrypted: i=1; AKwUvBzbwyNoHgZTizBFQikzLyykGPxgrfwgYMx5FCs2FuX/fdK1aFZEeDndpsf5DSx/MuNXpKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfdJkPITXTWJa+4YOa1NWLaQJFPCKlODKitzyEOEMB7/FK73R2
	pp3OaeNDPXYcs9s4p+muJXS2Xwn85xT+VxnVhYGIvbs2lOxxN19qQ5VN
X-Gm-Gg: AYBFou1roGJ3eZ3jwS2qsQSvGjB5WkTd1b2TPkUm+ID5zhHsy7jg3kx/iCzx20ZdFtv
	Vhl4SP0ZY+w5lh9YMLQztrsTCY5CkaFgCc7HcdqsUNGSgFf/Oqko8OFPWAVYsaBtXb28qSuvwIF
	xYMHeqpB+xCaM1urfMY5LIlIKx8Pjk02IISsYej8bNxO3k1CXwujaU0jAyQXoxCUoQy1N2lcJUD
	sidheYQRRaLPmtdLcNsRj/h5NOwkH8LTdMo+7hAphS7TG/AwJRAzQcxCj0zoyJQ0Gh6xpb+lkMA
	F2sNfiKVc1aI2Ef/h00DOlXtQ8vM413RQdJHvaU/gFwUhbXRSXhGbfpmW0R2CBkzkFyrLzE6w4a
	5hQW7HAOEL50XR1sOstbWM2QLXcPI3+PX+Y3/ex/mgMvyxJWBwWMNXyFAd/mmHxUbTKZ6RTXeQv
	4IfSXa8JWVaINe3Tj/aUlS+Xrud52WDGAD+sss5NfGv4AQas1OJ1uRlS90B9q5WqHJ9ISKKqhc6
	yJyE8/tQbo6dWvqj9JVtj8oIknUoV2EKSJcS2Px7ZYvMVhs3EhkxXX+OueAuBjECpuZfuttIXhF
	eovqqihWlbR0cveBCV7kreF1/tHNiZ9j2PRVNm67AaKOsbQ7Hu8aDtj+d3dgh1S+ldsfNs5vNpz
	aK4bXCtURsIKz7ew5SX2onZUDU6+4/vxL
X-Received: by 2002:a05:600c:a48d:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a204bb59aamr2067385e9.16.1792605886218;
        Wed, 21 Oct 2026 11:04:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:e6ea:6401:f04a:ac6f:988e:f33d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd13891sm47007775e9.2.2026.10.21.11.04.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 11:04:45 -0700 (PDT)
From: Nick Simpson <nick.simo@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Sridhar Samudrala <sri@us.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] xsk, ipv6: validate user-supplied checksum offsets
Date: Wed, 21 Oct 2026 19:03:26 +0100
Message-ID: <20261021180329.26358-1-nick.simo@gmail.com>
X-Mailer: git-send-email 2.50.1
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

In copy mode, AF_XDP turns the csum_start/csum_offset of
XDP_TXMD_FLAGS_CHECKSUM into a CHECKSUM_PARTIAL skb after checking only
that the checksum fits in the frame. Sent over a veth into a namespace
that forwards IPv6 with nf_defrag_ipv6, the checksum is then completed
after the forward hook has accepted the packet, at an offset in the IPv6
header chosen by the sender; with csum_start before the network header,
skb_checksum_help() warns. Patch 1 has the details and the trace.

This is the AF_XDP counterpart of the virtio_net_hdr issue fixed for
IPv4 by commit 6785011f8b16 ("ipv4: validate checksum_start before
completing checksum") and addressed by the "more virtio-net csum
hardening" series [1], which does not cover AF_XDP.

Patch 1 is the fix: CHECKSUM_PARTIAL is kept only for the TCP or UDP
checksum of an unfragmented IPv4/IPv6 packet, not IP-in-IP or GRE
encapsulated, on an Ethernet device; other requests are completed in
software at the sender. Frames without a linear part
(IFF_TX_SKB_NO_LINEAR) are left unchanged. One visible change: a request
on a frame that is itself an IP fragment is completed over that fragment
alone, as a device would, so the reassembled datagram no longer has a
valid transport checksum and conntrack marks it invalid; before, if
every fragment carried a request, it stayed CHECKSUM_PARTIAL and was
completed on refragmentation.

Patch 2 documents the new behaviour in xsk-tx-metadata.rst. It is kept
separate so that patch 1 stays within the stable size limit.

Patch 3 is defence in depth: the IPv6 counterpart of
ip_check_csum_start() on the two IPv6 fragmentation paths,
ip6_fragment() and br_ip6_fragment(). For IPv4 the check is also
called from nfnetlink_queue, xt_CHECKSUM and xfrm_output; their IPv6
counterparts are not changed here, and a check at reassembly time would
cover more. Patch 1 does not depend on it, and it is not marked for
stable.

Testing, on netdev/net 82e31923c055, arm64 under QEMU:
- reproducer (fragmented IPv6/UDP over veth into a namespace with an
  nftables forward rule on "ip6 saddr", csum_start/csum_offset 22/22;
  an unfragmented packet with 14/22 and TX checksum offload off on the
  egress veth; csum_start 20): without the series the source address is
  rewritten after the forward hook accepted the packet, and
  skb_checksum_help() warns. With the series, or with patch 1 alone,
  nothing is rewritten after the accept and there is no warning; with
  patch 3 alone the fragmented cases are not sent on (ip6_fragment()
  drops them) and the unfragmented case is not covered
- a legitimate IPv6/UDP request (csum_start at the UDP header, offset 6)
  is still sent CHECKSUM_PARTIAL and delivered to a UDP socket
- which requests stay CHECKSUM_PARTIAL, observed on the veth peer with
  PACKET_AUXDATA: IPv4/UDP, IPv4/TCP, IPv4 with options, IPv6/UDP, IPv6
  with a hop-by-hop header and VLAN-tagged IPv6/UDP stay partial; a
  wrong csum_offset, csum_start in the IP header, IPv4 and IPv6 first
  fragments, IPIP and ICMP are completed in software with the correct
  value. Without the series all of them stay partial.
- tools/testing/selftests/bpf: test_progs -t xdp_metadata passes with
  and without the series
- on a kernel with KASAN, PROVE_LOCKING, PROVE_RCU,
  DEBUG_ATOMIC_SLEEP, DEBUG_PREEMPT, DEBUG_PAGEALLOC and
  DEBUG_OBJECTS_RCU_HEAD, no warnings: with the series, the
  reproducer, the classification test and the selftest; without it,
  the selftest and the legitimate request
- W=1 and sparse (C=1) on the changed files in allmodconfig builds for
  arm64, x86_64, i386 and s390: no warnings, with or without the
  series; checkstack unchanged; arm64 allnoconfig and an INET=n build
  with XDP_SOCKETS=y build; checkpatch --strict is clean; htmldocs for
  networking builds without warnings for xsk-tx-metadata.rst
- arm64 allmodconfig and allyesconfig with W=1 build, with no warning
  in the changed files (CONFIG_WERROR and the DRM *_WERROR options
  were turned off: with gcc 15, existing W=1 warnings in unrelated
  files otherwise stop the build)
Not tested: IFF_TX_SKB_NO_LINEAR (virtio_net) devices, multi-buffer
frames, an attached BPF flow dissector, a sender in an unprivileged
user namespace, x86 at runtime, and patch 3 with tun/tap or packet
socket sources of CHECKSUM_PARTIAL (the same header rewrite through a
tap device was reproduced on mainline earlier, but not re-run with
patch 3).

The issue was found, and the patches and tests prepared, with LLM
assistance (see the Assisted-by tags). I have reviewed the changes and
the test results. A reproducer is available on request.

[1] https://lore.kernel.org/r/cover.1792411304.git.mst@redhat.com

Nick Simpson (3):
  xsk: validate checksum offload requests in copy mode
  xsk: document checksum offload handling in copy mode
  ipv6: validate checksum_start before fragmenting

 Documentation/networking/xsk-tx-metadata.rst |  7 ++-
 include/net/ipv6.h                           | 12 ++++
 net/ipv6/ip6_output.c                        | 10 +++-
 net/ipv6/netfilter.c                         | 10 +++-
 net/xdp/xsk.c                                | 58 ++++++++++++++++++++
 5 files changed, 90 insertions(+), 7 deletions(-)


base-commit: 82e31923c0553fdbfcddcd910ca07952880ca9b9
-- 
2.53.0

