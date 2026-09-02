Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD844A8A10
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380281; cv=none; b=agmrGz/9N7cseWySEFEZVQoNkBwWSVWHa8OyNXp9TN09NDTta4Vm/H4gjly/ftk/p1OFg4OQIfWsKGTIa3Xc+5g2XqiCx9qArBRePuuBNcRAjDd36HoOA1yGIUtnE1a124M+1FLiCDrtFrX38j6e6KhUqI6tJqMqCJ8tw1X6kYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380281; c=relaxed/simple;
	bh=nFxZoL8X1JqmLeavgnZ7iJeUzTYIv1IFELQUjfYADQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bu9GxKPl7f2krtIp+JkXJtGyrGosUQJs3k6+px1lwX11NcGO1Od681BCZbSf04merBJPIrOdc1jVCrHwZbBHbW9IYyYnT/4QTM+YQNh25Kdxs/9coyphPfY14waR52CVVPsTynXUuf5WlioWtd4ECV1itcuK+be23ARCrhzpGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7aZ0vC3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVkCZa1f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7aZ0vC3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVkCZa1f"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KH7jB2523695
	for <bpf@vger.kernel.org>; Wed, 2 Sep 2026 20:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	efI1FvVtE+b3ucJ7UkFRdJEgMJPTTh0ZxSFaMrEjJSM=; b=H7aZ0vC3hKr6fW4u
	a2QKtX1ydF6rUcEtnvzQ3p0SE+VcdllxtYSFcwb5+WvVdxF4aDyRVU8CA+JHOKuV
	+zaQc8oZZY58hN+R4TH2Zf7Yv7jK7nDHTkmftHwYiAGV3Z7uLX44WK5WXYEXxYTz
	5kEprpFr8VLmufVcG3TO1LI8aASfNOXGCgAPRxUSM4LEWp29r14EcsMJIRdbkBGN
	K23AjPRm59+WAMaw7pF+LluWVEsgday52WXPrkCO56E8YNirT18l5CF/GpmQGQHE
	HprT4AmO4YKVwxTsn1BibBg5PGM5NWPAXdPPNMcpPaQES2l1s7mgITbVlpunu+qE
	QEdieA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 20:17:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934956beec8so303776085a.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380278; x=1788985078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=efI1FvVtE+b3ucJ7UkFRdJEgMJPTTh0ZxSFaMrEjJSM=;
        b=FVkCZa1fprE6VuHCezilEaEQQj+oYUY75TPMt7mh/yC566OFDuF24+wV4zDijm9X9b
         Ey5oRWrRAWJFSip6Mbhnu61BoEQWT8f3FB+TBlNrlm7vaaKNGmglgmxv3MvyOyIWZdYZ
         3eyxbd00JkLsAbf0JXSKwrYgONsjjjHTnU9OmSyVbEa0vDlvpbkQ8c0AraHiMG1+5s7e
         O4sTqWrHE+v+YhzhUnIBNJ4x2JPP/kZxQqn8PFZY4GVujJtxoXXnhnR7n75jNpoIDZun
         5/OEU5TZOM3nzYGEEugkc5oqUSeehbeUi85J8jN7H9RCh8Yt8QoosUoBP19zXF/RAKgT
         wXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380278; x=1788985078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efI1FvVtE+b3ucJ7UkFRdJEgMJPTTh0ZxSFaMrEjJSM=;
        b=kxwXd87oKq8U4md3ULgcvrlx1uaD4jwc9GXk1hnu2k3cHWQXgBcfaI/WfTlcsEFVPn
         KiYVrLwaPO1nRKT7wghh34U7v05bpftB01/gluaD+vw87NPH4LC5mZ8d6cHqatLDBGEG
         fmVD52xG6kCchhwljHXcbAuycwC+lK3WxTHyRlH/5YCSppoVCZ/WMWAfJeBLvpFPE/0G
         CUXn2VH4vMskIOCZOFm++6NlMqM/yniK/x1EICRQgHKD01D++ct5vuShfO6nmNmQBAB0
         JDnQ7kJ1Lc3WUxB0TuoeITBMyDt19ztslPen4h2701g5WdotBL0wcwyChHdOYioF+YO/
         9WZA==
