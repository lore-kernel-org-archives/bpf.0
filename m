Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E5C636CC
	for <bpf@archiver.kernel.org>; Thu,  9 Feb 2023 00:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBIA1M (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBIA1K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 19:27:10 -0500
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 16:27:09 PST
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260A4EC4
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 16:27:09 -0800 (PST)
Received: by endrift.com (Postfix, from userid 1000)
        id 9F3E4A2AE; Wed,  8 Feb 2023 16:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1675902075; bh=b6G0cqmUOe9ZyUtUgB37XF3NbMyAqO6fxMn3uA0uwVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r29Y8ZfyqTohMeSLBPkLVBmymmk2E1cX/xMgXUYKadgKi+Rt/d12naiO8LwNdQ74v
         ixjAQ5c9vHlZD/TQf1hxIqzf+d+xLqGLLQDb4HIEc3eoo1TUMG3PN/qPNbi8oVMGqa
         FK7Y8g/U2btbhCO+xCDxEBzl7lzelGuQWF0/O1yw/xvcQsI1FahodsvYLKAM2SaDol
         zDfEpRaXJgeMk8JwfI7pqmAau000UsysvDDnv7DwktNnAa0/DmAQ7nVK8hnTtycr/C
         5+sfnXvenBjEXhO3ooZstdtWKkd2sCLTAheyhxPCUNV6WJ5+wOJ7iC9FfqF0DECJd+
         ecyZ3x57U7sIA==
Date:   Wed, 8 Feb 2023 16:21:15 -0800
From:   Vicki Pfau <vi@endrift.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexandre Peixoto Ferreira <alexandref75@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Message-ID: <20230209002115.GA15810@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kxUzyfpEQpnN7w@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I seem to be having a related problem trying to build Linux at all. This used
to work, but after some recent upgrades (I am also running Arch Linux), I'm
getting a dedup error too. I'm also getting a "relocation to !ENDBR" error
that, as far as I can tell (and that's not particularly far, to be fair), is
erroneous, which makes me think something even stranger is going on with my
tools. Since both of these issues appeared, so far, only on Arch Linux, it
might be an Arch-speciifc packaging issue.

I've uploaded my config and pahole log to the following URLs:

https://endrift.com/files/config.gz
https://endrift.com/files/make-log.xz

Vicki

PS: My apologies for the lack of a quoted reply or any other formatting issues;
I'm not subscribed to this mailing list and am struggling to figure out how to
send a reply without the originals in my client. In retrospect, maybe I could
have imported the .eml/mbox directly.
