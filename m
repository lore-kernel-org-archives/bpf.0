Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224251;
	b=kNUWwmhHNqs/8/2j0KfoVqasixzalY3/VmhgX/Yn38tJ0YOlGC/lOCgeO+FPjPUuKfUt
	 JopPuwl9M58lksUe73XZ1y60+JDe29+Z+wK1mMNsBT4beCTn1ODhuHFMe7JdEQoJsixQE
	 bPNZlvCdExrLTmz+hZIa3MZljWs+q9RIMloI+q88HFqANQw9e5fppFTkOuueylzXn4rUM
	 ZKBNvQMYruD0vg41Xjo5W73BMk44Qw2B3qABOmTWSPYLd8VAqrGqpFPORcdOoiwpcFyxA
	 rXedmQP+wzw9S7wHa4mT+wP/uxeJtGhhXCERIxTFU0riQj2J7xzIZ1AmNdwOa99TcdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CgSRkrT3C0ViBLHE9DlJxbToE1aRxdogX3+8Kv7zlYY=;
	b=izujngZuEJIdbu59EcVJEZTvt6jPk5tH7274EdSAw23nDW4vo9Kn7lnO+Ved0awNoumj
	 EpA9tDrpjBNlnbE41FPo6r5e3ETIzRQywcp0mS2gc5Y1sIfI3QH+LFbVUBmnf390WCM/3
	 ag7+ym3byRQpP7FlAGlTLtHPuXYG/BqEGeTkYS5bBFwmLuoPUWyZBNJDfVHIx+mOtP0eK
	 35g7gWXuYgq943PEZWmkpP/BrVwBrYLDFZbmItjx2nmmlGXAGYbQcNhNRi+54ETjqW6sO
	 2X/OxpUzkyZPJxuQDZQJu37U+VNUnfb61lg7xhCm+qjZylfRPWeki4JXlxkHGuVsqyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QTgeak9m;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC689606A688
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 01:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC689606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QTgeak9m
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50aaad19fbso180757066b.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 17:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795224247; x=1795829047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CgSRkrT3C0ViBLHE9DlJxbToE1aRxdogX3+8Kv7zlYY=;
        b=QTgeak9mIs1Z8LVAaKgxdPGIhe77qyXmkMZCK4Wshq4NMtZVSLO6R8rxQwUG7Q2w/n
         C1xC+tnusGY7NKssSWETx78hJWC79i1zwyoWNb6kHGOQvx9t4M/nGuwb3JAOE03ZKiNf
         iLAGdxwXD1BhXDQbhJFeFwrB1+NMibLxhZ9xUqliWXDRCjGyZgIGUfb2F1S3GP00NdV0
         bxGILYSTRRgko/IBHMchgMsG8nvuVMRIqNSkYOLZvBf+hT0nIxdKdDRKaEuXJcrO/sol
         9hRVVkREtwFLhwURR9DnI1gq99ih5p6ByOY6ffTsPu4OfSiFcK5FH9mr1K+0znwZ4dVE
         AuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795224247; x=1795829047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgSRkrT3C0ViBLHE9DlJxbToE1aRxdogX3+8Kv7zlYY=;
        b=mAOrdoCU8aH3miXCwbXbjLjWBHNnUyGFpiX+EhLHxJ2Q+8fAwufP/BIU6MEJv8b969
         14m9af1Zb/W5BZAyfDfPluX6UtK/MaVcmAxj4i+gqmRdcxlKSUCBMRr5eYcw37eHlvGH
         IB8RExNIcinRQNuUXwPgR9YDPcV8J8Zx5szAtaiv8qs8Meq+gRwy0gEIpZV/Ct0zG7Bc
         HaJXq5s1s6qnkUPhINriyptnC3TASvQR6pQt7udUv3msghGU6JoBOGfZ9xvFCfk1EPE+
         jZiFUfCTBWY/e1BIpVbu8N5FeZGWXBBd+1N6RvWB1av+lzCRJ2+7doU+8DUrdgrhtsKd
         OfcA==
X-Forwarded-Encrypted: i=1; AL+hErHtpMwPRboZ8kx0EqfPs+zLNX2dON70Una/XvHvYfu+UUiVjG2i2NB2IVMlaE17vXZ6KC0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/icfC0K3dfH5vy3dzzszHUPvMpGZyrO1q+quv+5MW7dmkFOLCf
	4XFCuTBptSD7fcjZzuKPAq+4HtNK13kylaBUWZbRCO5yHW7Bc0Xck3sxeTHVAtiVQCg=
