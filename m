Return-Path: <SRS0=rSwM=DN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABECC4727D
	for <bpf@archiver.kernel.org>; Tue,  6 Oct 2020 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B9B20897
	for <bpf@archiver.kernel.org>; Tue,  6 Oct 2020 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602010206;
	bh=cmnoiWOoLar8N5rCSOYNQUh0j1ZlahKgTZzrKQ8osjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=ShRpJGU5jqB/8s0PxMOrwmgJmW/457Z6teD4+htIA0AZ+MSAZ7IHLla2HKXpcsjvQ
	 D5dF2GG2V1StGJYV6eoRv0hzEdbMrMCdaMBuqJe7oFex1qI4MnXKYkNaXKj/mvKWem
	 equgTT+WinSPOanufcOreyXZxPJGDIMysgu8KoyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgJFSuF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 6 Oct 2020 14:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgJFSuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 14:50:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602010204;
        bh=cmnoiWOoLar8N5rCSOYNQUh0j1ZlahKgTZzrKQ8osjs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZDp8utaAFCoByp++vD4hpoel+CVcDDh403iLKYymW8nhNov1+pELu7H9yUUMjbgqW
         LEHrO6BvNs3OHE0r1Vl+7MJ7BSlFSScfY3zSiqKAu4exr0WJKp67m4yE1dFBM3o3mA
         CExy5Fp/PghZqZBujhafsocXlYwh87H2KWYgdZrc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/3] samples: bpf: split xdpsock stats into new
 struct
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160201020450.15578.15216583134041941419.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Oct 2020 18:50:04 +0000
References: <20201002133612.31536-1-ciara.loftus@intel.com>
In-Reply-To: <20201002133612.31536-1-ciara.loftus@intel.com>
To:     Ciara Loftus <ciara.loftus@intel.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Fri,  2 Oct 2020 13:36:10 +0000 you wrote:
> New statistics will be added in future commits. In preparation for this,
> let's split out the existing statistics into their own struct.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  samples/bpf/xdpsock_user.c | 123 +++++++++++++++++++++----------------
>  1 file changed, 69 insertions(+), 54 deletions(-)

Here is the summary with links:
  - [bpf-next,1/3] samples: bpf: split xdpsock stats into new struct
    https://git.kernel.org/bpf/bpf-next/c/2e8806f032f5
  - [bpf-next,2/3] samples: bpf: count syscalls in xdpsock
    https://git.kernel.org/bpf/bpf-next/c/60dc609dbd54
  - [bpf-next,3/3] samples: bpf: driver interrupt statistics in xdpsock
    https://git.kernel.org/bpf/bpf-next/c/67ed375530e2

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


