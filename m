Return-Path: <SRS0=uc+s=DH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70EFC4727C
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707AA2084C
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601493005;
	bh=V52RmqVxdhC7tuhd2A8Ex0H/Yd6anh8T+xH3kpeZpXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=NlLQFCIRKhNtm1wzLx5/XBW6oMir8JKWZhufyCvE857qJzDPgA3kB2aaNFLnBnbjn
	 JmW6BwLnEMm2bMdIDju67259Bc+cm9WFexFnIfeXKt+aZiMl9wWC4eSAM1zn9RzGiT
	 rwo6wolTHrnEi5POTxKVRIi2ZN4Hj5XN8j235sTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgI3TKF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbgI3TKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 15:10:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601493003;
        bh=V52RmqVxdhC7tuhd2A8Ex0H/Yd6anh8T+xH3kpeZpXo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ygsSN005U8MHSWtI3nKGHYCyjBmwXoU+nGqjI+sfMVCvPM45Urh6ykO9Qau4xlAtC
         /gDDkMJ3EWarisBrgHzCIs1xSSsV3CiUWx4cn0qz/dOXRdHdSYOqOcsnPGthOZLMkm
         x2ywE73kn8vDTrlDym/waVnFhCHN8Y7eTl0NqIQ8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/6] Various BPF helper improvements
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160149300373.16261.5082951869822951600.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Sep 2020 19:10:03 +0000
References: <cover.1601477936.git.daniel@iogearbox.net>
In-Reply-To: <cover.1601477936.git.daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 30 Sep 2020 17:18:14 +0200 you wrote:
> This series adds two BPF helpers, that is, one for retrieving the classid
> of an skb and another one to redirect via the neigh subsystem, and improves
> also the cookie helpers by removing the atomic counter. I've also added
> the bpf_tail_call_static() helper to the libbpf API that we've been using
> in Cilium for a while now, and last but not least the series adds a few
> selftests. For details, please check individual patches, thanks!
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/6] bpf: add classid helper only based on skb->sk
    https://git.kernel.org/bpf/bpf-next/c/b426ce83baa7
  - [bpf-next,v4,2/6] bpf, net: rework cookie generator as per-cpu one
    https://git.kernel.org/bpf/bpf-next/c/92acdc58ab11
  - [bpf-next,v4,3/6] bpf: add redirect_neigh helper as redirect drop-in
    https://git.kernel.org/bpf/bpf-next/c/b4ab31414970
  - [bpf-next,v4,4/6] bpf, libbpf: add bpf_tail_call_static helper for bpf programs
    https://git.kernel.org/bpf/bpf-next/c/0e9f6841f664
  - [bpf-next,v4,5/6] bpf, selftests: use bpf_tail_call_static where appropriate
    https://git.kernel.org/bpf/bpf-next/c/faef26fa444d
  - [bpf-next,v4,6/6] bpf, selftests: add redirect_neigh selftest
    https://git.kernel.org/bpf/bpf-next/c/eef4a011f35d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


