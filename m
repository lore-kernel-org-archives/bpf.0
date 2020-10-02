Return-Path: <SRS0=svjS=DJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA557C35257
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ADF20738
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601677804;
	bh=NhXDSu17HUgau68592gDgn3Pg4c6kyKbwvZiBeJTZLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=p7rOcMoyQUfSyrBDAUGWiOur+ggQ0V/m8ie/3bz3wzl346/Lo61phyqs7M/7yIvEw
	 DNarhVxq0DVpwTGW/Enli2LaU7bN5K7aRG2X279yHZDydMxpDb0wffp/ZPkyiWvDe+
	 iJBAyfYeQcf6++XbQDPXME8UY7dlDP+lHkqiFbrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBWaE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 18:30:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601677803;
        bh=NhXDSu17HUgau68592gDgn3Pg4c6kyKbwvZiBeJTZLc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JKDJDcj3B0IBZK+hc1QvA/YdMDE8mU/JfrZbBzxm0nVxq9VXFf689kbffPhVVmdYa
         5AQrih7EwDRCgvd61BhiC6PG62IqRKHA2HRpSRLtpoFnFuBBzZM/PPClF1Mh/xO8ub
         +BRiELDNcX2sOgdGsQnzyIChI3+iFrFaBIBXnV/E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next PATCH v2 0/2] Add skb_adjust_room() for SK_SKB
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160167780367.26044.61096032487233912.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Oct 2020 22:30:03 +0000
References: <160160094764.7052.2711632803258461907.stgit@john-Precision-5820-Tower>
In-Reply-To: <160160094764.7052.2711632803258461907.stgit@john-Precision-5820-Tower>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 01 Oct 2020 18:09:34 -0700 you wrote:
> This implements the helper skb_adjust_room() for BPF_SKS_SK_STREAM_VERDICT
> programs so we can push/pop headers from the data on recieve. One use
> case is to pop TLS headers off kTLS packets.
> 
> The first patch implements the helper and the second updates test_sockmap
> to use it removing some case handling we had to do earlier to account for
> the TLS headers in the kTLS tests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf, sockmap: add skb_adjust_room to pop bytes off ingress payload
    https://git.kernel.org/bpf/bpf-next/c/18ebe16d1049
  - [bpf-next,v2,2/2] bpf, sockmap: update selftests to use skb_adjust_room
    https://git.kernel.org/bpf/bpf-next/c/91274ca53518

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


