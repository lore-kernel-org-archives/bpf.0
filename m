Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2791366DC4;
	Thu,  2 Apr 2026 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166456; cv=none; b=ldXFnt/KhgZsOtc94Yus2V7K/9BHh4WRj6+8jB/cljYpW3ieMt4ZtZFPf05ewDxCvNtrlQVt9E4iBOoot96wDQqWplvvmhLi5Przkhu8VIr4nnAMTMDTFGFHUS4Rtm5CAQ8ZZSTb4mbGv1hdKl5rt9jt5skFnWO3ZuDVJYp0h3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166456; c=relaxed/simple;
	bh=NCQ2iu2oK2whClbBsYQU22HZemSxySMrHUGi3V4KUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lxj36KSrE3RFQe565ohjwWchHlNl29EYM7ZyjqJbC7Ik7BUYLTq2p8DqfIO/tmodbweM598504aA+PkWTeQ61MOrh3zbwEL4Hc2PyetVtinVnI1ucr0B8n2mU3xubJCYzp4P2ciqERf8Wqo+3PztEvcmZAYvpC74gU6fRgPp110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q47f1Lrr; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q47f1Lrr"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8F11BC00218E;
	Thu,  2 Apr 2026 14:36:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8F11BC00218E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1775165810;
	bh=NCQ2iu2oK2whClbBsYQU22HZemSxySMrHUGi3V4KUfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q47f1Lrr/thuuWVnUSzbZjCEG0ylDGJztlaCGz6QFF5us9vMWp+PInvkdyQsEW+jo
	 9A5DVF24arenq2mTnyCmbmqpXeOWUheQFiXs3sK2RNT2An4+4C/G7WaaJTzVT7V+6u
	 1JyHRAL10WEzjpRuWVGNk3yRhPtpBlx4o1mOVRj8=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 1C380AE80;
	Thu,  2 Apr 2026 17:36:48 -0400 (EDT)
From: "Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v9 4/4] net: stmmac: Add BCM8958x driver to build system
Date: Thu,  2 Apr 2026 14:36:29 -0700
Message-ID: <20260402213629.1996133-5-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Add PCI driver for BCM8958x to the linux build system and
update MAINTAINERS file.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 MAINTAINERS                                  |  8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig  | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/Makefile |  1 +
 3 files changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..0637b8a563ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5120,6 +5120,14 @@ N:	brcmstb
 N:	bcm7038
 N:	bcm7120
 
+BROADCOM BCM8958X ETHERNET DRIVER
+M:	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/stmicro/stmmac/dw25gmac.*
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
+
 BROADCOM BCMBCA ARM ARCHITECTURE
 M:	William Zhang <william.zhang@broadcom.com>
 M:	Anand Gore <anand.gore@broadcom.com>
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index c2cb530fd0a2..f6f8fa256bf5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -398,6 +398,17 @@ config DWMAC_LOONGSON
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
 	  Support for ethernet controller on Loongson-2K1000 SoC and LS7A1000 bridge.
 
+config DWMAC_BRCM
+	tristate "Broadcom XGMAC support"
+	depends on STMMAC_ETH && PCI
+	depends on COMMON_CLK
+	select STMMAC_LIBPCI
+	help
+	  Support for ethernet controllers on Broadcom BCM8958x SoCs.
+	  This selects Broadcom XGMAC specific PCI bus support for the
+	  stmmac driver. This driver provides the glue layer on top of the
+	  stmmac driver required for the Broadcom BCM8958x SoC devices.
+
 config DWMAC_MOTORCOMM
 	tristate "Motorcomm PCI DWMAC support"
 	depends on PCI
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index dc55aec915a2..a1e39f65cd42 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -51,4 +51,5 @@ obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
 obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
 obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
 obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
+obj-$(CONFIG_DWMAC_BRCM)       += dwmac-brcm.o
 stmmac-pci-objs:= stmmac_pci.o
-- 
2.34.1

