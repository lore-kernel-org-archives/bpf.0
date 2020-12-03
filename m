Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404BFC4167B
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 20:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B44207B8
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 20:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgLCUKr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgLCUKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 15:10:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607026206;
        bh=sXhMuQ0ue6a6ZDYM4zgczr7RKLhuC3DvBrirGzj1n9A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mAtsXMRj6691EIwY4pFlKqcEZ9nA8DfAO6j0KBpmqs1XfiuGyMyRLd1tFUVugNei0
         uJ3+AzKcKgsj921h0lPeiMr0phldO+A3VQgoqaDGmlFSk2TWsaSgEi95YV4fRIjnKo
         dEWFSt9cJ/73TQA+tMWtpmAt9CQWsZv2bu56xhAy702KAPzAlw9+gKHzUsb8Zt5G2+
         +FCRoLQF/3KLGKACM8BceoDfL5X0LFWQiN2cWn76D2bG+eJKE3u4RjVs4JeDQFvl5t
         AY9A01Ei161Xe3vnt0gEomL788+JNBiClI5AfQ7c6z7Lp0NBhQaRWqP4igEarU1I6U
         H6kRZ3G5JtP7w==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: cap retries in sys_bpf_prog_load
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160702620648.3826.10588839413640919063.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Dec 2020 20:10:06 +0000
References: <20201202231332.3923644-1-sdf@google.com>
In-Reply-To: <20201202231332.3923644-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed,  2 Dec 2020 15:13:32 -0800 you wrote:
> I've seen a situation, where a process that's under pprof constantly
> generates SIGPROF which prevents program loading indefinitely.
> The right thing to do probably is to disable signals in the upper
> layers while loading, but it still would be nice to get some error from
> libbpf instead of an endless loop.
> 
> Let's add some small retry limit to the program loading:
> try loading the program 5 (arbitrary) times and give up.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: cap retries in sys_bpf_prog_load
    https://git.kernel.org/bpf/bpf-next/c/d6d418bd8f92

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


