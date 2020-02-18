Return-Path: <SRS0=zGgN=4G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F6C34031
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 23:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456272173E
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 23:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBRXtG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:49:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38410 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgBRXtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 18:49:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E917415B7533F;
        Tue, 18 Feb 2020 15:49:04 -0800 (PST)
Date:   Tue, 18 Feb 2020 15:49:04 -0800 (PST)
Message-Id: <20200218.154904.2022305443692674467.davem@davemloft.net>
To:     dsahern@gmail.com
Cc:     daniel@iogearbox.net, toke@redhat.com, kuba@kernel.org,
        lorenzo@kernel.org, netdev@vger.kernel.org,
        ilias.apalodimas@linaro.org, lorenzo.bianconi@redhat.com,
        andrew@lunn.ch, brouer@redhat.com, dsahern@kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC net-next] net: mvneta: align xdp stats naming scheme to
 mlx5 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c9018a2d-27d0-9ff8-82eb-83b37b40b12f@gmail.com>
References: <87eeury1ph.fsf@toke.dk>
        <703ce998-e454-713c-fc7a-d5f1609146d8@iogearbox.net>
        <c9018a2d-27d0-9ff8-82eb-83b37b40b12f@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Feb 2020 15:49:05 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Ahern <dsahern@gmail.com>
Date: Tue, 18 Feb 2020 16:24:13 -0700

> There is value in having something as essential as stats available
> through standard APIs and tooling. mlx5, i40e, sfc, etc, etc already
> provide stats via ethtool. This patch is making mvneta consistent with
> existing stats from these other drivers.

I completely agree.

It is the right way to go and we have precedence.
