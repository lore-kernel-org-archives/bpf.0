Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70824ED186
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983406; cv=none; b=Nv6KaEAYGQrg3dvNhNXyvTs961Sytovw/y3scOtIX6IVLLJPeZaqDmkLuJMLvnJr05rzGuXUQY+sOUdeAKxEEWuIw7VPitUpHxt9DfnEQPPRJ6mR3GUfDplhWObQgtHY8zq4JC5Og1/+7OMBNDj2hgi8IIC41YRlyou5Q9PKldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983406; c=relaxed/simple;
	bh=UWIBsJA0AMwqmfihWwqpoAZw35fN/wlKzbscpWo0euU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuUNBQEMa7x08c3i3hrDs7yr2k32u9lE5pjgfK3T6K8tQCNCpigsrneXtwxdbSksAS+9BtX9yOpZAqleErZIMX4ieBVE6UPS/wbiYL75SVzXIqtIptzpAWbXUU2nl7pv96aFosdR+ZN3n4rO1FkQuWnNvluun0flzIiCcpsW6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nb7uy6oj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LSU7IX+a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nb7uy6oj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LSU7IX+a"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E7UBsX2874286
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dr4UNi2862uzLCvE35YrGjzU5tZKVhKomCpQrcCSy+M=; b=Nb7uy6ojVv30njE4
	PBVTi3sjtNu2Nsg7/VXoCIvVfIFPPPn9uQuTSl+JRD8O4Czo3j+Vvoqe0mZTg1+q
	oM0fa7Mir64wMugEIycAQ0omZLLbzQoesEtWm+VNm73N72qw0O/MQ9bNxLdR9ml8
	xX/V2QAB057zJT7/ByMarFlVFSzO/IWJ0+MsZ9kHWe67+FSWQj3X5SFTZg7uvmug
	l5czSIsuJRf6cNkttUN5fTF8TvmjuaHIPBiaB0Sr89ey377dsIxzkAX135V941PA
	PNz1Vjl11fjHp58bYvtwWjBXoh5sowl45E4JAn9++zJdTN8NagQxziW9nNO3imm0
	r/sllA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphjp3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:10:03 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5e949cfaa3bso901327e0c.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983403; x=1792588203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dr4UNi2862uzLCvE35YrGjzU5tZKVhKomCpQrcCSy+M=;
        b=LSU7IX+aHd0va6uv5RHTwNDF9AAJI5q0AJ01B0n3tlTcuGhHuNF6bR/IfKDSuHn6V7
         /wdFyZhsRmtcYGyZAOMMfVVBD/EkE6DpcNWFeoBT6tNicLGAComewBefRL/cb0Vn0RKR
         SpQACYATr13fwkqXVK/DAG6QYqLbeNRDrJEg9m7C8OSTTND49ZSYujO+t0c/Ww9MbKwL
         neihs1SgdAHfPgZjXSMDRGAo+aelNoKi7i8JKCTQO/bjbu4/dZ+I7HlXCHeVqjm/4bA9
         abBrJI1ijWvOaD8/bce6B/e4FxPb9kTPdD5afkU4BujQD6JuGBzEKFa5iJqynKVpMQXq
         /Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983403; x=1792588203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dr4UNi2862uzLCvE35YrGjzU5tZKVhKomCpQrcCSy+M=;
        b=ujvaxXhHZ29PhY+40cRsanRdQ3VAg4o4WUu+IrjupNgItydfO+J2JdxO8ahgbuvQaa
         mylXddNaGnNjzaDCDLoqJbwS/HQB899o+w09Ewr9aB+riT74H+FInxgtrZ8xTapd419b
         KjvUhw7m8VwGkQdkkcJv2lJ3JEjpuPWTMKilebvYXBV5MwIKLLS+a2Jtl0S57BX7ofqv
         jAjc9Ywgv7i5salhjsmmANCcNf9nxbYYdSOeJlhKyohHRYGg2nC0ywlYU+SAUuCPY6w1
         IEf7wf/XVI5ulgUtGKNIbRP6J6x/hdSwH7bvSKKoeoKpAs+UldP7rY5jGaKPXfBCdd67
         K6+A==
X-Forwarded-Encrypted: i=1; AKwUvBykhpZwYTMX8ldt0HG+v6Rin6s9wXOAFHJn+fH3tk0wFrJXzutkGPJd6a9n5aFYEJfk/To=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPgPF80tHYh24La+4JsNRDJdDQ+N6Qur5LoYf17b69pT4IqnYM
	Cic1yw4+IhtWfFyiZKIkiyo7zulGxgD/qW/FN2AEYhmvzpCGWmWwksCDRCKIDOZEYH7jnyboY3j
	BXXOSLrDXUPdTGJjRIi19ofQg0ZUhgD2WCOjjz7sUIfBSYgIR6OvdFwQ=
