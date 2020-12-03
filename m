Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE12C4167B
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 20:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F890221F4
	for <bpf@archiver.kernel.org>; Thu,  3 Dec 2020 20:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLCUUr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgLCUUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 15:20:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607026806;
        bh=Tkyv4YxmIkfl86eenFjdn9rHENw/f56Yi/8XLBvDLTg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lcWLH6aTBD1VDKGAgLs+lutOcUSoAXOxXlB0PXQeE+DtzFwQZkZMmLpkzMQXPPm+z
         4bhTdP3HTw+QgdbCtP60rPtJo9cnKl8an1OgkfZ/IHIEZdJ+qSGT8MIhCedzOJluZI
         kYEMqWX47RqFGiLrzrhXgSPMXmh9rGF47bMJlsUUPenTpimlXR/HTcyU24OIVrDZtA
         rPGemBqqGyOoR5Jd4mATGYqZT/k+nxC+vMkzdi0m73FMB9wIzHRTwAXKUhmLkaS3rT
         xXe8CeBTQMoCm0kQeuDEkayeVl40zSmmI4lhyFt8AEFIw8jGt8lg9IP/wlGPLvnS8g
         E434uqEqpnI6w==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] samples/bpf: Fix spelling mistake "recieving" ->
 "receiving"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160702680632.7769.6625196471588556263.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Dec 2020 20:20:06 +0000
References: <20201203114452.1060017-1-colin.king@canonical.com>
In-Reply-To: <20201203114452.1060017-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     mariuszx.dudek@intel.com, andrii@kernel.org,
        magnus.karlsson@intel.com, bjorn.topel@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  3 Dec 2020 11:44:52 +0000 you wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  samples/bpf/xdpsock_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] samples/bpf: Fix spelling mistake "recieving" -> "receiving"
    https://git.kernel.org/bpf/bpf-next/c/2faa7328f53b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


