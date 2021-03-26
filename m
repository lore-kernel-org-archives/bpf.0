Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924C2C433C1
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 12:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5666D61949
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 12:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhCZMaG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhCZM3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:29:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD91861949;
        Fri, 26 Mar 2021 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616761783;
        bh=KEe5WdEyJHtzuPMGzpiocUmfrX3xOnunn5dZvpKwBh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5YZRvu0OwwHcf4MMZEVSI4g24EhaST1TvSh+gQZAjkzw4re5UXCA7xqpFJO8l4uX
         SZioqtoTk8ne0YwzTNgSfedODKPm94Jlk4QpAd5IjwlTGSF0SWoovgOWA2ulLKYykQ
         Ey9yZ5mywNqjB9QPxXKcKV7EdcvTe3ezd29l1HdUdZkBoX9KRaKaeQCrmaAxxVNsOq
         FEsD+vYGyEW6yd0ZBBsn6UF5BitfpKcxP6JXjICqcabqZ8p4ipztLJkhC+a3LT9zcD
         xpp2tk9knV0wum1CsS4ADYOF1u08ahbg7UXRN/IqB0pgEfIZMDUfDeKLu/rgK7MBWy
         bLJ8uS4f1PRQg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: [PATCH -tip v5 06/12] ARC: Add instruction_pointer_set() API
Date:   Fri, 26 Mar 2021 21:29:33 +0900
Message-Id: <161676177318.330141.5557920432730866080.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161676170650.330141.6214727134265514123.stgit@devnote2>
References: <161676170650.330141.6214727134265514123.stgit@devnote2>
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

