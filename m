Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52183C433DB
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E8664F1C
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 15:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhCDPvQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234172AbhCDPur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 10:50:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4EE1B64F02;
        Thu,  4 Mar 2021 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614873007;
        bh=13UobHiXkomCjZUPZJBU9DrYDOK+JKZaWtXJy9fi8PA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VcWQrdita1Qr9qWIcjE+d3w2Bzrg7qXtJ68i7nEtL4lVNQR4sJm3KevR+nwHeqRWZ
         bE0Z6ahWWFvoNB6jwRFRfHQI1nYLHDKdS0ocDRDKf5KNyRX9jhA8P8A9asRttJqXMy
         si6gvXYAN0qzKw98xTZRjsfEXPGkpRwzCEIcW3mrEryJKwg94o4QrRbDeN95C9Kjah
         z2LbUiulCyUIEtAr9Unf0zZde7S92/F8CAua1QYqiFmuryxMSsl6aicRyZresVPHYz
         VN/Lh1FCqYdCeXpp1RvFIS/roME1H641UwJ2OprwLUy28RHA2Ema6yxnipz1JioApA
         Dz0okpc0oZ6iQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add a verifier scale test with
 unknown bounded loop
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161487300726.23414.8497936169085676798.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Mar 2021 15:50:07 +0000
References: <20210226223810.236472-1-yhs@fb.com>
In-Reply-To: <20210226223810.236472-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, pizhenwei@bytedance.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 26 Feb 2021 14:38:10 -0800 you wrote:
> The original bcc pull request
>   https://github.com/iovisor/bcc/pull/3270
> exposed a verifier failure with Clang 12/13 while
> Clang 4 works fine. Further investigation exposed two issues.
>   Issue 1: LLVM may generate code which uses less refined
>      value. The issue is fixed in llvm patch
>      https://reviews.llvm.org/D97479
>   Issue 2: Spills with initial value 0 are marked as precise
>      which makes later state pruning less effective.
>      This is my rough initial analysis and further investigation
>      is needed to find how to improve verifier pruning
>      in such cases.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: add a verifier scale test with unknown bounded loop
    https://git.kernel.org/bpf/bpf-next/c/86a35af628e5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


