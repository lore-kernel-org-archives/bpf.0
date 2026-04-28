Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA944D6A9;
	Tue, 28 Apr 2026 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381676; cv=none; b=DsEX1hUEVhopToHRLSlA/GwOZHgl0PolypKPwjAhJZFaWava29Az1eQ5OuMH79PZJq4trCMdfyLS6Zqk3G/jSQvoGIElQLzM30NVeqh9JZBnPGCKlJmIyFV4q+RcNyT45uZuBDoOEkyHmJ8Lq+Tans+6ziIuWHI5pjJ9mktSIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381676; c=relaxed/simple;
	bh=ngwNGPEpnChc8hiUqz809IVYoAZ+8Dv1ZWheWlcjMDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tmNGuHdfKJHerPYANRFLHihKTtg68w0WV6UUL0i1EP+Jw6ZqLQL1c1joXGtIfN92U0tKvhsUVIrAdWtxSKr+wMCCAfKZiPeD2il3fR4ET4y7HqZfWZwPGYbJpjDZF/pVQNeeH3poFNWXB/kTkHvnO9rmfIfFmtFeAExoAQHshsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=guknH2OL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="guknH2OL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777381676; x=1808917676;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ngwNGPEpnChc8hiUqz809IVYoAZ+8Dv1ZWheWlcjMDs=;
  b=guknH2OLydYF0oFEUMDJ5BkqS/LDBd6rZn+YyaOtNNLYSW0ylfoDnA1H
   lP0agPZbwX0f+aYwUcSK8O+wYgICFJRYvDjjAYgTnaAftbWdZAKkDFsao
   tPy4nKlPI4+418W7ZRW86fFSRwTMSk6WCIkQWXuc4nHSo/GITo/L4t+3C
   78vMFla93pO7BwabMx8lIV3FxDyktCSLt2lBPpiWcad6CaHaR1H5eqP81
   pTnfMUbABilL0zqknLoYiKUEq62BIe0UUoyc1Zzow9WcaYoJ74oFZjEx+
   eBsx+bphtfGDFpdtawdrSBQSOXKcb5IwWLRB8iLojbD8uAuHrRxn4F3q3
   Q==;
X-CSE-ConnectionGUID: mG9mwEjqQ8GAKlCYsY73RA==
X-CSE-MsgGUID: hPWJDXCVQ4Gg+kY3zI9q5Q==
X-IronPort-AV: E=Sophos;i="6.23,204,1770620400"; 
   d="scan'208";a="56719893"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2026 06:07:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Apr 2026 06:07:54 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Apr 2026 06:07:50 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 28 Apr 2026 15:07:01 +0200
Subject: [PATCH net-next v2 12/13] misc: lan966x-pci: dts: extend cpu reg
 to cover PCIE DBI space
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-lan966x-pci-fdma-v2-12-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
In-Reply-To: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
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
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3

The ATU outbound windows used by the FDMA engine are programmed through
registers at offset 0x400000+, which falls outside the current cpu reg
mapping. Extend the cpu reg size from 0x100000 (1MB) to 0x800000 (8MB)
to cover the full PCIE DBI and iATU register space.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/misc/lan966x_pci.dtso | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
index 7b196b0a0eb6..7bb726550caf 100644
--- a/drivers/misc/lan966x_pci.dtso
+++ b/drivers/misc/lan966x_pci.dtso
@@ -135,7 +135,7 @@ lan966x_phy1: ethernet-lan966x_phy@2 {
 
 				switch: switch@e0000000 {
 					compatible = "microchip,lan966x-switch";
-					reg = <0xe0000000 0x0100000>,
+					reg = <0xe0000000 0x0800000>,
 					      <0xe2000000 0x0800000>;
 					reg-names = "cpu", "gcb";
 

-- 
2.34.1

