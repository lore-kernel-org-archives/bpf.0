Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC7C433EF
	for <bpf@archiver.kernel.org>; Fri, 22 Jul 2022 20:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiGVUKS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiGVUKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 16:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63561C109
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8370DB82A62
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 20:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39745C341CB;
        Fri, 22 Jul 2022 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520614;
        bh=aMEz0mexT8rFOuAGowT2GGpGvG6Aq09e8RdGFpdDOD0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rb0EWng+/+BlzWUyQSi+iWC3UnPvPIs/tYE3thoYvLtec7Lc2EBuO+tN67YoknBPt
         CF1HlGOZk3Ub6F2UFRrWFdUffKG8bFBbyYuAdfQpF6Tw9Jop91dPAYUziYfGB1J6yV
         W5ivh+SHlyhEcCjpcEnZgeMsa97hSiQ0YTDcDCIlBkWLiSDctRdisFts0mFQzlEFV3
         jJG1J1JkvZpgijeQZsn7k27IZ+JwzPdHyttyem1W46lNXh5Ya0Vd+7aLIbKt4INP2p
         R7ztkWFp77mmw8x4/c4TBt5Q2P1cSXcOJ02ti7MXggTW7HTegt6L5+WZsQWuxFM03Z
         XzRwcy+pHkm5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BB70D9DDDD;
        Fri, 22 Jul 2022 20:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: simplify bpf_prog_pack_[size|mask]
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165852061411.17882.11243539179338347467.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 20:10:14 +0000
References: <20220713204950.3015201-1-song@kernel.org>
In-Reply-To: <20220713204950.3015201-1-song@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        ast@kernel.org, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 13 Jul 2022 13:49:50 -0700 you wrote:
> Simplify the logic that selects bpf_prog_pack_size, and always use
> (PMD_SIZE * num_possible_nodes()). This is a good tradeoff, as most of the
> performance benefit observed is from less direct map fragmentation [1].
> 
> Also, module_alloc(4MB) may not allocate 4MB aligned memory. Therefore, we
> cannot use (ptr & bpf_prog_pack_mask) to find the correct address of
> bpf_prog_pack. Fix this by checking the header address falls in the range
> of pack->ptr and (pack->ptr + bpf_prog_pack_size).
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: simplify bpf_prog_pack_[size|mask]
    https://git.kernel.org/bpf/bpf-next/c/ea2babac63d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


