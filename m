Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D57C4741F
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F952075F
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601382016;
	bh=T1w5XrXa2H9LIp7yp9/7COaL1m0xbyEKuPiJJf5RpYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=QieNb7nuEPt495M5lo/1GBQqlBIYnBQvpuBY/o4R4TUact0bK+Dv1YAEJp+U0VdTH
	 zZ7kdTit2nsIQFnttbh38uprBTWJ7Zg49iLuJGZAGXM4KuP6aL6aqlNCf3kN2+0X+b
	 g2veQ3xMhfsIHavUK5N/1OgCjAS22B8g22bIFM2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgI2MUJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbgI2MUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 08:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382008;
        bh=T1w5XrXa2H9LIp7yp9/7COaL1m0xbyEKuPiJJf5RpYc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vh7zhpPh7tSvLJTje2Oihassq0ugHsS57Vrfut2z5MNvr+N7SvSkm+W3xA6A2IrkF
         GYqO010rGceL8p/aZG4gGcqqsnj2jq1N4AhhWpCYTthpfdAgaprYJSQ13SYLRYZGMg
         ADaqofguvRwgbtBdRek3ZhKcHdmgPt5qYGFLA+KA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: cpumap: remove rcpu pointer from
 cpu_map_build_skb signature
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160138200860.26741.2323768930219509515.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 12:20:08 +0000
References: <33cb9b7dc447de3ea6fd6ce713ac41bca8794423.1601292015.git.lorenzo@kernel.org>
In-Reply-To: <33cb9b7dc447de3ea6fd6ce713ac41bca8794423.1601292015.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 13:24:57 +0200 you wrote:
> Get rid of bpf_cpu_map_entry pointer in cpu_map_build_skb routine
> signature since it is no longer needed
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  kernel/bpf/cpumap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: cpumap: remove rcpu pointer from cpu_map_build_skb signature
    https://git.kernel.org/bpf/bpf-next/c/efa90b50934c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


