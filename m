Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8514AC2D0E4
	for <bpf@archiver.kernel.org>; Tue, 24 Nov 2020 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A352083E
	for <bpf@archiver.kernel.org>; Tue, 24 Nov 2020 22:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgVne3uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgKXWKG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgKXWKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 17:10:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606255805;
        bh=AgDEfULAY6T3o4Gah+IhqNkauuIiyV0q6bhCqw5kdL4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UgVne3uwHYJzAuA2dgJ5wvv1hJklxAjNG23HeVbqFfbV5ySouoyhsl6fFN/1HyduW
         4KReKxT4t4E+zPgKdijVpgAkgE7xxMhNhwJpgWjGViqXJPSsEfMGdk9ECLI0+6/Da+
         3GiYP3TKKFfVvQ+RxkrOwlUAi6yfHyvJk39MKdhg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] selftest/bpf: fix link in readme
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160625580579.16430.4916381760822076885.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Nov 2020 22:10:05 +0000
References: <20201122022205.57229-1-andreimatei1@gmail.com>
In-Reply-To: <20201122022205.57229-1-andreimatei1@gmail.com>
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Sat, 21 Nov 2020 21:22:04 -0500 you wrote:
> The link was bad because of invalid rst; it was pointing to itself and
> was rendering badly.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  tools/testing/selftests/bpf/README.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,1/2] selftest/bpf: fix link in readme
    https://git.kernel.org/bpf/bpf-next/c/05a98d767273
  - [bpf-next,2/2] selftest/bpf: fix rst formatting in readme
    https://git.kernel.org/bpf/bpf-next/c/1c26ac6ab3ce

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


