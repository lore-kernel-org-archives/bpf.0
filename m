Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC72CC433ED
	for <bpf@archiver.kernel.org>; Tue, 27 Apr 2021 23:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8149861222
	for <bpf@archiver.kernel.org>; Tue, 27 Apr 2021 23:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhD0XVF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Apr 2021 19:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235423AbhD0XUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 19:20:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9D342613B0;
        Tue, 27 Apr 2021 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619565609;
        bh=b8tLAU7dKdLUGC3UB2siG9xZir71vQRt1mbCzMXntNw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dh383S4mgHTB3Mb8KcDXZCcXoa46nU45fIIcR3NOc7UeMbFU/1md2VaJTGGAJ3P0h
         HngJ6Ype7yAwVgVtwLq4+U1kFHKH0e2WjCC7yNKiZXz0oLvKJ55/eesLIq/CYTKD3V
         QJWX0rJyAQJJ+eg3/BqtD8xEwtO36U732v1Qa28sfvhpfxjXjX8m15YMhB753lFbvq
         e2fMf0MP3PLTBB1w/OZYZ0YAubwjQL0XAhNe+TpjaM6JBYA+GN0jfjFCBZMG/wIOn7
         pyZjlYTkKYJdyzocPUyuii+Za3cERVXZOI1eg8UpRmft95vFaB7yrTIO0ffHKHOIe/
         iSJQDG9ne8aHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] add batched ops for percpu array
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161956560959.15012.15996853487160339552.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Apr 2021 23:20:09 +0000
References: <20210424214510.806627-1-pctammela@mojatatu.com>
In-Reply-To: <20210424214510.806627-1-pctammela@mojatatu.com>
To:     Pedro Tammela <pctammela@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, shuah@kernel.org,
        pctammela@mojatatu.com, david.verbeiren@tessares.net,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 24 Apr 2021 18:45:08 -0300 you wrote:
> This patchset introduces batched operations for the per-cpu variant of
> the array map.
> 
> Also updates the batch ops test for arrays.
> 
> v4 -> v5:
> - Revert removal of percpu macros
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: add batched ops support for percpu array
    https://git.kernel.org/bpf/bpf-next/c/f008d732ab18
  - [bpf-next,v5,2/2] bpf: selftests: update array map tests for per-cpu batched ops
    https://git.kernel.org/bpf/bpf-next/c/3733bfbbdd28

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


