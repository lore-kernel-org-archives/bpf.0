Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537145A297
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981125; cv=none; b=ZFEMjn16vCmz3idh0x2vSctnWPx6dJd1kOfZU4piKgA9pkuurOYWa54pd5W/oj/v/RF/Pyd6JcvAx9ISBOEBAz6jdpptuRniWoOaWLPrNg3tlAGrPU8plG5f3VXOQi3p5lGd1eIFVGBjy+ghwI0krfrJKBV1J1///3UFaudlNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981125; c=relaxed/simple;
	bh=EmgX1uuejLp13JfkLHg8qVj5L/1hJU1g01DKmSdoKSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ALxcdqYE7MXpbSDbbGcidlb+gTM5PJL/+JbmPoZXt+PxWLW71UHCRLp384PmfnkH5S7Ra0MEOAh13m/KSVlusTk70v4DgsHCrXIxXItehTfpoq/TvQ9Ex9RioMLsXpjd3+G+Z1hI5uN/38ZYc4NqC1w5OAFsBfJmNUm5B46lPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC3JviOg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kndm0r95; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC3JviOg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kndm0r95"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L8aSP14146635
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jl71JFVeIBL/MZQdt3BzOf
	azAM3dFwYN4cwsPwRgqwI=; b=WC3JviOgm0t/YkloMCLjbL/OjH1KiL/lK2ZAo+
	0TF10UZABlaG1ds2eKPduppVq1lAeOMNgCdXaL7JdX5smp5Y6ImlQNvH7RgSNQOQ
	/kfRyI4Q8Vq67zP8NrDGI7PmD1i3toYCS/xIuGQv221CnT5dsoTFqiaTeLKUfbc0
	7+JRjmWMC+p4mUuDrjdj9yB/pV/BmQs5h5ShBWDO5lGXcryMM5hgfq0vnXwVF4m1
	BkrQfaelhi+jc+B4wTfiAbNeH7KZEJjlt/60vuFiIES9WyWeqQT8u9cWCGtqGZZg
	/ZuF4OFP2zJNp5QTAlRp3/Pkkuae2f4azziqwi4M0hVB868w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gr2ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:58:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so415451785a.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789981122; x=1790585922; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jl71JFVeIBL/MZQdt3BzOfazAM3dFwYN4cwsPwRgqwI=;
        b=kndm0r954y8A6Pn8GIJ4GCva+lNG3w4fC70Q2XnTc0OiNC3V669Hn16yCcS91EoXto
         T/FrVx1oGxHLTUrTzSfKG1TfwiS0AhVcetl/WNVl243mHHwso3beltOunzFeUzoMt9QR
         Ni4JCtEr5lgMptktCG4cfLk5saq1DVmUuUNqb0mmeEspnLLgIb/ZxIOUOy7nDkRgZg3v
         D1Wl20T9pTA19EsAdiElNw9oVVN4MQSI8ewKxZkxBczzx0sT6AKs+CulTy1YC8ybGaHx
         8fVcLSuw5Kkocc5/O+KhBADrja2OuGFaJ0zJ5hIdDGuSM6R8zuFSY5YnrcDqkdl584kx
         i6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981122; x=1790585922;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jl71JFVeIBL/MZQdt3BzOfazAM3dFwYN4cwsPwRgqwI=;
        b=f8w4SaOtmUXdwdRNsX7SI+4Vgab1Msj2j2UxHAEjwKC7UL0jnPLzbBIpGpbDpvEZpD
         cYkYfz4RXyd3NkVF8EFN2aI6nAwSlQw+JWhnOigC+mVDC3p1AJuwj4YWnjJDWJATpHMD
         W9sgW0zo4Q58SVvSazF5BtJOrAB/9I7H4QE7nfQSuiAaGjFs+qONX0xvgZcX6XD3pkd2
         DEFEtB+eVrVuysnNh/T41bWPZMWaVbgbWvFZVgJmVONf4DJ8SPRr63vhLTxxK7hytMXj
         qtgrpGs82+oAWJHbQXY+yEjjk82+mpUhATu9aLL4EH8TEsDLFeRn94hkI7WsZpkMYzrs
         OXrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWfowo+sPf068bPsSWvINlgKhlDmiE35wCa0elhPiAMC4drpIq16L3XCr+fF4AN9yBTsA=@vger.kernel.org
