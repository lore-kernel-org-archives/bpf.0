Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618160;
	b=NpNNIpCBNifNQQ4NLCMbMZfcMouPcx06PgpeFPFI/UdfXwWbj5VS1wDHFTCuMTVxfCpq
	 4pznw34sBHKgQZyRTmV1vrH4XIs3t4v5bfYV24bHjAYxnn+etOuDC/84h2gY2SiBU+Zew
	 ArN+xC2hkUQeqLpEqD4YroINhGJT5DkMwAJBAsdRWDoWr1hhoFaaEtKj7Ga6No/zEHzVT
	 Jdoi9XqT1RYrXjv/dZ33qaKYSMCiOmcVLlSE6+LY4NIETDJs1T3S/4jzTyv+oXJrJDkO4
	 bq4kpOQ4bCxapSnhfWbq0Vxredprv8dKUBnpwhaS/nLp2fW2nURcSB5tSRzHCEP09gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AvLJ6LPJDQYfEsj0iXxgDL4EBDjauQdJXtj3K3q/NEg=;
	b=QpEQCcvR7biXtYKm+ysNV1DaHzGXPqNLkXxoj73jilHTjLdXIfqd8VkpJTHeZS1X/k/M
	 kwm4aOGxnqIFYHBJDj1Ha7jzUkgg/0lf7Ff6mKNdHh2K//Fl79oWgrtz80Zr/hCwPUIN6
	 h9d7ixQEmZGzqkYz4xop1ZTP10L/GphmbzaPaAiwcC/ao2G8GdI3W3D8CVhqQfKzNHhs8
	 UDDk4cDLxwxFHhHrDs9iEkat3Qm5dUCuGq2y92gifSk95iALAzHH8Uvia1Be5Euk1FuTT
	 +zhF2tTK2kEMb/wdihs0eJ/sJoSGpcXzM94AdODExl+UsiXykIoKmVu/AJz57sdmFoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wfgt8Rr4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I12tslSz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45317606A335
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45317606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wfgt8Rr4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I12tslSz
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEMBos1158359
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AvLJ6LPJDQYfEsj0iXxgDL4EBDjauQdJXtj3K3q/NEg=; b=Wfgt8Rr40icjoFz0
	93eh48mtj38nujU+LArwkZQEXDT6rvi/6D/lBPaxK8DD7Gl2CCLFHMpYDkJ1vPff
	jFPMmLvORF8/SDy2kE6onW3Htf6DTiOO+X0YCBrNecolyzzFB1klAOpjihFr7vab
	/R+hkadWZ3A+/4DlwzX7bkOJUwxOteCIPMULjcIW5bOzvghF9asen2FjJlJZ3h4V
	pcIYCl9aUO7ruZ0yt0zEC39OgeGxHP1MFd9k6mc3G7K2dtbpc7OWGcONyFQB3xCn
	DkPjGbRpfAlkavq7dAc5D1LkHXCY0ULMz8E5QIow7vxqIVvLTN8D6SQ+XA6yYzDD
	q2IMrg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnsays-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:19 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0e878f574so89882757b3.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795618159; x=1796222959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AvLJ6LPJDQYfEsj0iXxgDL4EBDjauQdJXtj3K3q/NEg=;
        b=I12tslSz4uAyFxRl3eOwK7sjzirib021B7Znn9ZXmSVpYE0XLhNAaB2UYH+mPjr5Sa
         fX/gKwGampzYkCVvDjH4cfPmcbpKW0kl2+rfJ5tzfWXoRgFvWus0sMFtNfKkGWP+63wK
         kFyqJqFoQYptOmky9j6G4t5Zwx3KDgGLqrN6A6Mn6G/7Z5TTF9ebstjUEZw4rldOxNtl
         lJL4qIPCkKp2FqN6jCJLukUvrteH4CLH7T/Rlm5Fg0kYUHZUtPKOZ6EpppLzpExDKLu2
         Y6NxOzRPwdVNJvRjnvKQ11C2w7p/7SNdylS3KFhmVl3ovzisz47xkJUUm7qNHMy7u4+c
         E+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618159; x=1796222959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvLJ6LPJDQYfEsj0iXxgDL4EBDjauQdJXtj3K3q/NEg=;
        b=jIm64QaMBHpCoIJBBOZ1RXfFtEtv4cUfquxfix196hnY47XVi1R2axzVpQYbUBdyJg
         /8TCaZi4XjiS1SZvvd2Q3KpNp/C8jaGROVShca/PfdgxUa7zy6o4BbYSxJV0SMHiW7of
         P0E9YoCSo568VBjbP9csaDV7dM4z9ITzDpfpWwtJYtfP7/1bO5pNohd4KnYLe6oUz1AH
         UWf8omPxED09vErixpvqYAqWASRKC8yXbXagK38lbUEyXSREOLAcrZp3k4ZPJuuILj15
         LHdIy/mYMCPrzu8F151w7P0Fsbau3o8JXm7WBuzopXNP7J7zFzta40N6uZ4GwkZQ2AdD
         SAcQ==
