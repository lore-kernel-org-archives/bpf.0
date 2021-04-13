Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B3C433B4
	for <bpf@archiver.kernel.org>; Tue, 13 Apr 2021 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9411A613A9
	for <bpf@archiver.kernel.org>; Tue, 13 Apr 2021 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhDMVk3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhDMVk3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 17:40:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 61CDA600CD;
        Tue, 13 Apr 2021 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618350009;
        bh=dLxddwqzVRPFSDsajTZQev0FDo0nLDnLMpjZ44+SDB0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J0he4ufuWsBsJjdXXxZ3ZIETVLYU6bqljlNTIMKq37ytMGiN4oUpnvrakp0RFHHVJ
         nvS03Nxw0OdEBQ/xjY2HpBcluy+6t44gJjVxsQ+IlEf9W3fuMjNAJsEcTQxqM4Pkn2
         m2s3Ublr/Ooahc4sN2RSDRq71seOTZy+NDsyLPuMzphXel0YtpHmfNFQBzeayYWqd1
         4NRltZhMKn7trSASCfZ0qbKMbsdYiDnnPpCIpqyvnS/+JW5Fdseuz3/VPwnCuky7Ku
         ZHxpH5QIhP43fW0YRxT0gYeLyPxGSP3vZxQa+T7E++yORfkoqI/oB5CbjEs2DLoEPN
         ws0o75pbfb4Bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Generate BTF_KIND_FLOAT when linking vmlinux
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161835000933.18297.13476318230441945616.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Apr 2021 21:40:09 +0000
References: <20210413190043.21918-1-iii@linux.ibm.com>
In-Reply-To: <20210413190043.21918-1-iii@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        acme@redhat.com, bpf@vger.kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 13 Apr 2021 21:00:43 +0200 you wrote:
> pahole v1.21 supports the --btf_gen_floats flag, which makes it
> generate the information about the floating-point types [1].
> 
> Adjust link-vmlinux.sh to pass this flag to pahole in case it's
> supported, which is determined using a simple version check.
> 
> [1] https://lore.kernel.org/dwarves/YHRiXNX1JUF2Az0A@kernel.org/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Generate BTF_KIND_FLOAT when linking vmlinux
    https://git.kernel.org/bpf/bpf-next/c/db16c1fe92d7

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


