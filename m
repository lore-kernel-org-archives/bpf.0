Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A6C54EE9
	for <bpf@archiver.kernel.org>; Fri,  2 Sep 2022 14:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiIBO6W (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiIBO5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 10:57:47 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CF83A2
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 07:22:48 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU79l-000EVN-FU; Fri, 02 Sep 2022 15:56:25 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU79l-000KI8-7l; Fri, 02 Sep 2022 15:56:25 +0200
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Store BPF object files with
 .bpf.o extension
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kafai@fb.com, kernel-team@fb.com
References: <20220901222253.1199242-1-deso@posteo.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dcb08ba7-0d5c-ddd7-35f0-2832952dc895@iogearbox.net>
Date:   Fri, 2 Sep 2022 15:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220901222253.1199242-1-deso@posteo.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26646/Fri Sep  2 09:55:25 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/2/22 12:22 AM, Daniel Müller wrote:
> BPF object files are, in a way, the final artifact produced as part of
> the ahead-of-time compilation process. That makes them somewhat special
> compared to "regular" object files, which are a intermediate build
> artifacts that can typically be removed safely. As such, it can make
> sense to name them differently to make it easier to spot this difference
> at a glance.
> Among others, libbpf-bootstrap [0] has established the extension .bpf.o
> for BPF object files. It seems reasonable to follow this example and
> establish the same denomination for selftest build artifacts. To that
> end, this change adjusts the corresponding part of the build system and
> the test programs loading BPF object files to work with .bpf.o files.
> 
> [0] https://github.com/libbpf/libbpf-bootstrap
> 
> Changelog:
> v2 -> v3:
> - adjusted msg call to use proper extension substitution
> - adjusted examples in README.rst to use new extension
> v1 -> v2:
> - fixed up subject; it's only a single patch
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>

Applied and fixed up the checkpatch warnings along the way (modulo exceeds
80 columns and %s... ones):

https://patchwork.hopto.org/static/nipa/673411/12963406/checkpatch/summary

Thanks,
Daniel
