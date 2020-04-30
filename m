Return-Path: <SRS0=Oi1G=6O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B983AC4724C
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A388420731
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 19:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD3TzJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3TzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 15:55:08 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC891C035494;
        Thu, 30 Apr 2020 12:55:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A70D41289FD4D;
        Thu, 30 Apr 2020 12:55:07 -0700 (PDT)
Date:   Thu, 30 Apr 2020 12:55:06 -0700 (PDT)
Message-Id: <20200430.125506.1341002176317746009.davem@davemloft.net>
To:     zeil@yandex-team.ru
Cc:     netdev@vger.kernel.org, khlebnikov@yandex-team.ru, tj@kernel.org,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] inet_diag: add cgroup attribute and filter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200430155115.83306-1-zeil@yandex-team.ru>
References: <20200430155115.83306-1-zeil@yandex-team.ru>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Apr 2020 12:55:07 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dmitry Yakunin <zeil@yandex-team.ru>
Date: Thu, 30 Apr 2020 18:51:13 +0300

> This patch series extends inet diag with cgroup v2 ID attribute and
> filter. Which allows investigate sockets on per cgroup basis. Patch for
> ss is already sent to iproute2-next mailing list.

Ok, this looks fine, series applied.

Although I wish you could have done something like only emit the cgroup
attribute if it is a non-default value (zero, or whatever it is).

Every time a new socket attribute is added, it makes long dumps more
and more expensive.
