Return-Path: <SRS0=tRXP=4I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB7C7619D
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9F42465D
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgBTAmy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:42:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgBTAmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 19:42:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 679D115BD9527;
        Wed, 19 Feb 2020 16:42:53 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:42:52 -0800 (PST)
Message-Id: <20200219.164252.2235102056249065952.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2020-02-19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200220003611.34197-1-ast@kernel.org>
References: <20200220003611.34197-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Feb 2020 16:42:53 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Wed, 19 Feb 2020 16:36:11 -0800

> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 10 non-merge commits during the last 10 day(s) which contain
> a total of 10 files changed, 93 insertions(+), 31 deletions(-).
> 
> The main changes are:
> 
> 1) batched bpf hashtab fixes from Brian and Yonghong.
> 
> 2) various selftests and libbpf fixes.

Pulled, thanks Alexei.
