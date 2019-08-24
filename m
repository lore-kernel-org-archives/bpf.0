Return-Path: <SRS0=81Vy=WU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E12C3A5A2
	for <bpf@archiver.kernel.org>; Sat, 24 Aug 2019 00:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E556C21670
	for <bpf@archiver.kernel.org>; Sat, 24 Aug 2019 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfHXAe1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:34:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39534 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHXAe1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Aug 2019 20:34:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B3A7B15449D64;
        Fri, 23 Aug 2019 17:34:26 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:34:26 -0700 (PDT)
Message-Id: <20190823.173426.2012838816038876039.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-08-24
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190824001157.16043-1-daniel@iogearbox.net>
References: <20190824001157.16043-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Aug 2019 17:34:27 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 24 Aug 2019 02:11:57 +0200

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) Fix verifier precision tracking with BPF-to-BPF calls, from Alexei.
> 
> 2) Fix a use-after-free in prog symbol exposure, from Daniel.
> 
> 3) Several s390x JIT fixes plus BE related fixes in BPF kselftests, from Ilya.
> 
> 4) Fix memory leak by unpinning XDP umem pages in error path, from Ivan.
> 
> 5) Fix a potential use-after-free on flow dissector detach, from Jakub.
> 
> 6) Fix bpftool to close prog fd after showing metadata, from Quentin.
> 
> 7) BPF kselftest config and TEST_PROGS_EXTENDED fixes, from Anders.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Daniel.
