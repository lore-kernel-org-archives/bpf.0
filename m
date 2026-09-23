Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49135E93B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127850; cv=none; b=YJjErxKo7CMD438j0C+UBtbbr0hVvFAxM4Na5ERyIAUEFivV/7lHm3LBkbPjnxys6QYlpUOHGqcKxbDPMWdtS2RbxNpbY73+fYwKYxTqwtSIwP4XGMAPV5rjyXzRJNcfx1P3nAFSKlmgQoSb7GHqFnZ7Ezc4csJySKOHFFi29LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127850; c=relaxed/simple;
	bh=JLREV+8jTK9SZ0OiGjrpJVQPy0C9Bb/geA6QzFNVlok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JEP2S12kprBLSvnNJMBH/bqUP6T7fR/5lwGczhwLP/ZfebvhUukJJoVwGfIPbtpmCxzxD/Y4XPFGGfju5h4NexbSgsyeD+5WSw3z6bd18Kz2Y724RKVVbhgsZQvvwjjcSGUQWAgyD7nagQX9GcB0l8Fx4P9Z3WcBz3OrmG+seeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ0y3qdl; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ0y3qdl"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6beed321ad9so267190eaf.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790127847; x=1790732647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CP0iNzv3n/vDsQDDI+VKrwNL7s5RWy3LXnanNrQWAnU=;
        b=KZ0y3qdlrcepn0AVSIwO3MUnBo0iBlF9vJ7RyOrWLnQ6zgg1EcYNJzG+Lil2n5I0H9
         3izkO+v1hIbmcEErYx/mfy+onjQtn5jN7Ejxce5liO721yOXpxppkJKhokj8XcNINg29
         yE4z/wKELoBhg/VVqOrskgGFsGPEmtQctfUdxJM2OP3OclUUD97/lmdUOA6kc9+fJoHm
         UhDkF6l/ZWjoCYDKcy8G0PEWfHZCpTPcUZPjUZJ71dk88D9p2Pm64SfMQqdcS7w2S7ji
         SG3ijuyccRU7FHJ41nIkJ2ZjpMvd4ahzUXkQm3qTUOIfxuKQT7SEvnsoj4rIY7aEzn18
         qMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790127847; x=1790732647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CP0iNzv3n/vDsQDDI+VKrwNL7s5RWy3LXnanNrQWAnU=;
        b=Gnj+joY6F9eRS5995+F3M4r7smLVxGjisbourXNf8Aq14IOziSbSzELFn7T2J5zonB
         dKuCPSzu2Ou+3JQ2zlEEPYoTzb65qPOVZ9dRYyAkGbLkJhUWAZCjpj0uM04q59W74eLc
         p05QZAQUBxl3M8JyieDP5+hj7dt8tu4oaZPXhAJl8Iw9th6VS+QyOyoGMU9pF0WIEF/K
         Jiyzi/z2QUZe8lCublz2mbgtBAwaV8Tlobr72I10Y4XL6onIluD6EdtrNfMv2zppVShv
         rYfSi0Lql+HxpY1i2g8jm8PT/juJi8D7B2Jf6dDl6/9Fp61i7YhB1g5NuWvx4xZH48Uf
         HiBg==
X-Forwarded-Encrypted: i=1; AKwUvBwxMDv5NoHPwksZRf1b1OEodY9GdrIkfF8Rae+phxA9rIX9WsEj9cWtMH3HssCB0IlPZ/E=@vger.kernel.org
X-Gm-Message-State: AFuF++kBDemMYiHJMwGg/37eEY52kYv6ESPzC6jboZc+T52rw1XKO/5k
	obTRRhZEr3+NbOyWHhtP2+6CsczFKwkUm29BIqkuMDLwWlPk6TvEh7zY
X-Gm-Gg: AYBFou1vZ0gBbu8H1iJjYD4rudP7mHgehFd70V9bvrArfT+Bnst4QoX2cxnLVnPJRCy
	555QztG5JmXRQK3ucBuEcvv+a99nhCLudlcY9sTbM8Aejcx1eoGwVGFoNLOI6P031oBpdiml2bq
	Ye3uRlFFgheIxWLOP1kLELpwta6IVciDi6hMzynO/1t1wAuHz6Lc/2kAD2DUWTUHl2gr7cuJfPB
	idBijgPvjmwHnE7ckZjbPi+sPeS5xTZc0NvpcbQbIe1hu4zi5ugDNQwOvqrPEk9SUktFfjA5xro
	y3Nlxr7gHZht9VWO0+PjPygLW4pjAlmNax8hXStsrYmqTgLvXIpFpGdsOsBJotfinGoRUcFjJr3
	rfGUVkTy1v4a7Ec/2zXCn3R59JoVlY7JJ6TfrgVB/P8U0pRW/47RaRP50FfgbZAhzcz+Vx2bgyb
	bsds5Jz6ayqSzmaZkyGq5JbMtXC/wEbuBW7xnD4i82Wh22EVqWMfYVacc5HN81fKYBGIdAUDu1I
	VIE60w=
X-Received: by 2002:a05:6820:160a:b0:6cd:3fcc:96ca with SMTP id 006d021491bc7-6d2d3c08a6bmr1047859eaf.72.1790127847301;
        Tue, 22 Sep 2026 18:44:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2ce25c058sm1369513eaf.5.2026.09.22.18.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:44:06 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 22 Sep 2026 18:43:41 -0700
