Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68267C433EF
	for <bpf@archiver.kernel.org>; Fri, 11 Feb 2022 05:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiBKFUK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Feb 2022 00:20:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBKFUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 00:20:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C512710C4;
        Thu, 10 Feb 2022 21:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55695618C7;
        Fri, 11 Feb 2022 05:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B25A7C340EB;
        Fri, 11 Feb 2022 05:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644556808;
        bh=9J9MSIgaoQV6CiZBEgLgrguVIr//L88WN81Q+uDZty4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bfyrSUkDK/Tddx8YbBFjfveeoeKE3qobnRtrsY/LHh1M5ne9NGm++LMA9zqxsDgex
         MVYThcvLP7WvdoUsLRrCTq8cs2BKttKMlM/j9E2T5D4DpzOnj3c/CXmhHJlk9mSGi7
         eNjXC3W/z8YKcc8ChckObv5z/3rVgu2yZ/mrRyUk0JBj+0a447LDePcs5Mby8WSy9H
         Y8rj+U8yneJ0Ilrc9yOrJ2IveIjC8kItngHmgnnFGJm7Szd2udVesxPDE2VPRUD4YV
         AVM7tP89/sdlTkmBr1LIWPwGWjTDMcWFIMFk5VCQNuWHv1Q+X/fKPxzA4m4fO/+jf8
         eMgMzhegsJ5Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98654E6D3DE;
        Fri, 11 Feb 2022 05:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpftool: Switch to new versioning scheme
 (align on libbpf's)
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164455680862.7855.13945335074780551017.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 05:20:08 +0000
References: <20220210104237.11649-1-quentin@isovalent.com>
In-Reply-To: <20220210104237.11649-1-quentin@isovalent.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 10 Feb 2022 10:42:35 +0000 you wrote:
> Hi, this set aims at updating the way bpftool versions are numbered.
> Instead of copying the version from the kernel (given that the sources for
> the kernel and bpftool are shipped together), align it on libbpf's version
> number, with a fixed offset (6) to avoid going backwards. Please refer to
> the description of the second commit for details on the motivations.
> 
> The patchset also adds the number of the version of libbpf that was used to
> compile to the output of "bpftool version". Bpftool makes such a heavy
> usage of libbpf that it makes sense to indicate what version was used to
> build it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpftool: Add libbpf's version number to "bpftool version" output
    https://git.kernel.org/bpf/bpf-next/c/61fce9693f03
  - [bpf-next,v3,2/2] bpftool: Update versioning scheme, align on libbpf's version number
    https://git.kernel.org/bpf/bpf-next/c/9910a74d6ebf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


