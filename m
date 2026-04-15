Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311CF328B5E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241631; cv=none; b=ucIJWC2DnXUY7Up+H4H0JGfLrqYW9Ccu4FVTVp9MoYfE0vmZie2KP00v8f44KPVr6iG8GmYrzAw6baj7fh68+f2hm05dKsFOkXIxY1Ftxdry+clNEzSFaJaFb0MS++Agt2LmFE7n1ysJpbE7Q2NZPSomewkeT+ILCMWmSOdSmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241631; c=relaxed/simple;
	bh=hMzjVc3Cn9l85etUK1tHR3p0M0YY8+4rAJHaPUKj5Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GHUx358dhXvvO25YvVZ9N46QilvLO4xSUJKNKAkHtCveEMBkxYcq/E0LbipKQaTxGgISptYnBIOics2xtl+YZdcUXT9ee0rsjLhzlIr2ZUmJ9wfH3bdGmUNbbowUmqU9li1G3cJACagMkSIrHGYkQMn0aN4/1gMb4o/R+BZucDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSS0qaPO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSS0qaPO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b24fdac394so58786175ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241629; x=1776846429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm5iSouNfDbTWxQtC2q/PDgrb7odjtEmqv4Pfv6847M=;
        b=WSS0qaPOpw/wD7pDKo4K34pjkicgIlYdEI+wMXs7jZ1P5Ao3owHB+aGUl3/iVWuOrF
         0XU7HEkJGlQ9y6WCIsgcieoi+bqppZNOPPnUTshNyC41OEYvLas8PctyKpx9O/9jzTOh
         RFO4AIOUfK2IRJT+6IJeM+/gAhayPcwOEQ/E8nf64dcfoVETGpeSTKstCdf3qHzW+bf+
         fl3LnyqytS6PtItXwuZmbwgtd0YkqzigEqXlanoMo7PqDbK9JO3PYTVSnyLrNd0xSNYI
         KyHOa07lGquZbv3tX5RTfYy2Ce2tAdUg4TFaUoD1zfOsgoaG0ZGPb7NS+ZChqP+3p2ws
         KKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241629; x=1776846429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm5iSouNfDbTWxQtC2q/PDgrb7odjtEmqv4Pfv6847M=;
        b=C6XcpW67AaNAzgtm9GHWwG1c19EYuaPi2C8gu8IiKJqAN8kkFsLQP/88FNM1fu00mh
         6pm1v7Ca6K3gn8aQDMyzk6Cv543yvaYTUG/gIf9j8a4Z8NjUHHzSIY4fERtuTDdM+mC9
         NOw962yuKp7KZTc+4hWe35yN22LwYTKPL90KTAByU4O2aF1+RW8U68ElBy6/p1Mp95T0
         E8mxHn1Gm4/JAq1Cmr70gU8FpDsIgio25pxyFyi5sKDvxFo1WgpHU+qVSdhRDzJu+27x
         IFFHvLwYzMtPWfTSI8YeO6IG7PDvAfwtc+iLd20NqA6bibF8vDU8c0GtGofWfJVRN2+a
         TqkQ==
X-Gm-Message-State: AOJu0YwpG3B3t6zzsJxQrQHWVebbjtFcaJ0/7LXqoUCOsXPVtQgtuDy/
	aIbDKKWzJsx8Be+sa+FWYZkTtqxhnSOcEFUgq/Ey/ZIciJGk3m3E8Uh2
X-Gm-Gg: AeBDiesT4UR35za098Z7/ODTlmTglnXdIJw4IkEsen/S7vQrAVJSyci571jB8KGg2Iy
	3FgF2Q5rHzGuJns2wO9/3k7U/0czOk8gOWLc8yVaCZRC+ei8f0rYVIW/OT1e9oqHHXeZfyYpPfh
	e+flh0wL7zBX4dPSF09qBebtl1ljoSCZBSWn+f0pTg3hAnHUvu3IBlo9vKRHkZhjdDBp2C03g0E
	BLyg3zWluwakELphLGiZVqAGUzhXAN+GRpBLMDICVpgrOBD4a3xWbcwMbW9urL8uBJ7IsluiRux
	3P577hhuiwQ90eTtRCt+dHXk5n3JDhvNKu4pXKNvPZnBxI5c0ra6v8aJPrz1EugFFj+Zdh5/x0f
	chi0QRM9uurLjTyL9U00doMi3t24iKSt4CtgbghWUEr2yMSZNeblcvcP7Rv6nrXgnA5PzH6oO3T
	pqN1ABIKPVWYyijf1S1IrbMQB4z8IjOs8MFIcG2xgFSVy0hQBdhUxfCJRFZn/najcpqv55uj49r
	gu/Qb98IZ5cEgtoCHU=
X-Received: by 2002:a17:902:7249:b0:2b2:4cd2:e174 with SMTP id d9443c01a7336-2b2d5aa42d9mr154214885ad.43.1776241629460;
        Wed, 15 Apr 2026 01:27:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 00/14] xsk: batch xmit in copy mode
Date: Wed, 15 Apr 2026 16:26:40 +0800
Message-Id: <20260415082654.21026-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Greetings, everyone. This is the batch feature series. Even though
net-next is closed, I would appreciate any feedbacks and suggestions
on this! Many thanks!

Bottom line up front: it improves the performance by 88.2% stably.

