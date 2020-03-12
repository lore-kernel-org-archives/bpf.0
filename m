Return-Path: <SRS0=5rgj=45=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DEC10DCE
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA56F20691
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 06:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgCLGUP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:20:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56150 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387848AbgCLGUO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 02:20:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DF7EA14DA84A4;
        Wed, 11 Mar 2020 23:20:13 -0700 (PDT)
Date:   Wed, 11 Mar 2020 23:20:13 -0700 (PDT)
Message-Id: <20200311.232013.489547255392767135.davem@davemloft.net>
To:     jbi.octave@gmail.com
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org
Subject: Re: [PATCH 3/8] tcp: Add missing annotation for tcp_child_process()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200311010908.42366-4-jbi.octave@gmail.com>
References: <0/8>
        <20200311010908.42366-1-jbi.octave@gmail.com>
        <20200311010908.42366-4-jbi.octave@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Mar 2020 23:20:14 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>
Date: Wed, 11 Mar 2020 01:09:03 +0000

> Sparse reports warning at tcp_child_process()
> warning: context imbalance in tcp_child_process() - unexpected unlock
> The root cause is the missing annotation at tcp_child_process()
> 
> Add the missing __releases(&((child)->sk_lock.slock)) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Applied.
