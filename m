Return-Path: <SRS0=svjS=DJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE60C4363D
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 18:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE15208A9
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601664603;
	bh=omv6p2WfPJ1g4z0aJKds7xPt2hDx2R8a4p8nl91AGk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=Z1jygyH3UKbtNc2OZNJ8nanXB4bDfvBPrayRuRqXW1VE7nGKVFT2Grlx3N0aqBzjg
	 xmCqTuxWTKWI+gt1Fq7pVSqQB8NO0vKbJRNCuiwSkgnnlJiy8nZYzj47jgLppXsutD
	 x9EquuvdicnouSnZvfJglRQyrVaY8ot9V91uffAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgJBSuD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 14:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbgJBSuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 14:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601664602;
        bh=omv6p2WfPJ1g4z0aJKds7xPt2hDx2R8a4p8nl91AGk8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LIp4wxwQlAd654B32RSLu7Oxlg0dB/0UKe8Mbmud0ZqOo5wheqB8yoVdy4M3HKLw6
         URMb1L9u/v7CWscuyt6IQg3/snby81IfNaiW43CLlr2Ve7Ov4XxWlPucuHgfuNM7fj
         krvdCny/nOxTWi+9xHT+jDzX3gUYiPimLX3qFs48=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Do not limit cb_flags when creating child sk
 from listen sk
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160166460282.17511.15563010625020001748.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Oct 2020 18:50:02 +0000
References: <20201002013442.2541568-1-kafai@fb.com>
In-Reply-To: <20201002013442.2541568-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 1 Oct 2020 18:34:42 -0700 you wrote:
> This set fixes an issue that the bpf_skops_init_child() unnecessarily
> limited the child sk from inheriting all bpf_sock_ops_cb_flags
> of the listen sk.  It also adds a test to check that.
> 
> Martin KaFai Lau (2):
>   bpf: tcp: Do not limit cb_flags when creating child sk from listen sk
>   bpf: selftest: Ensure the child sk inherited all bpf_sock_ops_cb_flags
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: tcp: Do not limit cb_flags when creating child sk from listen sk
    https://git.kernel.org/bpf/bpf-next/c/82f45c6c4a70
  - [bpf-next,2/2] bpf: selftest: Ensure the child sk inherited all bpf_sock_ops_cb_flags
    https://git.kernel.org/bpf/bpf-next/c/96d46c508506

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


