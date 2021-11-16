Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8694C433F5
	for <bpf@archiver.kernel.org>; Tue, 16 Nov 2021 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA50961B29
	for <bpf@archiver.kernel.org>; Tue, 16 Nov 2021 09:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhKPJnX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233463AbhKPJnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 04:43:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3871D61A38;
        Tue, 16 Nov 2021 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637055609;
        bh=leUWuk0cuFUsY7rozKsa5X5K10xcwN9GFPb4Li8QTPE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OAUWXqdgjvuWVwbl2WZ6moPjxj2kLvczakDsqAMh7Q6AJ0LlNtO2Q+83PYoMoMFWu
         j+LD7RzHrdN5LTqPsR+v9IHc0t7WuKldB2+RWkpCt3iFCwZ+encLfXN5kIaTedg8nx
         ub3870ZXWXveeHGneGbr5U7wcO9jDrrhf7X2SP42wu8qbvNVC3QfGf716Q5eqLaK2j
         s1UuOhBJ6bq3KI50I7YhqbPixtYDC6aj7BKKs5NfmOp0PwpX1kpWVqlGwUmrAjtJw6
         KM0ZWNVF2iELVIJIR/DpIxg3fJzErIHtKuaUvl6+2wuVcXJtzPnWx3xsw/efFRoTsl
         XBTtLzi7Le5GA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpftool: add current libbpf_strict mode to
 version output
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163705560918.11400.8517609295182972615.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Nov 2021 09:40:09 +0000
References: <20211116000448.2918854-1-sdf@google.com>
In-Reply-To: <20211116000448.2918854-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, quentin@isovalent.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Nov 2021 16:04:48 -0800 you wrote:
> + bpftool --legacy --version
> bpftool v5.15.0
> features: libbfd, skeletons
> + bpftool --version
> bpftool v5.15.0
> features: libbfd, libbpf_strict, skeletons
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpftool: add current libbpf_strict mode to version output
    https://git.kernel.org/bpf/bpf-next/c/e47d0bf800e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


