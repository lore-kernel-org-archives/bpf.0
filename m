Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A74C43462
	for <bpf@archiver.kernel.org>; Fri,  2 Apr 2021 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE4061185
	for <bpf@archiver.kernel.org>; Fri,  2 Apr 2021 23:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhDBXuM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Apr 2021 19:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235256AbhDBXuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 19:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0AA2A61186;
        Fri,  2 Apr 2021 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617407409;
        bh=3Bi7GR+aSkQtPpGZta6shYRhKPLMp8cHPLrhYjl9g1k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s4rCNm1km5QIzlNyWd1LZeN6CmssPqfeFmF6ViSlJmtRi3RpAmhGQKT+9eONFYT3s
         TKcXjGE5AwLBvMSjLK3ssckN/6ppSTtmi4ODo4uouGp+jqYGW4S5dfUopzw4s7fy8i
         2R111OgIpttv/rRQBh619EcAiRT7n4ehcVeX2ejrdYhXALYNaPtaCtrB5JFAgf6Yt6
         1Qsuc5j0w9gyll2wulpIWafCpIH5jYru96RbQOW0Zvv3E69DAiKwWGmNLAf3vgM2Ss
         1ZLNs61gYC6wRxF6Qu0HjNh9w1poZORpaNWndc6V6umDN/yzMT+9qx4kIuHqz6tiCJ
         EKIKKio4pZ87Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] linux/bpf-cgroup.h: Delete repeated struct declaration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161740740897.27506.7716128219327085410.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Apr 2021 23:50:08 +0000
References: <20210401064637.993327-1-wanjiabing@vivo.com>
In-Reply-To: <20210401064637.993327-1-wanjiabing@vivo.com>
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

On Thu,  1 Apr 2021 14:46:37 +0800 you wrote:
> struct bpf_prog is declared twice. There is one declaration
> which is independent on the MACRO at 18th line.
> So the below one is not needed though. Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/bpf-cgroup.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - linux/bpf-cgroup.h: Delete repeated struct declaration
    https://git.kernel.org/bpf/bpf-next/c/2daae89666ad

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


