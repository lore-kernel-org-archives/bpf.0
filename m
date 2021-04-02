Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D62C433ED
	for <bpf@archiver.kernel.org>; Fri,  2 Apr 2021 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D7661183
	for <bpf@archiver.kernel.org>; Fri,  2 Apr 2021 23:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhDBXuL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Apr 2021 19:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234908AbhDBXuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 19:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EA9016112E;
        Fri,  2 Apr 2021 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617407409;
        bh=GHU4ooGlVbVTMpAz4JEW57VIOLPeXfAUssnkK5ZlkWw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GLfTQ21oHeNXx29ZxxXEJkrnboBYygJ1Z8EGIWDTDZyyllUYyp9UGq+IJ8jKzrWD7
         qYeD09DXa1+esX7bWZ3rN7kYCt21kzAvwza/YluYsqq3xqC3YiLG3Ys/0FfG7oOtPS
         yzw5TWhYRtCJzn3LxzL/LCBK4l2gqN7kvDciqQF7w5Tqx3Rjkg+wGJN7F63tfPuufk
         i2YMWorMxuel4YLJgqfaddmW3QH5o5QOcrweVk3sZnEVyuiSwii5uq7BTsHmsFywBv
         JDAa+ojj0t+fvet4+qNvMPPxj/fwogZF61xfUHjyzY66/ZpBVIlnsQM4ZGSraY40a0
         mvsO2EBs9pbQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] linux/bpf.h: Remove repeated struct declaration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161740740889.27506.15715239233278144317.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Apr 2021 23:50:08 +0000
References: <20210401072037.995849-1-wanjiabing@vivo.com>
In-Reply-To: <20210401072037.995849-1-wanjiabing@vivo.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  1 Apr 2021 15:20:37 +0800 you wrote:
> struct btf_type is declared twice. One is declared at 35th line.
> The blew one is not needed. Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/bpf.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - linux/bpf.h: Remove repeated struct declaration
    https://git.kernel.org/bpf/bpf-next/c/6ac4c6f887f5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


