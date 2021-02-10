Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3188C433E9
	for <bpf@archiver.kernel.org>; Wed, 10 Feb 2021 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA36C64EE5
	for <bpf@archiver.kernel.org>; Wed, 10 Feb 2021 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhBJUY5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhBJUXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 15:23:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 990A064EE7;
        Wed, 10 Feb 2021 20:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988458;
        bh=A1OGZxdVLmo97uZgjqZtndeKBYSVE9LkJWn/8Nkyuz0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ImdF+HVcfDcNburfhgJoTUbmLcDBziq/R0H+wyiqq8fJJscJZGQWthAuCl5eUi2/f
         OGoxu4l134EIr/hPG7rVaEyIw8bV+yqn8B6QbzMfe/fgjXRBIG83HZMeC5RU/OObpb
         A5HwrPAIV3mMWnb19ub4qIz6DGz/0HGIpcNnBgoO1skUqaT6pnaZIYQVPIARtd4hqs
         GWx4I/0ctZehMvqQJl73McpYXKZF3/LdujjAib5TC5zDnbejkbtK7k+21jnxu6SRmO
         Im5ehOnejPSxmTYCL3VXMkY6cddaxCvVmMBYTFWLhVpID4NvWe3McQQHSYn43c5Bpj
         xGNftnXy82ltQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix endianness issues in atomic tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161298845855.26937.3345427891979780404.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Feb 2021 20:20:58 +0000
References: <20210210020713.77911-1-iii@linux.ibm.com>
In-Reply-To: <20210210020713.77911-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 10 Feb 2021 03:07:13 +0100 you wrote:
> Atomic tests store a DW, but then load it back as a W from the same
> address. This doesn't work on big-endian systems, and since the point
> of those tests is not testing narrow loads, fix simply by loading a
> DW.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 98d666d05a1d ("bpf: Add tests for new BPF atomic operations")
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix endianness issues in atomic tests
    https://git.kernel.org/bpf/bpf-next/c/45df30526825

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


