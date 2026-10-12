Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114F49E120
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818723; cv=none; b=poDCu7YdcxNkw0ZPk+w3uM2chDZGA6Sb8LYS/mjRhPE7X+03WmC/FujRcmw4JOW6hLvyfKbnysRoaHgtrJTa4pzOSPd1L0If7X0DsSkyJRusVA804suZNWlwcO2wcEZDghDa6iNTcC2ZHQIcz6XpA9Qs6FWMraRZ3Ysq39j8Qgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818723; c=relaxed/simple;
	bh=X5i03B1356B19CZG39num7HEzLFY3hgoslJeIwvZeK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGZzHctJ1aZalkbdkZx+zjX0e6rl33oW/KvyNygzFEj7/fL4NQroKQioCFglMm8irfmNvHo+3CiqY2LITMy3x2iwWgcB+gewxOHkGaATq/POlBNyVzJPEGNsBYJMlJ/kqoGHYfuuINsMec4kdj7TlD9+/Fc2+8+/8uWZWvelpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hHLA21iU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M/KVAffW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hHLA21iU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M/KVAffW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CBxtFr3364053
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AV9tmVKum9YrJoJWP0QRLd4eRfkv0CgfW6YzK0/bKew=; b=hHLA21iUdjNz59Nh
	73E+yS0r7blRxp1lxC0B0sWq6LVx4m7LMpj67NlHHwlhFHoYSrX+edzOT3GmsroU
	EjUp/rnIz+4V0tZKr++Pejkfhyc08666ZtzvM8YiStTGgu2TSFRDSbGRje9jttPT
	GOU4aPI6IQlVaPFB4ZgQzbvD668ClYIzEexBe8JwNv1YMnAZnzrTTOrqJCJQ4VeC
	5ASP5QGVktP2JMBC0XkZ/Hrp7q0PQNwDGgA1c/UqvI0ydKe5zzavWeVNmQ6oUxpR
	WfbBC3husBUay9Hspyruf8/PejTFg2dNsovVlPiMAdwdMncsVlm427YGF+CEn0X2
	mdgC1A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdr9dsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so436089485a.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791818720; x=1792423520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AV9tmVKum9YrJoJWP0QRLd4eRfkv0CgfW6YzK0/bKew=;
        b=M/KVAffWAdlBHSDh7qGifKsL+DVaB+KA7mUTdlBkA7PtLGNOGEmm0K0maqmI7sQuh7
         eZBl0dtYvobJMD8JftjEgFJtC2rbM5uUw2fuk94KfIwbUVyx1NxzgBjKDh3HK/SqE3sI
         BJyP5HuWjKunPxhERavleBz7DEvbchsaxPvNic7MVNtxgch/ApOnDlwMU3K7DgMyotkF
         KBMn6XE1T8w/4cvdOdQ1RnBbC7HScEG7dZFr+EHk2AvzMCKidQE4SL+cl5MRj+DvKjy9
         lS0RRGnfMi3L5xetYitJsI42rfdRb0mUuXeXcDZOxUDhTW3svDuFhsvfu4W94nyEG2yQ
         iLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818720; x=1792423520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AV9tmVKum9YrJoJWP0QRLd4eRfkv0CgfW6YzK0/bKew=;
        b=ttRpwAB2CD/k7uot1SchHHugHY6HRBRwdQyevfwUHCWZLRsbHhcf9oCdAiSvj6DDCM
         aLf7f7tEVN81BntM/tqgroLBkEQM7RRA1WqVDD/NbbdKFNLJJeX2Yy0t5ZLl8qtdK2gV
         mXMJ8lzk7Uup0oDorYvPJ0m4rwN9uzxN5/0lYxek9jvO8kssHiA6j1kvji3UbKR8XtPk
         U2aCTV6VcCS9KLTbzIhm+8FArELqx3ghNdztKFAPu/oWDkBtYDl5TpWglF7Zx6wVlQvV
         H9wZyvtaZ18w/5mqwJ8HGLkr1ZLGqKafhiia8nvFnMtVzkxnv/kna/osNztc2Qq9bFwl
         EsvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxcdTNRm1RhLXjHq1kM1+TvAC+/Izlovk2W18l5SHoTnWNu4nkLGUeiaLLyxDxqq1OPHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9ydAj/v4j/SUFblG0pukNAyyMcj0mj/XAVVTvqvbIFzWlnzEh
	ZR0FF1snozc7dgT8kkHikVK+fPfbfQSD+myQTf2nGWXV8D2AmaIhwPLYWc5pnjUuqA0AWGm8QlM
	Sp0U7fe+hKetctLQfsG36K9oO5LbSjSbPOtBx92OHxxVdD8V0M5sx5CA=
