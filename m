Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51F158535
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505945; cv=none; b=Onr9XTmy6o7k6ZmF+6tX8nA3KZkOy2qD0PYvaJzi3cDve/srKe0aWCqt+PMQKftgF99drf9z8CP2DpoEO+pLtfQkH/B7Z8tuK5RtOZatFNoZttk0Zz9+A7g+FRH6hn0oLDBVLxs5+3Q7Gy/rDAtiMSe5gMjl56jLkONwqqT3r6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505945; c=relaxed/simple;
	bh=b+0Ff/pUDhFe+rGVzYVSp1+4DBYWUSZiCFvSNbPgMUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KncHVstCkMWWJ3myi99/EwtsLVuu8HFOh+RBYcs7ZukyswuXmgKGdkSQqQkLyeKXo1qi3Bw9vPAURYDT0TB45xVQiJw2j+U3ODdjFSCGa1vmJ5D1/BPqTEgUqcbUsktGSKR4tnUxqemxVEQ6Im/JenqM0bB3lwYTvjvVI3RD01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ffauuUDS; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ffauuUDS"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6786b13984fso4051444eaf.2
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 18:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772505943; x=1773110743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zopse3Rf+kKizvyvuRBVQ7DWejIScda9vW//LITHTBk=;
        b=ffauuUDSI18B5wnMPdSGdU34iEGOz3MV9NTaBrYmFZQytzq9TwRiYF3qyJy01YcGEO
         hj8xnqHi0yn44h9z0SIR38OkwrjqSWc+lzkdNVJevrxhiFCrRRqq7xKMpMc9JM6x+tiN
         J1sXlXbbBWcSejDNxFwpNVcUeTO3TpP4/pAXGgC9+33p/w5mayIYgE6QRlavGE95TcK/
         thzEIZAoiB5tASvqVyq3tz6tjGd8k4FBzcLkOK4MU8/ryhdTuuGHH2EPGMTH0UKY5HWL
         qc+R5Fily8rvV4GpMyZwOZViUViuIgmYxITCY8xZVBq56QWYx9mM0CpLgO2IgGdlB9wc
         AHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505943; x=1773110743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zopse3Rf+kKizvyvuRBVQ7DWejIScda9vW//LITHTBk=;
        b=PwK9aO+YEzitMC6gxDbrUcczfMey9gxEJUGPBNnO6y4Mm2OjRp3Se23ByGSKIPNQ7/
         IKT/QgPvJBCND1/Qphg2VS+hdFnO17g39MMvFgr2UCF6AedIuUAuftgUF/nG/ZuLcPH6
         uWvm+YuCKtnTTxmyt8rHej7SdNkuLHdFxpTbh84lxqvuZIKIB6DRsmZrSbL6FfeTg+me
         hm4M7rG+1uVX+4t79GmN99jIDlS9laCICy8Al4YpWUmMsUMCBbEQxRTi0FjAWeCSIlBB
         YPNTQs0Powfu7KE/6FTJca6VXrDKZlv4MPxqkCRKtiTMe0trg1+SOqORHGTIWhVIgukf
         lAGw==
X-Forwarded-Encrypted: i=1; AJvYcCWqBfnJMh7VDigMJoLd6Q4IWHH7wNHb4TBaf/UfMjGVHOubl1E1dUd48oD89Tn9HQwY5uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHe586H7FN/0zWC+p46xbHsiCWZaExNT/R1SF+snu14w2RAL+d
	mdjAlNsm/gHTCA6fJHEsV1b0bzRTjMDjvZ3lVQfygpbQJFItcg/qYYWzObNCXFJ8uLc=
X-Gm-Gg: ATEYQzy5FgEKAmGP78ZgHesh/I/TQBCU+Z4/OkDneKEZSIAUg9EH34sLK0JpK8jOIju
	h3bW1seODCUEim89/yeTOJNdUeHg8F74ym5RoowxSWeyRLbOyb65QNo7fHan/AzG6wQsakuTewH
	I50JfJ8qvn4/GIOoU2zPgJPufG0D25fthAsZbykH5dlcSK5AX2C9wH0kVnlaOXGY6Ce3wtpgVmn
	G+a43Rmb8y0u7m8RLhKox8R0XStlA6r8PjYOHFH+2LeXUHhS5oSczSDu0c+t4B56zkiD9P6JSJH
	2VEzoG8dS+RwuFPa0tsCLFayPpURtwecsPr5e4seu6P+C421VSM1nFcAz3Hp2OP4igHBd0TUq3A
	fkRdgsp7c1sHY6ofWvwfT0mxq8/PdkazBiWmTDLxD8o7Za7Rs7HMQ6tiYf9cgkYMwBpXk7DGqQ3
	qNbkKSzl0=
X-Received: by 2002:a05:6820:1747:b0:677:e78d:223b with SMTP id 006d021491bc7-679faefa6dfmr9051694eaf.36.1772505943148;
        Mon, 02 Mar 2026 18:45:43 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::a2:70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm10205642eaf.9.2026.03.02.18.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:45:42 -0800 (PST)
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
Subject: [PATCH net-next v2 0/4] bnxt_en: add XDP RSS hash metadata support
Date: Mon,  2 Mar 2026 20:43:48 -0600
Message-ID: <20260303024510.644962-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213192449.1294830-1-carges@cloudflare.com>
References: <20260213192449.1294830-1-carges@cloudflare.com>
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

Changes from v1:
- selftests: moved tests into net/hw
- selftests: fix pylinter errors
- selftests: add check for no error count
- bnxt_xdp: followed RCT for variable declaration
- rebased on net-next 

Chris J Arges (4):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  47 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  95 +++-------
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 12 files changed, 486 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

-- 
2.43.0

