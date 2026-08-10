Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C13DA5AF
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387680; cv=none; b=fOCSzYay9QxWqNvzD8RGI9VyOtvYFjt2nYREK10pxVpi4aY3w0YGHXRHjBu2T5Bt3gxrjvjC/P9MlRoC9jbC7RyzQuNxT2Vj95j7sF2T8zFsfc2uPyxMXdfzT1E910q/hx+SNC1OU/GgpZr+Z95MbJPdv4vNX7Csfl5KuzMnScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387680; c=relaxed/simple;
	bh=GKE9WxfuuFSk4fxayK4oJhsYIA/EvxRVXK9sR7Ol0aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfoCKcPR6q173PG6YfdfqOJC/2WJaqJi/BqwiEmO4AM7/DdCShwPS2IxzfTtW9dDMuEOmfFWq2o5cOJpCBHmric08PXs6bd+6VNNCYsA6nbOvnYynU0wi7umimrSPbnVso1MY5hKAQvHClqWg53rRXr3aVJUi/8oLjaxEzhQh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtb724h4; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtb724h4"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d0344e1ce9so11111285ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786387677; x=1786992477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/h1pNasFi/92T6RUAvXDvHq7QawRH4lT9AOvszwUiP4=;
        b=Gtb724h4xyP9iqtruN9lvhZNNL2Mw5QzZSOwevKtUYvMt2cv0ckDAO4u8UfQEu0Zmx
         AxeaZZQWOLhKOIifUYslieR9maZ62toBToi/nN97tqOf4MpJzwYbvRuzAOs1+GzV0tI1
         wwkgAzfDg1emRhyjMdLbf/t7z8A+K3S+FFmUOhE4DJrsAhqMRdHYG7/c3/EXFQ42Ltce
         5pXlXLBF3vTVjOAHNF6ZklKLAobnxQzrkk3BnZF9eWJ3DggbRrgGoczbgYGbnbJPF/QO
         l4KSvZvF1HGx2t05JVLHKUlk7dRQSdd1rrwLGQkhzv1fuGCAI0pZAizo4y0U2Z00BREU
         hDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786387677; x=1786992477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/h1pNasFi/92T6RUAvXDvHq7QawRH4lT9AOvszwUiP4=;
        b=IZj2pvSqYMlui5cXZymymiZysBbIEFBYZp8vdJ0k8n0iIDvhmTOv4uj+4dN6xHxUNW
         tDImxFuyrDdYvkX4Vf+Mr3XNBFGvgRcRO3np1RHaqcFNsAbt29bWe/MlhktRwjL5FzBr
         Vnp8OLkQqbceJHvuKTn/bv+1BVUB4ONO03p/JH7msvbKbH/IwiSaPhd4w8o4HM2hKWsD
         hKvAAzq7qjooEBXKx9FrMmQx3kiOFBAu6E8WGXbVLaacOOS5Qz6y2Pdlegxfnafz96CZ
         0uMhLw1dybh4wlkfnU0pJ6jXvjdW0M9jIZvy+i4ACbLb4nAxOpJIY35TsXPo6LfAaDSF
         2+MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpoug7bPUEksfvwvGQjDqGOqNYm1Yul4raXUdETWK5Hdrj7SqP0dQC1U7IFz5TzIiYeFJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbbDtfkqltkgJqiejYkiV4RwJ1kxqLI0fHhCEz/kUTS0hQDZ4
	cTbJ5zYh5YZib9vUzfvOgrF0Lwr9f0MMotrupf7mCOEF4JWnM5vfa+2M
X-Gm-Gg: AR+sD133lxZeogfga4lnOOqP+BqiIfPzXzUVqQniIl5iDlr4L19EuRgCtoErp4rCgOx
	oUhwivNjG1uh6CTfxGqULACCzsVNpbiZnN8uOBaKtvVRfnJh6oIxWAjXaysdic6i8LIStCNPxBl
	1f1UEkAqojIQs0W/ClKSvoV5L3U0P4p//EseUw8EDAGXBUprYLV3KYDMAK1t2vfsun32+VPbEOZ
	7zp5I2QJaJdeP+fzsXsEVtwUu7Eg+uCtqZvHsOawJLK9psncbTa1pZaiyhG4h+iOqRKyLIIhY2k
	bRLejmrZqVQz2iXzdy4UZ9DUjyIx4/2Fguul886c4v7IzdTllXXr3T+A5QgnO/EcP3Ipmn4QZD4
	YaHGTxWvXMgkkvBF0EDZVUCPPOjUqIrUmno2QnVXhn2rZTgpJM3aUf3aUzU+2y5Yj+sl+LaF1vL
	McFWTa7+6y5MU4iwuoMMaBaB8gvqQ7rjn5GKFSG/pKwd++St2LbQibdg==
X-Received: by 2002:a05:6a20:918c:b0:3c3:89cf:f3a with SMTP id adf61e73a8af0-3cbce6cb365mr23635499637.5.1786387677292;
        Mon, 10 Aug 2026 11:47:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f38882fsm4517610a12.31.2026.08.10.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:47:56 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	rohan.g.thomas@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next 3/3] net: stmmac: skip queueMaxSDU check for AF_XDP
Date: Mon, 10 Aug 2026 11:47:53 -0700
Message-ID: <20260810184753.135756-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>
References: <20260810184753.135756-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
was inspired by commit 92a0dcb8427d ("igc: offload queue max SDU from
tc-taprio"), but the igc change does not apply the check to AF_XDP.

xsk_tx_peek_desc() reserves a completion entry. Continuing without
queuing or completing the descriptor leaves the AF_XDP rings imbalanced,
so remove the check from the zero-copy path.

Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efa35cfecc4f..6e9d4cb336ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2714,13 +2714,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->est && priv->est->enable &&
-		    priv->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->est->max_sdu[queue]) {
-			priv->xstats.max_sdu_txq_drop[queue]++;
-			continue;
-		}
-
 		tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
 		meta = xsk_buff_get_metadata(pool, xdp_desc.addr,
-- 
2.53.0-Meta

