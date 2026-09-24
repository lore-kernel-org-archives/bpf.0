Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265632937A;
	Thu, 24 Sep 2026 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279837; cv=none; b=l01jcqep6bsDoWF8NaLz50JZvOP21SA6RnhUQVTaSjyzXKgiO0waLP6MCTq98bnMtChDxcbjCEvO4nHRYrrzMh4BXqX/UQHaX9FwVfx6SJQEEi+PN09xVW6u6r8VbTTG/6zWanDZip/tfT9UOlNanZW+Ba9EXFEBwLCsAUd0oIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279837; c=relaxed/simple;
	bh=Gn2TaEmSIG+/lBYc0ldYI+V/SltKbL/jrsFeLOUFEck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uorSGrpyKCPZRtths/HmGS9odCodccCaJE5Fp3vBC9UznrIXaGp3DqqWZY5BZkXQp/AGZWEzbpvpbSVkheLB+1aUZzR3Qr4BX86KmJ9Sv7MbZdwJ/IIZI9QBg2784J4FCNxN8xykOq5+v82vfCN8j+Bcgd5UdaELQ8MkGYH4H3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Vej73FJo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Vej73FJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790279832; x=1821815832;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Gn2TaEmSIG+/lBYc0ldYI+V/SltKbL/jrsFeLOUFEck=;
  b=Vej73FJosCuxJmFLKpA2ZjDUG/UGxWSxTS1L5uPbg1MEBr9SWLjqlHrG
   9bJyQh0bE546DqlzazKHu63qj7x23VKkrcIlT/Q1X8UQdn3edHX9g1yD+
   y9+pBFE8BHfPa4eLvyLSnSvI6Dpmzp3tSZanK6NLNzCXFFKY7wxl/W6++
   3a15ckpewExd072RgkJMj44PCELRM4TV+6BV0/8rfCeLzsv3BJdJ1xvKo
   igVzClmf/l2jOsBFwEXiKc6Z9ewshyBh4EYM+WVz5rB7ICGENY1m1CSv1
   8wGiWD2OCkh/Km1XBRGLAZpiNPHt7W/JFrI1bx/iq3J5bDamhsP05Xz91
   g==;
X-CSE-ConnectionGUID: dt19c12VQ8e4I6MEbc3qBA==
X-CSE-MsgGUID: GAV2M1Q1SI6YQ7IauS2mwg==
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="64420627"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2026 12:57:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 24 Sep 2026 12:57:05 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 12:57:01 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Sep 2026 21:56:49 +0200
Subject: [PATCH net-next v8 01/15] MAINTAINERS: add FDMA library to Sparx5
 SoC entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-lan966x-pci-fdma-v8-1-201c7b707d8b@microchip.com>
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

The FDMA library under drivers/net/ethernet/microchip/fdma/ is shared by
the lan966x, sparx5 and lan969x drivers, but is not covered by an entry
in the MAINTAINERS file. A subsequent patch will add new files to the
FDMA library, so let's make sure it's covered.

Add drivers/net/ethernet/microchip/fdma/ to the Sparx5 SoC entry, since
I am already listed there.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3ce77c839b0..e5da9d0378b6 100644
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

