Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3AC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 05:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0852206E0
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 05:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfDZFzG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:55:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58434 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZFzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 01:55:06 -0400
Received: from localhost (unknown [12.154.31.185])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6909D13F12FEA;
        Thu, 25 Apr 2019 22:55:05 -0700 (PDT)
Date:   Fri, 26 Apr 2019 01:55:02 -0400 (EDT)
Message-Id: <20190426.015502.1931004450547734930.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2019-04-25
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190426002739.1101826-1-ast@kernel.org>
References: <20190426002739.1101826-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Apr 2019 22:55:05 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Thu, 25 Apr 2019 17:27:39 -0700

> The following pull-request contains BPF updates for your *net* tree.
> 
> The main changes are:
> 
> 1) the bpf verifier fix to properly mark registers in all stack frames, from Paul.
> 
> 2) preempt_enable_no_resched->preempt_enable fix, from Peter.
> 
> 3) other misc fixes.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Pulled, thanks Alexei.