# Background
This series is focused on the performance improvement in copy mode. As
observed in the physical servers, there are much room left to ramp up
the transmission for copy mode, compared to zerocopy mode.

Even though we can apply zerocopy to achieve a much better performance,
some limitations are still there especially for virtio and veth cases
due to the implementation in the host. In the real world, hundreds and
thousands of hosts like at Tencent still don't support zerocopy mode
for VMs, so copy mode is the only way we can resort to. Being general
is its strong advantage.

Zerocopy has a good function name xskq_cons_read_desc_batch() which
reads descriptors in batch and then sends them out at a time, rather
than just read and send the descriptor one by one in a loop. Similar
batch ideas can be seen from classic mechanisms like GSO/GRO which
also try to handle as many packets as they can at one time. So the
motivation and idea of the series actually originated from them.

# AF_PACKET Comparison
Looking back to the initial design and implementation of AF_XDP, it's
not hard to find the big difference it made is to speed up the
transmission when zerocopy mode is enabled. So the conclusion is that
zerocopy mode of AF_XDP outperforms AF_PACKET that still uses copy mode.
As to the whole logic of copy mode for both of them, they looks quite
similar, especially when application using AF_PACKET sets
PACKET_QDISC_BYPASS option. Digging into the details of AF_PACKET, we
can find the implementation is comparatively heavy which can also be
proved by the real test as shown below. The numbers of AF_PACKET test
are a little bit lower.

# Batch Mode
At the current moment, I consider copy mode of AF_XDP as a half bypass
mechanism to some extent in comparison with the well known bypass
mechanism like DPDK. To avoid much consumption in kernel as much as
possible, then the batch xmit is proposed to aggregate descriptors in a
certain small group and then read/allocate/build/send them in individual
loops.

Applications are allowed to use setsockopt to enlarge the default value.
Please note that since memory allocation can be time consuming and heavy
due to lack of memory that results in complicated memory reclaim, it
might not be that good to hold one descriptor for too long, which brings
high latency for one skb.

# Experiments
Tested on ixgbe at 10Gb/sec with the following settings:
1. mitigations off
2. ethtool -G enp2s0f1 tx 512
3. sysctl -w net.core.skb_defer_max=0
4. sysctl -w net.core.wmem_max=21299200 and sndbuf is the same value
5. XDP_MAX_TX_SKB_BUDGET 512

taskset -c 1 ./xdpsock -i enp2s0f1 -t  -S -s 64

copy mode(before):          1,801,007 pps (baseline)
AF_PACKET:                  1,375,808 pps (-23.6%)
zc mode:                   13,333,593 pps (+640.3%)
batch mode(batch 1):        1,976,821 pps (+9.8%)
batch mode(batch 64):       3,389,704 pps (+88.2%)
batch mode(batch 256):      3,387,563 pps (+88.0%)

---
RFC v4
Link: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/
1. fix a few bugs in v3
2. add a few optimizations
The series is built on top of commit 2ce8a41113ed (net: hsr: emit
notification for PRP slave2 changed hw addr on port deletion). Since the
changes compared to v3 are too many, please review the series from scratch.
Thanks!

v3
Link: https://lore.kernel.org/all/20250825135342.53110-1-kerneljasonxing@gmail.com/
1. I retested and got different test numbers. Previous test is not that
right because my env has two NUMA nodes and only the first one has a
faster speed.
2. To achieve a stable performance result, the development and
evaluation are also finished in physical servers just like the numbers
that I share.
3. I didn't use pool->tx_descs because sockets can share the same umem
pool.
3. Use skb list to chain the allocated and built skbs to send.
5. Add AF_PACKET test numbers.

V2
Link: https://lore.kernel.org/all/20250811131236.56206-1-kerneljasonxing@gmail.com/
1. add xmit.more sub-feature (Jesper)
2. add kmem_cache_alloc_bulk (Jesper and Maciej)

Jason Xing (14):
  xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
  xsk: extend xsk_build_skb() to support passing an already allocated
    skb
  xsk: add xsk_alloc_batch_skb() to build skbs in batch
  xsk: cache data buffers to avoid frequently calling kmalloc_reserve
  xsk: add direct xmit in batch function
  xsk: support dynamic xmit.more control for batch xmit
  xsk: try to skip validating skb list in xmit path
  xsk: rename nb_pkts to nb_descs in xsk_tx_peek_release_desc_batch
  xsk: extend xskq_cons_read_desc_batch to count nb_pkts
  xsk: extend xsk_cq_reserve_locked() to reserve n slots
  xsk: support batch xmit main logic
  xsk: separate read-mostly and write-heavy fields in xsk_buff_pool
  xsk: retire old xmit path in copy mode
  xsk: optimize xsk_build_skb for batch copy-mode fast path

 Documentation/networking/af_xdp.rst |  17 ++
 include/net/xdp_sock.h              |  17 ++
 include/net/xsk_buff_pool.h         |  10 +-
 include/uapi/linux/if_xdp.h         |   1 +
 net/core/dev.c                      |  49 +++++
 net/core/skbuff.c                   | 152 +++++++++++++++
 net/xdp/xsk.c                       | 279 ++++++++++++++++++++--------
 net/xdp/xsk_queue.h                 |  40 +++-
 tools/include/uapi/linux/if_xdp.h   |   1 +
 9 files changed, 473 insertions(+), 93 deletions(-)

-- 
2.41.3

