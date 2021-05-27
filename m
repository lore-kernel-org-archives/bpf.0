Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7E5C47089
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 06:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF45613CC
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 06:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhE0Gku (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 May 2021 02:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233414AbhE0Gkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 02:40:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CB3D613D4;
        Thu, 27 May 2021 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622097556;
        bh=lruHPAWz+JCx1JmZ/0Vse4XTb21USc/CY1aMZrfI25g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qztL6YhqvjJ9dvyMGsJPM2z95Dd8HNrJaTC+KROWXqCHDQlxP/k/B9V64aOlNa1We
         ooh4G2ZzmvVlENXeCerxYmf8bnAeUGqIWxHQkoktDHApA8g8v1r5SqywduNtaURjF/
         91SnMLIuoO894AYRTH6WqYJpB5POMFTys8M2IrvbFcUdywv37giX5t27Cq12NK65hO
         IbIOQkAb7G7Cyc8rjC69AiN4bsKE3eLt2wg3E5f/0zfHB4i9u0TnImX4rdNVzn3gS3
         KNh/Wkz4U0sll8SK2mNg6tjRjzucSEZOfPDskHen8ik5lBlIEfZppgjCdgbUI9qybX
         I8HkjHW1bA5FQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v7 01/13] ia64: kprobes: Fix to pass correct trampoline address to the handler
Date:   Thu, 27 May 2021 15:39:12 +0900
Message-Id: <162209755266.436794.8129663087781463352.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162209754288.436794.3904335049560916855.stgit@devnote2>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
missed to pass the wrong trampoline address (it passes the descriptor address
instead of function entry address).
This fixes it to pass correct trampoline address to __kretprobe_trampoline_handler().
This also changes to use correct symbol dereference function to get the
function address from the kretprobe_trampoline.

Fixes: e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
  - Fix a compile error typo.
---
 arch/ia64/kernel/kprobes.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index fc1ff8a4d7de..ca4b4fa45aef 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -398,7 +398,8 @@ static void kretprobe_trampoline(void)
 
 int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
+	regs->cr_iip = __kretprobe_trampoline_handler(regs,
+		dereference_function_descriptor(kretprobe_trampoline), NULL);
 	/*
 	 * By returning a non-zero value, we are telling
 	 * kprobe_handler() that we don't want the post_handler
@@ -414,7 +415,7 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
-	regs->b0 = ((struct fnptr *)kretprobe_trampoline)->ip;
+	regs->b0 = (unsigned long)dereference_function_descriptor(kretprobe_trampoline);
 }
 
 /* Check the instruction in the slot is break */
@@ -918,14 +919,14 @@ static struct kprobe trampoline_p = {
 int __init arch_init_kprobes(void)
 {
 	trampoline_p.addr =
-		(kprobe_opcode_t *)((struct fnptr *)kretprobe_trampoline)->ip;
+		dereference_function_descriptor(kretprobe_trampoline);
 	return register_kprobe(&trampoline_p);
 }
 
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	if (p->addr ==
-		(kprobe_opcode_t *)((struct fnptr *)kretprobe_trampoline)->ip)
+		dereference_function_descriptor(kretprobe_trampoline))
 		return 1;
 
 	return 0;

