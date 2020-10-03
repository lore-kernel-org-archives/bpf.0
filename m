Return-Path: <SRS0=nNHG=DK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63D3C4363C
	for <bpf@archiver.kernel.org>; Sat,  3 Oct 2020 02:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E147207EA
	for <bpf@archiver.kernel.org>; Sat,  3 Oct 2020 02:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601692204;
	bh=/GdVGcCMMFuMnUAyvKz2m/dBmsQWXPWaq1KqnZFaiLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=dWbbHrHOKiKw2HIfvVnHPrZ4Hcej+r3cVpjXjMUNPgfTeJiXUiRpFM/gL4h2nLCaL
	 sxpqbRQ6+LGhS8lEvdL907UsNY8YHWOe6V643P5zNl6KaPhz0CMmcdyhXqPtgS5F5x
	 ZQyxNrpbMv5fZZ1aF0l/pQFp4RK4hVJEfpZmTqfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgJCCaE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 22:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgJCCaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 22:30:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601692203;
        bh=/GdVGcCMMFuMnUAyvKz2m/dBmsQWXPWaq1KqnZFaiLI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Uhw9P3SqmnhHNNIeD4siivfccdTH8W2G0DGDjHs03q/ZZQ6zgDji1K5B8C+Vd5g9g
         R6nRGo470KwtwiPvEQuX+RdnG+bLU6wsS/JG1MTL+szT571NJA8XHJSblGQWGpWLVs
         R4HqWRf1lEHDz2uGX7snaMAFY6haRdM+QW/1Aftk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: deref map in BPF_PROG_BIND_MAP when it's
 already used
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160169220350.9428.1442474322300183574.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Oct 2020 02:30:03 +0000
References: <20201003002544.3601440-1-sdf@google.com>
In-Reply-To: <20201003002544.3601440-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri,  2 Oct 2020 17:25:44 -0700 you wrote:
> We are missing a deref for the case when we are doing BPF_PROG_BIND_MAP
> on a map that's being already held by the program.
> There is 'if (ret) bpf_map_put(map)' below which doesn't trigger
> because we don't consider this an error.
> Let's add missing bpf_map_put() for this specific condition.
> 
> Fixes: ef15314aa5de ("bpf: Add BPF_PROG_BIND_MAP syscall")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: deref map in BPF_PROG_BIND_MAP when it's already used
    https://git.kernel.org/bpf/bpf-next/c/1028ae406999

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


