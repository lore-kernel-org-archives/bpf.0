Return-Path: <SRS0=+bqE=YK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADCECE58E
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 09:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680B621848
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 09:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439365AbfJQJFE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:05:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfJQJFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 05:05:04 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iL1iP-00046j-1i; Thu, 17 Oct 2019 11:05:01 +0200
Date:   Thu, 17 Oct 2019 11:05:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     bpf@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191017090500.ienqyium2phkxpdo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Disable BPF on PREEMPT_RT because
- it allocates and frees memory in atomic context
- it uses up_read_non_owner()
- BPF_PROG_RUN() expects to be invoked in non-preemptible context

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I tried to fix the memory allocations in 
  http://lkml.kernel.org/r/20190410143025.11997-1-bigeasy@linutronix.de

but I have no idea how to address the other two issues.

 init/Kconfig    |    1 +
 net/kcm/Kconfig |    1 +
 2 files changed, 2 insertions(+)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1629,6 +1629,7 @@ config KALLSYMS_BASE_RELATIVE
 # syscall, maps, verifier
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
+	depends on !PREEMPT_RT
 	select BPF
 	select IRQ_WORK
 	default n
--- a/net/kcm/Kconfig
+++ b/net/kcm/Kconfig
@@ -3,6 +3,7 @@
 config AF_KCM
 	tristate "KCM sockets"
 	depends on INET
+	depends on !PREEMPT_RT
 	select BPF_SYSCALL
 	select STREAM_PARSER
 	---help---
