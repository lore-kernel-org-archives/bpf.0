Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9042E42F;
	Thu, 24 Sep 2026 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279870; cv=none; b=rqA2vpFdBMFZ5eOjbHUH4aJ7bfJurIy8SaaO9LmCl4hyl1xS2vVNdSb6BabZY6KQiYR+gaOdv4YBaeT8ExovrSEDCEuUUvueU1zVmxUFSHQpgZxUavOo5nSAfIezp6kJpkM6C6UwanKHbf+g/Cuoy1353q9JecaE42XFRLbnMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279870; c=relaxed/simple;
	bh=y0vF6b41qbK3wylCJn2vV8VV9O4lTAJzwOWZxknr6bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kbEEppd+1VXsfudPesZkwUcHQTIhQMOx+mbx/45on+OBii1idGhdTCsSSUjbVJpc4UfSCT/PSTUKunjAJ8SRNYxlPLFgKIbv/bevxRWyZtSk4e5jDtx5bqh/uVaAzJkY4P73C5+gPIHdYfoznZcY9B7dwgmB/qt4DVkgkf7iwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vHrJo+1S; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vHrJo+1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790279867; x=1821815867;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=y0vF6b41qbK3wylCJn2vV8VV9O4lTAJzwOWZxknr6bc=;
  b=vHrJo+1S0+Q+zseNgiJnrs2VZ3T/2EFkDzarslQFZMv9p8tGcJlRP85m
   TR+nc57O9rAMdr/phQwB06Y7mjvsBmjn9wYGyFbh4mw8cxmTDgE9+yc8x
   eKojMLdgqhaqionmYH9mQaGS1yWre1ZlXM+mvnJ0g4DN2RBCObGUz0aBq
   2nzJPyiKVq199YzjYYCCVRGCg/3dpkMMIBb3JYnovbx8rn1T55yjWMXpP
   rseLAq1pGtI/viY8wRYvpN0EqA/naNYPSAIKLRqn5tVdG7+ccoGwshUfA
   JcKXtF1qthVxUx5FbUD/5T+cTH6uhaeczp61R9CclC6hQGMOrNqdTAicV
   Q==;
X-CSE-ConnectionGUID: VbuQ8EQsTNe24HDwSI+PYw==
X-CSE-MsgGUID: BtH5oc4PRL2Y6rxMBv2GYw==
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="295533222"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 12:57:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 24 Sep 2026 12:57:41 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 12:57:37 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Sep 2026 21:56:57 +0200
Subject: [PATCH net-next v8 09/15] net: lan966x: clear FDMA interrupt
 stickies after switch reset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260924-lan966x-pci-fdma-v8-9-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
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
	<mohsin.bashr@gmail.com>, "Simon Horman" <horms@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

When in PCI mode, the GCB soft reset issued by the reset controller
can latch spurious bits in the FDMA error stickies. The latched bits
sit in FDMA_INTR_ERR until the FDMA IRQ is requested later in probe,
at which point the handler fires immediately and WARNs.

Clear FDMA_ERRORS, FDMA_INTR_ERR and FDMA_INTR_DB right after the
switch reset so the FDMA comes out clean and the IRQ handler does not
see ghost errors on probe.

The clear runs on both the PCI and platform paths. On the platform
path it has no effect — there are no spurious stickies to clear — but
keeping it unconditional avoids a PCI-specific code path here.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 6e6c08bb8eea..259d81e75907 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1067,6 +1067,15 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 
 	reset_control_reset(switch_reset);
 
+	/* When in PCI mode, the GCB soft reset issued by the reset
+	 * controller can latch spurious bits in the FDMA error and
+	 * data-block stickies. Clear them before request_irq hooks up the
+	 * FDMA IRQ line, otherwise the handler fires immediately on probe.
+	 */
+	lan_wr(lan_rd(lan966x, FDMA_ERRORS), lan966x, FDMA_ERRORS);
+	lan_wr(lan_rd(lan966x, FDMA_INTR_ERR), lan966x, FDMA_INTR_ERR);
+	lan_wr(lan_rd(lan966x, FDMA_INTR_DB), lan966x, FDMA_INTR_DB);
+
 	/* Don't reinitialize the switch core, if it is already initialized. In
 	 * case it is initialized twice, some pointers inside the queue system
 	 * in HW will get corrupted and then after a while the queue system gets

-- 
2.34.1

