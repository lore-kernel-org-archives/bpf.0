Return-Path: <SRS0=hqV4=U2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE7C48BD6
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 00:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFFB20815
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 00:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596489;
	bh=L6SMbqHSeQw9mv1yAKSgSSkPQBoiKxO5Gh3UPOSOQSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rEQfys43tkCe/APLWVcYQSZ/ZrXrwawrOJSCgHsAWoT14Hz+fOFKPIqTxdFBo3yZ6
	 GJ/+M+/1asET2qiRnqNd+ui7484BesdLPqOAbHGowHUmE+W6inrnAeke/5hWQ6H0YJ
	 Lih6kcfHAdYRo93vflopQMXZ7s2sLI1i2gsrGOaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfF0Aie (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfF0Aid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 20:38:33 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF64B214AF;
        Thu, 27 Jun 2019 00:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595912;
        bh=L6SMbqHSeQw9mv1yAKSgSSkPQBoiKxO5Gh3UPOSOQSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZP4CW66qHalhR3EAQ1ywVvV+SE0NZr7le8WDp8K1PBxQjSwtJCi42pXlg5Lsvqeef
         46TOfd+nRiz0Bplc4IiXN1Niixtj2uDiNjOg2QJYPhVVytbsUpx0D4PtS3FQ4e9QNU
         FeNhNuyJLBS7CGYZqlD4W253KfQz1fu7huHr5Vlc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 43/60] bpf, devmap: Add missing bulk queue free
Date:   Wed, 26 Jun 2019 20:35:58 -0400
Message-Id: <20190627003616.20767-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toshiaki Makita <toshiaki.makita1@gmail.com>

[ Upstream commit edabf4d9dd905acd60048ea1579943801e3a4876 ]

dev_map_free() forgot to free bulk queue when freeing its entries.

Fixes: 5d053f9da431 ("bpf: devmap prepare xdp frames for bulking")
Signed-off-by: Toshiaki Makita <toshiaki.makita1@gmail.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 99353ac28cd4..357d456d57b9 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -186,6 +186,7 @@ static void dev_map_free(struct bpf_map *map)
 		if (!dev)
 			continue;
 
+		free_percpu(dev->bulkq);
 		dev_put(dev->dev);
 		kfree(dev);
 	}
-- 
2.20.1

