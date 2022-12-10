Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D4C10F1B
	for <bpf@archiver.kernel.org>; Sat, 10 Dec 2022 04:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLJEAX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 9 Dec 2022 23:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLJEAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 23:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293D057B53;
        Fri,  9 Dec 2022 20:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D512FB82A4B;
        Sat, 10 Dec 2022 04:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78931C433EF;
        Sat, 10 Dec 2022 04:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670644818;
        bh=Rz+P4SaGHSIpmQsi3KIQXlPIq5hb6Gs+1inK2v4ojnI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mVRc8GNEm3ThZgLn47sVD2FOsXz5OhPQcQagxoFEqhhaxT+/zxO723gzOqpLKhFvr
         xwsHbsZW/+vf2aafWyVXqsIu5kx2Ts5cyw7S+hzfkiodTa+hTArFWIOG9SXqKR/gzW
         8gj/j3HwVwLz98tOtFjF+mg7Fk5AQJvFNwz/TAAxKRlvUD2j1Nk8u5OWTRTC5ecMzP
         onfyGfdpRywRkKy+jjd8QePbW4e9vxT/nzrMLLHUH2RwPTxghDSK1fmYDzN/hGpFS+
         9wSi/0B8xHd4JadPgcWEskDaYcAKCoJjtHAoOJLIyApA4lor6kn8HIhiwkc6TcjUzG
         OGBUIaIzb6wFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41E41C41606;
        Sat, 10 Dec 2022 04:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] skbuff: Introduce slab_build_skb()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167064481825.12189.4717731779203655380.git-patchwork-notify@kernel.org>
Date:   Sat, 10 Dec 2022 04:00:18 +0000
References: <20221208060256.give.994-kees@kernel.org>
In-Reply-To: <20221208060256.give.994-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kuba@kernel.org,
        syzbot+fda18eaa8c12534ccb3b@syzkaller.appspotmail.com,
        edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
        asml.silence@gmail.com, soopthegoop@gmail.com, vbabka@suse.cz,
        kasan-dev@googlegroups.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rmody@marvell.com,
        aelior@marvell.com, manishc@marvell.com, imagedong@tencent.com,
        dsahern@kernel.org, richardbgobert@gmail.com, andreyknvl@gmail.com,
        rientjes@google.com, GR-Linux-NIC-Dev@marvell.com,
        linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Dec 2022 22:02:59 -0800 you wrote:
> syzkaller reported:
> 
>   BUG: KASAN: slab-out-of-bounds in __build_skb_around+0x235/0x340 net/core/skbuff.c:294
>   Write of size 32 at addr ffff88802aa172c0 by task syz-executor413/5295
> 
> For bpf_prog_test_run_skb(), which uses a kmalloc()ed buffer passed to
> build_skb().
> 
> [...]

Here is the summary with links:
  - [net-next,v3] skbuff: Introduce slab_build_skb()
    https://git.kernel.org/netdev/net-next/c/ce098da1497c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


