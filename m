Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108942;
	b=ZFulS8N4PzCquYgntg0ZrKh1G2yqC9CtS7M/9IsSOTHIXAtpDSVV1pCdC3Fc3SI71LW1
	 WT6gLNO1ujrLDRwBX25mzLBc9O7dMKpNUPADtH3rgY9XQhaTm0xKWsqYnjCnoHrKdnfHY
	 ADEg9zIRRjfmjRuELa8yvqWK1U9lm1M0xNNPCVMKq+99YGZ84eqTm6Slw5UPiLa/ar2sC
	 UXvQ59fwI338SZUX+EBs+CHVqz7nUQSh40slKkT3LmBaPxQj546b1cutWRylg5c0W5USM
	 t7CRPvP0d9/PNroGnVwA1/w+LIukz/uAHXOEReDckkM4QW1gfff1wugp3cQQMmjo8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108942;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AmQqM/FOqOqOLJNrO9V4EKVQvKZuNX4OQLoiG1lHBVQ=;
	b=rtKsRfpgxwIwuLHOqUk+uWHj5Di0io46dNfq9LsmM0lZkVJvat/NUO4wPLOy/jwhszKz
	 wb85EW3v9pIMfH8Xk3EbufAN0Me45Kmdsyj8u4m2hnJj3G6ehluicZUDZ3Bh8p42oPYxK
	 VGMM9T5c2SamGruAfAQk9V8KnhpvW1O06JgxVyJEUXricrsH6ipCZra3ygMLqzZJ9p8Z0
	 d8rlhbblQ6SauqmV4MjEJBLQa7bC8RuAgkczJzSYxnp4QO48NRqYbbOLnqewkHl2oHOok
	 oIIYPEvQ+cWdnvXkHHsnOQ8/nsY2JztByfNrlbIDEY4TARCErHBoP1eHOmAVKKiLe4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c0OQ0ueG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hwydz0Od;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF5606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BBF5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c0OQ0ueG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hwydz0Od
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdwNm2458110
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AmQqM/FOqOqOLJNrO9V4EKVQvKZuNX4OQLoiG1lHBVQ=; b=c0OQ0ueGVcdWzglE
	IF1UIuArvMziDXsKE8kJBLLUw79fGM2gk1iwYg/t9ARtp//FuZy9iAgxlOpLvU9h
	exgmrU8P+85NaiUI0al8fZBTBzO2SnoBTft2cw/JgJSo7DQoyW0JeKlqU8ITFQsL
	3dKth69mKMlV+h+bn+wgPI0X/SsN14orv4DE87fuX11kkayyts5nucNSI97Ibp7G
	VXDWcIMBSfK9/+qGzhXrXErw9d36OmVdmqUluiJ2jHpEY+fzFrJ6BWv0To3mx/tq
	LlmTc+Q8cenPaORezymRRDjpCxBUo15YMyVomS9zSZ7RTgMLojnUW+eeokIMZRyo
	COOAnw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtajje-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1e62510cso1012611185a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108940; x=1793713740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmQqM/FOqOqOLJNrO9V4EKVQvKZuNX4OQLoiG1lHBVQ=;
        b=Hwydz0Odqoyfq5n/aDRSY0Umu9jFrrKTVr0n1pVsCqaStOSUTsruiMEYUq0YxeLiVA
         8lM/PqYCuC77NrPF2bxygVI4rmzBxJ+xZCohR15RD88OF4U9pw6dDtENKaWvbPEuKdiy
         kONB/b0xU3RzUvYWd+D2PUCVU61eUlaZ3THEeZ9U23q2AgI/GDlMEgfZXrWUUe1FpxoL
         9OLZbERv1RcxeUJnSgxYjoXD5Npn3LjX21sJorISEfgeb3nSuFw472knuGhXbywX6jMA
         38GGUvfGrrmibVQ1GaxyjQt/1q90aurGevq+1PAYWsZFa7UedVNLQh+KlLmTLmI9/qRS
         pxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108940; x=1793713740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmQqM/FOqOqOLJNrO9V4EKVQvKZuNX4OQLoiG1lHBVQ=;
        b=QGVOZENP3CF4+he5iPr7823ksCF8GgX7fcjSGWmbIkR/MpBKAfuIRroo1ZK6VtpX8q
         X/WZRFj5ctBrznY/lNjCUsCRY8omj4sHcLl7LjIyU8N3EEoqDdFNhfhTaQrS0dW5Xu4D
         z+xT9fhs4Vqqi/kK5DtsmpEeIfGQaRoHWB+oNosDx2e+XB8rOweqeG2USbHWISGOygCJ
         lEx8xNbkXjyBKcQnF1zGepCOmIYEI73VDkX06C4SveGUGDGX7qs64SB+LcEdEHLILD6F
         9bJBiM81JZHmk5W5aN/q8XHsOPQIdg7CrC7NecRFKumoVjUPwkABNp4QCSF4yjpMLKWV
         REvw==
X-Forwarded-Encrypted: i=1; AKwUvByxrZwgEAr7oLMzWsS31isch679XOm+GGTtVUnWSwR9uoSmpLTdpDDeKu/Kfd6os5fdQcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/CZGqUOlcfpB2x/7+sUvZMxvsl3tDbQkKUJgqPnautFuOEUdA
	+v1J72CEJIvwXFetYI939m+aDniAZB4aya2EPMfNvyPQRrJp/Ji67TR9NiextjIdq2Ccq9npmLA
	iEYwiWVRjo6Dt1DSfk7sA49L8n7fJNUhwhged+ntakgMhuYJmZKcSKJ4=
