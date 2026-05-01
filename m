Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8493D6491
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650880; cv=none; b=j+VDsR7Fe0oJti0+aOXZj/RRWSNceAWTGucHN8vOvijofb2YSWOOsZYiHx2Fsgiwhc3k+VDRc1jyRNGP/kWVAy5fPA0MuYRGanJGu/0IyCdYOCNhQvgXnuRwSsW9Awajk1+RIGGBXIEB6Ykuzz/DRY4cZsI8KMfbhK1lYMhD9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650880; c=relaxed/simple;
	bh=FecQt5wh6wqUypR7GIOTL8vQl1Ce+BG0nyhOWnwbzHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIBLoYmohGWigemuZmvljR7winzdLjaaKNye0PuWSWZn6IwG2vZWRIfJEb2PwgkcBJbNu36EgBet/HfMbGumdBv7TnpA9GHjRb2o5E9A6hJ5qwx3BSJzrVBUuDxaFJV2VR7CKekmz+UxPFNEME4S3+G3FbKMfu2sRLq6gzd4Oms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ZAgDP0s4; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ZAgDP0s4"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899d6b7b073so21010636d6.2
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650877; x=1778255677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HU0BdifEzvMmdb0M7vix3Brd2gKsWcYWwUTy3bx7+E=;
        b=ZAgDP0s4QtucLi1Q6l9yovad8PH0p+80wTXLtwGboA4oHPtlziC8ml/OsIxeUCbFRR
         zASeQjQGNpXhJ4ZjPY7VHt57wEkgCMu3NY7ihDMR8DF0wmpdc2zRSonrxsJzoyN+CdXy
         aHG4q8PYUyvWHcVJ50gJOxqybW2ND1QJjrEwRiyQAapHfQWWdTqaD9XCDyxGNIEHpDGk
         jOFAducwA7dbVRQoH08I9XvJhtQaTEN+/3910iAqAyfl2zxtchMEpZ6cwh+FUV/F4q5v
         5+GCp4moui9KewVl77ZuTwXHZmBsMbqSL1g74LDxvBBoz2Tv3ud137vzWCbpArhzIRfg
         9Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650877; x=1778255677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HU0BdifEzvMmdb0M7vix3Brd2gKsWcYWwUTy3bx7+E=;
        b=ASc4i3MMXwNNzxjK5cfVxmq45s5XKRuEPpo37i9K7aR0Xcl4bEplUm6p50gvpW0Y7y
         jdOrVbLp6Mn2pq6dW9e50CjaCFJaGYM0VZXqH8VrWGEskwK/4IksC3g9c8veUylYq95q
         w/LtHUA9r7N25ENVZhRYreWmRWX/LZ/P8IxwAzZk0j4FDw8964VlZUl1fR/CrZwJy74P
         m0xcfmxVDBIGGg5Z2/nexd0+gQke/w5S41oxYdMtinBfzL5eCQHqhFh0/u5oHCL7sLOQ
         SwJ7Azu+LTJbQnrXXu2l/G4hxCeJ7gKWUkqvB4Gqcbpi0zItEGB/rxT+wdx/y7D5ywJj
         V5Wg==
X-Forwarded-Encrypted: i=1; AFNElJ9SxjA6ES14B4jmqeLpJotkCD0+kY12AR7qgck5dOR5aISjr1dkXnnDBIoLio2+WdewAcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUP++CrS3fE8EHgCWg5WkuM0TclhL/WdkMvDnfPk2FX0f5ZwvX
	Nz/xH9+2GiBxOP9/Qp6UEOpf1H/SWQ2GwU0uLl5WTWYWcToSaI7wl/f6OIC8qfxg7R4=
