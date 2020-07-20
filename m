Return-Path: <SRS0=N7Fo=A7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E204C433E2
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1924222C9D
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 14:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgGTOKg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:10:36 -0400
Received: from foss.arm.com ([217.140.110.172]:48976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgGTOKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 10:10:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27B4CD6E;
        Mon, 20 Jul 2020 07:10:36 -0700 (PDT)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.210.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 00C553F718;
        Mon, 20 Jul 2020 07:10:32 -0700 (PDT)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, Song.Zhu@arm.com,
        Jianlin.Lv@arm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Generate cookie for new non-initial net NS
Date:   Mon, 20 Jul 2020 22:09:19 +0800
Message-Id: <20200720140919.22342-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For non-initial network NS, the net cookie is generated when
bpf_get_netns_cookie_sock is called for the first time, but it is more
reasonable to complete the cookie generation work when creating a new
network NS, just like init_net.
net_gen_cookie() be moved into setup_net() that it can serve the initial
and non-initial network namespace.

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
 net/core/net_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index dcd61aca343e..5937bd0df56d 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -336,6 +336,7 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	idr_init(&net->netns_ids);
 	spin_lock_init(&net->nsid_lock);
 	mutex_init(&net->ipv4.ra_mutex);
+	net_gen_cookie(net);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);
@@ -1101,7 +1102,6 @@ static int __init net_ns_init(void)
 		panic("Could not allocate generic netns");
 
 	rcu_assign_pointer(init_net.gen, ng);
-	net_gen_cookie(&init_net);
 
 	down_write(&pernet_ops_rwsem);
 	if (setup_net(&init_net, &init_user_ns))
-- 
2.17.1

