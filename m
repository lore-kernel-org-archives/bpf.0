Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108949;
	b=BLOrFUmRhtQA53jyTdjHTsrBsRDcmcjU0bUKcdYYuAT9cN5sdzaE4zQEVHnnoc6svbbF
	 INxju0dTtTSMt7IPqc0iNEykXyoqmrwsrKoUT2WYpcfislcdt8tKhBveX88uvddQBDU6V
	 Ld95/I8G1//hloCSMxyI/oGvwTjpzcsmhcS6vJx3DlfDNxgElShFdj7OvV5+EJ4L0epRe
	 Eb41iyK2UYXbofnrboptEOjFz6e39QH52vJKJ7KnSLdUPn9b056Q8j/UrCIcHbl4Gf4Zg
	 tTL1rGnFH0BJfJqSbb0heH0ZxD7iP6FtcwXjZWDXr+qeKp2Rg7MV9ly46nTlDsthmmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=;
	b=199OPsISzoj6n0/CsNLPfo+jXlN5EUSB5pwzQ5bSDLWfbA2T2GE4OCF8FvEjZMlBfUAu
	 PvqUv9++NgXpCTJPwPqjqrYGNQzGDv3e9HafcqD8RpR3dP9dJX+XL1dCVSS0uTkTA+C41
	 iU+4H7BUwcY6YffYXkDrBqugC926tIPfRq7RbOcZeAxW4FGotH9XkeE+HdL8tKDDycKaE
	 VU6kvvpMZAcwIZ76YgsnrW7a6eah/gFgVW/cqiCY6IEhBoZlhyMOCeYlYhKK4qWUTuj5/
	 65Y5bSxHcETo0NXa7lYBYZRVDUQxRsaFzsm/YW+MM6dpxnMMLtqiv1mRplkSsUM+lSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VVaSGVw0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PrIc+DKV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558B60A2600
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5558B60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VVaSGVw0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PrIc+DKV
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe2CX1921937
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=; b=VVaSGVw0c/4DeoQe
	FFIo2iPP+suk/zTD0Euu2q8iV5EErkpjwp6/SIV1RJ44OrIJGSBqCOTSqR1t/C9c
	ZWV/DdlNEyF8y1pDyfV+bmyZouDjHgDAAberJIyS4mcXYDKjeySwMFdeJvkXXEcU
	AiPS9/jFR+rR/FIDCvAL19aaCON+Qa1d085jQ+jLB1donLg5CrQb/8mDyEPNf0Hi
	7OHyyCfPzDlEPzBqZagkB2Id8IOLysWyDogpCu+MDIrQ6Ey0/8j2WdLQayoKiEHg
	sr2Nyvra3vYNw/PGs0VDonP7E1CGL15plgnJQmhT7YHa1M/eAioN+5pSLs9Eudgb
	Al/FWA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq695jb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so211081785a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108948; x=1793713748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=;
        b=PrIc+DKVkU7RiMGE1fUo/TkleL3jYfI+cx6pmOWBxEYvEwxK6uaRtr0aVQi9q4N1Bm
         gd7Tp5uopHJcb8ZpEuFO+ujL0QdD0f1hjRNGz1/yYTC6Ajg/AfulNHep7QvoqRCpWNS7
         hCNlpLXDeGc6nH5CIKARwygWzzal1mjR5PKG1vNBAO9pmQC2FE5Bq8thSTdRHHKjda6G
         ahvVzQz5xDubQBq/sDxQIfDLlGOSuCwNx0mEGiY2Ok8TvDLCsw5HlC4QIBw/PHmBZYs+
         tu4mkbBVSnG/3RhUzMNMGMa1Ook8DOcbhMTMrUgU180vLaseVpXvw3bmRcqmHoqdnKP1
         oPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108948; x=1793713748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=;
        b=P782Hr+U4yMS+WtU7oG8glhYyIJem9ngZQpnHWrK4Css5hLAuRUh+KW1T1HfEXQJ7H
         Aa3bsaOaiwgnkY0bl1PTTB/QtYV5Kvv7gPbEsUJysqEK58uDVFwb6ft751JAcouAWGWs
         z+/dcJ/yD/XRdar6WtrSFIf/NKwmXyNJF+JNwVSE5jy9ODUxPJuG6cGld6q1TH7K1VgZ
         GXHDDgF3XcMLGAjSfMdTSJRJnAeWGA0Tc4C2VcsQg1h5umjjMpufH04mxktGogpVx2UQ
         FwvO0i8H98B6EweEtQ38268eq/dq+RVedPiu6yF4mY21Csw477miWefE+sL06HkckMeE
         XrTg==
X-Forwarded-Encrypted: i=1; AKwUvBwVaP7MYKoA28Xcr28TNbAY+b7tp16Q4mUYDEjvfNNUgpu1uvTHWyTwva7J7X0E0x/ZdmE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrzcYrAFpQUa2b6/aGbPOmaIgmnLhdKFvIaH4hgbkvXpOHxkrJ
	UNGEZPgKVV+drzA/kwddWHnp4e56HvBm84MxL//C8WQw8ovZV4NYEjktLkclYxtSsOZxuUbwWBJ
	5kvBUsdu9cs7VX2S3M++0Q+kqbGcssflHWy8SLrOJyslwcY14AzkH44M=
