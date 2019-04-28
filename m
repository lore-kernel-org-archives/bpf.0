Return-Path: <SRS0=Xozv=S6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A51C43219
	for <bpf@archiver.kernel.org>; Sun, 28 Apr 2019 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842AF206C1
	for <bpf@archiver.kernel.org>; Sun, 28 Apr 2019 12:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfD1MnG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:43:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfD1MnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Apr 2019 08:43:06 -0400
Received: from localhost (unknown [207.239.160.254])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE678133E97C3;
        Sun, 28 Apr 2019 05:43:05 -0700 (PDT)
Date:   Sun, 28 Apr 2019 08:43:02 -0400 (EDT)
Message-Id: <20190428.084302.1848005410351775224.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2019-04-28
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190428105909.9248-1-daniel@iogearbox.net>
References: <20190428105909.9248-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 28 Apr 2019 05:43:06 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sun, 28 Apr 2019 12:59:09 +0200

> The following pull-request contains BPF updates for your *net-next* tree.
 ...
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks Daniel.
