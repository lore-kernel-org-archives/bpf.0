Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769EDC47420
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 20:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0A22076D
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601411409;
	bh=nW+Hk0tKaZYDSl3lVZdl4YLL0D4cy0TFJh8tQWvp7J4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=tWysu1VYcVnQJpHisoy13vF4MKqyx4aZqeP+003wseUvg4vKcQD3vxywpx4c2DK16
	 E9dHt9Zv+j3wPykjSGdpmX9EkB++5OB6d3hRjMLslI7LoMwUsfo67pDGNYpCEUs4tr
	 k8NfKUfzsW8sF83+pCNTLtshA1wjeJe+aO7FLAH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgI2UaG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbgI2UaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601411404;
        bh=nW+Hk0tKaZYDSl3lVZdl4YLL0D4cy0TFJh8tQWvp7J4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UR/D+05QLTLSZNsEhjCUUZL+fKX+V4X6XMA/PjLAhLsfvqzERBZg/L/oNGx8vXwY3
         mrqEU4DuLPJ9MvRBjoDhwLiJJtdeZ/3FEAaEKvDglxUBzmIo0a5HoMbEoHN2ytEzXi
         wE6jCLgjVlLtS6qqLGEKHXsjcV3dHPp886dP2ubw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next PATCH] bpf,
 selftests: fix warning in snprintf_btf where system() call unchecked
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160141140480.17638.2211015367858971528.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 20:30:04 +0000
References: <160141006897.25201.12095049414156293265.stgit@john-Precision-5820-Tower>
In-Reply-To: <160141006897.25201.12095049414156293265.stgit@john-Precision-5820-Tower>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 13:07:49 -0700 you wrote:
> On my systems system() calls are marked with warn_unused_result
> apparently. So without error checking we get this warning,
> 
> ./prog_tests/snprintf_btf.c:30:9: warning: ignoring return value
>    of ‘system’, declared with attribute warn_unused_result[-Wunused-result]
> 
> Also it seems like a good idea to check the return value anyways
> to ensure ping exists even if its seems unlikely.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, selftests: fix warning in snprintf_btf where system() call unchecked
    https://git.kernel.org/bpf/bpf-next/c/c810b31ecb03

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


