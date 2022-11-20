Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452CC433FE
	for <bpf@archiver.kernel.org>; Sun, 20 Nov 2022 23:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKTXuT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 20 Nov 2022 18:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTXuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 18:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D962228D
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 15:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC9D60DBE
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9029C433D7;
        Sun, 20 Nov 2022 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668988215;
        bh=Skrr+yZ327S0LDEKCXV0PkNmFSsT4yBo8yXuXHBjQLo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SqepesMF8au5rpZzp6Y61y+rK6GrWVO6SWAY1xQ37eblsOS5KAG3ipMopcKz4omqM
         CNG4nM8d3PdoOJMGKIDtSqtH6I5llYqHJDominZgDxvIH2OGiDQt6ODu+Z5ijPKuX/
         kV1JCmvEQHfMxMriQd0u5jUOIO4j18p+LijTUpVxsyTSnkgfFUEDfdxJiURgp6DyTc
         WLH4rV79xR6X9iMSPc0nn12s6gjW3yZCOuQEUagzZArcTvPRj3U+8eC+PWjf9IEvzq
         7MaJdX3DJzxJJstxgxlRIJAI6yaxk8BoAqLVmQyIFRTvTCulzwg6Lahrfw/LEuJEkl
         gsDUp0AYvSuqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD088E21EFF;
        Sun, 20 Nov 2022 23:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Disallow bpf_obj_new_impl call when
 bpf_mem_alloc_init fails
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166898821576.32599.1173796530789763639.git-patchwork-notify@kernel.org>
Date:   Sun, 20 Nov 2022 23:50:15 +0000
References: <20221120212610.2361700-1-memxor@gmail.com>
In-Reply-To: <20221120212610.2361700-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 21 Nov 2022 02:56:10 +0530 you wrote:
> In the unlikely event that bpf_global_ma is not correctly initialized,
> instead of checking the boolean everytime bpf_obj_new_impl is called,
> simply check it while loading the program and return an error if
> bpf_global_ma_set is false.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Disallow bpf_obj_new_impl call when bpf_mem_alloc_init fails
    https://git.kernel.org/bpf/bpf-next/c/e181d3f143f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


