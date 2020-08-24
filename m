Return-Path: <SRS0=dkA9=CC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F41DC433E1
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 14:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE38206F0
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 14:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHXOUx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 10:20:53 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D20C061573;
        Mon, 24 Aug 2020 07:20:51 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BZvRg5Lbbzvjc1; Mon, 24 Aug 2020 16:20:47 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH bpf] bpf, sysctl: let bpf_stats_handler take a kernel pointer buffer
Date:   Mon, 24 Aug 2020 16:20:47 +0200
Message-Id: <20200824142047.22043-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
changed ctl_table.proc_handler to take a kernel pointer. Adjust the
signature of bpf_stats_handler to match ctl_table.proc_handler which
fixes the following sparse warning:

kernel/sysctl.c:226:49: warning: incorrect type in argument 3 (different address spaces)
kernel/sysctl.c:226:49:    expected void *
kernel/sysctl.c:226:49:    got void [noderef] __user *buffer
kernel/sysctl.c:2640:35: warning: incorrect type in initializer (incompatible argument 3 (different address spaces))
kernel/sysctl.c:2640:35:    expected int ( [usertype] *proc_handler )( ... )
kernel/sysctl.c:2640:35:    got int ( * )( ... )

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 kernel/sysctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f91717..09e70ee2332e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -204,8 +204,7 @@ static int max_extfrag_threshold = 1000;
 
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
 static int bpf_stats_handler(struct ctl_table *table, int write,
-			     void __user *buffer, size_t *lenp,
-			     loff_t *ppos)
+			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
 	static int saved_val;
-- 
2.27.0

