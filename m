Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26C24DCF9
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214132; cv=none; b=ker5BwCNH8ooUxqaNs0qZD/of2r+PFmgYB1thuPoiNySUtcddlU5jBrHLKcAXuhx14Hqz8ni4wPvlw9A271K4qeA/kbw4+F82S7JICKAVjwSN323BkmLwYiN6crBjzYllNQrUViwEOaskq4HRAPRhygZFHRyRsRzVp8QRnOU0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214132; c=relaxed/simple;
	bh=wlYJNHp+EGFmqiim3z8wdiqCaTuHFQeVOxxyb01uGJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvAYxE3evPGHhlijiL5YkWtW+9PGJYLVVPy0ewRjcLDv2IDdwVdiK+I5lsf+uBrRVa4tHWrUcoit+qfMkNRj1roSxqUWtl22VIVGEQvwBhkD3Ln3vCwmssIy5LKopkAG8GOO3VNXzNvLuRFcKPVSFsGrEwgZeqNUKpqHR7ktGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Tmzbm4wb; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Tmzbm4wb"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d4be94eeacso1935144a34.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 09:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772214130; x=1772818930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOSTTPOtp0HFguKQvmsnkWpDGw1Tid3aGCL4G0QCjjg=;
        b=Tmzbm4wbnoEaiwGqIt/fNScNMP/ZUZt3b1ML+PGErH0E+20pLjIWx8snqaIiqf07MM
         ZzSTYE2r27iRMKgHe9r2kKPmPZRRRS7TlF0BoB2owreUSVHn+VT6crfz1YHv1dqywxzS
         Yxr5Yuv5LPW8FSpu2vl2VlFGUBRhRuyz1uBoCs1sZCr7ABWhkFUpmsHOB+N3yHp6YLq4
         bd9XI6lU0chV9nwEEIIzuSoMF2gMz9fKYJb4ZYCoBKY511A0pyQzRU95fTj1JqVm9062
         EXZPaKlH93MmhhDYpaZ8yI0zLhf0SHrZ1DamHsBTOmgQJbcWDw8ZMTkVrTHZwhQHtloB
         TfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214130; x=1772818930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOSTTPOtp0HFguKQvmsnkWpDGw1Tid3aGCL4G0QCjjg=;
        b=upK7maX5yHV1LLt3JkDdHbanDSkTDczvjnzakIYVgHgOLbDp8wmxY+UHUIxcTN6N1x
         HnJOsW2XIJoAsu390Y1Z+S9ZtWibmxmV2TdHavopsBMs0aSzyJ85d59ghGHHwBatRfi2
         vQnSoZKhKiAqzTnEqX19O8dV10YBi/+s0V1Q+kSxwc8Q219hxr68ndUM1gJ+zQoOSpg9
         4Wo4iTT+M2b/pxffzRW5uPFV6EDVVCEBQyFywtst0fvaqbDAuC3pJ12WBGFNQnhBqwpp
         uHOM4StPvVNr55kg8g990+bfGgqdZDr/AnVQvj3bu2oTqRF6WoKcz9jxz0XR3v/pxn2m
         8QLA==
X-Forwarded-Encrypted: i=1; AJvYcCXQuo0ApvLUTk6ljveqkBNousaLb3MBDlHScZ9a0IcXvgddNuF+UERTM8c6nvCx0JIsF7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkTbKptevGm4YiN4ONli7ndeeQ8us9XigzTY0OFCrUuVK2N87
	6yzscr+l+/sCo8NRh0rbEebV3Q+UsMKnifMvyUTZFMH15GsJAm0BkK38EPCPF4LULtw=
X-Gm-Gg: ATEYQzx8frO69s9bS+6u4bo+rIXj0u/7aQKnP6G4J0Vq6LztVvjeu7BHftHOmty1uP5
	DdxIxANXpPKI424MF5DThMnw0n1jONElJbsHREXI9C9UeDBouk/vCYyzd/5qspkyVmRoss54m02
	NU9WtIDqj8Jep3WXD2oLT/HRX5+l2QXJ4YvLxsJXSjbLDtEB5Yp5+3leRJGm+H+vAyFuDaksYHr
	ebNjAjZKfgDnGfqkmZvqzXSdQU93HEUVAX3kQIloJ6v9b+oKURmyw7h1qdoXuOZe4oEeIV8LWwf
	DhrfTBj84cGXB3I3voV95YTB5N/lVonUyXfPonVRTup9YKT4VoXJNAjb839LYBXs6E2o4shtx0U
	UtucW8qzclR/lqX6N96Qyxdv4fgZ5uo/4vA3visQ0idwC9/KPidf4RIX2w5bpSHioGqGNgMn9IJ
	OwjvlSzBA=
X-Received: by 2002:a05:6830:6201:b0:7c7:69c8:2d2 with SMTP id 46e09a7af769-7d591b324dbmr2356264a34.13.1772214129060;
        Fri, 27 Feb 2026 09:42:09 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::f:3cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm4723385a34.2.2026.02.27.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:42:07 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/4] bnxt_en: add XDP RSS hash metadata support
Date: Fri, 27 Feb 2026 11:40:16 -0600
Message-ID: <cover.1772211065.git.carges@cloudflare.com>
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

The driver changes introduce a bnxt_xdp_buff wrapper that carries
hardware RX completion descriptors alongside the xdp_buff, then use it
to implement bpf_xdp_metadata_rx_hash().

The selftest changes refactor common XDP/BPF helpers into a shared
library and add a new xdp_metadata test that verifies RSS hash
extraction for TCP and UDP traffic via device-bound XDP programs.

Chris J Arges (4):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  47 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  95 +++-------
 .../selftests/drivers/net/xdp_metadata.py     | 144 ++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 11 files changed, 482 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c


base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.43.0

