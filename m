Return-Path: <SRS0=s2Gn=7Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5787C433DF
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 19:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A778E20792
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 19:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFKToM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgFKToM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 15:44:12 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D17C08C5C1;
        Thu, 11 Jun 2020 12:44:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0EC2D128657AC;
        Thu, 11 Jun 2020 12:44:12 -0700 (PDT)
Date:   Thu, 11 Jun 2020 12:44:11 -0700 (PDT)
Message-Id: <20200611.124411.1798325783779516035.davem@davemloft.net>
To:     lirongqing@baidu.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] xdp: fix xsk_generic_xmit errno
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1591852266-24017-1-git-send-email-lirongqing@baidu.com>
References: <1591852266-24017-1-git-send-email-lirongqing@baidu.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Jun 2020 12:44:12 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>
Date: Thu, 11 Jun 2020 13:11:06 +0800

> @@ -353,7 +353,6 @@ static int xsk_generic_xmit(struct sock *sk)
>  		len = desc.len;
>  		skb = sock_alloc_send_skb(sk, len, 1, &err);
>  		if (unlikely(!skb)) {
> -			err = -EAGAIN;
>  			goto out;
>  		}

Since the result is a single-statement basic block you must remove the
curly braces.
