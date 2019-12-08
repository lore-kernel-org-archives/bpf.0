Return-Path: <SRS0=6yca=Z6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1515BC43603
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 00:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BE524673
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 00:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLHAEJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 7 Dec 2019 19:04:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44928 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfLHAEJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Dec 2019 19:04:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C7EEB15449D7D;
        Sat,  7 Dec 2019 16:04:08 -0800 (PST)
Date:   Sat, 07 Dec 2019 16:04:08 -0800 (PST)
Message-Id: <20191207.160408.1854593319545864289.davem@davemloft.net>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
CC:     ast@kernel.org, daniel@iogearbox.net, tglx@linutronix.de
Subject: [RFC v1 PATCH 1/7] RT: Add local lock stubs.
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Dec 2019 16:04:09 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


This will allow us to annotate BPF function calls in
mainline.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 include/linux/locallock.h | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/linux/locallock.h

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
new file mode 100644
index 000000000000..38ecf5bdf99d
--- /dev/null
+++ b/include/linux/locallock.h
@@ -0,0 +1,41 @@
+#ifndef _LINUX_LOCALLOCK_H
+#define _LINUX_LOCALLOCK_H
+
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+
+#define DEFINE_LOCAL_IRQ_LOCK(lvar)		__typeof__(const int) lvar
+#define DECLARE_LOCAL_IRQ_LOCK(lvar)		extern __typeof__(const int) lvar
+
+static inline void local_irq_lock_init(int lvar) { }
+
+#define local_trylock(lvar)					\
+	({							\
+		preempt_disable();				\
+		1;						\
+	})
+
+#define __local_lock(lvar)			do { } while (0)
+#define __local_unlock(lvar)			do { } while (0)
+#define local_lock(lvar)			preempt_disable()
+#define local_unlock(lvar)			preempt_enable()
+#define local_lock_irq(lvar)			local_irq_disable()
+#define local_unlock_irq(lvar)			local_irq_enable()
+#define local_lock_irqsave(lvar, flags)		local_irq_save(flags)
+#define local_unlock_irqrestore(lvar, flags)	local_irq_restore(flags)
+
+#define local_spin_trylock_irq(lvar, lock)	spin_trylock_irq(lock)
+#define local_spin_lock_irq(lvar, lock)		spin_lock_irq(lock)
+#define local_spin_unlock_irq(lvar, lock)	spin_unlock_irq(lock)
+#define local_spin_lock_irqsave(lvar, lock, flags)	\
+	spin_lock_irqsave(lock, flags)
+#define local_spin_unlock_irqrestore(lvar, lock, flags)	\
+	spin_unlock_irqrestore(lock, flags)
+
+#define get_locked_var(lvar, var)		get_cpu_var(var)
+#define put_locked_var(lvar, var)		put_cpu_var(var)
+
+#define local_lock_cpu(lvar)			get_cpu()
+#define local_unlock_cpu(lvar)			put_cpu()
+
+#endif
-- 
2.20.1

