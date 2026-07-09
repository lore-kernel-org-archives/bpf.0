Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BE34F474;
	Thu,  9 Jul 2026 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618632; cv=none; b=hidEKjgQfv/FSLJxbK5jIkGgHbnu0ipO8i7vLt+D2WtBz6PXlMZmsSta4pXyo2rW+qjPgzJBOrwVNVpb0m4dgyw8PCBxva36+xLuhDmQKAZzpefvE8VygBBA5rj1wM6WOKI0PuCy+yLxMqrUv/nwfeGVMP+SZuO6e1VlviNjT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618632; c=relaxed/simple;
	bh=i53kwuLke4zLIyBVwG1o/VQp4c/twqQGwmEjdRAOVRo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Smm6hx68lKDutm4SVbN5b/13O94TMOTTtbrIS8QzspdNyIB9LvjfBwzHRydrh+9P+OsXavxzqUVV3Z3KLqt9enbN1Y19+gWuYudKrwmEy+a+RXdr6QVF9ms8VBj+hU7j7o7QVukw4DbITisxyViWxXvrZVKN4NL4PIvHM9YWqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r4NyZKm/; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r4NyZKm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783618616; bh=UAyvjol5WCjgzSal4DFc+b6VlKMSnPe+L70I0ttHVAk=;
	h=From:To:Cc:Subject:Date;
	b=r4NyZKm/wHKVz7VkYYsvusqUTFk70X0+NWIeaDKaIc50pW7GLBSywtp50H10AYYYJ
	 Ls6SctumHPRfG7W5ufdzaYXYbc1jemjt5a3jC1KB3EwQi4jnuoa2T7ep+zY7e9+Fyl
	 +YVh6qSxF5iVNn2OvlMVMGdO2C90cGQA5cMC0R9Q=
Received: from halo.lan ([240e:379:223b:5900:1e30:bbb9:ee9e:94aa])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 934B325C; Fri, 10 Jul 2026 01:36:52 +0800
X-QQ-mid: xmsmtpt1783618612tnu3ldab8
Message-ID: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
X-QQ-XMAILINFO: OYTBn1rNHH7tmL/0My2SlqTxknUS7CZX1dhTLmMDZzIq0qyw98cDBHl3bojwhu
	 zfw7/Zy3LtX4YPGlxAcxABkDHH2s2wFAUta9CTkdQrInaKix+ZHh+m/R9/MOW/31JjUgGrIP+gFb
	 8zfcCc7BH1evEs8qk4Xm0/7trxx/GQN47UpKGmvWwq3TuLcSoX74RE/eHSTZWexdmIGI0VAyj3Sz
	 SyExxrg1ytqx5UKakdewM7BVc+apnNYux3htkCk1geadUcjwz0rD34E20zzNCET51cynJYfeqqK6
	 3+l8Z9x9FbnF+90L0Z6tKuUaUXAFHSrNuhD1Q77oyAwtbHWqAi88vRUpRhIZRS9MNn+6nCONUoM7
	 NuL8ZEokbzHHG+T/himRlfUQjJ0yVgVKp082NyHOyGsMnJP35u/EBxxvJDvd54Mtm+G2670AE6bn
	 t5esk9ZTr88Lh+2aYIVG5uAkImeHLO6RDFd0ce0ZjsIEi/ck19CweE0VNK6jn+BqtgYj+gBiCVrq
	 2wuJ3N2YyLu+B0Eh6vYtMyT+SeupOeuf5zhdJsvySvonzucAz1mX8ZcMiBz0sIVWQM/mN6Rk/PSj
	 GM2gYeiThES3TMo7FM3EqCW7C0NvdZ47FeGQ7zlwojicBcPu6A9bPksBaiKdlr3eleiJkSc+Ziv7
	 SiV45LshzIXk/9DVk4KRucoZ0u+g0hBxeVTb39O8eV/WhZKCgneWnK71fP/Z5kUReF914SYLb24X
	 bQ6FWncXTI2S5YtahhP/fJ4Ss3iYrDp8pJrHvqOGegTK0++ZNchWOeT/WlnfVuZAcf1wTJyuy2pd
	 hEsIyABkaq3p92WjjUHnxItV7E/jue0HSb9ruHCBePt613UVJW2yaEgF0w6vOHZ8HqC/EaG52mL3
	 ZXvWHg6ZcpBcnbwlvXO2VfwxD7z9zfVfpZfLHmV/BioQBQyqsOKwrXS+GR4uhqFgmRz5dAps2DGS
	 S+Yv3mnslqPK+62j++3ombPIUpP91xLxdM6ZJLsUTsf8aGtCZjhH4yD5Zuir1Cf/fVCyC7oCXcv9
	 rdD4/FJvacaU07Dvo9veLZQQhFyAdd/FItkRUV+18MPqWLD9VRW4HPu4na1Iv9GAQrQ4VWSq7d1w
	 NrmBq/pKuoRTKzHpINmQQRI9qjmA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net-next 0/2] net: atlantic: convert RX path to page_pool
