Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB93E5EFB
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546418; cv=none; b=hln2a8BscLEpzrOh3AajXgUOhcXfvLrdf46Sy6PxIi6KFy1lDZKmJMlO5wqxN0Wrxs5//PSSGzLqYwiZl1xSiMGKs5xLHUfv5d9CTutPzuvCnbZvAmsuWz4iXa6k5XLlhHEKiCIvPTj6zzQIyREUnggHpnAm3RlyMHERVH3TBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546418; c=relaxed/simple;
	bh=gVk5Yp0fa5DC+JmIN7hJNs0tuRiH76TK6U/e7s2AWcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCOOht3UoRTaQ/gg6OFjZdWLKnNLBH4dpuU8THSenoZuwxvZDs9TxibCUcH5ZH08AUO9nizw8/IaqpiRWmwNih/BBnXl3fI+JE7JTIBmETOq8XMbdn4ZjpbUAtLodTAu9Z2RlaZAq7fweigWzZTtlvEd7927ihCa7LaDwfFyuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNBASeX4; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNBASeX4"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81adacb0f81so649063a34.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546409; x=1791151209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cINQWWverkhRH4suCO77K0cLfNkdgj2lkVHlOLl+dU=;
        b=eNBASeX4zaB5bjKWwvhnEx2OlAPVLhGsQ5duqSjGt7PlpnlTCPenimPcA8OANXsIS6
         lzW/v8qWWNbDzpZa4wTGhpTpEB3b3lRus1Y9u6pWRwnz8aOPvQ2wUtACBiMUrwr515VT
         5EXM/h9Px9nxGGT88z7YDRZsGrltBhEgCkIqr+EZjDGuh+145UI0Us+hKBOU52/Qi19Y
         0qXNe00frLddsu0PkzpowZH/ydcO4K5m8Pq4+FN3bNLJZZBgIY0XnHKom7ryNjrL3f3q
         5nAgxSTw7kVKpLxM2puSiOXzKvHEqNeb4JG43OaS7kwQTOGNwUcATwvVKsnljrOkLXDx
         g+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546409; x=1791151209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cINQWWverkhRH4suCO77K0cLfNkdgj2lkVHlOLl+dU=;
        b=ck9F3dcrP5AEs88+ZlsDm3LWfsRrdhFQhugvlzDqCsVkC8n17djb+3QwMw8pqYPyTg
         xodmgkrW1N/P4qSqJRGsYO9hpUkVZSEK6NQUtVzkbsbr5vAbUD1NcAQAshd6iRTYeIVB
         yvskPROv3nitrQqQ7YqF2KsRJylmUVEBn0bb5V2+5PtFWyibhOvAnpNGRd/4RM2l130d
         fqtHBV29A68aBirAYZrohGVaW2JBqnpDv6uv9/Sgv6lrespG+hTy1JEymkwpGRCOGMgY
         KrVesjVuK/lxvb2fgNXXHPiGiZlX7+lNRNrAv3Uy5T7N6Cill6zOrdQljWgGGJsBnhpZ
         wJoA==
X-Forwarded-Encrypted: i=1; AKwUvBzIHjVcZfUCUlxpxnRyiEQvR0Ibcxz3Zhar1eWGHjDd1/1xwCvzeYq0LQ8YMoWk+VVIK3A=@vger.kernel.org
X-Gm-Message-State: AFuF++l2J/r6qYVai9uaWIqT8PdY4aL2N1fUaFpQyPJFYaqqJdqtOvzh
	/frO5Cy9lXyc3NSZ6G8YIAyziR5bsdW9s4EamMXhOHTomquQuNkvfBlu
X-Gm-Gg: AYBFou3S7ifqrUp7BrrrCf2PkEFaZh9IxkTE2kzTR1zm5smF7dPNCl7kiEtHq8EJ2K3
	CluAffNap009yW5DBZ04fSGgSJHwnKplqOkboSwMdCISHnxBDciOqXYK2TRULW7Gf5RNvMnnz79
	M2iJZL5pAp+LJ8FSyg97BRUyioOZDhgqDmKCj+rI0deaPRlispOP755WwxAF80w33rEUAPTubGn
	lapr/1jrt2DTPVyiD5TRbCOUYOpf/6b9w3D4SVzd4uBLvS3Abc5VCfvalPyqcndT5FH8x+pb2xs
	PFiHVX29gvKsJpacD93Y/ye4mz+P7Le2GkelA3RdSFTMLZj24MfE8oDL2f9q0bSeyPsGKP40EGS
	6a0p5CbW/b1KOFJ7XT0aeKRbH3s9qqfuaA6APxGE/tEkhuc70U6uhk0MmiMNZPEPwFNZi3rCH6L
	EnyGWvkMXSEem7fdQI2+DbVWv83FBrm/T32BXBn48ssChzYpA7n2Cj6Ob8WCGWXCrQ1ADl7RP8b
	5rD9TvY8kObHNHg3fNW7zxm1WAm1TOdpKIWpJcCH9kPOVXP9hzgu7v5uaAr4tfy3R5OAZzGU0w1
	jYFwLfHzLBZhDV8uSma+1c43UlAAnf9c9XNlzpoRNn6Uu7/R8ojei38igblDA9Gie8gFTdYFDur
	IaFoPjMu2rCUq9tVnimmZ
X-Received: by 2002:a05:6830:6d11:b0:81c:a8c5:6380 with SMTP id 46e09a7af769-81ca8c566f2mr813463a34.5.1790546408844;
        Sun, 27 Sep 2026 15:00:08 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:44 -0600
Subject: [PATCH net-next v5 09/19] net: stmmac: leave the datapath running
 for normal-size MTU changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-9-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
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
index a8e5e86e0ead..d9d676ae1c82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6212,7 +6212,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
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

