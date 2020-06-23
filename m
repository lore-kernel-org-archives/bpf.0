Return-Path: <SRS0=QOwA=AE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF42C433E3
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 21:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72B320CC7
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948405;
	bh=1pJytwJejZQnTfJpmOAYaRgg4T3M4iz5/khnbm9cSqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tRBnGuZAKal1hRQRkdakYPDYDs9cdCeqy5VXSlfKwb4d5LyYRl+Y7gc4upLWcLHn5
	 7t/oOsLz7KTeGLujF59P1Ir8MZBedtCgqUkLOR7cRHeUO00BfwyvWj3G5pMaqlmYhz
	 Ts6oBcub0gXR0UusWyY50ymsSZrhujt6kUfWzw7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393621AbgFWVkD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388546AbgFWVjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 17:39:54 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16532072E;
        Tue, 23 Jun 2020 21:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592948394;
        bh=1pJytwJejZQnTfJpmOAYaRgg4T3M4iz5/khnbm9cSqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDhAuM1QaPWxQKhV60o9eyw5pLFNTiX3w2nq+7UntMwk0fs6QEHLfl5UXzjRTImxe
         BTDu+Ep/AUx5PUX6bGu+YIEn+i0U2QUh9TuwEVO/vJKItid/F5SjBCJYuKDTJAKnIX
         f2mEM/6qTQvIinTfumzqg5mhIKV8OCnVXbkpWIuA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, brouer@redhat.com,
        daniel@iogearbox.net, toke@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH v3 bpf-next 1/9] cpumap: use non-locked version __ptr_ring_consume_batched
Date:   Tue, 23 Jun 2020 23:39:26 +0200
Message-Id: <3d87bb527b7fc7159aaf2229d661e59c895ac54e.1592947694.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592947694.git.lorenzo@kernel.org>
References: <cover.1592947694.git.lorenzo@kernel.org>
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