X-Forwarded-Encrypted: i=1; AKwUvBxcuCLotLPp3QO67a7azMZ7B9MQCeWeMPLDLi9bo0RUFRI2zh9yGgYhuuxj8uvzsdUcABk=@vger.kernel.org
X-Gm-Message-State: AFuF++mUWIjlv1x1wfTyvOtbdXFcS/H7b6B7yEG/Vrph8tvWjBLAPl2E
	rSSjtNxvc2Q68wUTS3vRN6pVWH9OLWUzwB4o8yLWL3rXQT4ITaQIWw1KtKrOkxAV+PmtRtntRNb
	C6nZQId9/qizB73Dq6KYHpBbQIFAescsVV+yZfAb05xoSmfcLJNRQQ1E=
X-Gm-Gg: AYBFou1JqgU/jdMwnJY5tQbY1BBNsu+75D467BYq3SiYD76FwgvS6uG+slODGST1z2Z
	p0B6qm+pvEu/TuL3vLLZDYxDFkj2nG9H/1WvDx2aRhggvuG1YYlf38kERcljo5NjDJLm+1kGZM3
	HE8eXrvIAwbB0n3loY48JkZQIb/ay/T0h4ZtbN0tJ5Gt4akmKlIu/U3ZBQ9ssdXzqXJ/rMY09Vw
	aloriWhWvLkVpxgKfmmA3Mp5u8QJ3o79V3eBYFETkLDEtLo0NUtcGx4v5BLU9r/SkkQbqrt/o13
	uaSnVoW57VtiT3u4A/MMbCGLehmkrbzrkDV9CU6i6RSwMsDiJQxFmFoYoeaauO0SlIcoIeenU8t
	Al4fCIIkFiT6/Yg==
X-Received: by 2002:a05:620a:ec4:b0:939:6df9:6547 with SMTP id af79cd13be357-9396df968e6mr148813685a.51.1788380277338;
        Wed, 02 Sep 2026 13:17:57 -0700 (PDT)
X-Received: by 2002:a05:620a:ec4:b0:939:6df9:6547 with SMTP id af79cd13be357-9396df968e6mr148808485a.51.1788380276690;
        Wed, 02 Sep 2026 13:17:56 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d9db2sm16618865e9.8.2026.09.02.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:55 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 02 Sep 2026 22:15:44 +0200
Subject: [PATCH net v3 4/4] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-stmmac-est-reapply-after-open-v3-4-e72a6df5a7ef@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a988476 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=JpBpa1p7AAAA:8 a=DNwXZpNFxi9TDD9oO0cA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=YCh05so4W2E6r1tszMC6:22
X-Proofpoint-GUID: 10qdh924dXlD7EjV9svHWUrhT1J-kn3K
X-Proofpoint-ORIG-GUID: 10qdh924dXlD7EjV9svHWUrhT1J-kn3K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXw+unO7XMvIBt
 5NyJD5JHK0Wlur7X8Ud6KUp5EITUGjiP0jWyK2I/U1k5qG7gIffcXzzqVoq4OMT1qfPC5MdOY9A
 9ldByU8n0TKAxPgbZwCDvKlT9gxj/VSjdASi2Gs1GTqFTRQviSt5j5j20XBkxYXl0Rwl+5uZLnm
 LEJQ257BHP7k65LKAtAd8YuuCwgnVv56TbvqvC5UERQmHL6umexrOcOnZqMv4zWKVz8bVJqowSM
 sldfSiJEgULPDe23Ns/WYGYBTTBbloj2BitoJpuuQh3m2kshHb+BZtXnmHkHxvFUwPVh5MX105F
 rf6YRz+VnvLkr70JVGmXkyzMRBbpOeyqP0kyXh0glFBuWDvdP4IRepakGYFnI1nk1Qi3DjGHFbd
 1I6OMCbrPEm4jrxvA+PDWNZ+Fkvg9JsU/jrhh4kyGAVK+afokL+Os0QxCoafc7eG6ZuEz2q6KD4
 PaTX2kW4rwnlKqSmbLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXzWImOnZhtfYu
 6Iklca9FC+2yiNBvLCFNACSlpuFe+uPAt7nF5QoK6LDjE0wxCJnxsopUnkExyprA1AJ2Fdf3Y1z
 qAdtmo/Epp8iunXWLUV+d7ttEIdRW8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179

