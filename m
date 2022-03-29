Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF5C433EF
	for <bpf@archiver.kernel.org>; Tue, 29 Mar 2022 03:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiC2DBz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Mar 2022 23:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiC2DBy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 23:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF31FE55C;
        Mon, 28 Mar 2022 20:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6143061333;
        Tue, 29 Mar 2022 03:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B51EAC340F0;
        Tue, 29 Mar 2022 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648522811;
        bh=zHmkWPGVO0bBmKps2Dxfn6lk57pbVKvhQxJuoTSyRic=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f3k6C7QquWAvXgph024WcM7Ih52lZn56qyJrsnAQoFOO1kBfQk7trzhwrDSMBqWXf
         QL4tYWIqa7A1LHy4wr9o7nKxn8FMDw/H1OzQm4l01oaFrdUjV9XgcWmQK4oe+sftdv
         HQmn3aZHzUHp6jK10MIwgFXcKWxLfzH15TZhMDT90VRMZQK17b9w66TRLLw+vQDPjX
         MjM1wbKIC46jSh2wHj+0C4ixxOAZfkRdJ5lhX7EFvmrHNwAodwRSkQDP4d8GTQjU+N
         Xef+O1WMViZAxlujjudDXUqI3MTA53v+HlOS63D41MVPXdC2aiciAA0WSJ3W35FL5e
         54R3kezz056qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 925B0E7BB0B;
        Tue, 29 Mar 2022 03:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/4] xsk: another round of fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164852281159.22723.13670887365804546647.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Mar 2022 03:00:11 +0000
References: <20220328142123.170157-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20220328142123.170157-1-maciej.fijalkowski@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, magnus.karlsson@intel.com,
        alexandr.lobakin@intel.com, bjorn@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 28 Mar 2022 16:21:19 +0200 you wrote:
> Hello,
> 
> yet another fixes for XSK from Magnus and me.
> 
> Magnus addresses the fact that xp_alloc() can return NULL, so this needs
> to be handled to avoid clearing entries in the SW ring on driver side.
> Then he addresses the off-by-one problem in Tx desc cleaning routine for
> ice ZC driver.
> 
> [...]

Here is the summary with links:
  - [bpf,1/4] xsk: do not write NULL in SW ring at allocation failure
    https://git.kernel.org/bpf/bpf/c/a95a4d9b39b0
  - [bpf,2/4] ice: xsk: eliminate unnecessary loop iteration
    https://git.kernel.org/bpf/bpf/c/30d19d57d513
  - [bpf,3/4] ice: xsk: stop Rx processing when ntc catches ntu
    https://git.kernel.org/bpf/bpf/c/0ec1713009c5
  - [bpf,4/4] ice: xsk: fix indexing in ice_tx_xsk_pool()
    https://git.kernel.org/bpf/bpf/c/1ac2524de7b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


