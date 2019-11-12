Return-Path: <SRS0=YQHJ=ZE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA6DC43331
	for <bpf@archiver.kernel.org>; Tue, 12 Nov 2019 20:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E203214E0
	for <bpf@archiver.kernel.org>; Tue, 12 Nov 2019 20:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLUYM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:24:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49214 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLUYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Nov 2019 15:24:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 24D55154D4A28;
        Tue, 12 Nov 2019 12:24:11 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:24:10 -0800 (PST)
Message-Id: <20191112.122410.512273112809490584.davem@davemloft.net>
To:     afabre@cloudflare.com
Cc:     linux-net-drivers@solarflare.com, ecree@solarflare.com,
        cmclachlan@solarflare.com, mhabets@solarflare.com, ast@kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 net-next] sfc: trace_xdp_exception on XDP failure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191112153601.5849-1-afabre@cloudflare.com>
References: <20191112153601.5849-1-afabre@cloudflare.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Nov 2019 12:24:11 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Arthur Fabre <afabre@cloudflare.com>
Date: Tue, 12 Nov 2019 15:36:01 +0000

> The sfc driver can drop packets processed with XDP, notably when running
> out of buffer space on XDP_TX, or returning an unknown XDP action.
> This increments the rx_xdp_bad_drops ethtool counter.
> 
> Call trace_xdp_exception everywhere rx_xdp_bad_drops is incremented,
> except for fragmented RX packets as the XDP program hasn't run yet.
> This allows it to easily be monitored from userspace.
> 
> This mirrors the behavior of other drivers.
> 
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>

Applied.
