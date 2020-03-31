Return-Path: <SRS0=bJqj=5Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE3C43331
	for <bpf@archiver.kernel.org>; Tue, 31 Mar 2020 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE58F20848
	for <bpf@archiver.kernel.org>; Tue, 31 Mar 2020 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgCaRIH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:08:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53088 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaRIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 13:08:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3ABD15CF9D4D;
        Tue, 31 Mar 2020 10:08:06 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:08:06 -0700 (PDT)
Message-Id: <20200331.100806.878847626011762877.davem@davemloft.net>
To:     bmeneg@redhat.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, micron10@gmail.com, ast@kernel.org
Subject: Re: [PATCH] net/bpfilter: remove superfluous testing message
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200331130630.633400-1-bmeneg@redhat.com>
References: <20200331130630.633400-1-bmeneg@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 31 Mar 2020 10:08:06 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Bruno Meneguele <bmeneg@redhat.com>
Date: Tue, 31 Mar 2020 10:06:30 -0300

> A testing message was brought by 13d0f7b814d9 ("net/bpfilter: fix dprintf
> usage for /dev/kmsg") but should've been deleted before patch submission.
> Although it doesn't cause any harm to the code or functionality itself, it's
> totally unpleasant to have it displayed on every loop iteration with no real
> use case. Thus remove it unconditionally.
> 
> Fixes: 13d0f7b814d9 ("net/bpfilter: fix dprintf usage for /dev/kmsg")
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

Applied, thanks.
