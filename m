Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C64AC63697
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127ED2469D
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLyc9R5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgKSRAG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Nov 2020 12:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgKSRAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 12:00:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605805205;
        bh=NFaRCoK+duTuFLA/IvS65CpltxA3sv7nJQm3qn8aAl8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uLyc9R5Aa4RD46FF++1b7uqO4CM9jjgBad72x46ph5Xv0ZXD1Ccr2toO6XkbghUoy
         YoEzoHJ2az+cQqGBLMVuWoJ5YR9z57+3G0/KfFvKSjewD4jdGCYgZFlPWamv/aoltw
         usTkLGsZ7lsgRVcNF8AXx+u0yDc7iRZx3tVQqLPw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix VERSIONED_SYM_COUNT number parsing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160580520567.11649.11624136099417270376.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Nov 2020 17:00:05 +0000
References: <20201118211350.1493421-1-jolsa@kernel.org>
In-Reply-To: <20201118211350.1493421-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com,
        tony.ambardar@gmail.com, cascardo@canonical.com,
        aurelien@aurel32.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 18 Nov 2020 22:13:50 +0100 you wrote:
> We remove "other info" from "readelf -s --wide" output when
> parsing GLOBAL_SYM_COUNT variable, which was added in [1].
> But we don't do that for VERSIONED_SYM_COUNT and it's failing
> the check_abi target on powerpc Fedora 33.
> 
> The extra "other info" wasn't problem for VERSIONED_SYM_COUNT
> parsing until commit [2] added awk in the pipe, which assumes
> that the last column is symbol, but it can be "other info".
> 
> [...]

Here is the summary with links:
  - libbpf: Fix VERSIONED_SYM_COUNT number parsing
    https://git.kernel.org/bpf/bpf/c/1fd6cee127e2

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


