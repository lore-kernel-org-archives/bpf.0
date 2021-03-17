Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB27C433DB
	for <bpf@archiver.kernel.org>; Wed, 17 Mar 2021 23:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5232464F20
	for <bpf@archiver.kernel.org>; Wed, 17 Mar 2021 23:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCQXuO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Mar 2021 19:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCQXuI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 19:50:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5B24764F20;
        Wed, 17 Mar 2021 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616025008;
        bh=KDbsb5dEQechYp6a/3jCaUcxfT+403Pqo00Fe1sb4o0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Jz9M10WtFAyOxxGqhkDCnZEYVSW23oNSkHy+7xtIGkHHK27PajAFJvRIfElWju5rR
         AXDx2LXL3jTGBcOgw6te6pUIKkJWJEM8v5DLPD9PJwcRFePo9lCZez2irJNeRhg9zg
         YHw81nJRhJHGkECsM8iebonXYoHYbTkVrVytfbTBI66sIx8MUP0wN/WGW3Lv0zqAUQ
         0E9TnqMM91EZjRvPt5cwWoc9a3nzCv4HP9rf0mRt2WUTZ4BuPi12COaXDy8gL6Kubg
         mxlUhFnT4puG6cNna3hye9XdnoGr3iOhT6UJHbWGytjynr95aefeolYq9Tf8sxXGw6
         0B7wSluL6j1Rw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix error path in bpf_object__elf_init()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161602500831.24175.3204440838433756707.git-patchwork-notify@kernel.org>
Date:   Wed, 17 Mar 2021 23:50:08 +0000
References: <20210317145414.884817-1-namhyung@kernel.org>
In-Reply-To: <20210317145414.884817-1-namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 17 Mar 2021 23:54:14 +0900 you wrote:
> When it failed to get section names, it should call
> bpf_object__elf_finish() like others.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - libbpf: Fix error path in bpf_object__elf_init()
    https://git.kernel.org/bpf/bpf/c/8f3f5792f294

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


