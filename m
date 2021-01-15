Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA81C433E0
	for <bpf@archiver.kernel.org>; Fri, 15 Jan 2021 23:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5AE23339
	for <bpf@archiver.kernel.org>; Fri, 15 Jan 2021 23:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbhAOXAt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Jan 2021 18:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbhAOXAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jan 2021 18:00:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6591A2399A;
        Fri, 15 Jan 2021 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610751608;
        bh=RuxI0+5o+iF8ELYoih7lRTU/CZKmOIoEc5ZL2ZswYjI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C2i6wcPIUOSxDA240gv7CVN1x1bbDwvGhBsUZ8z3I6gbETbPmLhOTqbYaFlj1/ZMt
         r0obPA5rAYIF7I4sBucQP7fETZYPgNrRL0k4HuW0wyuIYMXMwTPcGY7HiRQtpbz3Dc
         4ht+fJLHpjheFkdmCbdJo2akI81ID/eo+AioU5ExV/aX0PBF4uIhDo79Ozvh4nUzhM
         0VQaNjrM7+dOqmT1S/ynQF0JyUNw+Yg2sNpTseRGq5QWfNnPrEJdCbuvNIGxV6dM4L
         BMmplvy3tXS3NJ4ifKiYkXjAqjbL2SWBERPk1IPnCw4X09ZvN2OTk/xbbGMKWEkaHi
         InAQI9MvrLKmA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: update my email address
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161075160837.22495.5230649397692870926.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jan 2021 23:00:08 +0000
References: <20210115104337.7751-1-bjorn.topel@gmail.com>
In-Reply-To: <20210115104337.7751-1-bjorn.topel@gmail.com>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAZ21haWwuY29tPg==?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, bjorn@kernel.org,
        linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Fri, 15 Jan 2021 11:43:37 +0100 you wrote:
> From: Björn Töpel <bjorn@kernel.org>
> 
> My Intel email will stop working in a not too distant future. Move my
> MAINTAINERS entries to my kernel.org address.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] MAINTAINERS: update my email address
    https://git.kernel.org/bpf/bpf/c/235ecd36c7a9

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


