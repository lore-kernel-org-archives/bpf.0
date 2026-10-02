Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305093E557E
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946563; cv=none; b=DlUbO2y30oJecdxYJuQI1TB0nG/fChrzqczIyrXO2PCrbqpyK2BZdOn4E/0sN2pDsS/SWINdMmBw7cCd8/VLuRJxMnIaDq6mKxGubPrTmO+mxAngLu8kjsPS8v7YiqJTYrB+UBR4s3+UjAXCiNnLTEFEsxope8LCW/6tVNkfSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946563; c=relaxed/simple;
	bh=NILLfHoGRMOikRV0fS50d3oroJdYD2VHjU2ELpDYkaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9WlBd02hsUEi9PDYeKI7z9L3v8omUvpFIaoKahkp89QhTQ82WsESjpJ3tSdS6J26bCjG46bIUPKFoy3v5eZXxW4iDm+KLJRhMftwye1EhzHOqp5Wt8wlMS0+hNo1KSLJBS2gpL+BJ9Hf762yue462NqRhlghXKU+hg+KgYvOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMEx/kIA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMEx/kIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
	b=OMEx/kIALIStao/Aa7RThYfham6yxWoq96nFbMQL81mg8PHc/n0Io3B0nwIGE9XQ1xb3bZ
	HuLi3ZJJ6ToHfSdKO0wb6RJY1CuZWvACd2EWJbu4ET/CitgRAI+yZnUIc2VGuo9GoStjC5
	HY27pxxxn7bQv/BQc/Z0WDq/nsH9p84=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-BLZtcfimP7KX1xoF7cxTcg-1; Fri,
 02 Oct 2026 09:09:13 -0400
X-MC-Unique: BLZtcfimP7KX1xoF7cxTcg-1
X-Mimecast-MFC-AGG-ID: BLZtcfimP7KX1xoF7cxTcg_1790946550
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CB5218011D4;
	Fri,  2 Oct 2026 13:09:10 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CC44767;
	Fri,  2 Oct 2026 13:09:04 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Henry Tieman <henry.w.tieman@intel.com>,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Preethi Banala <preethi.banala@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
Date: Fri,  2 Oct 2026 15:07:52 +0200
Message-ID: <20261002130752.2597259-11-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

tx_restart, tx_busy, rx_buf_failed and rx_page_failed in struct ice_vsi
are u32, but ice_update_vsi_ring_stats() fills them with sums of the
64-bit per ring counters. The values are truncated and the ethtool
statistics exported from them wrap at 2^32 while the ring counters keep
counting.

Make them u64 like tx_linearize next to them.

i40e fixed the same truncation in commit 3b8428b84539 ("i40e: fix
unsigned stat widths").

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6c596e5a315175..a985b81efbe2d6 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -344,10 +344,10 @@ struct ice_vsi {
 	u64 tx_linearize;
 	DECLARE_BITMAP(state, ICE_VSI_STATE_NBITS);
 	unsigned int current_netdev_flags;
-	u32 tx_restart;
-	u32 tx_busy;
-	u32 rx_buf_failed;
-	u32 rx_page_failed;
+	u64 tx_restart;
+	u64 tx_busy;
+	u64 rx_buf_failed;
+	u64 rx_page_failed;
 	u16 num_q_vectors;
 	/* tell if only dynamic irq allocation is allowed */
 	bool irq_dyn_alloc;
-- 
2.55.0

