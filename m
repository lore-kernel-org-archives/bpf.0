Return-Path: <SRS0=hI4V=2Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF25C2D0C0
	for <bpf@archiver.kernel.org>; Thu, 26 Dec 2019 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49CB2080D
	for <bpf@archiver.kernel.org>; Thu, 26 Dec 2019 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfLZXZX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 26 Dec 2019 18:25:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44592 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLZXZX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Dec 2019 18:25:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C734B1539F551;
        Thu, 26 Dec 2019 15:25:22 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:25:22 -0800 (PST)
Message-Id: <20191226.152522.547752807327139189.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-12-23
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191223144823.3456-1-daniel@iogearbox.net>
References: <20191223144823.3456-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Dec 2019 15:25:23 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 23 Dec 2019 15:48:23 +0100

> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 2 non-merge commits during the last 1 day(s) which contain
> a total of 4 files changed, 34 insertions(+), 31 deletions(-).
> 
> The main changes are:
> 
> 1) Fix libbpf build when building on a read-only filesystem with O=dir
>    option, from Namhyung Kim.
> 
> 2) Fix a precision tracking bug for unknown scalars, from Daniel Borkmann.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
