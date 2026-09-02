Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725F4A6CD2
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380279; cv=none; b=AwddP/TPbkqRh8kCyWaEFBFU55qnjDktdCLPFliRs9lfriMI+hXUhkpo8zB3jcKiWaXLngyNrK3UW+TOOqQ/exn+nnlMMpJa67/rCxUktPh4o/X5rKZL0td+aI7lkvMteHMSXae+PzMzZmjlZmZdVh8s0BlT8Ig31eD3X88PGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380279; c=relaxed/simple;
	bh=KDgA7TJiYQAYtRWei9u85vme5LNZ6jc1Gdq/MRYbiJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+RzMNh1Mr3MB/DxA7LfDMmHWrinrVo/vFWstgMg70HnLzHzwvTArRBT8nNOYH9d08KxXZil02fCj3QOgWjinNyjREyCe+HTUvNSCEQewP3TY97yGl34MGPwvuqk2bjzKoYdWs4wRgtzTqQJXmFiXuVHp7FP7V10o5K1YWnHRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vtn6kbXC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UBCEyzJ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vtn6kbXC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UBCEyzJ9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHATJ2523722
	for <bpf@vger.kernel.org>; Wed, 2 Sep 2026 20:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D/P6vYyxP2DSmIU7845M8Rwzs9xRPXT9282fqThmHwM=; b=Vtn6kbXClgC3SK5m
	552dRBfHRdS9nsnb8Rw/wSLPbfUHZsRWkuRfeVP1EG+ss51YgqC32wkzLycNAMy1
	Xj/z/+SndUjuf8UuLtVx7GcCcqMx+cqLRWpVEJspoiaG/zMS0OfrCQiCYVW/HxGn
	RBd8e3HuZrUHJjVNielbf/3oMrIaENURfNuReP8mG2YQkkSouUSEMBDTcrSeMSAC
	MR3hWYyip8sgEqIEIeVKFuUhjSv/y+jFeZnKWW8N3Zuppf2zotywfekyIeVkhROR
	c42G0K1ojhXu0p3HQpCObNj3IG77qfguK24XwqS7QP8mYR0feHWxYizccHWd3CXJ
	Tnyd1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4nd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 20:17:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so94663085a.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380276; x=1788985076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/P6vYyxP2DSmIU7845M8Rwzs9xRPXT9282fqThmHwM=;
        b=UBCEyzJ9D+gtNXt27gP8+E1ks+xLeUa4hMXWSBeZej66UikePRyDNfk719qTeAL4Uv
         5bs6SKK8PHVr/nv22PAfYNcM5HJxMLJNG8RE8yJiyMe3SmxQFQ9uDgenYQf74XkcCoWt
         D+l/GSPvG5Y31VocLabsivDarJSK5VstvaSI/0SKu+bRjRXvlSw07czuAzXwAqTnKCig
         gQsJAh4W23BSmW3Qo4y93PYbPSwcQdyT0giJZip2m5kUAu3f43HAcqIYjch9wKSGwzp1
         bkSWODlf5ITKsi3zgeyKcRLRD0EkljnszTDWWYHSRK6MQk6NHRVCsYLkfFE5NP9aqMIs
         l5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380276; x=1788985076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/P6vYyxP2DSmIU7845M8Rwzs9xRPXT9282fqThmHwM=;
        b=BtAb6sTA8YlKe/6oBm3+ruDLr9rF/6ho3uGOEpNjKnXZ985qeF0PhxbhBa4KRZs3c+
         f8Xv2dkNaV2nVnaKjgP0nFPxJOkLhdFg271ZnCjrl3/pS0gMKY7lxyJ6F1EDYbDRADsc
         HJ29ymXDzSux1s3fUhYXXEUTdfPAmhRBnpW4y34dI0+2CsjAH57cbYncrdQ7wfYw1cHx
         cQGyNK5yyex6MVmgJyN8V5X+o5bhAmEBn4UCCBn9fdXwt+C+PCfAjzEREgDiil2V1t84
         glq7r4uka1DJghaP/pNVbM3HX7nlxe5a7i9qh/N4bityqEMULOTLfYnrLPBCXay8tIgd
         RSmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZNYAm6zUyVuDRUrBurB8GUv0VofcT/E/uOsFAT27yczceHGACSSQT5IfyOmSA6q0oGcI=@vger.kernel.org
X-Gm-Message-State: AFuF++nrH+FgHnAJX5LF5hFzhE9WHQ4v0F8uMlO081nHiMYBzZqqCtMk
	wftcCcsZoslYRXSJQc3+H1KnL054ZgmJJzp9q/TbXU1soxAJDwQVNWTeC3ba240Ldi2sCE1vjDM
	/aTQ7frvV0nEKKfPXquS47pqAqyZTq0eEMDzsZjwzbggK+KBuJ04xyz4=
X-Gm-Gg: AYBFou24JvGEbB5OZnS/th/VLDxEvpfpKkXlkyGqCVp+QfniyLSd4emsiuIg29lnHCg
	e7pXNJKqDOhqpXi0Bq1wAyrozWFcX74fK5RLgKtTE6TxzesIPI/72qMbJewK99gSPvGcZxAzX+Z
	z8kSkxRQ49Rn5CuMhKXw4dHHcACbH8bUpNQm4sLSfhJgf+0D5dHirmJ1jNHvGvIRE1W6Ss0mKEY
	i5QTkaifFHgRIWBaNYczrYLU+F+2SVrrGDDgyXo0/f8lNPBexsZKQcN0qvytMyvHYF8My8hOo5n
	IfB0quyrqsaGKyQyNTUET7ggClcoVp5iAxP+JOuZfzSX2E/S550PGsCwgtPUGALQqXEkq8zRyy2
	cD0Xmj3GpbaGm1A==
