Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89427366553
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469519; cv=none; b=rhVH6v1UcNuED278ielK8XbbQd+eW/WVm3xm7DAJ55023l5GKKzpDE/beumWRAb89eYfvXt2CtQqOWBHNjl1zXobPZd2hvnthDIHMRLqoZb2N544wgGeLambDADZ4zK9ipED603kj3J8iIl9TnzvacWLAdwEdNcFPgi1GqvZr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469519; c=relaxed/simple;
	bh=AMSE7Bs/MZKuLM6hrnKnX+2i7bncB0wloo9AGDyWfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2qf86O3+CcOG0sTSp4jO/LSljI/gFZXb26O88gK1/+D4BqiJwtM2/0SAZbXO4loy3S9ZXB70/VVfMzdzl6dW5CCJ2oif17UR9ewFSV1Izn6DTD8qDm58dYduUWXtQigRoX4k5QYVNmhwA6MeaOlMNP36tFLNeP4m1ozMUcRidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LKnSy6Yt; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LKnSy6Yt"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-67e00a230adso196636eaf.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469516; x=1775074316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqHZwYBZ42AZ2CSQh5u+QvxE5CToH719GXie9Td1RjA=;
        b=LKnSy6YtzsxvjgOg4Bm5JREE98sq5NRvIlyBjxVbNklC5YK/3eQeDuMcs/KyuXk1Yn
         RAADCWLm3chd25MOc9fTIopW3jIbqPXNgQMd40qEQ0eQaJFY5vx11EcdjdZP+0BxlBUd
         g95I0hK+yNh+xQSB74O90o9/qmr1Qm80EyiJ2sUe5iY9MS7Y0SumcRJfyWXxe0p1SAkt
         44lFzJx27QO8cLMn5U3Rq3h0y3cliz1LNAvuK1HVeJuDbIp0Yc7wBRvmT7M7fudeawd1
         4wLsUh9psq7mMnvwkE28rtK9REQd9JNzMsK1BS1SXP9Kcq7FDUCrkDYxVWcCuHci37QW
         9/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469516; x=1775074316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jqHZwYBZ42AZ2CSQh5u+QvxE5CToH719GXie9Td1RjA=;
        b=BvwdfuORPQDAP0mwOOBrXynl6jtaX6uplsvghZTrgoofktHFxSw4sGL5dIHJ6WXdAb
         i9kOlJ7S+Wbdm24wxztEpeN2c22GVOPsh7XlipvH+jISPL2dNDdDclMJZ0U94DY3Rr2i
         w4yVSGYgbAHYWIk2vUulrbyBkCd/bHiydDL+5meYRh08ZSRE/OH69rUfxBYQj9XpiWgv
         g+KkCfOPTUsYx/IUNyTcF7vitUG0uAQEUFXgp3tZI5QiZnTNMarZy1GVBjwvAwgEXwyC
         1WElwvwxH5KE8QZOHQZ0S+Z5DpnlBLg8MHAgfq71MNWp/yQEjNR40DAzvRIv/VCIPPmB
         tHyg==
X-Forwarded-Encrypted: i=1; AJvYcCWbYYYI3HqICAiACm70E6nUz0RF0JXCUxj6j8XnRFxngC0raiRD69TPh9UoeIUr7UyYQeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrRMsvuMQk/f9UzefJgN9j7RH+31VHq9ta5jMLcN3hqlO6oVx
	C2vGkcPJSJYAUwNiDtcznDX46a3EMYOGgvqTMw/bmkbNnwNIZjLR1izaR2MxPuLRuzg=
X-Gm-Gg: ATEYQzy7YdJomxWsvMbHYMDRzP8YbOlsNoE/sxk4XYRELGwuX1n6TUXXAZwWTyGFxM1
	583QjsudCHXLBKShQaIThSD81NY3AQS3xeYiaoqf/N6L7iMOwiPywVF+L6buO7/C844IqrGMbhB
	M6ItgwnhdyYLdq1P8KGJbrNCrMNV4cgS+C9GeDWMMYaKk7xtlJST4rsc+QXPJT7rZaX6sBBdJge
	14wmRU/xy29n1jOX8AV2O5eJ4tjhMYsfUm22Hb0UKdDJR97wRIHiib2pMnfW8PPHmb4sSGIBIfT
	4KhbWWzUH8/Qp0B7Mt9jG28Qa2AQi7L8Ovhdj6P3iAKNCXw7uf8siBBsuF4loRP+22/3ujcwZBo
	p5F0A9UArja9HMt7sDgoQvAxvxHiWZfY22KmUE5fqa0Fc+DReHDZneo5CrCbJwkzNRngnum5lbN
	TEdVIx7OaKKKas757E4ghK5qU=
X-Received: by 2002:a05:6820:1506:b0:67c:e09f:39dc with SMTP id 006d021491bc7-67dff24ef04mr2529701eaf.0.1774469516464;
        Wed, 25 Mar 2026 13:11:56 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:56 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/6] bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
Date: Wed, 25 Mar 2026 15:09:50 -0500
Message-ID: <20260325201139.2501937-5-carges@cloudflare.com>
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

This adds another conditional when cmp_type is CMP_TYPE_RX_L2_V3_CMP for
drivers that support this completion format.

This re-uses bnxt_rss_ext_op to provide similar functionality. One
limitation is for L4 hash-types, protocol-specific bits can't be
determined.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v5: no changes
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