Date: Fri, 10 Jul 2026 01:36:44 +0800
X-OQ-MSGID: <20260709173644.61978-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems where the NIC sits behind an IOMMU, the atlantic RX path
cannot reach line rate: every RX buffer is allocated with
dev_alloc_pages() and mapped with dma_map_page(), then unmapped and
freed once the stack has consumed the packet. Every map/unmap is an
IOTLB/pagetable operation, and at 10G rates this dominates the RX
path. On an AMD Strix Halo system with a Thunderbolt-attached QNAP
QNA-T310G1S (MTU 1500, TCP over IPv6, iperf3 -R), RX tops out at
about 2.2 Gbit/s.

An earlier patch [1] worked around this by making the RX page order
tunable via a module parameter, amortizing one map/unmap over eight
pages worth of frames. The review feedback was to convert the driver
to the page_pool API instead of adding a knob. This series does that
conversion.

Patch 1 fixes a long-standing teardown leak first: TX buffers beyond
the budgeted single aq_ring_tx_clean() pass, or still posted past the
frozen hw_head, are stranded when the interface goes down. Today that
is a silent leak; after the conversion a stranded XDP_TX frame would
hold a page_pool fragment reference and turn every such ifdown into a
permanently stalled pool shutdown, so it needs fixing before the
conversion lands.

Patch 2 converts the RX path to page_pool with the fragment API.
Pages are DMA-mapped once when they enter the per-ring pool
(PP_FLAG_DMA_MAP) and stay mapped while they recycle between the
driver and the stack, so steady-state RX performs no IOMMU work.
page_pool_dev_alloc_frag() takes over the sub-page splitting the
driver's hand-rolled "page flip" scheme did based on page_ref_count(),
buffer ownership becomes transfer-based, and the XDP memory model
switches to MEM_TYPE_PAGE_POOL.

Performance, QNA-T310G1S (AQC100) behind Thunderbolt/IOMMU, MTU 1500,
TCP over IPv6, iperf3 -R:

  before:  2.24 Gbit/s
  after:   9.14 Gbit/s

matching what previously required the rxpageorder=3 workaround, but
with order-0 pages and no tunable.

Tested on the same setup: line rate with plain RX and with XDP_PASS;
XDP_TX with a MAC-swap reflector under sustained traffic; repeated
ifdown/ifup and module unload cycles under both plain RX and XDP_TX
load complete without "stalled pool shutdown" warnings or other splats.

[1] https://lore.kernel.org/lkml/tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com/

Yangyu Chen (2):
  net: atlantic: free stranded TX buffers on ring deinit
  net: atlantic: convert RX path to page_pool

 drivers/net/ethernet/aquantia/Kconfig         |   1 +
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |   3 -
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  20 +-
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 268 +++++++++---------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |   7 +-
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  17 +-
 6 files changed, 172 insertions(+), 144 deletions(-)

-- 
2.47.3

