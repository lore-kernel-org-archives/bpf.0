Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454CC433EF
	for <bpf@archiver.kernel.org>; Tue, 14 Sep 2021 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B0B61165
	for <bpf@archiver.kernel.org>; Tue, 14 Sep 2021 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhINOk5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234634AbhINOk2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:40:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C888E60698;
        Tue, 14 Sep 2021 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630351;
        bh=Ts/h7mGNCMrQe1saq26gi6wFqSuBUa6bKhvGbOtlAa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpnQYub5dNKDYUSyo6O3HaHYuLKiLqspd0eSbO1C3vrjn8ox9Lz1q988hNxNy2w9H
         72ZmFw1Kqc1ccBkBW01idQLUEQ+XEx2z7AjBE4WKEyGIbk6RGz3CSWXlTTFURdiNGF
         lBoAKgvom6iP6iuIdPQwezqPcbgJLDbdHI+b8QHI6/RiwDfaaSKBnXnTU/IpoFYDxS
         tvBwvESfvuFP6sn1JJ4vxEF3l3Exyv8QXfC7g9tYldtGbuYKgi6+knlgMdzckd69tP
         qNlJW9ceBxSuNnGO0ZTj3y25rENNy8pBwjl0joQ22oAZWFaZRcC7HFAwACViuGWLMO
         3JWIm/3eVprjw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 04/27] csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
Date:   Tue, 14 Sep 2021 23:39:06 +0900
Message-Id: <163163034617.489837.7789033031868135258.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Punit Agrawal <punitagrawal@gmail.com>

The csky specific arch_check_ftrace_location() shadows a weak
implementation of the function in core code that offers the same
functionality but with additional error checking.

Drop the architecture specific function as a step towards further
cleanup in core code.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/csky/kernel/probes/ftrace.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index ef2bb9bd9605..b388228abbf2 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -2,13 +2,6 @@
 
 #include <linux/kprobes.h>
 
-int arch_check_ftrace_location(struct kprobe *p)
-{
-	if (ftrace_location((unsigned long)p->addr))
-		p->flags |= KPROBE_FLAG_FTRACE;
-	return 0;
-}
-
 /* Ftrace callback handler for kprobes -- called under preepmt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)

