Return-Path: <SRS0=IKg2=DM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52044C4363A
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB8A207BC
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601905804;
	bh=jkeoUvfb9+qi0YP3XKCy/+JI0hbfm4G/XT6Mu4Ewqs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=NoBIjoApx/dvfs+l0/9xk0wwKbsptWWFANeEuojgCnbKUL9C3x6BLbKsN2OcrZv6k
	 B6ovYjS4dF6Y2FDn+oHQUIgEyMRKtNHyXDVaUwqEIyuDghrcOaj2XUv2+ulaqgl06k
	 ZlsmnTSmx4CQoI/HQkARCkPJb5aCnXlLla/bVNMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJENuD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgJENuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 09:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601905802;
        bh=jkeoUvfb9+qi0YP3XKCy/+JI0hbfm4G/XT6Mu4Ewqs8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WikUrC9dxK8AHyrFnSujllFOtBlwYoektxDSFBeeBbH5VB0wBD0ZbVc83H4xtrjlG
         r5WdKRryqJx4D8p3hpAiQq120A8H7dcd6pqu7O2scYztbYOg6GjG0JeNKUIqex4JeI
         MTWTO+TZw41CW6gfEgpHnaBjXJkBgzKBtc2gONYk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: remove internal DMA headers
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160190580272.6052.16962712861392065928.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Oct 2020 13:50:02 +0000
References: <20201005090525.116689-1-bjorn.topel@gmail.com>
In-Reply-To: <20201005090525.116689-1-bjorn.topel@gmail.com>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAZ21haWwuY29tPg==?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  5 Oct 2020 11:05:25 +0200 you wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> Christoph Hellwig correctly pointed out [1] that the AF_XDP core was
> pointlessly including internal headers. Let us remove those includes.
> 
> [1] https://lore.kernel.org/bpf/20201005084341.GA3224@infradead.org/
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: remove internal DMA headers
    https://git.kernel.org/bpf/bpf-next/c/b75597d8947f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


