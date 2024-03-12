Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931EA7A137
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249777; cv=none; b=jJVcCISVsrN7b2loSIMIQ/RYWH8j/zu0lw0ltoJH8RYzHJt53ye/lBajOYk5n42HOjdQp43+RBElSwymiRsoYijGlowqMaoN1a2Sdm+eAO98U7lmDYnl3iY2buX9RsT/eEMhZrez4hhIN/bGx1htREkSfyXJIkU6k1bcsHa9PZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249777; c=relaxed/simple;
	bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZY8MolGZf72ZtZpopGCt7f58dE+4RkZ63DChRKO3cluaQFvUwVIxls3j/vu1qjLz/w4wEMr8t2WypIZ0Ovjz4dI7uVazMw/vyJYgsCCFfMAx536hjA9gPIwRMcC5axkUZyOvdgfhdJElEabkfhw7poj6JzClOM9Nj24Ubau4IhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dyiZTgoN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dyiZTgoN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4133847e47bso4150205e9.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710249774; x=1710854574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=dyiZTgoN45XsRfXvpv4SfJR59VJUf+jjoF0z6RvIpSxgMafbhMT0cos+2ItXOOfF4l
         Td9QSk/XXkQu+cy31AmUwgAuJSFNIMeAaoSzH2tVMxlZ0FtsdzLzsYh9cx8+/QcJckRa
         DZakH0bEiYkAStBsKigpN2maloFb2/luF5qN4dk1sK2E96pkNZGElD0BkkDBMvHGcQuB
         RWGsaZtJIgEKhgv+KzVJ2WA27oT6DOvjmxtjfg+tIjX/ltj/D1UySqf4hDTOZ69zU63J
         EeG6arvg9P7yuO8aPac9lzcaAp0gqAQ64icD+qvo81jRsXMTVh5lri7sDyX1XESUo0sU
         wBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249774; x=1710854574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=wCKbzQEIM6AUMQjFISsLEsD7oh78R630bCPUiML1gipRkWG4XxIMNF2EYZ/zl4NIeN
         1NNcM+2oKFDHZ6Urm06d6Xkm/UPraCOJ+dPi6rio/3WKca/xgKm6c8wGH7hSzuoHaoC9
         D/VKVCwJ0h8uObxFaQKCev5ZG++Auo+jlsC6BUmUVxw/QqPTt4lHwQcVbvl+WV1JDRun
         kBDP/A46eYUEjj20HYIJa9cMlPFaUgGy3cJZ3I2tGCS6WYoACljfn8FZwMaw1xVEOm+H
         t1EjLYqv+rOHiJWiFAMOYKixdGm6AkZR1XrGARnFNvvMYN0qQxr9/byaBZFq0VJ5NMIx
         wBsA==
X-Forwarded-Encrypted: i=1; AJvYcCVe+jiEdrYZJ+FBnNt2+OT4SvDipIQDZ6FobiHL0ocrlaWDcOpgkN1BzmM0d++ExvlBDzvvuFfXoT/MHSOBNPojGF5y
X-Gm-Message-State: AOJu0Yw/T6UFd6u3nHoUZ+zHO9REvRAjUWTSCBk6EVQmsQmfUEJ/zzVp
	czQwZQUOk1FsHGATZKfOawyJcp1diwZ+uwRUCCVeWdDxf3/Sp9nIIiPIgqiEgcw=
X-Google-Smtp-Source: AGHT+IHlytHdEXscr/W+dSAr2nTXoxgxrjyAq7hvZ/powmwJ49KYk2NF7VEmNWzayQm3bD8Elvc57g==
X-Received: by 2002:a05:600c:458c:b0:413:2c3e:c323 with SMTP id r12-20020a05600c458c00b004132c3ec323mr3370255wmo.38.1710249773976;
        Tue, 12 Mar 2024 06:22:53 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id r13-20020adff10d000000b0033b278cf5fesm8980167wro.102.2024.03.12.06.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 06:22:53 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 12 Mar 2024 14:22:40 +0100
Subject: [PATCH v4 1/3] net: ethernet: ti: Add accessors for struct
 k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v4-1-38361a63a48b@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710249771; l=1852;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
 b=Hv8qFAJaCv6kB2joBPWZNghBiio/tb9H7gUNxrjl4zJ1hbySQ4ZrUI17WPbsgLUJJGcO8W8rA
 8wJzf0mor2KBFT1SmQ6ACzZMR0wREU/bfp6sf0fRwAbqrnAk9um/rP2
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
index 05cc7aab1ec8..fe8203c05731 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -132,5 +132,17 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
 
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool)
+{
+	return pool->desc_size;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_size);
+
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool)
+{
+	return pool->cpumem;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index a7e3fa5e7b62..149d5579a5e2 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -26,5 +26,7 @@ k3_cppi_desc_pool_dma2virt(struct k3_cppi_desc_pool *pool, dma_addr_t dma);
 void *k3_cppi_desc_pool_alloc(struct k3_cppi_desc_pool *pool);
 void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool);
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3