X-Gm-Message-State: AFuF++ns5czZqbFUo2kkSBfgoPYZBFwxygxgjDl++te7Csa8Gg65Cdpg
	KF+wjL8I0x/6cYgGEXtUqHd3aY4mkDB+MebcXq+u50LV0rBcZUTDwUipLBAKM6Nf2xayXOxyFS+
	//a5L03O7iyv3b2SOYgZC5PXIpafbnaumA7yP2tcR+4KxT8gYqJI2oNc=
X-Gm-Gg: AYBFou2dwMTDcwh25EbcEz163CMNiBnvjC+NSxNWXeImurGaKAKLARmJFu6HaRruPUK
	CHisfP96axWZ4a58qEnbfeSbsAHTnKE4k1tFsyFE0sen+gMCZG9TC+EYbDw+CKYgxTKDv6OQjBs
	FlXToOQ/JFqB3YOWZBB3AQOsaujlNES6RFhAoKo3grRlheWHt0HSfSUI9HSBFMdAiS8Eohn1E2X
	WgZXnKEJxL8nrTA0+6smqZcsiWpkuyAmfqzXzygcNuVVueZizT5JHhvYuG0FdylxFKfEhKdnThG
	cbNWAdkuntogqYAiNwH3vMBpbSsT/sD0TaklR22sdac6dPW14N2obwsLn/mpiF/5ehbkuVtd9f7
	Zv7MBCRo+zDcNow==
X-Received: by 2002:a05:620a:298c:b0:93b:d7a1:ba0b with SMTP id af79cd13be357-93bf5742f73mr970963285a.54.1789981121887;
        Mon, 21 Sep 2026 01:58:41 -0700 (PDT)
X-Received: by 2002:a05:620a:298c:b0:93b:d7a1:ba0b with SMTP id af79cd13be357-93bf5742f73mr970961685a.54.1789981121379;
        Mon, 21 Sep 2026 01:58:41 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244608e7sm22478423f8f.6.2026.09.21.01.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:58:40 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:58:26 +0200
Subject: [PATCH net-next v2] net: stmmac: rework stmmac_rx to support XDP
 rx multi-buff
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-stmmac-rx-mb-v2-1-6e826e1ff306@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQqDMBBEf0X23JVsSLX21P8oHqKuNdAkbZKKR
 fLvDZ57GXgM82aHyMFwhGu1Q+DVRONdAXmqYFy0ezCaqTBIIRvR0QVjslaPGDa0A1Kjmk7LlhR
 rKJNX4Nlsh+4OjhM63hL0pVlMTD58j5+Vjv6/ciUkFIM6UzspofR88zHW749+jt7augT0Oecfp
 O31FbkAAAA=
X-Change-ID: 20260918-stmmac-rx-mb-16469a2714ea
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: FpscMz5G9KnEHUsUgTG21-LNJhHlnkZy
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab0f1c3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rAskiDj5dFfVSkN7usYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyOCBTYWx0ZWRfX5mMj+LxrHaKk
 T5LStzxmD30PRJRpAdADNY15c6Av2n5NetHVEXStkCrtiwOcNEP8qhqCudjjLkv2xirpHlRtV97
 3hOKWhsYsZDXOG7djjdOJPS3OLDEPF7XeddfByM6S01hKPjjLzstiHz7MCELfcfKHnj83QQDP/t
 R6aUABnndW9pg/P3AiDfo6N4c6DHss3X+whGDkkAcLhe3/EDzV7UhWCWoi234EXE14JsAO8kQPF
 pcFpRlwpkHC05FuRz9xBU+vdNz16fHj6ADkqTnuDAR9W9U0cjpD+hmtycV/1frpmpZeMYFhjnwJ
 FQdcWLwZlVMXc894zofpdD9JVWETYLtQENNqmx6ToLVHS7gWVbJzSEgC5xBAg2Al6kp5uINYTGg
 ahk9LY4vYGwmuJCBxNCYFzT/OlUNmFnqOtd5Yi9snNZr+a3UVXzjuP7RAhxpdbZ/ESydDt/FsUf
 xAyKKyhTSWMmMbBtgdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyOCBTYWx0ZWRfX7YHcFsnm/Fwu
 6FH05yXMvcs1vcA0JquXwgImKwew08dBXjCQ2nykwIbKNwNLMFQYct8rPDaEfDGGea5d5tZ+qKw
 oOjfObtlqm1ZdvQAB5WNJvFs4rxhZSA=
X-Proofpoint-ORIG-GUID: FpscMz5G9KnEHUsUgTG21-LNJhHlnkZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210128

