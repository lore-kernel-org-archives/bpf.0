Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1E2C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F323B20821
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfDPI0p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:26:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:59054 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDPI0p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:26:45 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJQR-00066K-V2; Tue, 16 Apr 2019 10:26:44 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJQR-000Pde-K5; Tue, 16 Apr 2019 10:26:43 +0200
Subject: Re: [PATCH bpf-next 0/2] add btf_dedup() support for VAR and DATASEC
To:     andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Cc:     Andrii Nakryiko <andriin@fb.com>
References: <20190415234808.2225360-1-andrii.nakryiko@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f51fa84f-a7a3-eb84-d682-690d26b32e96@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190415234808.2225360-1-andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/16/2019 01:48 AM, andrii.nakryiko@gmail.com wrote:
> From: Andrii Nakryiko <andriin@fb.com>
> 
> This patchset adds support for new BTF_KIND_VAR and BTF_KIND_DATASEC BTF types
> in btf_dedup() algorithm. VAR and DATASEC are not deduplicated and are always
> considered to be unique, but they require referenced type IDs adjustment.
> 
> Patch #1 adds VAR/DATASEC pass-through support to btf_dedup().
> Patch #2 adds a test validating all the type ID adjustments are correct.
> 
> Andrii Nakryiko (2):
>   btf: add support for VAR and DATASEC in btf_dedup()
>   selftests/btf: add VAR and DATASEC case for dedup tests
> 
>  tools/lib/bpf/btf.c                    | 29 +++++++++++++--
>  tools/testing/selftests/bpf/test_btf.c | 49 ++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 2 deletions(-)
> 

Looks good, applied, thanks!
