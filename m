Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20B4B4867
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823486; cv=none; b=vAZEMWA1zKCLo5utZdI6CLh+BQe9jcf/nhTU/aUg74geS2C0juw7l/0c7tCGocLCBQgJHAbXJgGfbrEf430eiBTNmvO81crWjYNYwBJXNR0QTKwiGFtc6f3U21+ykkng7ZXT2A/YI1PAVdH6iwkAqMs7XGS0rGk+bCdQxr7mez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823486; c=relaxed/simple;
	bh=PNzCV9hPwNjNkKsDZsW+5abejAnYdpudy6D3Gu4mjoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9wrDQt8bJ2pFGEBFwi/VX8L/uveWc+4o3gl2CPWK/Ktrz2oI9hhh7YrzbOJQLidtWSNC8ts/llnCwcqDldSei/fzNnKf8G7omq2/s19idUR/WvnTy5/5GjBDuaaCcmHg5DxQu8Xme9g00R8ZMpjxiLK6D9JZKdOdJ03wgOkc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ApX9a17M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M9zzU0RA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ApX9a17M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M9zzU0RA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFevk41895533
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 16:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y5uGbkqYL5BqGtvqhH6fP3VPuTl/sxkQyH/3ZIuzOc8=; b=ApX9a17MgDArd3zz
	IEIomvFkQPdFNEZXNs0jrcGizyMFUeVYF5lLWptmDLl/KpgiQOSxKV7kL/4U1TYy
	AmW1tc/2b0Wi/uciNkWXg9kAfBjMGrGiBjAI2xAd8eeaeEeeUOiYvhx8ovtORrXD
	Jho97VAk7gsoSqIDdOSEcqr/jOkCGozpykNCLSOsW/OB5qV2JdU5gxeL1ctrt9w6
	fCQa28y+eWoRtycqglvvfeaSXs545imSmPbpeQmrEaqCK9KEAETaoxNbzSYt/G1F
	nbIouPblNllnfcbOvdapMheFfjc/zuIxAo3U5YsNHzsqTbEEN7RBZbzcbyBzGVE7
	KRDq+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7kt5v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 16:44:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e834ff4d0so604006985a.3
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791823483; x=1792428283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5uGbkqYL5BqGtvqhH6fP3VPuTl/sxkQyH/3ZIuzOc8=;
        b=M9zzU0RAFJETF1FoBMNP3aj6wxhyVCFQPMFVGIz1SrryrC94oqXUT21/330jtC2vGT
         VDEqiDEUUpbi6klSk6ZnTjfGs3vgIrhqvfT4lygs3EqIUX7ZJFn/3hqJp0+QeQoig6ui
         g/GI7Nh787rJ43lwmO6UxmOuEH9ZEpv2D/LrnE0JjltjR5CZvl2iNfBn0aDwmfXsO3as
         GIpJ2zD1s8RRAflTbsBfFOPalZvBvpRiZVHx5/oS13OJSxg1oIu8TBDvp3dXhghyaHHQ
         rfdKy+kyej6ESdGKBncyDTjpsaiHKWnekJJqX1APO/8VmGpBQf1MQKli4ttcZkgmfUr8
         NqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823483; x=1792428283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5uGbkqYL5BqGtvqhH6fP3VPuTl/sxkQyH/3ZIuzOc8=;
        b=GHA9lJPos3od1PfKYvilzRHtTeJjoHw3g+BNI8YKpXH2+20k8NLOgKlyu7ySAWBiXT
         8PAlisPaT8ps3xwxc315d4syNrI+ltVMkW1T24Gypd7d2W9+5RLfrijnlw87BDfBi8Rj
         zjk2KlxXHSBM8o1Wq2IvOLflgYY5Q68Qj8kegNvPTeidsv7JYNvhHevcPwxQXdvJYwHL
         utoYnoudQkaTwkaJTkoPuMWMFOAzQjZqBBse6sW0ZIKA+w2RbGHRKQZ4kVL9LSeF0uir
         pFPEkIupn3dKXRFWCU11hby1e9+HnJbZTIgfGxMKpI+pWkVo/YaRd6jc+YDAwu5EHtYC
         RA6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwro9gHoIifd4byKxRVjFLyUDxbi6lLtPVLmGvhkqX7f0Vk1xo+LGjPCy7q2dKEaxu13ko=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFo2ZFGAIT9b581IHadLVOXnaqw2Ed6Csa+pDxmvGtzq6bZIjq
	zpGkyN9DAA0+MChJEmaFTCa3HYbivwulN7wuiAxOmMQs1aQLfNlPDF/xpeeESmEk0GuLyByY4UN
	Whn558RqMApDbLcoElBGc6Qt+eOEBVGsEwCg4/QVe9sO19skGGOH/e+k=
