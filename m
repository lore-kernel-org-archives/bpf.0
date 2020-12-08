Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7111C4361B
	for <bpf@archiver.kernel.org>; Tue,  8 Dec 2020 16:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A043B239E5
	for <bpf@archiver.kernel.org>; Tue,  8 Dec 2020 16:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgLHQUr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Dec 2020 11:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbgLHQUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 11:20:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607444406;
        bh=FXMSbKlCr8Gr/JmDVh/PLJR+rc/iVDlBwFB938umaic=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MJ3N5Tbf5n6liM6ZAU4WMlcnhKYaVxhKfw+auP/Qf+B8yWJR8jz33vDbqlu6yPeKP
         gj/4crk+cArzoxqM8qtyLdNxXuiaieBscCpBLOILUvkJ+erJNs9bT5VB0OlZx/TuLc
         ghPPbSBYAL13T/3+keqJSItUz5TK/S0PCnQcZ/voa36VD1z/bQyefIbYXIVBFe1355
         dag7TBNKKjcJIwOdypWjw7Vc7DC6KPxwTDtl+lc6N9OiXInSsizIRWD03LQlTk1zF1
         87SLScdtMi8Qgk33eBu2C7j2qpNWng/5pViYMYQeCoBAm80VRJjn5+4v/As2t6wRhF
         T+irZl4Uu153Q==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: Validate socket state in xsk_recvmsg,
 prior touching socket members
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160744440641.9463.3968311616669664098.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Dec 2020 16:20:06 +0000
References: <20201207082008.132263-1-bjorn.topel@gmail.com>
In-Reply-To: <20201207082008.132263-1-bjorn.topel@gmail.com>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAZ21haWwuY29tPg==?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        oliver.sang@intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon,  7 Dec 2020 09:20:08 +0100 you wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> In AF_XDP the socket state needs to be checked, prior touching the
> members of the socket. This was not the case for the recvmsg
> implementation. Fix that by moving the xsk_is_bound() call.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: 45a86681844e ("xsk: Add support for recvmsg()")
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: Validate socket state in xsk_recvmsg, prior touching socket members
    https://git.kernel.org/bpf/bpf-next/c/3546b9b8eced

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


