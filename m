Return-Path: <SRS0=uc+s=DH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDE7C4727C
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 00:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762FB20897
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 00:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601424004;
	bh=A6JJfG8E9Ua0Z1MjKPxxF9c8+gw1X1snHHpD7iPUOGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=FOqvMoCBcov2Z5+sa4PQrcI4JoJORAMnIrynPr6FBuwbFFrVrDF1WffvmfX20TtgT
	 lNp4uHUj8hz2nIgf0+wK+epT5o8ebd/ewpV+SKAzmQQ+paNFVUr/BYnKdoEr/HzuXJ
	 aO1B9FVXUn5hGjTVnysArYWEIJPOzjXlZQXOUzl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgI3AAE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 20:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgI3AAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 20:00:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601424003;
        bh=A6JJfG8E9Ua0Z1MjKPxxF9c8+gw1X1snHHpD7iPUOGo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Of4p+zKZtP+TMKwrwuLEDDbbgrwYZlMk2iTQKrQKPn/o/TpYTky4kTx8KyyLLQMDN
         1ymZAFGyBkkrTHdyHg7ZuhrCz5v3+j+VZUtGb8gH9AUYPJaZJlm4/IzAmsad+tenUR
         osfBhJ4EyxuXIQ7PhFuHa9G1R1AvoGkkgTooAh80=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf, x64: optimize JIT's pro/epilogue
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160142400339.22881.13903800847155832950.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Sep 2020 00:00:03 +0000
References: <20200929204653.4325-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20200929204653.4325-1-maciej.fijalkowski@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 22:46:51 +0200 you wrote:
> Hi!
> 
> This small set can be considered as a followup after recent addition of
> support for tailcalls in bpf subprograms and is focused on optimizing
> x64 JIT prologue and epilogue sections.
> 
> Turns out the popping tail call counter is not needed anymore and %rsp
> handling when stack depth is 0 can be skipped.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, x64: drop "pop %rcx" instruction on BPF JIT epilogue
    https://git.kernel.org/bpf/bpf-next/c/d207929d97ea
  - [bpf-next,2/2] bpf: x64: do not emit sub/add 0, %rsp when !stack_depth
    https://git.kernel.org/bpf/bpf-next/c/4d0b8c0b46a5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


