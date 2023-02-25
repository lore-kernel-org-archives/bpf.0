Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BBFC6FA8E
	for <bpf@archiver.kernel.org>; Sat, 25 Feb 2023 01:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBYBk0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Feb 2023 20:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBYBkZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 20:40:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D343E515E8;
        Fri, 24 Feb 2023 17:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5231CB81D78;
        Sat, 25 Feb 2023 01:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FD02C433EF;
        Sat, 25 Feb 2023 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677289218;
        bh=QIlJNRK7O/fYSQ2XdQDu6fwQR/yjiyEw+lpxtMVbZ2E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BF1y+1f62G6yk/Rm4r1YNqO7D7vgoHNZ8Vy7yt+5V38n+jSgJk95uyZiZ6e6hGXQZ
         uZ07mxQCqBkVGDg6YHjCHpcS0i8tmd06NFj62J2sjsBSYGQR5dy9EbvYS+DNhlBSv3
         fUYADk1gDkwG08Sp1ueLJSncSKs1GWQaVfK37ioEyy8+oHLPQCKy9e7iIxlbkDHazV
         NqS339HPwzJALVjS8wu+SWmmgpFsEfabSRiCfYuFZpr7+IXTFk5XQLeoz0i2UWf6CP
         Fqv5W9wrhNbkqm2XGtFWfNPbcKMfY4QkQ0kp8+d8RCiGVywroSZwiuglUzdK/mKkHw
         2e46RyndGeeUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8F9BE68D2D;
        Sat, 25 Feb 2023 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/2] move SYS() macro to test_progs.h and run mptcp
 in a dedicated netns
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167728921795.31034.7569688658636917497.git-patchwork-notify@kernel.org>
Date:   Sat, 25 Feb 2023 01:40:17 +0000
References: <20230224061343.506571-1-liuhangbin@gmail.com>
In-Reply-To: <20230224061343.506571-1-liuhangbin@gmail.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        davem@davemloft.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, fmaurer@redhat.com, matthieu.baerts@tessares.net,
        mptcp@lists.linux.dev
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 24 Feb 2023 14:13:41 +0800 you wrote:
> As Martin suggested, let's move the SYS() macro to test_progs.h since
> a lot of programs are using it. After that, let's run mptcp in a dedicated
> netns to avoid user config influence.
> 
> v3: fix fd redirect typo. Move SYS() macro into the test_progs.h
> v2: remove unneed close_cgroup_fd goto label.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/2] selftests/bpf: move SYS() macro into the test_progs.h
    https://git.kernel.org/bpf/bpf-next/c/b61987d37cbe
  - [PATCHv3,bpf-next,2/2] selftests/bpf: run mptcp in a dedicated netns
    https://git.kernel.org/bpf/bpf-next/c/02d6a057c7be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


