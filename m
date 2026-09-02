Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B253E0082
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380283; cv=none; b=UHjIf7AiPu9pJ7Bq8xiYA8x3mVuQqmXNv0UMZKIGJII8ZoxxKyFQXndCxv7uJIr+QtrqgEhqoo20SQqSrwBpOGTTZy1FlSEzMiIFK3URHNisVx4kOsGHUzAT9fi3Pq+nroOzN3UO3MUlY8UEWdtO041xGwdMqCTyMY5NZEZNi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380283; c=relaxed/simple;
	bh=a74RwhKOzKO2aMZM9dGHFvUrKg/bQrbdI3oc5mLOjNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eD4wXZTwv4+FE1z1S0jpST91bIF3HPcGIXgeZw5yjW6APgBvknISVA4tUOhxYbfdMZ1EwoxyWrmo6/XjNe+pFMQ5FyV82SFxGpbjN0DqCp757JX0zwe47uB1ItNhJNT0lBnilhiKtYDPbWvNLuc6GcSaU2Pxa6eGniauxBhnwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fxlBvkH+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RuaTyZCs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fxlBvkH+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RuaTyZCs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHaaQ3045235
	for <bpf@vger.kernel.org>; Wed, 2 Sep 2026 20:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyYScNOtdHH5lkgudhM8EXCmcZZ2OIA7V31pDbai0PQ=; b=fxlBvkH+vXl0Gx0O
	ag8gnUdA9OsyNqIr10AuWOAq5z/1Qs6DF0Z9g+wiV6At2goJbvh8a+819ZDOM2Bc
	PwV1kRM9w2VHUBvvxKjqZmIQmXEu8Sl2ID54ndP9NcJi591kgVzg75D5/ioBLpkx
	R3Ya+gTWoPLz6LGLVoIORazrkBhpyxkeDTYFuD8RDLo+uD+6rTqkD3t2AX4rxwgP
	ZiS8R8WC+YuSylM+t/OjfgQ/e8XEL3Wv7lMq/wM+iieZt/0l5wqYhUqvAuFInEC9
	/VhDYj7kzcVaRv8vjhM35caDGGzS6VNml0OiapBRnot/GfMECgKM5iV1O2BTlQ24
	7oX+Mg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy2t9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 20:17:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9394ad7f64aso306897885a.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380279; x=1788985079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyYScNOtdHH5lkgudhM8EXCmcZZ2OIA7V31pDbai0PQ=;
        b=RuaTyZCschqPe485jNqGEbOVuiVqliDxrTRwlKbXeyDA2GLdEBHtTvWxxFmD8VNb/5
         gNj1IMpX7nhNfw6iedqQMOVVqtNuWfCoMMXOffy8ipooFKsrZqqFtTAZpl3T87+BEMLL
         yo2d9B0W8gZDuonK+2To9JAvbBUiaI9fpOVTNxNSduAFplREX1kmXyCDHKKN2UXf10W2
         0m7Mr451TLx1NmrReyXcN/mLq5WH9sYfEdFuconl5A17/gMbG2HDfSeFRaDpH79xoH8X
         NDo/pYECzedkhL4NHtMWXP0gfN38u4cIWG9YsVxTorlYYBEb7fhaxgZ0XwQ22m9xUmrq
         lmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380279; x=1788985079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyYScNOtdHH5lkgudhM8EXCmcZZ2OIA7V31pDbai0PQ=;
        b=jDceikq1Qb5YItkHybvwv+eytCvunCWw3b40yPIRmO3A3fjmDEcwnZNf3+xOZsHa1M
         sFOJjwWu9cp0HJHbep8tVebpxckMqxdsXwKpDa0v7VBAQLDpbll4oGuFzHzFVRyW+B8d
         6Ug9EdT9mlrWTH4syYFw/V/ASTCfybR6Mj0CQU2WMKx51Fv/VoGMq5cRvtwAjQVli/YW
         wWG84otJ+Tq3MpE59k2aGtEL8szDVu7Em+RU1n4RTdoyvKa7+M2MtjWfYbfNf/dOTVXG
         ufUnkTRH/0fNRudrYu6UnNjkFdE+N2pv72EPZZlo8zyDTcAlE7+gu53pz2ktUSbcpJqD
         Db2g==
