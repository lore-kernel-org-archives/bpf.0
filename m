Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EEE396D14;
	Thu,  9 Jul 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618687; cv=none; b=i8BNkuj9hK9whhMeIKcKRBZePEgq8dTccVw7FyqB+uht9lTndUmwgMzdEXPPyOenf3wKCG/zLsXZ68eI8F10T+JU0LqdxoItX05FOURZMLu2yALOaf4Pjobe7wX44nVMZ4L/1gBQtTkOUxdWzsV1+oM4Z5sBAeyDsreWJxoyzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618687; c=relaxed/simple;
	bh=FxgpKNAnJoxeCvNpeKca8J9Ys1HConjMKEk/4D4NWT0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=e3z/jGCKCWhu1biUd/QL3gVVrUAXSYi38x9A9mf7QW7SYY3Y8WjU1HL0dZ00gUuQozPCExoItebMSMtw/wwIPR9NFoZhLIdbldN7BXpqQA05Q9vWtrJfPcrZSZCiLqekXDwHESPF1CLRaHEkJO6iPIr86rS1dcgYGG6yEPp7HCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=E5vJGHT2; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="E5vJGHT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783618674; bh=GbXudm9T4bptRsNZNl7Y+3gwyFdR/V1Sg+kWp9rPYhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E5vJGHT2qrEiUGLqmMuvcdZUaHi7AixeTEYUVEsXGKB9ryrUC1CA/ikq1HWYTj2Qa
	 8IdgqYX+ard+2CvEk25j3BBMUeDi4/3zsYW19pE08TOzZi26s8bVHicN6MHk/xj0t6
	 clTjgR9lnJYrEG1IlD9IE3ZngZ0hAGEgsTUZLCvA=
Received: from halo.lan ([240e:379:223b:5900:1e30:bbb9:ee9e:94aa])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 96F942FA; Fri, 10 Jul 2026 01:37:47 +0800
X-QQ-mid: xmsmtpt1783618667tyf6i4pcl
Message-ID: <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uyPLVL8VAjeR2VAfr4VcW9yhBJYSm4OjoausI3xFwBwMYs5vyQO
	 Oalz6pqzlWCmHgddHm229H/zKgTIelQLP84ul4dJvPIgFzDLohJVciJfcbFzcA5HRDKYcebjrexb
	 /9CLJkXoMCCbu6rygnBaYqQCc5zcq75NFmlgTWgVF5UZ0OVdvah6Sx9U3QYZ5/nq1JvJozWFpBK2
	 aX8ywQs8nqyb1vyKknzt0WsUxhWclkSQ8eSVG00T0Dv6jCyFV1WlrZPGhxrNh2bz4muqaUyi9w+7
	 kCrxFlKp6aT8MrCT19pFFGN52dkGcTNOAm+Gnxw3MyfAF0Y/3JsrjuqIVIqOrNrsx0jtd3mN8peo
	 aozoVFdOXMz8GlyJykWhHwue29GVN/2sriunE8yG4xg/QzwnGOSSkgcpmRKgIokU1Ek6oFcGMxaD
	 1t5XYFsWh3fJp190PR49FcrOjvLy5sQNzaVXbClhRRQJBR8hDb1tT32mPI+9qJGjYUpLvvcE/rH0
	 eOpFwUKC/Csdpjyk5NKg2PtBJu+2LzIl+p/O/rEAilNCCTYD1InHoNXgfL85XKagp9z4US/w14ay
	 jzYh/x7u5hQXrrOCoXKZEzMNKskDch/CR2cK1VfZrYbBYuNJJLkOCG0h+KB3JKC45qbR2pYmhSF5
	 iTyoGZXRG1uvfwDsP34uBdHUSHnNezFywFuzABi0o2vyg4qIkZXd5FF2NA+HbtUted2hOPEyHGq8
	 +shMrdyPwITHvaDRDwLVkuF8EARpZ0XHurbCsTZ15Z7TVrzocxz5wJPx/FRfRNcxXRdzxEr/VcdJ
	 LB8vTdtKKexBXjOB082RiRdF0VU+v5sc6BMyyJ+xiLDAwj8qzeFM7lvf+XlQy4IBeKq1kNiNpLG5
	 UHrmDLqbAv0ZeEGGDDRD7QHOCJkOSwhaV7y9uUFG/aBlcln1i72L1W1PTbSIZhVGOhhmmeFT43Zz
	 gpcjWJeAh//oZKjryYnnI4Vq8Yxivacdu06+DEH4m7i9Ewn1AhpOP8OFVp4vLDfhHggN5tNpNR2w
	 YIrCjP7xvK3WyEvdRAC+Udow8TKG9YGHQICFvNg6XfRHZ+OfNbXUMgMVGNsSgI/oUyKGcgw52QDv
	 zekHRi4gJqJB+3b9GVOZAGATmQPw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net-next 1/2] net: atlantic: free stranded TX buffers on ring deinit
