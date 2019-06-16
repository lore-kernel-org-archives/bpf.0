Return-Path: <SRS0=8oeG=UP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F8C31E47
	for <bpf@archiver.kernel.org>; Sun, 16 Jun 2019 01:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AEB2183F
	for <bpf@archiver.kernel.org>; Sun, 16 Jun 2019 01:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFPBWG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 15 Jun 2019 21:22:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfFPBWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Jun 2019 21:22:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1438C14FBD222;
        Sat, 15 Jun 2019 18:22:05 -0700 (PDT)
Date:   Sat, 15 Jun 2019 18:22:04 -0700 (PDT)
Message-Id: <20190615.182204.2054894325791126260.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2019-06-15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190615234138.3313038-1-ast@kernel.org>
References: <20190615234138.3313038-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Jun 2019 18:22:05 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Sat, 15 Jun 2019 16:41:38 -0700

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) fix stack layout of JITed x64 bpf code, from Alexei.
> 
> 2) fix out of bounds memory access in bpf_sk_storage, from Arthur.
> 
> 3) fix lpm trie walk, from Jonathan.
> 
> 4) fix nested bpf_perf_event_output, from Matt.
> 
> 5) and several other fixes.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Alexei.
