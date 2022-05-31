Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B905C433F5
	for <bpf@archiver.kernel.org>; Tue, 31 May 2022 22:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346382AbiEaWKQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 31 May 2022 18:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiEaWKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 18:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A701712D8;
        Tue, 31 May 2022 15:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22F0161411;
        Tue, 31 May 2022 22:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CB4FC3411C;
        Tue, 31 May 2022 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654035013;
        bh=NHduzSrHSTkUo6SczPZztFAfc6A9Ik98aFoaPiMWvi4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JuM1QIOPY+n2Teh9EVDZ5gXbDQ60zIFEMsSDrEyz6TaQNCGSrTUIL/rEvX1KcsRvm
         VJiek5m3z+SwrCx8PfQQjY3bQAECivfJNXL9FiMgVpd/WQbAgsO1tJ2JAECXEfnSkQ
         HFf3y92EgooLb5CcwfyBOJoXlMAFAbvJUKhba3TIIItwlDCkQgyRQBiKBdrGNDEITq
         cQ2SZz1BPFMuDawrqbEyyxP6+yNgb0MKC2LONz8U8KdGLWHoZtIqHKto6dRtDLVI8C
         lN80k5rWy+e2/BoaaVAbVall9DC3j5zaqcIOX9mJknzoVojWFWgq7UT/HPML7R5lic
         gqFfJYOL/FAuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 647D1F0383D;
        Tue, 31 May 2022 22:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test_run logic in fexit_stress.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165403501340.21268.15920693593241298541.git-patchwork-notify@kernel.org>
Date:   Tue, 31 May 2022 22:10:13 +0000
References: <20220521151329.648013-1-ytcoode@gmail.com>
In-Reply-To: <20220521151329.648013-1-ytcoode@gmail.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 21 May 2022 23:13:29 +0800 you wrote:
> In the commit da00d2f117a0 ("bpf: Add test ops for BPF_PROG_TYPE_TRACING"),
> the bpf_fentry_test1 function was moved into bpf_prog_test_run_tracing(),
> which is the test_run function of the tracing BPF programs.
> 
> Thus calling 'bpf_prog_test_run_opts(filter_fd, &topts)' will not trigger
> bpf_fentry_test1 function as filter_fd is a sk_filter BPF program.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix test_run logic in fexit_stress.c
    https://git.kernel.org/bpf/bpf-next/c/960b8ef9609c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


