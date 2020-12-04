Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77171C433FE
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 20:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDF222C9C
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 20:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgLDUar (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgLDUaq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 15:30:46 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607113806;
        bh=AUCS15uf0JYnRffSh3WYFb1hvqGziNQGH8XV3fjYO30=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fZjU02QbbY4yUUV77xdQzY+QsybDx13kLbToJ3D4aj9rvEswWw2tozmGiCAWxsWuo
         0ajo7KRL+GauX7dZEI3xeujt/4ycZzPWNoRu0fwZUJTX8QDaa+Lep5pLCzWM5vpH0H
         9v4x9jy3uzhRYNTVcQ4UQUoWRjYs7/+4Y3V5wopA+pMfYuaQa4R79kiGpMBlTliUEd
         zxxU89mW2A0t5yigiAKSTQTGfLIeYfMf2yUnNI+4eXNKvpNZNw4HsIfRSFihxjy/x7
         GO974DjKK8imn4ZDvponBvdLI1aDYZp8dH63vl1ZvcVAXWIiKy8LZUb5CUKeQEwKER
         8Evk1NSYCIaoQ==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2 v3] Improve error handling of verifier tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160711380631.17303.9145064627875444770.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Dec 2020 20:30:06 +0000
References: <20201204181828.11974-1-dev@der-flo.net>
In-Reply-To: <20201204181828.11974-1-dev@der-flo.net>
To:     Florian Lehner <dev@der-flo.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Fri,  4 Dec 2020 19:18:26 +0100 you wrote:
> These patches improve the error handling for verifier tests. With "Test
> the 32bit narrow read" Krzesimir Nowak provided these patches first, but
> they were never merged.
> The improved error handling helps to implement and test BPF program types
> that are not supported yet.
> 
> v3:
>   - Add explicit fallthrough
> 
> [...]

Here is the summary with links:
  - [1/2] selftests/bpf: Print reason when a tester could not run a program
    https://git.kernel.org/bpf/bpf-next/c/7d17167244f5
  - [2/2] selftests/bpf: Avoid errno clobbering
    https://git.kernel.org/bpf/bpf-next/c/5f61b7c6975b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


