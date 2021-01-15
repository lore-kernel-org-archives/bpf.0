Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF8EC433E0
	for <bpf@archiver.kernel.org>; Fri, 15 Jan 2021 03:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478C92389E
	for <bpf@archiver.kernel.org>; Fri, 15 Jan 2021 03:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbhAODut (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Jan 2021 22:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbhAODut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 22:50:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E8A0523A04;
        Fri, 15 Jan 2021 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610682609;
        bh=922mU9FWeciDiV8VPd/claFmg1FFEW9oQgl2lBD/i34=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wwphgvf3OolNn0vqztlmo8xudvcl8VK9OYkIernQXIyQn9l4i1HVGySCeAvx/Ij7u
         6XS+YGuydCRH+bMUaDidewvWapaD7URJT9SPqOOsClnnCGThYaWT04fsFv82lrlF4J
         sYd8gB9+kq5QLyw1HGUGHmEB8F3dAA84WysRyPpzYE2P5yxhuUcJHIk7QdPdpyHhRV
         BJO5TLW2MJyHy1jmtzhIcAmUvxVXomb3NNpT7pNU0GTH3e+JN2dGZByHLLygBgK8D5
         +vdS7bqZfjgHC8HIjaNG/4xpDSOELN6I14K7SZ00b0WvXPf5NsF+6XrGFpF1FX1bPw
         aK/eQIQk0o27w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv7 bpf-next 0/3] perf: Add mmap2 build id support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161068260889.10644.18398465813919990190.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jan 2021 03:50:08 +0000
References: <20210114134044.1418404-1-jolsa@kernel.org>
In-Reply-To: <20210114134044.1418404-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        a.p.zijlstra@chello.nl, mingo@kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        mpetlan@redhat.com, songliubraving@fb.com, irogers@google.com,
        eranian@google.com, abudankov@huawei.com, ak@linux.intel.com,
        adrian.hunter@intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 14 Jan 2021 14:40:41 +0100 you wrote:
> hi,
> adding the support to have buildid stored in mmap2 event,
> so we can bypass the final perf record hunt on build ids.
> 
> This patchset allows perf to record build ID in mmap2 event,
> and adds perf tooling to store/download binaries to .debug
> cache based on these build IDs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Move stack_map_get_build_id into lib
    https://git.kernel.org/bpf/bpf-next/c/bd7525dacd7e
  - [bpf-next,2/3] bpf: Add size arg to build_id_parse function
    https://git.kernel.org/bpf/bpf-next/c/921f88fc8919
  - [bpf-next,3/3] perf: Add build id data in mmap2 event
    https://git.kernel.org/bpf/bpf-next/c/88a16a130933

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


