Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A4DC25B0C
	for <bpf@archiver.kernel.org>; Mon,  8 Aug 2022 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiHHWUS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Aug 2022 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiHHWUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 18:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141DFEF
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 15:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A96DB810DB
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 22:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B467C433B5;
        Mon,  8 Aug 2022 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659997214;
        bh=tXVPJUFhrT/paA3P9qsSRXg/HcSRpVWvBqTybF2Uj0Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S2+gqR0m2e4f8FH6RzeoF0PNyEwSp+zf6iKevda82KmzitC+xcy2Ylwl0fWzPjPTF
         8qiV2x5IWZCUPJ/JmxKbyibaYfEfuVvz3QnMARKv5oMOyLVj3chkc7FGpYZUJXAZh6
         SdQy46GqW3N6uwjCwZoUnVSZ9cDJSIrpqcfr8Ph1EwAbl2sElgtLW4TvauESsGG/3p
         9hk58LfgCifzP4Cw3pnUUvr7ks+tkWd/RWH2CU4aokd2SsHSD+YGYNoAOn7gZ+8Iix
         gwnvuUsMtMk/pJO9NJjdseKt90hwmh8yRwEYJrtqg+2pc4GMCSTWGKTnLcJTsC0Y7T
         NeU1G8VdCPr0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E430EC43140;
        Mon,  8 Aug 2022 22:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Improve docstring for BPF_F_USER_BUILD_ID flag
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165999721393.22650.17849612213445584107.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Aug 2022 22:20:13 +0000
References: <20220808164723.3107500-1-davemarchevsky@fb.com>
In-Reply-To: <20220808164723.3107500-1-davemarchevsky@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, kernel-team@fb.com,
        slinger@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 8 Aug 2022 09:47:23 -0700 you wrote:
> Most tools which use bpf_get_stack or bpf_get_stackid symbolicate the
> stack - meaning the stack of addresses in the target process' address
> space is transformed into meaningful symbol names. The
> BPF_F_USER_BUILD_ID flag eases this process by finding the build_id of
> the file-backed vma which the address falls in and translating the
> address to an offset within the backing file.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Improve docstring for BPF_F_USER_BUILD_ID flag
    https://git.kernel.org/bpf/bpf-next/c/ca34ce29fc4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


