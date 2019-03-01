Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01427C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EA62085A
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfCAAmi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:42:38 -0500
Received: from www62.your-server.de ([213.133.104.62]:33978 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCAAmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 19:42:38 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzWG2-0003ZZ-C8; Fri, 01 Mar 2019 01:42:34 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzWG2-000Q5R-4S; Fri, 01 Mar 2019 01:42:34 +0100
Subject: Re: [PATCH v2 bpf-next 0/5] btf_dedup algorithm and test fixes
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, ast@fb.com, acme@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, songliubraving@fb.com
References: <20190228233125.1013080-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0128a624-68ec-9378-f34f-c21e566ced93@iogearbox.net>
Date:   Fri, 1 Mar 2019 01:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190228233125.1013080-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 12:31 AM, Andrii Nakryiko wrote:
> This patchset fixes a bug in btf_dedup() algorithm, which under specific hash
> collision causes infinite loop. It also exposes ability to tune BTF
> deduplication table size, with double purpose of allowing applications to
> adjust size according to the size of BTF data, as well as allowing a simple way
> to force hash collisions by setting table size to 1.
> 
> - Patch #1 fixes bug in btf_dedup testing code that's checking strings
> - Patch #2 fixes pointer arg formatting in btf.h
> - Patch #3 adds option to specify custom dedup table size
> - Patch #4 fixes aforementioned bug in btf_dedup
> - Patch #5 adds test that validates the fix
> 
> v1->v2:
> - remove "Fixes" from formatting change patch
> - extract roundup_pow2_max func for dedup table size
> - btf_equal_struct -> btf_shallow_equal_struct
> - explain in comment why we can't rely on just btf_dedup_is_equiv
> 
> Andrii Nakryiko (5):
>   selftests/bpf: fix btf_dedup testing code
>   libbpf: fix formatting for btf_ext__get_raw_data
>   btf: allow to customize dedup hash table size
>   btf: fix bug with resolving STRUCT/UNION into corresponding FWD
>   selftests/bpf: add btf_dedup test of FWD/STRUCT resolution
> 
>  tools/lib/bpf/btf.c                    | 73 +++++++++++++++++++-------
>  tools/lib/bpf/btf.h                    |  3 +-
>  tools/testing/selftests/bpf/.gitignore |  1 +
>  tools/testing/selftests/bpf/test_btf.c | 49 ++++++++++++++++-
>  4 files changed, 103 insertions(+), 23 deletions(-)
> 

Applied, thanks!
