Return-Path: <SRS0=EP3I=CJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3680CC433E6
	for <bpf@archiver.kernel.org>; Mon, 31 Aug 2020 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F80D2083E
	for <bpf@archiver.kernel.org>; Mon, 31 Aug 2020 14:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHaO7f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:59:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:50476 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaO7e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Aug 2020 10:59:34 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kClHM-0000b4-OM; Mon, 31 Aug 2020 16:59:28 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kClHM-000Huj-J0; Mon, 31 Aug 2020 16:59:28 +0200
Subject: Re: [PATCH bpf v1] libbpf: fix build failure from uninitialized
 variable warning
To:     Tony Ambardar <tony.ambardar@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20200831000304.1696435-1-Tony.Ambardar@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5e77a6d0-3841-0de6-fd6d-6e6763f575bf@iogearbox.net>
Date:   Mon, 31 Aug 2020 16:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200831000304.1696435-1-Tony.Ambardar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25916/Mon Aug 31 15:26:49 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/20 2:03 AM, Tony Ambardar wrote:
> While compiling libbpf, some GCC versions (at least 8.4.0) have difficulty
> determining control flow and a emit warning for potentially uninitialized
> usage of 'map', which results in a build error if using "-Werror":
> 
> In file included from libbpf.c:56:
> libbpf.c: In function '__bpf_object__open':
> libbpf_internal.h:59:2: warning: 'map' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
>    ^~~~~~~~~~~~
> libbpf.c:5032:18: note: 'map' was declared here
>    struct bpf_map *map, *targ_map;
>                    ^~~
> 
> The warning/error is false based on code inspection, so silence it with a
> NULL initialization.
> 
> Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
> Ref: 063e68813391 ("libbpf: Fix false uninitialized variable warning")
> 
> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>

Applied, thanks!
