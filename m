Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70FC64E90
	for <bpf@archiver.kernel.org>; Mon, 30 Nov 2020 22:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D0620857
	for <bpf@archiver.kernel.org>; Mon, 30 Nov 2020 22:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFvkax7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgK3WAq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgK3WAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 17:00:46 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606773605;
        bh=Pldb+UCD99ZZpz434GAUDJkd11qwRgAiJcgN4PWtE9k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vFvkax7WNxcgaoxHbaABluUAdhY/tVszMfi+HcBIBHY9wbLTpte3Skx9snnKf4Z3Q
         x7/K1xTTlMzVDVC328IRcRTBS/H/iVxd79SSGLkl8ok1C/EtyQ+PR+Jj+JaZYoCLC8
         94qW6kn4kmEVSd7CN8rAUAf3VQucWs1Ncq0Na4Dc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flavored variants of test_ima
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160677360569.26869.11402788721160375478.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Nov 2020 22:00:05 +0000
References: <20201126184946.1708213-1-kpsingh@chromium.org>
In-Reply-To: <20201126184946.1708213-1-kpsingh@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf@vger.kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, revest@chromium.org, jackmanb@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 26 Nov 2020 18:49:46 +0000 you wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Flavored variants of test_progs (e.g. test_progs-no_alu32) change their
> working directory to the corresponding subdirectory (e.g. no_alu32).
> Since the setup script required by test_ima (ima_setup.sh) is not
> mentioned in the dependencies, it does not get copied to these
> subdirectories and causes flavored variants of test_ima to fail.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix flavored variants of test_ima
    https://git.kernel.org/bpf/bpf-next/c/854055c0cf30

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


