Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C0AC00144
	for <bpf@archiver.kernel.org>; Fri, 29 Jul 2022 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiG2RuW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiG2RuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 13:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B226CA
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 10:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06CB7B82907
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2986C43140;
        Fri, 29 Jul 2022 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659117013;
        bh=dHx1sZH2hpA1ZemXN097Bt5i8AnPMTTNYPj3d1aLRYk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZLDIQifAUY52EvYywYYea/6S3myVW3qblP7X8uXu/w0NvcP15MOv6QS87I0hQbhdX
         Nodmxzk+U2tCZfkxuPtF//ITePU5x5akrJkFrzfGix6mK2fSqnai0gXyu5rBTvpTIf
         8wv76NOhrNcf85tkyCaNpPBrrB/KIP/q36fLNT6qOubDF3BaK1sKxdPjgR7oMkjZ3e
         FQBKtJDLzzEWWcXv5f3y9eMUBlB4HW61FlB4GhOC0y2ofH8epmFG/DRWLibCwqT1MX
         aGvxBPSzhPlLGxojiSIGrty2q4hmvZu/me4qmPcXwJRz9QLM4t4pMqYpM4pYLX1wAh
         yECqHU1bF3y9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 859C2C43142;
        Fri, 29 Jul 2022 17:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE
 macro
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165911701354.9897.17660683542908813821.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 17:50:13 +0000
References: <20220726093045.3374026-1-clementwei90@163.com>
In-Reply-To: <20220726093045.3374026-1-clementwei90@163.com>
To:     Rongguang Wei <clementwei90@163.com>
Cc:     quentin@isovalent.com, ast@kernel.org, bpf@vger.kernel.org,
        weirongguang@kylinos.cn
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 Jul 2022 17:30:45 +0800 you wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> Use the ARRAY_SIZE macro and make the code more compact.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpftool: replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE macro
    https://git.kernel.org/bpf/bpf-next/c/5eff8c18f124

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


