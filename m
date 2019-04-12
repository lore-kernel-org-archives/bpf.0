Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855BCC10F13
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 00:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5073A2184B
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 00:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDLAAq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:00:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37648 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDLAAp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 20:00:45 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 14E3D12B05D33;
        Thu, 11 Apr 2019 17:00:45 -0700 (PDT)
Date:   Thu, 11 Apr 2019 17:00:42 -0700 (PDT)
Message-Id: <20190411.170042.1850894246064393674.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2019-04-12
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190411232546.15502-1-daniel@iogearbox.net>
References: <20190411232546.15502-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Apr 2019 17:00:45 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 12 Apr 2019 01:25:46 +0200

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> The main changes are:
> 
> 1) Improve BPF verifier scalability for large programs through two
>    optimizations: i) remove verifier states that are not useful in pruning,
>    ii) stop walking parentage chain once first LIVE_READ is seen. Combined
>    gives approx 20x speedup. Increase limits for accepting large programs
>    under root, and add various stress tests, from Alexei.

+1

> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks Daniel.