Build the xdp_buff by accumulating all the descriptors that make up a
frame, so the XDP program runs on the full (possibly fragmented) packet
instead of just the first buffer. When the frame is not consumed by the
program, assemble the skb from the head buffer and the collected
fragments via napi_build_skb()/xdp_update_skb_frags_info().

To do so, store the in-progress xdp_buff in rx_q->state instead of the
partially built skb, so the accumulated head and fragments survive a
NAPI poll boundary (mid-frame dma_own or dirty_rx break). The state is
saved only while a frame is in progress and cleared once it completes,
leaving it untouched when the poll does not process anything (e.g.
netpoll invoked with a zero budget).

In addition:
- build the skb head with napi_build_skb() passing xdp->frame_sz, so
  skb_shinfo() lands on the same shared_info the fragments were
  accumulated into;
- attach fragments with xdp_buff_add_frag(), which initializes all the
  shared_info fields and takes care of the pfmemalloc bit;
- release all buffers belonging to a frame when it is dropped on RX
  errors, instead of leaking the ones already attached to the xdp_buff;
- drop the whole frame when the number of fragments exceeds
  MAX_SKB_FRAGS, instead of delivering a truncated one;
- skip zero-length fragments, which can happen for non-first
  descriptors when split-header (SPH) is enabled.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Rely on xdp_buff_add_frag() to create xdp fragments
- Fix bugs in rx_q state recording
- Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
- Cosmetics
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 202 ++++++++++++++--------
 2 files changed, 131 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4fc96b317d79..69bdbbf4b920 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -132,7 +132,7 @@ struct stmmac_rx_queue {
 	dma_addr_t dma_rx_phy;
 	unsigned int state_saved;
 	struct {
-		struct sk_buff *skb;
+		struct xdp_buff xdp;
 		unsigned int len;
 		unsigned int error;
 	} state;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bf9e7e4cb1c3..7d1149511c55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1695,7 +1695,8 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 		if (!buf->sec_page)
 			return -ENOMEM;
 
-		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page) +
+				buf->page_offset;
 		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
 	} else {
 		buf->sec_page = NULL;
@@ -5140,7 +5141,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 			if (!buf->sec_page)
 				break;
 
-			buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+			buf->sec_addr = page_pool_get_dma_addr(buf->sec_page) +
+					buf->page_offset;
 		}
 
 		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
@@ -5735,6 +5737,70 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	return failure ? limit : (int)count;
 }
 