X-Gm-Gg: AYBFou35q/+c7jQWnsWO4/1CG/Pvc2xPXNjkji+wWDQucVzPYL9c5OUsvvzVhdwerL7
	9TQuA5DMclszSYFAucZmcEcxR1ZcBETD+LuwitBHZg/K8Roy47XAi6MmZ/lsAvZrZqePnvDiCUj
	Rgu8+vGDFipHqvjQbJl1oe0bAP2ROwfYzu5UOEdRyzHuUBOh6AvU1Ni3BE3VF8sCFEhs2h8VilC
	2Co0DnjTIdSCI7H14/UsYzhtlrWGYhTXprDVoGYcJo7lvOCOJsE2T9nP1D+xnBxTJoSI+RCO/8I
	ZIueoNz2DNgiKCVrR0GgUqYk1Of8/pmzxzubWxcIiMW3AjAzHfwNrojCeAqO14XAQbMk8m+1YNd
	QPQXJ8m91RwSw8A==
X-Received: by 2002:a05:6122:ca5:b0:5c9:a60b:e5d6 with SMTP id 71dfb90a1353d-5e91f4dcb02mr5398988e0c.16.1791983401869;
        Wed, 14 Oct 2026 06:10:01 -0700 (PDT)
X-Received: by 2002:a05:6122:ca5:b0:5c9:a60b:e5d6 with SMTP id 71dfb90a1353d-5e91f4dcb02mr5398934e0c.16.1791983401200;
        Wed, 14 Oct 2026 06:10:01 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b482b3e4sm47307595e9.4.2026.10.14.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:10:00 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:09:38 +0200
Subject: [PATCH net-next v7 4/4] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-stmmac-rx-mb-v7-4-5d2d70f052cd@oss.qualcomm.com>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
In-Reply-To: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
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
X-Proofpoint-GUID: RnJmJnjjvm-hoY31709Qw-xBRuEl6Uef
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX1Km7BZlMPwye
 +dYGXX63QuVmvuaeL3uy+yVnrn+lZ2VvxlrvbqIx3c8Ma6kzXa+neydH1pCzwQhZvm+/A7EvDDF
 p8S0mYgqW2y8U9smg4VHjAjenzBaG4g=
X-Proofpoint-ORIG-GUID: RnJmJnjjvm-hoY31709Qw-xBRuEl6Uef
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf7f2b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=flYnR0XiPPvn2sS5u-IA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX6mh4t3XD30V2
 +ugB50Yi5ke1t2SQQ3d6zd9htEZLS5UmONTdxc7EiYmqHyqXJA68Uwly0jtydrXjCXMVehu6fMT
 VGQnhqKWMr5OjvArj1PidTiawEVdGH5y5OdildXzk895jYkLSizh5xxJT2mnLm1QYqN9Kyo/jYR
 cPr1+RgoO4NqTTrrtm+r2fg0JLV+ZL0H7YFKkxzH4OMSWqAYEwIfuhBhg/cqA9Y+ypKBOeX2hbb
 +F2Y9E0RnKsNQJY5wqsX3vhQspNvMFTuDrWnzrGDDPfVtKyGxKvsQhCqRvX34N04YAiRT8ireAu
 8rzZ7L4tdZQnka7dQCFwRhvsF25oxRBNWmY/xcg8qx8r6qbGwBUwe0Tv/bnnU+bcFii2QHo8Wov
 EUxrEKm9u9pkAgePyy4Lo3tgHpbp8IxdEHdR9xBed5Lo9wD3mQdZwHgSk2/5r1k4ukcwj4CZeLc
 OFd7dwg1qC51H+Ge74w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

The preceding commit dropped frames split across multiple descriptors, or
using a second buffer, while XDP was enabled. This prevented the
per-descriptor XDP path from re-parsing frame tails and from applying FCS
handling to truncated buffers.

Rework stmmac_rx() to accumulate all the descriptors that make up a frame
in an xdp_buff, so the XDP program runs on the full (possibly fragmented)
packet instead of just the first buffer. Frames split across descriptors
or buffers are now passed to programs loaded with BPF_F_XDP_HAS_FRAGS;
programs without that capability continue to drop fragmented frames. When
the frame is not consumed by the program, assemble the skb from the head
buffer and the collected fragments via napi_build_skb()/
xdp_update_skb_frags_info().

