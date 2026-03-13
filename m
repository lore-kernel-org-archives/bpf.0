Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E83A1DB
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441036; cv=none; b=kQqoD7WT3W1MKo68uLjW3+MRNXzYmvrArFxSAxroyTBfk/6huHKK8ZjLYz5BSx1sQJ8Zx8KRdGhl/Gf92066jlAgVVC2yoVc2m09cws62QKGn/WfPjGDWPb5aYxaDFOV4G8XfujJ+X/kQe4ut4zOXkhFHL/I3cREs9mLZWiEFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441036; c=relaxed/simple;
	bh=OSIhld/8cPmcioyVfZ926MRv4gb50JYRi8mjnvQAO74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRpfpsTgDR44aC34rZRwy8xfyIn8jKrzhB/SqYPqs0+equflPhZgp6mxxlEEXfFf0QEhoiw8QKGxjxJeE9p4XcOLd0hc4/ZsNR5yon5lEmQCsO0mOt/6pdZ1fnYlMAwkJNyorXKWsaLp1YQDWy0rzQep23G6S5wANn4b8s0uCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ff7n9r/z; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ff7n9r/z"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-466ec4c6852so1743586b6e.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441032; x=1774045832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4YrcG7dyAIkvfBnIr5QQD0gb9f+0O2huZFQNopL/90=;
        b=Ff7n9r/zr+VKvyUBkUT3Z1vF/0Vy1YOUjtixiRJRd1gKvFRb08+KROWBFvvIOqyKiA
         pM+JwvGlV/4u1uei202IMCJyYKUydAojOzYCBxLc1MSLRdCF/qwoQbzCUc5Ywq4JMPvY
         EcrI/x+5enAu/3KfcsZwPqR8Nhzb5+qCnSsZVheSaHOeQrb7DVJGiPykjXvV9QCxSKGP
         UJ9gibFE9AJHrvSd5j0gdbug3qeg/cDK3VEwNrTCyewV6rvWih1x9LBAavSP9xNhMxPP
         TsP5Bnlj1bv9z4qD3mvV5fENjHU6IgXpjtHVmnaZhv9iAmSm906O1NYITYqJE/pOJNkg
         4VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441032; x=1774045832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4YrcG7dyAIkvfBnIr5QQD0gb9f+0O2huZFQNopL/90=;
        b=Tk9eB3rCCwf4eaAim0oQJJJ4A6EYSEeAKNYQ3TZjRJAexI/hXlW4R3zht/mgs5PdUV
         g7ulGz2QpOB0U0Ax6238bQmjUL8wpk5Kj2RGhFC+OK2zBnpbgK1BMf5skQioZhjcjuCy
         EgWwscmutH9VCcAyk39ei2UZMp/7e7G6WsD51KxqymPePh6P/7+amjcLxBYqyqWP/mGF
         ADdZI+p0/WbasFWAuBk94UzqhnRRR8rNGr+r/fC+ICqUdinJ+uoyxxWQvqNeQBIv8Myd
         t/GnYF2ohzkqd9vZv2WH+mk4aIHPbh7A0yH2VDuQKIwHuN+C296RUpu+Y94VSFHk4oyV
         ZQkw==
X-Forwarded-Encrypted: i=1; AJvYcCXDk6SmKSJcPX3czsaAwG6hKg2aOP2zESz5/7mFM2zJuzvV744Yr4KLDJI1XF6hTkKxY2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oeLKxUDrVYnNwEY4aEZPmxeoxltNx7DNBZIBo4RSoQVyU+1P
	OoXRIpWToOoYKQpKdGeN5HYfUh/dVe5MFmEYxqbMt1WIBQ8bTPWiFD42mDXM7zrt1Ow=
X-Gm-Gg: ATEYQzwNN4f4oWTB14E8/S2XLejazr+/+cEOox/GGg885bVEUaK7+zpDq2MOZv6b+yR
	yZXxx/KtZcUvYR/CkXrkAYYMw507b1wRocqrnGvw3oc5IMv0ts7RdAHViUmbDTtUoTBDsc07CvN
	cyF/c7TQJdp1Z9yl97JnnIECiJQmAdTdZbFvZmNLgYTwbV8sSrdNjPJh1H2IhWTxwSOSTH1sTHK
	4sqrsv6tIppIsROVWUiYHv0xbVE84KU952TJ1CuLfk+yDZLMh+YBNHfghH/HT+jxWwBjxILs30v
	JB5cG/FwySRGZbBIAjxS8J/339W9EonvbXUX5cQv+AtpjMyWJAQbFhouBDjbux21ML5ybRafm5D
	nos0NSmM57mhDWrn82KVGf18FFC3IYArwb/KY7+DWOKWbUw3Eo6c2jB64OBzjfoT+t4oGLISi7W
	GYVL67P482
X-Received: by 2002:a05:6808:23d1:b0:467:15ad:9de5 with SMTP id 5614622812f47-467570a27f2mr2598220b6e.13.1773441032469;
        Fri, 13 Mar 2026 15:30:32 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:30 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 0/6] bnxt_en: Add XDP RSS hash metadata support
Date: Fri, 13 Mar 2026 17:27:30 -0500
Message-ID: <20260313223029.454755-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds XDP RSS hash metadata extraction support for the bnxt_en
driver and includes selftests to validate the functionality. I was able
to test this on a BCM57414 NIC.

Patches 1-4 implement the driver support:
  - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
    pointers to the hardware RX completion descriptors and the
    completion type. This is similar to other driver implementations.
  - Patch 2 adds xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
  - Patch 3 moves bnxt_rss_ext_op to bnxt.h
  - Patch 4 adds handling for CMP_TYPE_RX_L2_V3_CMP completions

Patches 5-6 add selftest coverage:
  - Patch 5 refactors common BPF map helper functions out of the
    existing xdp.py selftest into a shared net/lib/py/bpf.py module.
  - Patch 6 adds an XDP metadata selftest that loads an XDP program
    calling bpf_xdp_metadata_rx_hash. The test skips on devices without
    xdp-rx-metadata-features.

Changes from v3: https://lore.kernel.org/netdev/20260306230600.1628196-1-carges@cloudflare.com/
  - split out bnxt_rss_ext_op into header
  - address RCT issue
  - rebased on net-next

Changes from v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
  - bnxt xdp: actually fixed RCT issues
  - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.

Changes from v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
  - selftests: moved tests into net/hw
  - selftests: fix pylinter errors
  - selftests: add check for no error count
  - bnxt_xdp: followed RCT for variable declaration
  - rebased on net-next

Chris J Arges (6):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  bnxt_en: Move bnxt_rss_ext_op into header
  bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  47 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  19 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  57 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  95 +++-------
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 12 files changed, 513 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

-- 
2.43.0

