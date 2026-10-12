Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEF4B1D19
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823488; cv=none; b=mV78clwvtGRtBW97Q0qADtOEcfvaWxt4wrH2HbGK8fSnkgEmCn9dWxYggiL7GKZV+rkDOg11oK7AuZzvVnweKBvEPFpW/LMOgd/zK1IesyzlGs01fFgG3JEsH+ntehxkEYaA6OXSzJwSqiRPXI87hLjTJAb93tnMHrNTKlZHNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823488; c=relaxed/simple;
	bh=0xyEjyBSKDu4MiSCbk7jL5Uqm6SKc87RAS6DG+0iwAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AF3ZLF81Ms+n2ro8gnScC+FIzCMH6qy/rnFwfEiBUHkQpOxJRQFuH9e+C/QmlYPsI74f1+mDmXYjfCyo/x4vgLkK7+AWXn64HB18EdjK9Lx7X6WKwXhYexyRkolwkjb5oYdsQpWBMkYSuRssJHmiDwcVeCvWMCmKt8yuEZZtcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzPAHmLu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AZKg4tSD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzPAHmLu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AZKg4tSD"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFewUp1895566
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 16:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	avi+XkrV3WTbZAOaZMmBOeG+lzogrfppC5qF3amD0t4=; b=kzPAHmLutDUCWOIo
	TeKbEZ26MR3CLzAgFhnsG/ta5bEZzMI0YqJwwsHqoCABr7wn+WdxDDZYDYuWIdnv
	0f840MWLQuxHyrW3M0dMLOeLQQ2KuxEkDLuIdmBIvdAEK8Q6i107LW6bzw96leFH
	R8Gl77woPwRsCHIiKETQHAuSrrz5T6L62W0mDyfIAwcHNqJU3fqe8FkqsenXqEFf
	y+KyHyqQU94ZGvztBjCOO7qu2PCrK9ZSr7TSjILjuen1B9zN0FyBnKY4qsVMS4t1
	IKpTIL7TgavlCEFW6ecE2ptyLnKbnnR06/Xw47L3w/NHgGuhW9ozck63pO9g4NXQ
	kNTcQA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7kt5vb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 16:44:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-917a7c17166so42097156d6.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791823485; x=1792428285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=avi+XkrV3WTbZAOaZMmBOeG+lzogrfppC5qF3amD0t4=;
        b=AZKg4tSDA2X5FRKcpkTaD93bVqvh5rRB8vih19/yVChjjZmBi3Zsb0ykUFn0gaQCVa
         Xcx4zWB4oDyv72IOAPlPohWpC9HAAW5WAeHHCpx6ZueNIKVNPcsgJh/L1gFE6PEV4Rqf
         Q1ZPo5WSyHoy/SRRvxPL/6E/e4gosTMuxO6mcG4eOxnAnSRHAYpjcTum2BavSIGjtbB3
         VqBX0/HqdSegAcmPMPOvbHA4E3BAKUerCW60NZIWoegkX77EpZZLqnCJoKaq7UUZMel2
         SPwQ/RMQ2mUxSq+JV88qgwqDduZdreS4XToAoYU/G7cqAAnGsFhGemoDqBh0j6482b33
         G9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823485; x=1792428285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avi+XkrV3WTbZAOaZMmBOeG+lzogrfppC5qF3amD0t4=;
        b=Sv5oZpm5mr7L2JG9+uPj6a4xXw9YAk8WSKzMc69pz90T8JHYtVi99ftnq/9TuS/Vs+
         izslQCu2TVx2uSaCt5hKhLpYqSwHvL4zIbrN3Q1dBmCze5Ss0G2zzIv3kvXcAPEoxkpf
         x99MfyAXfuqZ9himJrtz84t+yrZbC9vMc/GdMDX6Lx3jf1e5236PpUxw7AP7RWbDQ9Yy
         owpkDU1PaaSz6giRDgmplmB7I3HlVOZU4ilDDbuYTCxXFPXk0zpbTLBKZYZh3Xh8DN9/
         tp/Zr1hMCBxvwX12pBsm6gFUxjTy5LUrpMwwyia+9Fw3+0IQ4rdUVl0cmCvbVHTUWxie
         j3lw==
X-Forwarded-Encrypted: i=1; AKwUvBxmin/zU3XlH00vzxZfYJMjORtIVZK8B/VBrnCN7hjkh+3adjpg6tDYpNyusKA6JEk7gFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvW/6OhmVn1mg+2rhOLAtdxYiun5E+4q9zELFXGqx6gWPX7hLV
	+mMGDR7SrI77xYJFjeoo6daJYVcArpWT5tfBNM0V2w+caY7dlGVuEoNrWKXd7Wg+G5tFGqHyFvJ
	JyGu3Ya5O96dN5jOkfZ0y/sc8pGS4kOvh39d1YKxN6tmCAWx+rqaqUBA=
X-Gm-Gg: AYBFou2LABnxhM8f50axlOHZdUH8s+twNDlTI14XqwK+Xx/VEL+Dkh1RuGJ6/ixFzVY
	qmX0+anW0N2HpOXGw/tn3O7w3H9NoJRsF4tDg/MrEjm4a+jdR1Ap6w/lLA9A9C7kgTyRfJHRruw
	jn+iWYc0Qqz+TcMN16G6eYdVikZLcmr5WlEQRjNVeJux+saPSPUdn2EQWhYDYaPt78ds1fyAdcf
	q3Lf+6plc6RbisHW0qS2hfivSPxWVWO8esOD4Z5zJuKNK+dA6SAF3l0GPKwKF+D4eCI6xbLclfn
	S1UwJtRuP1Iv7T9D6T1FMJc1Fdh/9VisbbC0fCcvoD/0WHa4mQic082/emuC1D/p0Xxu6sHCYkR
	ymjkCHjBt98J8Gg==