Note that XDP still rejects an MTU larger than ETH_DATA_LEN
(stmmac_xdp_set_prog(), stmmac_change_mtu()) and disables SPH, so an
ordinary frame fits in a single buffer. This path is therefore exercised
by frames that do span several descriptors (for example jumbo frames the
MAC admits through its jumbo-enable bit) and is groundwork for extending
XDP to jumbo/SPH; it does not enable XDP jumbo support by itself.

To do so, store the in-progress xdp_buff in rx_q->state instead of the
partially built skb, so the accumulated head and fragments survive a NAPI
poll boundary (mid-frame dma_own or dirty_rx break). The state is saved
only while a frame is in progress and cleared once it completes, leaving
it untouched when the poll does not process anything (e.g. netpoll invoked
with a zero budget).

In addition:
- advertise NETDEV_XDP_ACT_RX_SG, since the RX path can now deliver
  non-linear buffers to XDP;
- build the skb head with napi_build_skb() passing xdp->frame_sz, so
  skb_shinfo() lands on the same shared_info the fragments were accumulated
  into;
- carry the XDP metadata written with bpf_xdp_adjust_meta() into the skb
  via skb_metadata_set(), so it is no longer dropped and TC/BPF programs
  can read it through data_meta;
- attach fragments with xdp_buff_add_frag(), which initializes all the
  shared_info fields and takes care of the pfmemalloc bit;
- release the buffers collected in the xdp_buff when a frame is dropped
  on RX errors; the previous code relied on dev_kfree_skb() recycling the
  skb frags, which no longer applies now that the head and fragments live
  in an xdp_buff rather than a partially built skb;
- drop the whole frame when it would exceed MAX_SKB_FRAGS, where the
  previous skb_add_rx_frag() calls were unbounded;
- strip the Ethernet FCS from the accumulated xdp_buff with a driver-local
  tail shrink (stmmac_xdp_shrink_tail()) for both linear and fragmented
  frames, instead of trimming the skb or the first descriptor length.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 335 ++++++++++++++--------
 2 files changed, 211 insertions(+), 127 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 08b68441f9c8..4ac596a2d904 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -132,7 +132,8 @@ struct stmmac_rx_queue {
 	dma_addr_t dma_rx_phy;
 	unsigned int state_saved;
 	struct {
-		struct sk_buff *skb;
+		struct xdp_buff xdp;
+		unsigned int frames;
 		unsigned int len;
 		unsigned int error;
 	} state;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f4beb0ff6fd2..662ec8732157 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -158,6 +158,9 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue);
 static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 					  u32 rxmode, u32 chan);
 static void stmmac_vlan_restore(struct stmmac_priv *priv);
+static void stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q,
+				struct xdp_buff *xdp, int sync_len,
+				bool allow_direct);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
@@ -2180,8 +2183,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
-	dev_kfree_skb_any(rx_q->state.skb);
-	rx_q->state.skb = NULL;
+	if (rx_q->state.frames && !rx_q->xsk_pool) {
+		stmmac_xdp_put_buff(rx_q, &rx_q->state.xdp, -1, false);
+		rx_q->state.frames = 0;
+	}
 	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
@@ -5454,8 +5459,8 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 					   struct xdp_buff *xdp)
 {
+	int res = STMMAC_XDP_CONSUMED;
 	struct bpf_prog *prog;
-	int res;
 
 	prog = READ_ONCE(priv->xdp_prog);
 	if (!prog) {
@@ -5463,7 +5468,8 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 		goto out;
 	}
 
-	res = __stmmac_xdp_run_prog(priv, prog, xdp);
+	if (likely(!xdp_buff_has_frags(xdp) || prog->aux->xdp_has_frags))
+		res = __stmmac_xdp_run_prog(priv, prog, xdp);
 out:
 	return ERR_PTR(-res);
 }
@@ -5795,6 +5801,118 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	return failure ? limit : (int)count;
 }
 
