Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53F386441
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441060; cv=none; b=rTi1m6/x3Vy55JBtx0psJvWkmjbNhcoVoPATtpf3vKHkGAynJKFuL8pjxsOugJ+sBEtEyZy1mYUgd5H7bNbZLTBAzk2BjipGPItQt14hTTp/+nvVYT8bavssZItbr2yRH7l8M9r+KolN8vKloLSB0XFehOhQvvxsCn2rYu3nzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441060; c=relaxed/simple;
	bh=OtHFbcpOVbLFwcytf7vnE+Hfd6w3VV2I2VNOK9waWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDRiXRzDBbzn0u+IqUXE1Cph8kQqbjNDYYp2IkumLZ3U6iCCM/yBKt43tTaWJzYNY5sih8NiBx4exWiS0bXJtCioR9JOJrh00e12bvX5qiS+cm6F2xYAbS56PFQaL7l5SRew2FC2OfqLlI4zz+l30+ZvcEn79C9IbKDkDekJSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IZmqc4iO; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IZmqc4iO"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46702742c99so1720830b6e.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441057; x=1774045857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLKdgna2TJg/4cf6a9WLp0moZG16XDEww02DyhezqPc=;
        b=IZmqc4iOxoBtUFX6VTFP8z/4pf2m6t55C5WJyM7E6R8pUwH4XcXqwqhvf40zXvYOS4
         O4stlxlMA+ijEMBcRLuvuQ9ioFM2WGqHfS5QYsh21PLWbEnOl+AdAqFmzckLECew1FB4
         s5MMJoBrRIdkcJUbwJX7UaId8UHl/DPDBw00dDXMSVWiQJOA8q/39OQi+b5GimCYhYrK
         C12qfD2xhl+4uwzOWBO8ivqS71X2UkboQ4a/+s4kft4DpPT8TWoxCKyd7aRNlXjR1pgG
         RjVbgWXbJiwBRQieGGyOX9Lcb2aD0NHN9/e3S11ivhMIMuOTwYF+64ba8u2mKF1zft5O
         nWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441057; x=1774045857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLKdgna2TJg/4cf6a9WLp0moZG16XDEww02DyhezqPc=;
        b=cg4bEENtwnGjlfQMR6jNPZF4b87MhWlfcLxBLa7aJqvNd2d/h95A7gzt34qol/BtN2
         me2ntpCIKDw+FtP4B97mxbaTZ12GgZNacYdoc+8M2T2Sfr1ftSUWHZA9LkfFUISE+hQW
         z/tXwuQT5JgUgE4XanK3biU+sJRh4C7dX1v1TThG3UWxJO4xv5KIRhK4nIJSqqoV+WE/
         urMnRKS/inezxFCvFqAnek7wTlNGOmrFQKwMt/aP61ssuSPWnQ6RjQEVIVQ1lRLg5Oim
         yHh68f6S5uyDqAZWYaLWosHwU/NgqyX9ZZE3AT1rrkyqp1Q8+fH6vQrH+9/cKuXafxEX
         WTrg==
X-Forwarded-Encrypted: i=1; AJvYcCViIXbaXYPmxQmGP0R3ChZ4bp4P5AMlHgUzjRB0vUcQkQpE2FYq2VCnjZ1Sb1ftp4r2FCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Gex53UIYb5qE7Fp0iJEvGEYEgkmYE7UT4QxcBw7TeXIWAR4y
	EWp1OTDFxnmjh2PyZ+MeHUvB8bwNGmq7DeTDUF2IApauFEBecSi276sqr7l0jw3G3RI=
X-Gm-Gg: ATEYQzx3ljOmJZGyyVbYGUN4d7eZbvpAf5PxM8yQngz0cJvqgSOYrMc5PexGzOEbUxM
	ixhC1GlBFy7euGFAWuGhN7N375zcrV58vupiXlFbuHjgOozqHuUDRA5yeiIktVmLIvMcGKgZ5l4
	WHVEV0YurOb3ywc/T/G030bq/rBSSMZijJBhipKXiQO5VKiyO5zUKkhDYL6RJVq743ohlL16Ldf
	exBaIUVHduYX0YZjWptBeJNhijwIGntaTEMn2Yfw0rkfe8LUxAM3/0AlJCxNNsfvSvG8+TaTahF
	WmfR4H5Cn+oAESXea7qC+CeYbJo639jpAlbS/StPzTfLXQLbKL1gtk46OoXPd7jn4trmaagP35+
	o/LeZBWS3JJBV7ZwWuDpC7hgmu61ZuEMJNcbxsMmWGKq8lnDGowhOqeLcMWgbENrESU1YyN66U1
	g1kgLHXl4UfJBiyytljTA=
X-Received: by 2002:a05:6808:a550:20b0:467:2926:1252 with SMTP id 5614622812f47-46761727390mr1271145b6e.30.1773441057445;
        Fri, 13 Mar 2026 15:30:57 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:56 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/6] bnxt_en: Move bnxt_rss_ext_op into header
Date: Fri, 13 Mar 2026 17:27:33 -0500
Message-ID: <20260313223029.454755-4-carges@cloudflare.com>
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

This allows bnxt_rss_ext_op to be used by other functions. In addition this
modifies the rxcmp argument to be const since the function only reads from
this structure.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 -----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4881d9359549..8176d34b3408 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2077,23 +2077,6 @@ static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
 	return NULL;
 }
 
-static enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
-					   struct rx_cmp *rxcmp)
-{
-	u8 ext_op;
-
-	ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
-	switch (ext_op) {
-	case EXT_OP_INNER_4:
-	case EXT_OP_OUTER_4:
-	case EXT_OP_INNFL_3:
-	case EXT_OP_OUTFL_3:
-		return PKT_HASH_TYPE_L4;
-	default:
-		return PKT_HASH_TYPE_L3;
-	}
-}
-
 /* returns the following:
  * 1       - 1 packet successfully received
  * 0       - successful TPA_START, packet not completed yet
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 34bb98709f2b..f8b8068bb47e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2902,6 +2902,23 @@ static inline bool bnxt_sriov_cfg(struct bnxt *bp)
 #endif
 }
 
+static inline enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
+						  const struct rx_cmp *rxcmp)
+{
+	u8 ext_op;
+
+	ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
+	switch (ext_op) {
+	case EXT_OP_INNER_4:
+	case EXT_OP_OUTER_4:
+	case EXT_OP_INNFL_3:
+	case EXT_OP_OUTFL_3:
+		return PKT_HASH_TYPE_L4;
+	default:
+		return PKT_HASH_TYPE_L3;
+	}
+}
+
 extern const u16 bnxt_bstore_to_trace[];
 extern const u16 bnxt_lhint_arr[];
 
-- 
2.43.0

