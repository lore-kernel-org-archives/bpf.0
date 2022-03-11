Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48CBC433EF
	for <bpf@archiver.kernel.org>; Fri, 11 Mar 2022 22:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiCKWrG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCKWqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C92DBB91
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 14:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA5F61FB6
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 21:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF28C340F3;
        Fri, 11 Mar 2022 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647033610;
        bh=5Omgc8N2RMJg13tpfO1RcQgVJkATS95l8boNf3wAQN8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hL3Clp6sV/zwRtoEZKZS/PD1aLIkLQYBCa4QNlLmZBxNhGQ22PHCELNLJ/99bKp1I
         Wn81HHPjianGS7Cue4GfmOLwnSJKEm+kTVWW0HCb3yVTyZ9dCo3jjDLgLcJYusa6DE
         xc9Gh3EyZMbpf1zPm3C5xi2jiezKxPlR8tkWDnVqosUDoKaWCV809GOI1YTq7a2YNq
         oqIE+hoGpvCjfuKbMgNy/7nvKIom3AIDxWGyRmvttVSzzpFihcBqGHK9K3ii/ruKwX
         860y2OIfmlp5jItAeESl6AOdbAZqy/O8z40oQ8rhogtxZSPqP3/jxQijIZWaoJz2dQ
         BgcVgvr7Vp9tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4A17EAC095;
        Fri, 11 Mar 2022 21:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix a clang compilation error for
 send_signal.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164703360986.31502.17354183573742038108.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Mar 2022 21:20:09 +0000
References: <20220311003721.2177170-1-yhs@fb.com>
In-Reply-To: <20220311003721.2177170-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 10 Mar 2022 16:37:21 -0800 you wrote:
> Building selftests/bpf with latest clang compiler (clang15 built
> from source), I hit the following compilation error:
>   /.../prog_tests/send_signal.c:43:16: error: variable 'j' set but not used [-Werror,-Wunused-but-set-variable]
>                   volatile int j = 0;
>                                ^
>   1 error generated.
> The problem also exists with clang13 and clang14. clang12 is okay.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: fix a clang compilation error for send_signal.c
    https://git.kernel.org/bpf/bpf-next/c/d3b351f65bf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


