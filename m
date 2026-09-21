Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D34A6CFC
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002110; cv=none; b=ToTNsl8WLdAhP27/c1lY/gL9pD98z83614qOzDEy80y4IveXdrGQ/1W/pw/MH1UJzRWLpsttp+zbdIeY+XaDhFWR904+x/gXh1yr2oX6RQpQsRTFZgAzQbf+d1tYrRLvxlayUQrYBOmMcxfiry/5EFbmtX4i14HbAmJb2+zwVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002110; c=relaxed/simple;
	bh=mfV7pGjn+VFBwwHcZbPDTYPNX/j6THDW/6Co+m3ocf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m8oWPlgK7UxBpcMRk2V//aEweUcPjCfYTJ8vplj10lmhFUY5bbJPOtfLk9sEF3/nQrglJVGB+Z6QakNQqrUQsD5XDcSGGhwQhCm45wxu0oj8dd+SNFQ86m5RX1yb80uml/qXY8X8qGUTw9FOZEQAPBFCAFL8TZrqKFNzL7lGGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R0ATRRtL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aNaYyfPQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R0ATRRtL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aNaYyfPQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGZEm894564
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uaI3kmU3uE8s1l/mKjAGkt
	kJ2ehGVLhz/2R5u1l102s=; b=R0ATRRtLgmhprp72UGtSf+HLQUdYK5GgPOY8/4
	S3ZMu3hkX3IAGJjh/t5zNjKkONlQ3W9B1zJf92oFxROt4+tsJ5qzxLrN9IboGkLQ
	ZljeltC5oj5Cvh9tgmntlyuv2zM5p9x5g09wQjC7KTeVoubc+72TtQQJekwAkUOd
	o0x3A+YzaKF9N+UiJ04EAhqPBAzRrWJETseIFqrO9FLshfReve8nHvHwm7p1MDBT
	LbqY9koOKH6/v8Zj00+0TETmcuHxX3gBswszrpAWWEFFzA8CxTpDlrNM2goRnxKF
	raYnwV8isBj/LJ29etwH5kb5o3QCB4hhEJEKgiiv3gWcASeA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq9ty1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:48:26 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78a5a291af3so2870863137.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790002106; x=1790606906; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uaI3kmU3uE8s1l/mKjAGktkJ2ehGVLhz/2R5u1l102s=;
        b=aNaYyfPQXuIF1IetLpESvZxmuJ2jjv4lhEpO6b78hailqAeU+dFNmXGI5X90QI1rBG
         CKQQfYFrI/Fpx3iAhD6/H4vXgSf66cLA3BgoUod2JpV6ZAXdIa3h4iDvQzbqgBk4zYN9
         9V0NtXTTZt93iSzhpXW3Ce5VH6L3lQhrkV+X6meQ6Jc9w5YNY/TJNJ4FUNexZ1H/G+Np
         Q3Gv6XVi/1QQPtDydJfqglgZCSkLQh08nMW8+5v4gsW42rLcripzbm5MNLv3POfZshEc
         cbcspeGskxbGS587aDT57euLSZ5XiZKvr0VvF+ChUpUPAbhs33+gtjMXHVyi7rIHN/w4
         tprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002106; x=1790606906;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uaI3kmU3uE8s1l/mKjAGktkJ2ehGVLhz/2R5u1l102s=;
        b=wt+/NBYkT7niTT8AqNJYNEDU6HXqxwOnted8tXEQrwcKfGGNHXhYOYu0JNgd86AosB
         eaStXo9TV/fnaq5cwB8Kt9V/FH/Tz3Lv0dQNQw9BGE7FKihrwTsJfHKjcIWnCJZZ7hdh
         iFr1KKl01y14AlRptgyWW1ZFPJfVmcqCYriFjb2/1DTx0qDxDwohxeJWuPou/A/lIYx8
         1PuXWn3J5jZi9bARSFgLc391+RTnP0ESLSvguqSRqZUepsqcim+4hFa7p7Lv1zqSzCuV
         BHaYb2J2h9ThvqkdWATuhXpWBo6QuQkXEByXRHl4q565pGuv9V56Ji46wnrtno4OGw5d
         /BrA==
