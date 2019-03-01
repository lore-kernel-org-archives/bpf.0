Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F3EC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA6D2083D
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfCAXlf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:41:35 -0500
Received: from www62.your-server.de ([213.133.104.62]:36968 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXlf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 18:41:35 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrmW-0007oB-Fe; Sat, 02 Mar 2019 00:41:32 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrmW-0006Oq-5s; Sat, 02 Mar 2019 00:41:32 +0100
Subject: Re: [PATCH v2 bpf-next 0/3] bpf docs typo, wording and formatting
 fixes
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        ast@fb.com, yhs@fb.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, songliubraving@fb.com
References: <20190301011221.1290474-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f45000d6-f512-c8c4-ee88-800c9ec22dc2@iogearbox.net>
Date:   Sat, 2 Mar 2019 00:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190301011221.1290474-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 02:12 AM, Andrii Nakryiko wrote:
> A bunch of BPF-related docs typo, wording and formatting fixes.
> 
> v1->v2:
> - split off non-documentation changes into separate patchset
> 
> Andrii Nakryiko (3):
>   docs/btf: fix typos, improve wording
>   docs/btf: reflow text to fill up to 78 characters
>   docs/bpf: minor casing/punctuation fixes
> 
>  Documentation/bpf/bpf_design_QA.rst |  24 +--
>  Documentation/bpf/btf.rst           | 316 +++++++++++++---------------
>  Documentation/networking/filter.txt |   2 +-
>  3 files changed, 160 insertions(+), 182 deletions(-)
> 

Applied, thanks!