X-Gm-Gg: AYBFou0A5lsNdPs4bKARQSBzEkSX7uPYzgjrx9qytZtUImTJq6OYMdCr/qKuRHP0CA8
	STgrHkixKZGNyd2AOy3bkk1+jzHuHJl0jX2Sa8OgpWw0WLaZuNgtDMraQ7cD1Ang59GP9rG4tmN
	82KD0tIrO23JrfyzUaq2ZOvbI0YF9Lo35fWXTauYVhz9HSmjv3PSdtkdPDSKGpzvshgJ1JLa3cP
	iSejOhIeg5OSmC77y6wzq66LwDRU2dvTBw9dcLPufB98qFe+e5VL5rgDGXVXIIviALFr4QOAiGF
	yzb8cCV3joFzX+vwNH2wnzVNzDi9Xy1Rejr403y2jWzurLMNGj2kCcqKk582Y79m2m0Kj+iwLnr
	dBqv/Fya5hW0=
X-Received: by 2002:a05:620a:a895:20b0:943:b019:f011 with SMTP id af79cd13be357-943b019f025mr869448485a.28.1793108939932;
        Tue, 27 Oct 2026 06:48:59 -0700 (PDT)
X-Received: by 2002:a05:620a:a895:20b0:943:b019:f011 with SMTP id af79cd13be357-943b019f025mr869445885a.28.1793108939391;
        Tue, 27 Oct 2026 06:48:59 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e995dsm455982266b.25.2026.10.27.06.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:48:58 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:37 +0100
Subject: [PATCH net v2 2/6] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-stmmac-xdp-fixes-v2-2-10eae8a093a8@oss.qualcomm.com>
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
In-Reply-To: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX6ob86lUKIDZp
 xxPkEyFJlBV9UR1tFInSOojcpTqQqif0PicStQ/LvIJjw9T8l/Wd1PRosaI37q4WqfgWliuM+dN
 L9wEvMLLtiws3Xymde3hry2cVQf0Zis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX18Ym6Jh9NqRD
 8PmAGbrTtXm4Wf0+EBITZ0bZR01dA7tgdx1N9KpZKz3uC1QUY8Ay/EVLjx02gnpc603DiPsnH/Y
 9DiwsZC/Arg8/xtMYHjJpR/B6VPchIiBJdo56sbCVoCn4e2ATYgBqrcQhRYd/94LgdIJt0Ws46D
 uicgQE3Gq4qukHSzJHrH8DBuMdTH+HJBO1f/GXMObtO39hTUX3KEcXu6/tSs4yL26R1Qn/woXtN
 535Ej+aY4Cv6ebSLu5Tsu7ZdfesrEsU+jebY3/2BUakWEKDmex53hSwsWp92jwGfsIrJ26PSP61
 o9A2qM4KZ97rDObEs7LD3S9PCd52f5XQw2oO97gVVU2d868Fr4xCYotbtkdEGPfXqq66b3iUxMk
 Uqy3rru2CRoiXdcituQWWe/8gjgFGmXqZDHhkBebNkIfwWQ4dtvVF4qYL1MASNBEajQhCBSo5k8
 hdVgKrhzPLBY2vYZ97A==
X-Proofpoint-ORIG-GUID: JP69_e3NF-bsVyBOaIC69aT7yvtFZhXL
X-Proofpoint-GUID: JP69_e3NF-bsVyBOaIC69aT7yvtFZhXL
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0abcc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=6POjKhNZmwZEydtLWKIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
XSK pool buffer and drops any frame that spans more than one RX
descriptor:

        /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
        if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                dirty++;
                count++;
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
dropped frame once in the poll budget / rx_pkt_n. The direct 1:1
mapping drop also increments rx_dropped.

Use a bit test instead of an equality test for discard_frame.
Commit 644b8437ccef9e ("net: stmmac: dwmac4: report Rx checksum errors
in status") made dwmac4_wrback_get_rx_status() set discard_frame on
RDES3_ERROR_SUMMARY and OR in csum_none on RDES1_IP_HDR_ERROR or
RDES1_IP_PAYLOAD_ERROR, so it can return discard_frame | csum_none.
The old "status == discard_frame" test missed that value and delivered
frames with CRC, overflow, watchdog or giant errors to the stack in
stmmac_rx() - or to XDP/XSK in stmmac_rx_zc() - when they also failed
the IP checksum. The change therefore affects the regular RX path, not
only zero-copy. The bit test is also required for the
discard_frame | rx_not_ls value returned for non-last legacy
descriptors below.

Normalize the legacy normal and enhanced descriptor callbacks to report
rx_not_ls together with discard_frame for non-last descriptors. This
allows both stmmac_rx_zc() and stmmac_rx() to drain split frames on
dwmac100 and dwmac1000 instead of reparsing the final fragment as a new
packet.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Fixes: 644b8437ccef9e ("net: stmmac: dwmac4: report Rx checksum errors in status")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 023b54b72478..7ece8d4157a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -205,7 +205,7 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c4b613564f87..d19bf7ca4db3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -70,7 +70,7 @@ static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa7108919e90..33814672c842 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5714,18 +5714,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 							   &rx_q->dma_erx[entry],
 							   status);
 		}
-		if (unlikely(status == discard_frame)) {
-			xsk_buff_free(buf->xdp);
-			buf->xdp = NULL;
-			dirty++;
+
+		if (unlikely(!error && (status & discard_frame))) {
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
@@ -5734,8 +5737,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
+			rx_dropped++;
+			error = 1;
 			dirty++;
-			count++;
 			goto read_again;
 		}
 
@@ -5907,7 +5911,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							   &rx_q->dma_erx[entry],
 							   status);
 		}
-		if (unlikely(status == discard_frame)) {
+
+		if (unlikely(status & discard_frame)) {
 			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
 			buf->page = NULL;
 			error = 1;

-- 
2.56.0

