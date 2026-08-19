Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB2485500
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155544; cv=none; b=HT9bXYhSZxztH5pRODqVN6C76yZVpZbIE3+CMR2uxVY5Z2FJ6zkICwvIXOLjBuPojlnQIAAs4fmobnfjBpcnzS4V3qRQMfYoRRnWTtlUHs+uqXRlR41CdwORk9yBvYtM0SaPQzTiE9P5imqaSSjddZtP1tPKphUGBJ1aDp1stCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155544; c=relaxed/simple;
	bh=cQTwj67zy7Laq/EhHZBENAZnhoe0otCikzM/pbJIwzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQc2ct1sDQ5dYfuxY8pyaWqA0759HLCtsyggfqAogp+PLa60u3opL8Nd1OwOG+ruCrGQRCfCr8iwF8zcEm37OaXuwclP8LOdz0tuaIqcnDRFJMDpa0pam/v3P4WEiDJgkw8b4UgtGnoeZ5JGxaaCklgotMCF/uD6wvfRCaEqkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTESn9Xd; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTESn9Xd"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cabfb70501so3289125ad.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787155541; x=1787760341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKdPBJAuwbKNHRSj/o9wx9GTRe/KKjDR+X94RAURNcg=;
        b=nTESn9XdI2bnT31A6rjMNe8XOps2FXnK2IdAMHwlZb66qHA9q//IzNOCds//X13m4B
         B6M533AYGYZn7B6ZkSBwBY9bk79Qb9qtedfroxLfFnL/9mHVtkh0SBqanWw/qRCcyhbx
         PXbKjmjmLfw3hYUAabnJ9NCcDg/zAD+yGlBwfKsC6ECinw5bcm5N/+w6otEJNGeXFyHk
         iy4JDjS4WVwRVSbIp3NF8XzH9D2dP7UC3Z3G6SOWW03oeRyohkMixfQ5oA/YFtEw01Dw
         K8sxUreEQBJ4EuFDNL/6tFJa9WEblqVFlaJh0DsQt+AdpXWsobqDoFgcMwwe8JqPJWwb
         CiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787155541; x=1787760341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKdPBJAuwbKNHRSj/o9wx9GTRe/KKjDR+X94RAURNcg=;
        b=ZnHioBmQMA9V5vRpXeD44oU2atqVPMjBVUP8V8BWO3lw5UVDxUL1XWd0/GTVoWyCbo
         CwV1m4uv+txw/r9nxT6R9IjohHg0Y8QtiX2cI4zoms/1nDMyzKc/LyB/7L9LTzNsgDuE
         8mYETmhi27gybyFHvdWcWyyMi1xJPexyHrcdfKBtSHMEkfJc2WNq9Fdw/GREiXa4fDZp
         p30cN4h3vYx2eOJLw5mWF3O8mqAAjvYeUolhZ9681lxjYr+n3KdwVfuIBWwZbUlS8Yu8
         3eC75iG/UPPMa9V97g+cC1PrPvFn08pqwUpkH8GsZwxbavPbyoqyixNIgRF1Hdiz+kWr
         l+Uw==
X-Forwarded-Encrypted: i=1; AHgh+RrTkmMeoUBGgflsufK3nOo0/HpeJLME6NMyq/u1D1f994/Z9S7D9KSDpZ3eAON4Iu5sUKU=@vger.kernel.org
X-Gm-Message-State: AFuF++nWxFcRXGctAxQd+1OjJT0Yq8fq27vsicMyCbBFu+sx/lWGJTGg
	rGoOZspWhS3gcVm0F7lAq/s/IpGHE/oBucIQ9eCExIbK67INRb5M/5rF
X-Gm-Gg: AR+sD12IBdMWsdUe/ScNTUjFyddb301FHGL73PjBRdD00JgAR6ZyU0QESVq3QpOSLjA
	uguedCMT/yb3JpNk7OCbJ/M8mJdbJ3j1o5eguQKZwesMgKR7/1FFlG26uvi3FqP9lKvqUk5Jy3f
	PtMli1v+MDbRGzNk34ppRU2uGmbhJYJxXP4e8lsioJkI0Ni6B/4wfsbbTkCZLgxGzFNusGrZKiZ
	WpPO1KUr4JvFQVyTyQWrFZ02ewtWRbMtPL8R58aQ6/wU+B36gUZ4yUekRPmmgQEcvo+HXFM1RpW
	tErfoBKKYp7yurrX+cPZ8Z3mkgpmC4B3ZC2TOjggrgeUFdkPR/HKFubZZuZTqkQ6UQW6CegT7Ju
	QJKAnVELBJ1L227ruhLQV0aGcxlUd/twag5GHd4XJUpeB97UdQiR09R7iSjzWGS4zEQzohh2Gd/
	65MWKob6cL0mlKnYQvS6Dr/7VPxEBXaclX5ySADNsrIDuIYvld4ipoizMOzJsxy3nD
X-Received: by 2002:a17:90b:3fc4:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3958110c755mr10914058a91.12.1787155541199;
        Wed, 19 Aug 2026 09:05:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb17eb5sm3740911a91.3.2026.08.19.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:05:40 -0700 (PDT)
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
	guoren@kernel.org,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-csky@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame handling
Date: Wed, 19 Aug 2026 09:05:35 -0700
Message-ID: <20260819160535.1472459-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819160535.1472459-1-sdf@fomichev.me>
References: <20260819160535.1472459-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
after xsk_tx_peek_desc() has reserved their completion entries.

Completing a rejected descriptor is unsafe because AF_XDP completions are
ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
descriptor, which may still be owned by hardware. Instead, leave the
completion pending so the ring eventually wedges and increment the drop
counter to expose the application error without risking hardware
misbehavior.

Document this intentional ring imbalance at the check.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62de03e65a90..6a532747c039 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (priv->est && priv->est->enable &&
 		    priv->est->max_sdu[queue] &&
 		    xdp_desc.len > priv->est->max_sdu[queue]) {
+			/* Completions are ordered, so this descriptor cannot
+			 * be completed safely. Wedge the ring to expose the
+			 * application error instead.
+			 */
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
-- 
2.53.0-Meta