+static void
+stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
+		    int sync_len, bool allow_direct)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i;
+
+	if (likely(!xdp_buff_has_frags(xdp)))
+		goto out;
+
+	for (i = 0; i < sinfo->nr_frags; i++)
+		page_pool_put_full_page(rx_q->page_pool,
+					skb_frag_page(&sinfo->frags[i]),
+					allow_direct);
+out:
+	page_pool_put_page(rx_q->page_pool, virt_to_head_page(xdp->data),
+			   sync_len, allow_direct);
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
+static int stmmac_xdp_shrink_tail(struct stmmac_rx_queue *rx_q,
+				  struct xdp_buff *xdp, int offset)
+{
+	struct skb_shared_info *sinfo;
+	int i;
+
+	if (unlikely(offset < 0 ||
+		     offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
+		return -EINVAL;
+
+	if (likely(!xdp_buff_has_frags(xdp))) {
+		xdp->data_end -= offset;
+		return 0;
+	}
+
+	sinfo = xdp_get_shared_info_from_buff(xdp);
+	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		int delta = min_t(int, offset, skb_frag_size(frag));
+
+		if (delta == skb_frag_size(frag)) {
+			/* The whole frag is consumed by the strip: return it
+			 * to the page pool right away. Its ring slot still
+			 * carries the page DMA address until stmmac_rx_refill()
+			 * re-arms it at the end of the NAPI poll. This is
+			 * safe because HW cannot touch the slot until then.
+			 */
+			page_pool_put_full_page(rx_q->page_pool,
+						skb_frag_page(frag), true);
+			sinfo->nr_frags--;
+		} else {
+			skb_frag_size_sub(frag, delta);
+		}
+
+		sinfo->xdp_frags_size -= delta;
+		offset -= delta;
+	}
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
 /**
  * stmmac_rx - manage the receive process
  * @priv: driver private structure
@@ -5808,21 +5926,20 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	u32 rx_errors = 0, rx_dropped = 0, rx_bytes = 0, rx_packets = 0;
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	unsigned int frames = 0, next_entry = rx_q->cur_rx;
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
-	unsigned int next_entry = rx_q->cur_rx;
 	bool in_progress = rx_q->state_saved;
 	enum dma_data_direction dma_dir;
 	int coe = priv->hw->rx_csum;
-	unsigned int desc_size;
-	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
-	bool fcs_stripped = false;
+	unsigned int desc_size;
 	int xdp_status = 0;
 	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
-	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	bufsz = rx_q->napi_skb_frag_size;
+	ctx.priv = priv;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5835,23 +5952,25 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	}
 
 	if (rx_q->state_saved) {
-		skb = rx_q->state.skb;
+		ctx.xdp = rx_q->state.xdp;
 		error = rx_q->state.error;
+		frames = rx_q->state.frames;
 		len = rx_q->state.len;
-		rx_q->state.skb = NULL;
 		rx_q->state_saved = false;
+		rx_q->state.frames = 0;
 	}
 
 	while (count < limit) {
 		unsigned int buf1_len = 0, buf2_len = 0;
+		unsigned int pre_len, sync_len;
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
+		struct sk_buff *skb;
 		int entry, status;
 		u32 hash;
 
 		if (!in_progress) {
-			skb = NULL;
 			error = 0;
 			len = 0;
 		}
@@ -5894,19 +6013,11 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 				rx_errors++;
 		}
 
-		/* We do not support SG in XDP mode */
-		if (unlikely(!error && (status & rx_not_ls) &&
-			     stmmac_xdp_is_enabled(priv))) {
-			rx_dropped++;
-			error = 1;
-		}
-
 		if (unlikely(error)) {
 			if (status & rx_not_ls)
 				goto read_again;
 
-			dev_kfree_skb(skb);
-			goto next;
+			goto error_free_frag;
 		}
 
 		/* Buffer is good. Go on. */
@@ -5916,129 +6027,89 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
 		len += buf2_len;
 
-		/* Drop the packet if it is split over buf1 and buf2 on a
-		 * single descriptor if the interface is running in XDP mode.
-		 */
-		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
-			rx_dropped++;
-			goto next;
-		}
-
-		/* ACS is disabled; strip manually. */
-		if (likely(!(status & rx_not_ls)))
-			len -= ETH_FCS_LEN;
-
-		if (!skb) {
-			unsigned int pre_len, sync_len;
-
-			/* Each frame starts here: reset the FCS handling */
-			fcs_stripped = false;
-
+		if (!frames) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 			net_prefetch(page_address(buf->page) +
 				     buf->page_offset);
 
-			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
-				buf1_len -= ETH_FCS_LEN;
-				fcs_stripped = true;
-			}
-
 			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
-
-			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				  buf->page_offset;
-
-			ctx.priv = priv;
-			ctx.desc = p;
-			ctx.ndesc = np;
-
-			skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
-			/* Due xdp_adjust_tail: DMA sync for_device
-			 * cover max len CPU touch
-			 */
-			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				   buf->page_offset;
-			sync_len = max(sync_len, pre_len);
-
-			/* For Not XDP_PASS verdict */
-			if (IS_ERR(skb)) {
-				unsigned int xdp_res = -PTR_ERR(skb);
-
-				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_put_page(rx_q->page_pool,
-							   virt_to_head_page(ctx.xdp.data),
-							   sync_len, true);
-					buf->page = NULL;
-					rx_dropped++;
-					goto next;
-				} else if (xdp_res & (STMMAC_XDP_TX |
-						      STMMAC_XDP_REDIRECT)) {
-					xdp_status |= xdp_res;
-					buf->page = NULL;
-					goto next;
-				}
-			}
-		}
-
-		if (!skb) {
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
-				buf->page = NULL;
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
 			buf->page = NULL;
 		} else if (buf1_len) {
-			dma_sync_single_for_cpu(priv->device, buf->addr,
-						buf1_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->page, buf->page_offset, buf1_len,
-					priv->dma_conf.dma_buf_sz);
+			if (!stmmac_build_xdp_frags(priv, rx_q, buf1_len,
+						    buf->page,
+						    buf->page_offset,
+						    dma_dir, &ctx.xdp)) {
+				if (!error)
+					rx_dropped++;
+				error = 1;
+			}
 			buf->page = NULL;
 		}
 
 		if (buf2_len) {
-			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
-						buf2_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->sec_page, 0, buf2_len,
-					priv->dma_conf.dma_buf_sz);
+			if (!stmmac_build_xdp_frags(priv, rx_q, buf2_len,
+						    buf->sec_page, 0,
+						    dma_dir, &ctx.xdp)) {
+				if (!error)
+					rx_dropped++;
+				error = 1;
+			}
 			buf->sec_page = NULL;
 		}