X-Gm-Gg: AYBFou32oBIEjijcHtbaoJEbBmNYhCIpdCUq0Gnp1Ucd75/MTFQznRJTbNG6JTUhHop
	gtCQy+oHH3u46LR9bly6zQAJX2zq17jpqOGFUAJr+iPu45LwBoFy+Qjj5cKccoyZZjRUkKWgcNb
	w+UsEduxDl0fqih2htL31LNp0IIMDuEBNMJqNUCgm0oyw2qTh8eZRhGEGExUJ1jQUuJqNcFEPiT
	m7Xca9XnhIiLJhpOuAvik9EUjLnGhqMhSvZ1jlepGUN3O8wGhWfJeQr8ihjFyM0jIrDbFSWu/x7
	WvgoQ7h99G1Y1uTWqj9QNcjzdbnxqWSZYsZNJYdxvZYFyUePGyoQSA7abhT1zSB4semfOHBmMJF
	NEpC2Dba5N9DFqg==
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id af79cd13be357-93ec12d0818mr1145454785a.79.1791823482767;
        Mon, 12 Oct 2026 09:44:42 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id af79cd13be357-93ec12d0818mr1145449385a.79.1791823482159;
        Mon, 12 Oct 2026 09:44:42 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaa21sm424502f8f.9.2026.10.12.09.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:44:41 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 18:44:24 +0200
Subject: [PATCH net-next v6 2/4] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfXyUIZN5pJ9W04
 nZp5GXrsaRWv7D9CMzgmZXFeV6KErZ0IoFfZf+iTN+tSysmPFh6AYL7GnnfemWyVCclF35dZhS3
 ovLR9/i+w8Y0SAayzEk0koCYYaBGbkm5NpRfFjkWD/ftrr7Z8YBziXMqh5+TGqF6QzZGUBag6Et
 QOrW/XiVVlP8MJ7AJYqzgl01acF1o0oiZeLmJfJkpCnccjL836iPaSiYLa5lH7TWb8XkWg4XbNz
 CSq2lauInavK7ESY1X4jybFWz9u0rw9VTNOIDAggEMAllEZDGPJ7jK8THi6zSfMKqKb2ndsuLaq
 JrXdvCaCwJS0av+6i6W07ky/Be9vjd75SV9m6KPnESJdidfhkNXbbPOlodfaW4ZtiuSOVnGqn6z
 O15dzHkzuhv6fEAN/V47T44KMjHAPMhkQtkM+RUGTe8tE2fnfCJP2JlwYD350AMolTMvFuCLkZn
 wTUM02IM8he8mXlfNZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX1jzB64KrCSoy
 WaehoN5QB9OWZYHPnO00C9E+Y0qeeSZphyHIyi4Uph2Y24cT5uaL3FrXufLJMen/vpa9h+A9Fp2
 w//tMG8aIwAEDyPDKUvRMLtoKjnulPU=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acd0e7c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=lO1k50BjLTqofN_Ss1gA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: m05dL5p0D3XvzL8f-aINA7WAl6_e2z0c
X-Proofpoint-ORIG-GUID: m05dL5p0D3XvzL8f-aINA7WAl6_e2z0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120066

stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
XSK pool buffer and drops any frame that spans more than one RX
descriptor:

        /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
        if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                rx_dropped++;
                error = 1;
                dirty++;
                goto read_again;
        }

The non-last descriptors are freed and dropped, but the frame is not
marked as errored. When the poll reaches the last descriptor of the
same frame, error is still 0, so the fragment is handled as a complete
frame: it is passed to the XDP program, copied into an skb on XDP_PASS,
or converted for XDP_TX. The tail starts in the middle of the original
payload at a predictable offset and, parsed as a fresh frame (len == 0),
stmmac_rx_buf1_len() reports the full dma_buf_sz length for it even
though the DMA engine only wrote the tail remainder into that buffer, so
the reads extend past the received bytes and can reach beyond the end of
the XSK pool buffer. GMAC4 always enables jumbo frames (GMAC_CONFIG_JE
in GMAC_CORE_INIT), so an on-link peer can trigger such a split even
when the interface MTU is left at 1500.

Set error when the 1:1 mapping check drops a descriptor, so the
remaining descriptors of the frame - including the last one - are
drained and released with xsk_buff_free() instead of being processed as
a new frame. Account every freed buffer with dirty and count the
dropped frame once in the poll budget / rx_pkt_n, and once in
rx_dropped.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f66b796f7725..426bb68c9bbc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5701,18 +5701,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
-			xsk_buff_free(buf->xdp);
-			buf->xdp = NULL;
-			dirty++;
+
+		if (unlikely(status == discard_frame) && !error) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
 		if (unlikely(error)) {
+			xsk_buff_free(buf->xdp);
+			buf->xdp = NULL;
+			dirty++;
+
+			if (status & rx_not_ls)
+				goto read_again;
+
 			count++;
 			continue;
 		}
@@ -5721,8 +5724,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
+			rx_dropped++;
+			error = 1;
 			dirty++;
-			count++;
 			goto read_again;
 		}
 

-- 
2.56.0

