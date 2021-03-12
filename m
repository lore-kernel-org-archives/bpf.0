Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9200C433E0
	for <bpf@archiver.kernel.org>; Fri, 12 Mar 2021 06:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BE364F80
	for <bpf@archiver.kernel.org>; Fri, 12 Mar 2021 06:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhCLGna (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Mar 2021 01:43:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhCLGm4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 01:42:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA80E64EB6;
        Fri, 12 Mar 2021 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531376;
        bh=KEe5WdEyJHtzuPMGzpiocUmfrX3xOnunn5dZvpKwBh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyjz33PEptJjlnaDrLIpjQkQLp+N8OZ4wTn++a5LT6iMaw7eU72SRN6MzsHHKjjTz
         dCoXx2gp9h1fVvKfqZRwWxQ0yqRLwoz0jbXJ8S27kNrOcBH+ioBzrGZcJcrOJOM1O8
         T/qbp51vPwXNvX34MIJfWZ/uSGJXvjgT3zYQFA3oaIy3OZ3bk/0GQ2chCAUlSZqybg
         bbKJioXnweMKrcGPYoFqhq9JSDlgOcaT5GguaYQT/ST2zNessY0UCkBg/u7yjgdLZG
         XDSmAdxBlgu+TUMJbiHGNCz3CwXZTQlW/FCcZiuaFODPV7MSYL38SSbxgL2vH2k236
         HQH/wbX2/Gdtg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip v2 06/10] ARC: Add instruction_pointer_set() API
Date:   Fri, 12 Mar 2021 15:42:50 +0900
Message-Id: <161553137020.1038734.7275687549596878670.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161553130371.1038734.7661319550287837734.stgit@devnote2>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
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

