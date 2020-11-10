Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2F2C2D0A3
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 00:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F9C207D3
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 00:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVaLnKLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKJAaF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgKJAaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 19:30:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604968204;
        bh=Uq0HtpuNQ7Mo0Nnu5gzptiZMxCSCjx6iBv7UzWmQo7E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uVaLnKLORb6vxLuKQfnr/amycvbyc1XRC4Lm4qhFgYXsesGrtWvlNC6yPQby0r/lP
         qaoRiF9cI1fqCPBrKunEpok7JMHRUkZq2143J5e+DxPMH0WXqwZJ47ux3iCPSwxihj
         QAADAnXlt8nFxhzV/Up/3B7oTkEYZsmsawWYINL8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: selftest: Use static globals in tcp_hdr_options
 and btf_skc_cls_ingress
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160496820472.3832.13317278965010005669.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Nov 2020 00:30:04 +0000
References: <20201106225402.4135741-1-kafai@fb.com>
In-Reply-To: <20201106225402.4135741-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 6 Nov 2020 14:54:02 -0800 you wrote:
> Some globals in the tcp_hdr_options test and btf_skc_cls_ingress test
> are not using static scope.  This patch fixes it.
> 
> Targeting bpf-next branch as an improvement since it currently does not
> break the build.
> 
> Fixes: ad2f8eb0095e ("bpf: selftests: Tcp header options")
> Fixes: 9a856cae2217 ("bpf: selftest: Add test_btf_skc_cls_ingress")
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: selftest: Use static globals in tcp_hdr_options and btf_skc_cls_ingress
    https://git.kernel.org/bpf/bpf-next/c/f52b8fd33257

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