X-Forwarded-Encrypted: i=1; AKwUvBwDXFn/MnSvwMilqRTqVfkX6efkaiKVJQhnXHWHntTGskrvFnKkMYT3AimM6x+Iypli3cc=@vger.kernel.org
X-Gm-Message-State: AFuF++liWEiwji57RlzpJHlLbyu2uR0ElLsSm2ihi2n+VFFfoeYQcg3v
	3MShlaY2FoZ20sba1Kuf+VMwhCSb6OFlepc0mP16NNfft0W0y8lcB0XkCND5xUegRdP3AnvQ4Uk
	T7tm0TSRFFv+/fk7fe07U1G47tZpS1/V+AafYLK2evJvwOK3WmjHlGlU=
X-Gm-Gg: AYBFou2ytOYxJTA2IjwW5Etfg3W9UJ6JK7nj06qiE13a/mbE53ajw7Q1TjKIT8D7YD1
	+W2nzwY+/mdiniWVSedJvBhSmsv7N8/PFJXSkcG6vi/ydpW08fRj6qTn4J5ZnhWK9ATWy77padd
	LHHiwWs+ovMmf7hzl0ZtghhmQWoDaW3mzh4mwL2hCZiZkaAowck0Zkintdx82qDMIecu6pZiHXJ
	vO5ZSfSnZH6IheaVxGVBFD8YkorlzNeM0EaJugDeJiqDLYur4TQeagZOEPrWCZM4CQxf4/YYj3u
	qkGG5M2XPgku7jn6uPwSAZB2am897/L7dknPH+jhjJNQP1deEUyoViHSRzeB96Ct7F1tj1s5ZJ5
	uYvzs8CVbO8P5EQ==
X-Received: by 2002:a05:6102:e0e:b0:7a6:ef60:dac with SMTP id ada2fe7eead31-7a6ef6011abmr3250794137.34.1790002105530;
        Mon, 21 Sep 2026 07:48:25 -0700 (PDT)
X-Received: by 2002:a05:6102:e0e:b0:7a6:ef60:dac with SMTP id ada2fe7eead31-7a6ef6011abmr3250729137.34.1790002104845;
        Mon, 21 Sep 2026 07:48:24 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd1f0a061sm170708595e9.12.2026.09.21.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:48:24 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:47:53 +0200
Subject: [PATCH net v2] net: stmmac: fix rx Scatter-Gather support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-stmmac-rx-sg-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6DIBREr2L+ut8AbRW76j0aF6CgJAVavjU2h
 ruXuO9mkpnJvNmBTHKG4FbtkMzqyMVQjDhVMMwqTAbdWDwIJhrW8QZp8V4NmDakCa3bUMlRjFK
 dtWIcyuyVTIkP5AOCWaAv4exoiel73Kz8qP4TV44c9aXTrZa2FVd7j0T1+6OeQ/S+LgJ9zvkHW
 oLSxrwAAAA=
X-Change-ID: 20260916-stmmac-rx-sg-fix-a8d2d8a3ba01
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: _vDzvawyKbyJczK9PXJpJQ-5tsN5mfWJ
X-Proofpoint-ORIG-GUID: _vDzvawyKbyJczK9PXJpJQ-5tsN5mfWJ
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab143ba cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YI1BYhXVuOdgUOMkKCkA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxNSBTYWx0ZWRfX0mpk+gnQueng
 ZtOjTIysPGq0UdG8tp6/akYwN8oHQgXD8dMxsVgU8M9HtdePF0m1Vlt1q/EV6oNa8TGkiP8PF43
 uOyn1g37nyC+4h74r4T7XCbZhifxVHE/mV4O7sXefh4MUs2sSQ4Zic/J/dgD08xBr0MG/Qe/ex1
 GwZIQfdMndiGjQ4s9sc4v/KUPeFWMZ7a8a4lRJVEFQFFEzEvOPvOVH9ZLfymFgHBccI711Dki+6
 9TAM8Kps0RgVDpExcOrnMZU52QaIUtC/BZ7vt08YxMTLaewMG0MI55hcEZxabtCFbp33TSxTVi3
 AxLbWo28Qje/pTYbTu96vkurU3/EcQnRsgyo+tX2CvscTyRcz3IUdn3rgQYSWniFZ0/KIYqpEzL
 INLi38G0APvEsGknm5RBJ7A3OQdWyErODlhyI254GWQKjPREVmbGk0NCq16mN60j1KQhhEgnkW3
 aQ4mR/nhcYhrS4cLJ1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxNSBTYWx0ZWRfX3gGsJAQNxXmR
 vM6J7fWPJb7a24f1knDphV4APR7y+ajJFj+fuuWCFkbOJAr5CYSBVmzG6g9r8A41ejCMNLnDWPn
 snjUAz7FiRuhToOeODBmdiBNxxkWHKM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210215

