Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F1C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 09:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B2820830
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 09:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfDCJVK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:21:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:51212 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDCJVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 05:21:10 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBc4x-0003l7-Kr; Wed, 03 Apr 2019 11:21:07 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBc4x-000DwU-Cz; Wed, 03 Apr 2019 11:21:07 +0200
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
References: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
 <20190403084619.GA23855@krava>
 <611b4f67-801e-1bab-7a43-a16d341187ba@iogearbox.net>
 <20190403091258.GA24875@krava>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f6c63645-48b9-6cb8-2310-d3cf65b5e480@iogearbox.net>
Date:   Wed, 3 Apr 2019 11:21:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190403091258.GA24875@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/03/2019 11:12 AM, Jiri Olsa wrote:
> On Wed, Apr 03, 2019 at 11:04:28AM +0200, Daniel Borkmann wrote:
>> On 04/03/2019 10:46 AM, Jiri Olsa wrote:
>>> On Tue, Apr 02, 2019 at 09:49:50AM -0700, andrii.nakryiko@gmail.com wrote:
>>>> From: Andrii Nakryiko <andriin@fb.com>
>>>>
>>>> This patch adds new config option to trigger generation of BTF type
>>>> information from DWARF debuginfo for vmlinux and kernel modules through
>>>> pahole, which in turn relies on libbpf for btf_dedup() algorithm.
>>>>
>>>> The intent is to record compact type information of all types used
>>>> inside kernel, including all the structs/unions/typedefs/etc. This
>>>> enables BPF's compile-once-run-everywhere ([0]) approach, in which
>>>> tracing programs that are inspecting kernel's internal data (e.g.,
>>>> struct task_struct) can be compiled on a system running some kernel
>>>> version, but would be possible to run on other kernel versions (and
>>>> configurations) without recompilation, even if the layout of structs
>>>> changed and/or some of the fields were added, removed, or renamed.
>>>>
>>>> This is only possible if BPF loader can get kernel type info to adjust
>>>> all the offsets correctly. This patch is a first time in this direction,
>>>> making sure that BTF type info is part of Linux kernel image in
>>>> non-loadable ELF section.
>>>>
>>>> BTF deduplication ([1]) algorithm typically provides 100x savings
>>>> compared to DWARF data, so resulting .BTF section is not big as is
>>>> typically about 2MB in size.
>>>
>>> hi,
>>> I'm using the latest pahole from git tree:
>>>   https://github.com/acmel/dwarves.git
>>>
>>> and getting pahole crash:
>>>
>>>   LD      vmlinux
>>>   BTF     vmlinux
>>> die__process_inline_expansion: DW_TAG_label (0xa) @ <0x3eef8> not handled!
>>> scripts/link-vmlinux.sh: line 96: 31222 Segmentation fault      (core dumped) LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>>> make[1]: *** [/home/jolsa/linux/Makefile:1025: vmlinux] Error 139
>>> make: *** [Makefile:170: sub-make] Error 2
>>>
>>> is there some other source/dependency I'm missing?
>>
>> Yesterday night, I've tested with [0] but seems to have the same HEAD as
>> the github repo you pointed out. Seems the above is coming from pahole's
>> __die__process_tag() bailing out with default for DW_TAG_label?
>>
>> On my side worked fine:
> 
> hum, I also had to change the version of pahole in the patch to allow
> version v1.12, because both latest pahole sources are on version 1.12,
> did u have to do that? looks like there's v1.13 somewhere ;-)

Yeah, I did for local testing. Tag still needs to be bumped by Arnaldo.
