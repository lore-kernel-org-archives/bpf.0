Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DBC54EE9
	for <bpf@archiver.kernel.org>; Wed,  7 Sep 2022 18:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIGSUX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIGSUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 14:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7B96FFB
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 11:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21DFD619E3
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 18:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7476FC43470;
        Wed,  7 Sep 2022 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662574815;
        bh=MCO92E5KtvW+qhvyjQslHkf3DYIj93hVGCxx2jXiepU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gePf+K0TpnRz9c9Qc+vtHUGgFWi3I42aAEdrnjI3WOpgiLb2ItWTDWU/4yxZfTHfo
         grP6eSIIyGn7/rfoJ3bI2MEZuotznunDVa0Dj3bL0h8sjz0RNkgpV0ycRIPR59ZY6L
         6IP+Gu8LO/x/AecrV7pkE9CF5UbmhyK9ZBbJTeKLd4GV4MJK626NrMd/ivdi2tFc2a
         GsoeudX94nUH/U9XRy2Wtp4aJfuo/l2gt8915IfDsPgv3yY5D0G31X5IWEmxU3aVwE
         B+8/qfJrhL7z4e4eaUodo5sNn4HfbYmiM98Ux8gTWb8Me9Q1A4kAPBNESY6gwXSf+8
         86GYp+RvQp/cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56E79E1CABE;
        Wed,  7 Sep 2022 18:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Fix resetting logic for unreferenced kptrs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166257481535.10994.10943927407806912362.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Sep 2022 18:20:15 +0000
References: <Yxi3pJaK6UDjVJSy@playground>
In-Reply-To: <Yxi3pJaK6UDjVJSy@playground>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, memxor@gmail.com,
        Elana.Copperman@mobileye.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 7 Sep 2022 16:24:20 +0100 you wrote:
> Sparse reported a warning at bpf_map_free_kptrs()
> 
> "warning: Using plain integer as NULL pointer"
> 
> During the process of fixing this warning,
> it was discovered that the current code
> erroneously writes to the pointer variable
> instead of deferencing and writing to the actual kptr.
> Hence, Sparse tool accidentally helped to uncover this problem.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Fix resetting logic for unreferenced kptrs
    https://git.kernel.org/bpf/bpf-next/c/9fad7fe5b298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


