Return-Path: <SRS0=925M=BY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224DC433DF
	for <bpf@archiver.kernel.org>; Fri, 14 Aug 2020 20:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15F22074D
	for <bpf@archiver.kernel.org>; Fri, 14 Aug 2020 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHNUzr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHNUzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Aug 2020 16:55:47 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D44C061385;
        Fri, 14 Aug 2020 13:55:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19883127471E4;
        Fri, 14 Aug 2020 13:39:01 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:55:46 -0700 (PDT)
Message-Id: <20200814.135546.2266851283177227377.davem@davemloft.net>
To:     Jason@zx2c4.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, thomas@sockpuppet.org,
        adhipati@tuta.io, dsahern@gmail.com, toke@redhat.com,
        kuba@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH net v5] net: xdp: account for layer 3 packets in
 generic skb handler
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200814073048.30291-1-Jason@zx2c4.com>
References: <CAHmME9rbRrdV0ePxT0DgurGdEKOWiEi5mH5Wtg=aJwSA6fxwMg@mail.gmail.com>
        <20200814073048.30291-1-Jason@zx2c4.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Aug 2020 13:39:01 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 14 Aug 2020 09:30:48 +0200

> @@ -4676,6 +4688,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
>  	    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
>  		__skb_push(skb, ETH_HLEN);
>  		skb->protocol = eth_type_trans(skb, skb->dev);
> +		__skb_pull(skb, ETH_HLEN);
>  	}
>  
>  	switch (act) {

This bug fix is separate from your other changes.  Please do not combine
them.
