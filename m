Return-Path: <SRS0=WdG8=ZL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C4C432C0
	for <bpf@archiver.kernel.org>; Tue, 19 Nov 2019 23:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E0A2071F
	for <bpf@archiver.kernel.org>; Tue, 19 Nov 2019 23:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKSXED (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:04:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46264 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfKSXEC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 18:04:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0E387142612CA;
        Tue, 19 Nov 2019 15:04:02 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:04:01 -0800 (PST)
Message-Id: <20191119.150401.2253889270351799413.davem@davemloft.net>
To:     willemdebruijn.kernel@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        john.fastabend@gmail.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, willemb@google.com
Subject: Re: [PATCH] net/tls: enable sk_msg redirect to tls socket egress
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191118154051.242699-1-willemdebruijn.kernel@gmail.com>
References: <20191118154051.242699-1-willemdebruijn.kernel@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Nov 2019 15:04:02 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Nov 2019 10:40:51 -0500

> From: Willem de Bruijn <willemb@google.com>
> 
> Bring back tls_sw_sendpage_locked. sk_msg redirection into a socket
> with TLS_TX takes the following path:
> 
>   tcp_bpf_sendmsg_redir
>     tcp_bpf_push_locked
>       tcp_bpf_push
>         kernel_sendpage_locked
>           sock->ops->sendpage_locked
> 
> Also update the flags test in tls_sw_sendpage_locked to allow flag
> MSG_NO_SHARED_FRAGS. bpf_tcp_sendmsg sets this.
> 
> Link: https://lore.kernel.org/netdev/CA+FuTSdaAawmZ2N8nfDDKu3XLpXBbMtcCT0q4FntDD2gn8ASUw@mail.gmail.com/T/#t
> Link: https://github.com/wdebruij/kerneltools/commits/icept.2
> Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
> Fixes: f3de19af0f5b ("Revert \"net/tls: remove unused function tls_sw_sendpage_locked\"")
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Applied and queued up for -stable, thanks!
