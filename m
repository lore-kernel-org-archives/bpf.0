Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080770818;
	Sat, 14 Mar 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481255; cv=none; b=ZQScEvBHs1KtwXadHGGFg4APKpoy4ny2z2omlVo904gJvvqzmS3TG+8kaaKVpbprdATeRtcp+uBl4mqgrXh1f6wt1qigWf+20iuc+mpCtdVx1H23avdFf/SHMGQ4qxBz4AurqkqwuBMJ618AdPUtk0H0LmnA7+qFZfbs+yPQ2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481255; c=relaxed/simple;
	bh=tapsd7sY+iaJfd5ufSW1IAp2nbsWh+HpxFDYsUl0rLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mneq5qwwZeiuitgiBzCvUqthERzmXuKN+QcLCUJh+jySf5bHK//J7qhM8KJLK5V2Dqd+I1zLGnYSoZb0fuIkJ2nwWGMIC2Q5WNkdop1shm8oL7lVGpOhzC5C/FdoeeMegSEZe4IlNVkLYb/+x6gYBWh4fM8yVmryS8KYlDepO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=03V3inru; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="03V3inru"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=giw/FPcMzl3MM6EQUmYxXJkdtyw1xyqeK51ftMdqupE=; b=03V3inru0PLoJXwGQMDfz5TK2v
	BpL62WmfhgC249rMgbEau0fi+HCUclWJL5+iPmbzp4qMEIzJ68VQKtS5xm6HcJY9cQLnA1dJ/Ypbo
	9eSYCgQHavUv21avLBPDm7gdSc5P3YsOyL2IZmmLGgA0CD8r7ZMl/JSY02qkUfKP348laAEUBqeZj
	XS2bgi+LJDD49LMElN54zuD+YQop7obZ8p60i2+A1ZZ0/YsDrWTGfxTSO+YdC1462gJ0WHQCRCtUb
	B+NO3bmYdv0eA9vPdXlglCKC37IG/q21wkE+fwZKcBq+jF19cIdqh3mbA0djmX7UvICOaU7MsREmD
	+aJ9Yl/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46212)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w1LUB-000000001zP-2tES;
	Sat, 14 Mar 2026 09:40:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w1LU8-000000000hS-3fbY;
	Sat, 14 Mar 2026 09:40:40 +0000
Date: Sat, 14 Mar 2026 09:40:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v4 00/15] net: stmmac: clean up descriptor handling
 part 1
Message-ID: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Part 1 of cleaning up the stmmac descriptor handling. Rearrange the
struct stmmac_tx_info to pack better, and introduce helpers for
duplicated code handing the transmit and receive descriptors. Remove
unnecessary struct members that are only transitorily used.

v4: merge fixes from v2 into correct patch (11 not 13)

 drivers/net/ethernet/stmicro/stmmac/descs.h        |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 458 +++++++++------------
 4 files changed, 197 insertions(+), 273 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