X-Forwarded-Encrypted: i=1; AKwUvBzNYGGVHqQrNtrWrFzEWOHc67Kr/edTKZo2zDxo7YT17GXtvJyNVh7qY87BhwDxZyjk2As=@vger.kernel.org
X-Gm-Message-State: AFuF++k3ys3NAveU1ym9STlDWEh8MkJW1yKE3t0QxQMZWiuI7FPOv8GA
	4k5eofq0Lgo+QtUINaDb7bLK9Y1W3dc7uMd8QMEMo2WdbyCZDvZNPWouFJrSu/uHyyVx23136da
	79IDP1lrdOEGGcJUjiGuEXjP1Dfxhq7l3hCNZvDAOIfRr1zyvEL7ffTI=
X-Gm-Gg: AYBFou36Mzfqj7ANer9OZ9PnlIMwHa4dHTsBFoVnlxQ7Q8GOajvga5P6F0iG7e41eox
	RK+Q5FVWD4nU9+ntaHKJcLqor+AnL/5TALyMdn0b1VbfiVerH0ATjqx8UPm87+JvzbVCEumSa2t
	gTUo10P5Ty2rwX3BykJb24rVq3NFo7kKQf9+KQ58aNvBSXgU9h0GM0oHT7FxsYjnpZX6yeEMoW/
	jRdjKeDFXyovwDYLKILZXtKMZkabNb2qTpH8MmHmpgEwUrjUChSAvoVpoGIqNcBmplPwxNNPyLP
	V5u2yaS0DHT6XVcmFtU1w22dt9YjGNbwLI2xVUTxrDmZIeNokj+UuhNf9qgMRg2zBbenV8nYqiW
	yw6t5tJjYnP2wWg==
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id af79cd13be357-93960ef3c8amr950529685a.24.1788380274072;
        Wed, 02 Sep 2026 13:17:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id af79cd13be357-93960ef3c8amr950521185a.24.1788380273528;
        Wed, 02 Sep 2026 13:17:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d6029sm15725085e9.6.2026.09.02.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 02 Sep 2026 22:15:42 +0200
Subject: [PATCH net v3 2/4] net: stmmac: embed struct stmmac_est in
 stmmac_priv struct
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-stmmac-est-reapply-after-open-v3-2-e72a6df5a7ef@oss.qualcomm.com>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
In-Reply-To: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a988477 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8m_mm4JullfRwlNGEJsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: p0mqc83pOIK75y67tKrcja0XGCbmM-a5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXzHFJoE2e1s4R
 xnKQxrtjbIcZpdGNVKbzelfSjqQsETEWEDbPpfMAp6vAEMP+NRu4pt4ez/q77Ad/XXt2JnxAQCK
 gxsgslQfb5pH6KvwB0zGbW23GMbilOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXxxVflmplwR99
 iDSV6UwuWn813h6G9HD5zFJceaHyBgVMtrKNl+RjCVzxQbBaS3QlKfoJ69lTYl8dLONfRUsUqsT
 5ha08C/v8x9cKQx5uMsYiCTlLIGZRKSdjzgR2sGPhSWrb0t8bS92Scze8TRX8EC3+0VF+kECNRu
 OVOp80tmlp+twHuETzf0u1Su+bUqAK83NPUqZcgkT7cLFK24XBfzpFLyIpKne/h99ZwWlHgqJ4C
 aAjzwnm4igvxYUfp7EKS9IJT3sQ6jpjb/V+BHgQ59Sdw9CLByFHxueGgrCaFaOedi+b1m8KFE1k
 MVI2LKvzGGaaHUb87nkeZbIRumpzBmEpeac23NddIF2ZrVUdyYKoYjG+sD+ZM+lj+N9szjuuM+f
 d2u6QfQVUMLcBSAsWBEHzCwPFgbOBroQn8nqNLEZ0deBta6356vLMykW4dTLt75HFMI3zEuiqog
 HVCeFw/g7nVouGZwbAQ==
