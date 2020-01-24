Return-Path: <SRS0=TRWS=3N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82A1C2D0DB
	for <bpf@archiver.kernel.org>; Fri, 24 Jan 2020 21:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CCF2071A
	for <bpf@archiver.kernel.org>; Fri, 24 Jan 2020 21:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAXVfr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:35:47 -0500
Received: from www62.your-server.de ([213.133.104.62]:48630 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXVfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 16:35:47 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iv6cD-0008FV-G0; Fri, 24 Jan 2020 22:35:45 +0100
Received: from [178.197.248.48] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iv6cD-000GQr-7B; Fri, 24 Jan 2020 22:35:45 +0100
Subject: Re: [PATCH bpf-next] libbpf: fix realloc usage in bpf_core_find_cands
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, williampsmith@fb.com
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200124201847.212528-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <29074cbf-791c-8d3c-1b94-cd77e9a02c3f@iogearbox.net>
Date:   Fri, 24 Jan 2020 22:35:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200124201847.212528-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25705/Fri Jan 24 12:39:10 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/20 9:18 PM, Andrii Nakryiko wrote:
> Fix bug requesting invalid size of reallocated array when constructing CO-RE
> relocation candidate list. This can cause problems if there are many potential
> candidates and a very fine-grained memory allocator bucket sizes are used.
> 
> Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
> Reported-by: William Smith <williampsmith@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