The core soft reset issued in stmmac_init_dma_engine() clears the
MTL_EST registers, but nothing re-applies the taprio offload after it:
priv->est.enable stays true while the hardware EST block is left
disabled. The TX/XDP paths then keep dropping frames larger than
priv->est.max_sdu[] and taprio is reported as offloaded, although the
EST block is not programmed.

Re-apply the taprio offload in __stmmac_open() and stmmac_resume()
after PTP is up. The base time is recomputed from the reserved base
time and the current PTP time, since the timestamp counter has been
re-initialized and the previously programmed base time is stale.
Introduce the stmmac_setup_est utility routine.

While at it, make the EST enable state transition atomic with the
hardware programming: pass the desired enable state explicitly to
est_configure() and hold est_lock across the whole configure sequence
in tc_taprio_configure(), so that the software enable flag and the
hardware state transition atomically. Moreover, priv->est.enable is
only set once the hardware has been programmed successfully, and any
failure path disables EST before returning. This also fixes the stale
HW schedule left behind when a REPLACE fails validation, since priv->est
is no longer wiped before the new schedule is known to be valid.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  |  30 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  13 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  13 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  35 ++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 101 ++++++++++++----------
 5 files changed, 116 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index f15d4d046aa7..49edfebbc39e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -80,6 +80,36 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	return 0;
 }
 
+int __stmmac_setup_est(struct stmmac_priv *priv)
+{
+	struct timespec64 current_time, time;
+	ktime_t current_time_ns, basetime;
+	u64 cycle_time;
+	int err;
+
+	lockdep_assert_held(&priv->est_lock);
+
+	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+	current_time_ns = timespec64_to_ktime(current_time);
+
+	time.tv_nsec = priv->est.btr_reserve[0];
+	time.tv_sec = priv->est.btr_reserve[1];
+	basetime = timespec64_to_ktime(time);
+
+	cycle_time = (u64)priv->est.ctr[1] * NSEC_PER_SEC + priv->est.ctr[0];
+
+	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);
+	priv->est.btr[0] = (u32)time.tv_nsec;
+	priv->est.btr[1] = (u32)time.tv_sec;
+
+	err = stmmac_est_configure(priv, priv, &priv->est,
+				   priv->plat->clk_ptp_rate, true);
+	if (err)
+		netdev_err(priv->dev, "failed to re-configure EST\n");
+
+	return err;
+}
+
 static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index f70221c9c84a..b4d1a1f04f10 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -65,3 +65,16 @@
 #define EST_GCL_DATA			0x00000034
 
 extern const struct stmmac_est_ops dwmac510_est_ops;
+
+int __stmmac_setup_est(struct stmmac_priv *priv);
+static inline int stmmac_setup_est(struct stmmac_priv *priv)
+{
+	int ret = 0;
+
+	mutex_lock(&priv->est_lock);
+	if (priv->est.enable)
+		ret = __stmmac_setup_est(priv);
+	mutex_unlock(&priv->est_lock);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a9fb15bdda43..c4d353948347 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -48,6 +48,7 @@
 #include "stmmac_ptp.h"
 #include "stmmac_fpe.h"
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_pcs.h"
 #include "stmmac_xdp.h"
 #include <linux/reset.h>
@@ -4168,6 +4169,13 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret)
 		goto ptp_error;
 
