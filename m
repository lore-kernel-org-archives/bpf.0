Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD34B66D2;
	Fri, 18 Sep 2026 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731260; cv=none; b=dF4w6kMTpeh0tXw8hi9O5aXyVYOMPthYj/j6lD7igjHuOsqre4uSefIOKpC+EDxvDfRVQIHfx5s3d9eRp1renNI9eR87yCfY4XDpiSqNyrd5uUTPGZadMavniOKxbD05Q5XRcdZe+senTM7HbBWrlQOW4Y1Yjyp/CH7BNs22IrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731260; c=relaxed/simple;
	bh=LhixG2fCAUNCT+8en6PrRgF6aAtHhOutp8kzJk8cL28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W3lR23P+e+LjbGjuMEPD00rEgOcEQMnbU9vaZlEhYJIwodIJUQESUXh/nZ98SgwAuCLNMkmbyWlELDasVHUR2Z5Tv7SCJTRwlomLZL1lsu7tKe5pvGhQshGhGwyvMQvS2rk5ejApIVEIFbFBzm0xvS0AVt+TCGCaET+fz6tBi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X94jQLDs; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X94jQLDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789731257; x=1821267257;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LhixG2fCAUNCT+8en6PrRgF6aAtHhOutp8kzJk8cL28=;
  b=X94jQLDsqjVcjXfMi619Lgnw7LrT9XPnBjJD1PBshqWy5JKT4r0qhGyT
   hTleeeDPXHVkWN10CikBtO0GFsz3I6uYZyvV9PhYYNG2FJnoBTVPuk5Ig
   s7SLHfbiQwe617z16/duKJwxvjf1jyQqNNsLtSXNInpG24QRzcv5dmneH
   yWJ0l2eOYvSwc0uciKtR+q11h2VDkq2VziqBB8yZnuJKkcO3J2zRR2KZ8
   i2qXORtGsvBKokB3R1QpLonuEo9decVUJgatO2qLCnpRZiloWyyfhzhOh
   4Ayrw2yY1LMuFKbw6pDk8ixpg7eLmBacjq3NLQjcoq1Buoeui05rqQgxy
   A==;
X-CSE-ConnectionGUID: dg8cqeJqSmOc+EtBdo31DA==
X-CSE-MsgGUID: KN83PZ+MQK2vb0B5phUZeg==
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="62877995"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:34:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 18 Sep 2026 04:34:15 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 04:34:12 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 18 Sep 2026 13:33:53 +0200
Subject: [PATCH net-next v7 01/14] MAINTAINERS: add FDMA library to Sparx5
 SoC entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-lan966x-pci-fdma-v7-1-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
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

The FDMA library under drivers/net/ethernet/microchip/fdma/ is shared by
the lan966x, sparx5 and lan969x drivers, but is not covered by an entry
in the MAINTAINERS file. A subsequent patch will add new files to the
FDMA library, so let's make sure it's covered.

Add drivers/net/ethernet/microchip/fdma/ to the Sparx5 SoC entry, since
I am already listed there.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..e41d4337136d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3214,6 +3214,7 @@ M:	UNGLinuxDriver@microchip.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm64/boot/dts/microchip/sparx*
+F:	drivers/net/ethernet/microchip/fdma/
 F:	drivers/net/ethernet/microchip/vcap/
 F:	drivers/pinctrl/pinctrl-microchip-sgpio.c
 N:	sparx5

-- 
2.34.1

