Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F85C64E75
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 09:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA432466D
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 09:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="eEWyVZhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKQJlU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Nov 2020 04:41:20 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:10411 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQJlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 04:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1605606080; x=1637142080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+7noeoH7kZjzLDKf5z3YvNItSMxEV1uiKyWB4NySDiQ=;
  b=eEWyVZhePVq05yoGDnVYEIMFgDcg3NN0xEP7SJ23y9a8qDpZhMS2Vhdt
   kgzJiDpH8QZtpUqx2J2k/R06ZBWws8r5tzo3mGcJSAmneJ5R3gBaES7Ma
   LmgqbQ5nfPC3/ACcNlIaGTyJuhsgecYKC9GDG6hhMKNuhBCBwkdXgaVPk
   w=;
X-IronPort-AV: E=Sophos;i="5.77,485,1596499200"; 
   d="scan'208";a="66876881"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 17 Nov 2020 09:41:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 33D1AA0570;
        Tue, 17 Nov 2020 09:41:18 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 09:41:17 +0000
Received: from 38f9d3582de7.ant.amazon.com.com (10.43.161.237) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 09:41:07 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next 1/8] net: Introduce net.ipv4.tcp_migrate_req.
Date:   Tue, 17 Nov 2020 18:40:16 +0900
Message-ID: <20201117094023.3685-2-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20201117094023.3685-1-kuniyu@amazon.co.jp>
References: <20201117094023.3685-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D07UWA003.ant.amazon.com (10.43.160.35) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds a new sysctl option: net.ipv4.tcp_migrate_req. If this
option is enabled, and then we call listen() for SO_REUSEPORT enabled
sockets and close one, we will be able to migrate its child sockets to
another listener.

Reviewed-by: Benjamin Herrenschmidt <benh@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 Documentation/networking/ip-sysctl.rst | 15 +++++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index dd2b12a32b73..4116771bf5ef 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -712,6 +712,21 @@ tcp_syncookies - INTEGER
 	network connections you can set this knob to 2 to enable
 	unconditionally generation of syncookies.
 
+tcp_migrate_req - INTEGER
+	By default, when a listening socket is closed, child sockets are also
+	closed. If it has SO_REUSEPORT enabled, the dropped connections should
+	have been accepted by other listeners on the same port. This option
+	makes it possible to migrate child sockets to another listener when
+	calling close() or shutdown().
+
+	Default: 0
+
+	Note that the source and destination listeners _must_ have the same
+	settings at the socket API level. If there are different kinds of
+	sockets on the port, disable this option or use
+	BPF_PROG_TYPE_SK_REUSEPORT program to select the correct socket by
+	bpf_sk_select_reuseport() or to cancel migration by returning SK_DROP.
+
 tcp_fastopen - INTEGER
 	Enable TCP Fast Open (RFC7413) to send and accept data in the opening
 	SYN packet.
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8e4fcac4df72..a3edc30d6a63 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -132,6 +132,7 @@ struct netns_ipv4 {
 	int sysctl_tcp_syn_retries;
 	int sysctl_tcp_synack_retries;
 	int sysctl_tcp_syncookies;
+	int sysctl_tcp_migrate_req;
 	int sysctl_tcp_reordering;
 	int sysctl_tcp_retries1;
 	int sysctl_tcp_retries2;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 3e5f4f2e705e..6b76298fa271 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -933,6 +933,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dointvec
 	},
 #endif
+	{
+		.procname	= "tcp_migrate_req",
+		.data		= &init_net.ipv4.sysctl_tcp_migrate_req,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	{
 		.procname	= "tcp_reordering",
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
-- 
2.17.2 (Apple Git-113)