Date: Fri, 10 Jul 2026 01:37:41 +0800
X-OQ-MSGID: <20260709173742.63286-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
stops at hw_head, which no longer moves once aq_vec_stop() has stopped
the hardware and NAPI. Completed descriptors beyond the budget and
everything still posted in [hw_head, sw_tail) keep their skb or
xdp_frame when the interface goes down: aq_vec_ring_free() then frees
the buffer ring and the references are lost for good.

Today this is a silent memory leak on every interface down under
TX/XDP_TX load. With the following conversion of the RX path to
page_pool it becomes much more visible: XDP_TX frames carry fragment
references on the RX ring's page_pool, so a single stranded frame
keeps the pool's inflight count above zero forever. page_pool_destroy()
then never completes, the pool is leaked together with its pages, and
"page_pool_release_retry() stalled pool shutdown" is warned every 60
seconds from that point on, on every ifdown, XDP detach or ring resize
under XDP_TX load.

Bring back aq_ring_tx_deinit() as it was before the removal and use it
for teardown again, with one extension: TX rings can hold xdp_frames
nowadays, so release those too. They are returned with
xdp_return_frame() since this runs in process context.

Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---

Notes:
    Without this fix, converting the RX path to page_pool (next patch)
    turns the stranded XDP_TX frames into leaked page_pool fragments, so
    page_pool_destroy() can never drain and the shutdown stalls forever.
    
    Reproduced on an AQC100 with this patch dropped from the series (i.e.
    page_pool applied without the tx-deinit fix):
    
      # reflect received frames back out through XDP_TX
      xdp-bench tx enp99s0                    # or any trivial XDP_TX prog
      # from a peer on the same link, flood RX so frames are in flight, then
      ip link set enp99s0 down
    
    The pool is destroyed with frames still stranded on the TX ring, and
    page_pool_release_retry() warns every 60s with the same id and inflight
    count and a growing age, indefinitely:
    
      [161110.753385] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 60 sec
      [161171.170756] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 120 sec
      [161231.588685] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 181 sec
      [161292.005886] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 241 sec
    
    With this patch the stranded buffers are freed at deinit, inflight
    drops to zero and the pool drains cleanly.

 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 30 +++++++++++++++++++
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 8ff07de2bd52..c59b6c0b37f1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -360,6 +360,36 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 	return !!budget;
 }
 
+void aq_ring_tx_deinit(struct aq_ring_s *self)
+{
+	if (!self)
+		goto err_exit;
+
+	for (; self->sw_head != self->sw_tail;
+		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+		struct device *ndev = aq_nic_get_dev(self->aq_nic);
+
+		if (likely(buff->is_mapped)) {
+			if (unlikely(buff->is_sop)) {
+				dma_unmap_single(ndev, buff->pa, buff->len,
+						 DMA_TO_DEVICE);
+			} else {
+				dma_unmap_page(ndev, buff->pa, buff->len,
+					       DMA_TO_DEVICE);
+			}
+		}
+
+		if (unlikely(buff->is_eop)) {
+			if (buff->skb)
+				dev_kfree_skb_any(buff->skb);
+			else if (buff->xdpf)
+				xdp_return_frame(buff->xdpf);
+		}
+	}
+err_exit:;
+}
+
 static void aq_rx_checksum(struct aq_ring_s *self,
 			   struct aq_ring_buff_s *buff,
 			   struct sk_buff *skb)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index a70b880ada67..6431cc62962f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -202,6 +202,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *ring);
 void aq_ring_queue_wake(struct aq_ring_s *ring);
 void aq_ring_queue_stop(struct aq_ring_s *ring);
 bool aq_ring_tx_clean(struct aq_ring_s *self);
+void aq_ring_tx_deinit(struct aq_ring_s *self);
 int aq_xdp_xmit(struct net_device *dev, int num_frames,
 		struct xdp_frame **frames, u32 flags);
 int aq_ring_rx_clean(struct aq_ring_s *self,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 2f9033ceed8c..05814fea0f5f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
 
 	for (i = 0U; self->tx_rings > i; ++i) {
 		ring = self->ring[i];
-		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
+		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
 		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
 	}
 
-- 
2.47.3

