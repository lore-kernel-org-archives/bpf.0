Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB340D587
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986576; cv=none; b=hUGPBsHdNqB7tA0j4r3uGIL4GkzniUasQ7m0guF0ks9pcKX0BTpeGuYbHt/LN7phmUYWn56SSJEeH5v8qwN/VBo53fq3aadG2EzUQsGrlA8BjuKY3H71/PlRteDIJTg8OpktwWFALWJkQgjscFuuGRVnwPv7uXL0M44Ruj3MD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986576; c=relaxed/simple;
	bh=LIsuuVFh9rqAnffRRLX7EYaWLpMggrVjylfB5CZ81L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPEHCq4KW9WeqZxHnYbgF8zJJ2boMKMGQvS4XWCidejSZJeKlrKjW1P5kml/6BqU+jgrT4yQL9i8zPMaqZWRNMfqW8txA+M/boNKWEkn0o6uJ5C71XTTYfnLLnt2bonpzZ3fLGAP70TrSRLkzK6BK3kwIRGRlFk+QuVB8A3/GZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=LfyoDid7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="LfyoDid7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6c57c5c07so21425905ad.1
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781986575; x=1782591375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3UyEb8OkZcV7i25lPmBZwX/buS6tC9WTgQg7YwJuto=;
        b=LfyoDid7QHot4e6k7UtzS7ssahbMK9p6kByJryBmu3Nc2OmBH8OzZNFmIa0ksiLs+h
         ZPU3Tx47DZ7vi5/smoXzx/mCAHg4JacGsTR6/XOCn9/J8tozSMJQL3yXhVJEZJL07ylg
         5hV1aWtk7UMQQBBP30VIMDWYCzrVEsCTkcHa4iZkr+jgG0e7uOIrAxtGg2AU11VeFewv
         m8f9fSRzggjIlmbxk3eGcpWdfc29ZqvXA2H5Gxp1N5sIK9ffgKlGxIdDTxF2UwwWwrIW
         7O6HLkb9y/A4EGNmHjDrjlPMrFQwGmxzXoS1Ae2pZqVbxqLZdbcGnYJPO92d5ggTUUaN
         gHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781986575; x=1782591375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3UyEb8OkZcV7i25lPmBZwX/buS6tC9WTgQg7YwJuto=;
        b=az9qaLqiFMNXd2tL+udthRQg5izpMFxjcbXmQ2ojR2xu3sc0J6+iGzeky0bCI/t/am
         vyxJ+kOWeoHPSMPHPnCRJ1XpoQVpBOj4Xs2TPeoftzcReuB1R+7iUu/EwiiiV3IqARGC
         FbWEJ0ieS46Xq39Pj6pwdTQc0HEKT5OKzSVzXeLLT0Vm7MBP7EgW9x95H4vnM6sk8bjq
         apU/ZbJNPZE3xlJK3O1LcK8Bpub+rJymbFDJpvmoVn0+V78m/CRSh+Av7LF6baIGUEUX
         6BvaJ7KkeZ12EZRG8MqCd+4BNKpta/FC4NdRLbWWvJWpSoQt+BIlRE9vUM0rlXXDa1ZY
         Xb6w==
X-Forwarded-Encrypted: i=1; AHgh+RpDAvC9odi4SWI3K5Xx2myege1ieIGp8xGt+42KYdLOId8+0QpConYX5U5xjpFci+QzfmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVux/PHB8gmjSkMTFnbY+UzYDO8NEifco1wmj885k8eWiWp/5
	lXYKMHZPQpGh1BB5tZwJ1C+dTXKGHiHWRpYTYA8k39rZj1onr7AD4Dz/7ID+FpqAhA==
X-Gm-Gg: AfdE7clsWwHuxYyfcr+rhTscqo6bKlrlYex/rZb+8stdmJUGm86OKR04ze39OCRm/ch
	8iXsvSEtjUYw88lLqK6bNl1Nu0590R9dkQWlp6JlWnRPP9kxFWpLnzXhQ/201idGjRRq9/imgTP
	KYv5wheADcaH4fHP/KdIPXW2yqnKcq5dhKRxU9XszrQxBuSF9L5dNom+1KM3VbViof4R3KilVOb
	oJidGGz+B35g6NMFGXB347QasHlVWBS7WC9w22A/LvOopJeOM1wbpsKRx2gHRPVloHqz5FSKvLO
	n/dN4FE7WZrIwUV3u8Syg+bKmvHdkF6Ry2XHdNyIy7vwdoaXhsqs6PVQksbiyl7vcwm9IW7BCeI
	kQI+YyVZ6FwRI08kPJjExEDzCzlwwLam+I1PgaAiHyD+cevLthb2bUTHmbQ/3nhn8RooGQThYlQ
	==
X-Received: by 2002:a17:902:d509:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c718fc247amr88629605ad.35.1781986574669;
        Sat, 20 Jun 2026 13:16:14 -0700 (PDT)
Received: from p1.. ([172.56.104.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85a4sm31747095ad.54.2026.06.20.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:16:14 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Jussi Maki <joamaki@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net, bpf: check master for NULL in xdp_master_redirect()
Date: Sat, 20 Jun 2026 13:15:31 -0700
Message-ID: <20260620201531.180123-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_master_redirect() dereferences the result of
netdev_master_upper_dev_get_rcu() without a NULL check, but that helper
returns NULL when the receiving device has no upper-master adjacency.

The reach guard only checks netif_is_bond_slave(). On bond slave release
bond_upper_dev_unlink() drops the upper-master adjacency before clearing
IFF_SLAVE, so an XDP_TX reaching xdp_master_redirect() in that window
still passes netif_is_bond_slave() while master is already NULL, and
faults on master->flags at offset 0xb0:

  BUG: kernel NULL pointer dereference, address: 00000000000000b0
  RIP: 0010:xdp_master_redirect (net/core/filter.c:4432)
  Call Trace:
   xdp_master_redirect (net/core/filter.c:4432)
   bpf_prog_run_generic_xdp (include/net/xdp.h:700)
   do_xdp_generic (net/core/dev.c:5608)
   __netif_receive_skb_one_core (net/core/dev.c:6204)
   process_backlog (net/core/dev.c:6319)
   __napi_poll (net/core/dev.c:7729)
   net_rx_action (net/core/dev.c:7792)
   handle_softirqs (kernel/softirq.c:622)
   __dev_queue_xmit (include/linux/bottom_half.h:33)
   packet_sendmsg (net/packet/af_packet.c:3082)
   __sys_sendto (net/socket.c:2252)
  Kernel panic - not syncing: Fatal exception in interrupt

The missing check dates back to the original code; commit 1921f91298d1
("net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master")
later added the master->flags read where the fault now lands but kept the
unconditional deref. Check master for NULL before use; a NULL master is
treated the same as one that is not up.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 40037413dd4e..6037860d5283 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 	struct net_device *master, *slave;
 
 	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
-	if (unlikely(!(master->flags & IFF_UP)))
+	if (unlikely(!master || !(master->flags & IFF_UP)))
 		return XDP_ABORTED;
 	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
 	if (slave && slave != xdp->rxq->dev) {
-- 
2.43.0

