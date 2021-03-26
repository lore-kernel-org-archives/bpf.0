Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9328C433DB
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B410361A1A
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 16:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhCZQuk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Mar 2021 12:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhCZQuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 12:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B7CC861A2A;
        Fri, 26 Mar 2021 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616777409;
        bh=bPvnKB1bqYHAOC0vfdChI5XA7D+a8Ut3c68V91H9DwQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aBY+gXeo2zGOyH/ncBBMIJHHEuugSwt0/cZu5W/ubzevaz67KUWZrC1ZVcxj8JEP9
         7xx4L5JlQMHCFUwW5sujGXJ8Fsxh5YZPUrSYgEWTA41l9cpraOogC/tFDJ+chE5amK
         GcKFPzD+NNV3tSgo4OBskIQB1z12sPy8XtQcPYt3X8ZwBx7e9KQ5VN47zs7Pl17p1D
         W/KPghhYBSMHSjkz/xYUDSLx4056h+H0C39Gzk7pl0Cke5oVz1w0XK4uFXGWdwzxSB
         DtZ67jLv6fgglk6LcEPiwDTUhsokveRQTFNWHPPFTbiXf/RKSnizGQI+D7eJ3FaAwn
         GXLNiEXmrrV/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] include: net: struct sock is declared twice
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161677740962.24745.2082571652347835274.git-patchwork-notify@kernel.org>
Date:   Fri, 26 Mar 2021 16:50:09 +0000
References: <20210325070602.858024-1-wanjiabing@vivo.com>
In-Reply-To: <20210325070602.858024-1-wanjiabing@vivo.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 25 Mar 2021 15:06:02 +0800 you wrote:
> struct sock has been declared. Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/net/bpf_sk_storage.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - include: net: struct sock is declared twice
    https://git.kernel.org/bpf/bpf-next/c/fcb8d0d7587e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


