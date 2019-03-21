Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF5C10F00
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F127A218D3
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfCUWTX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:19:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:40358 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCUWTX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 18:19:23 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h761w-0004ap-JX; Thu, 21 Mar 2019 23:19:20 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h761w-000O56-DO; Thu, 21 Mar 2019 23:19:20 +0100
Subject: Re: [PATCH bpf-next v4] tools/bpf: generate pkg-config file for
 libbpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrey Ignatov <rdna@fb.com>
Cc:     "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
References: <20190319210639.6282-1-bluca@debian.org>
 <20190321102531.31810-1-luca.boccassi@gmail.com>
 <20190321160042.GB13709@rdna-mbp>
 <20190321220107.pcvf6e23kun4gj7r@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <80186d7b-ff21-e81f-1320-5916ecfcc99b@iogearbox.net>
Date:   Thu, 21 Mar 2019 23:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190321220107.pcvf6e23kun4gj7r@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25395/Thu Mar 21 08:52:58 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/21/2019 11:01 PM, Alexei Starovoitov wrote:
> On Thu, Mar 21, 2019 at 04:00:46PM +0000, Andrey Ignatov wrote:
>> luca.boccassi@gmail.com <luca.boccassi@gmail.com> [Thu, 2019-03-21 03:26 -0700]:
>>> From: Luca Boccassi <bluca@debian.org>
>>>
>>> Generate a libbpf.pc file at build time so that users can rely
>>> on pkg-config to find the library, its CFLAGS and LDFLAGS.
>>>
>>> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ...
>>> diff --git a/tools/lib/bpf/libbpf.pc.template b/tools/lib/bpf/libbpf.pc.template
>>> new file mode 100644
>>> index 000000000000..0ecd334c109f
>>> --- /dev/null
>>> +++ b/tools/lib/bpf/libbpf.pc.template
>>> @@ -0,0 +1,11 @@
>>> +prefix=@PREFIX@
>>> +libdir=@LIBDIR@
>>> +includedir=${prefix}/include
>>> +
>>> +Name: libbpf
>>> +URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>> +Description: Linux kernel BPF library
> 
> github/libbpf/libbpf is a true mirror of kernel's libbpf.
> I think if we start shipping libbpf.so from kernel and from github
> it will be very confusing to the users...
> Which one is the true libbpf?
> Also the package should mention the license.
> And the license for libbpf is dual lgpl/bsd.
> But if we point to the url above it will not make much sense.
> I think the packages URL should point to github/libbpf/libbpf
> and packaging scripts should be in github only.
> 
> Daniel,
> what do you think?

Looking at [0], I don't see where license would be part of the keyword. Given
this is just a pkg-config file where folks using it care mainly about the
needed cflags/libs, it would make sense to me to ship it and have it under
tools/lib/bpf/ in kernel tree (since this is distro independent). If the URL
and Description causes confusion, I would probably just remove the URL field
since it's not mandatory either. And description, I'd put something like
'official BPF library' or such, so it's generic enough.

  [0] https://autotools.io/pkgconfig/file-format.html
      https://dev.gentoo.org/~mgorny/pkg-config-spec.html#keywords
