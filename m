Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA8C4741F
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259922145D
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601404204;
	bh=zH9MrFY2h7oPmhsbKlTafGpw28e1E3Fet4pfAw4q8b8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=A8FXJwtylVxyZ58RgKgvR9oiams4S/04B8PJgYAQYW6xh9cEWRfzkCSY8W8bbnKmL
	 PFIg3HifW/Ea3+aBQVP1tjHZ1pVFHmci0kqwf0GVqVdQUMXaXFh9jRyPfVlVJpYsZW
	 i4NlxQ2M0AgI+bC4kM+o9wdE1rKBsWM2Rw3ltXDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgI2SaD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 14:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2SaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 14:30:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601404202;
        bh=zH9MrFY2h7oPmhsbKlTafGpw28e1E3Fet4pfAw4q8b8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XQuy60XHuZ8zDtv2TDKYE6mIfFv9LjBAvxFSWHCN0aa3bjix925lJ2tQiqqiO0pwI
         lf82zRFeCJVkJ51ciXvwNofvbAEzFa9GqOSFnfCr8yUZ50fncxp8ov3gd4KonUeo0D
         UmlRK9BNkBWRz5+Ff6ElnaYqbf3IdBJuXdAquX3E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: fix a documentation mistake in xsk_queue.h
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160140420260.22687.15249708539681867546.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 18:30:02 +0000
References: <20200928082344.17110-1-ciara.loftus@intel.com>
In-Reply-To: <20200928082344.17110-1-ciara.loftus@intel.com>
To:     Ciara Loftus <ciara.loftus@intel.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 08:23:44 +0000 you wrote:
> After 'peeking' the ring, the consumer, not the producer, reads the data.
> Fix this mistake in the comments.
> 
> Fixes: 15d8c9162ced ("xsk: Add function naming comments and reorder functions")
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  net/xdp/xsk_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - xsk: fix a documentation mistake in xsk_queue.h
    https://git.kernel.org/bpf/bpf-next/c/f1fc8ece6c07

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


