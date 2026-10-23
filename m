Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743045;
	b=wsvsYDekp0/b+Ti/UqRBiHg5nG+bUOnFhQgdAUP0JqNbnyaMnxiGe4Emfckma8q+je9h
	 nSyXtGHIfAjKGq+zmOw8KJnLuTod8cSEqm6GEr5+ftQtFpFT6554Vk8uHNonqeoM0hUXS
	 mNjRpL+GKUPl9ZjkJ4NQkyViDG92BEsVJTMjT2NR35ictKNVaMO7z8VJt4DTWIo41GAMr
	 FQkEC7SuGOvvLLdhb5TzFG+jxKwTBY9iIdkIJl0Wg0mhmrERPPAmBukliUjlZhKsMwo29
	 ud3qclTxPErCCnY4whIJPP9/uF0JxYDFIdGFuurYtT9be8gwAr+MgAqkOZSK/7+RDBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=;
	b=yw8SnkCAbeqSMe3EKCQ6xjqhI54xCi7jxsgVjC9eQlP9/yNyJQGG55SkMfnpf8sAWVlZ
	 kDIK0C+oXVgU9yJ2rHtL55mJrzlWFFv7X4sgjjrM2KltiR9+7uvQdlJ7KdWBTPAw2VBw/
	 ///dHEh5kJG7+m5VZQIM/LwW2QpAgMVZoXBCJmRzfSoKjYypdfkgcWy+e/2uVc5SmQoA+
	 ElBHONMwFU+2t9PvPJ/WeD5Ihdh+gFIlGvZsCwTat407XRXGYepQq67/hfV7L4wpuPAVV
	 HFUQFz/XCqBN2hDtqGerFcRfD4qDRBaUojYxgC6ZZbLA6UBwMipfaUeKJ01d4EbEeaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y+Kzydqg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZsGW8WRC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D24606A322
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D24606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y+Kzydqg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZsGW8WRC
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FTuq2650363
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=; b=Y+KzydqgVm57vbKr
	1/4d5clgmk1xev0MNqnpDNtziAEKpwB1nQJZkd8szBg4V+CjP4WTmYxp5vOn7Lge
	+TXrUpFF/fmSLPJGmFAgZrMn/cpbG1x8fiC1hkTuovsFnQR98Snyvfvv4GPMW2kz
	KLXIuGf3LZBbvaCwWLfJkf2zuP3w8if36oaGS3tEVCOhg+LjUAFJ/CwziPVvmkhJ
	xyVntjFJstKtf/ZVHxiFVsESr8EL+MM8K0oMGXskMn1qINktXxvmuhAIRLGuSlvE
	BmZtx6iJIWilwhPwNrfFyq1Hl7dfdVPdvXn07HEnIyfIk3wZ/VNx12bpH15lp0/W
	y1hWQw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjapmn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f33438950so140200785a.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743044; x=1793347844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=;
        b=ZsGW8WRCNl15aTjELjNlZQqb+g8VKYgmcFS7Enqosvh7eFGvRG4a4tf1tpckaI0mUi
         d7cXoTjU7RF+M2EfBtVxy2uaac/uaFkaGPflWLVw9Qo+8NDOSsEocNMjeO2PD30g7XKc
         KEs9l/cMjlSe17yGk8i6mQlPanOfup5buKZDqMwiRqB/K4t/p6oxySDOhK9cvRDmN7QU
         f/SsXdLjLDZA8kw7DjMRAJbYEEfeAJaTJjZJVD6qZP66oTa0lGfJKxzrPEBMsy6eSWok
         z6wFHYoEF/D5At2ZFdkErOexHqPcQ6IfVqljM+fMa7pMCJXZ1PuDQu9gWRcaRe9SNTZK
         +B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743044; x=1793347844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=;
        b=M8ipS/dLPV7Xa4lamCWYKhPwMFYphjMX+29B+M/Riiz3YDwclyEHPRxSZ8TwtbFgLZ
         aa+PEUg2YZCIRmYr6/p1inXRiLvtPK/PhsaGzCyh4vIFaYNXwRm2A0vEk4am6R3BHFPq
         Ex8no8PpwtDFBB2x9LqK/u9AHQlM+tq2Vr5LnYdDuqXbv66+q0dK7Hwe6lwGXfI4zXxF
         4cp+AjyLAlMiLkhU2Xf9yiKsCUE2dGQfzuVd7uq++eJNq5MGrM4aatOx6WyaVu+3Tqwo
         YJ1qo3zb4DG/wr5Gp67rUmdPvDTE+4D+K8UerGFoV8yMrZLquWBxAMIcktk3Ha/dZAf3
         iNnQ==
