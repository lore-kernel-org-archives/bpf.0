Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E1C4338F
	for <bpf@archiver.kernel.org>; Tue, 27 Jul 2021 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F9660F91
	for <bpf@archiver.kernel.org>; Tue, 27 Jul 2021 18:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG0SUG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Jul 2021 14:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0SUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 14:20:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F33B860F58;
        Tue, 27 Jul 2021 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627410006;
        bh=eQGEvL1d8lFprElBCwkgBl7lkugfTNTy9wkYormX9a8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S9O/Lli5CxBngAljdSfhtzCrKU+RHJ+gHmPzwvwSRWNuL5EiwzD58s2by14zQk7TZ
         i0+06mPAGq6r+rr+CXLivJJ6ycaiGRO+WyxycqV3IUzsKgiAZX1AGtnqQdDYH1MNYn
         dyTvl6fYgGpj7/+LClZfiiB2RBRUCtrkC9uwI78AFrmoSSH7Ko7gn/PuXdTl0bzjSc
         RxAaREKSyilDFomQTxl9kqn9CB3uepOUbLHJ+EYzhLUfoMHurW7s4b1qs7OmLN3kEx
         zhK4wcOb7RSxb5I+gHMT0SnqezvgnEQnvCYXbHJtHYjfOvrExledk2Ri3XMvgRKkqQ
         hnZcQoixXlZwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v2 1/2] samples: bpf: Fix tracex7 error raised on the
 missing argument
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162741000593.4520.5117531432819411073.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jul 2021 18:20:05 +0000
References: <20210727041056.23455-1-claudiajkang@gmail.com>
In-Reply-To: <20210727041056.23455-1-claudiajkang@gmail.com>
To:     Juhee Kang <claudiajkang@gmail.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        yhs@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 27 Jul 2021 04:10:55 +0000 you wrote:
> The current behavior of 'tracex7' doesn't consist with other bpf samples
> tracex{1..6}. Other samples do not require any argument to run with, but
> tracex7 should be run with btrfs device argument. (it should be executed
> with test_override_return.sh)
> 
> Currently, tracex7 doesn't have any description about how to run this
> program and raises an unexpected error. And this result might be
> confusing since users might not have a hunch about how to run this
> program.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] samples: bpf: Fix tracex7 error raised on the missing argument
    https://git.kernel.org/bpf/bpf-next/c/7d07006f0592
  - [bpf-next,v2,2/2] samples: bpf: Add the omitted xdp samples to .gitignore
    https://git.kernel.org/bpf/bpf-next/c/05e9b4f60d31

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


