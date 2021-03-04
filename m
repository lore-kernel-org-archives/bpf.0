Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4434C433DB
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84EAA64F1D
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhCDPlI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhCDPkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 10:40:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 330CC64F21;
        Thu,  4 Mar 2021 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614872407;
        bh=YVQGiVLkwRDio8qKf+8kEWRgIWC3o9vFWwkkMlaxeeQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bVsag/6OKJFh0DW4E1G0NRLJ2rWuhU2N/nwRKrNznfWtb2lDrA2CpMJfo7kWG4WdK
         w8eRIHSw8KOBzE6e/5DWxrBQUD6PttIVdjZvnVaD4RdZRGYkXg3rR1aGWOkdjTDbrx
         LMWNJeD40PN5g2p7UlvE70HCldj7nzosM6Iien4698BUM0wDNK7f9WRJXR5/j8g805
         OHCoc8SqWIGWPrmxEoVG48N+jW8yeyG+np8P5OuRLZMjq9r8cZ6J2mcsZTj2tkh/pR
         sp+VqukkzQPfMYk2t0Je6XkNRuZVPV5cWZFOHrPJmJfmD508RK9G23RE1mVm4QqLpb
         mBZHZ/hUjR4Kg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch bpf-next] skmsg: add function doc for skb->_sk_redir
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161487240715.18962.12442494103235692735.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Mar 2021 15:40:07 +0000
References: <20210301184805.8174-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20210301184805.8174-1-xiyou.wangcong@gmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        cong.wang@bytedance.com, lmb@cloudflare.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, jakub@cloudflare.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  1 Mar 2021 10:48:05 -0800 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> This should fix the following warning:
> 
> include/linux/skbuff.h:932: warning: Function parameter or member
> '_sk_redir' not described in 'sk_buff'
> 
> [...]

Here is the summary with links:
  - [bpf-next] skmsg: add function doc for skb->_sk_redir
    https://git.kernel.org/bpf/bpf-next/c/6ed6e1c761f6

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


