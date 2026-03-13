Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812938911C;
	Fri, 13 Mar 2026 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441308; cv=none; b=FeA7Z25ESTCI9R7UMaApJ0gZeXBfqOfeJWLgABmqL52e4IrV3UHW71Oqv/zHiglwv7fXnn6HdTMIZz6oJhOWHJ2nieMQUJ8qhcm8zTBtR92J1Y8EP7uK9fadBxbFRxkXU754w8oYuDlAXUnmMn50I8EQhHNlwUiVgk9hPwcMdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441308; c=relaxed/simple;
	bh=2hRxoXPHiiTTfcfjiyVMbqrDc68Jy2CknleYd+4iGqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNw+nYVXwcDaILsB7YC40lHg46Bovaoqb357nq7l61amr+8vpSUr3BlM46cviGczEQgcFUFftdpOqpGdBTes2q713qvy1ahgI7xm9iWEgtwdgUh42Dh6tYXvr5kg15sTU35/aop27yJUB17gEAnSN9RXOQcu9UleEzppzuMNfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eM65V7JU; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eM65V7JU"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 19ADFC0005C1;
	Fri, 13 Mar 2026 15:22:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 19ADFC0005C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1773440545;
	bh=2hRxoXPHiiTTfcfjiyVMbqrDc68Jy2CknleYd+4iGqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eM65V7JU0ki++LTx2bQ5be1ZdJoScWJ8H/gtIL68opfUUG1tPQB5jrBUvcX22RiIw
	 7iNubcPOj0CjDbj8+Of8nH5eUh6Phnt5F9Pju/sbTAj04jy5b+EwyFulXoiR0mNj4O
	 PP5I/4NkzNU0fLoMH7bZNL4AtI2jj3CcBBTA4Uqg=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id CA93DB7E;
	Fri, 13 Mar 2026 15:22:24 -0700 (PDT)
From: "\\Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
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
	matthew.gerlach@altera.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v7 1/5] net: stmmac: Add 25GMAC core type to dwmac_core_type enum
Date: Fri, 13 Mar 2026 15:22:02 -0700
Message-ID: <20260313222206.778760-2-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

The DW25GMAC is a newer ethernet MAC IP block from Synopsys that introduced
new DMA architecure called Hyper-DMA. Define a new dwmac_core_type
enum in include/linux/stmmac.h file.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 include/linux/stmmac.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 965ada809fdf..c8535476276b 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -176,6 +176,7 @@ enum dwmac_core_type {
 	DWMAC_CORE_GMAC,
 	DWMAC_CORE_GMAC4,
 	DWMAC_CORE_XGMAC,
+	DWMAC_CORE_25GMAC,
 };
 
 #define STMMAC_FLAG_SPH_DISABLE			BIT(1)
-- 
2.34.1

