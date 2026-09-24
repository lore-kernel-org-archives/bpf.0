Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976634BFE6B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271880; cv=none; b=T3eNAMmgWacEYIkyJqYvOZPRxRS/OLLw0Z9z3UH6aq9kOTOBd87h+HcI5iHtgmt+wPXKBjer0rc9iUsyKk+WPqiKqMEiT6d4W9XHreL6FThOtj/Y1OMFE3lDxi6FMDdSrJ23lYwVKpkJcXzhCaN5VWCUshFeSU7U5/qjR9AZVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271880; c=relaxed/simple;
	bh=99+ygyxjwVBdYixymAmvkjn9F6hAmZaAbfPFXH1rCO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlHFIKUtm2qDKdALQYu7KQ6bg2+9+2I1VjtxXkGI/KZPUETcWzH8c+oO6mNW7DrTTL1pam9JflTi/VbGFfvBsikaUZ0j7/Is0i77XiZe6lNYTPcgF6KrN1xKC939lRO66szCHAS2Evvf9+IjfllGUwgI5wJX3jG4CR/FDM5zMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqk7pKnY; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqk7pKnY"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d06a12d360so70185eaf.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271877; x=1790876677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wKZkkE2xLR0im7GAkRWZzs8Zs+Mbht27bASwGvGU3E=;
        b=kqk7pKnYq3RmGeN1NWm7oeBeJmfGPD6VeMxCvA0LWjk7gJwSQCwjQFgZ2j67I7G7cM
         UsazgAEKp7VCN9tK5mPTrUMo8D2XtHc7+xYfE/LToVHki9fQUL+VVeR5VHGNkXjdvd7t
         3jGdTC4znRTO4ASwminR3/Wm0TrgohcZkD/e0L1L6J6h+Or/b6XYPLLYLfRlpw9p8zbO
         j2ZL8//WIUugIEEGslf+HprbTr2HH4bZkoIxJKjMxUzl9yY3FHiZxQjDKfN+0vfdIx7X
         O5P70NZ3/nP7+UIYjr6E8ydfkTkOm3kfutR3evLsmpnwkF3PU+wo+V932ByZi7aiaeEQ
         Qoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271877; x=1790876677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wKZkkE2xLR0im7GAkRWZzs8Zs+Mbht27bASwGvGU3E=;
        b=fVPbu12cfxFBB2ggFTBSEkaFbXRvCQAIYdrVNIWqEtNSzb0B3cdt9pWerwJn50SQJ1
         +r/LY+4Eq4cWre8+wksi6uWF+gXOwp4quyYHXi3sEkPv9DQCPNBOi5XTSrEl8Rp0cF5C
         qFW6S47B2yURiMeuwrvmtN5u1f2W/fylBQZCQN1Sb5oiq7u86SU3o1SVFvAKHu1yy9iA
         ND7GlQJuleoLRCQJJc8kBELvjFqSvUMkK8loQ/JpLiToc9QdowN8eCOL5EEK4Lxax2Ad
         zEuIv1SljmA1paSLWXJYPFizkTY/D5RK1Fop3PGdTt03GDzlTvM5TJJVaLveRMP/nFW6
         5EXA==
X-Forwarded-Encrypted: i=1; AKwUvBzBUQEBtaE/J7vi4nUNRGBCxgQ3x0/idBxQx/r0Jkwd8r/ilXgnGWlnsjvz+zb6bzzRt7o=@vger.kernel.org
X-Gm-Message-State: AFuF++kbKo5A0y7HI4ONJmHYMUxV7lTnujHxz2r3nbQpHZOAk2XDlzzN
	FzFLJ0q84ZNMJNTKWmFe1S39EJhngejqiEEzbaZM9izN7AP+Z1qr68U0
X-Gm-Gg: AYBFou1QzCHeCIdjl7ZB/idiGezGq+omvMqxhjkitM3H7AAF6InsAvv7UDiF1o+je+Y
	1B4EosRDx6BOWTYcpgmGsWQ26jmZvavljV1GEu0SeJP4yZXWiqECjnkMRdtZvOZ51LSabTKKzex
	CuFkEM4bL0PuboO9mbwN7oFtCbYxr/uiPAawMHrfWjMigGO5t+9fSd+odJ/ZeV2muuPtPS4DA7d
	W5qXxQGaPUpyv6zuAL77HK/92xqsCpAdkMqJJK2KXgS6Oe5hGGoMR2b28RG1uqV+HGHiRiUOFaf
	etRW8Wb39gjClAG0yGa4NWi+ATuYuc1SDIOQbnpBRpTvcqsmlxGbOGEcKVZdNV3Jhn65nbD8sNp
	egUCvrj7NOlfCsrWJj/ndqVc5NRn6jiV9uJ0oseJtuCUplN32WEciRxF1nbgKLpp06M0jgBpx2f
	Ry/oMx9yMv54Ef71CzrujA+zdYfsezPvnerznmugvulXuhR3XgvBt+bGJXZCkrZ5U8mVNYcwFml
	t2wAelME9HcgPqhp9lFPUP1OWJFnoVGdq8Z/o+N9noEpu/og9mzjfrtqpmjQuDughMNhzEUQ0jY
	k9sAPAP1XlejE4NhCMO+ySZ9GV9xXThu32e4MQ335Mfxwn2ElixUI2v15KqR4hFc5rpvL4hT8+T
	uHbQ4PZgwxRmGuE3eqV9SlA==
X-Received: by 2002:a05:6820:f005:b0:6b7:83d6:2924 with SMTP id 006d021491bc7-6d43f7a5ca3mr3335705eaf.39.1790271877265;
        Thu, 24 Sep 2026 10:44:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:31 -0600
Subject: [PATCH net v3 01/10] net: stmmac: unwind the WoL IRQ after a
 safety IRQ request failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-1-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The IRQ setup paths request the MAC IRQ, then the optional WoL IRQ, then
the common safety IRQ. If requesting the safety IRQ fails, cleanup must
release the WoL and MAC IRQs, but not the failed safety IRQ.

The REQ_IRQ_ERR_SFTY case instead frees the safety IRQ and skips the WoL
IRQ. Allocation fault injection during live XDP reopening reproduces a
"Trying to free already-free IRQ" warning and leaves the WoL handler
registered after the datapath resources have been released. A subsequent
open can then fail to request that still-owned IRQ.

Move safety IRQ cleanup before REQ_IRQ_ERR_SFTY and WoL IRQ cleanup after
it. This restores reverse acquisition order for both shared and MSI IRQ
setup, including unwind after failures in later per-queue IRQ requests.

Fixes: 5c2215167d12 ("net: stmmac: Add driver support for common safety IRQ")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f34d491c959..4f3d452c3503 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3797,13 +3797,13 @@ static void stmmac_free_irq(struct net_device *dev,
 			free_irq(msi->sfty_ce_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_CE:
-		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
-			free_irq(priv->wol_irq, dev);
-		fallthrough;
-	case REQ_IRQ_ERR_SFTY:
 		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
 			free_irq(priv->sfty_irq, dev);
 		fallthrough;
+	case REQ_IRQ_ERR_SFTY:
+		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
+			free_irq(priv->wol_irq, dev);
+		fallthrough;
 	case REQ_IRQ_ERR_WOL:
 		free_irq(dev->irq, dev);
 		fallthrough;

-- 
2.53.0