X-Gm-Gg: AYBFou1m6PJr6Xkx4QW+Bh1fG6J2SBdhDq3YO3VKsWalwVdG/D26SheKCvNuttcZKo7
	1qnYrPLUAy0LbQkbob+m0gpdrvdr6Kgi9tghqJPq0yjvN14D95bcVH+WD6GN6Q71LoRU7L0dOOm
	RrbT51XQQBlCdevSlVUWYHhHk8Dqpmh4Rr/L+E0LtYiITnXmPpx329bACdQbCG1x4ftjjuBuSaD
	EDkuZLVQgNahwtkBwuuYb/IvmUFRAoXB0cuBbh254m2eRG0EUm12ctFtjnIzYWxp2jz2XHs0f1J
	jiFGlI1kS9FAu20eiBS7NugI+sutnWB0fcJs1h3sq+wOA4A2PofLsteo4WTu/BIvLtYi3Qg8seQ
	e34gnmR7vPWU=
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id af79cd13be357-943f4b8ce2amr420871185a.20.1793108947102;
        Tue, 27 Oct 2026 06:49:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id af79cd13be357-943f4b8ce2amr420865485a.20.1793108946506;
        Tue, 27 Oct 2026 06:49:06 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49640f1b9sm40758a12.19.2026.10.27.06.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:49:05 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:41 +0100
Subject: [PATCH net v2 6/6] net: stmmac: fix XDP RX buffer DMA sync length
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
Message-Id: <20261027-stmmac-xdp-fixes-v2-6-10eae8a093a8@oss.qualcomm.com>
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
        bpf@vger.kernel.org
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0abd4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=xzJaxtAIzuUiCKeOh8cA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: -xkeJMn8DSf0iFRTuV3HpyR7Dypm6KW3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX0FUNecF4WEvt
 IWZqOwp8Q+ktDl93nhNikF4Gw/bXpHiRLyvz90+q/1ournCboHSN5Crje7U1FvwhVlqRgwU+Ixr
 ku2kn1HZMs0RzkmduWnydS5xEWOE4bk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX6KMsKkWs2Clf
 mFrb2wTDyKBedRKwyiNVfoOPyg5RQkGNjUcicYrdEMAzp1PeiVtXl9+lsjoPWQbEF9ZXxnmcnPV
 n8EowVBX6E/WN6Bkk2g1W+qVsZhcRuFOVNrtgeX2Q4fKa6JG0ZXFzmEJBL9YU/61VRGeaU3z+/L
 0Vov7V0gaCHTC7uln2hDtmoSjtLS6eJlJEOF3tc3gmreGDmz4xP9GBJ8vJtW4f/fDk04kpPF+1f
 YjJOsFMmIsaUTYuq26iWPRZTmRL/1Hsk4w8bBF8bPE3+zZvOxyxTaxzmg+57Oc4Q9xg1OoA7SWo
 JUcTodpJlB8011wE5XMnvANZLbC5Ix8zGuuego618HSnT6mkJTqONVZ+F4YtRrUzhY3rmcDQhY0
 eQjAYhyggLwBLcAMmxcW4bQP2b0GxxDsviw+veNdIwQRhERrgs+Zb8I0OyG7u/6ZFT9jCFFe59l
 AfhuWpFUrHQUtGIWmMQ==
X-Proofpoint-ORIG-GUID: -xkeJMn8DSf0iFRTuV3HpyR7Dypm6KW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

stmmac_rx() bounded the DMA sync length by the largest data_end seen
before and after the XDP program and passed it to page_pool_put_page()
on the XDP_CONSUMED path. bpf_xdp_adjust_tail() zeroes the grown area,
which dirties the CPU cache, but a later negative adjust only moves
data_end back. If the program grows and then shrinks the tail, both
endpoints miss the zeroed range, so those dirty cache lines are not
written back before the page is reused.

The length was also wrong since commit 88095728511e ("net: stmmac: fix
rx Scatter-Gather support") moved the page_pool DMA window to offset 0
and set max_len to dma_buf_sz + page_offset: the driver still
subtracted buf->page_offset, so it synced [base, data_end - page_offset)
instead of [base, data_end).

On a non-coherent platform those dirty lines can be evicted after the
device has DMA'd the next frame into the recycled page and corrupt it.

Sync the whole page_pool DMA window on the XDP_CONSUMED path with
page_pool_recycle_direct(), as the PASS path and page_pool allocation
already do. The device only writes [page_offset, page_offset +
dma_buf_sz), so syncing [base, base + max_len) covers every cache line
it can touch, regardless of how the program adjusted the packet.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Fixes: 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fb3b7174599e..b038472b9817 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5970,8 +5970,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			len -= ETH_FCS_LEN;
 
 		if (!skb) {
-			unsigned int pre_len, sync_len;
-
 			/* Each frame starts here: reset the FCS handling */
 			fcs_stripped = false;
 
@@ -5989,29 +5987,18 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
 
-			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				  buf->page_offset;
-
 			ctx.priv = priv;
 			ctx.desc = p;
 			ctx.ndesc = np;
 
 			skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
-			/* Due xdp_adjust_tail: DMA sync for_device
-			 * cover max len CPU touch
-			 */
-			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				   buf->page_offset;
-			sync_len = max(sync_len, pre_len);
-
 			/* For Not XDP_PASS verdict */
 			if (IS_ERR(skb)) {
 				unsigned int xdp_res = -PTR_ERR(skb);
 
 				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_put_page(rx_q->page_pool,
-							   virt_to_head_page(ctx.xdp.data),
-							   sync_len, true);
+					page_pool_recycle_direct(rx_q->page_pool,
+								 virt_to_head_page(ctx.xdp.data));
 					buf->page = NULL;
 					rx_dropped++;
 					goto next;

-- 
2.56.0

