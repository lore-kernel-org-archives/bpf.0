Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48CC433EF
	for <bpf@archiver.kernel.org>; Wed,  6 Oct 2021 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D6361186
	for <bpf@archiver.kernel.org>; Wed,  6 Oct 2021 17:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhJFRWA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232019AbhJFRV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 13:21:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5D29561183;
        Wed,  6 Oct 2021 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633540807;
        bh=wgzVh1dTaYY1xdhB/o44yFpV9k5392mOVEWBIBUvrNU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=adO2O2nn2h133QxgiIuA4UMn4y3qCvZjnAcZn32d2uzUQGLSusaXZM4ly3NFBpeCT
         0Q9/qFp+O9lVStN+p1Nwc6/fzQbR8ERh0deP1cO83xmzJfrLBvqFzNmOC3iVLoiJF/
         rVvXd8lOb6CEQEwGzWmb8sbXyzhoMBQPVq/tcnlFWGk38IoJN2gXUGNcKnszciJa+Z
         EqmP0cZSqx1RcxkIq26JQKv7Pwtahjsn/+2Na9d1qRJYr3h6jLrVUwWNLmhpqjcU++
         AFW92eqPYKFVI7v3kDp3TAuISnHUiAq2+vbAE2hHibrbc0fvmiMRx703zMCtkg3CF4
         UHaG9TlCoJrEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftest/bpf: Switch recursion test to use
 htab_map_delete_elem
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163354080730.29602.11506067200815201165.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Oct 2021 17:20:07 +0000
References: <YVnfFTL/3T6jOwHI@krava>
In-Reply-To: <YVnfFTL/3T6jOwHI@krava>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sun, 3 Oct 2021 18:49:25 +0200 you wrote:
> Currently the recursion test is hooking __htab_map_lookup_elem
> function, which is invoked both from bpf_prog and bpf syscall.
> 
> But in our kernel build, the __htab_map_lookup_elem gets inlined
> within the htab_map_lookup_elem, so it's not trigered and the
> test fails.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftest/bpf: Switch recursion test to use htab_map_delete_elem
    https://git.kernel.org/bpf/bpf-next/c/fba27f590fd3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


