Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2D7C433B4
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 15:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE7C61363
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 15:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhDLPk2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240600AbhDLPk1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:40:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 472A061356;
        Mon, 12 Apr 2021 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618242009;
        bh=cyUjI3weUqPl6H7WaONppY25mWACI4d0IU+b0NtJ5HE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FRarOSO4GcY2F0EP8N/v2XsL3xsPAZVkhXUpLY6Mx2Uny5RKZ/NlFuFPyznZh2U1M
         GfWe9ht1faWqnR3MplrvR7bNbmxz1Vx7aXV58rI5QPBA8GF9M0imKeDwUN/zl1nWx7
         n6nL0VNKFYWTr51mGW1XueybeYnaS/unVG7E+YeUgsNDKirx6V8oNzTO5BuilkaqMv
         dmJAkGASJFtqQUWz3IMXYhpnAG7izP7C6xATg+pZJe6yjv7nDyy0Ej6Cx1dIG0EpOg
         h0XAGUw4OlZ1j7SxYCatRxkoa0VrZ0uBKgGvX6nx3RxIvfvC95v5rBra8fxN9EXAOp
         L8TQLANS/NtwA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Document PROG_TEST_RUN limitations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161824200921.5298.6148172568351920270.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Apr 2021 15:40:09 +0000
References: <20210410174549.816482-1-joe@cilium.io>
In-Reply-To: <20210410174549.816482-1-joe@cilium.io>
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        yhs@fb.com, lmb@cloudflare.com, songliubraving@fb.com,
        sdf@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 10 Apr 2021 10:45:48 -0700 you wrote:
> Per net/bpf/test_run.c, particular prog types have additional
> restrictions around the parameters that can be provided, so document
> these in the header.
> 
> I didn't bother documenting the limitation on duration for raw
> tracepoints since that's an output parameter anyway.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Document PROG_TEST_RUN limitations
    https://git.kernel.org/bpf/bpf-next/c/f3c45326ee71

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