When a received frame is larger than dma_buf_sz, the DMA scatters it
across multiple RX descriptors (rx Scatter-Gather). The secondary RX
buffer (sec_page) was only allocated and programmed when split-header
(SPH) was active, so for regular frames buffer2 was neither allocated
nor backed by a valid mapping. As soon as an incoming frame overflowed
buffer1, the DMA wrote the overflow into the unmapped secondary-buffer
address, triggering an SMMU translation fault on IOMMU-based platforms:

arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x00000000, fsynr=0x7f0011, cbfrsynra=0x1c90, cb=11
arm-smmu 15000000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x1c90
arm-smmu 15000000.iommu: FSYNR0 = 007f0011 [S1CBNDX=127 WNR PLVL=1]

Enable scatter-gather for non-SPH frames on cores that can program an
independent secondary RX buffer (GMAC4/XGMAC): allocate and mark buffer2
as valid in stmmac_init_rx_buffers() and stmmac_rx_refill(), and account
for it in the buffer length computation. Legacy cores have no set_sec_addr
op, so they keep buffer2 disabled.

Since buffer2 is handed to the DMA at page offset 0, the page pool sync
window is widened to cover both buffers in every mode: offset is set to 0
and max_len to dma_buf_sz + stmmac_rx_offset().

The FCS can straddle the buffer1/buffer2 boundary and a descriptor
boundary, so it is now stripped from the tail of the assembled frame with
skb_trim() instead of from a single buffer, avoiding an unsigned underflow
for frames that overflow a buffer by 1..3 bytes. For single-buffer frames
the XDP program must not see the FCS, so it is removed from the XDP buffer
before the program runs.

Native XDP currently only supports single-buffer (linear) frames. An
oversized frame accepted by the MAC (jumbo enabled) is received via
buffer2; the XDP program only sees buffer1, so on a TX/REDIRECT verdict
the frame is forwarded truncated. XDP multi-buffer support to handle
this case is planned as a follow-up.

AF_XDP zero-copy RX is not covered by this change: a ZC queue still
programs buffer2 at DMA address 0 (and XGMAC has no buffer2-valid bit),
so an oversized frame overflowing buffer1 can still trigger the same
SMMU translation fault. Handling is planned as a follow-up.

Fixes: 88ebe2cf7f3f ("net: stmmac: Rework stmmac_rx()")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Gate buf2 allocation by stmmac_rx_check_buf2_cap() routine.
- Always set pp_params.offset to 0 and pp_params.max_len to dma_buf_sz +
  rx_offset.
- Do not remove fcs_len from buf1_len or buf2_len, just from len
  counter.
- Link to v1: https://lore.kernel.org/r/20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 84 ++++++++++++++---------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 11035b7d944e..d41892b56c5a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1629,6 +1629,16 @@ static void stmmac_clear_descriptors(struct stmmac_priv *priv,
 		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
 }
 
+static bool stmmac_rx_check_buf2_cap(struct stmmac_priv *priv)
+{
+	/* Only cores that can program an independent secondary RX buffer
+	 * (used for scatter-gather overflow or split-header payload) back
+	 * buffer2. Legacy cores have no set_sec_addr op, so buffer2 is
+	 * never handed to the hardware there.
+	 */
+	return priv->hw->desc && priv->hw->desc->set_sec_addr;
+}
+
 /**
  * stmmac_init_rx_buffers - init the RX descriptor buffer.
  * @priv: driver private structure
@@ -1659,16 +1669,13 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 		buf->page_offset = stmmac_rx_offset(priv);
 	}
 
-	if (priv->sph_active && !buf->sec_page) {
+	if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
 		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
 		if (!buf->sec_page)
 			return -ENOMEM;
 
 		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
 		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
-	} else {
-		buf->sec_page = NULL;
-		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
 	}
 
 	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
@@ -2256,13 +2263,8 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	pp_params.nid = dev_to_node(priv->device);
 	pp_params.dev = priv->device;
 	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
-	pp_params.offset = stmmac_rx_offset(priv);
-	pp_params.max_len = dma_conf->dma_buf_sz;
-
-	if (priv->sph_active) {
-		pp_params.offset = 0;
-		pp_params.max_len += stmmac_rx_offset(priv);
-	}
+	pp_params.offset = 0;
+	pp_params.max_len = dma_conf->dma_buf_sz + stmmac_rx_offset(priv);
 
 	rx_q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rx_q->page_pool)) {
@@ -5097,7 +5099,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 				break;
 		}
 
-		if (priv->sph_active && !buf->sec_page) {
+		if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
 			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
 			if (!buf->sec_page)
 				break;
@@ -5108,10 +5110,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
 
 		stmmac_set_desc_addr(priv, p, buf->addr);
-		if (priv->sph_active)
-			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
-		else
-			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
+		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
+					 stmmac_rx_check_buf2_cap(priv));
 		stmmac_refill_desc3(priv, rx_q, p);
 
 		rx_q->rx_count_frames++;
@@ -5142,7 +5142,9 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
 	unsigned int plen = 0, hlen = 0;
 	int coe = priv->hw->rx_csum;
 
-	/* Not first descriptor, buffer is always zero */
+	/* Not first descriptor, SPH enabled: buffer1 only carries the
+	 * split header of the first descriptor, so it is zero here.
+	 */
 	if (priv->sph_active && len)
 		return 0;
 
