Return-Path: <SRS0=+deJ=4A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E1CC35242
	for <bpf@archiver.kernel.org>; Wed, 12 Feb 2020 01:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A7F2070A
	for <bpf@archiver.kernel.org>; Wed, 12 Feb 2020 01:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgBLBCe convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 11 Feb 2020 20:02:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54934 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgBLBCe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 20:02:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 55AE5151671B4;
        Tue, 11 Feb 2020 17:02:33 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:02:32 -0800 (PST)
Message-Id: <20200211.170232.1486991008920101035.davem@davemloft.net>
To:     toke@redhat.com
Cc:     kuba@kernel.org, john.fastabend@gmail.com, brouer@redhat.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, shoracek@redhat.com,
        pabeni@redhat.com
Subject: Re: [PATCH net] core: Don't skip generic XDP program execution for
 cloned SKBs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200210161046.221258-1-toke@redhat.com>
References: <20200210161046.221258-1-toke@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Feb 2020 17:02:33 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Mon, 10 Feb 2020 17:10:46 +0100

> The current generic XDP handler skips execution of XDP programs entirely if
> an SKB is marked as cloned. This leads to some surprising behaviour, as
> packets can end up being cloned in various ways, which will make an XDP
> program not see all the traffic on an interface.

Yeah this has been a sort spot for a while, applied and queued up for
-stable, thanks.
