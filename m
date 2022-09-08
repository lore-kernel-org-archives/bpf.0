Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE012C6FA83
	for <bpf@archiver.kernel.org>; Thu,  8 Sep 2022 04:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiIHEOk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIHENu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 00:13:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BAC6EB5;
        Wed,  7 Sep 2022 21:13:19 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MNQcj508QzmVGj;
        Thu,  8 Sep 2022 12:09:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 12:13:16 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <martin.lau@linux.dev>
CC:     <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <ast@kernel.org>, <andrii@kernel.org>, <song@kernel.org>,
        <yhs@fb.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3 12/22] net: sched: act_mirred: get rid of tcf_mirred_walker and tcf_mirred_search
Date:   Thu, 8 Sep 2022 12:14:44 +0800
Message-ID: <20220908041454.365070-13-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908041454.365070-1-shaozhengchao@huawei.com>
References: <20220908041454.365070-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tcf_mirred_walker() and tcf_mirred_search() do the same thing as generic
walk/search function, so remove them.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 56877dd19375..f9c14d4188d4 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -372,23 +372,6 @@ static int tcf_mirred_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	return -1;
 }
 
-static int tcf_mirred_walker(struct net *net, struct sk_buff *skb,
-			     struct netlink_callback *cb, int type,
-			     const struct tc_action_ops *ops,
-			     struct netlink_ext_ack *extack)
-{
-	struct tc_action_net *tn = net_generic(net, act_mirred_ops.net_id);
-
-	return tcf_generic_walker(tn, skb, cb, type, ops, extack);
-}
-
-static int tcf_mirred_search(struct net *net, struct tc_action **a, u32 index)
-{
-	struct tc_action_net *tn = net_generic(net, act_mirred_ops.net_id);
-
-	return tcf_idr_search(tn, a, index);
-}
-
 static int mirred_device_event(struct notifier_block *unused,
 			       unsigned long event, void *ptr)
 {
@@ -509,8 +492,6 @@ static struct tc_action_ops act_mirred_ops = {
 	.dump		=	tcf_mirred_dump,
 	.cleanup	=	tcf_mirred_release,
 	.init		=	tcf_mirred_init,
-	.walk		=	tcf_mirred_walker,
-	.lookup		=	tcf_mirred_search,
 	.get_fill_size	=	tcf_mirred_get_fill_size,
 	.offload_act_setup =	tcf_mirred_offload_act_setup,
 	.size		=	sizeof(struct tcf_mirred),
-- 
2.17.1

