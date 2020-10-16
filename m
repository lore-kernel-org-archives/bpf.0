Return-Path: <SRS0=a5tc=DX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B38BC433E7
	for <bpf@archiver.kernel.org>; Fri, 16 Oct 2020 06:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161E420848
	for <bpf@archiver.kernel.org>; Fri, 16 Oct 2020 06:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbgJPGTK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 16 Oct 2020 02:19:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393991AbgJPGTK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Oct 2020 02:19:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 258D7E95BBEB13B85C01;
        Fri, 16 Oct 2020 14:18:59 +0800 (CST)
Received: from [10.174.176.180] (10.174.176.180) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 14:18:54 +0800
Subject: Re: [PATCH] bpfilter: Fix build error with CONFIG_BPFILTER_UMH
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20201014091749.25488-1-yuehaibing@huawei.com>
 <20201015093748.587a72b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQKJ=iDMiJpELmuATsdf2vxGJ=Y9r+vjJG6m4BDRNPmP3g@mail.gmail.com>
 <20201015115643.3a4d4820@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQLVvd_2zJTQJ7m=322H7M7NdTFfFE7f800XA=9HXVY28Q@mail.gmail.com>
 <20201015122624.0ca7b58c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQLiYfi3DvT=S_jgb+X=qD4GC1WJynWmh8988scUQJozWA@mail.gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <888cb447-dda7-dd1a-38ab-fbae08032e23@huawei.com>
Date:   Fri, 16 Oct 2020 14:18:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLiYfi3DvT=S_jgb+X=qD4GC1WJynWmh8988scUQJozWA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2020/10/16 3:57, Alexei Starovoitov wrote:
> On Thu, Oct 15, 2020 at 12:26 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 15 Oct 2020 12:03:14 -0700 Alexei Starovoitov wrote:
>>> On Thu, Oct 15, 2020 at 11:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>> How so? It's using in-tree headers instead of system ones.
>>>> Many samples seem to be doing the same thing.
>>>
>>> There is no such thing as "usr/include" in the kernel build and source trees.
>>
>> Hm. I thought bpfilter somehow depends on make headers. But it doesn't
>> seem to. Reverting now.
> 
> Thanks!
> Right. To explain it a bit further for the author of the patch:
> Some samples makefiles use this -I usr/include pattern.
> That's different. This local "usr/include" is a result of 'make
> headers_install'.

I didn't notice this, sorry for the wrong fix.

> For samples and such it's ok to depend on that, but bpfilter is
> the part of the kernel build.
> It cannot depend on the 'make headers_install' step,
> so the fix has to be different.

Yes, this should rework.

> 
>>>>> Also please don't take bpf patches.
>>>>
>>>> You had it marked it as netdev in your patchwork :/
>>>
>>> It was delegated automatically by the patchwork system.
>>> I didn't have time to reassign, but you should have known better
>>> when you saw 'bpfilter' in the subject.
>>
>> The previous committers for bpfilter are almost all Dave, so I checked
>> your patchwork to make sure and it was netdev...
> 
> It was my fault. I was sloppy in the past and didn't pay enough attention
> to bpfilter and it started to bitrot because Dave was applying patches
> with his normal SLAs while I was silent.
> .
> 
