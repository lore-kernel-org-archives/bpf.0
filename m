Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4C5F466
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054129; cv=none; b=dohWTpvvIkxFQFeZgyZmaMtXQCmS1iYP8FY5Gw6pruYwOse3R2X6YJOyrbsXbbXxNuwxSsUxl+ahwZYyLZvqH2x4TDWRdXCCDhCagZYqdcK871Z7QwrYNt9iZae9PGtOWp9dMYTy2NZMud1cX7y6yC1nG06CH2jsG0kdW7HnXp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054129; c=relaxed/simple;
	bh=gm/ub3GiZq9SNWEfLYxrU9N6dJbEL0XROTTbGOG4WtA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HgODWSee1kX4p8IYY8O1q5ajiCU8O0Xfddk6r1GcsTf4L6b2N0yDkDyg1iFeCovKU8dOt0hOVdwCJdSATUjMB7f3u7zoT7rX1Nce4wUFHB/8KnjT08tKSGm5CiNDlBYcETN8THI86d28XFEIR2TKFRkhqv4FFGPpA6vscLFjeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cI+CGaOE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cI+CGaOE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4161eb1adfcso82185e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712054125; x=1712658925; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPpJN3A2gIdeLf753gUAk7Ivbl+pQSVyK6KyrqY9EVI=;
        b=cI+CGaOEPuQRBCZDXbX/G778rm652y29jMckOX6jT5mmUpfKsUhylTUIFeyMorwKwP
         sicnxrUK4m/wBNRbRsvOi035gLfuW4ppClwe+Y3/9FbM7WmpzHm6jtdlHXAlJ/cmIf2A
         nm4nGpazAG9pKOWHhHAuQAjKKTZjWnZXrA1ZwpFL27wRHpXhyPJow0g9MDYoKO+sjv4e
         aEBMCYfZtApYfQ7Vd0RwAsbdNagviJrsW0LFJEkWrYld4XeX8HimIdV7lLqfioCXvb5B
         sdwve1ufUq7bSgxSfNIyUc+ZC5AUJgNHdKwG0VSIOTxdVwjfz+YYNvChB+jLFzE52GON
         xm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054125; x=1712658925;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPpJN3A2gIdeLf753gUAk7Ivbl+pQSVyK6KyrqY9EVI=;
        b=D/dt/m1PpfGkKr7bd5LIzGliQelTe6KBDzzCXuMx5HrvnKriOa6luRfdDzR/69tLXu
         Sbspf4QlVa3GRLBjGVczmHRlgxHtGHMpDJ4W8xr2wcErwkmmyHaQKPT1lFzJAktn0H3G
         I825wCT77n2UZtA3NoY/2C4cojB5muNBzEVYoAqZ2akPRs9TVe1PjzJsGvHx0MRLIN4T
         P5Yae9OcedgsYtCfxgJoXqjsBigK0T9HxQsqLU+76zYYKXol8J/V00mFyABU/RlKRZaC
         2wn0qu4EcKUbBkZU1XclGFH4dMcZ6jViQpUqs15oCGiSzIEAyAy5Igj2pmtKVMj+pGkz
         GjIg==
X-Forwarded-Encrypted: i=1; AJvYcCUH6CEhaZfjYbYyRwuDf5PZLZEq1M1u6zVcdSOpFAyRBgHxEmSq2gaPYkBNkrDfNlMaC/YOxlnqiI3Ws4RB6IAW364i
X-Gm-Message-State: AOJu0YwLg54T2x84T/quV6tfYerVKf7PQm0a+uQtlKnDCTn1Jx/xQFT/
	WyXlqibtjfhetLSRa0rkRuuQW3uCJNtuLtDqB4fcpT+BOb/LiUBj0JQ2hkb9eeU=
