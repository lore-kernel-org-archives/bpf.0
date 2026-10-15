Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC8384CD4
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076298; cv=none; b=E9J6xxaBWXlHEYRcFDMNd9rcRzPrvuh8RmLLYVoEc9k6II/g+g2CUZh0/o2FGdBGlbTloPf/kHpIdKeFKrP0WCun+t4R+hgK022zkpOOczfGACxQf6zEAdsyb19H737Tz4MoGNb2gckcBJTHkxZEQldD7Gl6QxWFg5nuJeOBBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076298; c=relaxed/simple;
	bh=Q4wFPJGMnZj3CekJ0BbunBaPUViZ/ENfbpq0d6PkpF0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cdlRsfWTio/K7NJu5fDU3lOd0kPiA4kHiEb8ykctC8NpvBaub/cZ5efQX2C/S5PRGb6sRzRY1qeEiTY+sHMiamnuoe0vkrRcQrIhEXTMr5ZuYqQQzrkdvlZPj1KscUBJ3NCwzCh1q27DyBsceh+2ucjFFA4dqCZcN0CCb3rbquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Rn5/b31H; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Rn5/b31H"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b0d19cf7eso48247f8f.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792076293; x=1792681093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DerXhHtNp5KAS7b6YTtqVphbqoa4v22Zyi/1qyIXn6Y=;
        b=Rn5/b31HDbspD+nQK/sTUJFk8Q3fzZsytczPGvvERkoSRzDOnGpAIvZ7ym/9vO1TMD
         c5h/MTkUmJyrullzaHxq+9/u1uydtUo41AFelQm8KyF8NkRfgY0omOT9stVXAzMcr4mk
         NdFvZpUc5C+Fypm9YWPPc89xpJqj+oGj2y3QHrM3ezEVX7LQvHIA3yQSGqV/A3iUMhSz
         iDEqXqqzFtO5H2xGPn6D01rZTSVyzGDdo9CAIp7xvCqaFbnLQBcWKYjrfJPGmI1xpB/4
         hDMil77/atd4oCY48pGpLM0+loqHcaJ0lhqfiu6hd7O86+tx/rDOzuau5yyTimzVKLw8
         gjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792076293; x=1792681093;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DerXhHtNp5KAS7b6YTtqVphbqoa4v22Zyi/1qyIXn6Y=;
        b=FAQatSVWinTlcvWVhCisW8H30CjbAnJTMIVa7z1IHlI99Ql9NHHZm1jK25PvT6hOqZ
         FWw1paoiUgvZx/0IhTdrgHeZLymjepre56C2ut1lQBipXeIN6lXrhj47EFCWKCdUosG3
         vHN7pHvOtQ/PJV/ABO4I1DUDoZFN0AUgqSR7vVYyDjtJI/Z23Pjm8NJXHatSI0ki8Cb/
         lqbYIYwf/9vcQPMqRh2Ek+4uK21yPJu5/9nzhs9jl6wF3CeVpVPjhd4ANptEvQCPFTkz
         eY0MND1/XV+vBP5WFwpH8+0KmarHfTAS+0gmuHQk5vlylkVNWfNPQcsNB6ha5gys9IRe
         KvOw==
X-Forwarded-Encrypted: i=1; AKwUvBz6Ei7/WoCJLrl+7GM9CVebxEoMXQQB6ujm2Wa2CEO+JhrPodt3K0eAp02Yfwkp+XDX/Kw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5kc+WT1DCSfoejDjshlt2mVA/ERVYziAOOEsCXaDxPcUXaLHj
	X9t9U6+HaWLHGIb3ApMa4Oe9qkS0eoZrlJGyhYZNog36kU1RqIKllI9MBdLp0VhZNO0=
X-Gm-Gg: AYBFou1BY8omLprD7SwnmmvPe9DqzyPeW78N/EpqiO9hEs0Bp9JTap2ksPOLsmw9AgI
	9b60w9wCE010YlrHw3GARsPsJPLLHVw3KJDs/EdnnQzH7h6zCA1ZKWcoVRC+QEtkVeCdzgrlbmm
	VvErZO4fkGPnIw0gZRDObKqKSNfCF4tNE9mjV1sWwvT/PL/9jEr5WV0N1GLDV2+9n6dklsKv3Sy
	/AmZHeH17M/NGd8zmNEgkM6Fjy8olTFeezrOfUbfPExjpf+ouGOtXmT9LVzOZHKZvRcD6QZHQEV
	EUryrvFFVYuFSztp2rxCrq1BhP6nqRfwP0/mQ4zhvY3Oi6rvKOuE3oseYh8Mob3bv5Cn36qcYi2
	n5pJH5B6tcpYSJ+CqFdWIk/vncstVNPxggiG8HaRW3ybVLueavzDsd2NMGD2WUgVsRjVjSkUwHn
	yk9JTGlKxbBzW14x5hzLlN/nJ+xmUDgHoThLCIqp4XoiUFEF5golMPM+rMR5/SYRRlNAL8ghHbX
	G30WkxhZmoYloEg8ClLkadEXZmUKHuc1TfNxYdnRFOufcqdXIrRhAk3uFAX3YIeHQjPk7w+rv/I
	C1YRGDaiYbj4ehTKrvtcVmnLe/5ksNPo6+hIqrfI8ZaKYYBlED62KLejqWU=
