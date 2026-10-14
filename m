Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1EB377ABE
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959242; cv=none; b=hhkUJcTXpYAYlAaaQzxvZCBjrih01pSSU4X9CZkE0N5PmFNbf0Q7VBij78K5vKcL/gU/3Smfi5DC2JXxvHyx+AHNuTXCGbe3kIDtoa7NY0T4EXX/Foi1NrQtEUJOHDbU7EznEsEBG2HDgj4EGodSAF4MQuiA8AuGb8oTKd6r/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959242; c=relaxed/simple;
	bh=RFL89FGKefYovGeBgZ3CB4+xWGgb3vNqaJKhk5dNQjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYrvhnx98CoRsjYkSWGI9piWIWGMwjNZxWge4kwwPgvqwMssnScGcYKLly6koDTjislUu1mfQbGXqxAZt+tmrsF3n2dpvrj5yksHsoH7eiy8Qu2Y0MA8/64wts7qAsO+gh5trrNYiwknprOQ7JaTrXB4N5zd4t04aycYcdb4e/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqmQ2mq6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqmQ2mq6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so22400085e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959239; x=1792564039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOeaatzk9bhuYpSzqiCT8rOTWkQH4urpPw2fjdSr5Ec=;
        b=pqmQ2mq66RojAANIF5bwWk/pRlXcTIptjkcEvmoBYeri1kmR3iMW1AH8XGBZJe/ZHb
         uc3ks1PY2X6iC6x2Fg0Ej28dlF7aA1rPvObgoVTfoJIF87UpaFztHY4z8ZgdDbRnp+iu
         fD+SRLMgiHp/B6it15XHmTdxJlSv/JFTfkegiNH1dXEQu/i0RSjWbdWlyo2sUK7TaQn2
         nfm5CNoJw+7DGHojgOLmOQzWwQ23hthXvSkBJp44wBixD3fv8y9Jpe7S1jqao8CA17f8
         q5BmBE028Zj8YHaTJGOTZRnPhcILHAAZx0zmSXuUXf7wADcstaX0yu5OSrd1DEvKe0qn
         aVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959239; x=1792564039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jOeaatzk9bhuYpSzqiCT8rOTWkQH4urpPw2fjdSr5Ec=;
        b=UYM+Xmx0x8eXtGXhVe9BGUzPIW+/+ReSH/0XtF0/ngzQ7XuprUYzogPAFOdn7CDChP
         xFfTbl8peOicMMWVDqnBAHu7K7pHS6ZFikBHIU5D9HanK9RxwLIjeRlKDnFJIpq3CySq
         sA3xAvuj7CmhjADi4VjF08StOEGxfS79siQ/5o3NXcTbKp+XZfw3GTUkLp19Ki+o1hKc
         1AMUGvLrX/GGfB67P50fYdBHjvTUictfcqUK3QhLitjpkTK9mxmlWKkR2KbpP34qNZJd
         Zc4xn0ZB1ur9SlgMQF+w5mI+mPj5J1Ri+XGApYC/+xJyvdicN6uUVwHWclwiwS+s/8jm
         tASA==
X-Forwarded-Encrypted: i=1; AKwUvBzqF888Q7WZCLuFoc/okkcpenGJtPNy/9gHyUzBVOoRHbY0F3d9YFEaEgWyYMMy1G7+SVk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoR3cueam6kNJ5PTeWeaD1t/bvWHNxf3ZdnKL34LqXaACu8Sew
	f7LnoRmnP8zmQAYz6bmXKKMEIPujhxkhEEjZtvQ2IkGvHJBt07GMiLfD
X-Gm-Gg: AYBFou13Ml5IXZycygy64owpl0VhDqMi+o3xTe2MnYjCTbLFjglXH9pGzg9lpNwWQtE
	LC2OMysE1vT+viOG18LDYI7j1yxflrF8xcTERtz/RyBe2rMtAUjEU2JP8N4sTfxwhrEC/Bx4JrK
	8lfsH1x4KiWeqdHdJtc8t67GeRtWVn0uE/0JFJaN6a6LQ5+2sOJaAy3irDySj0JfJMaKVE2Nj9C
	VtUZWl7Rh91WxNWjbBCc7uA28IEY8g1je5yaf9EnVfDo4GuDsUuRiQZdSKgnXe+z5CAhQcDUN+3
	2BIv4DK4vQFhKeZcOfRfvpVSJZl0eTviEt1ldHikMLSGrq/E6g/SrxiR/+Vi7LB15GvEs3rL95e
	Cnv4nDZqrBA1dtTBJv9KqZ/KcTj0oponBq6rQi5RVxqpjpvbea2/R5lOZkGBwER/0evITpdpuTt
	+Z7mUT1SaK2SIeqDB4dm6yLjBTryA9w5V4V8KppkIgY52mVg/9FmpxfPTEVrS0EHlOHSpmi9KF5
	scVitdm07gwd7qW2z7R0WlWQHqhZ8NSzDFpJEFvHCgrg7M46VHAKlTQVFfTuvwPQYTxQtgP2mtk
	YOEFE+kfRuRDRYRkC0JEYUtoYZLCM+a3YxtSaNKDVScJMV0IXhfdhWtbDaiE0tfcRCHwWUAp1bL
	XW6WmxSZaFYlH6g==
X-Received: by 2002:a05:600c:1c1f:b0:4a1:a484:2c37 with SMTP id 5b1f17b1804b1-4a1a4842caemr152491245e9.25.1791959238943;
        Tue, 13 Oct 2026 23:27:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aed1-da01-ddff-863b-8308-ab16.310.pool.telefonica.de. [2a02:3100:aed1:da01:ddff:863b:8308:ab16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm528846745e9.4.2026.10.13.23.27.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 23:27:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: stmmac: free RX resources when TX allocation fails
Date: Wed, 14 Oct 2026 08:27:00 +0200
Message-Id: <e7a5380aabfbc03bd560ab08f37ea255d11d528a.1791958735.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791958735.git.kmehltretter@gmail.com>
References: <cover.1791958735.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_dma_desc_resources() allocates every RX queue before allocating
TX queues. If TX allocation fails, its error path only frees TX
resources and leaks all RX resources.

Free the RX resources after the TX allocator unwinds its queues.

Found by inspection. On a BeagleV Ahead (TH1520), forcing TX DMA
metadata allocation to fail left the RX cleanup event absent. With this
change, both TX and RX resources were released.

Fixes: 71fedb0198cb ("net: stmmac: break some functions into RX and TX scopes")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 495ff7aef..8fd7d2173 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2425,6 +2425,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret)
+		free_dma_rx_desc_resources(priv, dma_conf);
 
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)

