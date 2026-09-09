Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAA568FB8;
	Wed,  9 Sep 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958884; cv=none; b=uvlionBQJ741sQpCmiP3gnelHYwDxDpcWGfWsiuvTk+mu/zLXtGpLwkAjWH3WRANgovx+NyVVIFgKL8PwGBDN+ZZZDHzLE3d+bnrbJ/hBTlviHdkmjow1+Pi1R1IygH5jWMA+5Lmd4OIRLgoGciUrdPjhwJqYUKlPwUP8/ynaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958884; c=relaxed/simple;
	bh=wGxs+F/+5Vrhuyz2y5uEWLeuFrAw1YPbFSMnjR0PIic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N+iR/tR2s0dqNx3HcJlDucp2MtFU4oRH6vGuzxwFqviC+ZVmo97wZnH3/57evOmucYdgECmrKDlcUQ9yy6m1OIsL5ul83v5CvOFQGySMr3Gl+UuyhniW/DBV5ArS+HkyRYkKt5Dfh6a9wQIdhdoE0g/nIb6961rhDCSvljSMBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kIdAIrlX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kIdAIrlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788958883; x=1820494883;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wGxs+F/+5Vrhuyz2y5uEWLeuFrAw1YPbFSMnjR0PIic=;
  b=kIdAIrlX2i5Ws4OKInvWaC8eZ2mFBm7uI3tf2xzKq1aqtRBRgeXVamXU
   ExlJIcW9aEr/th0kBileXEGtM+XO773hqhLeVKn8iCPllq7cDMqczEdfC
   LixEkNQRs71VLOnYQYingw0dJB18dd0D+0+xczoCd74/oaKlb2ZjUL5uB
   aWSlcBSkBQW+wa4399yUZJ9dMqFMRnAzpszSbcfd1xUP4KfrVwfKJsgO7
   ceKl4UkmSo+0O1CcQV5my8s4GkNimP//enqZjD4FwmCFySWhYethnjA3i
   h1KWGBZV2QnBPbNgvNaX3pPAODoWll+oQ7VyaOT8FSbogLTq7E/tTmQ/D
   g==;
X-CSE-ConnectionGUID: m9VhaSUDSZCeuWHFixm3Lw==
X-CSE-MsgGUID: UKhMqLabSB+23J0chCn83Q==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294759204"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:01:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 06:01:21 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 9 Sep 2026 06:01:17 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 9 Sep 2026 15:00:16 +0200
Subject: [PATCH net-next v6 14/14] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-lan966x-pci-fdma-v6-14-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
In-Reply-To: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

Add the fdma interrupt (OIC interrupt 14) to the lan966x PCI device
tree overlay, enabling FDMA-based frame injection/extraction when
the switch is connected over PCIe.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/misc/lan966x_pci.dtso | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
index 7bb726550caf..5bb12dbc0843 100644
--- a/drivers/misc/lan966x_pci.dtso
+++ b/drivers/misc/lan966x_pci.dtso
@@ -141,8 +141,9 @@ switch: switch@e0000000 {
 
 					interrupt-parent = <&oic>;
 					interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+						     <14 IRQ_TYPE_LEVEL_HIGH>,
 						     <9 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "xtr", "ana";
+					interrupt-names = "xtr", "fdma", "ana";
 
 					resets = <&reset 0>;
 					reset-names = "switch";

-- 
2.34.1

