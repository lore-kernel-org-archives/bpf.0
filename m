Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F151356F;
	Mon, 28 Sep 2026 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624042; cv=none; b=MHcji4n9sc3oZa5ZlT29V8mLikFTAJp1afKa0oJYeMIDsJ35Gxnt7vdeyetuax16D9Zs9+pa0AGhLdsIt8Gi1zO6417gt2AU6Z6OWZU26KaRkA2OMEY/6OfNgvUR06GrhiTGlONTkdwp50r2OUSzabddhxlG0fCupDAh1mxp6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624042; c=relaxed/simple;
	bh=f1Jl7ARCrnbvOaZkK/LjDTX3tw1/5r96ssNQoJplEUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UnF9yqxO/FBJym5BCpasehW6w/lZh5doXMgtAw7/ipqw9JaKmQVIfDnORyjETrZTWcaimZiwbkBmISuxCvzH9SQex35SF2KPsujiINMZvZHSvlc/ImS8NGdNTjEzlby2mLoQ4oYAeBlz3BJlaH9bFPVJDljX9FJuwhxgEwPCueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=II82ZhOV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="II82ZhOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790624040; x=1822160040;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=f1Jl7ARCrnbvOaZkK/LjDTX3tw1/5r96ssNQoJplEUQ=;
  b=II82ZhOVggz0YTprPyYiGPy9RcTcNHUrf+ROzY8SJiufjRtPf7ILvIpJ
   95bGw2eEBAxrdLlfuSRFcFOB5fVHPNOKUmYXq6LpYNitDqaxUfjxakox+
   /IlaT20K/lcl7gg++NbcqFnfx8hqABuRUHzSYZF5AVPbzx89KU+kdsCUr
   CkMoFxLuaL+w5gCysecZ8MLdRuzY1pKiEQQbkY3IXUpknxgo9vZ/NyAdv
   xIhYEZvwXDihlGdY3y0SmisC9tWzUtULYgOKjzaVVBGFndTvN9xnlOcNj
   e23yN7L9NbuQApxWUzOatv6YrhSRHgovdaD11SYbSviPh0J/2IF+5N2Vj
   A==;
X-CSE-ConnectionGUID: bG64uvDkT3myQSAY+44k0A==
X-CSE-MsgGUID: sKhYwI4CS46B5rS8+iJvkw==
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="74445087"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 12:33:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 12:33:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 28 Sep 2026 12:33:55 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 28 Sep 2026 21:33:03 +0200
Subject: [PATCH net-next v9 15/15] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260928-lan966x-pci-fdma-v9-15-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
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

Add the fdma interrupt (OIC interrupt 14) to the lan966x PCI device
tree overlay, enabling FDMA-based frame injection/extraction when
the switch is connected over PCIe.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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

