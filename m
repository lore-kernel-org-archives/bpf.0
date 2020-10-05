Return-Path: <SRS0=IKg2=DM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4BC4363A
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 22:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6165A207BC
	for <bpf@archiver.kernel.org>; Mon,  5 Oct 2020 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601937989;
	bh=5f4TuVuEVfs/YeAP7NVbMT+uWcaBbdsq5ViAMdSYBYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=D3LXhqwwg/S9igoc3/zNteBEei1OFDbRrVOA8Lhl682K00PIxVUVBX5LMVXVhshr3
	 /u9+wsDfaX96eiqCuCme1IEIoLOeGQRjF/M2E2d6KFNddgf/+CY0oErQrC2My3fHEl
	 Y+kyhdIisBZkSNWBEOYbhUcJ9JUpX9cDdJyUkTbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJEWq2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 5 Oct 2020 18:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgJEWq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 18:46:28 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601937988;
        bh=5f4TuVuEVfs/YeAP7NVbMT+uWcaBbdsq5ViAMdSYBYU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xivo8p29JKokT88mCMFwcHRcngb1r5YdoCkiU2zb9EDOohblItBB+QaWfosNefXKW
         MDto8lgIRgzm0JBHzEnZXEpGgvwzzxs3hZY2nhNue+GBhltcoBoZt3g2+4FO+biyWC
         mzwzx2Wia1NteQ8H90c2/HikJa4fBATubZL8n1os=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, doc: Update Andrii's email in MAINTAINERS
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160193798826.16948.9063174466220297295.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Oct 2020 22:46:28 +0000
References: <20201005223648.2437130-1-andrii@kernel.org>
In-Reply-To: <20201005223648.2437130-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 5 Oct 2020 15:36:48 -0700 you wrote:
> Update Andrii Nakryiko's reviewer email to kernel.org account. This optimizes
> email logistics on my side and makes it less likely for me to miss important
> patches.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf, doc: Update Andrii's email in MAINTAINERS
    https://git.kernel.org/bpf/bpf-next/c/dca4121cdc48

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