+	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
+	 * registers, so re-apply the taprio offload after PTP is up.
+	 */
+	ret = stmmac_setup_est(priv);
+	if (ret < 0)
+		goto est_error;
+
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
@@ -4189,6 +4197,7 @@ static int __stmmac_open(struct net_device *dev,
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+est_error:
 	stmmac_release_ptp(priv);
 ptp_error:
 	stmmac_stop_all_dma(priv);
@@ -8336,6 +8345,10 @@ int stmmac_resume(struct device *dev)
 	if (ret)
 		goto error_stop_dma;
 
+	ret = stmmac_setup_est(priv);
+	if (ret < 0)
+		goto error_stop_dma;
+
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_rx_mode(ndev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 4869827670c8..8f3a90df3178 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -8,6 +8,7 @@
   Author: Rayagond Kokatanur <rayagond@vayavyalabs.com>
 *******************************************************************************/
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_ptp.h"
 
 #define PTP_SAFE_TIME_OFFSET_NS	500000
@@ -55,7 +56,6 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	u32 quotient, reminder;
 	int neg_adj = 0;
 	bool xmac, est_rst = false;
-	int ret;
 
 	xmac = dwmac_is_xmac(priv->plat->core_type);
 
@@ -69,46 +69,21 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
+	mutex_lock(&priv->est_lock);
 	if (priv->est.enable) {
 		est_rst = true;
-		mutex_lock(&priv->est_lock);
-		priv->est.enable = false;
 		stmmac_est_configure(priv, priv, &priv->est,
 				     priv->plat->clk_ptp_rate, false);
-		mutex_unlock(&priv->est_lock);
 	}
+	mutex_unlock(&priv->est_lock);
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
 	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	/* Calculate new basetime and re-configured EST after PTP time adjust. */
-	if (est_rst) {
-		struct timespec64 current_time, time;
-		ktime_t current_time_ns, basetime;
-		u64 cycle_time;
-
-		mutex_lock(&priv->est_lock);
-		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
-		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->est.btr_reserve[0];
-		time.tv_sec = priv->est.btr_reserve[1];
-		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->est.ctr[1] * NSEC_PER_SEC +
-			     priv->est.ctr[0];
-		time = stmmac_calc_tas_basetime(basetime,
-						current_time_ns,
-						cycle_time);
-
-		priv->est.btr[0] = (u32)time.tv_nsec;
-		priv->est.btr[1] = (u32)time.tv_sec;
-		priv->est.enable = true;
-		ret = stmmac_est_configure(priv, priv, &priv->est,
-					   priv->plat->clk_ptp_rate, true);
-		mutex_unlock(&priv->est_lock);
-		if (ret)
-			netdev_err(priv->dev, "failed to configure EST\n");
-	}
+	if (est_rst)
+		stmmac_setup_est(priv);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index be48bcabdadc..9745c9bae33c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -10,6 +10,7 @@
 #include "dwmac4.h"
 #include "dwmac5.h"
 #include "stmmac.h"
+#include "stmmac_est.h"
 
 static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
 {
@@ -968,10 +969,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
-	struct timespec64 time, current_time, qopt_time;
-	ktime_t current_time_ns;
+	u64 ctr = qopt->cycle_time;
+	struct timespec64 time;
+	u32 *gcl = NULL;
 	int i, ret = 0;
-	u64 ctr;
 
 	if (qopt->base_time < 0)
 		return -ERANGE;
@@ -979,6 +980,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (!priv->dma_cap.estsel)
 		return -EOPNOTSUPP;
 
+	if (ctr > (u64)U32_MAX * NSEC_PER_SEC)
+		return -ERANGE;
+
 	switch (wid) {
 	case 0x1:
 		wid = 16;
@@ -1013,35 +1017,45 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	mutex_lock(&priv->est_lock);
+
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
 
-	if (qopt->num_entries > dep)
-		return -EINVAL;
-	if (!qopt->cycle_time)
-		return -ERANGE;
-	if (qopt->cycle_time_extension >= BIT(wid + 7))
-		return -ERANGE;
+	if (qopt->num_entries > dep) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
-	mutex_lock(&priv->est_lock);
-	memset(&priv->est, 0, sizeof(priv->est));
-	mutex_unlock(&priv->est_lock);
+	if (!qopt->cycle_time) {
+		ret = -ERANGE;
+		goto unlock;
+	}
 
-	size = qopt->num_entries;
+	if (qopt->cycle_time_extension >= BIT(wid + 7)) {
+		ret = -ERANGE;
+		goto unlock;
+	}
 
-	mutex_lock(&priv->est_lock);
-	priv->est.gcl_size = size;
-	priv->est.enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->est_lock);
+	gcl = kzalloc(sizeof(*gcl) * EST_GCL, GFP_KERNEL);
+	if (!gcl) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
+	size = qopt->num_entries;
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid - 1, 0))
-			return -ERANGE;
-		if (gates > GENMASK(31 - wid, 0))
-			return -ERANGE;
+		if (delta_ns > GENMASK(wid - 1, 0)) {
+			ret = -ERANGE;
+			goto free_gcl;
+		}
+		if (gates > GENMASK(31 - wid, 0)) {
+			ret = -ERANGE;
+			goto free_gcl;
+		}
 
 		switch (qopt->entries[i].command) {
 		case TC_TAPRIO_CMD_SET_GATES:
@@ -1053,51 +1067,44 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			gates &= ~BIT(0);
 			break;
 		default:
-			return -EOPNOTSUPP;
+			ret = -EOPNOTSUPP;
+			goto free_gcl;
 		}
 
-		priv->est.gcl[i] = delta_ns | (gates << wid);
+		gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->est_lock);
-	/* Adjust for real system time */
-	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
-	current_time_ns = timespec64_to_ktime(current_time);
-	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
-					qopt->cycle_time);
-
-	priv->est.btr[0] = (u32)time.tv_nsec;
-	priv->est.btr[1] = (u32)time.tv_sec;
+	memset(&priv->est, 0, sizeof(priv->est));
+	memcpy(priv->est.gcl, gcl, sizeof(priv->est.gcl));
+	priv->est.gcl_size = size;
 
