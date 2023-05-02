Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA0C77B78
	for <bpf@archiver.kernel.org>; Tue,  2 May 2023 23:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEBXUX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 May 2023 19:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEBXUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2151FF9
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B3F6299F
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 23:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 849D9C433EF;
        Tue,  2 May 2023 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683069620;
        bh=qYKzQ6GSnQHhx8NSn9h+a3i6VD6h7pyK39Wp3jtxXZ4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JNhc5h9dGxibR5F5p+uyv62M1sH7Q7kj9BZOkZgDzkyW2EHEUI3oyEMthBxjGd2hG
         m6LwKd5IwLeDylAtLsHSVvSEwivTenrjdLAz+LjKQoehjuZDG8Zm2FzXSR6fwLZOmz
         qEgANHWEr/YlPK+o7JiK4WiXxO4CV6bWQprVidqooTwFmrto4ZJyg7EDhOr+332iVO
         dCidsVZya3JHczl0/icWvRaC4SbOGZYLPuxDQja9z1UWTCLdFOuQhkO5cm5h8IkLfI
         hUaIV+ceOgmgWZaOCz4kKH44CaQlg4FGqdcTB673RVX8TUyVm1sW2hzJqJHhGZgXtK
         MGzV3fbSE4CJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 621D8E5FFC9;
        Tue,  2 May 2023 23:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Emit struct bpf_tcp_sock type in vmlinux BTF
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168306962039.20785.6836205072814420823.git-patchwork-notify@kernel.org>
Date:   Tue, 02 May 2023 23:20:20 +0000
References: <20230502180543.1832140-1-yhs@fb.com>
In-Reply-To: <20230502180543.1832140-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 2 May 2023 11:05:43 -0700 you wrote:
> In one of our internal testing, we found a case where
>   - uapi struct bpf_tcp_sock is in vmlinux.h where vmlinux.h is not
>     generated from the testing kernel
>   - struct bpf_tcp_sock is not in vmlinux BTF
> 
> The above combination caused bpf load failure as the following
> memory access
>   struct bpf_tcp_sock *tcp_sock = ...;
>   ... tcp_sock->snd_cwnd ...
> needs CORE relocation but the relocation cannot be resolved since
> the kernel BTF does not have corresponding type.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Emit struct bpf_tcp_sock type in vmlinux BTF
    https://git.kernel.org/bpf/bpf-next/c/bf6882aebd0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


