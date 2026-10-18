Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE773E5A2A
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343241; cv=none; b=UXgr1emcDsZCBbU0gy87ZhdldU704ZQCd6pste2gefW1kkhIK/SAJmIJLz6pLvKhWnD+H5IXWiGaQBqJmPwtjbz7bTtIUBl+u5vtm/qqaJQ+LFVcLOFBos2vNPuMs2fJcQk+RsTyAAaJOG8X9IIVjzj7kMTtErM/QtCKe5ZoRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343241; c=relaxed/simple;
	bh=Au8HZDixDEJE1Bbbs+a50n2xC6KEh0hICpCccr4h8jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJ22zKTqcjYEfaZQXbtGYEVNMApWdsT1z2/JB7sJ3gqUIEYhPsJA23FHppsHICwAGQ19Hs5PqeyhOpOjtaGGCV3b9WOt62bZSieNq0Q33gSKua6hyHBMFO+kgfPs7gKcQi1qarintLbK1KG8aZaNmOPaIikL8jc5M9J9jh8spc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aeK0M6XQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b2flT0FT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aeK0M6XQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b2flT0FT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF6s7f1102406
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SzwC/zJKlfxLCWUTfxSQcRAYGVmJ1awZ4A2jt/xfnek=; b=aeK0M6XQZxPUNrvZ
	jITxHfdSVnnePip4Y5uyB7W2MsVwuTeUXQMF8+WgRiWv9I8GzMpYd1k3YFcZP05M
	+f7lqOFQizgS8nJHbxYyhXQW7LbrKXqB7EmzqfInypFQXfwtJlnBAO2UZsWHmLvz
	ekPVCIVrOCJPs3cyixcPv/fBK0/GB+9myRhextYI7UcBPol4qlRTxXQydoP8STVG
	hOg8fxoUgHlt7Y56RdNYRft274qXKWKguAnFGhso6Nf+q+n85wQO+e8/4d4JSuTy
	FL1NY6X3Lk96oRmb9fpUaDc/bsHYWe7eYURvmeMiJgRZ9OB6TKvNU98OO5M2HNpE
	fPeQKQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys3p5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ecdc701a2so159119085a.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792343237; x=1792948037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzwC/zJKlfxLCWUTfxSQcRAYGVmJ1awZ4A2jt/xfnek=;
        b=b2flT0FTDNWohfU+U2rwr8IuSs1iDp2rQtChaeg145ZgshM1gCkAkhRTj32p+8FCzF
         dJRPPCAkz75FFT+jI6qQk6tNI1x7HQD5+TW2vrcZNjF1eTkuXwRFMq5OzDoDhpfQEN8S
         Mbv0NfXNyAWmQc1MfW7iYWPQG+Up4T8a3dtukIzvUE0359dUaFsO2HWrRI99pR45mgOt
         E9duk8ZVk1WTQJNaSy7oscVdioIClcXZLMLtFcUJHKH7BHJ4Ipl2jfXz3C+IvmJ+oWm+
         cdoycHN4Y8zSs0pYtctMg3Us+lVSqnIT7g6tGTN5cIWwqAxglYaN1LaVZ1mBHNvyNDKw
         JkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343237; x=1792948037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzwC/zJKlfxLCWUTfxSQcRAYGVmJ1awZ4A2jt/xfnek=;
        b=qGpgsR3wQZZ/YTy/cc4DcDsZx3LRIqhZQlSFACXeyH24GiZHsI3k3yvH05x3Ht9kkG
         sYrgg04lJNdpx49bHHy1FVnMw24kxVxJuLVAp8JXInrlbf8ljramy2ecEqSTmoc2C4ok
         3x55Byrv6fS7nbqnumH/bGyXf/i7G031qJqJGlqBodHf5bTIfb7cOHwfZxT8iVViyRzB
         mLF63Y44qXbcFoPyxio2esFZZCFxoo00ifdIWBt/7iSbJRpe4qJHgh+1nVjoEzWs2hCq
         aM7Khb2d7P1mAC2k6JPcMJOvKH0Untk3diouSuMWvLMHi4nvfvwIqEYTOUSnxDlMvnBM
         gF/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwRnoOdMvgGoX8FTHSmvXynsNJ2fLl1fe+5wLUc1Z7rXGhcjL5Iz3jjvelUAov8iiUYeRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1pDpYuxc+3uaQ5sfQFuwRDrRcLpfD9ky7cHaSO3jqwKQ3aXlu
	hqiS7OQswlAQHFuBIejB0t2acO3RMELy8nN3Z15G8oXMOi9pRP20/fnbzPfW9OePy5gDI9XNInc
	iQbRCmTM2e9+WfZ0HMFQnm27UxlR5hfGv06fR0ffMMO15BLB/3SaRXnc=
X-Gm-Gg: AYBFou3hru+OndbBzVuK7ZcaNWhJPLMpZHL9ekL2nx3oloveqt441wqXxL+6FLQPqwT
	Es+Zm8O3m5JN52qrfhom0Eo4YA2kH/MC7hblypSJPvJ+J/zkn79yJ6wOpt52mCQwaJA4pNYq2kF
	T8pvI01LWnE8FgelQRcjA7EimFSbcnzZIAlBtY5olbv/Wd6/KQsTzRCwp4FNNv2gdwwk/213OiG
	sUKKCLpgK7GU1L9k/ZfjmQWoxzFICR4sG2XJqhveXl8NxgiFNojPXbbMw0b4M4I/vVoUgIPNGc9
	h5b4DDM9K54jYjDlwOpk8yovJVVtaLmPTYpdvHAlc4SolviFMawGJAPrws9rnkV5e+sdHdPL7Kn
	oRh5OmCSdYmTaBA==
