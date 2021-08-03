Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2632C432BE
	for <bpf@archiver.kernel.org>; Tue,  3 Aug 2021 11:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC62861078
	for <bpf@archiver.kernel.org>; Tue,  3 Aug 2021 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhHCLAT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235255AbhHCLAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Aug 2021 07:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5FFBB60FC2;
        Tue,  3 Aug 2021 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627988405;
        bh=u0iSr8tWET96V33a/KIoDgeLBp517jFLEILaNgFmTdI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BE9IBW8cTKdta7AVbO/Bq/ofr94tVxFB5+R1UYlKUBcdUkWlIDWbf8mm9pe3tlc4L
         bS/IFvi5/elt9bL0wOKg0LNvm0ICNgR24sze15gPkfsMKzKc8S79LoEgSZwR9t57BB
         5m7qXejTjfH3yMZdvReoec6vx+Fi4AENGNuh+Vkoogd/JbL10UKVpIlP14/1hG6GUt
         2njYpvQHj2KrtJzEoysaIFMpQAOfYO52E0k/fkSF4TjWKtz8LpfcRVlx3p/+1D3Ifm
         r163KZNo0kyaJRbBhMStmIat7MmJCnlCiIDRqftCuwlWAN/YsOI525aC8fYhOWtZ1V
         MNAd+p7ocResw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: libbpf: eliminate Docum. warnings in
 libbpf_naming_convention
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162798840534.8237.10933586439896059711.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Aug 2021 11:00:05 +0000
References: <20210802015037.787-1-rdunlap@infradead.org>
In-Reply-To: <20210802015037.787-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, grantseltzer@gmail.com, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Sun,  1 Aug 2021 18:50:37 -0700 you wrote:
> Use "code-block: none" instead of "c" for non-C-language code blocks.
> Removes these warnings:
> 
> lnx-514-rc4/Documentation/bpf/libbpf/libbpf_naming_convention.rst:111: WARNING: Could not lex literal_block as "c". Highlighting skipped.
> lnx-514-rc4/Documentation/bpf/libbpf/libbpf_naming_convention.rst:124: WARNING: Could not lex literal_block as "c". Highlighting skipped.
> 
> Fixes: f42cfb469f9b ("bpf: Add documentation for libbpf including API autogen")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Grant Seltzer <grantseltzer@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - bpf: libbpf: eliminate Docum. warnings in libbpf_naming_convention
    https://git.kernel.org/bpf/bpf/c/a02215ce72a3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


