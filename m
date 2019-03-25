Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F70C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BCC20823
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 12:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfCYMxG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:53:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:56780 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbfCYMxG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 08:53:06 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8P63-0000Ll-Vs; Mon, 25 Mar 2019 13:53:00 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8P63-0001t5-NZ; Mon, 25 Mar 2019 13:52:59 +0100
Subject: Re: libbpf packaging
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrey Ignatov <rdna@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        bblanco@gmail.com
References: <20190325122134.GA14042@krava>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
Date:   Mon, 25 Mar 2019 13:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190325122134.GA14042@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/25/2019 01:21 PM, Jiri Olsa wrote:
> hi guys,
> we want to package libbpf and I'd like to coordinate
> with you on some issues I've met on this:
> 
> 1) I think libbpf should be part of kernel-tools-libs and kernel-tools-libs-devel,
>    which would look like below (from early rpm build):
> 
>    $ rpm -qpl kernel-tools-libs-5.0.0-1.fc31.x86_64.rpm
>    /usr/lib/.build-id
>    /usr/lib/.build-id/ca
>    /usr/lib/.build-id/ca/654da1e5ea553f985e28b8d98ad24e51f19e88
>    /usr/lib/.build-id/f6
>    /usr/lib/.build-id/f6/a788b316f26fbe70db47bfc0ef500348117023
>    /usr/lib64/libbpf.so.0
>    /usr/lib64/libbpf.so.0.0.1
>    /usr/lib64/libcpupower.so.0
>    /usr/lib64/libcpupower.so.0.0.1
>    /usr/share/licenses/kernel-tools-libs
>    /usr/share/licenses/kernel-tools-libs/COPYING
> 
>    $ rpm -qpl kernel-tools-libs-devel-5.0.0-1.fc31.x86_64.rpm
>    /usr/include/bpf/bpf.h
>    /usr/include/bpf/btf.h
>    /usr/include/bpf/libbpf.h
>    /usr/include/cpufreq.h
>    /usr/include/cpuidle.h
>    /usr/lib64/libbpf.a
>    /usr/lib64/libbpf.so
>    /usr/lib64/libcpupower.so
> 
>    Do you see libbpf as a standalone package or kernel-tools-libs* wuold be ok for you?

My preference is definitely on making libbpf a stand-alone package, so
people can just install 'libbpf' or 'libbpf-dev{,el}' and are good to
go. Also given the pace it's growing these days, it absolutely qualifies
as a stand-alone package.

> 2) There's already bcc-devel's libbpf library packaged:
> 
>    $ rpm -qf /usr/lib64/libbpf.so
>    bcc-devel-0.8.0-1.fc28.x86_64
> 
>    so there's a conflict.. any chance we could rename libbpf to
>    something else like:
> 
>    libbpf2.so
>    libbpfobject.so
>    libbpfbest.so
>    ...?

I don't think we should rename the official libbpf package, this will
just create plain confusion and will make it much harder for potential
users to adapt in the long-term since we aim for /everyone/ to consume
official libbpf library instead of hacking their own.

I think bcc folks are migrating to official libbpf as well, at least
that was my impression. Imho, this would need fixing on bcc side then.

>    I checked and I think those 2 conflicting libraries don't make
>    a valid case for using 'alternatives'.
>   
>    Also the libbpf.so from bcc-devel has been there for some time
>    so we can't just remove/rename it.. ;-)
> thoughts?
> 
> 
> thanks,
> jirka
> 

