Return-Path: <SRS0=nHIV=VX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F627C76190
	for <bpf@archiver.kernel.org>; Fri, 26 Jul 2019 00:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724BB217D4
	for <bpf@archiver.kernel.org>; Fri, 26 Jul 2019 00:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGZAf0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:35:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfGZAfZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 20:35:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E98F12650B76;
        Thu, 25 Jul 2019 17:35:25 -0700 (PDT)
Date:   Thu, 25 Jul 2019 17:35:24 -0700 (PDT)
Message-Id: <20190725.173524.84589370019771034.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2019-07-25
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190725173541.2413580-1-ast@kernel.org>
References: <20190725173541.2413580-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jul 2019 17:35:25 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Thu, 25 Jul 2019 10:35:41 -0700

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) fix segfault in libbpf, from Andrii.
> 
> 2) fix gso_segs access, from Eric.
> 
> 3) tls/sockmap fixes, from Jakub and John.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Alexei.

I will push back out after build testing.
