Received: from outbound.qs.icloud.com (qs-2003d-snip4-11.eps.apple.com [57.103.86.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24652C21C5
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781957646; cv=none; b=lQOCmtce57pU7cJK2VF8IbV16JCxF9xzBT3A7PQafWtYwfOta+Y1a3+0c9bXzILXqgqgzDxanhOOiN55PqXPsSS3HHEaxQO2bZ00bUZYgb2IB/t7/XxqLNVopWzSs1UOOcKvOP0vFPFK8il5Y+Hpd60zQLXjwifOXCkVALeVByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781957646; c=relaxed/simple;
	bh=TO9V7ICBl7BLxTNXy7GTCfYh08A04OV/Xuec4UsgoL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CljzD0r+7ik8hTivfUymRiDvWbkJQLNAdA99V0htzG1VHpg+iS3H9xv/uk9vtwfAiCUw4QHm6FHYKZkh6iVHcpe6ZG+gtyllIy1xi5kvm3YXTYGxZBmbbm978U3CzPliOV8oK+N1J3OOaND2dyhoBWZ+zcl+aZiMxvIIcieX9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yGFRFAmP; arc=none smtp.client-ip=57.103.86.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yGFRFAmP"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPS id 5EBD1300017A;
	Sat, 20 Jun 2026 12:13:59 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYLWxcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUKTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRAD0oDXAVaAUIIVgdYBVkFXQtVQARTD1oRSwxbDl4JWzBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781957643; x=1784549643; bh=hLv+QDIV6yKbLR46SmVL6ZfSa2uZ+Go7i+l3zdbv+hA=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=yGFRFAmPH2eFJ95d6yGcShoYxAzsZUepF23pC/DSZOmKdaZ28nbVgQpKv3qfU5g6p5dNkmlYWzXqT4JxCGxnGOmSCJGJtctIi3Y/OxSbwyRNfcAXkYipONX4db0CtmMDYzf3fqkSg6DJ+Vot39a0EYQKWPNYyAEhQfcF/UYT7yppPcN3YMXUCNhI3//+igBkXxox1onjDEiZJIM923GEhr8HeLlU86g9ncvysU84uIQ8DOm71D+iF8U+HvBw8AzptD8ZkbX6Xyn+xhse7+QEqv2Ya9WTEONE4kk42Ky4km335SXSMrLJp1XJQJG72/VKaNYGgsLuQHGZeFjYaUbEAA==
Received: from cibi (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPSA id A28E2300019B;
	Sat, 20 Jun 2026 12:13:54 +0000 (UTC)
From: Siddharth C <siddharthcibi@icloud.com>
To: ast@kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Siddharth C <siddharthcibi@icloud.com>
Subject: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
Date: Sat, 20 Jun 2026 12:13:13 +0000
Message-ID: <20260620121321.45227-2-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620121321.45227-1-siddharthcibi@icloud.com>
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDEyMSBTYWx0ZWRfX3okgtLqLioiV
 wx58s4gTtJgFLcZE++7ScyO2w2mnchhQfFgtcU5eE+f1NW6AEEnB8Gn0+lvTS6HBREkK5lT7RRa
 yQic1xa3KRPKmB0BZpzTWbW8rnDRnMnWhIW8n++7n9Y6jsHt5Lt8Tb1w5+QRfsY//QeQTkP3CQs
 wayfYxpZhzAdtZhPxy7La1drWu2lNcmS891vm9j353KiVI77ov7wrkjyAJucTomb2OvLguc+mRJ
 yLL/oKO6Qd0ft5aGuu4+tL7q/7CEJ8Hctq9TYGTJ/SIImASC3TshWohjPQUBnULebzGDQAc4W3y
 tOsfTs7i7x0tKeOcArc
X-Proofpoint-ORIG-GUID: dOz5sg86ZAWpi_E9P6YBp-5S1KAOVhVn
X-Proofpoint-GUID: dOz5sg86ZAWpi_E9P6YBp-5S1KAOVhVn
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=

Store rx_queue_index in struct xdp_frame during xdp_buff to
xdp_frame conversion and restore it when rebuilding xdp_rxq_info
for cpumap and devmap execution paths.

This preserves ingress RX queue information for XDP programs
executed after redirect, allowing access to the original
rx_queue_index instead of losing queue context.

Also propagate rx_queue_index for zero-copy XDP frame conversion.

Signed-off-by: Siddharth_Cibi <siddharthcibi@icloud.com>
---
 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 5 ++++-
 net/core/xdp.c      | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..90318b2b76dc 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -301,6 +301,7 @@ struct xdp_frame {
 	 */
 	enum xdp_mem_type mem_type:32;
 	struct net_device *dev_rx; /* used by cpumap */
+	u32 rx_queue_index;
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };
@@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 
 	/* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
 	xdp_frame->mem_type = xdp->rxq->mem.type;
+	xdp_frame->rx_queue_index = xdp->rxq->queue_index;
 
 	return xdp_frame;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 5e59ab896f05..8f2d7013620f 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->rx_queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index dc7b859e8bbf..f419fa0e53e5 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -339,7 +339,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 				struct net_device *rx_dev)
 {
 	struct xdp_txq_info txq = { .dev = tx_dev };
-	struct xdp_rxq_info rxq = { .dev = rx_dev };
+	struct xdp_rxq_info rxq = { };
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
@@ -349,6 +349,9 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 		int err;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
+		rxq.dev = rx_dev;
+		rxq.mem.type = xdpf->mem_type;
+		rxq.queue_index = xdpf->rx_queue_index;
 		xdp.txq = &txq;
 		xdp.rxq = &rxq;
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..9691d8dfadf3 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -606,6 +606,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
+	xdpf->rx_queue_index = xdp->rxq->queue_index;
 
 	xsk_buff_free(xdp);
 	return xdpf;
-- 
2.53.0

