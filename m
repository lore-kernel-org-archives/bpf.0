Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E5CC433FE
	for <bpf@archiver.kernel.org>; Thu,  3 Nov 2022 23:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKCXuS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Nov 2022 19:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCXuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 19:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F85ECC1
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 16:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09BB06204F
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 23:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A7A5C433D7;
        Thu,  3 Nov 2022 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667519415;
        bh=KfU91qTl49Cnb696V1TmGTNByOvx09X8DG6jYIv+kR8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WeJi5mpCVPl9A7jQeJepW/GqrkV2cp56BTk9E/nDU7FjPUlAK0N7B1cuPCT4e4uaZ
         Ldr/16yEETkd+Kcm04FbLIlTP0cx3+BFzuPG5X/YPkcouFCfrTLlgL4wv7UAJ4Xw2b
         qAe//hjSXJdAah9TOVcm9+CWSx/znkki7QSeFL+98TG/FffR0QVk3S6hl/tLSwLXTy
         PjfEoRqvG32WkjxqqWMQ2CE9VYl5yrIvgZZT2KGk532SoPALnQTfhLdWYJjHuT6ijw
         X+GWKKMKwgOWdFa9ZjsFf/pkX9aA82tvJV/6HXHyRQ8GnvNpfZXohL06oaitGwTvj/
         ysvchja8U/Aiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EE26E270F6;
        Thu,  3 Nov 2022 23:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2 v2] bpf: Fix wrong reg type conversion in
 release_reference()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166751941531.11927.6923605690119797378.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Nov 2022 23:50:15 +0000
References: <20221103093440.3161-1-liulin063@gmail.com>
In-Reply-To: <20221103093440.3161-1-liulin063@gmail.com>
To:     Youlin Li <liulin063@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  3 Nov 2022 17:34:39 +0800 you wrote:
> Some helper functions will allocate memory. To avoid memory leaks, the
> verifier requires the eBPF program to release these memories by calling
> the corresponding helper functions.
> 
> When a resource is released, all pointer registers corresponding to the
> resource should be invalidated. The verifier use release_references() to
> do this job, by apply  __mark_reg_unknown() to each relevant register.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2,v2] bpf: Fix wrong reg type conversion in release_reference()
    https://git.kernel.org/bpf/bpf/c/f1db20814af5
  - [bpf,2/2] selftests/bpf: Add verifier test for release_reference()
    https://git.kernel.org/bpf/bpf/c/475244f5e06b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


