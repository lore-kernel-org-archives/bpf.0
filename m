Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B485C433E0
	for <bpf@archiver.kernel.org>; Tue,  2 Feb 2021 22:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A3864F91
	for <bpf@archiver.kernel.org>; Tue,  2 Feb 2021 22:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhBBWks (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235317AbhBBWkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 17:40:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F376164F77;
        Tue,  2 Feb 2021 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612305607;
        bh=kIpNVZMOWYIogyH+CabwMWi2G3OEMriGjSqtRrXODYQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DZ+HnyW7kjSmLQuVykV9fot0z4Z21QfpSs/VuOK/Yvh4D10DwaU/Ib+3o1hEPEmlA
         xmKIzNcJDJBNbhg85X10laALUS1aslvc1UCCD8EuTYn2pSEF35mAFffGeZ2Irh/oz/
         BIPgKZueCiuVYLdu+WSsdiA+qSbBFcoUrbc4IJ7gCwiZsxQVOFdwyx8XxJU/80BLXR
         f80/YQFDIa7qh9mEbRnYpeu0riunBUnoApUIQ4Pvc+3ny5yWy9RF3j2mGpAAEHbQm4
         l2X0rSZToUc2nIo/Sm4d6sqeq91Q+N2MO0B9MUZ5wj5eODWZrdxf1f2p4YMF9pYV/U
         0vn9/KcPmbETQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: Add include dir for MIPS Loongson64 to
 fix build errors
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161230560690.17917.396207762953039292.git-patchwork-notify@kernel.org>
Date:   Tue, 02 Feb 2021 22:40:06 +0000
References: <1611669925-25315-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1611669925-25315-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lixuefeng@loongson.cn
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 26 Jan 2021 22:05:25 +0800 you wrote:
> There exists many build errors when make M=samples/bpf on the Loongson
> platform, this issue is MIPS related, x86 compiles just fine.
> 
> Here are some errors:
> 
>   CLANG-bpf  samples/bpf/sockex2_kern.o
> In file included from samples/bpf/sockex2_kern.c:2:
> In file included from ./include/uapi/linux/in.h:24:
> In file included from ./include/linux/socket.h:8:
> In file included from ./include/linux/uio.h:8:
> In file included from ./include/linux/kernel.h:11:
> In file included from ./include/linux/bitops.h:32:
> In file included from ./arch/mips/include/asm/bitops.h:19:
> In file included from ./arch/mips/include/asm/barrier.h:11:
> ./arch/mips/include/asm/addrspace.h:13:10: fatal error: 'spaces.h' file not found
>          ^~~~~~~~~~
> 1 error generated.
> 
> [...]

Here is the summary with links:
  - [bpf-next] samples/bpf: Add include dir for MIPS Loongson64 to fix build errors
    https://git.kernel.org/bpf/bpf-next/c/058107abafc7

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


