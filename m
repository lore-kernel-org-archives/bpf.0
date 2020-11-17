Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E174C6369E
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 01:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5C624682
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 01:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxk8s75U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgKQBAF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgKQBAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 20:00:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605574805;
        bh=qxb2bNK1ibr9KQzXsnZnNk3RpwESyMXG9MMrBtT03z4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cxk8s75USiK0Eyw2ARxDwjuKp+wKptW/PbBynYENkNDnRiCXHJrkDrqeeZSm+kxN7
         n/CuWoLIV0XxYzfHxMrTZzkfkcTbfzGL6ySR2mlQGZMZFaXT8dsz4E5d7/Zfrfr2Mb
         /vRjmLkWdkQlAD9dMZtJI5mLxrWB+2ljFHkKHcGo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix the irq and nmi check in bpf_sk_storage for
 tracing usage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160557480494.19963.4345087543810572466.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Nov 2020 01:00:04 +0000
References: <20201116200113.2868539-1-kafai@fb.com>
In-Reply-To: <20201116200113.2868539-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kuba@kernel.org, kernel-team@fb.com, netdev@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 16 Nov 2020 12:01:13 -0800 you wrote:
> The intention of the current check is to avoid using bpf_sk_storage
> in irq and nmi.  Jakub pointed out that the current check cannot
> do that.  For example, in_serving_softirq() returns true
> if the softirq handling is interrupted by hard irq.
> 
> Fixes: 8e4597c627fb ("bpf: Allow using bpf_sk_storage in FENTRY/FEXIT/RAW_TP")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix the irq and nmi check in bpf_sk_storage for tracing usage
    https://git.kernel.org/bpf/bpf-next/c/b93ef089d35c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