X-Received: by 2002:a05:620a:8812:b0:93e:b7cc:67bb with SMTP id af79cd13be357-93f29d6ffd1mr858464585a.54.1792343236335;
        Sun, 18 Oct 2026 10:07:16 -0700 (PDT)
X-Received: by 2002:a05:620a:8812:b0:93e:b7cc:67bb with SMTP id af79cd13be357-93f29d6ffd1mr858459285a.54.1792343235744;
        Sun, 18 Oct 2026 10:07:15 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f9c41sm19002552f8f.38.2026.10.18.10.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:07:14 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 18 Oct 2026 19:06:59 +0200
Subject: [PATCH net-next v8 1/5] net: stmmac: take ownership of saved RX
 state at poll entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-stmmac-rx-mb-v8-1-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
In-Reply-To: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX9fn2RfhkY42y
 bnUMXZBU04CRqvJL+M0UM9LT88aFBwQUXDpIO0kt5Gm5Q6ziA9GkxXPJEv/kIrXVfR8MUg8ZbOp
 piFj0WhWMSkTrwitCBFDR+OmF0ejhk5W3nbiJelsXhV4wHg94kucGVz6UXIRl487B9FqsUIF9h7
 LOsg+kngKtmGyvboRfNzIGZGlRvywf/vAdPMFjKUOSOmDrjWj9MQoxhfdT3ZyyP2NsK7YAnDhCI
 Ox1CsHpP4DqzaDruU6xmaK68VnRcK3IMs5bNi1jYpq9WQ9kW4Ws3nN1Fp1AlHSh8m9Ym6f5bzda
 RDEPEp5v0Q4yoBBEfGEVIoZM4yxvI2pAmXkhHiiAr8k9IDRicMSmYMnxGClGqsdLFLn9vbUjJdF
 PU0QMjQ0Pnb5j0QR1IDJN3K8LXOoUdEsBy5l2MVeVVrABl2mo+JtnJmumeMRQF3Ux4QL0foWzwe
 s24pPlZkoRshzGmI70g==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad4fcc5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-gjLCbu4MZEjzEcwt_QA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: AtbJzPqbb44qEVJj8jauWBm4yPRptk01
X-Proofpoint-GUID: AtbJzPqbb44qEVJj8jauWBm4yPRptk01
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX3qwztR4ms8+l
 B8Q88BQuvHQ82CpSBmS9A9Y/QScltpEILrn8SX/z9ZMSTCxsCw02SoPLBLtez9QUzmWS5n6jjjv
 u74fyfvgQY5lp1u7Po7f98EXJUnNyeQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180068

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned.

Track the frame-in-progress flag independently of the status read from
the next descriptor. The old code keyed the save on the status of the
last descriptor looked at, so a loop stopped at a DMA-owned descriptor
(rx status not yet valid) could drop the saved error/length bookkeeping
in stmmac_rx_zc().

Drop the saved state both when the queue parameters are reset and when
the ring is destroyed. stmmac_reset_rx_queue() is reached from
__stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
stmmac_enable_rx_queue(); without draining it there, a partial frame
saved before suspend (or before a queue is disabled and re-enabled)
survives while cur_rx and dirty_rx are re-armed, and the first poll
resumes that stale skb with descriptors from the freshly initialized
ring. __free_dma_rx_desc_resources() releases it on teardown.

Apply the same state handling to stmmac_rx_zc(), which also leaves
state_saved set when a saved frame finishes at the budget boundary.
That path saves only error and length bookkeeping, not an skb pointer.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 72 +++++++++++++----------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 53782ab55e12..8fd2acb25fb6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2180,6 +2180,9 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
@@ -5614,12 +5617,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int count = 0, error = 0, len = 0;
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	u32 rx_errors = 0, rx_dropped = 0;
 	unsigned int desc_size;
 	struct bpf_prog *prog;
 	bool failure = false;
 	int xdp_status = 0;
-	int status = 0;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5630,23 +5633,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		struct stmmac_rx_buffer *buf;
 		struct stmmac_xdp_buff *ctx;
 		unsigned int buf1_len = 0;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		int res;
 
-		if (!count && rx_q->state_saved) {
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5685,6 +5690,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
@@ -5757,7 +5764,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5799,9 +5806,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
-	int status = 0, coe = priv->hw->rx_csum;
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	enum dma_data_direction dma_dir;
+	int coe = priv->hw->rx_csum;
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
@@ -5821,25 +5829,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		skb = rx_q->state.skb;
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state.skb = NULL;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		u32 hash;
 
-		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			skb = NULL;
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5868,6 +5879,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -5880,11 +5893,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
+
 		if (unlikely(error)) {
 			dev_kfree_skb(skb);
-			skb = NULL;
-			count++;
-			continue;
+			goto next;
 		}
 
 		/* Buffer is good. Go on. */
@@ -5958,9 +5970,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;
 					buf->page = NULL;
-					skb = NULL;
-					count++;
-					continue;
+					goto next;
 				}
 			}
 		}
@@ -6017,10 +6027,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Remove FCS if needed */
 		if (!fcs_stripped && pskb_trim(skb, len)) {
 			dev_kfree_skb_any(skb);
-			skb = NULL;
 			rx_dropped++;
-			count++;
-			continue;
+			goto next;
 		}
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
@@ -6045,14 +6053,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb_record_rx_queue(skb, queue);
 		napi_gro_receive(&ch->rx_napi, skb);
-		skb = NULL;
-
 		rx_packets++;
 		rx_bytes += len;
+next:
+		in_progress = false;
+		skb = NULL;
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
+	if (in_progress || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;
@@ -8399,6 +8408,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
 }

-- 
2.56.0

