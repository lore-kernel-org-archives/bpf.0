Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10347365A05
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838398; cv=none; b=sn4wXMdIIgbk7M8w/LtcJa/fPEPxFxNP4xZdZ7H7B9W07VECSKDtbbYF+VmVFhEhKAN2GDx0/H+VsrCwVi0M/ZfopsIavDIruc0zdVsRQ/KvBqOaLikDYlrZ0zPLFnwaupSOVUB81VZNzVFnfjGqmBRrmq4Jy97OzU7UeOd9uFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838398; c=relaxed/simple;
	bh=G1m2bChyGfFCLRh6E4i97fS7WkOhKhPKA/ZRk/gLdPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDbNy9hFaYiwE1CmVaJGuGuyR2N1MU4ZIO5H4ly7LOR/23lkJ9kxcNOWohOXCul5WPakQAcV8SWikRrzR1RV4R4pwy+cUvWeDibA+Z1Ou8E10nz9VpNhe2bJm6rTGBEvEvS+Y/2OjvACDt5AvNIyrA2Mf7r4q7FqUUZRy5oq+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aBpaE88+; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aBpaE88+"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-464bc03efd8so5759225b6e.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838395; x=1773443195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csumzbWHZvx8PA3oyWoX+6soqsMyY5CickRdRinv65Y=;
        b=aBpaE88+ILfrcp/pXPRpS46zO4rEi0NIYGOfEAgPdVHZovFOiOvUgk+qTFWYhqsQHp
         cjmU34OUFXNHZDC9ktFhq5lXM9Ziy+gUf8HxO/G1WJ2ghkOnhhMvO1Ov2H69scUQHflY
         0osQfEMxBgumDqB/1oGgXmqmjC5ZItyX13O72i0ZfjgB2uQsZHcnm9fAynp6iYcfkLwz
         sz9qinXOKoDy+jp4n23EMLrx0B6uJW9NEIHwQVesp7o3jPo0afHLjRuMWuA6/ayg38NM
         PcOxfjKPIOqiCXCe85ghO/NkK2knqjizadNmM9ot5VTLFwWlvsKsQElWnwD/wDlg9+th
         Bzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838395; x=1773443195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csumzbWHZvx8PA3oyWoX+6soqsMyY5CickRdRinv65Y=;
        b=cHB2zGobQSmN3RaHhFGw0UVEZr1ZDCzc/Bk1Dh7xM/nb+ahADhcUEUuP/OUNiC9Zwz
         d1AenEmrlcb62ssFpB72eax51xt6L9LvdyyMmvDmZLwima73Bu2pYNUOcIK/x3y9sy0b
         uoGcXlHf2TgTHFzrulHT7waXvkAWCe0JLMqsEm6Lf2CXFKqfxFGkHhxxZzNUl8dD6aRh
         t+nBDCvZcsUlrMJ6McqNTfbZm17GzadL2WRau1zzIaASsGGiQLh6CN874fkPjZV4uXHP
         iiFC8UqHyeMcB8oXsPxD2vdjE1NBxT28azB7hcClCGAzz8LZ3Nfx3gjWP3yAEvwa9y89
         mlgw==
X-Forwarded-Encrypted: i=1; AJvYcCUSIEnnW8e6pM3dZ7FpbRv+NMwMD1rMRSwjopbQ+EfRVkOoS3mlm7i+nmAFFtW5gTcFaGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VVJ6QgDJU4PgEfCRiOMqTS+olYseOk2WSvO883eA/hTqg0B4
	6Hsu2pN8r+dV2SqvwU/+CJujGbdvlOpc1rDaCowdz1WenkaRPqVpH8zj3MUdqzm4Pvk=
X-Gm-Gg: ATEYQzz6686ZOZ6rOnxw8ScNMvkTRMIXsmbe8sUl8s0VZ2HtMa2uhwURzrA0GNHXRra
	3JKB1H7CNl56o46y8LE9GqkCxZoLzAZZOCYdCJS2fxF4GtQDd7GXMWT+alQk0+gkPj8Z7UPXlgb
	vChrFzKidgH/xT73qlxi634F4PludsvBY/Aaewx32Cj1nfTsT273tMXrazikUoKQ5RMPRPxfKSY
	FgJ2bQn/yOKQCPRQbA4KI3kdAevhp0h1GVtgxmvk2dE3K+WidV6z+EBQDFVtLGuPLdZPWMI4ro9
	vhcyAPUpXZ3OSWK2p9BErZ+76Eg53psy4JaeCyvsDxt4UCUMERTpq161NIybRBt0lW8yXsYQRKM
	iUmmJeAY2OyGc9geHPyepuM5uFGy4TzIHfmyxxXU99mAOMTHU/PeRPHnXaWdx+gN2cjbWlRua8a
	FYh2QZNFRB05QUEDNF9bE=
X-Received: by 2002:a05:6808:3098:b0:45c:7c9e:854f with SMTP id 5614622812f47-466dcb9c0d7mr2209128b6e.58.1772838394942;
        Fri, 06 Mar 2026 15:06:34 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:34 -0800 (PST)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/5] bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
Date: Fri,  6 Mar 2026 17:00:18 -0600
Message-ID: <20260306230600.1628196-4-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds another conditional for if cmp_type is CMP_TYPE_RX_L2_V3_CMP for
drivers that support this completion format.

It uses a similar approach as found in other parts of the driver.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 1f920464b426..25ecef1eb96e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -514,6 +514,26 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 		default:
 			break;
 		}
+	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
+		u8 ext_op;
+
+		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
+			hash_type |= XDP_RSS_TYPE_L3_IPV6;
+		else
+			hash_type |= XDP_RSS_TYPE_L3_IPV4;
+
+		ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
+		switch (ext_op) {
+		case EXT_OP_INNER_4:
+		case EXT_OP_OUTER_4:
+		case EXT_OP_INNFL_3:
+		case EXT_OP_OUTFL_3:
+			hash_type |= XDP_RSS_L4;
+			break;
+		default:
+			break;
+		}
 	}
 
 	*rss_type = hash_type;
-- 
2.43.0