X-Received: by 2002:a05:6000:2488:b0:48d:f3ec:e818 with SMTP id ffacd0b85a97d-48dfae552eemr686896f8f.7.1792076292078;
        Thu, 15 Oct 2026 07:58:12 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac4fd7sm19738293f8f.40.2026.10.15.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:58:11 -0700 (PDT)
From: Daniel Thompson <daniel@riscstar.com>
Subject: [PATCH net-next v3 0/2] net: stmmac: Avoid freeing and
 re-requesting IRQ during XDP set prog
Date: Thu, 15 Oct 2026 15:55:00 +0100
Message-Id: <20261015-tc956x-stmmac-no_irq_teardown-v3-0-8189870be545@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETp0GoC/43NsQ7CIBSF4VdpmMXAxdLi5HsY01CgylBQIFjT9
 N0lTMZFx5M/+c6KognWRHRsVhRMttF6VwbbNUjdpLsabHXZCAhw0hGOkxItX3BM8ywVdn6w4TE
 kI4P2T4d72bUCRjH1iqJi3IOZ7FL9M3ImYWeWhC6l3GxMPrzqcaa1//mRKaZYT4QITaCDcToFG
 1VMMuyVnyue4QNk5BcIBZRcMSoYjLI/fIHbtr0B8coxUSgBAAA=
X-Change-ID: 20260706-tc956x-stmmac-no_irq_teardown-8a7592b9f8c1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Eric Dumazet <edumazet@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 Daniel Thompson <daniel@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378; i=daniel@riscstar.com;
 h=from:subject:message-id; bh=Q4wFPJGMnZj3CekJ0BbunBaPUViZ/ENfbpq0d6PkpF0=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBq0OnWOTQqxxX7nMcfeGzROflkt4bY/QjQzVNnM
 T0WFB3avd+JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCatDp1gAKCRB84yVdOfeI
 oePkD/94qvwD54AknAWsteA5RKgdf3ycF1CoudrTwIUffTO+WlKSyjZf1IXhPyPGBv+rc5D0h0j
 134nan8y/SxRaisB4DG5I3QW/dfqHl1EsDIaXOlH3508Ejf85X8ldB8SYfMVXXfkfmzPaRtPnQF
 yhL1dHBAzxc0YvhbZbi0cFblL5FsAgtiRou5gSw8EJu3kPuRA2No9BKQAI4nRx7OC2DT120Zzid
 yS3+GFS5RCf7eJFv/B+EVVkQVvA2h8GLXlgOPxHCADMJprcgN9zBApQUVQ9/aidBXGy0Al3krY1
 ZCMoaLvOwNZGxhQ+SHI2oHP89pIMSvtw8Fqv4o4ZhX6Hs+6iUetprT+ZnBCNCjYH0tmGN7nDbhC
 GSs3NrUhy4zypAo1dtW3o3z0haqZrV6Y4R/yhdvXmF5s59qXkWIzaJc2JYKillkU9In4CFjOLeO
 QoipTKFtxxYOabsRledtwFrOxj7mRmpQZvgOC1YRSt1CPi0LHrQsYqac3uty/ITTwE2AyjE4s4n
 TzRONiTtBea07NtkLqyBhr8h0XaNpJsfI4DfKpD5NklWO6aiBNbzvrpIn891O0fSapIVzrXVi9X
 NCdoE2zwepxIN5q4AFleujozFjVaOkHOFYaNHhdWxNPFgIGlIXELUFgTHv9CLMVeN/ykoCxIH4q
 fWs8gQZruCYQHRQ==
X-Developer-Key: i=daniel@riscstar.com; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently stmmac will run a full cycle of IRQ tear down and setup when
setting up a new XDP program. This makes tuning TSN systems difficult
because whenever a new XDP program is installed then the irq threads will
be stopped and restarted which will undo any thread tuning.

This series addresses this issue by replacing the free_irq() with a disable of
DMA interrupts in the XDP paths. The series consists of a preparative patch that
extends the DMA interrupt enable/disable functions and then follows with the
meaningful change.

These changes were developed (and tested) as part of the TC956x work that
Alex Elder and I have been working on. However the change should work with
any driver that uses the stmmac core and there is no dependency between these
changes that that work.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
Changes in v3:
- Switch to more aggressive interrupt masking to avoid problems with
  concurrent normal/abnormal DMA interrupts.
- Changed the enable_dma_irq/disable_dma_irq ops prototype (to support the
  above)
- Link to v2: https://lore.kernel.org/r/20260730-tc956x-stmmac-no_irq_teardown-v2-1-a6c31932ba84@riscstar.com

Changes in v2:
- Added net-next prefix
- Remove stmmac_init_chan() from stmmac_xdp_open() because it will re-enable
  interrupts
- Link to v1: https://lore.kernel.org/r/20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com

---
Daniel Thompson (2):
      net: stmmac: Introduce group arguments for enable/disable_dma_irq
      net: stmmac: Avoid freeing and re-requesting IRQ during XDP set prog

 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 12 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |  4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   | 29 ++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    | 29 ++++---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 29 ++++---
 drivers/net/ethernet/stmicro/stmmac/hwif.h         | 10 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 89 +++++++++++++++-------
 8 files changed, 135 insertions(+), 71 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20260706-tc956x-stmmac-no_irq_teardown-8a7592b9f8c1

Best regards,
-- 
Daniel Thompson <daniel@riscstar.com>

