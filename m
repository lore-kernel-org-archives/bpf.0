Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA3C49EA2
	for <bpf@archiver.kernel.org>; Fri, 18 Jun 2021 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0C8613F5
	for <bpf@archiver.kernel.org>; Fri, 18 Jun 2021 18:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhFRScP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhFRScO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 14:32:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 30368613ED;
        Fri, 18 Jun 2021 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624041005;
        bh=hla1afcXiBZO3Ji0LffAnkcrWwE5QynZOPQYf/PQXPQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tmlZOfeOHtWbpgwFCoLo0V3OLvIoq6VCoyDfSFIq/hBH6vTT2HPHYOgZbS+qnl5bg
         Mm3/P0nU9Ls2ylT/hUAigor4n6rx+FTJM9c6ft/RxYe8XZnfEI0IkQFwLUWzL4piLf
         2vfjZ6SILHwwsFa2NPQ6rPeEPzUaWWaNhQJS59vOloobhc2ScAvYqOArA54qebN/IF
         NzqjlHzWQqWNonAeMKo4GRbDGQ2aSeEIV7P4WeUoNsWGkfrtwCBdeLoIDR1H2V0hYj
         Vr9/UvbSS18p9Y5D8ZbNWzNSkRJrV9ILk7xkRFstVvnnf3rDg9fo8lircrLGn53zQd
         qNJcLNHbCMlaQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/1] Autogenerating libbpf API documentation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162404100516.18542.1194147590836785271.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Jun 2021 18:30:05 +0000
References: <20210618140459.9887-1-grantseltzer@gmail.com>
In-Reply-To: <20210618140459.9887-1-grantseltzer@gmail.com>
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 18 Jun 2021 14:04:58 +0000 you wrote:
> This patch series is meant to start the initiative to document libbpf.
> It includes .rst files which are text documentation describing building,
> API naming convention, as well as an index to generated API documentation.
> 
> In this approach the generated API documentation is enabled by the kernels
> existing kernel documentation system which uses sphinx. The resulting docs
> would then be synced to kernel.org/doc
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/1] Add documentation for libbpf including API autogen
    https://git.kernel.org/bpf/bpf-next/c/f540a7d2c37f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