+static void
+stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
+		    int sync_len)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i;
+
+	if (likely(!xdp_buff_has_frags(xdp)))
+		goto out;
+
+	for (i = 0; i < sinfo->nr_frags; i++)
+		page_pool_put_full_page(rx_q->page_pool,
+					skb_frag_page(&sinfo->frags[i]), true);
+out:
+	page_pool_put_page(rx_q->page_pool, virt_to_head_page(xdp->data),
+			   sync_len, true);
+}
+
+static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	u32 metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+	u8 num_frags = 0;
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		num_frags = sinfo->nr_frags;
+
+	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
+	if (!skb)
+		return NULL;
+
+	skb_mark_for_recycle(skb);
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	skb_put(skb, xdp->data_end - xdp->data);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
+					  num_frags * xdp->frame_sz,
+					  xdp_buff_get_skb_flags(xdp));
+	return skb;
+}
+
+static bool stmmac_build_xdp_frags(struct stmmac_priv *priv,
+				   struct stmmac_rx_queue *rx_q,
+				   unsigned int len, struct page *page,
+				   unsigned int offset,
+				   enum dma_data_direction dma_dir,
+				   struct xdp_buff *xdp)
+{
+	dma_addr_t dma_addr = page_pool_get_dma_addr(page) + offset;
+
+	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
+	if (!xdp_buff_add_frag(xdp, page_to_netmem(page), offset, len,
+			       xdp->frame_sz)) {
+		page_pool_put_full_page(rx_q->page_pool, page, true);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * stmmac_rx - manage the receive process
  * @priv: driver private structure
@@ -5756,11 +5822,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
+	bool first_desc = true;
 	int xdp_status = 0;
 	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
-	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	bufsz = rx_q->napi_skb_frag_size;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5780,9 +5847,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		u32 hash;
 
 		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
+			ctx.xdp = rx_q->state.xdp;
 			error = rx_q->state.error;
 			len = rx_q->state.len;
+			first_desc = false;
 		} else {
 			rx_q->state_saved = false;
 			skb = NULL;
@@ -5820,21 +5888,21 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
+
 		if (unlikely(status == discard_frame)) {
-			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
-			buf->page = NULL;
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
 		if (unlikely(error)) {
-			dev_kfree_skb(skb);
-			skb = NULL;
-			count++;
-			continue;
+			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
+			buf->page = NULL;
+
+			if (status & rx_not_ls)
+				goto read_again;
+
+			goto error_free_frag;
 		}
 
 		/* Buffer is good. Go on. */
@@ -5855,9 +5923,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			}
 		}
 
-		if (!skb) {
-			unsigned int pre_len, sync_len;
-
+		if (first_desc) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 			net_prefetch(page_address(buf->page) +
@@ -5866,6 +5932,33 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
+			first_desc = false;
+			buf->page = NULL;
+		} else if (buf1_len) {
+			error |= !stmmac_build_xdp_frags(priv, rx_q, buf1_len,
+							 buf->page,
+							 buf->page_offset,
+							 dma_dir, &ctx.xdp);
+			buf->page = NULL;
+		}
+
+		if (buf2_len) {
+			error |= !stmmac_build_xdp_frags(priv, rx_q, buf2_len,
+							 buf->sec_page,
+							 buf->page_offset,
+							 dma_dir, &ctx.xdp);
+			buf->sec_page = NULL;
+		}
+
+		if (likely(status & rx_not_ls))
+			goto read_again;
+
+		if (unlikely(error))
+			goto error_free_frag;
+
+		first_desc = true;
+		if (!skb) {
+			unsigned int pre_len, sync_len;
 
 			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
 				  buf->page_offset;
@@ -5887,26 +5980,18 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 				unsigned int xdp_res = -PTR_ERR(skb);
 
 				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_put_page(rx_q->page_pool,
-							   virt_to_head_page(ctx.xdp.data),
-							   sync_len, true);
-					buf->page = NULL;
+					stmmac_xdp_put_buff(rx_q, &ctx.xdp, sync_len);
 					rx_dropped++;
 
 					/* Clear skb as it was set as
 					 * status by XDP program.
 					 */
 					skb = NULL;
-
-					if (unlikely((status & rx_not_ls)))
-						goto read_again;
-
 					count++;
 					continue;
 				} else if (xdp_res & (STMMAC_XDP_TX |
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;
-					buf->page = NULL;
 					skb = NULL;
 					count++;
 					continue;
@@ -5914,51 +5999,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			}
 		}
 
+		skb = stmmac_build_skb(&ctx.xdp);
 		if (!skb) {
-			unsigned int head_pad_len;
-
-			/* XDP program may expand or reduce tail */
-			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
-
-			skb = napi_build_skb(page_address(buf->page),
-					     rx_q->napi_skb_frag_size);
-			if (!skb) {
-				page_pool_recycle_direct(rx_q->page_pool,
-							 buf->page);
-				rx_dropped++;
-				count++;
-				goto drain_data;
-			}
-
-			/* XDP program may adjust header */
-			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
-			skb_reserve(skb, head_pad_len);
-			skb_put(skb, buf1_len);
-			skb_mark_for_recycle(skb);
-			buf->page = NULL;
-		} else if (buf1_len) {
-			dma_sync_single_for_cpu(priv->device, buf->addr,
-						buf1_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->page, buf->page_offset, buf1_len,
-					priv->dma_conf.dma_buf_sz);
-			buf->page = NULL;
-		}
-
-		if (buf2_len) {
-			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
-						buf2_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->sec_page, 0, buf2_len,
-					priv->dma_conf.dma_buf_sz);
-			buf->sec_page = NULL;
-		}
-
-drain_data:
-		if (likely(status & rx_not_ls))
-			goto read_again;
-		if (!skb)
+			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
+			rx_dropped++;
+			count++;
 			continue;
+		}
 
 		/* Got entire packet into SKB. Finish it. */
 
@@ -5989,13 +6036,24 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		rx_packets++;
 		rx_bytes += len;
 		count++;
+		continue;
+error_free_frag:
+		if (!first_desc) {
+			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
+			first_desc = true;
+		}
+		dev_kfree_skb(skb);
+		skb = NULL;
+		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
-		rx_q->state_saved = true;
-		rx_q->state.skb = skb;
-		rx_q->state.error = error;
-		rx_q->state.len = len;
+	if (count || !first_desc) {
+		rx_q->state_saved = !first_desc;
+		if (!first_desc) {
+			rx_q->state.xdp = ctx.xdp;
+			rx_q->state.error = error;
+			rx_q->state.len = len;
+		}
 	}
 
 	stmmac_finalize_xdp_rx(priv, xdp_status);

---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