X-Gm-Gg: AYBFou0PnnzGW/7Fkd6YIMVlZ07nzq+5EW2ADE1hcMwgE2hlXXQbMARAOhc0XTKLlmC
	/ieGGxcLu+QcB7IRw3HTqhvcRoweB+bUsPmNGXaIxloBvWYCbZhHd1+GshLAfzkcppfR9gqoook
	TiyyivSXH6V42597G7f8M7UYzCMPIcYe41AFNR+CgDYDVEoyiKChxL+r96JwlStTkxKb5eaXt9h
	1qP+gCHvF1MVyxaDIA+7+49Wndvt/BXgK8yI/GMzThni+WwdAJmN0YOYnfdr7C9OcytjZOAtPRO
	3HLqL6VkYGgaGDGcstPDiJeFP2VxdrgLrA5vNTTUl17OIVoogON9SYJF/7T4iAmB0uQ21Hf5Vl2
	y3KkXkGCbsSczzg==
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:43f6 with SMTP id af79cd13be357-93ec12c490cmr1632983685a.67.1791818720074;
        Mon, 12 Oct 2026 08:25:20 -0700 (PDT)
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:43f6 with SMTP id af79cd13be357-93ec12c490cmr1632976585a.67.1791818719393;
        Mon, 12 Oct 2026 08:25:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac35dfsm33381f8f.33.2026.10.12.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:25:18 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 17:24:39 +0200
Subject: [PATCH net-next 1/2] net: stmmac: fix XDP TX DMA address for
 compound RX pages
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
In-Reply-To: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX9rHtJqZ3f3AR
 KZJKSAkjMEyum7QmY5GmDPwNPz3+iMERTg/4Y4oQA5ps/MCJfhvQoxWOZOmCWlewSLPNiBxYlUM
 faaAwmEDpIQSrlzGWU2pfkWpmhOgf4pl/CefYmLyrc2pbzOgIq8dBnHUCRk26B9blCVRHeidrKM
 8IXUPQQx4TVhgI2m9twh1I/Xf1vwJjhdoEtuVLPUMkUgpqQTuXms/mxow+3h82bPRyFGZNcgEuz
 LigKfbNiBTPhd16SUt9j29pKcYaSLT4elTOw+cCDBKYSdDPZoR7v6Ju/dkudwbMdgjJJJfLRQR2
 Mv459jtfUKsf/38phzyEl9UvxBAM9sBi8RVMKNZbi5Nq8mrFZL9u70EbFllbqGBGy4tGbtTRU08
 zatauBBl0wei2suWuA2j5nIyub9eiiV4p5HTOEvRJuaPf+MCLmVed3aN3JXr58EOJciV5va25So
 YdCEqwLuHEkBh+UbbHA==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6accfbe1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=X7MBymmcuZ5hxvlvhugA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX2dJmZ3eIpoAF
 tZnmzAztr9griajUeEnax7VrSKD/JGzQNbWB1a+cuqfnC82SRlpvjWAAA9PRU5Oti31qje4+5fQ
 VbPPYevjgWpYh079+uIPfPJiDNs/OO0=
X-Proofpoint-ORIG-GUID: 8neDGj3aN8Kddoah8hNWSfj66K-TdVMV
X-Proofpoint-GUID: 8neDGj3aN8Kddoah8hNWSfj66K-TdVMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120061

When RX buffers are compound pages (order > 0), only the head page
carries the DMA address programmed by the page pool
(page_pool_get_dma_addr()). stmmac_xdp_xmit_xdpf() computed the head
buffer's bus address from the page that happens to contain the data:

	page = frag ? skb_frag_page(frag)
		    : virt_to_page(xdpf->data);
	dma_addr = page_pool_get_dma_addr(page);
	...

RX pages become compound as soon as dma_buf_sz needs more than one page
(pp_params.order = order_base_2(num_pages) > 0), which happens from an
MTU around 3000 bytes once dma_buf_sz reaches 4096. If an XDP program
moves the data forward with bpf_xdp_adjust_head() by more than about a
page, xdpf->data points into a tail page whose struct page has no DMA
address: page_pool_get_dma_addr() then returns a bogus bus address, and
dma_sync_single_for_device() together with the TX descriptor transmit
from the wrong location.

Use virt_to_head_page() to read the DMA base of the buffer and keep the
offset relative to the head page (sizeof(*xdpf) + xdpf->headroom), which
is correct no matter which page the data ends up in.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b8b4de4c5b1a..ca61ab449e32 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5301,7 +5301,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 			struct page *page;
 
 			page = frag ? skb_frag_page(frag)
-				    : virt_to_page(xdpf->data);
+				    : virt_to_head_page(xdpf->data);
 			dma_addr = page_pool_get_dma_addr(page);
 			if (frag)
 				dma_addr += skb_frag_off(frag);

-- 
2.56.0

