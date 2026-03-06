Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47FD361DA6
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838390; cv=none; b=W2DOIEQ746kRNxiZdGOS4lLeCcBhXZxOjbi9cGRXSAhuUSZb0busFEEQ2psI7mhsjIr7mSADsJJY7HCy73yQDFMfM1oFTF4ihlv0F0NqaCn0WfBuvNPtaTrmQ07W8c2iCpuR4cJoOGItZrTN/UmV/arbYwuA07LBj3n+Ml7s/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838390; c=relaxed/simple;
	bh=V460VK906BFezr6jgbTYjUJbrX6GtL1cR6J9HZk3gVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpTlyEpgW6IXWEWEVrTFBRe5/39Vdn+QikHgLj5Y+kKw0M33XHLoV9w0ceSgzRC9mot7NUZh/xRuCaPDEH0n/IzSHYXIAD6RZvnnEh3HRBcTGPf0OpXbiwS9ZqpHEkvWWroAaqkw5nuFth2j1VAuwlzbp0XpvWTpdonckApuWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dUafYy9B; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dUafYy9B"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-464bba3a9easo6511440b6e.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 15:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838388; x=1773443188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgiXl+17uP8yy0lPJ2n9iuC11JFgZbW986sK6b5v3mM=;
        b=dUafYy9BUHCWR2RhpQnpnnymAj72wnl9OkMaug5QPVnM6d8Gw2y8T5zHWVIQ+vXNBa
         30FduFkMpaSbxnirG8g/qDgnnEyOOC8jl/6pSY1zvdi5d1MYSmcQFpkcNSNs8qIy1bSD
         0gVF7qWsZb70xZvaojOCMTNL8kFDGkMSXIaqNn04mCd7v/I2o56ejObDMozERrucYXDi
         1K7D8QfT27vh29m5+py9zC3xTwMxhEYPZTw9N7SDnITcjat3l/3RBb/rpOIBCYIYpGdG
         iYQtDjXNaOHJrVfOAAOCnqBRKYbSldzM2/qfos3DPdeHqYF/LNkOr4eLPAoDLyD8j14N
         IvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838388; x=1773443188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgiXl+17uP8yy0lPJ2n9iuC11JFgZbW986sK6b5v3mM=;
        b=XoJ71CB9cJpmD6aen11X8T06mgPwdEouHmRGSynF52880kZy8ulTIoV5lmnQdjeT8d
         s87iKn3Sa+ebDkWX0HGeRD1r8N8Z4ZhJKhtRjwPA7hJvD3BEdnb6Vd4AFTmNWkvhXgEI
         9vbwKRI/Zhhoaj4IMzYIGYJ/uS5GXpD0VsaIUmWSTvm5bnLDJzrzGiqyTA6i7l8Hghtk
         JSscNJlModPso5jzpPAcQrh/RiZhiV55h25ao4HOXtlZ0oGQsJYN9mHYPfR9ShR56q4u
         mPI13isV+YZjHXQy1Oj4eW86pwtZyFo2Z27pQuh6LKa2DVvM9drbHESSkTc6g85iGBgE
         xGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVlVXeErz29bON2KRmwqu+bWc2Jz49mCBJElxKhk04WP38eZJDopBdlcyC1F2e96iMieas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3Hmn/3hk0AzWrb6KvyaJYvy7HFh4k/gYypryiOO/nRsUE0zG
	xNCsKoJ1mqwOB+EOy85x2ozt4zu6yqyAIl0x6n8x8cElwgbiv2h8g4f1Xm50qHSime4=
X-Gm-Gg: ATEYQzyVGCLuALcBOieRCWkLRgQ4qvNvfRn9+ZQsoYbiRVEQ94wiaI9r+/h48IdkF/B
	juLNVXtSG2g+prcQQxZzLMw0KpC3dq75M3GFKDNoqcyRr4apQwvQIOZwp9iU2VbvzDphYlKVoFG
	TnG+Bb2h4xQYtqT8cUN7XQ90nIGi3uW8GtYM3z8WNEqplIL+a3OTBVfFnCaxgSB4tvqAiGnNEhJ
	QFdq4vrAYoPV2tia8Qb5/FyPKylCKrcokMa++rcq9GITyPfR5WIlZKncmg/M7Jh1scqB/cZin6V
	KPOTJ4uJaczbIFgFfdm5hEpjpQLL1SYZ9Q19/UDvjI5UqoTrXubwfiaeo/LzxnI9wDdfk4Wmj1C
	NMN5qOBPC+jRzGbXJEkxWLiZap+52GXQOoFojaZVVl09EGkXzer6OH11k32BJJYnvHsk9tj4UrO
	Dsev0Nto0d
X-Received: by 2002:a05:6808:3a11:b0:44f:f747:f9f with SMTP id 5614622812f47-466dcb1c378mr1987332b6e.36.1772838387694;
        Fri, 06 Mar 2026 15:06:27 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:27 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	joe@dama.to,
	kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 0/5] bnxt_en: Add XDP RSS hash metadata support
Date: Fri,  6 Mar 2026 17:00:15 -0600
Message-ID: <20260306230600.1628196-1-carges@cloudflare.com>
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

Note: I don't have hardware to test v3 completions at the moment.

Patches 1-3 implement the driver support:
  - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
    pointers to the hardware RX completion descriptors and the
    completion type. This is similar to other driver implementations.
  - Patch 2 adds the xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
  - Patch 3 adds handling for CMP_TYPE_RX_L2_V3_CMP completions

Patches 4-5 add selftest coverage:
  - Patch 4 refactors common BPF map helper functions out of the
    existing xdp.py selftest into a shared net/lib/py/bpf.py module.
  - Patch 5 adds an XDP metadata selftest that loads an XDP program
    calling bpf_xdp_metadata_rx_hash. The test skips on devices without
    xdp-rx-metadata-features.

v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
  - bnxt xdp: actually fixed RCT issues
  - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.

v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
  - selftests: moved tests into net/hw
  - selftests: fix pylinter errors
  - selftests: add check for no error count
  - bnxt_xdp: followed RCT for variable declaration
  - rebased on net-next

Chris J Arges (5):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  67 +++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  95 +++-------
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 12 files changed, 506 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

--
2.43.0

