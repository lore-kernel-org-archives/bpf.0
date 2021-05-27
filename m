Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A6C47089
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 14:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AE660C3D
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 14:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhE0OiS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 May 2021 10:38:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39477 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhE0OiS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 10:38:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lmH7l-0003Hh-9g; Thu, 27 May 2021 14:36:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bpf: devmap: remove redundant assignment of variable drops
Date:   Thu, 27 May 2021 15:36:37 +0100
Message-Id: <20210527143637.795393-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable drops is being assigned a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/bpf/devmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index f9148daab0e3..fe3873b5d13d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -388,8 +388,6 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 		to_send = dev_map_bpf_prog_run(bq->xdp_prog, bq->q, cnt, dev);
 		if (!to_send)
 			goto out;
-
-		drops = cnt - to_send;
 	}
 
 	sent = dev->netdev_ops->ndo_xdp_xmit(dev, to_send, bq->q, flags);
-- 
2.31.1

