Return-Path: <SRS0=JwFc=W7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B98C3A5A8
	for <bpf@archiver.kernel.org>; Wed,  4 Sep 2019 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F021670
	for <bpf@archiver.kernel.org>; Wed,  4 Sep 2019 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567614038;
	bh=YGUky5l4b/jTQwvCUKgf0yLafhrXcctKofNMlj9R7Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SvkpRC3m7iLWnLcgp92ul3CCPubawfk1w1A5Xb8zxZMbnBO7vM7+5BHW3n3GFLlbS
	 0WBnrHgDKqF20XkcOJqMlIfsZpKDoAc9q9i5EEsp9Ur2DguXJrxxVwyDpAipdkYcIj
	 RA28cwTcp0sbBU5Pk+oupO+6lrGdqpzmSg4dMTYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfIDP57 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbfIDP57 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 11:57:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5C9A2339D;
        Wed,  4 Sep 2019 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612677;
        bh=YGUky5l4b/jTQwvCUKgf0yLafhrXcctKofNMlj9R7Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njD40NO5VII8q3Bwcr/8N0eljOmAa9T5kqgvD1iT0CVk+wVr/n5CzPb2TTeV18H4Z
         td1ze3C75fYc24MOZxOc5jf/nVoLDbfsj4J/WCBqcGWq+A85U5XP4qtFHDYEoPCNOQ
         ZPaSqIA+rHKBOjFClrJUigmLAJRO6C8GOaMxn+MY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 10/94] s390/bpf: fix lcgr instruction encoding
Date:   Wed,  4 Sep 2019 11:56:15 -0400
Message-Id: <20190904155739.2816-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit bb2d267c448f4bc3a3389d97c56391cb779178ae ]

"masking, test in bounds 3" fails on s390, because
BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0) ignores the top 32 bits of
BPF_REG_2. The reason is that JIT emits lcgfr instead of lcgr.
The associated comment indicates that the code was intended to
emit lcgr in the first place, it's just that the wrong opcode
was used.

Fix by using the correct opcode.

Fixes: 054623105728 ("s390/bpf: Add s390x eBPF JIT compiler backend")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 5e7c630331590..9a711472cbdc0 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -853,7 +853,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		break;
 	case BPF_ALU64 | BPF_NEG: /* dst = -dst */
 		/* lcgr %dst,%dst */
-		EMIT4(0xb9130000, dst_reg, dst_reg);
+		EMIT4(0xb9030000, dst_reg, dst_reg);
 		break;
 	/*
 	 * BPF_FROM_BE/LE
-- 
2.20.1

