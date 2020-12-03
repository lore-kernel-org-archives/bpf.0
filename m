Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB50C4361A
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 20:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D13222203
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 20:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLCUAq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgLCUAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 15:00:46 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607025606;
        bh=u2avPBs2wcV6gNPGB4NiNw7lv0Nkjyx9BafWVAygCvs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jJNpU9ilhqfZlRtwQN3wA3DSj5bJbjzxbLr29aVfz9FT7g10YymZtwte12YztqDBK
         3w7TMC4JKq4Ip7d9zPObfnsR7/9RHwlIyUvhlYIjG51+aSWhGXjOg9NIuibUQObQXm
         YGRuKePbFRBil9eMGF82R/9tXnCSrKklOShDIl7st2RkyhLCT4E9YVdOoFe6amKh6y
         M3FXRpue75A+du95EVzsguzePApgWyjlK4A3yKWJen+VC98FpfU50enN4dseHysPkN
         8qEINASIFEipDUwzQGDOJZPVOpyWmRoHixFwq2/X9F5Y8ErSzCamQy2IIf3fQU4Rc8
         z0WrlzA9iempg==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libbpf: fail early when loading programs with
 unspecified type
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160702560588.30230.4432583746640187390.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Dec 2020 20:00:05 +0000
References: <20201203043410.59699-1-andreimatei1@gmail.com>
In-Reply-To: <20201203043410.59699-1-andreimatei1@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed,  2 Dec 2020 23:34:10 -0500 you wrote:
> Before this patch, a program with unspecified type
> (BPF_PROG_TYPE_UNSPEC) would be passed to the BPF syscall, only to have
> the kernel reject it with an opaque invalid argument error. This patch
> makes libbpf reject such programs with a nicer error message - in
> particular libbpf now tries to diagnose bad ELF section names at both
> open time and load time.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libbpf: fail early when loading programs with unspecified type
    https://git.kernel.org/bpf/bpf-next/c/80b2b5c3a701

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


