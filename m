Return-Path: <SRS0=5Irp=CQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63200C43461
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F6621481
	for <bpf@archiver.kernel.org>; Mon,  7 Sep 2020 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcmCsZqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgIGPDY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgIGPCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 11:02:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B143C061755;
        Mon,  7 Sep 2020 08:02:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so8150853pgh.6;
        Mon, 07 Sep 2020 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oi4BSZHdphLvMn4ImifMad+2Dzg1/daPi3Jxv2xnQrs=;
        b=NcmCsZqyCCq+KwtlcULSkCBfkjSDbIC6YHcT/uAIpORTGHCs3JrlZ0GL17TJSobwkq
         n4FhtNTGrv/AnGiFZoZkLj9JY1Y+4wY4lBiOWFx7+b8yYXemJKwnsfcFpgz11t27Ik4z
         gaitglCZf7n37ihZLFM2alBSrmcWjaSTu4O/pDozVCCeunH1UGTKCy/7ANBQ9oaaWaSy
         F/il0qCN65nxGXP/lWtzxcf+vKv25+T4QP4gZyuAaBis/1TPJByNvJ8TR08rLz2KVeu1
         NYaXHvlqndCRvd8KcUGC9x//1Q24d1C9Dk4NQXDXG3SqKl9cC1ucsovrAJYgxwwKKCP3
         X2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oi4BSZHdphLvMn4ImifMad+2Dzg1/daPi3Jxv2xnQrs=;
        b=DPKTTTT2zjR5uAEQ42bV1naxCmsANbCwM4RdHv47lLjWNqm10KFgfleWiVFZ7yoeA1
         GdBAWNSp4J3VhmHh4A4tgQ7QQHnlCaN/Bbx+YVwZw13ISIrpGo7MkBK8wXu+Jc1Qdju1
         e10kLvtOncWUwMzEKgmG9zQOpeaq+Fju+oJGJ0yMMxJPCfZXLz4GxyOC2NleznUtYSwy
         U0/m3h3wiB2JmdgepbZDNz/Tl+rG/oCyc2zvpsR9Ge12vyesqs+eTvj2oO/XM3IGMcPJ
         X+0gKYjDe1zUzocMx5h9Hgb68NqDpEiJsLMl1rVGsIKdnzzLuUbhXz277Kw77VqLLw43
         VqaQ==
X-Gm-Message-State: AOAM530hB4d98yLsLvRajzOsvr0zsDu8a/u4bxmV8TOyGeU2p1AgJ2uw
        pkqNa/nsBBg60t0S95t4CBs=
X-Google-Smtp-Source: ABdhPJyK0Eh/ki5AGgO8dibVUfobmkKI1lVGKcG2ekDu8CgUcH2I44/GYY3jjsR8QDXg9+H8arJEZw==
X-Received: by 2002:a62:14d4:: with SMTP id 203mr1508796pfu.186.1599490967814;
        Mon, 07 Sep 2020 08:02:47 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id g129sm15436022pfb.33.2020.09.07.08.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 08:02:47 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, kuba@kernel.org,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH bpf-next 3/4] ice, xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
Date:   Mon,  7 Sep 2020 17:02:16 +0200
Message-Id: <20200907150217.30888-4-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907150217.30888-1-bjorn.topel@gmail.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
zero-copy path.

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 797886524054..cb473ccdf613 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -561,7 +561,7 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 	unsigned int xdp_xmit = 0;
 	bool failure = false;
 
-	while (likely(total_rx_packets < (unsigned int)budget)) {
+	while (likely(total_rx_packets < XSK_NAPI_WEIGHT)) {
 		union ice_32b_rx_flex_desc *rx_desc;
 		unsigned int size, xdp_res = 0;
 		struct ice_rx_buf *rx_buf;
-- 
2.25.1

