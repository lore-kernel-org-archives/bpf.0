Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5A56511C;
	Wed,  9 Sep 2026 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958858; cv=none; b=M7MlA4AfFDBId4xSBgVKgZGRo0wgim0utSe48QZlhvNxi4+gjTL4NP9HVZant4F75kfdzFUkmXXMFGJWAyOc22wOdexlE12s8l5tY93sWE3Mqf4+yn816ZL5vVFJW376bIaT/NzfPfPGIuXJeH4ugSN0S5wqdSHiRCvwXT0uEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958858; c=relaxed/simple;
	bh=rVpMMDlK7E+NlpQ9MahYaWBp6KhJAh4OQm2tWvl9qOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J7U8uHzW2UULnRySNhUirRMvHKChdIxp4R8zAJldECcJiklZpjuwW/ek2/xWkXOj0TUPN8WK9GtRAvn+ALexkKyhQZ2DAF4gEQ0g3OGSJ+xcoTDN9d+hGD9WS6xje+DR0Z9QDIUnEoVjZEMWc17R4ixA2KzJ1VUnZyPL0/gpPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2FkZwUvF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2FkZwUvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788958861; x=1820494861;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rVpMMDlK7E+NlpQ9MahYaWBp6KhJAh4OQm2tWvl9qOI=;
  b=2FkZwUvFokaV/y4QWc7Evpa8JdChZppvjZ264DV9iCf4qLi8SQY0O7ur
   ML6zAq0lGbK/RPuY7zhditc0DuEbrWk4ZNv4rSL/rjgB7OZfgGvNdvwJR
   O0VtjTJqqtzUuSrFbpm3Wf7MJbjGp0w82lIdMDrJonDPL7l+Dk+x+7JN8
   Izkgj5eGaRK5u/Gl3wc1NHH7EsEtBcoRmYt5UkF0nOTmksZpJK9KJHYf8
   f0HTwo2Q9VBHa5DDV6V8gEQjA7a1sfcdfyuRZ9WTaj0YHrofDx/TexeGg
   Zi6Y6hSjDbNmAg+TJzE293ydss3gRVcU5TDffsF6gF+Qo4OsOKfWgrbT6
   w==;
X-CSE-ConnectionGUID: wSoHObMlRVyHWvIVKL+mDQ==
X-CSE-MsgGUID: OvS619mMSi+yHy3DRCpW4w==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="63658691"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 06:01:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 06:00:55 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 9 Sep 2026 06:00:51 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 9 Sep 2026 15:00:10 +0200
Subject: [PATCH net-next v6 08/14] net: lan966x: clear FDMA interrupt
 stickies after switch reset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260909-lan966x-pci-fdma-v6-8-6f48dab9d671@microchip.com>
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
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 6e6c08bb8eea..11094a381ec2 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1067,6 +1067,15 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 
 	reset_control_reset(switch_reset);
 
+	/* When in PCI mode, the GCB soft reset issued by the reset
+	 * controller can latch spurious bits in the FDMA error stickies.
+	 * Clear them before request_irq hooks up the FDMA IRQ line,
+	 * otherwise the handler fires immediately on probe.
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

