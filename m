Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCD263F4A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621257; cv=none; b=tkfI5+t/2ce+NnZVNBouXLooq7GM0SvX6ZFnTLGrViGrEvkt+N2qFOrhMKlkHACJkrHqFUuzI7HO+dr/vR3ao0JMNef74ovkSQzSLn3zY7yM7IcdNGWssOfvQGylzp1AZX7cIoY3/a9dYRa3r6+lIr/FNzWCGQL6RcxB9GIKmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621257; c=relaxed/simple;
	bh=Fl2vvfFimqS4GlpOM20DZtsfCLCrtWoZalqmHnKTKCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GarQP0MapYmys6rj6qhClw3IXNivRux+mTjqBWqYIMyGM2csznVuZs9VHxMvTn04G+bLF3VePy1r4XxZF77B52Aqwvai8faGXtu1RydCJv8kX9q8JRG86jnO3FoPYVoOd0BrJPOn0FHBeexktTiS/5/pEjZuSo0CC1HB2jkw0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hnPP2LhC; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hnPP2LhC"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-486852c7b68so546048b6e.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780621241; x=1781226041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZkK5iRkM+bFu8r36hoA1oZzT41u9/qmzwRkx8FhOsM=;
        b=hnPP2LhCrmphc0LS/cRwIZU/py9l8iqMlf/5s76G55Vbm22SCgKVelKwBEkfF4qIZO
         NtHYL02toKdC1nI87qUMsmfD1yplesNL04PK7gmMP+7FPrlLHUwP7vx1KGzcLT7w+UjO
         od15QFIpPyVrVlCbHpUppdWGsiZfGqOKKOPzPtsR3con7QeX2QmIG0wI+hDkWGNRH/k+
         0Z/Rikks1UulXIN9VvXGldIawMTkALO+12U/8NWaFwTwfljOVJNAu/SffsPJOYtQa7LE
         TFYGw/qDgWbPhJ0Qjr3bSbf3C+D+z1CuU98jyXVDDbGgp95VMcf4tqUOa/gNbJCUIkrB
         qp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780621241; x=1781226041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZkK5iRkM+bFu8r36hoA1oZzT41u9/qmzwRkx8FhOsM=;
        b=qEP3q0UlpP0ObKbnHwOLEWyrOkEastGfiW8SByi8tGk3Qy53PF3k9fy4BCwlvEG5Rv
         ms+2U1Gg1Iw3TA2z12DW2jRJ9kELw9CCY7VBRMPnewvanV9EZDz72n3ooffrw2RLqS8T
         pwnmEFo8lR5Vkl6nRVSZv9ybz7XmjjG4IoY0PTgCMb48VkgZTkldfbtTm0Q63w3rQwY9
         EIaHbeRh+tZ24o/pUuT6vGqt/pao3eSnfWdYQRgoASrs4LA8KPxH838E6MHZfLAPXAg5
         UzkSj9eUTC/eHdam2hZ71HeJ8vaM75alAF2vYAmAXfLJ8cc+TzF362XvwJTiFKMBikxq
         n4yQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qAkwdslj5xqBRyxV0GaNChzD+2eR7dIyeqK1MZzuiWkUPsjnTv0KIWN6LdcREISIE5eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1ssBjQdZGqplgm3GOaXaJzCwtl4A6lA7a0nkFwWoH3nV82UH
	r6cpArAGmIbUtIMSDefsN+m99ioxhhSuCM/sLzNlUX1GLy0t8ePkeTWCK2FeTDmrgMo=