X-Proofpoint-ORIG-GUID: p0mqc83pOIK75y67tKrcja0XGCbmM-a5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

This is a preliminary change to fix EST reconfiguration in the open
and resume paths: the taprio offload must be re-applied after the DMA
soft reset clears the MTL_EST registers, but the current layout makes
that fragile.
priv->est is currently a pointer allocated with devm_kzalloc() on the
first taprio REPLACE, and the mutex guarding it (priv->est_lock) is
initialized at the same time. That ties the lock's validity to whether
taprio has ever been configured, so the EST parameters can not be
read under the lock (e.g. to check priv->est->enable in the open and
resume paths) before the first offload setup.
Embed struct stmmac_est into struct stmmac_priv and initialize the mutex
in probe(). This makes the code simpler (no logical changes added).
Moreover, the lock is now unconditionally valid, so the enable flag can
be inspected under the lock from any control path.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 17 +++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 22 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 61 ++++++++++-------------
 4 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..a8c8be34ff81 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -298,7 +298,7 @@ struct stmmac_priv {
 	struct plat_stmmacenet_data *plat;
 	/* Protect est parameters */
 	struct mutex est_lock;
-	struct stmmac_est *est;
+	struct stmmac_est est;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47295845371a..a9fb15bdda43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2723,9 +2723,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->est && priv->est->enable &&
-		    priv->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->est->max_sdu[queue]) {
+		if (priv->est.enable && priv->est.max_sdu[queue] &&
+		    xdp_desc.len > priv->est.max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
@@ -4788,13 +4787,12 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_is_gso(skb))
 		return stmmac_tso_xmit(skb, dev);
 
-	if (priv->est && priv->est->enable &&
-	    priv->est->max_sdu[queue]) {
+	if (priv->est.enable && priv->est.max_sdu[queue]) {
 		sdu_len = skb->len;
 		/* Add VLAN tag length if VLAN tag insertion offload is requested */
 		if (priv->dma_cap.vlins && skb_vlan_tag_present(skb))
 			sdu_len += VLAN_HLEN;
-		if (sdu_len > priv->est->max_sdu[queue]) {
+		if (sdu_len > priv->est.max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			goto max_sdu_err;
 		}
@@ -5198,9 +5196,8 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
-	if (priv->est && priv->est->enable &&
-	    priv->est->max_sdu[queue] &&
-	    xdpf->len > priv->est->max_sdu[queue]) {
+	if (priv->est.enable && priv->est.max_sdu[queue] &&
+	    xdpf->len > priv->est.max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
@@ -8029,6 +8026,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->est_lock);
 
 	stmmac_fpe_init(priv);
 
@@ -8160,6 +8158,7 @@ void stmmac_dvr_remove(struct device *dev)
 	stmmac_mdio_unregister(ndev);
 
 	destroy_workqueue(priv->wq);
+	mutex_destroy(&priv->est_lock);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 960249960004..be5b26edd04c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -69,11 +69,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
-	if (priv->est && priv->est->enable) {
+	if (priv->est.enable) {
 		est_rst = true;
 		mutex_lock(&priv->est_lock);
-		priv->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->est,
+		priv->est.enable = false;
+		stmmac_est_configure(priv, priv, &priv->est,
 				     priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 	}
@@ -91,19 +91,19 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->est->btr_reserve[0];
-		time.tv_sec = priv->est->btr_reserve[1];
+		time.tv_nsec = priv->est.btr_reserve[0];
+		time.tv_sec = priv->est.btr_reserve[1];
 		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
-			     priv->est->ctr[0];
+		cycle_time = (u64)priv->est.ctr[1] * NSEC_PER_SEC +
+			     priv->est.ctr[0];
 		time = stmmac_calc_tas_basetime(basetime,
 						current_time_ns,
 						cycle_time);
 
-		priv->est->btr[0] = (u32)time.tv_nsec;
-		priv->est->btr[1] = (u32)time.tv_sec;
-		priv->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->est,
+		priv->est.btr[0] = (u32)time.tv_nsec;
+		priv->est.btr[1] = (u32)time.tv_sec;
+		priv->est.enable = true;
+		ret = stmmac_est_configure(priv, priv, &priv->est,
 					   priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..e25a08e4be5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -959,7 +959,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			priv->est.max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -1023,24 +1023,15 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	if (!priv->est) {
-		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
-					 GFP_KERNEL);
-		if (!priv->est)
-			return -ENOMEM;
-
-		mutex_init(&priv->est_lock);
-	} else {
-		mutex_lock(&priv->est_lock);
-		memset(priv->est, 0, sizeof(*priv->est));
-		mutex_unlock(&priv->est_lock);
-	}
+	mutex_lock(&priv->est_lock);
+	memset(&priv->est, 0, sizeof(priv->est));
+	mutex_unlock(&priv->est_lock);
 
 	size = qopt->num_entries;
 
 	mutex_lock(&priv->est_lock);
-	priv->est->gcl_size = size;
-	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
+	priv->est.gcl_size = size;
+	priv->est.enable = qopt->cmd == TAPRIO_CMD_REPLACE;
 	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
@@ -1065,7 +1056,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		priv->est->gcl[i] = delta_ns | (gates << wid);
+		priv->est.gcl[i] = delta_ns | (gates << wid);
 	}
 
 	mutex_lock(&priv->est_lock);
@@ -1075,22 +1066,22 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);
 
-	priv->est->btr[0] = (u32)time.tv_nsec;
-	priv->est->btr[1] = (u32)time.tv_sec;
+	priv->est.btr[0] = (u32)time.tv_nsec;
+	priv->est.btr[1] = (u32)time.tv_sec;
 
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	priv->est.btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	priv->est.btr_reserve[1] = (u32)qopt_time.tv_sec;
 
 	ctr = qopt->cycle_time;
-	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->est->ctr[1] = (u32)ctr;
+	priv->est.ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	priv->est.ctr[1] = (u32)ctr;
 
-	priv->est->ter = qopt->cycle_time_extension;
+	priv->est.ter = qopt->cycle_time_extension;
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	ret = stmmac_est_configure(priv, priv, priv->est,
+	ret = stmmac_est_configure(priv, priv, &priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
@@ -1106,19 +1097,17 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	return 0;
 
 disable:
-	if (priv->est) {
-		mutex_lock(&priv->est_lock);
-		priv->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->est,
-				     priv->plat->clk_ptp_rate);
-		/* Reset taprio status */
-		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
-			priv->xstats.max_sdu_txq_drop[i] = 0;
-			priv->xstats.mtl_est_txq_hlbf[i] = 0;
-			priv->xstats.mtl_est_txq_hlbs[i] = 0;
-		}
-		mutex_unlock(&priv->est_lock);
+	mutex_lock(&priv->est_lock);
+	priv->est.enable = false;
+	stmmac_est_configure(priv, priv, &priv->est,
+			     priv->plat->clk_ptp_rate);
+	/* Reset taprio status */
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+		priv->xstats.max_sdu_txq_drop[i] = 0;
+		priv->xstats.mtl_est_txq_hlbf[i] = 0;
+		priv->xstats.mtl_est_txq_hlbs[i] = 0;
 	}
+	mutex_unlock(&priv->est_lock);
 
 	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
 

-- 
2.55.0