-	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->est.btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->est.btr_reserve[1] = (u32)qopt_time.tv_sec;
+	time = ktime_to_timespec64(qopt->base_time);
+	priv->est.btr_reserve[0] = (u32)time.tv_nsec;
+	priv->est.btr_reserve[1] = (u32)time.tv_sec;
 
-	ctr = qopt->cycle_time;
 	priv->est.ctr[0] = do_div(ctr, NSEC_PER_SEC);
 	priv->est.ctr[1] = (u32)ctr;
 
 	priv->est.ter = qopt->cycle_time_extension;
-
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	ret = stmmac_est_configure(priv, priv, &priv->est,
-				   priv->plat->clk_ptp_rate, true);
-	mutex_unlock(&priv->est_lock);
-	if (ret) {
-		netdev_err(priv->dev, "failed to configure EST\n");
+	ret = __stmmac_setup_est(priv);
+	if (ret)
 		goto disable;
-	}
 
 	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
 					      qopt->mqprio.preemptible_tcs);
 	if (ret)
 		goto disable;
 
+	priv->est.enable = true;
+	kfree(gcl);
+
+	mutex_unlock(&priv->est_lock);
+
 	return 0;
 
 disable:
-	mutex_lock(&priv->est_lock);
 	priv->est.enable = false;
 	stmmac_est_configure(priv, priv, &priv->est,
 			     priv->plat->clk_ptp_rate, false);
@@ -1107,9 +1114,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		priv->xstats.mtl_est_txq_hlbf[i] = 0;
 		priv->xstats.mtl_est_txq_hlbs[i] = 0;
 	}
-	mutex_unlock(&priv->est_lock);
-
 	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+free_gcl:
+	kfree(gcl);
+unlock:
+	mutex_unlock(&priv->est_lock);
 
 	return ret;
 }

-- 
2.55.0

