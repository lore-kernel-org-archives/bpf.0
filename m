Return-Path: <SRS0=66DU=DI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28209C4363D
	for <bpf@archiver.kernel.org>; Thu,  1 Oct 2020 01:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0E6207C3
	for <bpf@archiver.kernel.org>; Thu,  1 Oct 2020 01:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601515803;
	bh=2cCF0cVL4RoiJRlNlR+hCLJrxFFR/ZpyV1C8MDOpFIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=sIpB2x7pHssYXfoSAcK9rDVcYsB/P8Ge4DnTFnJuH0DLFsV0YD/j34bESl7dWksgt
	 5mkcx4ojbZ8PJTh/1maVEZaYeJo9GPX0Fi78QwkdD3JzAnpxCBI/5nStrjZSAbAJqP
	 nB//jQEK9fDme7TCPCaplBKRg8d+Dn3/0HfJktx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgJABaD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Sep 2020 21:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbgJABaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 21:30:02 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601515802;
        bh=2cCF0cVL4RoiJRlNlR+hCLJrxFFR/ZpyV1C8MDOpFIU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NCDl4YjwNROWP/GhWilzcdoH+m4PpVad2Fqx5bETBCZPVlX0a2RCFMu/wnT4oS3H/
         NY8z3/wJqfIV3yiYDbepLvVNpUlpPcZX3PAFq6ziQKTqhhdhlzNZ4keT/msAkQDVjJ
         VR1KQDYDDOROoCIMCojt7pcy5Nf1JwyT1KProVCU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix alignment of .BTF_ids
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160151580256.5707.15212236468735145552.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Oct 2020 01:30:02 +0000
References: <20200930093559.2120126-1-jean-philippe@linaro.org>
In-Reply-To: <20200930093559.2120126-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 30 Sep 2020 11:36:01 +0200 you wrote:
> Fix a build failure on arm64, due to missing alignment information for
> the .BTF_ids section:
> 
> resolve_btfids.test.o: in function `test_resolve_btfids':
> tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:140:(.text+0x29c): relocation truncated to fit: R_AARCH64_LDST32_ABS_LO12_NC against `.BTF_ids'
> ld: tools/testing/selftests/bpf/prog_tests/resolve_btfids.c:140: warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix alignment of .BTF_ids
    https://git.kernel.org/bpf/bpf-next/c/3effc06a4dde

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


