Received: from outbound.qs.icloud.com (qs-2004k-snip4-4.eps.apple.com [57.103.84.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E33E7160
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542907; cv=none; b=H2l+6WDywdmmuZ2L0xLM+vzsyofcm2XPIFnmb0aoTkkM9mT/Ygx9NQzOvtas427bceoGBzJr1h/lv7xnaDXxijhD6jx4JH0mTjIF98b8b/xKYny3qEHnTydIoJOsswDYLVs6gwbqwYX3YIJPa3Zr1sS+VvhOFzgMOa6vhUlG4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542907; c=relaxed/simple;
	bh=Ob6KhEnJEHL49NGQIQ7skMx8gNTZdt4HvuzDLrR7h8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8i9SdvrMPnxyytUSEkbu40SeHxWI8KVydGbN6p5lh20Q3tjgyLRQjQ333F5PGPvui/WSRGTPWD45IKiAPQZwpnFl/ekm2zN/TPLwS0KALUyqAVfuEFo50ceTD0kb9nW24cT4E641YvYMmbLkNVUjjeuQ8uiDb+TMw+hUpOR5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=dL4HSmuq; arc=none smtp.client-ip=57.103.84.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="dL4HSmuq"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id E61603001123;
	Wed, 08 Jul 2026 20:34:54 +0000 (UTC)
X-ICL-RepId: 019f4370-d0ce-7cdb-8d2c-bde2998f77a0
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGlgfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783542901; x=1786134901; bh=GWr+/cYzoqlgW0kcEges+YFVPk1EvrUUCWQCvaQHOqI=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=dL4HSmuqc/VJH0/UZr+88qr6rSn61knIn8+Wh9JIlJHgVotUdvZAEHbMDJcsshsK5kPIOsZ7ThORGJDpEDSbAxy7Fq19PCZ22/FmuFiCUAdd4b8OWr7EFkROdtf4NMhDB7yNHRS4dcOb+Jl+rZWPYvF1X1P+nAJQ1navn6KWneWoQF+8ChI4dtZXLGAYiX9NB0xKgdLsokenF1elFDGbjDCdnZFKKtN6GOa3KomrINczVDq9VwJR6kaO+JBtpFak5K18Uv0vomG862ECLCpFmGX4hY6+hYN5ekM3f6ZEjbXj6M1k2XPclrG9D74jSdQXFa8ix19ERuaSSEgf1gTAVw==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id 00DA9300011A;
	Wed, 08 Jul 2026 20:34:48 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next v4 2/6] net: veth: Add xmo_rx_checksum callback to veth driver
Date: Wed,  8 Jul 2026 23:34:06 +0300
Message-ID: <20260708203410.45121-3-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lo6NqBdX611puj1IL8BWwXcDTgFJwfIx
X-Proofpoint-GUID: lo6NqBdX611puj1IL8BWwXcDTgFJwfIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX5VrYUA0tufOn
 ktYk9UvpocZIym5Q9GBeOgMFdThscsOvClhGAi3jjTiI5wddEoS2zpFbp9bjDdlr1UcOscQ9pgO
 MqAYl3YlggfGrqUeS2CKHnliNLDQe8RkAfz8AN/0rl9ogiMQiYM68eGbIu8pTzMtkCyLcdQwqse
 o3t7aB3/EznB/IS6EproSpb3sVxXz7yXf3py37a3/CvhJvlE5hGzvchf9QUpySVX8aZKm1Garo0
 m3jc9bcGvEvewwyrv/Daqzlp7rmxrDC66o4/WcG7GjjqFIWvysxI2AgeubNcadEhMVtxtL5QPHS
 Xr9e0+VrvaBQ91FC5qG

From: Lorenzo Bianconi <lorenzo@kernel.org>

Implement xmo_rx_checksum callback in veth driver to report RX checksum
result to the eBPF program bounded to the veth device.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 drivers/net/veth.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..498d894d043d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1700,6 +1700,37 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
+				enum xdp_checksum *ip_summed,
+				u32 *cksum, u8 *cksum_level)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	switch (skb->ip_summed) {
+	case CHECKSUM_COMPLETE:
+		*ip_summed = XDP_CHECKSUM_COMPLETE;
+		*cksum = skb->csum;
+		*cksum_level = 0;
+		break;
+	case CHECKSUM_UNNECESSARY:
+		*ip_summed = XDP_CHECKSUM_UNNECESSARY;
+		*cksum_level = skb->csum_level;
+		*cksum = 0;
+		break;
+	default:
+		*ip_summed = XDP_CHECKSUM_NONE;
+		*cksum_level = 0;
+		*cksum = 0;
+		break;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1725,6 +1756,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= veth_xdp_rx_checksum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.47.0

