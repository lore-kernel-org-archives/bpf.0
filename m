Return-Path: <SRS0=hqV4=U2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1F3C48BD9
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 00:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081D32082F
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 00:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596703;
	bh=BJMI6uh5TXibTvHIsacfwa/jIjDCymJ6D9xIhNW05Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GCBd8kHhZrcFqCI6akyuFb00qSKs9cqxbrtX+c7kQ7Q3alj+ugomhPmfnXWctZ2Ri
	 r6bvmEEKxFIPfLVJuTxNBQRAvgOJcTMppo/8xeMm2oZVytBwQF4nL84vxjHM3cBrcF
	 RGFCl2KaPOIWc6HpKWTo9AXo5TrgzbiSLEt6EM6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfF0AeO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfF0AeO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 20:34:14 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F6C21738;
        Thu, 27 Jun 2019 00:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595653;
        bh=BJMI6uh5TXibTvHIsacfwa/jIjDCymJ6D9xIhNW05Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8BObNMviHg0M6eVzwEtPj+jNHO8Z9zSqHJYZpQ0KbcZdomD4Asp/q5EBOXbLmaiR
         IaD26WwKoB3k08rPAxg9GjSWXA1U9wVi3TbXG9ObnwG1RBcGZj8vP/FSr5SKwhgQ8W
         H0fr/j/BDXfiqQ6CKnQRl7pEWLoaJxtUIvyxkSWk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 68/95] bpf, devmap: Fix premature entry free on destroying map
Date:   Wed, 26 Jun 2019 20:29:53 -0400
Message-Id: <20190627003021.19867-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toshiaki Makita <toshiaki.makita1@gmail.com>

[ Upstream commit d4dd153d551634683fccf8881f606fa9f3dfa1ef ]

dev_map_free() waits for flush_needed bitmap to be empty in order to
ensure all flush operations have completed before freeing its entries.
However the corresponding clear_bit() was called before using the
entries, so the entries could be used after free.

All access to the entries needs to be done before clearing the bit.
It seems commit a5e2da6e9787 ("bpf: netdev is never null in
__dev_map_flush") accidentally changed the clear_bit() and memory access
order.

Note that the problem happens only in __dev_map_flush(), not in
dev_map_flush_old(). dev_map_flush_old() is called only after nulling
out the corresponding netdev_map entry, so dev_map_free() never frees
the entry thus no such race happens there.

Fixes: a5e2da6e9787 ("bpf: netdev is never null in __dev_map_flush")
Signed-off-by: Toshiaki Makita <toshiaki.makita1@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 1e525d70f833..e001fb1a96b1 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -291,10 +291,10 @@ void __dev_map_flush(struct bpf_map *map)
 		if (unlikely(!dev))
 			continue;
 
-		__clear_bit(bit, bitmap);
-
 		bq = this_cpu_ptr(dev->bulkq);
 		bq_xmit_all(dev, bq, XDP_XMIT_FLUSH, true);
+
+		__clear_bit(bit, bitmap);
 	}
 }
 
-- 
2.20.1