X-Forwarded-Encrypted: i=1; AKwUvByDGJ9+cTBxGPvirqmrR7hKXdUceIMRrJypLN5yWuiEIXdNqJtvHbbvN9rtkTisI6l2MRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoki04lzzQJcc8pS4N1HZQHSDYOeiEyPbD++yG9NP0eInmVl/5
	ovxt4tUWDQ5uDAaCGNRaybNXY1Bl7KL2AP7LUTfDyetcrXDP3Ujt10E4RN56D2JMRIDqAEAD8VH
	hpn8+h+jvt5GLp2oN5vvqeyqGwoUfhdyJHKXF7RmkyMH02F6aKvjFoUk=
X-Gm-Gg: AYBFou0wk3P8J1Mio2W/cla/t9TCdUZS0KChP58tz0r7LaM/ZrPPiCMUobpiMLfqLfZ
	CtMLF4SOoo2xEQ6ntCZV4KaegNbjA7EPAdTUXTBsrhlaHQdr5fJ4dHgE/xkHVsmTMfSwKJS4qcL
	r6DdRX9dt6F3nVfW26BGbmKq8iveKgGXQmH+AtydAhN1Xml+iSy+hptaucyfmNqQREmKYGAr7Sd
	Cw2tPH/Ks+wInMZtzI7+mMAtt9+F7tRXctLfx8B+FP+Gmg+nn4pArSQQNOQyuzq09RjmjCugqXx
	puMy9a9k6/fikCydtdthgF6Ky1XOXS7XID+tdl9NnZJEHRvTfh8ah62lbkpLIcZWNM11Fc519x0
	gg4nCp5O9zA0=
X-Received: by 2002:a05:620a:a888:10b0:93e:b0c3:388d with SMTP id af79cd13be357-93f6f54c958mr203884285a.11.1792743043602;
        Fri, 23 Oct 2026 01:10:43 -0700 (PDT)
X-Received: by 2002:a05:620a:a888:10b0:93e:b0c3:388d with SMTP id af79cd13be357-93f6f54c958mr203882485a.11.1792743043078;
        Fri, 23 Oct 2026 01:10:43 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210299910sm57399365e9.1.2026.10.23.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:41 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:58 +0200
Subject: [PATCH net 6/6] net: stmmac: fix XDP RX buffer DMA sync length
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-6-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: auq6P4aHVrO8OO51H8icvstLHRKLZW7B
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb1684 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LaBVFg8F59WyocPVFFMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXwHhe7sqGwbTa
 wxI5tJt2q9PFbvZOkoLs7iu9tWu1La09toiJ+8S+AXWRsRhT56gfFIwx7dY5hRsm7mE2mQKDBsB
 1kG52WZSzNs1xWXxbpMxwjt5RCFExgk=
X-Proofpoint-ORIG-GUID: auq6P4aHVrO8OO51H8icvstLHRKLZW7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX+a2YxBIr5pva
 ioPtxyxYBWRpZdPolIbnW+bMPap31p6/K27CGs8Q3pBdnmQy8dpHfy/j0Jo3G/FwZ6uwJ/QS/9l
 Y26Ej/Tg6htzYbMug6LLK+4gO+Tu6m4EjrJRr/yepNmLHnCA764py/kehv/KbTT27H2y+I418E6
 ePkC/vKLY1i6Qvfm5POtDaw0dwSVVx5l5hAqYtjUQbCQmtwKNam+x1P63Zi1/8r4fmFh2NnMqMS
 +ldzit4WgMS7F4AmWFM+EBZQ34JzhY+X8INlEx3uU6dyNYnLTfHcVgmND6au8FdoBIfpXlkCtau
 ZCgkXHLJMmwv7nI/MNOav3M0nWXpBnLKh4zYl0ROLV4fdEFUxZyDDIcjjZojwceGrFvPX10/QHk
 z9v4a4Cem1TfgFG0juGNrPH2AXmmjj99HZCdfNl68q0VoV17ZBJDrTb5fH8S1WaFTc1zMAaZun5
 I18woDXDS3bLXdEBcLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

Since commit 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
moved the page_pool DMA window to offset 0, the sync range no longer
starts at the XDP headroom. The XDP path still computed sync_len as

        data_end - data_hard_start - buf->page_offset

so page_pool_dma_sync_for_device() synced [base, base + len) instead of
[base + page_offset, base + page_offset + len).

On a non-coherent platform an XDP program can write packet data, write
metadata or grow the tail. If the program then returns XDP_DROP/ABORTED,
or a redirect fails, the driver recycles the head page with an incomplete
sync. Dirty cache lines in the tail of the frame can be written back
after the device has DMA'd a new frame into that page.

Include buf->page_offset in the sync length so the whole CPU-touched
window is synced before the page is reused.

Fixes: 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 32b2c5834c34..c51358c51fae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5980,8 +5980,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
 
-			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				  buf->page_offset;
+			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
 
 			ctx.priv = priv;
 			ctx.desc = p;
@@ -5991,8 +5990,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			/* Due xdp_adjust_tail: DMA sync for_device
 			 * cover max len CPU touch
 			 */
-			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				   buf->page_offset;
+			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
 			sync_len = max(sync_len, pre_len);
 
 			/* For Not XDP_PASS verdict */

-- 
2.56.0

