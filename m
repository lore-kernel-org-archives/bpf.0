Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E9C433ED
	for <bpf@archiver.kernel.org>; Thu, 15 Apr 2021 22:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C3C61139
	for <bpf@archiver.kernel.org>; Thu, 15 Apr 2021 22:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhDOWkc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Apr 2021 18:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234764AbhDOWkc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 18:40:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9800661131;
        Thu, 15 Apr 2021 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618526408;
        bh=s5osAFJIBoErzySH2HP+pQ61kWzT3jkqYJyaM+C1vA8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NvUAQhyt8BE7o2+Wy4TgkDE+r/ByaFHu4PxyLg0fNSmtv9EL36OLjCr/Peywqzr5c
         6u66ipKOSa+oVMqpYmZ5SdIhGN0Q9nnL4BbU1i4k8rDba86gdlgGQtYSDtZDn17vwK
         uD1KaFSfbBy3beIVvrc8epD9MxTvFgerUY7Uki0o6xQt+XeVF2FGo6BHa0tCv9EsZ8
         arcEKiC458aGMzdL9lNev+S7cVTEfPIuA52QETn+LwdTjCZMwy8zTgbEvLeJiov2uT
         NvjVebH37MmE+0ggwNaCZIYABfds/T7t0daH9nELmnn/2c48yitnQOcDgYD8UdxN4z
         B4skClzhU3s6Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Remove unused field.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161852640857.32185.14340755924265777528.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Apr 2021 22:40:08 +0000
References: <20210415141817.53136-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210415141817.53136-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 15 Apr 2021 07:18:17 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> relo->processed is set, but not used. Remove it.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Here is the summary with links:
  - [bpf-next] libbpf: Remove unused field.
    https://git.kernel.org/bpf/bpf-next/c/d3d93e34bd98

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


