Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2120EC4338F
	for <bpf@archiver.kernel.org>; Sat, 24 Jul 2021 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED31A60EB0
	for <bpf@archiver.kernel.org>; Sat, 24 Jul 2021 00:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhGWXTd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 23 Jul 2021 19:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233059AbhGWXTc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 19:19:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9F21560EAF;
        Sat, 24 Jul 2021 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627084805;
        bh=TyoH2K5Hug8QBn8+54+oDZKzPVKApvLvJyuCcLcvU5s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E1PnKN5kSoanazqlc54+kQiNYN4gqym22vrIeElSjKdbOqDhUeDltEpAoIutYu5Uf
         2f+wxypCGd2eGmxfRcm5Wr4lnA2ckSvvT2v+dEnu0CPGtVUhGSD1cMpqqB3acIObq3
         balS5FTTUKUKN4mV7ynDKAExZAZOdMUBwihSPQ7D4UzeUrV/qiD9mAiVWuDYV9XQgV
         1y9U3Ewnm0+fXx2QbYIhXX71mZqMNruZeYlivfp9yKMbJVvGyY/pBbH5LI5ATi77IL
         eXESZGe7TQAQNSo80z9fHOTQ/Ps3k0hSYPf+og5GQlIvKbd0yLRVYDmo6a/PfDiUPy
         xe/QC8jtY2qSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] libbpf: Add bpf_map__pin_path function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162708480558.28739.10717560105050928241.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jul 2021 00:00:05 +0000
References: <20210723221511.803683-1-evgeniyl@fb.com>
In-Reply-To: <20210723221511.803683-1-evgeniyl@fb.com>
To:     Evgeniy Litvinenko <evgeniyl@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 23 Jul 2021 15:15:11 -0700 you wrote:
> Add bpf_map__pin_path, so that the inconsistently named
> bpf_map__get_pin_path can be deprecated later. This is part of the
> effort towards libbpf v1.0: https://github.com/libbpf/libbpf/issues/307
> 
> Also, add a selftest for the new function.
> 
> Signed-off-by: Evgeniy Litvinenko <evgeniyl@fb.com>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] libbpf: Add bpf_map__pin_path function
    https://git.kernel.org/bpf/bpf-next/c/e244d34d0ea1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