X-Forwarded-Encrypted: i=1; AL+hErGuEx6WoN5VbWR0oJUdjZK/x/SwNrv8IAbV0O5QLZCPxKNaDM5iNhXNZQaEibvOP6MZFYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fX3NROOXYOPZg9RM0j8a+FOet2Ewn13Alsfz9ymJdmQhih0QV
	RifFa8AEikAXyQtirleRVM4MyumSeOWn7s/iklGNFvGQy0FpBRpbaKsx8z7/Z5QokhW9HckS+1w
	I6en/S/u+gTcjQl2gFnSFotfDVElPxJGPU2ye9awpTUCQkFAIfFeGRJE=
X-Gm-Gg: AZFdTZej2vYizNncMm344Gna8iKMOaWhaYOUorlCvR0BC6HP85wLFeTKJoGim+B0eqK
	H26T7nOk7nccolHs4zHkBF+EA3W56+KBU3dElQ3b8Yms1Z9h1pH/wAsv0K5azueHA8d5QSlionG
	MRND0wTRkkSHlbTJvGNWTMKYUENyQ5TlWplMgtBxMtFpQatXqSCzWG87Vgd56U/lQvO3jNeV3qf
	RWFdlwxH78GndSsqys477gYXfpbYLG14qqSw1HxR+UfycwwxOOe9JJluTZq3ZtYJcEN+upOVSlq
	vs744NXNPwItrXfc+hOWkeyssUXghUjxXSJQZmtZK/vcyBfyCDlMJ2oVbkQrh05nCVF6GWlw7cn
	/cHhmLE1hGMOejCBsg1TKByK2HB8g6b+A8LvzE3L2a5Vj0zyfAeoaARqQdbIAZvY=
X-Received: by 2002:a05:690c:e09:b0:8b0:bc8e:9d75 with SMTP id 00721157ae682-8b5204b991bmr72173867b3.22.1795618158502;
        Wed, 25 Nov 2026 06:49:18 -0800 (PST)
X-Received: by 2002:a05:690c:e09:b0:8b0:bc8e:9d75 with SMTP id 00721157ae682-8b5204b991bmr72173287b3.22.1795618157864;
        Wed, 25 Nov 2026 06:49:17 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b8e564e39asm5195385f8f.57.2026.11.25.06.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:49:16 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 15:48:48 +0100
