Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619972;
	b=QecxoYfst4Ohli4qK8rLB94MCjZs0r7f6MEjAzOPXtX4ECR9sPZp+i3UrJtAmQfkGJc6
	 0VtCbCf4IDPZTOzV0gpQ+cPkmx9EFPn56ajZSpDju1M0nkfTQq/cwqK+brFjh0PbowRCX
	 zljWto8zWTVlOOwYZqEonTH2lWNGM3bRlGdrk3C7IhVPvlz+MK8cTEcLVyHo+1pSaNnPJ
	 kF/8ppOEQxrsqxUz/r9rrWhEil3cBrl8m0vrnsnpTyQBNgdjbPBpg6RNGvKW21scSroFp
	 F8isQdpHgqQDRP0+9zxLJx4sKtIkTP2yQc0aR55CSFUR5PxyxFstXJtyAwiSlDhG7sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=m3mBrDhbcxfP3/IX04+tIZdgrJqn6b7HrBefYlPYicA=;
	b=0fJqI7ADn4en1LbOR8Ve/nyJrVn580q21TNYCF+xgtSaltl76ImNcF+VzkXqz6jjt6vZ
	 mBJWs4AvMTyBjULiWId8QRplSGUGzf/sRIqzUpP3+K2IlzSx4B4fMMk2jphycvPJhwPe5
	 6hp0h/z1FMpdCcPygOD2rn4YzfRHRlwN3tT3KRIMGZs70CV9+/UlM8mX5g8mZlS+LrhoN
	 RfeskhSbrPrAjI+f7Dpi4oGmbLbWb9SoBYwlQRpL5i9PjH4/mOELwTOh7Njk05a88MQg2
	 MKKAmplC25HGXCjLDxHFbrh4vINAos0YNfClWl4z5L5lSBVBp21f/GowLDhDvVQM2aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NzRFsO30;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cGyTdP6z;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7B606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 11:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F7B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NzRFsO30;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cGyTdP6z
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A299w6h3402412
	for <bpf@vger.kernel.org>; Mon, 2 Nov 2026 11:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m3mBrDhbcxfP3/IX04+tIZ
	dgrJqn6b7HrBefYlPYicA=; b=NzRFsO30Ryp9ALm26cRedN2hD28g2VBAkl866F
	8VzIQpnPZMzEVt7Ijibk1rjcbOIuPySzM/gdjLFyx7NUSKdIEfWXk1wmFYjFynfu
	aPha00nh6SUYaJPCv/WT9627trx5tOb8jPnHj/AeB1seLN026eQ1ywwirBQX9lni
	cfam4I3tS4lIFsdpPXrwPhAH/WGHbxEr4+0kzJ1JRJsvtCpsrqBWo9u5+Q4bvn3C
	4lEyJhCqhy86onOWq1IJ6K3k3AhpKrdTkpOqHz9X4ld0dzhsDSUjrlyhBk6PeHBL
	qLcrrATrWyqoh3Zgf5kPy9xiBpSiAy2aiiTf34Lc2T0oGdBQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe8wwm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:46:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c15deb3794so569939137.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793619970; x=1794224770; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m3mBrDhbcxfP3/IX04+tIZdgrJqn6b7HrBefYlPYicA=;
        b=cGyTdP6zmU73zQZtJ4LkaKykCOA9iOx7jd2yJKhvxN/I/wbjpAfFRt5HQ52MrJJvtd
         IrlOLD9FdqNIeoNEoA4mE8TUD825Nb/qnXjy1x+xI160MdCqx9/Jcb8wtc4fNdbkPHLt
         IG/RCc60YYGuT6DbRF6h9cYPEY72uHEvgsaQY4jAu+9n2YuRk2SEqDkq6X/iZpUvfN6J
         3V+hXkBrN4FgKCiF+TUrIWWD0HegiRCOaoZcs05wc5GBSamyT3hW80Hpk/7gk4aT+tfa
         dAym02EkLsKf/IQZ7voFrfvB3TQyAPItCNACvZd87+ixapUu2SVve+Yw7S3xFM7/wi9G
         8eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619970; x=1794224770;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m3mBrDhbcxfP3/IX04+tIZdgrJqn6b7HrBefYlPYicA=;
        b=NrUVdom2vnklFdesRYwD6VnFi/g1xgeMhDKBquy/wVt7MOlao/ONgFdwTZt4edgmvC
         FNkx2vVRjrLwjpPoCIK0bYHxNswgf6BSe8pC2by4LuKuoXzrEPuMkSYa2givDzk4B2KZ
         muJgOT8LoKfnTJdYV0O7TsRFHzMfiEwOWom/2CKMW6ZmPRXgj7hO7cNmNKte7iVLfG4L
         G6DpUcSed+383l3fY24DDJ12OXzz0LcEselzgfWKF5Pf1ato+g7sPv7BEw3GJXZleFJE
         wujHbcD64eTtIQqIphOy7qEswjv3KN6tvkLjcCC0IW2LCVU4MtYOCr8Fr3heTkvLJVJx
         Aphg==
X-Forwarded-Encrypted: i=1; AKwUvBxGThjJUUYlzdq3QL8mcB3BkctfEzUkB1vczeffN4b+w3f4bRrb7zJ5DWkMw/HzSJETvnM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vvKgfnhpxfWmcaJE2YMBh3h7iNWgugyWWtw5Z98qPXlDLjDWa
	Xgcx7e9hruwCewqwRnFWupGCOWQX46p6X6I5NVyxR8EYnHjtFN98x/KQsOWkBTDqwiwSjI5yH1Y
	6vgJr8uWlzqbQDiXEF/TJfVFOP5O8RQ85PVaJ82GzIsdiUDOAfB+hYfk=
