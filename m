Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC410C433ED
	for <bpf@archiver.kernel.org>; Thu, 20 May 2021 22:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1698613AA
	for <bpf@archiver.kernel.org>; Thu, 20 May 2021 22:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhETWBf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 May 2021 18:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhETWBc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 May 2021 18:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3E51D61363;
        Thu, 20 May 2021 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621548010;
        bh=1ZT1b1dwh3sf9/WxTBbxqQrvapQ78cGlD6lGcVdGkC4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ja4ct75d2kzmlioRuRzYHXA1seXEze4zfaoNotwrW4v5xrCiJFYpCU72JDRtUe8k/
         niS6d+Z1WZerih8/i2ojwceuj1m1LKEcGQSRmoxtkVu6t2wSeq24vBspT+upoHAeuJ
         jouPnMvANNmFAd2hXR2A0VQkwykKTaNd2SMFigqxmeKL6vq9AxPPfJHz+WGEDFix0y
         QOQCQl9NT/+MHLlh9YfF5CjN3fVPji45yxuUp9VtTp6jU5drSlLJbbIdbkSkEQMCjQ
         tURSJhzYckxuLydHOj67St+O3CWxPoh9UMzLbzAlBygafOoKqlCluYu9wKeWB/HvPl
         4ALJ3GH+xJ8kg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: offload: reorder offload callback 'prepare' in
 verifier
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162154801018.4340.14011139314609775933.git-patchwork-notify@kernel.org>
Date:   Thu, 20 May 2021 22:00:10 +0000
References: <20210520085834.15023-1-simon.horman@netronome.com>
In-Reply-To: <20210520085834.15023-1-simon.horman@netronome.com>
To:     Simon Horman <simon.horman@netronome.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, yinjun.zhang@corigine.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu, 20 May 2021 10:58:34 +0200 you wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> Commit 4976b718c355 ("bpf: Introduce pseudo_btf_id") switched the
> order of resolve_pseudo_ldimm(), in which some pseudo instructions
> are rewritten. Thus those rewritten instructions cannot be passed
> to driver via 'prepare' offload callback.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: offload: reorder offload callback 'prepare' in verifier
    https://git.kernel.org/bpf/bpf/c/ceb11679d9fc

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


