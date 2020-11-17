Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F4BC2D0E4
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 23:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D50C2225B
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 23:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyk3KXE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgKQXUG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgKQXUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605655205;
        bh=SXRWdCFPOz85AyEgBt5NT1j7zcybr4nfU30eFPURXSg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jyk3KXE/XuHW32IE9GbeuosdZXf1D930KMynzCCfpKMZPG4GEs9RnbOps8MHFURuY
         upJQaeZ6OJLDFS3o7xgOO0vzNUC1urOjWSnRcrgOl4yXxtrCo/ztvmlSOSu2bPkvqI
         UJrISXFSP8CZd+97vH9L6GEMvU8As307bEyICLTo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf PATCH v3 0/6] sockmap fixes 
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160565520577.16897.8462803955194787332.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Nov 2020 23:20:05 +0000
References: <160556562395.73229.12161576665124541961.stgit@john-XPS-13-9370>
In-Reply-To: <160556562395.73229.12161576665124541961.stgit@john-XPS-13-9370>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     jakub@cloudflare.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Mon, 16 Nov 2020 14:27:23 -0800 you wrote:
> This includes fixes for sockmap found after I started running skmsg and
> verdict programs on systems that I use daily. To date with attached
> series I've been running for multiple weeks without seeing any issues
> on systems doing calls, mail, movies, etc.
> 
> Also I started running packetdrill and after this series last remaining
> fix needed is to handle MSG_EOR correctly. This will come as a follow
> up to this, but because we use sendpage to pass pages into TCP stack
> we need to enable TCP side some.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/6] bpf, sockmap: fix partial copy_page_to_iter so progress can still be made
    https://git.kernel.org/bpf/bpf/c/c9c89dcd872e
  - [bpf,v3,2/6] bpf, sockmap: Ensure SO_RCVBUF memory is observed on ingress redirect
    https://git.kernel.org/bpf/bpf/c/36cd0e696a83
  - [bpf,v3,3/6] bpf, sockmap: Use truesize with sk_rmem_schedule()
    https://git.kernel.org/bpf/bpf/c/70796fb751f1
  - [bpf,v3,4/6] bpf, sockmap: Avoid returning unneeded EAGAIN when redirecting to self
    https://git.kernel.org/bpf/bpf/c/6fa9201a8989
  - [bpf,v3,5/6] bpf, sockmap: Handle memory acct if skb_verdict prog redirects to self
    https://git.kernel.org/bpf/bpf/c/2443ca66676d
  - [bpf,v3,6/6] bpf, sockmap: Avoid failures from skb_to_sgvec when skb has frag_list
    https://git.kernel.org/bpf/bpf/c/4363023d2668

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


