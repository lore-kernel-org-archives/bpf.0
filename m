Return-Path: <SRS0=FlKb=3Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7008C2D0DB
	for <bpf@archiver.kernel.org>; Mon, 27 Jan 2020 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9156720716
	for <bpf@archiver.kernel.org>; Mon, 27 Jan 2020 13:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0NcF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:32:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39290 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0NcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 08:32:04 -0500
Received: from localhost (unknown [213.175.37.12])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 314FF155EF394;
        Mon, 27 Jan 2020 05:32:02 -0800 (PST)
Date:   Mon, 27 Jan 2020 14:31:59 +0100 (CET)
Message-Id: <20200127.143159.304887488057743776.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2020-01-27
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200127130618.24926-1-daniel@iogearbox.net>
References: <20200127130618.24926-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Jan 2020 05:32:04 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 27 Jan 2020 14:06:18 +0100

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 20 non-merge commits during the last 5 day(s) which contain
> a total of 24 files changed, 433 insertions(+), 104 deletions(-).
> 
> The main changes are:
> 
> 1) Make BPF trampolines and dispatcher aware for the stack unwinder, from Jiri Olsa.
> 
> 2) Improve handling of failed CO-RE relocations in libbpf, from Andrii Nakryiko.
> 
> 3) Several fixes to BPF sockmap and reuseport selftests, from Lorenz Bauer.
> 
> 4) Various cleanups in BPF devmap's XDP flush code, from John Fastabend.
> 
> 5) Fix BPF flow dissector when used with port ranges, from Yoshiki Komachi.
> 
> 6) Fix bpffs' map_seq_next callback to always inc position index, from Vasily Averin.
> 
> 7) Allow overriding LLVM tooling for runqslower utility, from Andrey Ignatov.
> 
> 8) Silence false-positive lockdep splats in devmap hash lookup, from Amol Grover.
> 
> 9) Fix fentry/fexit selftests to initialize a variable before use, from John Sperbeck.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks Daniel.
