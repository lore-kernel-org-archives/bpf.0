Return-Path: <SRS0=6yca=Z6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB4BC43603
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 00:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD2A24673
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 00:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfLHAE6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 7 Dec 2019 19:04:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45000 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfLHAE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Dec 2019 19:04:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7090E1544B9A8;
        Sat,  7 Dec 2019 16:04:57 -0800 (PST)
Date:   Sat, 07 Dec 2019 16:04:57 -0800 (PST)
Message-Id: <20191207.160457.297470232945357742.davem@davemloft.net>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
CC:     ast@kernel.org, daniel@iogearbox.net, tglx@linutronix.de
Subject: [RFC v1 PATCH 7/7] bpf: Don't use tasklet in stackmap code when RT.
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Dec 2019 16:04:57 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


In the RT kernel we can't use up_read_non_owner().

So in such a configuration, simply elide the annotated stackmap and
just report the raw IPs.

In the longer term, we can make atomic friendly versions of the page
cache traversal which will at least provide the info if the pages are
resident and don't need to be paged in.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 kernel/bpf/stackmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index caca752ee5e6..d49b5f184082 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -288,10 +288,17 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	struct stack_map_irq_work *work = NULL;
 
 	if (irqs_disabled()) {
+#ifdef CONFIG_PREEMPT_RT_FULL
+		/* We cannot use the up_read_non_owner() interface in RT
+		 * kernels, so just force reporting of IPs.
+		 */
+		irq_work_busy = true;
+#else
 		work = this_cpu_ptr(&up_read_work);
 		if (work->irq_work.flags & IRQ_WORK_BUSY)
 			/* cannot queue more up_read, fallback */
 			irq_work_busy = true;
+#endif
 	}
 
 	/*
-- 
2.20.1