X-Gm-Gg: AeBDievO4R8caR1yJcb28QcLRsPhHrTnthyJTSPKmS4Zs1BnSI4UAjUXKY0UQJahofP
	IuoHaoI4KIIzMdAWK5epMaJd7RddLXD12tptDU1aVAcLh3vg9jxDgP23pjbp+KIw1tDB7gtD6UA
	vXW2laa+iP7y5u9nISQWWUZrRBp6cOeU/euZWjWbYMFlO4kpl8AkYAmbBECXJPpLxgHtST1kn6B
	VZ9/kZ8agF7GWJu3FjSobHsnUvAEJ/PkLbzAAcNlGlYsk3+EIwDm7NDGZUg4sErIJXJtIP+RGur
	pNCESsv+xZws7e+AHpayRJb31Oqd7bEalBA42t1xT0AVFUPIkrAQSZtkEAS1K/eY7sq0cIPfHHf
	YqkCh23fphVOZj3TuKY/LjdapZRmtOxxE/hxqFETXA7kHHBvibMsB5kkhTOgKvZq0qt0B+UlyQ2
	RJZ3roLMSHCIno7jp1fTPEcgheX4M4yFZasNGTo2M8AhznmD8MH1PTXur0nToHtjtubHWkgSf8R
	MVYya1q/jSuHq49
X-Received: by 2002:a05:6214:3d9e:b0:8ac:b63e:72eb with SMTP id 6a1803df08f44-8b6660063bbmr1282856d6.12.1777650874598;
        Fri, 01 May 2026 08:54:34 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:34 -0700 (PDT)
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
	matthew.gerlach@altera.com,
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
Subject: [PATCH net-next 02/12] net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS
Date: Fri,  1 May 2026 10:54:10 -0500
Message-ID: <20260501155421.3329862-3-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Currently the XPCS found on Toshiba TC9564 (a.k.a. Qualcomm QPS615)
is unable to operate at 1000base-X and slower with a PHY connected
using SGMII/2500base-X (in our case a Qualcomm QCA8081).

The problem arises when the XPCS supports 10Gbase-R. That means that
the reset value of SR_XS_PCS_CTRL2:PCS_TYPE_SEL (0) is valid and this
suppresses the modal switching based on bit 13 of SR_PMA_CTRL1 or
SR_XS_PCS_CTRL1.

The reported XPCS dev ID on a TC9564 is exactly the same as every other
XPCS supported by the kernel so we can't use the dev ID to automatically
determine what operating mode to select. However we can use the feature
bits in SR_XS_PCS_STS2 to detect 10Gbase-R support.

Rather than introduce a quirk let's attempt to solve this generically by
setting SR_XS_PCS_CTRL2:PCS_TYPE_SEL to a reserved value when we detect
the right we detect the right combination of phy interface and XPCS
feature support.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/pcs/pcs-xpcs.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8d..b2c84b7e1e113 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -747,6 +747,40 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 	xpcs->need_reset = false;
 }
 
+static int xpcs_config_operating_mode(struct dw_xpcs *xpcs, int an_mode)
+{
+	int mdio_stat2, ret;
+
+	switch (an_mode) {
+	case DW_AN_C37_SGMII:
+	case DW_AN_C37_1000BASEX:
+	case DW_2500BASEX:
+		mdio_stat2 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
+		if (mdio_stat2 < 0)
+			return mdio_stat2;
+
+		/*
+		 * If this XPCS supports 10Gbase-R then it will be the default
+		 * which prevents 1000base-X and slower from working correctly.
+		 *
+		 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want the modal
+		 * behaviour that comes when we pick a reserved value. XPCS
+		 * allocates extra bits to this field and allocates values from
+		 * 15 down so MDIO_PCS_CTRL2_TYPE + 1 is the value likely to
+		 * be allocated last (and hopefully never).
+		 */
+		if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
+			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
+					 MDIO_PCS_CTRL2_TYPE + 1);
+			if (ret < 0)
+				return ret;
+		}
+		break;
+	}
+
+	return 0;
+}
+
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 				      unsigned int neg_mode)
 {
@@ -919,6 +953,10 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	if (!compat)
 		return -ENODEV;
 
+	ret = xpcs_config_operating_mode(xpcs, compat->an_mode);
+	if (ret < 0)
+		return ret;
+
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		/* Wangxun devices need backplane CL37 AN enabled for
 		 * SGMII and 1000base-X
-- 
2.51.0

