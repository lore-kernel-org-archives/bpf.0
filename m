Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B89C4742C
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 16:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A54620729
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 16:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="exsGQNUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgKPQKF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730625AbgKPQKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 11:10:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605543005;
        bh=VsEfImsb7aaIN8/Kom4MRznnt1LW1W7uTKpHZ4emYpc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=exsGQNUlQb4PJyAftbxb7SK5+uEy+hQgONU7ygIneYM8FeVKsuIkg9VLBeR/uKeFm
         zEA2uhijbi3jS0NKQPzSwcBis2qAtKgcfi1Yv3wyBg+8d6s5Sp+iOI5Mi2Ek1GoIqD
         GquqSjTzPAhxr8GHvnsphc+xm0ztk50SXWNOyuVk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftest/bpf: fix IPV6FR handling in flow dissector
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160554300507.14285.2147339351809481146.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Nov 2020 16:10:05 +0000
References: <X7JUzUj34ceE2wBm@santucci.pierpaolo>
In-Reply-To: <X7JUzUj34ceE2wBm@santucci.pierpaolo>
To:     Santucci Pierpaolo <santucci@epigenesys.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andrii@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 16 Nov 2020 11:30:37 +0100 you wrote:
> >From second fragment on, IPV6FR program must stop the dissection of IPV6
> fragmented packet. This is the same approach used for IPV4 fragmentation.
> This fixes the flow keys calculation for the upper-layer protocols.
> Note that according to RFC8200, the first fragment packet must include
> the upper-layer header.
> 
> Signed-off-by: Santucci Pierpaolo <santucci@epigenesys.com>
> 
> [...]

Here is the summary with links:
  - [v2] selftest/bpf: fix IPV6FR handling in flow dissector
    https://git.kernel.org/bpf/bpf-next/c/024cd2cbd1ca

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


