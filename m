Return-Path: <SRS0=32pG=TQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE3C04AB4
	for <bpf@archiver.kernel.org>; Thu, 16 May 2019 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B8F20833
	for <bpf@archiver.kernel.org>; Thu, 16 May 2019 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558007276;
	bh=KJF1ohD+GanVF7AGlDAg7a2PMSbc/5DsGZC2yHEZO0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBQOkHxrIL5nZV4WBElP6atcIXBZvG/KFbA2/3NcEdFQxBLQcR4DmY8ec7oWk8a65
	 kbCp1OQg0S01Ib7WD5HYm9BEuya4B8ZyGBjDrtUT/RViCWBBN3a34GrA/G+oalspjF
	 lmqr9GSaG63nj6CfzsPp1hg3Z4qdP/rVUNLjmS5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEPLkH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 May 2019 07:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfEPLkE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 May 2019 07:40:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9A020862;
        Thu, 16 May 2019 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006803;
        bh=KJF1ohD+GanVF7AGlDAg7a2PMSbc/5DsGZC2yHEZO0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq+B5EM+bhZb70rts1oQMAu/fYkg1fUE1yHH9cjFSypxsCeS9uUNndXiwa5YbjTq6
         8gLD/VIS8ikr8QRQ9R+vCBPQMRzskQocqKDrkziVnzLRvoZ2S73E3o2UHXg0uP07BF
         qfd4RRAd/GJPCRDQjmOT7fHwa4jmevukLVjr8S8Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 23/34] bpf: Fix preempt_enable_no_resched() abuse
Date:   Thu, 16 May 2019 07:39:20 -0400
Message-Id: <20190516113932.8348-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516113932.8348-1-sashal@kernel.org>
References: <20190516113932.8348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 0edd6b64d1939e9e9168ff27947995bb7751db5d ]

Unless the very next line is schedule(), or implies it, one must not use
preempt_enable_no_resched(). It can cause a preemption to go missing and
thereby cause arbitrary delays, breaking the PREEMPT=y invariant.

Cc: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e734f163bd0b9..1fbd7672e4b37 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -455,7 +455,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		}					\
 _out:							\
 		rcu_read_unlock();			\
-		preempt_enable_no_resched();		\
+		preempt_enable();			\
 		_ret;					\
 	 })
 
-- 
2.20.1

