Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F2C43334
	for <bpf@archiver.kernel.org>; Wed, 22 Jun 2022 03:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355815AbiFVDTz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jun 2022 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiFVDTz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 23:19:55 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483363123C;
        Tue, 21 Jun 2022 20:19:52 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id QZP00047;
        Wed, 22 Jun 2022 11:19:47 +0800
Received: from localhost.localdomain (10.49.41.6) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 22 Jun 2022 11:19:47 +0800
From:   Simon wang <wangchuanguo@inspur.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Simon Wang <wangchuanguo@inspur.com>
Subject: [PATCH] bpf: Replace 0 with BPF_K
Date:   Tue, 21 Jun 2022 23:19:23 -0400
Message-ID: <20220622031923.65692-1-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.41.6]
tUid:   2022622111947fb8a8e5ac3db23c86facd553ee87b236
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Simon Wang <wangchuanguo@inspur.com>

Enhance readability.

Signed-off-by: Simon Wang <wangchuanguo@inspur.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2859901ffbe3..29060f15daab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9064,7 +9064,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	if (opcode == BPF_END || opcode == BPF_NEG) {
 		if (opcode == BPF_NEG) {
-			if (BPF_SRC(insn->code) != 0 ||
+			if (BPF_SRC(insn->code) != BPF_K ||
 			    insn->src_reg != BPF_REG_0 ||
 			    insn->off != 0 || insn->imm != 0) {
 				verbose(env, "BPF_NEG uses reserved fields\n");
-- 
2.27.0