@@ -5153,14 +5155,16 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
 		return hlen;
 	}
 
-	/* First descriptor, not last descriptor and not split header */
+	/* Not last descriptor and not split header: buffer1 is fully filled */
 	if (status & rx_not_ls)
 		return priv->dma_conf.dma_buf_sz;
 
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
 
-	/* First descriptor and last descriptor and not split header */
-	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen);
+	/* Last descriptor and not split header: buffer1 holds the remaining
+	 * bytes of the frame, up to dma_buf_sz
+	 */
+	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
 }
 
 static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
@@ -5170,8 +5174,7 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	int coe = priv->hw->rx_csum;
 	unsigned int plen = 0;
 
-	/* Not split header, buffer is not available */
-	if (!priv->sph_active)
+	if (!stmmac_rx_check_buf2_cap(priv))
 		return 0;
 
 	/* For GMAC4, when split header is enabled, in some rare cases, the
@@ -5188,14 +5191,15 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	 * Thus 'plen - len' always gives the correct length of buf2.
 	 */
 
-	/* Not GMAC4 and not last descriptor */
-	if (priv->plat->core_type != DWMAC_CORE_GMAC4 && (status & rx_not_ls))
+	/* Not GMAC4, or non-SPH and not last descriptor */
+	if ((priv->plat->core_type != DWMAC_CORE_GMAC4 || !priv->sph_active) &&
+	    (status & rx_not_ls))
 		return priv->dma_conf.dma_buf_sz;
 
 	/* GMAC4 or last descriptor */
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
 
-	return plen - len;
+	return plen > len ? plen - len : 0;
 }
 
 static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
@@ -5718,6 +5722,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
+	bool fcs_stripped = false;
 	int xdp_status = 0;
 	int bufsz;
 
@@ -5807,24 +5812,31 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		len += buf2_len;
 
 		/* ACS is disabled; strip manually. */
-		if (likely(!(status & rx_not_ls))) {
-			if (buf2_len) {
-				buf2_len -= ETH_FCS_LEN;
-				len -= ETH_FCS_LEN;
-			} else if (buf1_len) {
-				buf1_len -= ETH_FCS_LEN;
-				len -= ETH_FCS_LEN;
-			}
-		}
+		if (likely(!(status & rx_not_ls)))
+			len -= ETH_FCS_LEN;
 
 		if (!skb) {
 			unsigned int pre_len, sync_len;
 
+			/* Each frame starts here: reset the FCS handling */
+			fcs_stripped = false;
+
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 			net_prefetch(page_address(buf->page) +
 				     buf->page_offset);
 
+			/* The XDP program must not see the FCS. This only
+			 * applies to a single-buffer frame (buf2_len == 0),
+			 * where the whole frame and its FCS sit in buffer1;
+			 * otherwise the FCS is stripped from the assembled
+			 * frame with skb_trim().
+			 */
+			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
+				buf1_len -= ETH_FCS_LEN;
+				fcs_stripped = true;
+			}
+
 			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
@@ -5925,6 +5937,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* Got entire packet into SKB. Finish it. */
 
+		/* Remove FCS if needed */
+		if (!fcs_stripped)
+			skb_trim(skb, len);
+
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
 
 		if (priv->hw->hw_vlan_en)

---
base-commit: 9bca72a2dd0663d4b39a5d4ed252ad78a8569b5d
change-id: 20260916-stmmac-rx-sg-fix-a8d2d8a3ba01

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

