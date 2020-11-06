Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A17C388F7
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 02:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9D22078E
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604629806;
	bh=bMss37PW0DjL+F105uZIF8AohlK/nn3hxT9D8pRtYjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=JMRZp4V1yFWuogFmwSjJbI9Q71tICn7/6hlaHW/tPk9YI+kSNUnDsCADNT4tbpzBS
	 Z1wQIXvViAplT47KGsjxYhAIsyh+FGGLuo7TiYmqcXOKDvKt7iIinLgvdq+B4RcB0y
	 ZMV5QuolJe4S7j2Kg5DPyJotwXwYZ+ZacYDJRpu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgKFCaF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgKFCaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 21:30:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604629804;
        bh=bMss37PW0DjL+F105uZIF8AohlK/nn3hxT9D8pRtYjo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HF9SZSMRYFDXCCfWp4kFzC7kgKN7n4J4865wsEXrebCmd3z4e9I6kpScuGMzL+1le
         vWVu/dmyhSusMEx4uaMIJyS80AZbQN8v4ihUv/gK2gtiwBNNxCmjnrMYleEiw8dQvm
         wdl/0LAcABARrHfF6WVMgaDcrIrWF4GWRV2mc358=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] tools/bpftool: fix attaching flow dissector
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160462980468.24579.17001075213935602324.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Nov 2020 02:30:04 +0000
References: <20201105115230.296657-1-lmb@cloudflare.com>
In-Reply-To: <20201105115230.296657-1-lmb@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kernel-team@cloudflare.com,
        jbenc@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu,  5 Nov 2020 11:52:30 +0000 you wrote:
> My earlier patch to reject non-zero arguments to flow dissector attach
> broke attaching via bpftool. Instead of 0 it uses -1 for target_fd.
> Fix this by passing a zero argument when attaching the flow dissector.
> 
> Fixes: 1b514239e859 ("bpf: flow_dissector: Check value of unused flags to BPF_PROG_ATTACH")
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> 
> [...]

Here is the summary with links:
  - [bpf] tools/bpftool: fix attaching flow dissector
    https://git.kernel.org/bpf/bpf/c/f9b7ff0d7f7a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


