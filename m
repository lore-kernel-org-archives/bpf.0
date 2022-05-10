Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B79C4332F
	for <bpf@archiver.kernel.org>; Tue, 10 May 2022 00:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiEJAyL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 May 2022 20:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiEJAyK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 20:54:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E662B276F;
        Mon,  9 May 2022 17:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F19E8B81A20;
        Tue, 10 May 2022 00:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 984B6C385C8;
        Tue, 10 May 2022 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652143812;
        bh=bROYPdUu59d2fJ2UjdKZYZOR3At/u8NsObL6Uo8nprY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qc7yrVWXDYwp0tQciBT+gbUETOMwndg6Gx3tOq91kIwBZEeLxUrC7BqpuJenctWQa
         7eoB2ZXtgtqsdtFxP1y/Bv14AKHscvSo7Vc1DUIlt0pVM4eFmImNA6Y4TNT5OtJZht
         HRy6qLKnUy1VX/MKfH/2FoJ4I0pEH2C4/f6WGo5/NIeI6SnQi4U4s8HIwH4d1d53ER
         N9tYNfBv1DbN6SajgbsZ4b5PuqIloo3jBNG9t4jIjKa3z2VEAxevZe6FRHSQMl4zb0
         JGsfLWuHzKBFaKg5kOa0rF8a7kqH2/SwmgOE5o423bPY0fVioBsk7xcJxuPK6uui7u
         kF0l4NgOLRFJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 729F6F03928;
        Tue, 10 May 2022 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove unused parameter from
 find_kfunc_desc_btf()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165214381245.1602.16846067928963768174.git-patchwork-notify@kernel.org>
Date:   Tue, 10 May 2022 00:50:12 +0000
References: <20220505070114.3522522-1-ytcoode@gmail.com>
In-Reply-To: <20220505070114.3522522-1-ytcoode@gmail.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  5 May 2022 15:01:14 +0800 you wrote:
> The func_id parameter in find_kfunc_desc_btf() is not used, get rid of it.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/bpf/verifier.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Remove unused parameter from find_kfunc_desc_btf()
    https://git.kernel.org/bpf/bpf-next/c/43bf087848ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


