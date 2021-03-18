Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12F1C433DB
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 02:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835E464F30
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 02:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCRCth (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Mar 2021 22:49:37 -0400
Received: from foss.arm.com ([217.140.110.172]:55866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhCRCtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 22:49:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C352ED1;
        Wed, 17 Mar 2021 19:49:17 -0700 (PDT)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E86D3F70D;
        Wed, 17 Mar 2021 19:49:13 -0700 (PDT)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jianlin.Lv@arm.com, iecedge@gmail.com
Subject: [PATCH bpf-next] bpf: Remove insn_buf[] declaration in inner block
Date:   Thu, 18 Mar 2021 10:48:51 +0800
Message-Id: <20210318024851.49693-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two insn_buf[16] variables are declared in the function, which act on
function scope and block scope respectively.
The statement in the inner blocks is redundant, so remove it.

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
 kernel/bpf/verifier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9096b049cd6..e26c5170c953 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11899,7 +11899,6 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
 			const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
 			const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
-			struct bpf_insn insn_buf[16];
 			struct bpf_insn *patch = &insn_buf[0];
 			bool issrc, isneg;
 			u32 off_reg;
-- 
2.25.1

