Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B73D668C
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650881; cv=none; b=UwWxblmAZVYb7+LCV4ONXS1c79LBeDWG7GMBMt/v/MKuvUVJXQ7mcIqFurw1hUYGiDnbC3C0tKFU91WW0MnVsTFPWyAJmafVsGta7SaJYNIAE48C6Kh/XddrpCit2Ne3tk1PvuUhSnZnQLDfkzaefIwruVR/zy7ntNlyG7k3/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650881; c=relaxed/simple;
	bh=vSMz0fMwD5nvE28rW2N/JHi9BJvlZF2OiadS95iYJ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfiX54s2+X7wJBGESm85ZGFnKaxNE4TLWErxJVjNT1hl8b8ursTjlXeW/Z1+M+Ba9NjuFhBPvOCpHnLry6m5S/wAW52W7WN5oSX2qKxh6TlpQvD4MGDUhiFH/SpoCPL9dB8ooNojeQkbOFPYw7QEVD0foD+iPjM2bcHngwkrAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Z5pLDII9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Z5pLDII9"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a032383008so21416756d6.1
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650878; x=1778255678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVr8Clh+n9i4UIz8+5GUPFBuftN5UkiMGfqWWtAa7So=;
        b=Z5pLDII9inAZIYRk3mHwRycVsXtkdv+tJIEvThfg1icNH8qCTRn+9tTfuMPeovkW7P
         aQyfaIEH442Fs0eM8ndBTO2CA74qq3PvbpncoYETsKlrO1XAZ+Aa/TUPukzfqc0z42dg
         bjLWAYawkJmCx/oTfbXnbGm1HowNQ1loVD+lWT9od8pPZFGuQmtJJn10620MKicg1cXp
         brPPS5wXGQWUUmaMzR8555yBCFcstfLYTEsZN6RqjSP+ev8ympE/3h8ThKfQfkvZoZ9G
         nHyRUL0Afm51WMx/9vtY0l+lbCP7perMn1H3HIk+UUBm8ab9lrekzEb3fdpREmkWP5Y+
         4C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650878; x=1778255678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVr8Clh+n9i4UIz8+5GUPFBuftN5UkiMGfqWWtAa7So=;
        b=FR7LzYVqWQ9BgQhrzF03TKGb4/0IgkmcGQ9/fuVhnlVtN6n3QM1C5sP6Lh7/gI9keQ
         TptU9V88YEA1yYgZjRnxwILR5r9TT7P5WF7TidS4dr2wd9q6NhhqrLEY1TIu7JexUcPD
         ClFuDOdKTOpqNMWt3xMf9uxyKR/d/fes70Lh5IIyQ4z/BvtOnHOUQrguD2UmnpKJakFU
         cp1WCHkONOa3CgPjNslNK4ZGMY1Bexnv90Fz48kzU9nsES/rA1BC6KSujoYiuBtojyRt
         3vSXqCmsHGEHHlhm7qhhWDvEie/n7X7kCfEX1szPTewDTa+o5lvNnz3mi7WlBZ0cb+av
         KdRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DMZq/nNtkAtp5TftQRyZcLx31w2Ln7DWT2gUg/GOzS5sgmMU0KcAcw3uuenxMV2cb5GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOCviX4qm84m+gD/QnNeYpTFRCR0tj7m/GgTCf8bVFRkJ5kSl
	myEaJp03Z8OPma1lRdUCswijUpJ9GXSB0bCDL9s2grvDXkcjFGrep8FpyWKw+iTXPno=
X-Gm-Gg: AeBDieuHrfm5gimwbt+h3Yd9TBEgThhcy5OmARllST6lK3+HNQYa/1utiBrftOQWD3z
	pXv9K7qD/J11sd+axSqPrKFy59UOOvg2a6o1nz/nEHAXOg8UcsFWhmlTyYUdgWmEkEg/YbUJVB5
	JZHddt9RDSt+DE6msEldRxU5XN8f6rGx59Kx7k7EaiZkxmMMGwzlkRCeQ3vwivh0eYD8qSEaVZH
	GAuPG4W5K0Y6tvrWyr2DaFg3vSDvH+nWpFM1A8Xiwb3pJECdAcGpMaa4jWGbTbmZ9By57F0jhKv
	2vroifCTW9l97phbr394vy/Bqmzl9Vrb+9oTajuGaUvf2R9lJgfJKlH0MRMy6UbBO2xEU/9le0f
	G7vD20oAeOFsh2SdqwJu66FH6Nq0Wvbr2LnWPf4dqhmFsF3AhX4dmlO9RqmXHM0sWUdMO+ppsof
	uSldl9mLHKmakHMFeAEF6v8ODrbzFdja0w+icNDZQfr66O68AoeUy792cXAqdwQk7vnMAUODS2+
	5XuWQ==
X-Received: by 2002:a05:6214:483:b0:8ac:bb62:fe4a with SMTP id 6a1803df08f44-8b665f02857mr1068856d6.5.1777650878062;
        Fri, 01 May 2026 08:54:38 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:37 -0700 (PDT)
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
Subject: [PATCH net-next 03/12] net: pcs: pcs-xpcs: Preserve BMCR_ANENBLE during link up
Date: Fri,  1 May 2026 10:54:11 -0500
Message-ID: <20260501155421.3329862-4-elder@riscstar.com>
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

Currently the XCPS found on Toshiba TC9564 (a.k.a. Qualcomm QPS615)
is unable to operate at 1000base-X and slower with a PHY connected
using SGMII/2500base-X (in our case a Qualcomm QCA8081). The link
negotiates speed correctly but the MAC can't get any packets out.

This attracted attention to the ANENABLE bit and we observed that the
bit is currently set during config and cleared during link up.
Preserving the bit during link up allows the system to work as expected.

Perhaps I lack the imagination but I couldn't come up with any reason
why keeping the ANENABLE bit set would break things for other XPCS
implementations. Let's ensure link up sets the bit for SGMII interfaces.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/pcs/pcs-xpcs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index b2c84b7e1e113..1d62d5b31c61c 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1263,11 +1263,14 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 					 phy_interface_t interface,
 					 int speed, int duplex)
 {
+	u16 an_enable;
 	int ret;
 
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		return;
 
+	an_enable = (interface == PHY_INTERFACE_MODE_SGMII ? BMCR_ANENABLE : 0);
+
 	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
 		if (speed != SPEED_1000) {
 			dev_err(&xpcs->mdiodev->dev,
@@ -1283,7 +1286,7 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 	}
 
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
-			 mii_bmcr_encode_fixed(speed, duplex));
+			 mii_bmcr_encode_fixed(speed, duplex) | an_enable);
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
 			__func__, ERR_PTR(ret));
-- 
2.51.0

