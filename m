Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC021B1BF;
	Thu,  5 Mar 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711117; cv=none; b=gNsjHnX4Xjpf90bqBi1uc059fj72rIYwgeb9tBpgciaAxA9NBrMgE5m0M/XEwdciBzdxdQecOVKVpy4rBUIdscH/bkQ85BqKbuKqBZTQ6Mqk5jownmSFHNlzwUQXLGlhYyD6HF9xG5BAvUr/xjQRkacAGL57l921ulzQm4QwMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711117; c=relaxed/simple;
	bh=opTc95F22QYXNj0gRqeqqoVGPkPVr2AhYzRKFlUulz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx8jzBzEVjBZRaeouwPBotwiWV1WSEeWq/9Nf23sLAV/AEys3HWGfoqYFyjCGgH0bS0xJxaWrJYALWCR1Ts+VH27BsrP2D6+XNuA2VC4hFPsXl3nJdqufeVGMI+0994qHqBZgYT/FljQdjK/rs/R2cJQuoPYhQoxfbKIeZtDle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdRpBDIw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdRpBDIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772711117; x=1804247117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=opTc95F22QYXNj0gRqeqqoVGPkPVr2AhYzRKFlUulz4=;
  b=SdRpBDIwfHAQm/yJlgLSF+wWes7y+HpG03CxIYDHTvGzf7XX/kc/JBnv
   D+9m5lQIPYSqF0W5t+YVUMg67gFRg4h/JIFyEnmlHP8mpnfcL8a+wj073
   3QbaxebUy1Lxl9O0Tsg5I1KlZ5BYmQPK8ZD6z/Fcd+KnFoPY2ZpQ9/7mb
   K4MuTKvgzXPtqQETnMc+qBJ+R4iI+ScDY3AptYtKuXy4b2TFwFtFmleA5
   6HP6dBuAJx/0yvoV71eknhiOKQFG/ONSjDw7NsTYSjx5z8fCKJDSF68Oy
   vx8+ZLs8eUu7CtCpn/CNTAIyzuTg1+RT9zOwjdHeUZqTq2rBoB4rvnsbv
   A==;
X-CSE-ConnectionGUID: RUsaMZPWTKKv3qehxy0eDQ==
X-CSE-MsgGUID: DMUhtxt9S4uBgPTYWaGNjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84428756"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="84428756"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 03:45:16 -0800
X-CSE-ConnectionGUID: 6l5cV+LNQ/qFWh9YO9uSfQ==
X-CSE-MsgGUID: 7Iiy1Kg4SVGguDnDCvohCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="223345408"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 05 Mar 2026 03:45:09 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9266328774;
	Thu,  5 Mar 2026 11:45:05 +0000 (GMT)
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
Subject: [PATCH net v5 8/9] net: enetc: use truesize as XDP RxQ info frag_size
Date: Thu,  5 Mar 2026 12:12:49 +0100
Message-ID: <20260305111253.2317394-9-larysa.zaremba@intel.com>
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
bpf_xdp_frags_increase_tail(). It clearly expects truesize instead of DMA
write size. Different assumptions in enetc driver configuration lead to
negative tailroom.

Set frag_size to the same value as frame_sz.

Fixes: 2768b2e2f7d2 ("net: enetc: register XDP RX queues with frag_size")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 70768392912c..a146ceaf2ed6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3467,7 +3467,7 @@ static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
 	priv->rx_ring[i] = bdr;
 
 	err = __xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0,
-				 ENETC_RXB_DMA_SIZE_XDP);
+				 ENETC_RXB_TRUESIZE);
 	if (err)
 		goto free_vector;
 
-- 
2.52.0

