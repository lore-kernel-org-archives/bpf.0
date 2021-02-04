Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86580C433E0
	for <bpf@archiver.kernel.org>; Thu,  4 Feb 2021 16:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AE064F4D
	for <bpf@archiver.kernel.org>; Thu,  4 Feb 2021 16:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhBDQLP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237687AbhBDQKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 11:10:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0915D64F6A;
        Thu,  4 Feb 2021 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612455007;
        bh=swyBGTcsJBrat/oEJNcKSg17JKJwWj1HmDi3Z4jelJw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RDEqR/C103+FBZcNr88BS6Yt7pBqdwEzFe+5CTECorvhs7ARjSccKX1JjD9P2Qxaa
         azCvoScFRl+z6z4EYzClwehTxZm2PqS4LLjyP7kzSnPr9yWTSo+OiuVoYQMbjKs7iL
         kTcE7+8amvpL+Io1t5/z2hP5pWFnowjA8YlsqCjG/uOACIS7FhJMk+ws7FFc0ib0Dd
         j9n3+CnHI5gwaxj+UD/zKL8rnX2/ezxLn3eCKT8mOaWZ3bd4hfpKaP7/AqS5ZjUEVN
         u7+SsTx34EbuWIrIPXFFaAoxu8yo08YABd5/1Jm4jQ7/4YF2OZfZ9OrjVn9ecCv7F8
         yvHtWVhIcAjlA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Emit explicit NULL pointer checks for PROBE_LDX
 instructions.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161245500698.23366.9347266254041745601.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Feb 2021 16:10:06 +0000
References: <20210202053837.95909-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210202053837.95909-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  1 Feb 2021 21:38:37 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> PTR_TO_BTF_ID registers contain either kernel pointer or NULL.
> Emit the NULL check explicitly by JIT instead of going into
> do_user_addr_fault() on NULL deference.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Emit explicit NULL pointer checks for PROBE_LDX instructions.
    https://git.kernel.org/bpf/bpf-next/c/4c5de127598e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


