Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC11C433FE
	for <bpf@archiver.kernel.org>; Tue, 15 Feb 2022 18:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiBOSKW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Feb 2022 13:10:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242902AbiBOSKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 13:10:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC86119432
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 10:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C29A616B0
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 18:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E000BC340F2;
        Tue, 15 Feb 2022 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644948609;
        bh=xmGAyeJlfSgJhRnmrB+XoZMUWHC0qUx6RX/pIP6DuoI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=irmm7O/K71t0eDOcDPWj9qPDvTXVsypRO06beazgDi8Tb6QDxyqscfuPmEDhtBPa8
         oxx3rI07kfUbf7HUDxqeEceUOoTMpGvca0TTU9t/5ucF94kUAVwq47NkO+2gPOkntj
         zLhNERVTdLSo9Tf1CtMRLeeruDpKritjg85pGey1jIx1FSP1bmYEPK7gNeqnr4otXw
         Vde1JeN18QOoF/Hm5yPrNTfNdGDV8qCToCg5mANoVRfddTYKKVcmessVitRbvh17Kd
         LTdOTcQ8Hfxjr+JUvAP433NrIFRtFHVGzCkZ4K5SnZt4oEI4n7EsCwx5EfA6+bsAIu
         P85rVqt/CjpEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9747E74CC2;
        Tue, 15 Feb 2022 18:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] Make BPF skeleton easier to use from C++ code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164494860982.24331.7075751123876238227.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Feb 2022 18:10:09 +0000
References: <20220212055733.539056-1-andrii@kernel.org>
In-Reply-To: <20220212055733.539056-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Feb 2022 21:57:31 -0800 you wrote:
> Add minimal C++-specific additions to BPF skeleton codegen to facilitate
> easier use of C skeletons in C++ applications. These additions don't add any
> extra ongoing maintenance and allows C++ users to fit pure C skeleton better
> into their C++ code base. All that without the need to design, implement and
> support a separate C++ BPF skeleton implementation.
> 
> v1->v2:
>   - use default argument values in T::open() (Alexei).
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpftool: add C++-specific open/load/etc skeleton wrappers
    https://git.kernel.org/bpf/bpf-next/c/bb8ffe61ea45
  - [v2,bpf-next,2/2] selftests/bpf: add Skeleton templated wrapper as an example
    https://git.kernel.org/bpf/bpf-next/c/189e0ecabc17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


