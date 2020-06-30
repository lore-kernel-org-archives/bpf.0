Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D842C433DF
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F46206B6
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593521457;
	bh=1pJytwJejZQnTfJpmOAYaRgg4T3M4iz5/khnbm9cSqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fs2WfYVLHxEu/yc2bno0PX/QA88K0gnrr5XJYheSggXvbItitvYH/pQAWzo7/IDRp
	 GuOd6AF6iQVJ/QSwNzc8KcQPJUhp+FbfPAOfuzQjKxaln9VUFfqfS8dKcq/bI97BUn
	 JI3lWlGmwu/L/+gnqRfuAPGMHlTtmQnwHNvtCcdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbgF3Mu4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387844AbgF3Mu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 08:50:56 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E26E2068F;
        Tue, 30 Jun 2020 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593521456;
        bh=1pJytwJejZQnTfJpmOAYaRgg4T3M4iz5/khnbm9cSqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hgf3gFZ/8UeEezWRUhJCEg5ik8Dlgj7OcHemmaja+QH9nLFG31CEvEyK96jYEX1YH
         hHqBxK+s4McElVpDCfCvkBZ2j6IzHy7Yr0TaD7mlD9JPzzDOlA2MUqC2rsjaT7kUSq
         CJI0guAsUMGfY9uTiwjuWms3oqLVqY/fXOBhGUz4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, brouer@redhat.com,
        daniel@iogearbox.net, toke@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH v5 bpf-next 1/9] cpumap: use non-locked version __ptr_ring_consume_batched
Date:   Tue, 30 Jun 2020 14:49:36 +0200
Message-Id: <cb522c1042e24f9d3a23f41ceb8645003de26135.1593521030.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593521029.git.lorenzo@kernel.org>
References: <cover.1593521029.git.lorenzo@kernel.org>
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

