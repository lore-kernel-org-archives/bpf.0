Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A03DC64E90
	for <bpf@archiver.kernel.org>; Mon, 23 Nov 2020 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD35D206E3
	for <bpf@archiver.kernel.org>; Mon, 23 Nov 2020 13:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfwcsFqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbgKWMaH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbgKWMaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 07:30:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606134605;
        bh=bJjRrUswrcJWQTxkFUU2VnvCNU3Lgeq2TjPcplo/lMI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JfwcsFqCCbV1tExLV7kJkqB8ORsZJ+3ogqGAoBD7qeTjSCDv2O6bbG5UcItb7vba+
         0gB7x7HJWFnFCqrlYcs+Ar+ZgUheee2mxkXRWPNEILhSoEI6HFidesxfd4YJPeDKNm
         4wHLnoTzeB65SfxsMPSXr5QDz9jPExF8cxVOEaQ8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: fix incorrect netdev reference count
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160613460571.1977.12060126612586560661.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Nov 2020 12:30:05 +0000
References: <20201120151443.105903-1-marekx.majtyka@intel.com>
In-Reply-To: <20201120151443.105903-1-marekx.majtyka@intel.com>
To:     Marek Majtyka <alardam@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, marekx.majtyka@intel.com,
        bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Fri, 20 Nov 2020 16:14:43 +0100 you wrote:
> From: Marek Majtyka <marekx.majtyka@intel.com>
> 
> Fix incorrect netdev reference count in xsk_bind operation. Incorrect
> reference count of the device appears when a user calls bind with the
> XDP_ZEROCOPY flag on an interface which does not support zero-copy.
> In such a case, an error is returned but the reference count is not
> decreased. This change fixes the fault, by decreasing the reference count
> in case of such an error.
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: fix incorrect netdev reference count
    https://git.kernel.org/bpf/bpf/c/178648916e73

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


