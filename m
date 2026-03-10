Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001323BED63
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177765; cv=none; b=sr/pxh7wuE7P4hOudHBr6oWQe22TY80cURGaikCw/EvAoK8nLGYnVcxogmgimAQD1cuGmGjN+JP0tPsfB//L+MW7ySpOO+t0Y85x07VplD/hcDeFFzws80khFPdytxCOiu9ErjtZoP32flAPcukqRkzX4MmAPFH9Uq/LELK29tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177765; c=relaxed/simple;
	bh=2Tsfewli6kOzAqfcjRX+wWMziPIVMge609IlrkkT7k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IiNWy7P1UpUpKpINf6t5owf9CNz7iZG6yZAZPLRtFfyn5XPyJj3dxHx3Jjx78/5/fLVLF6mSWp2tjsGMk6OR8qiTOOyT3isYRIWLeO6mSdyttw9a7oJaT5/m/lqnfykd3qoLrRbMVpdGdPFWjH5CA6MKwvVzlJNB6hH6F1dlg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kKkUKGOQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kKkUKGOQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aea68839a5so2409845ad.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177762; x=1773782562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggoVKtSKOc3N38d3zUE8ZE7aHfSiZIatc4vpDvMzCD8=;
        b=kKkUKGOQYCLRmYHkGLT0+lKG0VuOINw2LtMWynK9Gx6d5DOtgCSPEeXqlwzCyFOLSn
         U7Gw4zj5CCNsRw9mnVYnNiFyo6htJUBO3JO+BJ3qXVRSzeP4ORh0/4sQx/x6eRE/j0EV
         QpngqtJxeLnT0h+OXPRKBaCpezGY8mff3GO086z1v0C4Z3edYEMQ37e2tPaGAPMppI9e
         S1RaerE+mr1lP8NSe33ye78dmT+P3k0sMObVeubMd/x9WOn5Rx/Rp6gxVRLIkralJ9Xg
         cjH0icMbgxHe0C1fGacFQUGFOzZZthfbZpoQZa6o24/twfrgYHhxxSOMPKwusYXrsjIt
         /F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177762; x=1773782562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggoVKtSKOc3N38d3zUE8ZE7aHfSiZIatc4vpDvMzCD8=;
        b=l/XVGfu2i3ZVFf4xXTqf+G8Y8csJs3rwaIfCVJ8B5tccdXrTbaDeRnxWtxcNssyHob
         gie9WXyyP3rT7vWuTTrEllje3Hwiy76BsTURDj+hcYpgtsJw3MJKZ5dc2X6bHqLGwcTO
         01tC4aAWyK1rYYLmonQUU+LS9UltHlk9hEa8CLwcG2AjhGeq4ALt3UFu07Qiz/7P2RII
         HfanCsH3fpLRZWx4jBsDjKVVpS04Ntf0/HszZz0q1Y5oIA47lJnR/fBiU7zQEa1VcO8y
         g8LMuQidZ/A9z/AIwY2KHZeXlFuVb8TA68vK2/gAw8hCWWZFx4kK1jhZoLp/MCMoYzu2
         DajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRlQBrH+l4DAIuwRHVIZKDeL9tSAsei8dxT8pEqQZp5zXAfidVd0CGqR2hL40rvuJIH3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5Z1AK5bWXWPcrQAKoDmSzeiykV1Z3IXUIJxT1xQhGjPqel3t
	A6AvIPmwDK6grCj3wuXVQgbfZoZtNhqB+ev7UhXlreEymkNH/SlJ+Mv4fu7/KDfnEto=
X-Gm-Gg: ATEYQzx739W7RTMj4cjqnjhw5PuKTF78QuyeCM/56cWs//N7WZMPFFXa0HBmL6SZ69d
	BzpSrqgH4Ppb0P7YaVmZS5NhIuINh0SOuBowOj0no3BiLp6/ACjnWB5NEDXNZCaHfdePbhKJoco
	2ciMXajkz2H4NjDBfMrIZfhwtLwkx/i9oUZIxFmd0ZV9RjCJahFa2ZPSwfSEvgQCLk9fcxc6kNG
	SRDvk8advUOZaJ/RpI7Lwp583eXoObloZXlXUeTZlb0AZxQuxOai4ONf7Ky13bFFVAAEtC8lE9O
	kUNqVGdm/UOjV8u6Uf8Ghm3TZa9bUpKlCijfelPcReefHbUWYB0nCZB9uFIUv4jxC/f1ePo6Gjx
	SXm7SnXPpRBuivyAsqcyUHO0AcnXN2b8cZDS3JXvoUAH0kh+o7tE6sRxq5j0K0L2wP4qgLThPCE
	9VX9BhIMdkRfkL9g==
X-Received: by 2002:a17:903:350f:b0:2ae:478f:2ef with SMTP id d9443c01a7336-2aeaed1ea80mr1249475ad.28.1773177762359;
        Tue, 10 Mar 2026 14:22:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae246fe5sm2091485ad.28.2026.03.10.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:41 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [RFC net-next 00/10] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Tue, 10 Mar 2026 14:21:48 -0700
Message-ID: <20260310212209.2263939-1-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This series extends net/tso to add a data structure and some helpers allowing
drivers to DMA map headers and packet payloads a single time. The helpers can
then be used to reference slices of shared mapping for each segment. This
helps to avoid the cost of repeated DMA mappings, especially on systems which
use an IOMMU. N per-packet DMA maps are replaced with a single map for the
entire GSO skb.

The added helpers are then used in bnxt to add support for software UDP
Segmentation Offloading (SW USO) for older bnxt devices which do not have
support for USO in hardware. Since the helpers are generic, other drivers
can be extended similarly.

Early testing shows a ~4x reduction in DMA mapping calls at the same wire
packet rate.

Special care is taken to make bnxt ethtool operations work correctly: the ring
size cannot be reduced below a minimum threshold while USO is enabled and
growing the ring automatically re-enables USO if it was previously blocked.

Thanks,
Joe

Joe Damato (10):
  net: tso: Introduce tso_dma_map
  net: tso: Add tso_dma_map helpers
  net: bnxt: Export bnxt_xmit_get_cfa_action
  net: bnxt: Add a helper for tx_bd_ext
  net: bnxt: Use dma_unmap_len for TX completion unmapping
  net: bnxt: Add TX inline buffer infrastructure
  net: bnxt: Add boilerplate GSO code
  net: bnxt: Implement software USO
  net: bnxt: Add SW GSO completion and teardown support
  net: bnxt: Dispatch to SW USO

 drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 159 ++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  27 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 188 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  31 +++
 include/net/tso.h                             |  45 +++++
 net/core/tso.c                                | 165 +++++++++++++++
 8 files changed, 601 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h

-- 
2.52.0

