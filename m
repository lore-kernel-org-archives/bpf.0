Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32CBC4338F
	for <bpf@archiver.kernel.org>; Wed, 11 Aug 2021 14:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C4B61008
	for <bpf@archiver.kernel.org>; Wed, 11 Aug 2021 14:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhHKOUm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhHKOUl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 10:20:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BD1666101E;
        Wed, 11 Aug 2021 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628691617;
        bh=yBD9HUfzmgb8Oom65iVEdo87kc/F5O2W8KbGkXurL/0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s7exqjytXX9QbIUOPE94VeqyEjvE1365cVpv3F4Tn3rez94szju8MG0oCG+gSGGER
         ucWezpeIWsMAJK+kC154++UMKA7/7A8UD1UFrcDfrU8WgDnjapA2LV/l+vAMN1hLPi
         ORuIsGTnNFZ44ahtBxI4aUXq6FLKs/0xQdd2YXQQYNHrzkLEXySOLUBF513lROiWPR
         uL8RD3ueujIPt4FMbzGxwuPIv41qxQOA/ftXp0WIIy9vF8w3U95ufvFKdama6oKd94
         W5EcQ3/CAtp+Pr3a6uxpTopeRBQe54szBR1gbhaoaA4+Qo85xnANa/ewteOr26lBOI
         RLVh4HxURrcaA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix running of XDP bonding tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162869161771.7005.4799604087843127523.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Aug 2021 14:20:17 +0000
References: <20210811123627.20223-1-joamaki@gmail.com>
In-Reply-To: <20210811123627.20223-1-joamaki@gmail.com>
To:     Jussi Maki <joamaki@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 11 Aug 2021 12:36:27 +0000 you wrote:
> An "innocent" cleanup in the last version of the XDP bonding
> patchset moved the "test__start_subtest" calls to the test
> main function, but I forgot to reverse the condition, which
> lead to all tests being skipped. Fix it.
> 
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix running of XDP bonding tests
    https://git.kernel.org/bpf/bpf-next/c/25dc3895baaa

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


