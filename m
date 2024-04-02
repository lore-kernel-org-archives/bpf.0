Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73855EE67
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054130; cv=none; b=rCLtf4xRCNfMQpzzGthaZYOFN+DXXljeXs3BtRb4hWYd4BP1XDkhn5glfS3TsFl6LggRIZvv6/zcDHdkFF+lSAN1koh2lmVQNjjAowLHI16w7dqx0XuUZFKUfQ9onmmEL4mOZZy/cvijnG4F3DI7tQrTpGJFHbVhUoaNnG3t/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054130; c=relaxed/simple;
	bh=fA9wRh9BhzewgFnx03QdynOb7Uu7To/l82seA5HFPKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EipU8tjXMGEQr4aV31eNRI1m1xXYG3p1Nv58o55TbKbO7nv+1TjP8vJMyshtY+vzSJEb6oN7HRqWAugUJSSFhf5MvfweXkkTL4DXn6vWd48A4TCyLW9XNs2TifwKcRyNFbly9kuUf6H5zKcAqwriU6Wva5Zia6mSUq83LAOPzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lqIGMWpd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lqIGMWpd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34175878e30so3720164f8f.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712054127; x=1712658927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AGag0SLGP6ZTz9ElordkjjCIrAOBl+sGfiLsyWtvf4=;
        b=lqIGMWpduRSg7dCGx3iH7L2gEaAirMz2KCVH8RbFxDrWj6NNmUDgRNulKi1yi7da/s
         QzVR835ncovEekfqpE/3uB3hkQRgtvw0NOjlqWhUp2cXv5gSooLHJitsFx53+sP3CZjq
         Nnd10uoP88V+v5xJu6kV45qezzb0dRgVwsZ5NXCgHiCpKi4e1MtDZ+mDfNL7RGyWEgfn
         hPNQ75pISQyH1TF+c/ZpOWZE2bg+Y4f70do2v3ZjkfH+QujRI2u1NnI6ZJVkNOjyWiDX
         hJ3iuVAO/CptV+tWhvhPFDcSOJDcmFMWN/qD7Sxdh5wkY4FI2Dfg6RSX+cKIUIcJfNmr
         O1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054127; x=1712658927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AGag0SLGP6ZTz9ElordkjjCIrAOBl+sGfiLsyWtvf4=;
        b=wVnUc15HLRftnsxuwsOBEgAtUKdD95cYOAuiHMz0DTY/ZCSB4EW3lW3IRsnUBB6Ygf
         FgSu0P/QIp/G9PcGW+lW7gU94jOkoQal2q9Pv7RZdxCfP1vtvnaKda786+oqEAxOaMvC
         Jjv7cXlf0/rrLyh5jGw6q2N7ypsILWZwnY40S+a4tNtUgyWmarv88BFsVWTsT+nl1kaY
         aSnqxsxLd8ubYTV6eYWYikvYOtCpJvyK/HPlJbzPPAs2hQ2CxD10zirvSLO9mwpleUUL
         nCXyoZul7uYQcicbDSSmACFB7TpM+2wNmYhWWXbs/BfozJcIiqprt6Nl+siBBsGTPjDR
         mACg==
X-Forwarded-Encrypted: i=1; AJvYcCXK60zPzTQ3HYfvG3I69G0L81D3gCj/UekqcrEZjQH10JN0CUuur8P6L8Avy+mcOfSSbuU/UxQ9yu3rM6L39b5AwX6t
X-Gm-Message-State: AOJu0YwrTWJGoxiXRgizwrt5WoCdG8bPgRL3JRvTJz3sznfBfKmSeb1D
	xqau4G58OpthzoSf0WdepkAxb19R/9CIgnEq2FELBAIszgaPr2Hz1pO6+ZF0fg4=
X-Google-Smtp-Source: AGHT+IEQauaBUmNUkNb7TaoMVMyvLQ0qDGx3fl3TpOL+J1TZ99oJpnwpFAty39JqZhEXAfZ3MSaptw==
X-Received: by 2002:adf:a21a:0:b0:343:64be:b543 with SMTP id p26-20020adfa21a000000b0034364beb543mr1083680wra.57.1712054126878;
        Tue, 02 Apr 2024 03:35:26 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id bu7-20020a056000078700b00343587cfa7dsm1825769wrb.77.2024.04.02.03.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:35:26 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 02 Apr 2024 12:33:43 +0200
Subject: [PATCH net-next v6 1/3] net: ethernet: ti: Add accessors for
 struct k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v6-1-212eeff5bd5f@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712054122; l=1876;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=fA9wRh9BhzewgFnx03QdynOb7Uu7To/l82seA5HFPKw=;
 b=GqnxSs6sWkav4QBgqTK6Qla5Q5wvipN8noKqaNjqxNHrJHznw3DVJ1MlICZa2wE+dcsAZICLj
 LvjocVo2lrjB3euoYStafAEYdJ6COit/uJ7/9NeQw02Vahi+SUioXzb
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds accessors for desc_size and cpumem members. They may be
used, for instance, to compute a descriptor index.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 12 ++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 05cc7aab1ec8..414bcac9dcc6 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -132,5 +132,17 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
 
+size_t k3_cppi_desc_pool_desc_size(const struct k3_cppi_desc_pool *pool)
+{
+	return pool->desc_size;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_size);
+
+void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool)
+{
+	return pool->cpumem;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index a7e3fa5e7b62..3c6aed0bed71 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -26,5 +26,7 @@ k3_cppi_desc_pool_dma2virt(struct k3_cppi_desc_pool *pool, dma_addr_t dma);
 void *k3_cppi_desc_pool_alloc(struct k3_cppi_desc_pool *pool);
 void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
+size_t k3_cppi_desc_pool_desc_size(const struct k3_cppi_desc_pool *pool);
+void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3