X-Google-Smtp-Source: AGHT+IHsgrnrPNsVtFEYMmyvdA0IP4naNOkLV9wwcdrJ1kcXwbmMfv/ieru6N3dZglg6Qp/UJgrMNg==
X-Received: by 2002:a05:600c:1391:b0:414:624c:aaf with SMTP id u17-20020a05600c139100b00414624c0aafmr7781328wmf.35.1712054125033;
        Tue, 02 Apr 2024 03:35:25 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id bu7-20020a056000078700b00343587cfa7dsm1825769wrb.77.2024.04.02.03.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:35:24 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH net-next v6 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
Date: Tue, 02 Apr 2024 12:33:42 +0200
Message-Id: <20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbfC2YC/42Qy27CMBBFfyXyGrd+47Dqf1QVmrGH4oqYyEYpC
 PHvNdm1iqos53HPHM2dVSqJKtt1d1ZoSjWdcyvcpmPhCPmTeIqtZkooI5TSHAZneRjrN7/GkSP
 UFLiJ6JW3wqPxrCVblzgWyOH4zH6NkFN9bfv7AVI+pUz7STwXx0KHdJ3Pv7NMF57pemEfbXJM9
 XIut9lrkvP8X4VJcsn7g0AXMIKW4g3hdkpY6CWchxk5qRUYxQUXMrgAEADRLWD0CoxuGBt7Y6C
 P3sCSjVmBMQ2jvXYSnAbj8Tdm062IKzKWbKQgjF+wsCssbMNgkFvdy63A8Pcnj8fjB6OUq6lHA
 gAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712054122; l=2651;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=gm/ub3GiZq9SNWEfLYxrU9N6dJbEL0XROTTbGOG4WtA=;
 b=GSlVZrWGJwzlJnxckCzDVEvZs4b14/SyDtoDMqNQbUxbb4fIckpjXClyULnbfZTkOkO9rfv6X
 63aNWrMjj82DF7DIkGkelTjUAdpqND60CpJXCSwdsZSY/IT0LQXEina
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds XDP support to TI AM65 CPSW Ethernet driver.

The following features are implemented: NETDEV_XDP_ACT_BASIC,
NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.

Zero-copy and non-linear XDP buffer supports are NOT implemented.

Besides, the page pool memory model is used to get better performance.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Changes in v6:
- In k3_cppi_*() functions, use const qualifier when the content of
pool is not modified.
- Add allow_direct bool parameter to am65_cpsw_alloc_skb() function
for direct use by page_pool_put_full_page().
- Link to v5: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com

Changes in v5:
- In k3_cppi_desc_pool_destroy(), free memory allocated for desc_infos.
- Link to v4: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com

Changes in v4:
- Add skb_mark_for_recycle() in am65_cpsw_nuss_rx_packets() function.
- Specify napi page pool parameter in am65_cpsw_create_xdp_rxqs() function.
- Add benchmark numbers (with VS without page pool) in the commit description.
- Add xdp_do_flush() in am65_cpsw_run_xdp() function for XDP_REDIRECT case.
- Link to v3: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com

Changes in v3:
- Fix a potential issue with TX buffer type, which is now set for each buffer.
- Link to v2: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com

Changes in v2:
- Use page pool memory model instead of MEM_TYPE_PAGE_ORDER0.
- In am65_cpsw_alloc_skb(), release reference on the page pool page
in case of error returned by build_skb().
- [nit] Cleanup am65_cpsw_nuss_common_open/stop() functions.
- [nit] Arrange local variables in reverse xmas tree order.
- Link to v1: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com

---
Julien Panis (3):
      net: ethernet: ti: Add accessors for struct k3_cppi_desc_pool members
      net: ethernet: ti: Add desc_infos member to struct k3_cppi_desc_pool
      net: ethernet: ti: am65-cpsw: Add minimal XDP support

 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 537 +++++++++++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  13 +
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c |  37 ++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |   4 +
 4 files changed, 541 insertions(+), 50 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240223-am65-cpsw-xdp-basic-4db828508b48

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>