X-Gm-Gg: AYBFou12xXSbp2TktO6adATirzNnpCZojufABb9x/fG+Rbxr72qioRCcEHfBy8ua8GU
	t1/OQsGvka1aYss/0IbdeBXUmiYjcD5Ax88+0k0wIuG4K/Jl9WXyOdrPscYTM1ECEoj5Jb0ZJRp
	TEE9XZYuh56hwugxsB7aba9K6P4NqNIFRZVP68IWqH9xtnSWTfHMU2fmrPa8FQrKFwx0wC3NOWo
	LzKSC1wW78FHwvNqjX8TkbKRN3mDvZqUx4s/8Z1oDJ+l6ceFRlYBVbiHlUMeTpVmDVb4I/af8RS
	P/jpdBaFG2Nhz6V0zS0hdrpVcTpnO3j0705K5KuBxwdgO3P70QR3dza6flmQVXUOePX/0qBUC2G
	qHDEXoLqMtUeWojCGXguVYcYxWZJ3+hvLP2BbcgsDvIcaR2tQhyEKisRmhD1v6po=
X-Received: by 2002:a05:6102:50a1:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d07269b10cmr3718018137.34.1793619969957;
        Mon, 02 Nov 2026 03:46:09 -0800 (PST)
X-Received: by 2002:a05:6102:50a1:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7d07269b10cmr3718012137.34.1793619969394;
        Mon, 02 Nov 2026 03:46:09 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b72715sm19226037f8f.18.2026.11.02.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:46:08 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 12:46:04 +0100
Subject: [PATCH net] net: stmmac: set XDP metadata length on the page_pool
 RX path
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
Message-Id: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBN0FoFdJUImm2oWmqhEEN09a
 fkW/z9QOAsXGLsHMl9S5IwNpu/AHxR3VrI2A2ocjNGoSg2BvAtMlVZyKblE9VDam8WitYzbAi1
 OmTe5//EEkSvM7/sB+NAYDm0AAAA=
X-Change-ID: 20261102-stmmac_meatada_pp_path-0c1b9299e2fb
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
        Song Yoong Siang <yoong.siang.song@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae87803 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hfst0zn1j2-VxDRcdEQA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX4FUEymxEmPEu
 kwu6t1TFa0TOVpVlDeSmzf2R4JJacInBGcYE8DeBOM9b5jhdgGK9pmSLvfBoMkx1LxCS9Z0xqYl
 uCgprnM8OPNHRXBuT/GOr1FWPfP29i4ALb8WTqnybE9TVkVg1piAMJD6oYSsLu5opWQZkb3HJIa
 MXHer7jCsvz5m1e3CWk6qLUBzeCpEYWKksuv80TXbqoSoBFKN2KvrONn0HXmqzCsZZ43KHzXxkX
 WpChGZOfe9h6dsj9fuTusOP5AyRIPh+NdnCK6FbjVZt1oKfiGS5IJ31wD36SAIWkvY0VK+b7z9t
 rzNAPUjlRLmcOY9hnJInLaG9+SS55h13mvlGcInJYE7W5hb5gTi9ZyC6o+CUfhh6ZYtnouAZVve
 8uJqGeFTLlIN92p3vpzD77L9kmMnpPGcazwekX0OJaER+PmJbPWshRdaldV1753Fdv8Nvxj86ox
 Tj9Ypudhg/jhc3CkdYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX6uqpf/xC/h/J
 1iUI6xBkuQpBMB+ak3C6kmVYmk5zQ9CdPfj1K/HEzu2DWyGERYtD8e3JOc0MjlyHrKg0RGLCaw2
 wFmWKIlfKTI0K99DP25dib/+DHtmjiU=
X-Proofpoint-ORIG-GUID: R8ZgF-XcxxzWl5B9O0mGNireqf6oJnXR
X-Proofpoint-GUID: R8ZgF-XcxxzWl5B9O0mGNireqf6oJnXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046

stmmac_rx() initializes the XDP buffer with the metadata area valid, so
an XDP program can reserve metadata with bpf_xdp_adjust_meta() and write
it in [xdp->data_meta, xdp->data), for example to export the RX hardware
timestamp obtained from the metadata kfunc. When such a frame is passed
to the stack, the skb is built in place around the same page with
napi_build_skb(), but skb_metadata_set() is never called.

napi_build_skb() clears skb_shared_info up to dataref, which includes
meta_len, so skb_metadata_len() stays zero. The stack and TC BPF then see
an empty metadata range even though the bytes are present in the skb
headroom. The AF_XDP zero-copy path already records the length in
stmmac_construct_skb_zc().

Record the metadata length after reserving the headroom and adding the
frame data. No copy is needed because the skb is built over the buffer the
XDP program wrote to. With the length recorded, the software VLAN
stripping path can move the metadata together with the MAC header, as it
already does for zero-copy frames.

Fixes: e3f9c3e34840 ("net: stmmac: add Rx HWTS metadata to XDP receive pkt")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b038472b9817..f97f6dc08789 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6012,7 +6012,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		}
 
 		if (!skb) {
-			unsigned int head_pad_len;
+			unsigned int metasize;
 
 			/* XDP program may expand or reduce tail */
 			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
@@ -6029,10 +6029,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			}
 
 			/* XDP program may adjust header */
-			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
-			skb_reserve(skb, head_pad_len);
+			skb_reserve(skb,
+				    ctx.xdp.data - ctx.xdp.data_hard_start);
 			skb_put(skb, buf1_len);
 			skb_mark_for_recycle(skb);
+
+			metasize = ctx.xdp.data - ctx.xdp.data_meta;
+			if (metasize)
+				skb_metadata_set(skb, metasize);
 			buf->page = NULL;
 		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,

---
base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
change-id: 20261102-stmmac_meatada_pp_path-0c1b9299e2fb

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

