Return-Path: <SRS0=POGc=ZR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D2FC432C0
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 23:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D3320733
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 23:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKYXtZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Nov 2019 18:49:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56770 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKYXtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Nov 2019 18:49:25 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A9048150AE461;
        Mon, 25 Nov 2019 15:49:24 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:49:22 -0800 (PST)
Message-Id: <20191125.154922.129756476952207936.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2019-11-26
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191125232416.4287-1-daniel@iogearbox.net>
References: <20191125232416.4287-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Nov 2019 15:49:24 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 26 Nov 2019 00:24:16 +0100

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 2 non-merge commits during the last 1 day(s) which contain
> a total of 2 files changed, 14 insertions(+), 3 deletions(-).
> 
> The main changes, 2 small fixes are:
> 
> 1) Fix libbpf out of tree compilation which complained about unknown u32
>    type used in libbpf_find_vmlinux_btf_id() which needs to be __u32 instead,
>    from Andrii Nakryiko.
> 
> 2) Follow-up fix for the prior BPF mmap series where kbuild bot complained
>    about missing vmalloc_user_node_flags() for no-MMU, also from Andrii Nakryiko.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks Daniel.
