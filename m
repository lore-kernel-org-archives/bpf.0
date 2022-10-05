Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F6FC433FE
	for <bpf@archiver.kernel.org>; Wed,  5 Oct 2022 22:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJEWaS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 5 Oct 2022 18:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJEWaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 18:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E37F193E4
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 15:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFDA76175C
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 22:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ABB4C433C1;
        Wed,  5 Oct 2022 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665009015;
        bh=IsB/u9kHdof8F5NlaE92prqOqMlL4lpua+fvDr3GQz0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U/nY1LNzEQuTdFI5fZEDFeO94iue5UXE8MeSIJi9zdqUgnLMneagv3nc691S9r+HB
         gUJHoc+32iLqArIqvEY8ROdj0LYylHEKSNHm4T/TtVvvA+/xd8R8OE4eKXmRu2ZQ+H
         sXFswwSJaQHi3rnvl5rNFHTMtW/HywS7u/qkCHbRJeRWrqxaUltHffL4OcVWIeSTn9
         PC1CvvHa6YJEOMrDh84MwShO/wAu9Jk58fBU3NJ3v5lO3LcUTVdK+ieSthSjo+LAfy
         f46/2up+oGqziT/IhV9Egy8LRKzR0KeTlxmevEpqEwdAzTUlXdGUlK51dzKYsQj/Th
         TJi7D1aIjtJrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB24CE21ED4;
        Wed,  5 Oct 2022 22:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Print newline before '}' for struct
 with padding only fields
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166500901489.580.14826881947741874792.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Oct 2022 22:30:14 +0000
References: <20221001104425.415768-1-eddyz87@gmail.com>
In-Reply-To: <20221001104425.415768-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  1 Oct 2022 13:44:24 +0300 you wrote:
> btf_dump_emit_struct_def attempts to print empty structures at a
> single line, e.g. `struct empty {}`. However, it has to account for a
> case when there are no regular but some padding fields in the struct.
> In such case `vlen` would be zero, but size would be non-zero.
> 
> E.g. here is struct bpf_timer from vmlinux.h before this patch:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpftool: Print newline before '}' for struct with padding only fields
    https://git.kernel.org/bpf/bpf-next/c/44a726c3f23c
  - [bpf-next,v2,2/2] selftests/bpf: Test btf dump for struct with padding only fields
    https://git.kernel.org/bpf/bpf-next/c/d503f1176b14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