X-Received: by 2002:a05:620a:198b:b0:92e:76a1:96cd with SMTP id af79cd13be357-93ebd1e041emr1762533085a.13.1791823484971;
        Mon, 12 Oct 2026 09:44:44 -0700 (PDT)
X-Received: by 2002:a05:620a:198b:b0:92e:76a1:96cd with SMTP id af79cd13be357-93ebd1e041emr1762527385a.13.1791823484302;
        Mon, 12 Oct 2026 09:44:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm326879f8f.47.2026.10.12.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:44:42 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 18:44:25 +0200
Subject: [PATCH net-next v6 3/4] net: stmmac: drop multi-buffer frames in
 XDP mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
In-Reply-To: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
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
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX7HLhM+U2wzYy
 I/AS6NWsZhISZHDnfTLkeOaHZA+jmFxw3OWenkTTtwlkOwrpisefKSK6eAmP6G9NQnXw23gF8iK
 /jiGLRixb7chkCe7fMnA+4tWuiwEKD+djacBNQFhGYaSAeA8O3YjWy3CVRY6Ztfl1H55WOP42v3
 RWTLuOUqbf+vcsZ5ZjThg2VRiXku6zDyO5kkn1aEunPzfOeYb0u91fqXWasxCONjIhALCF+TNA/
 HT5bN1i8rKowjXrIWHWzpal2LKauwUnoZwMVNEs5CTWFAOFoCzX+ai4nAFuQYmKUSi8uHjIhJdr
 AhZdef/yQ6f/hWp2alZViC70rjtlWrHLQMiAh3IaaNFGHRw3YtTX8QTupFMPiUlh1qOZBtXpevE
 62myQrTEdkhGicgqUK9JbC46YE+c9Qof/1ljOZXcFozcF4senFtKEIuNuwa2W7Up+kcUCWfRT/m
 msrnc0ZTEioc6JWY4WA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX9DgqTEiAV1b0
 6XY/PuxsKsvfXiar1sDwD21y/HDnlkoGvJc12EKv3nu8mk+cKagzevdtIiMZ8U39ou3nDRI+F3F
 k0Z/GyFSKVntWntZMSCeGw4nPJ9oXVo=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd0e7e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=DrIia4gTWQP6Z4KYkkQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: LUWOUEBzjdrt5APbA29W1JxeR_JbJJWw
X-Proofpoint-ORIG-GUID: LUWOUEBzjdrt5APbA29W1JxeR_JbJJWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120066

stmmac_rx() runs the XDP program once per descriptor buffer and uses
skb == NULL as the only marker for the start of a frame. A frame larger
than one buffer is split by the hardware across several descriptors;
GMAC4 enables jumbo frames unconditionally (GMAC_CONFIG_JE in
GMAC_CORE_INIT), so an on-link peer can deliver such a frame even when
the interface MTU is left at 1500.

When an XDP verdict ends a non-last descriptor, skb is cleared and the
next descriptor of the same hardware frame is parsed as a new frame.
For XDP_CONSUMED this happens via read_again with len preserved, so
stmmac_rx_buf1_len() then returns min(dma_buf_sz, plen - len) for the
last descriptor, which can be as small as 0-3 bytes. buf1_len -=
ETH_FCS_LEN underflows and xdp_prepare_buff() puts data_end far past
data; on XDP_PASS this produces an skb whose length is close to 4G that
reaches the network stack (skb->tail and skb->len are 32-bit and wrap
below skb->end, so skb_over_panic() does not fire). A 4+ byte tail is
instead offered to the XDP program and delivered as a standalone
mid-payload Ethernet frame on XDP_PASS. XDP_TX/XDP_REDIRECT instead
falls through to the next iteration, resetting the running length, so
the tail is re-parsed as a full-size new frame.

XDP does not support scatter-gather frames until the multi-buffer
rework, so drop the whole frame instead: mark it as errored as soon as
a non-last descriptor is seen while an XDP program is attached, drain
and release every descriptor - including the last - and account the
frame once in rx_dropped. Removing the re-parse lets both XDP verdict
branches simply complete the packet via next.

Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" accumulates the whole frame into a single xdp_buff and
supersedes this patch; the fix is kept so the net portion of the series
stands on its own.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++++++++++-------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 426bb68c9bbc..8c08d44fdbd3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
-			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
-			buf->page = NULL;
+
+		if (unlikely(!error && status == discard_frame)) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
+		/* We do not support SG in XDP mode */
+		if (unlikely(!error && (status & rx_not_ls) &&
+			     stmmac_xdp_is_enabled(priv))) {
+			rx_dropped++;
+			error = 1;
+		}
 
 		if (unlikely(error)) {
+			if (status & rx_not_ls)
+				goto read_again;
+
 			dev_kfree_skb(skb);
 			goto next;
 		}
@@ -5965,17 +5971,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							   sync_len, true);
 					buf->page = NULL;
 					rx_dropped++;
-
-					/* Clear skb as it was set as
-					 * status by XDP program.
-					 */
-					skb = NULL;
-
-					if (unlikely((status & rx_not_ls)))
-						goto read_again;
-
-					count++;
-					continue;
+					goto next;
 				} else if (xdp_res & (STMMAC_XDP_TX |
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;

-- 
2.56.0

