Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B1367283
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437782; cv=none; b=cPBZl1ThIKsbUI0mAeBpGHqLS7lL8QWAr85cOnqMoub467C/NBhk0mYdnzi1R+hoqpvlHpF3nKmfPLholpgI1NWWHdXpnr9d4YsqzHB5IvLuuUMzbxJLA3RvhW7QCBJdFEEnAx/FD55CDqHvUypEcQZwnxcTZtCSufVXF20QT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437782; c=relaxed/simple;
	bh=Fs1fLcJcakNPYti2xesmjolkKKjRCOnYepmgSWO4EZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KacGa/2Ifgz5aReNkHdv9HLrIbn3zNeR4mMJ+7JgjKtPOpSec+QNXd2KYEimL7y68zPJK5JU0Zl/fgAfxEL0D/k+FXzB0ETFYLg2khiQfp2xN/uB9VVbg82nz9Orv3oeZ74TeEKKU3OW2q9AQDRHr3FKxUU0xiAMhiucmApUwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezwJTl+8; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezwJTl+8"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6d817a94799so42367eaf.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437772; x=1791042572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgjZN8ALEfDluGPl+zvIInMEXTqsuH7e7EhuIKCn+Ic=;
        b=ezwJTl+8XDy6ICdAkHU/Oz1I3/PWGtlErLyaBdFVE6ig6/5vaU7gLAQTbh3nNBJcLc
         44BioCN6vLGK6fDOy7e/CG4DyWy4RI4x3jR3155XjdL/l3G2mepIzWYESh89HVpetz2r
         3LTlIvCU2SxTvegPUS0dnvgOCO1CqTPRRDnlbHN1N4gssRNirzP6wawTIwGMnPAFV4d3
         /TMKh3PHokjkvNssBQmdcLu9o4mRyHrdqJoZwtXggI5VoG4ZhHu5m8x1AQrRXr1aWRUU
         dbsEzjIVp1d3FNiJze0BsVs6MmtD6yRJQsc5vFM6tRLeChL/4gQ2E3Kv40CDvePaR8Y+
         TcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437772; x=1791042572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XgjZN8ALEfDluGPl+zvIInMEXTqsuH7e7EhuIKCn+Ic=;
        b=FPoarjss0NDMCXbHpbIJE7veLZk/Y+x5JrZMwvlBc3gSD1yKLua49EYf5SLJOGr85U
         UuDHqflbrDC5eHl7MySTnJqeHF1LQY3JHouTLzwCYJpg9G8Ro9F4lI7r9+Rtx7xOP7NH
         3iSJeNc77t9QmZRH9ALG5WhkOcA405cEnlu0LuMw0UYVetW/skVOfoOnD80AlD+F79O0
         yYaI1MDDHoE2l8OR+kxewHgX8J3fK2jjoRBCW4m8SLWHU8t3hh19CmwKMYKh8jv3bFnm
         XE/hvTBQaY7pH54fWwJ6a0fMnmWxneK94k0HEtqWADj/6kFOWuIdCcJllLse9zZzXbFX
         40Yg==
X-Forwarded-Encrypted: i=1; AKwUvBwCcT7ZyX5DXACClfOp7cQ/BqumwU/FVPTf6em2x9UfijF2hnjn6hhKzATPAe0vCjDO7Mk=@vger.kernel.org
X-Gm-Message-State: AFuF++lMWQRBXZdd76gDW7+cQOW3GH5aGUhk8bUVkpTqpq9xLePgLA9R
	7y2xtjFjy0fi7hLG+1Ak21CDVlqphbnTQlcNz3u/j4Xff9AftRX5TQM3
X-Gm-Gg: AYBFou3HR6MRGoWhF9cJaB+yCzo9gdRP4KSKBF0uEL+fvEMjk4snuhLHNsRDPPy7V8c
	sLdffc/Td7Hml5e3uso5AMFsMztrHivqzkKjtQ4ZuaB+SyQB9/CbyudA/+MaBK7sxLFoKVDNWXo
	A+AeKpzD4499+HaF+IeyB4EDsAKc6UN1C6Woj432IKaJLqR6+GbKVJwsiA0+4+wbydVgWnqkTKW
	faX5pfIwBM2s+20SfmElL8XxSgm/pp+ud5Orod8T4Tw2nMrJ3kiR9lnzde6VJtysDR/7olGqp76
	lxlcBwRN3VcVLV1/nIOenkHSsYdrmFGNL9CbKPQEpz39TWrvZw/xOEa6wOVAylDCTMXBCkvFYru
	zpu0GQGQYFg4aVzu/8dNGwgfn1A3BNCGuti5yqTPw0497x4bRPwMRmZIWMdHqfWn9Ku2g0vrMJh
	rG68xJKY2kuqZpHIcNZwKwD0GorTs6baMesAK8Q5A0clHMeIBUdHCYr0QF/BrlHIJItIjyzxGL4
	N4XaF/yU8Ob1kqgtEZv/vnR/NWsaJ+FZiLQ6mOuNy3WAq9gWmxjaq5SR2IejG05Rcsd8smq54HU
	t0Y7EuldGuedpcBxt/atZVPDnOFGW4sFwd9Azdzt0bbKs5rgGRhPB9rmRxLboTXIrpd8+T8yHA9
	pkr5qhk4ucODsVkqRTnWkQfo2Z9AVm0g=
X-Received: by 2002:a05:6820:f02d:b0:6b4:117e:543 with SMTP id 006d021491bc7-6d43f7a6d39mr9544686eaf.21.1790437771939;
        Sat, 26 Sep 2026 08:49:31 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:49:01 -0600
Subject: [PATCH net v4 06/15] net: stmmac: leave the datapath running for
 normal-size MTU changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-6-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>, 
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.15.2

Changing an MTU at or below ETH_DATA_LEN does not change the receive
buffer size or the MAC receive limit when the previous MTU was also in
that range. Do not release and reopen the datapath for those changes.

Besides avoiding unnecessary hardware resets and their failure paths,
this keeps live AF_XDP pool bindings intact. Preparing replacement rings
before stopping the old rings otherwise binds the pool to a temporary
RXQ and consumes fill-ring entries while its current RXQ is still
active. XDP already rejects jumbo MTUs, so all supported live XDP MTU
changes can use this path without preparing replacement rings.

Keep jumbo transitions on the existing reinitialization path for now.
The later ownership and rollback changes address that path separately.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8b0bc7c46df9..bdebc5bfa2b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6166,7 +6166,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	if ((txfifosz < new_mtu) || (new_mtu > BUF_SIZE_16KiB))
 		return -EINVAL;
 
-	if (netif_running(dev)) {
+	/* Normal-size frames use the same buffers and MAC receive limits.
+	 * In particular, do not disturb a live AF_XDP pool: XDP does not
+	 * support jumbo frames, so it never needs the ring replacement below.
+	 */
+	if (netif_running(dev) &&
+	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
 		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
 		/* Try to allocate the new DMA conf with the new mtu */
 		dma_conf = stmmac_setup_dma_desc(priv, mtu);

-- 
2.53.0

