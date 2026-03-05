Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430039C64D;
	Thu,  5 Mar 2026 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711114; cv=none; b=uU8Igd3jm8eeYIS2FLlJU/J0N4xHwxw3xCkDZla885D/yowB5Kq7SvmRyakSD8GPt0+ZRIFUQgxCYFFw4M+jd6ghxVclSC07ioGHL1GD6EW0tm+E+bjZI7xwP6AtaPSGl4Dr6e/kJQ8suGxOccvgXVyWWJ5ZyzUbLd+ZgocdGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711114; c=relaxed/simple;
	bh=TZEXOfIR3nqd7pS9W9oFFIwS02GXdOuLJMeGp51CQyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGyyIDDpRvR6Fy1fH8QTP3RgpumNrox6fpLaC5Qa/z4puerJI2ocWn8lu98bbGriLgwrR5uPVtQmQi+XHjwZRXTpOkMBScCDtKWPt2eMV6nOSU0rEm1Mur18TekiDWbwhGfMiVkApb+9vxL+n2JFS8Re6cERoc1sPc1gDyjcd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKaf1Itq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKaf1Itq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772711114; x=1804247114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZEXOfIR3nqd7pS9W9oFFIwS02GXdOuLJMeGp51CQyU=;
  b=oKaf1Itqm6TNixsL57z9q8HtEzYin8M/xTYtuwl/aBY6C6aeiim1itzA
   pQ7L34OucXcA3YALCiycJW4+VVgvmdL99BT6QtvCIbgKEmAmFCJJt3aLY
   B3ajskF3zvPLHNTvO+DF8Go+vr5LKVeRJn96zG5yLpxsS1GyoZEQ3dylV
   E9J40mTFF4aVOOutRFi8iuNjJRI+o5FKFJYbk0Y3Yn2hR+7uHfeYs0K7c
   DEEmwjwN7k+JARBxoug3K7lmiEXjOInaSDo1qbIFo4nIYxAtcp6Gyq1u7
   cFoAsTaSlBsf7TEaBnIdm4LvtEAotZcoBH+iGipyuiG5KUkexI5+e7mL9
   g==;
X-CSE-ConnectionGUID: sx48JvsZTjKOvgK2W3heIQ==
X-CSE-MsgGUID: rz9PaGytS1C2d3UesIWBBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84428734"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="84428734"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 03:45:13 -0800
X-CSE-ConnectionGUID: bEG5wXzUTZOzLNsiD4UD2A==
X-CSE-MsgGUID: khhh8KZYTwO0y7595bpD5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="223345396"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 05 Mar 2026 03:45:05 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4F54F28778;
	Thu,  5 Mar 2026 11:45:02 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH net v5 7/9] libeth, idpf: use truesize as XDP RxQ info frag_size
Date: Thu,  5 Mar 2026 12:12:48 +0100
Message-ID: <20260305111253.2317394-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305111253.2317394-1-larysa.zaremba@intel.com>
References: <20260305111253.2317394-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only user of frag_size field in XDP RxQ info is
bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size instead
of DMA write size. Different assumptions in idpf driver configuration lead
to negative tailroom.

To make it worse, buffer sizes are not actually uniform in idpf when
splitq is enabled, as there are several buffer queues, so rxq->rx_buf_size
is meaningless in this case.

Use truesize of the first bufq in AF_XDP ZC, as there is only one. Disable
growing tail for regular splitq.

Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c   | 6 +++++-
 drivers/net/ethernet/intel/idpf/xsk.c   | 1 +
 drivers/net/ethernet/intel/libeth/xsk.c | 1 +
 include/net/libeth/xsk.h                | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 6ac9c6624c2a..cbccd4546768 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -47,12 +47,16 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 {
 	const struct idpf_vport *vport = rxq->q_vector->vport;
 	const struct idpf_q_vec_rsrc *rsrc;
+	u32 frag_size = 0;
 	bool split;
 	int err;
 
+	if (idpf_queue_has(XSK, rxq))
+		frag_size = rxq->bufq_sets[0].bufq.truesize;
+
 	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
 				 rxq->q_vector->napi.napi_id,
-				 rxq->rx_buf_size);
+				 frag_size);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index 676cbd80774d..d95d3efdfd36 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -403,6 +403,7 @@ int idpf_xskfq_init(struct idpf_buf_queue *bufq)
 	bufq->pending = fq.pending;
 	bufq->thresh = fq.thresh;
 	bufq->rx_buf_size = fq.buf_len;
+	bufq->truesize = fq.truesize;
 
 	if (!idpf_xskfq_refill(bufq))
 		netdev_err(bufq->pool->netdev,
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
index 846e902e31b6..4882951d5c9c 100644
--- a/drivers/net/ethernet/intel/libeth/xsk.c
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -167,6 +167,7 @@ int libeth_xskfq_create(struct libeth_xskfq *fq)
 	fq->pending = fq->count;
 	fq->thresh = libeth_xdp_queue_threshold(fq->count);
 	fq->buf_len = xsk_pool_get_rx_frame_size(fq->pool);
+	fq->truesize = xsk_pool_get_rx_frag_step(fq->pool);
 
 	return 0;
 }
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 481a7b28e6f2..82b5d21aae87 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -597,6 +597,7 @@ __libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
  * @pending: current number of XSkFQEs to refill
  * @thresh: threshold below which the queue is refilled
  * @buf_len: HW-writeable length per each buffer
+ * @truesize: step between consecutive buffers, 0 if none exists
  * @nid: ID of the closest NUMA node with memory
  */
 struct libeth_xskfq {
@@ -614,6 +615,8 @@ struct libeth_xskfq {
 	u32			thresh;
 
 	u32			buf_len;
+	u32			truesize;
+
 	int			nid;
 };
 
-- 
2.52.0

