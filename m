Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC7DC433E0
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35224206C0
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FQHKTBle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgF3R3f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgF3R3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 13:29:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BBC061755;
        Tue, 30 Jun 2020 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=wl8EAQlU5U9NfFNfWCICO6BKBWbdzGclG26DsxfSj2g=; b=FQHKTBle1w7XJi6kZa+YzV7bRx
        2Tr7Hr/5HbN8FfopyB2yWisfPt3LhRHCvEXaGrVDsVnYxilLbz8a3152bIxY3sqIN+lbZyW8pmbII
        RqZBxiLVWcpKtJVlY4fFzjKMvW41HASMcny9V2DcmC18iafHUzxIB3m0pX11FLL6m07yh7bsCgud9
        ICD8LC55/t9PtbIiWqP99ACqBdaHbsIP1Tm3dY9zRcHgFusyR/zxiF27cLAL72uUZY07dNp7ksOMP
        jYvX10BaKeS+kVfzRaqyBipx0ZOJzHaTzPsbrT+RIpILXcmWbacJOVkRriwvNERFYeIyLKxfvcCwB
        wHQqQ5EA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqK4J-0004Iy-EV; Tue, 30 Jun 2020 17:29:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        David Miller <davem@davemloft.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] bpf: fix net/core/filter build errors when INET is not
 enabled
Message-ID: <b1a858ec-7e04-56bc-248a-62cb9bbee726@infradead.org>
Date:   Tue, 30 Jun 2020 10:29:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_INET is not set/enabled.

(.text+0x2b1b): undefined reference to `tcp_prot'
(.text+0x2b3b): undefined reference to `tcp_prot'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
---
 net/core/filter.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20200630.orig/net/core/filter.c
+++ linux-next-20200630/net/core/filter.c
@@ -9328,8 +9328,10 @@ const struct bpf_func_proto bpf_skc_to_t
 
 BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
 {
+#ifdef CONFIG_INET
 	if (sk->sk_prot == &tcp_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
+#endif
 
 #if IS_BUILTIN(CONFIG_IPV6)
 	if (sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_TIME_WAIT)
@@ -9350,8 +9352,10 @@ const struct bpf_func_proto bpf_skc_to_t
 
 BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 {
+#ifdef CONFIG_INET
 	if (sk->sk_prot == &tcp_prot  && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
+#endif
 
 #if IS_BUILTIN(CONFIG_IPV6)
 	if (sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_NEW_SYN_RECV)