+		frames++;
 
-drain_data:
 		if (likely(status & rx_not_ls))
 			goto read_again;
-		if (!skb)
-			continue;
 
-		/* Got entire packet into SKB. Finish it. */
+		/* ACS is disabled; strip manually. */
+		len -= ETH_FCS_LEN;
+		if (stmmac_xdp_shrink_tail(rx_q, &ctx.xdp, ETH_FCS_LEN)) {
+			if (!error)
+				rx_dropped++;
+			error = 1;
+		}
+
+		if (unlikely(error))
+			goto error_free_frag;
+
+		pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
+
+		ctx.desc = p;
+		ctx.ndesc = np;
+
+		skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
+		/* Due xdp_adjust_tail: DMA sync for_device
+		 * cover max len CPU touch
+		 */
+		sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
+		sync_len = max(sync_len, pre_len);
+
+		/* For Not XDP_PASS verdict */
+		if (IS_ERR(skb)) {
+			unsigned int xdp_res = -PTR_ERR(skb);
+
+			if (xdp_res & STMMAC_XDP_CONSUMED) {
+				stmmac_xdp_put_buff(rx_q, &ctx.xdp, sync_len,
+						    true);
+				rx_dropped++;
+			} else if (xdp_res & (STMMAC_XDP_TX |
+					      STMMAC_XDP_REDIRECT)) {
+				xdp_status |= xdp_res;
+			}
 
-		/* Remove FCS if needed */
-		if (!fcs_stripped && pskb_trim(skb, len)) {
-			dev_kfree_skb_any(skb);
-			rx_dropped++;
 			goto next;
 		}
 
+		skb = stmmac_build_skb(&ctx.xdp);
+		if (!skb) {
+			rx_dropped++;
+			goto error_free_frag;
+		}
+
+		/* Got entire packet into SKB. Finish it. */
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
 
 		if (priv->hw->hw_vlan_en)
@@ -6065,15 +6136,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		rx_bytes += len;
 next:
 		in_progress = false;
-		skb = NULL;
+		frames = 0;
+		count++;
+		continue;
+error_free_frag:
+		if (frames)
+			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1, true);
+		in_progress = false;
+		frames = 0;
 		count++;
 	}
 
-	if (in_progress || skb) {
-		rx_q->state_saved = true;
-		rx_q->state.skb = skb;
+	if (in_progress || frames) {
+		rx_q->state.xdp = ctx.xdp;
+		rx_q->state.frames = frames;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
+		rx_q->state_saved = true;
 	}
 
 	stmmac_finalize_xdp_rx(priv, xdp_status);
@@ -8093,6 +8172,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* Default qdisc num_tx_queues */
@@ -8416,9 +8496,12 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
-	dev_kfree_skb_any(rx_q->state.skb);
-	rx_q->state.skb = NULL;
+	if (rx_q->state.frames && !rx_q->xsk_pool) {
+		stmmac_xdp_put_buff(rx_q, &rx_q->state.xdp, -1, false);
+		rx_q->state.frames = 0;
+	}
 	rx_q->state_saved = false;
+
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
 }

-- 
2.56.0

