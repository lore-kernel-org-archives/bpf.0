Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92024C47089
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 06:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C962613DA
	for <bpf@archiver.kernel.org>; Thu, 27 May 2021 06:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhE0Glx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 May 2021 02:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234577AbhE0Glr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 02:41:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DC3F613D8;
        Thu, 27 May 2021 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622097614;
        bh=eXubxiP2sfbDRxWXxCS2276qipPi7ZT+e19fUSeI+18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dU7CjDA1uwiyW26ZV7qYVU3P5HM/Ie2nnUFZwZrv9CLlLIuvPoyey34RKEw5hNuiZ
         5IafSvQu8qDI00Q3gXrjTz/E9t6TD6UWLiQaskFOHbsew2FVqoxG41kYv5wosvae4I
         xOgEvKU9xco8enDku5a00IrhgEOsSQxy549sOc4GVNelM0Ey4jwpXxXeatLzqh/8UR
         1XGjG56Pczz2O4WU63GdZHnbFJwTfs80csf+UQEm5Dg1YhcZ9iZJhtp4YDtwf3k3if
         Mwh9Oll7aHgI6Ce5sXuk+i7UO2JQxDizrwFuaxV8yo5VAx0Jizz2cGt6wayerVuBzD
         RVibQBF086j9A==
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
Subject: [PATCH -tip v7 07/13] ia64: Add instruction_pointer_set() API
Date:   Thu, 27 May 2021 15:40:10 +0900
Message-Id: <162209761027.436794.703331939926656169.stgit@devnote2>
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

Add instruction_pointer_set() API for ia64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v4:
   - Make the API macro for avoiding a build error.
---
 arch/ia64/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index 08179135905c..a024afbc70e5 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -51,6 +51,11 @@
  * the canonical representation by adding to instruction pointer.
  */
 # define instruction_pointer(regs) ((regs)->cr_iip + ia64_psr(regs)->ri)
+# define instruction_pointer_set(regs, val)	\
+  ({						\
+	ia64_psr(regs)->ri = (val & 0xf);	\
+	regs->cr_iip = (val & ~0xfULL);		\
+  })
 
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {

