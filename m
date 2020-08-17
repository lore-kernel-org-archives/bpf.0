Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E4EC433E8
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79E520658
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 08:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2U5GXmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHQIWr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgHQIWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 04:22:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781FC061388;
        Mon, 17 Aug 2020 01:22:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l60so7449626pjb.3;
        Mon, 17 Aug 2020 01:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnSx2Xs+5F55vipJ1GlRPOngMDb///4cheR/5/8gimc=;
        b=S2U5GXmo7ck1ZKahunFhTHxDXIlZOzEOfz2Ldo3lZV7wXaGbijFjmYJ6y9GPe7JEsb
         Zn0a9L4YvyzqdxmEdh9mSRBc7jpS+mRrU1u1MIJVwQLetIacicrbdTW87QgABnCSr4TR
         9+WfoJ7On1pmQAwDIGbyc5OKqz+7QW1J46cDvWGHmvKts/B91ywfzpGgmAM7C1gBjgNh
         sBwomzHfku5xWTvFJdYd8tXQQ5ErKNGJFOxhZ401NpR/uznNn/kfbHAabowljDvIo426
         jFeeopQuofHpn5V6pqn99ZwpbE4Cs7WtzeyZm8YPRzvgxsRXtBoKAJtFxKybqvNmw93E
         kH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qnSx2Xs+5F55vipJ1GlRPOngMDb///4cheR/5/8gimc=;
        b=SYUZlkG9UbPdJ3dYJ7pfn3Bwh/MligjpyiS/VrGjDjtQa2LT5YlJEoFgGX1LlR31lq
         UepK3lxkj4Q1zd/tq7dJ09P85z83PaZ5liU6BQzBhYUoGzscunQEpTm6qTUg/qmTOyYx
         lxrjXRgqPpOmazYXebFj10fzmH5oBdSA6pv9n7OihtWA/J9InUx+SrpjghB6mCHJ8Oq8
         PLsX8aNvXizrzZTLxQoa//Ye7B2LUP8ULEcE7fZXV0C0SXKzDzRomlvAKIkRF1cep1B1
         xMspoar9pWlhLvJyrn1qvFuK1XJeCiJVtY7E9nLEBBV3aWnXT7+dTbDxOJhFonsO3+eZ
         lz1g==
X-Gm-Message-State: AOAM532LAhtgIvgPh1NoKgkC8BglpL/kDdVeHhToZ85bPrlhT4jeR+Io
        oGQ0b3CMoyMKDknY7tBVcP0=
X-Google-Smtp-Source: ABdhPJzg5CA1taulVojf7+8vPbJsAwASHRozrU6aj+DjWYr3Cf2FaYf6IONr7tFFIkdkCyLlL5Anow==
X-Received: by 2002:a17:90b:2092:: with SMTP id hb18mr12059879pjb.118.1597652561292;
        Mon, 17 Aug 2020 01:22:41 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id d93sm16735334pjk.44.2020.08.17.01.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:22:40 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        michal.simek@xilinx.com, matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 30/35] dma: virt-dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:47:21 +0530
Message-Id: <20200817081726.20213-31-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817081726.20213-1-allen.lkml@gmail.com>
References: <20200817081726.20213-1-allen.lkml@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/virt-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 23e33a85f033..a6f4265be0c9 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -80,9 +80,9 @@ EXPORT_SYMBOL_GPL(vchan_find_desc);
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void vchan_complete(unsigned long arg)
+static void vchan_complete(struct tasklet_struct *t)
 {
-	struct virt_dma_chan *vc = (struct virt_dma_chan *)arg;
+	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	INIT_LIST_HEAD(&vc->desc_completed);
 	INIT_LIST_HEAD(&vc->desc_terminated);
 
-	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
+	tasklet_setup(&vc->task, vchan_complete);
 
 	vc->chan.device = dmadev;
 	list_add_tail(&vc->chan.device_node, &dmadev->channels);
-- 
2.17.1

