Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494490;
	b=c8cMlBegV6D/WhBK/duJqEzTeDVjziBQDmY6auyEv3/cGNYRaT3Wcq5Dn/KauCesf6Xk
	 ztQJMYpEOqgkSufURkUHfxSB5j5DfsOhcIMo++1ATEs2SKUhFkbTk/kvwUcBJvW84GNJP
	 CDwO8Wd5t6hdfnBkeje5kvPe0f6UpuM542Y3S69+JDtoWnaiz3mp7aoxBaaBVB1/VtPWb
	 gMh6EpEFf/qd2N+XItyUKyiFUisO8NO2v7JYrPjQrvx983g4OX84V/4V5fRCbGswqTcVs
	 dHYysRTuvGmLEcJMZ2XEEwnGOTS24JzQYSDdEBBupVkhY9zVEcVTYoFrTlgLfR/Ne+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494490;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hHypU3MBVkNWDt86hCOzcgVyrJp5GfhS4aRCatM/mXA=;
	b=0kCc/erfUpH3CNOUWnReqYMejChkpac9DvgI2PtfSV2hV6P5ccDq6fYXgtPoRG6Yb4ZX
	 QD3RuHWm2Dff42Ox1BFw7jbYotIicHtWyb7UIRB54cY1pICWYWH22a9VFEsB/P4D0uc/E
	 x5DeZcgMvoVPncywplKtKUC5zOv/9nEd18nHge6gsIYIi4EU4ooCt6zYXp/kPFeslf9u2
	 bIDqAZhjHTTc+JTvvbmmW9raYnvsYyU636jFEDbpDTE9nyRE+scT4qYhxZNL1yN+L/otY
	 g9EZfhu5FTDNEUKLcvhxMbCsfSZGUfscMUVAZRGfsvdiSg8rLQC9/hxJ074xXblTtyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSFlgDoZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C90606A322;
	Tue, 24 Nov 2026 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSFlgDoZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795494490;
	b=UKr/2yefYvf8zEJWMswOe88AJh9NT9IcsrZxW4hjtaonfG5fiRcIlGg2zfZj8vY1eQLI
	 fzwmptqVeK8uW4e0atTagiFEll3998gye84RLA3UmxinRB5NH563xVNzp5EZLU5QLl3pg
	 69vSLAj3vBIiNfcNLt+zfhnEXc1cUgjMVDQmuyaHK/TODBBfAk+6YmxeRM+lMQdgce8je
	 8oJPx2exeovqdqH8Kay1sug6J6hvM5OdS2T2zdyxZRptIuS/wwrtv6uy3TBGcxjsJ5ezz
	 y3nqOoI+5ZDHN9STHdC6hyIRd9JMdDLUSAuAitzbl7821jOaXSxcawRiVZI312Fwpcw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795494490;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hHypU3MBVkNWDt86hCOzcgVyrJp5GfhS4aRCatM/mXA=;
	b=ip5yRvq6K/TxY+bmUQd+dbJKMYgFX4h1sn/nF7Y5RQPeYmHscBsIXeFpHkK2PbmvZruk
	 k7nUzmJ64opgtVQymLSfIbncNCCSi7FVrOnLWXUZGQIvBKzx4JEPvpEOFW5umsvyyRS1P
	 d1jJBViz/ROfBHQD1qnkQ78glbZ9PJ3DcZ/81xzvEzVkLJrQGcAZissMgI67FjBwLFLgk
	 nH22HcpCAe/T8Hy26uw/B1F53DTBhBYNOD71Gx5BH3ruKfv12d4xJN+DlXSt8o9CI2xqa
	 b80lUc4JmM4mvwuyGpWaz7z6ZgAs7rU2BRHEuV+DYbbw/f2Rlnf2UU1GVAJDmjUdDGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D4B951F000C0;
	Tue, 24 Nov 2026 04:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795494490;
	bh=hHypU3MBVkNWDt86hCOzcgVyrJp5GfhS4aRCatM/mXA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aSFlgDoZdG9N5b4sSNFzP7MnymePgoLrGInaGQPme/48U7p9EII1/EjiYoJHT5nh1
	 2ua11qCZRFFe6EWrsGytCrZpSHWnhuRBtjQJpnMPVHLSW7Hy9JcMyONyU32Hg0SQjb
	 dQ4GzxBup9aIB6Ds8ytksA9HF5FMIVzUuI93DLr8dLxBK577uWfdm5WPhpjudygWaE
	 0usksAu065TzVY6R4cxez1WT1BhEPwF2zBK0uz7HWjpfV3ZUblHCO3qFO9vV/hFOVw
	 1eCZcGUhwu+ELd83lgBEIbVj8bZWOgKmFw0wvLXpakX3tGllucvpankanyWPzGm3dz
	 0dBA16SBucklg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 335EA4C88A;
	Tue, 24 Nov 2026 04:28:03 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 04:28:02 +0000
Subject: [PATCH net] qede: Don't advertise XDP features on VFs without XDP
 support
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
Message-Id: <20261124-qede-vf-xdp-v1-1-6fd99227d178@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFESBWsC/yWMQQrCMBQFr1Le2g9JiCJeRVxo/qt+F7EmbSmU3
 t2oyxmYWVFZjBWnbkXhbNVeuYHfdUiPa75TTBsjuHDwPkR5UylzL4sO4pz6/TGlGJVoxVDY2/K
 7nZE54vKXdbo9mcbvB9v2AU/A5ad0AAAA
X-Change-ID: 20261124-qede-vf-xdp-00d158cc44de
To: john.fastabend@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
 daniel@iogearbox.net, andrew+netdev@lunn.ch, edumazet@kernel.org, 
 hawk@kernel.org, ast@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sdf@fomichev.me
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795494482; l=2042;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=vQr3uhj8nir4mygw+a8Vo5cg0xdsW+ekBDQFJzRYxlk=;
 b=lccUFniknjtEaGIRnCUPoKnsqeDfSk0tVWSy5f0m4CGQE4Oz8pusaHVqxEGqoy/LrGLkyA2eW
 4S5jj63+juYCBCK/B/NDKcq+RWol+4WGDCd1krEANM9AFA2l9E5c7Mq
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

A VF without XDP support gets qede_netdev_vf_ops, which has neither
.ndo_bpf nor .ndo_xdp_xmit, but qede_init_ndev() still sets

	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
			     NETDEV_XDP_ACT_NDO_XMIT;

for every device. The devmap code only allocates dev->xdp_bulkq when
the device has .ndo_xdp_xmit, but the XDP redirect paths use
NETDEV_XDP_ACT_NDO_XMIT to decide whether they can call bq_enqueue(),
which dereferences dev->xdp_bulkq. So an XDP program running on another
device can redirect a frame to such a VF, through a devmap or
bpf_redirect(), and bq_enqueue() then dereferences a NULL xdp_bulkq.

Only set the XDP features when the device uses ops with XDP support,
that is on a PF or on a VF with xdp_supported.

Found with a static analysis tool and checked by hand.

Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on x86_64 (W=1, no new warnings). I don't have qede
hardware.
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 7ed17faced54..19d13ef27d10 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -890,8 +890,11 @@ static void qede_init_ndev(struct qede_dev *edev)
 
 	ndev->hw_features = hw_features;
 
-	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-			     NETDEV_XDP_ACT_NDO_XMIT;
+	/* qede_netdev_vf_ops has no XDP callbacks */
+	if (!IS_VF(edev) || edev->dev_info.xdp_supported)
+		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_NDO_XMIT;
 
 	/* MTU range: 46 - 9600 */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;




