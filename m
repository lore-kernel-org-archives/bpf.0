Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6B50A62
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382453; cv=none; b=cFRWAInkNvfrCp80mr2kgzlwuR2ofTrsdyTh2UznRJ7qlx2knkKx9beSVoF6qb48kwvfuTGwXrxq3kJe2EsNSnosciECqTnnajN9XBPCowLyYYYF/2Pfm0RHsuGCUij3N/HIQDc4XB3LjNQgWqnQm/pEEaaAjWChd6VToSMWiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382453; c=relaxed/simple;
	bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mum2yDfrgXnGfzYp0t3OtoFf5s6rmrJMCJqEJr0MRpho7zS1b0gsRh6PyO47fPsoTgbH5TSUqbvCHbgJGvsKdprLD2D5IVz8sUh+lMSwALWq2/XblHVT/cI0gfJbIMPcdrWo6qhcQVdxgk78VsFZEJ0WPUcE4IT4uCSTqqy+OHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tAK4T/XA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tAK4T/XA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41485fcb8ccso9460925e9.1
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711382448; x=1711987248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=tAK4T/XAYg4KKEs4TbeAuEuwzm4FP/TzqbKshsyTfWHAXGgT1EeuYYKVRRwmne6uc7
         36mVMBvxx7109Vbk9rHHoaccO+Q637gYua5POUWpaTUJ1LLUtYOr7MwqnI+J2bbuJedY
         2km4SDP3KaKCmmMQmqG19Kz9Q4zxpDcENtYbqUgRbvwk/WNUv673J0s2JA64Jft6q83l
         H6Gc4GsY7dNoQkjJ1Kxg5ARt2iP/YX2OJEppnICYpMfRzfLzJ78lMQqyrDVg5UpWzLd3
         ew5JGgsnhLpQsMSJdKFL5BZHedxdCXMFy1jYISCruMd+/hRLlEtreXxpm11nL6Q9epBT
         gMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382448; x=1711987248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=uRsom5ayiat6MEmBJQORl0x12o9HZ2uLOHiAd2DP9ZBvIM24dxJlvSjUXteg7GVGv5
         gy1y7QMBROWUCQxqP1jZB4ZxWQ6jA8l3Wk9i8YZu2DOVP8izukuUmGy9Jrn0WLwQAti/
         FbAc3AA9Eitjum+ykd27h04vCzsocRKhNxD+RcG9irgq637C4zcgj74gszGd9rDclJsd
         eFpaScYFIzLpBDx5ZBTm5QgwoL1yY/gMetDDYoD6frq33T/K15auDOSY5P/lyqXxCTg9
         4IB5AfuTnpvPZyfEG8TCZQs6fZV81umFINv6Ccjp9D2bVme/RslL28oUKbCZFf7uuv2v
         PoyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBQtJW8HfC5meDSFeAsdlqHzylGI3Kpo+pNyiG9+kdZx+XCD/PY3/iYMTNp327rf6+RmP33YBRt4Y/ECAjPTDD0hsy
X-Gm-Message-State: AOJu0YzMtZbJpRdsewzFEA6cxP0Nqr2iBwYaRan4x4qEDqdP4yff6zpA
	NUPxrV3p6s2nzzmeT6fYj3VbpTdhqEZIdNfGiRXB8+7gh38s2YuiD//I3C4zQHg=
X-Google-Smtp-Source: AGHT+IHCN+EUC5Ixkwt4KEbNvTXzChsqVSlHeysS1I9s3THmhKymtJhoWpKoPj2lxZQDIDpdjgl1zQ==
X-Received: by 2002:a05:6000:a85:b0:33e:cbec:b2bd with SMTP id dh5-20020a0560000a8500b0033ecbecb2bdmr4808890wrb.9.1711382448665;
        Mon, 25 Mar 2024 09:00:48 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r17-20020adff711000000b0033b6e26f0f9sm9839361wrp.42.2024.03.25.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:00:47 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Mon, 25 Mar 2024 17:00:35 +0100
Subject: [PATCH net-next v4 1/3] net: ethernet: ti: Add accessors for
 struct k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v4-1-2e45e5dec048@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711382445; l=1852;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
 b=aymDZ233B8w10bVhhQpTuMZOAhH2dz2fHG9HbLabwWA7o+g60okp+Zk4el2Yy3QIHto1OT8y5
 JlL8nNPV0CTDZEiTJL+HQuyBPyLbN4xLZFvaPfW3jH6TAEgAr48tp04
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

