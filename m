Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FBFC4332F
	for <bpf@archiver.kernel.org>; Thu, 22 Dec 2022 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLVTUW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 22 Dec 2022 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiLVTUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 14:20:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A3FA
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EEE461D18
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 19:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AD60C433F0;
        Thu, 22 Dec 2022 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671736816;
        bh=/OwTgPxqXERKbPvy+R75UFK6UkWqQlEPOU2Zpg/mheI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ex+kG3l7409T/R7XeRicbDyVyj4VW7Mt9IAm6+USWc1L2/g6RjSqGq7KTyhHt3Gnr
         pscnWA0PH5+DgbzLQh6OmYNIgk59Ph0B5OJDn2tl76zigxyPUMeiSu8byqNEs6S2Be
         2fFQUXpm7cmSWGa78AONIjLFGyh3QcjeXFc8LgktAwvwTAD7dLy5DRlDqxvfADJATP
         lifI+0cDQrktth7jhF+BAjJKBUUm3VWFDph7gS0PAxGWiDqBXlGBB944ZtkC4wgi7H
         eM9zXj0bfMklEV0aUl57fc2m96y9pUkWMEhXJeE9hKr/kUCVEJGAuzSmJAD+FACBJ1
         IxQJHK+7fqgKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71468C395EA;
        Thu, 22 Dec 2022 19:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: fix linkage with statically built
 libllvm
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167173681646.9636.4275856404037245286.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Dec 2022 19:20:16 +0000
References: <20221222102627.1643709-1-aspsk@isovalent.com>
In-Reply-To: <20221222102627.1643709-1-aspsk@isovalent.com>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, quentin@isovalent.com,
        jean-philippe@linaro.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 22 Dec 2022 10:26:27 +0000 you wrote:
> Since the eb9d1acf634b commit ("bpftool: Add LLVM as default library for
> disassembling JIT-ed programs") we might link the bpftool program with the
> libllvm library.  This works fine when a shared libllvm library is available,
> but fails if we want to link bpftool with a statically built LLVM:
> 
>     /usr/bin/ld: /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function `llvm::CrashRecoveryContextCleanup::~CrashRecoveryContextCleanup()':
>     CrashRecoveryContext.cpp:(.text._ZN4llvm27CrashRecoveryContextCleanupD0Ev+0x17): undefined reference to `operator delete(void*, unsigned long)'
>     /usr/bin/ld: /usr/local/lib/libLLVMSupport.a(CrashRecoveryContext.cpp.o): in function `llvm::CrashRecoveryContext::~CrashRecoveryContext()':
>     CrashRecoveryContext.cpp:(.text._ZN4llvm20CrashRecoveryContextD2Ev+0xc8): undefined reference to `operator delete(void*, unsigned long)'
>     ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: fix linkage with statically built libllvm
    https://git.kernel.org/bpf/bpf/c/55171f2930be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


