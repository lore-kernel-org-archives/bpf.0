Return-Path: <SRS0=UYZo=VA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28970C0650E
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5DF218A0
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCTJU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:09:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33094 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfGCTJU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 15:09:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F3179141CFB74;
        Wed,  3 Jul 2019 12:09:19 -0700 (PDT)
Date:   Wed, 03 Jul 2019 12:09:19 -0700 (PDT)
Message-Id: <20190703.120919.1014264152910427438.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-07-03
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190703153106.26356-1-daniel@iogearbox.net>
References: <20190703153106.26356-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Jul 2019 12:09:20 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed,  3 Jul 2019 17:31:06 +0200

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
 ...
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks.
