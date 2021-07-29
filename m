Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC03C4338F
	for <bpf@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568D3601FF
	for <bpf@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbhG2OJt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238857AbhG2OH4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 10:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09D8A6054F;
        Thu, 29 Jul 2021 14:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567673;
        bh=3BqLLykrOHv7GrNy26CHO6BhcUQk9jcyV1ViRuIHq5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjTxoVNx+0CPwjmljDa3NUqVrbGdoOjCvICs8nqofQ/XQychD9hg5X6ssibECY6tn
         67q1Gd8e2eHBEmzpynESsCXjopJoU79oZHuQdKNWSfZe7Nd+/7nQDKcRUaQjm6U5Hs
         lSehCLOUB8VGPS13FYbmJA5NdhDAE/3CXUSePAX/vyodSvZ+cTWLnysDE+Qrw6GvZp
         9iwcAWEtSgY7JXG05r17TKwsnbSaKsmvoqjD99sRblYqfN2rHdkBuT4HDRLBRyd0VB
         8AxLrgrlo7pKw2LcLxNzJK0ccb8M/cX0gSItxBy5NCsFgBxH8kuBKSbE9FYtLaZmDA
         blciR1p3Yix+A==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v10 12/16] kprobes: Enable stacktrace from pt_regs in kretprobe handler
Date:   Thu, 29 Jul 2021 23:07:48 +0900
Message-Id: <162756766854.301564.16064835736239439658.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162756755600.301564.4957591913842010341.stgit@devnote2>
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the ORC unwinder from pt_regs requires setting up regs->ip
correctly, set the correct return address to the regs->ip before
calling user kretprobe handler.

This allows the kretrprobe handler to trace stack from the
kretprobe's pt_regs by stack_trace_save_regs() (eBPF will do
this), instead of stack tracing from the handler context by
stack_trace_save() (ftrace will do this).

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Changes in v9:
  - Update comment to explain specifically why this is necessary.
 Changes in v8:
  - Update comment to clarify why this is needed.
 Changes in v3:
  - Cast the correct_ret_addr to unsigned long.
---
 kernel/kprobes.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 833f07f33115..ebc587b9a346 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1937,6 +1937,13 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		BUG_ON(1);
 	}
 
+	/*
+	 * Set the return address as the instruction pointer, because if the
+	 * user handler calls stack_trace_save_regs() with this 'regs',
+	 * the stack trace will start from the instruction pointer.
+	 */
+	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
+
 	/* Run the user handler of the nodes. */
 	first = current->kretprobe_instances.first;
 	while (first) {

