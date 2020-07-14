Return-Path: <SRS0=I/LR=AZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55834C433E3
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D37224F9
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594735024;
	bh=1pJytwJejZQnTfJpmOAYaRgg4T3M4iz5/khnbm9cSqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZf+xefk2S1azgXIuP/lAvxJT3pSHdnqdi4GqvYcdXnOzq3yLKvW/jEBwMQVzvahP
	 cxnZO341Stq3svPo0HKQakOicLNXH931mkel8a4QVwkO3Q1xhFiYCJXn45WZ/v2TKR
	 l3f3QxTnemEAUzic90sqHIYsM3zjxtgKjF3ZGeWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgGNN5D (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgGNN5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 09:57:03 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DBA224F4;
        Tue, 14 Jul 2020 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594735023;
        bh=1pJytwJejZQnTfJpmOAYaRgg4T3M4iz5/khnbm9cSqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYzP35GFjkIh7LiYeNm95fAIQyOAvmkshic9dfDL7g/c2jWwZ2Go636m5+RXBerAU
         GtmGofpFLPSmwK3ntPoVsvs6OiRVBcv2LV+3sslQ0txMPGGESjhWpHqxN1entTOXvL
         sp/4tnM21UWfwz1xyQwMlUoiTV+i/ylN3lDdYaKw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, brouer@redhat.com,
        daniel@iogearbox.net, toke@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH v7 bpf-next 1/9] cpumap: use non-locked version __ptr_ring_consume_batched
Date:   Tue, 14 Jul 2020 15:56:34 +0200
Message-Id: <a9c7d06f9a009e282209f0c8c7b2c5d9b9ad60b9.1594734381.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594734381.git.lorenzo@kernel.org>
References: <cover.1594734381.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

Commit 77361825bb01 ("bpf: cpumap use ptr_ring_consume_batched") changed
away from using single frame ptr_ring dequeue (__ptr_ring_consume) to
consume a batched, but it uses a locked version, which as the comment
explain isn't needed.

Change to use the non-locked version __ptr_ring_consume_batched.

Fixes: 77361825bb01 ("bpf: cpumap use ptr_ring_consume_batched")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 kernel/bpf/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index bd8658055c16..323c91c4fab0 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -259,7 +259,7 @@ static int cpu_map_kthread_run(void *data)
 		 * kthread CPU pinned. Lockless access to ptr_ring
 		 * consume side valid as no-resize allowed of queue.
 		 */
-		n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
+		n = __ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
 
 		for (i = 0; i < n; i++) {
 			void *f = frames[i];
-- 
2.26.2

