Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA8386C26
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441063; cv=none; b=mKlSBfCERb8opPsqjFypQe2hUh2QemGx7HO4b/Gse0FLas/Y8FQ0wdxR013eWzHolw+v8wAq2Qknu7daJxrBVXcImouqhGk3X52a1FwuED8je6+AH8AQ0oZoOMZhaBNphaju86o4PjgUuxjU6AB9sRU9nCLrOcbQgrS1SWUUIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441063; c=relaxed/simple;
	bh=4mx+e9oVG6CrcMMG3/eO6hOms8NOKTTMBQ+YcrRMFRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwus1ow74L3xmfk2xsGoYnQ3KLmV4DPRAQd67yU+3yd5GGtuRSOczELRwm6G8UP7/6bh3NEHZCg4Rw9uT0u1nJT+Gh+n96F3HS+P+q/nq9iIGN0uV9Oh8FhbWgss29PGGkjoGFKNCEoTG8+lPlVvQxmRadTpsHv5yMD76rKhPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TOTppMoQ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TOTppMoQ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45f053b7b90so1803109b6e.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441061; x=1774045861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0xGdOzKFMVP5ynlZwdIR9piZg01nlaRfSX1gpCcslY=;
        b=TOTppMoQ8aJarVmSBMuAdvj9iapkP7dnGWIJ0NJ7lCwzKF/Xan6tFKV9eodJ299Cse
         i8wPJW6SUZ9TSfOi95aeoY4CatQb/pB8CNyQmzKuXcwhnhnM2c0Wn6b42SbgG5KP33ZI
         eGMS9FKiOgGevk6WJGUdHXhnnfxrw2zMmLoCG+Ie7wRuWbxzEpx+WD8K8jQ/5YKcc8VY
         DHHLsuHS2AuBUfuCkxzinJQ6hV2QFEZvXhl3JHEoXRMYu5g/EBzEFoSCCF9NJ88MuuAD
         OWt0IZ+/HmcKYTbqloZMmsRQAqQckarFrAmMPvWPoTQa7Em6nLvfS38m6oUtZTkzY4IU
         IUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441061; x=1774045861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0xGdOzKFMVP5ynlZwdIR9piZg01nlaRfSX1gpCcslY=;
        b=a8p8sebk3izvHPknp8Y4kISRZumDRwMDyqpTkO03uUf8URhvKhW3Mq99jMiqCvZ29F
         oo/YnqnbqaJXdGiwqO2xRhNeqJmaHpnw77UPYBCZn0WDZjXrCQO8CTPenwc5Neg7nMPv
         t0nuY7uJm92aAAN+JthQ+AD8052n2vMHr2gCIdVpNDH69mEbCmDZ6pO9QRi41dTSI1ow
         w3tkZzU5yHHHoL9MAKZgVk3F43daBcC7rmPdHbD2EaMHh1ynvhuh9WBS3rZKp4jEttZ7
         rIa9Eoi1nIk0/lDgmHYmqqOOLRUVjNPp34oToTNaOHTQEFPInLrZs5RIOUxVmlsogtqP
         +viw==
X-Forwarded-Encrypted: i=1; AJvYcCXTlnrK9Lg0j5HMmAs162oNe3V4/FZj1Rzx6VU1NYPa2263/eU+KNBMrLyEcSXwrF2ddcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxePXMeUv48HGte+exZGeIO8eocCQVgM/dehmWErnwztPIHkVZn
	vi60eTDdy9RN2O1b/1WWbhQ9K8yz54Lw3NFNXD4+J18QTbIw6C5WzTSTg09L8Y/qd5g=
X-Gm-Gg: ATEYQzwULop1Hhd88TFPn4CLfR0sUTii9iNyZ/4P99aL3hhAQawfp86W1urjo0jnT5R
	upyQzHuAS8X94gpwaX12OAi0IZWsDhK1Mn08WqU9Mb+wAam1YdqrxiyqyIq+fZl5owBJ/6FDb+H
	U7oN7H3hOBhmU/rjROVZK1VR/mFBTIT7OGFy2FtLlks501aW06WG68g5VbyGROyqoZ0hccAfEBZ
	IvXEOspC1wCqpt1R9Nux0PBpREoz5WzKs4G89HAVNUCnuIUmzqy0rFmV+ii9IDdRxSY+9qbfDyi
	6Kx6fhMBJYWjr3EzN5ShxnA1ziGnxB7z1RXL+vMcX2m0JNvzyopm2OBV/cTH4Il/xiH1u2yXfxW
	Y4GFsyf8jeZeT/jxOnk0xRK+WEhBml0BRDut2TvLYtYQthT0YufKoHdo7sqnSEnRDdgzilpyLhB
	oxsBlMwQ7G
X-Received: by 2002:a05:6808:4704:b0:467:11fa:40a1 with SMTP id 5614622812f47-46757598a6amr2320563b6e.43.1773441060705;
        Fri, 13 Mar 2026 15:31:00 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:59 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/6] bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
Date: Fri, 13 Mar 2026 17:27:34 -0500
Message-ID: <20260313223029.454755-5-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313223029.454755-1-carges@cloudflare.com>
References: <20260313223029.454755-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds another conditional when cmp_type is CMP_TYPE_RX_L2_V3_CMP for
drivers that support this completion format.

This re-uses bnxt_rss_ext_op to provide similar functionality. One
limitation is for L4 hash-types, protocol-specific bits can't be
determined.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v4: re-uses bnxt_rss_ext_op
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 1f920464b426..babcd463e50e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -514,6 +514,16 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 		default:
 			break;
 		}
+	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
+
+		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
+			hash_type |= XDP_RSS_TYPE_L3_IPV6;
+		else
+			hash_type |= XDP_RSS_TYPE_L3_IPV4;
+
+		if (bnxt_rss_ext_op(bp, rxcmp) == PKT_HASH_TYPE_L4)
+			hash_type |= XDP_RSS_L4;
 	}
 
 	*rss_type = hash_type;
-- 
2.43.0