X-Received: by 2002:a05:620a:45a4:b0:938:ff8e:cd0b with SMTP id af79cd13be357-93960e009bdmr864278585a.18.1788380275674;
        Wed, 02 Sep 2026 13:17:55 -0700 (PDT)
X-Received: by 2002:a05:620a:45a4:b0:938:ff8e:cd0b with SMTP id af79cd13be357-93960e009bdmr864268585a.18.1788380275013;
        Wed, 02 Sep 2026 13:17:55 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm15349995e9.5.2026.09.02.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:54 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 02 Sep 2026 22:15:43 +0200
Subject: [PATCH net v3 3/4] net: stmmac: pass the desired EST enable state
 to est_configure()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-stmmac-est-reapply-after-open-v3-3-e72a6df5a7ef@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a988474 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ESEPPiCkTmsfOTcFg5oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 3TUoXKE8phskYXoCcD8lb5l5I_jk9qlD
X-Proofpoint-ORIG-GUID: 3TUoXKE8phskYXoCcD8lb5l5I_jk9qlD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX03Uh0CavQI1X
 S8Szdxrc1rfTXYwE8wJX+KWfrgyk6D0pfcHtLPFWeev6W7hWqK9ce+HXMYjphGdmNTmS9sO3JCu
 LDuS+UWTK8jCEbE1XEUcuMlL7iUrx4uuB9QBp0yfwfeWCXT6YqFcVIoxiNyxTpTT3dq6zMIdL17
 yxcep4l0S+yhznN0vOpBhUB3NFr0cvy05j9Of2B2xLYK/qqpUj5TR4sZClxGtt1U7yoRTjhrl7Q
 3XKe26oTvQSeGL5AYowgu1GH0boQ2CtKpgBcaD0HadPBXyKo9JaVMbsRc1SRLjdZzrm39zlkYg3
 RO4XLUeT0XrmNmaRGAisTZfQuowrS+bt/bEtpDvMmXWNuhcyDbvOuGOPalTH77/Pp+dG2i7YNqk
 JJv1g6rxtmbrOuuiXwejEVTO4m+yJoP5LniFCD4adeteAlssy/AJtK2MM4wJFC5fLQ6oS0mUwKn
 32mDGtPg/V04VsCAH1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX4ACzeeTbuSoC
 E7hoISIUCFQdpLmJD42E94dAuRaKyqYPiXwFvORavWszDmNpGttHi1Em4tINj+pvAom2ALT+//3
 Fvb3pqPg2JPrj5/jBIHzeBUh7T5KZD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179

Pass the desired EST enable state explicitly to est_configure() instead
of having it derive the EEST/EST_INT_EN bits from cfg->enable. This
decouples the hardware programming state from the priv->est.enable
flag, which records whether the taprio offload is attached.

No functional change intended: the callers keep toggling
priv->est.enable around the EST programming, as before.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 04dafec021b4..e5579166df1a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -620,7 +620,7 @@ struct stmmac_mmc_ops {
 
 struct stmmac_est_ops {
 	int (*configure)(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate);
+			 unsigned int ptp_rate, bool enable);
 	void (*irq_status)(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index afc516059b89..f15d4d046aa7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -26,7 +26,7 @@ static int est_write(void __iomem *est_addr, u32 reg, u32 val, bool gcl)
 }
 
 static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate)
+			 unsigned int ptp_rate, bool enable)
 {
 	void __iomem *est_addr = priv->estaddr;
 	int i, ret = 0;
@@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
 			 EST_GMAC5_PTOV_SHIFT;
 	}
-	if (cfg->enable)
+	if (enable)
 		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
 	else
 		ctrl &= ~EST_EEST;
@@ -70,7 +70,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	writel(ctrl, est_addr + EST_CONTROL);
 
 	/* Configure EST interrupt */
-	if (cfg->enable)
+	if (enable)
 		ctrl = EST_IECGCE | EST_IEHS | EST_IEHF | EST_IEBE | EST_IECC;
 	else
 		ctrl = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index be5b26edd04c..4869827670c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -74,7 +74,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->est.enable = false;
 		stmmac_est_configure(priv, priv, &priv->est,
-				     priv->plat->clk_ptp_rate);
+				     priv->plat->clk_ptp_rate, false);
 		mutex_unlock(&priv->est_lock);
 	}
 
@@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->est.btr[1] = (u32)time.tv_sec;
 		priv->est.enable = true;
 		ret = stmmac_est_configure(priv, priv, &priv->est,
-					   priv->plat->clk_ptp_rate);
+					   priv->plat->clk_ptp_rate, true);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index e25a08e4be5f..be48bcabdadc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1082,7 +1082,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	ret = stmmac_est_configure(priv, priv, &priv->est,
-				   priv->plat->clk_ptp_rate);
+				   priv->plat->clk_ptp_rate, true);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
@@ -1100,7 +1100,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	mutex_lock(&priv->est_lock);
 	priv->est.enable = false;
 	stmmac_est_configure(priv, priv, &priv->est,
-			     priv->plat->clk_ptp_rate);
+			     priv->plat->clk_ptp_rate, false);
 	/* Reset taprio status */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		priv->xstats.max_sdu_txq_drop[i] = 0;

-- 
2.55.0