X-Gm-Gg: Acq92OFowmkpsl0VW0SLKL8qfyJcszTOJfQK9hmpSlCVCnn/E40ggWdN3uX3ZlArEp8
	th0kgF/whQ+XZtluy76bXoA5XeVOeipBvlJQc9pD6Oyi6RsVYbcIxEYdkF9A6Q4+hIeVDduZKmI
	/S2bhiSaxuoPffYzEwqMNXHFomB5I5zFNTinaqH4ZZAKeAMZvLjDPfnAoN2ca+Q2TxPgy/PcOZ3
	dzHS65Igfik/rJlh+FedeW5gmYU/IU4yqipIkzNpCQEp8edvnLnKFMA7xTp2oX8lm8F20VYZFoK
	ioL1pmMXJmQFHP/g+PIPAAAAHCHkevP4d2uQ7Ndc0gKOXA46VtfyERVUSN0Q0ps9sboOY26cAYk
	4+wGT1K9X2ESPjSujMuzQ5wjGYT/6Eqx5w/aN2tpqPIKdrinSHj3A+sc0snVPWY2X45w2ZISj7e
	jA7vKRHwuIjB+CN0AUHN4XfHBzCBIE5kwtgLN44w==
X-Received: by 2002:a05:6808:1b0e:b0:467:5f1:fc93 with SMTP id 5614622812f47-4868dbe795amr869921b6e.9.1780621240655;
        Thu, 04 Jun 2026 18:00:40 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b6ec694sm5544631b6e.5.2026.06.04.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 18:00:40 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 04/14] net: pcs: xpcs: re-order xpcs_pre_config() to update after the reset
Date: Thu,  4 Jun 2026 20:00:11 -0500
Message-ID: <20260605010022.968612-5-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605010022.968612-1-elder@riscstar.com>
References: <20260605010022.968612-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Currently, on Wangxun platforms, the XPCS is configured during the call
to xpcs_switch_interface_mode() and, if the need_reset flag is set, the
XPCS is reset and the configuration will be lost. This is harmless at
present because need_reset will never actually be set on these platforms.

Nevertheless having xpcs_switch_interface_mode() on the wrong side of
the reset is an obstacle for future changes where wiping out programmed
configuration with a reset could be harmful.

Reorder xpcs_pre_config() to allow the reset can happen before we
switch interface mode. To make this work we have to hoist the special
case logic for SGMII into the parent function.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/pcs/pcs-xpcs.c | 56 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8d..76c04372b5b50 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -705,46 +705,50 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
 				      phy_interface_t interface)
 {
-	int ret = 0;
+	/* Wangxun provides a full alternative implementation to handle quirks */
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+		return txgbe_xpcs_switch_mode(xpcs, interface);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		ret = txgbe_xpcs_switch_mode(xpcs, interface);
-	} else if (xpcs->interface != interface) {
-		if (interface == PHY_INTERFACE_MODE_SGMII)
-			xpcs->need_reset = true;
-		xpcs->interface = interface;
-	}
+	xpcs->interface = interface;
 
-	return ret;
+	return 0;
 }
 
 static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 	const struct dw_xpcs_compat *compat;
+	bool force_reset;
 	int ret;
 
+	/*
+	 * According to the XPCS datasheet, a soft reset is required to initiate
+	 * Clause 37 auto-negotiation when the XPCS switches interface modes.
+	 */
+	force_reset = interface == PHY_INTERFACE_MODE_SGMII;
+
+	if (force_reset || xpcs->need_reset) {
+		compat = xpcs_find_compat(xpcs, interface);
+		if (!compat) {
+			dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
+				phy_modes(interface));
+			return;
+		}
+
+		ret = xpcs_soft_reset(xpcs, compat);
+		if (ret) {
+			dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
+				ERR_PTR(ret));
+			return;
+		}
+
+		xpcs->need_reset = false;
+	}
+
 	ret = xpcs_switch_interface_mode(xpcs, interface);
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
 			ERR_PTR(ret));
-
-	if (!xpcs->need_reset)
-		return;
-
-	compat = xpcs_find_compat(xpcs, interface);
-	if (!compat) {
-		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
-			phy_modes(interface));
-		return;
-	}
-
-	ret = xpcs_soft_reset(xpcs, compat);
-	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
-			ERR_PTR(ret));
-
-	xpcs->need_reset = false;
 }
 
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
-- 
2.51.0