Subject: [PATCH net-next 3/8] eth: mpnic: allocate MSI-X vectors
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-linux-mpnic-v1-3-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
In-Reply-To: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Request one vector for FW generated interrupts and then one vector per
CPU to use for the completion queues. Nothing requests a handler yet,
that comes with the NAPI vectors.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/Makefile    |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic.h     | 15 +++++++
 drivers/net/ethernet/meta/mpnic/mpnic_irq.c | 64 +++++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c |  9 +++-
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/mpnic/Makefile b/drivers/net/ethernet/meta/mpnic/Makefile
index 9dcaa1c72605..3aa7c6a5ab5e 100644
--- a/drivers/net/ethernet/meta/mpnic/Makefile
+++ b/drivers/net/ethernet/meta/mpnic/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_MPNIC) += mpnic.o
 
 mpnic-y := \
 	mpnic_init.o \
+	mpnic_irq.o \
 	mpnic_pci.o \
 # End of mpnic-y
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic.h b/drivers/net/ethernet/meta/mpnic/mpnic.h
index 67d48b7ce315..628fd48c997d 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic.h
@@ -4,6 +4,7 @@
 #ifndef _MPNIC_H_
 #define _MPNIC_H_
 
+#include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
 
@@ -14,11 +15,19 @@
 #define MPNIC_MAX_TXQS		1024u
 #define MPNIC_MAX_RXQS		1024u
 
+/* misc IRQ entries are allocated before the completion queue IRQs */
+enum {
+	MPNIC_FW_MSIX_ENTRY,
+	MPNIC_NON_NAPI_VECTORS
+};
+
 struct mpnic_dev {
 	struct device *dev;
 
 	u32 __iomem *uc_addr0;
 
+	u16 num_irqs;
+
 	u32 mps;
 	u32 readrq;
 	u8 relaxed_ord;
@@ -28,6 +37,12 @@ u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg);
 
 int mpnic_dev_init(struct mpnic_dev *mpd);
 
+int mpnic_request_irq(struct mpnic_dev *mpd, int nr, irq_handler_t handler,
+		      unsigned long flags, const char *name, void *data);
+void mpnic_free_irq(struct mpnic_dev *mpd, int nr, void *data);
+void mpnic_free_irqs(struct mpnic_dev *mpd);
+int mpnic_alloc_irqs(struct mpnic_dev *mpd);
+
 static inline void mpnic_wr64(struct mpnic_dev *mpd, u32 reg, u64 val)
 {
 	u32 __iomem *csr = READ_ONCE(mpd->uc_addr0);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_irq.c b/drivers/net/ethernet/meta/mpnic/mpnic_irq.c
new file mode 100644
index 000000000000..bcc33655cbbe
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_irq.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
+#include <linux/pci.h>
+
+#include "mpnic.h"
+
+int mpnic_request_irq(struct mpnic_dev *mpd, int nr, irq_handler_t handler,
+		      unsigned long flags, const char *name, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+	int irq = pci_irq_vector(pdev, nr);
+
+	if (irq < 0)
+		return irq;
+
+	return request_irq(irq, handler, flags, name, data);
+}
+
+void mpnic_free_irq(struct mpnic_dev *mpd, int nr, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+	int irq = pci_irq_vector(pdev, nr);
+
+	if (irq < 0)
+		return;
+
+	free_irq(irq, data);
+}
+
+void mpnic_free_irqs(struct mpnic_dev *mpd)
+{
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+
+	mpd->num_irqs = 0;
+	pci_free_irq_vectors(pdev);
+}
+
+int mpnic_alloc_irqs(struct mpnic_dev *mpd)
+{
+	unsigned int wanted_irqs = MPNIC_NON_NAPI_VECTORS;
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+	int num_irqs;
+
+	wanted_irqs += min_t(unsigned int, num_online_cpus(), MPNIC_MAX_RXQS);
+	num_irqs = pci_alloc_irq_vectors(pdev, MPNIC_NON_NAPI_VECTORS + 1,
+					 wanted_irqs, PCI_IRQ_MSIX);
+	if (num_irqs < 0) {
+		dev_err(mpd->dev, "Failed to allocate MSI-X entries: %d\n",
+			num_irqs);
+		return num_irqs;
+	}
+
+	if (num_irqs < wanted_irqs)
+		dev_warn(mpd->dev, "Allocated %d IRQs, expected %u\n",
+			 num_irqs, wanted_irqs);
+
+	mpd->num_irqs = num_irqs;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
index 68a64377e6c5..127b71b44b0f 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
@@ -112,12 +112,18 @@ static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
-	err = mpnic_dev_init(mpd);
+	err = mpnic_alloc_irqs(mpd);
 	if (err)
 		goto err_free_mpd;
 
+	err = mpnic_dev_init(mpd);
+	if (err)
+		goto err_free_irqs;
+
 	return 0;
 
+err_free_irqs:
+	mpnic_free_irqs(mpd);
 err_free_mpd:
 	kfree(mpd);
 
@@ -132,6 +138,7 @@ static void mpnic_remove(struct pci_dev *pdev)
 {
 	struct mpnic_dev *mpd = pci_get_drvdata(pdev);
 
+	mpnic_free_irqs(mpd);
 	kfree(mpd);
 }
 

-- 
2.52.0

