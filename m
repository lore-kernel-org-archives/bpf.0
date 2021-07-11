Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BEC07E96
	for <bpf@archiver.kernel.org>; Sun, 11 Jul 2021 13:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DB161249
	for <bpf@archiver.kernel.org>; Sun, 11 Jul 2021 13:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhGKNiq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 11 Jul 2021 09:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232793AbhGKNiq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:38:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3ADA61263;
        Sun, 11 Jul 2021 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010559;
        bh=KEe5WdEyJHtzuPMGzpiocUmfrX3xOnunn5dZvpKwBh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulDlveFLXVACl8HaeNF/3m0OJQ1+NlqGefcHu9EImClMi5X3XIdle9at57NCOPkho
         e55OOTjufE4/oSnQxkWNnfhEtkNbnCkcnPLE8D13baghwFondUJ39WP5F79MTujI0v
         y8ryu0HPZkux45VM2tpAlksR01VbGhMv3PJLV0+UnN5FF4DglkiiImhI/YgE6YbkNs
         ptJiaFyfV7pT4/eoQRGinPBRCjWvPQFXVbGvtYl4vhSiZlgl7h13QQO41qJDcGjCOB
         UALxcPdIZsD/cwg042YUx+p6YCKqydsgz3YHQGt4KZR6LWM75IKfpkVaI7L0+76BGE
         OBZmyfgJfNy8A==
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
Subject: [PATCH -tip v9 07/14] ARC: Add instruction_pointer_set() API
Date:   Sun, 11 Jul 2021 22:35:55 +0900
Message-Id: <162601055519.1318837.6462239884384139709.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162601048053.1318837.1550594515476777588.stgit@devnote2>
References: <162601048053.1318837.1550594515476777588.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add instruction_pointer_set() API for arc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arc/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 4c3c9be5bd16..cca8d6583e31 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -149,6 +149,11 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return (long)regs->r0;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PTRACE_H */