Subject: [PATCH net-next v13 3/5] net: xdp: add xdp_buff_shrink_tail()
 helper
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
Message-Id: <20261125-stmmac-rx-mb-v13-3-0f6bac53e8d5@oss.qualcomm.com>
References: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
In-Reply-To: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
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
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX1hHLutAw+XvL
 VHhVtnSt3LVcLzJHNG1M0hxiCcv15Z7QDjDg7h6QZXia0vaFl/8j78ovUsJrUX5JMyHcFBiNHkE
 TJX7K+wWhAkB8ZbAvLSIXdbaNobMrdXbbbsjom6MhlKbl5PFLSQCPutFI0uvLidwrKluFTG0XCo
 y7wVQLUlKr0HcLgntAmiUTcNHhhaKXL2JC2Jsd90/jIhIqUhMYoxXxpHiWiXGI7eImwK8t1K2d3
 0zAzzA2lEFjsTMKChzrxNW/05BX6XktO2DywsU6xoKnZ5w6/Eu3D9YgT+5eT3yQ+XX8jcBA1OqN
 bzYfgIhwMVKCrbN/p1GPkXfs0X9DgrNmays/dhyHEWx9O9B6OGLKP/pnv1zWM8cKC27Er37VlT1
 BjQnh7knfqMIfaz7OpEztuAsrad8fy4TpGHkLYUimiSXrNSM2Ar0Vgtn2zRgonHStgYWxMSIPrU
 O/o1AmXW7XNK9aGASmQ==
X-Proofpoint-ORIG-GUID: p0uzeC7BDzPeixpO0r5w8jKLhT_iemv9
X-Proofpoint-GUID: p0uzeC7BDzPeixpO0r5w8jKLhT_iemv9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfXy7ZHJNIj1zmS
 00kJEDzFQzXJFOBadGdgXKQePTf26wq2IhvdofKFr3x+IzOA5fqzbZPbO+KVcKhhdDOtbY+nuAj
 INaLaTvQIJOsYfwYEdBjv5NOYiQmoks=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06f56f cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=NV2rGKbi5YIghCh-FX4A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250058

Move the XDP tail-shrink logic out of bpf_xdp_adjust_tail() into
net/core/xdp.c so it can be shared with drivers. The frag helpers
(bpf_xdp_shrink_data_zc(), bpf_xdp_shrink_data() and
bpf_xdp_frags_shrink_tail()) move along with it and are renamed to
xdp_buff_shrink_data_zc(), xdp_buff_shrink_data() and
xdp_frags_shrink_tail().

Add xdp_buff_shrink_tail(), which handles the linear case too and is
exported with EXPORT_SYMBOL_GPL() for driver use. Unlike
bpf_xdp_adjust_tail(), it takes the number of bytes to remove as a
positive value; bpf_xdp_adjust_tail() keeps its signed offset ABI and
passes -offset for the shrink case. Negative offsets are rejected.

bpf_xdp_pull_data() keeps using the frag helper under its new name.
Behavior for valid offsets is unchanged.

This lets stmmac use the common helper to strip the Ethernet FCS from
the xdp_buff it accumulates for a multi-descriptor frame.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h |  3 ++
 net/core/filter.c | 80 +++----------------------------------------------
 net/core/xdp.c    | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 76 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..02289028044c 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -388,6 +388,9 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
