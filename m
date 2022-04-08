Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C41C433F5
	for <bpf@archiver.kernel.org>; Fri,  8 Apr 2022 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiDHVLr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Apr 2022 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiDHVLo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 17:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F5CC514
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 14:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA7961FE8
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 21:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1336C385A6;
        Fri,  8 Apr 2022 21:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649452178;
        bh=QIjB2h0N9DFN/9biAQkJxRgkeLFjcmib829Y9qA9M0M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZX2WGUQ91dNE2KVPndAX61boSqWeIfkb4RVQQBfe2jQ38jyr+CrmXmMMSLk+S8eaG
         t1Yid0Cj4WdFGXPHGtBlLOG5Xv1IySW34Zer/2GsvKRPlqOzsfvpjwTIw74AvG7EfV
         mWfKdImvSAX1jyPjVIoiCo+nEw2MUS8BYXmYU4Kx2bSDJxwrxu2DJmqEcOLdU0vmnF
         rC8dWkn7O2/apcCLHM0Kn0qTOsQJ6YYB+ZGsi5MXusMowAkraJHhqn6hHKJ91V8tXU
         +EylktW3F0GpdBS255w65D/jj3IT2Chf79iPM7jV0fUyRp1l/udYebjajby6sBwQ+x
         AzSGfiWmnlhig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFB75E85D53;
        Fri,  8 Apr 2022 21:09:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Fix handling of CO-RE relos for __weak subprogs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164945217878.693.11166040212712392434.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 21:09:38 +0000
References: <20220408181425.2287230-1-andrii@kernel.org>
In-Reply-To: <20220408181425.2287230-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 8 Apr 2022 11:14:22 -0700 you wrote:
> Fix the issue accidentally discovered during libbpf USDT support testing.
> Libbpf overzealously complained about CO-RE relocations belonging to the code
> of a __weak subprog that got overriden by another instance of that function.
> 
> Fix the issue fixed, return back to __weak __hidden annotation for USDT
> BPF-side APIs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] libbpf: don't error out on CO-RE relos for overriden weak subprogs
    https://git.kernel.org/bpf/bpf-next/c/e89d57d938c8
  - [bpf-next,2/3] libbpf: use weak hidden modifier for USDT BPF-side API functions
    https://git.kernel.org/bpf/bpf-next/c/2fa5b0f290e1
  - [bpf-next,3/3] selftests/bpf: add CO-RE relos into linked_funcs selftests
    https://git.kernel.org/bpf/bpf-next/c/8555defe4861

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


