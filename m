Received: from outbound.ci.icloud.com (ci-2003c-snip4-3.eps.apple.com [57.103.91.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3033DD526
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847092; cv=none; b=ZgX5ObFm1pr2sooDrJKRcTSOH323zVeVTfnIWsM/q413bZGpkBDdMRju4HnHfbhNt9MCoR0z4cIcEjenadTX5YGBAB3ytfe339PXZbwXO3Icv2nQoqqTS0YQBdm68jvx9nyByMyX7xRMwTUTYYfNJOQQA//PELd6gxfmKHCwLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847092; c=relaxed/simple;
	bh=5BykT81qTnmm4vpcgmzIZjA/frIMRr2JvZYfSYh06Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDgaswksEcpsjRNAEdGsZdGiQ83gNJ9d9ibPeUA8Em1nRNO/sG1JTIgCTVgzQdH8YUIZLfxPX2lhQtdyXHXTh/3nZGWH9Ik23boGx0rydelbOUhijGwCpi52sbF2MySR/1AXh3yFnlJ+HgDXFLzuONOy5S1xOYYDJST5qs0qhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=n84PIVDW; arc=none smtp.client-ip=57.103.91.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="n84PIVDW"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id B42A11800350;
	Tue, 30 Jun 2026 19:18:06 +0000 (UTC)
X-ICL-RepId: 019f19f7-a042-7bb6-9150-451fadb1a01c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGlwfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847088; x=1785439088; bh=J8z0BiiSjdwjKKt9TLWZCWvOoAAMr8hZowRTHIkZBCQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=n84PIVDWy55gep61QyicHC+c1aZniluA1McIUJTzA2/URYS243pZ8gXcCENxCyhb8a7H56XOyTpZjOR27sqeR4Arnte87e7hbJ0M6AIFBFXb0HvQ5dJ5C23IViuQlFKNBknowEJQeJ8yQGbOWtQf6WO3uAcAgCrb3KVQHx61zNXGk86qyg2LEdyT9X4+XtzKQL7nO0MP7ELfORZQHxdt+gflLA6QhwARuHRDq4sLVJMvIwc5AY8M1jIFRZyh2Z0YdEwEUj/slNqYru9ou2gQU5cI9m7cT/e4Qk/92TcQoBp9iWnPiPPiPNpbewXu3VrwK34Ux8qLRJiJWRok60a0qw==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id 180311801A8C;
	Tue, 30 Jun 2026 19:18:03 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [RFC PATCH bpf-next v1 6/7] veth: support the rx_csum XDP metadata hint
Date: Tue, 30 Jun 2026 22:15:09 +0300
Message-ID: <20260630191510.81402-7-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BXq2mXTp8n7D_PbQzsLZ1LGacAcheszS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX1W5294QcEWPR
 xI6facMuzf6VBJaKPGUfrU+iMkcHDa++bxhALJXzbEvKdfDUSLRpF6W0yJ7DMTma+FZkehmO9mJ
 vfY5eP0KrvBf4Md9Q2hlUecg8Qeyon7tu9JQir1qjCydpTkVcQvBMBzBc46MwsC8/FYcWfXFd38
 FdJZoJgoWJqif6modoVFlDWNLNkarxEhh9J2S+Mw58+jvzxLR2mbStrDbzpL4RSxRE8qnZmc1g2
 ysJOua+QSJzoyYiwEuwo/qK1PFD2AvpsffWWbgVpyql4ic4z+v8S5+zXxWQOsf1rUyn/XomxsE9
 IFRsFtkoo27FZM80E9V
X-Proofpoint-GUID: BXq2mXTp8n7D_PbQzsLZ1LGacAcheszS

Implement xmo_rx_csum from skb->ip_summed.  veth has no real hardware;
this surfaces whatever checksum verdict the skb already carries and makes
the metadata kfunc testable without a NIC.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 drivers/net/veth.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..b7bc5a3b07e5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1700,6 +1700,28 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_csum(const struct xdp_md *ctx,
+			    enum xdp_csum_status *csum_status)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	/* veth has no real hardware; surface whatever checksum verdict the
+	 * skb already carries (e.g. CHECKSUM_PARTIAL/UNNECESSARY from a local
+	 * sender or a previous validation).
+	 */
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY ||
+	    skb->ip_summed == CHECKSUM_PARTIAL)
+		*csum_status = XDP_CSUM_VERIFIED;
+	else
+		*csum_status = XDP_CSUM_NONE;
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1725,6 +1747,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= veth_xdp_rx_csum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.47.0