+int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset);
+bool xdp_buff_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
+			  int shrink, bool tail);
 
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
diff --git a/net/core/filter.c b/net/core/filter.c
index f42ecfb5841f..cdbb54a10b0b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4438,88 +4438,16 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
-static struct xdp_buff *bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
-					       bool tail, bool release)
-{
-	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
-					  xsk_buff_get_head(xdp);
-
-	if (release) {
-		xsk_buff_del_frag(zc_frag);
-	} else {
-		if (tail)
-			zc_frag->data_end -= shrink;
-		else
-			zc_frag->data += shrink;
-	}
-
-	return zc_frag;
-}
-
-static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
-				int shrink, bool tail)
-{
-	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
-	bool release = skb_frag_size(frag) == shrink;
-	netmem_ref netmem = skb_frag_netmem(frag);
-	struct xdp_buff *zc_frag = NULL;
-
-	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
-		netmem = 0;
-		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
-	}
-
-	if (release) {
-		__xdp_return(netmem, mem_type, false, zc_frag);
-	} else {
-		if (!tail)
-			skb_frag_off_add(frag, shrink);
-		skb_frag_size_sub(frag, shrink);
-	}
-
-	return release;
-}
-
-static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-	int i, n_frags_free = 0, len_free = 0;
-
-	if (unlikely(offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
-		return -EINVAL;
-
-	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
-		skb_frag_t *frag = &sinfo->frags[i];
-		int shrink = min_t(int, offset, skb_frag_size(frag));
-
-		len_free += shrink;
-		offset -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
-			n_frags_free++;
-	}
-	sinfo->nr_frags -= n_frags_free;
-	sinfo->xdp_frags_size -= len_free;
-
-	if (unlikely(!sinfo->nr_frags)) {
-		xdp_buff_clear_frags_flag(xdp);
-		xdp_buff_clear_frag_pfmemalloc(xdp);
-		xdp->data_end -= offset;
-	}
-
-	return 0;
-}
-
 BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 {
 	void *data_hard_end = xdp_data_hard_end(xdp); /* use xdp->frame_sz */
 	void *data_end = xdp->data_end + offset;
 
-	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
-		if (offset < 0)
-			return bpf_xdp_frags_shrink_tail(xdp, -offset);
+	if (offset < 0)
+		return xdp_buff_shrink_tail(xdp, -offset);
 
+	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
 		return bpf_xdp_frags_increase_tail(xdp, offset);
-	}
 
 	/* Notice that xdp_data_hard_end have reserved some tailroom */
 	if (unlikely(data_end > data_hard_end))
@@ -12840,7 +12768,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 		xdp->data_end += shrink;
 		sinfo->xdp_frags_size -= shrink;
 		delta -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
+		if (xdp_buff_shrink_data(xdp, frag, shrink, false))
 			n_frags_free++;
 	}
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..055931263413 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -673,6 +673,95 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
 
+static struct xdp_buff *xdp_buff_shrink_data_zc(struct xdp_buff *xdp,
+						int shrink, bool tail,
+						bool release)
+{
+	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
+					  xsk_buff_get_head(xdp);
+
+	if (release) {
+		xsk_buff_del_frag(zc_frag);
+	} else {
+		if (tail)
+			zc_frag->data_end -= shrink;
+		else
+			zc_frag->data += shrink;
+	}
+
+	return zc_frag;
+}
+
+bool xdp_buff_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
+			  int shrink, bool tail)
+{
+	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
+	bool release = skb_frag_size(frag) == shrink;
+	netmem_ref netmem = skb_frag_netmem(frag);
+	struct xdp_buff *zc_frag = NULL;
+
+	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
+		netmem = 0;
+		zc_frag = xdp_buff_shrink_data_zc(xdp, shrink, tail, release);
+	}
+
+	if (release) {
+		__xdp_return(netmem, mem_type, false, zc_frag);
+	} else {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
+
+	return release;
+}
+
+static int xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i, n_frags_free = 0, len_free = 0;
+
+	if (unlikely(offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
+		return -EINVAL;
+
+	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		int shrink = min_t(int, offset, skb_frag_size(frag));
+
+		len_free += shrink;
+		offset -= shrink;
+		if (xdp_buff_shrink_data(xdp, frag, shrink, true))
+			n_frags_free++;
+	}
+	sinfo->nr_frags -= n_frags_free;
+	sinfo->xdp_frags_size -= len_free;
+
+	if (unlikely(!sinfo->nr_frags)) {
+		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
+		xdp->data_end -= offset;
+	}
+
+	return 0;
+}
+
+int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset)
+{
+	if (unlikely(offset < 0))
+		return -EINVAL;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
+		return xdp_frags_shrink_tail(xdp, offset);
+
+	if (unlikely(offset > xdp->data_end - xdp->data - ETH_HLEN))
+		return -EINVAL;
+
+	xdp->data_end = xdp->data_end - offset;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xdp_buff_shrink_tail);
+
 /**
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
  * @skb: skb to copy frags to

-- 
2.56.1

