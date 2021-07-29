Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38FBC432BE
	for <bpf@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBE960F5C
	for <bpf@archiver.kernel.org>; Thu, 29 Jul 2021 14:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbhG2OJr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238768AbhG2OHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 10:07:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 113606054E;
        Thu, 29 Jul 2021 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567663;
        bh=jM/E5qbkTRhtXvBgC/DCoql0xzq9kLErr23TZymhaCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mArCi44kmWgrgoAPAnc6QdVP+WSo6vRzMMD+9HpCpuSIXmZTsYIgccnYpJBCIWM4s
         p5QpWQmphYMSlf6P8L2angS+Pyl132mPSbfRl31ygOOZhCts5as4M4TSZ5zFU1zyN5
         0APh5um3Qk9J75LKkenxB64xs8J8+/KES8itpoEIUQOl0UCW4eS934BQjy/VUj7GPG
         T/RnqPpnfDTn9hXL+fqZA5TkM8ZF+XqFMDTgFznUTmsAivfgl+nsek2jYZd9NCAMDz
         vBgn3jlKZNOyboH9GqzH0lpFzLx+izb7gNZhYv7Ohk2nfpOf/+R5AFSHbgpA22s0Ie
         bF4E7Vg8ug6gA==
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
Subject: [PATCH -tip v10 11/16] arm: kprobes: Make space for instruction pointer on stack
Date:   Thu, 29 Jul 2021 23:07:39 +0900
Message-Id: <162756765964.301564.5697343919087076371.stgit@devnote2>
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

Since arm's __kretprobe_trampoline() saves partial 'pt_regs' on the
stack, 'regs->ARM_pc' (instruction pointer) is not accessible from
the kretprobe handler. This means if instruction_pointer_set() is
used from kretprobe handler, it will break the data on the stack.

Make space for instruction pointer (ARM_pc) on the stack in the
__kretprobe_trampoline() for fixing this problem.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v9:
  - Update changelog.
---
 arch/arm/probes/kprobes/core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 67ce7eb8f285..95f23b47ba27 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -376,11 +376,13 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 void __naked __kprobes __kretprobe_trampoline(void)
 {
 	__asm__ __volatile__ (
+		"sub	sp, sp, #16		\n\t"
 		"stmdb	sp!, {r0 - r11}		\n\t"
 		"mov	r0, sp			\n\t"
 		"bl	trampoline_handler	\n\t"
 		"mov	lr, r0			\n\t"
 		"ldmia	sp!, {r0 - r11}		\n\t"
+		"add	sp, sp, #16		\n\t"
 #ifdef CONFIG_THUMB2_KERNEL
 		"bx	lr			\n\t"
 #else

