Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD4366DA4
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469518; cv=none; b=LEju2MAx3VQeAnbUM8YhNwWvUlm0djLzsGD3u1HAG3hoHDLK6zhVVbgY2o3WPjcRHwJKqUl8CmWPoLM0xSGPHsbYJGeuwnqvs2mqJr59D8PUNwpenzRO86x2SkuD1u6s6aWMUO0afS496DgJX7dr1Khgld6dzPOnpr1wn0sKPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469518; c=relaxed/simple;
	bh=obmtBdcSErYACs2keWx638lE8dHmynlQPWIspKdIllY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGtrBJDHlcvPdEm2iV9duyY+EXJxiwEBfxNnhom8fyJXtihNofGmQmH/XKJkvVYdM+Ac/I5xkfPiSkz5gidtwzC3OSUzR5L9A9+gG5IiFGnB9D2WvfMlpHMwvBggpFqq7rznmp9DoG55SoLP7EolsF/T3MTWOF7uIzHBRrJ/irI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AhPErz/v; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AhPErz/v"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-67e0ac36d87so156897eaf.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469515; x=1775074315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHj50gQQ7PYxlZfANZ5z4tfrKRrWvnoZOUlG8MRPfY8=;
        b=AhPErz/vR8OLgPHXJe8F0etJtixaBNyoBEc8U7W2MTVofAvFfCdZHhvUkRlZ3p2hfL
         Yvj/bDYyw+FITmC9OLAMuO+f3SK3PFIp5d6sMmIYzM4/gnTlOrYEOtA4NcHfAHHd+GnI
         lrvWegHvZFxaZdBvPO97IdZX7zx18slANrULlunW0qc1mEf95U/+EPOPAoSmi2sFukBr
         K2aqCAOxKGQ6crlwPDDgp8sB7pfjy/cI0r9dlTQY/3MAWhVBnTA91euAQuuOznT4Lmys
         Iw9GXoZhsuwRRZ+11+zim6tJPi1Boj871OPZ+O9TqTy3iSj4P3YoKHm7EbW33pYV/V2x
         TYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469515; x=1775074315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YHj50gQQ7PYxlZfANZ5z4tfrKRrWvnoZOUlG8MRPfY8=;
        b=X5vlu+FGGJTg9CgHIAk4yQ0Bv+WmHhMS5BawSqKzHBCbyM07ReraY9+4KB3nz2NG9C
         jWKiHB0AEbL7WXrz4SaLvMZDILsifJgKXNv+HSoyz4N9XbmZomCKro5o0xkiL9cKjW4F
         So+eXo2vrdcqwNzd48cRL54ZsMZBuNjXsqn4JWWBcn7XFTnuHC+h+fwvkfKvUYSj0woH
         ZjHBeHlFwIcpuvvdWNSPjAUBhiIYf02yToYxHAd+/7alFaJyfK5vTr7yWjmQLaZ2p0dn
         d6N4ZFS5Hdl3bljiLxg2TlOrOiON2SMeEMlw6oewC2gHznIft9E9tabXFxSFZQmApMNw
         8W5w==
X-Forwarded-Encrypted: i=1; AJvYcCX13fCp4a3TuY0z6AhFtJGqFHxJwZqyNhcREV4d3DTwRttzjl6AmYKErq/2rQz07loUZUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiufYrWtKUN14i5wms2eO3V54GqTMGKGvHcvhNSxr0ppZ9pMbY
	bIn/NzER7o+lTLkIbtgDX3iaXltYkuiv6cq8+Hc5k9ONFEVrKHWyqNiXQa2NDdLoJUQ=
X-Gm-Gg: ATEYQzz22dt8dRKKgggPVgxH1w9vJoZlC1JA1JKjRnsRsreF1jpHzOYYupcmxc7XZSX
	kkx2zeiNEK02z+5vH5sGP9LQB92Smwy7ZdBQj52ianrE87l0ft/Pvi7YbSiaEXLuULWeAoRN5Q6
	v1W5rc9iCv5KekEUM+Udv/AMkOn1Ay846/ws7ZJUHm/3WCYbyCMedBFwMXQumhwramcbDKs/Nhz
	hoEwlK41D5qzmiuzaEyjTFvaYSSziaPQ9QNpyDWsWP2lMxsdYIhyP+RmhWTZwKMyigim+fcdopH
	c/fUeEhKQn+wukNz2vXG8mq/Zf4+HIso72QNxMFMRgYrCNtDwccdR4Pt2dNEqjhoMVVJAvyLyWS
	O20knkRwMtsxdXhK1p21eND69xyAAjNgzguw0T8ZMaZQ7rvNwnrxjFjFhF+gy/XfpC7JTc6QQZp
	5ozUFi3e6IlAQuiHrTSdPV7DoyIRM4GpVEhg==
X-Received: by 2002:a05:6820:82b:b0:67d:f55b:a992 with SMTP id 006d021491bc7-67dff59d93amr2981589eaf.46.1774469514723;
        Wed, 25 Mar 2026 13:11:54 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:54 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 3/6] bnxt_en: Move bnxt_rss_ext_op into header
Date: Wed, 25 Mar 2026 15:09:49 -0500
Message-ID: <20260325201139.2501937-4-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
References: <20260325201139.2501937-1-carges@cloudflare.com>
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

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v5: no changes
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 -----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d15548dfd4a3..8ec611bc01ee 100644
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
index 99f45686ed09..30efcfbb4791 100644
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