X-Gm-Gg: AYBFou3xHNaUeF2zT/U1peRa3AkkBQwAztQ0XddQVypaFtZfq2OPlW0R/crg8xMs1kQ
	Vx02HcJXP4+TJIhrW3T49Ns/oGF5QrtAPXKjIvDS3+oVdCLs45XsEfF1FjhPwg/jQDT0PFV/Vqf
	E1P1MTbt+esXfJ07eT//oTI1XaiuhML8my+bjPdQ9gRsbrRZB3E/gDQB3CgOT0lvKa/lWwP8GAo
	od0tLw0SqoDOZIttZRecY+ajdiW/vfsVWo6aJqcLLk4+xCSOE93KyespORsv5i0bB93+wus10NE
	V4binYjRtXlfDnjXEOp5CXA5m5QK9fZuS4i4yZFXAl2zlnsmSdjfvNpPddPr6R65dDJFlKJZGmS
	pFWp5yQt9lmOlT2+v0bqc63KdapIeBiU5UyizNCK7BHJVsFXVU8hprhjuox2Ef4mJH9TMA6G9sH
	FcCEylTi4CyUvP0XqntvEoMZ5LySBuE2WAQH7W59LwVXMz2XRB/+Ptijo3A3X7TqpEUYq8oj4bJ
	KGoeASpX5PjwhI1gdHcCR+/Ie12Ab9H5lnxO/l57qXs434DK8Rk/TXxhyfHcfErizY9o/RSVUQs
	nOVXeXAtn+8aYMDA3mPSXpiGA2pqc4ZZe2JvyTPLs7Yod/DCg8bfvKOpXw==
X-Received: by 2002:a17:906:7944:b0:c50:564b:c63 with SMTP id a640c23a62f3a-c513a43559cmr500636266b.6.1795224246891;
        Fri, 20 Nov 2026 17:24:06 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6872asm143855266b.13.2026.11.20.17.24.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 17:24:05 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Sat, 21 Nov 2026 01:24:02 +0000
Message-ID: <20261121012402.84848-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
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

On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
that the hardware computes over the received frame. If an XDP program
changes the packet and returns XDP_PASS, that checksum no longer
matches. The stack then checks the packet again in software and calls
netdev_rx_csum_fault().

On Cloudflare servers, an XDP load balancer removes the encapsulation
of the packets that it accepts locally. Our production traffic hits
netdev_rx_csum_fault() all the time.

Do not use GCS when the ring has an XDP program, as mlx5 has done since
commit 5d0bb3bac4b9 ("net/mlx5e: XDP, Avoid checksum complete when XDP
prog is loaded").

E830 also sets the L3L4P and checksum error bits, so the packet gets
CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810. For example, a zero
UDP checksum over IPv6 is marked as bad and gets CHECKSUM_NONE. A zero
UDP checksum over IPv4 gets CHECKSUM_UNNECESSARY.

Two pending series [1][2] give XDP access to the checksum status.
Neither of them supports CHECKSUM_COMPLETE.

ice_rx_csum() reads rx_ring->xdp_prog again after the poll loop ran XDP.
While ICE_VSI_REBUILD_PENDING is set, ice_xdp_setup_prog() can replace
the program without stopping NAPI, so the two reads can differ. At
worst, a packet in that poll gets CHECKSUM_COMPLETE as before this
patch. The pointer is only compared with NULL, so this cannot crash.

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/ [2]
Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
Suggested-by: Jesse Brandeburg <jbrandeb@kernel.org>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
Tested on an E830 (8086:12d2, board N31483-007, fw.mgmt 7.9.5, DDP ICE
COMMS 1.3.63.0) with an XDP program that removes a UDP encapsulation
header with bpf_xdp_adjust_head() and returns XDP_PASS. The kernel was
based on 6.18.64, where ice_rx_csum() is the same as in net:

- Before: 63322069 netdev_rx_csum_fault() calls in 30 s.
- After: 0.
- Without an XDP program, the port still reports CHECKSUM_COMPLETE.

On an E810, which has no GCS, drivers/net/xdp.py, ping.py and
hw/csum.py give the same results with and without this patch.

Request for comment: I also prepared a drv-net selftest for net-next.
It removes 16 bytes from the UDP payload with bpf_xdp_adjust_head()
and fails if the packet reaches the stack with CHECKSUM_COMPLETE. I am
not sure we want to enforce this for all NICs, so asking here.

 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..ad22d855436e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -123,6 +123,7 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
 
 	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
+	    !READ_ONCE(ring->xdp_prog) &&
 	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
 	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||

base-commit: 92e97d7cffc7ec6adfa4699203c18b1ab0c8b314
-- 
2.56.0

