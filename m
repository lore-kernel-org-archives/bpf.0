Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0339C12002
	for <bpf@archiver.kernel.org>; Thu, 15 Jul 2021 01:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19EF613B4
	for <bpf@archiver.kernel.org>; Thu, 15 Jul 2021 01:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGOBrh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:47:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6820 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGOBrg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 21:47:36 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQH8f4cfdzXt4Y;
        Thu, 15 Jul 2021 09:38:58 +0800 (CST)
Received: from [10.174.178.171] (10.174.178.171) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 15 Jul 2021 09:44:36 +0800
Subject: Re: Ask for help about bpf map
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        David Ahern <dahern@digitalocean.com>
References: <5aebe6f4-ca0d-4f64-8ee6-b68c58675271@huawei.com>
 <CAEf4BzZpSo8Kqz8mgPdbWTTVLqJ1AgE429_KHTiXgEVpbT97Yw@mail.gmail.com>
 <8735sidtwe.fsf@toke.dk> <d1f47a24-6328-5121-3a1f-5a102444e50c@huawei.com>
 <26db412c-a8b7-6d37-844f-7909a0c5744b@huawei.com>
 <189e4437-bb2c-2573-be96-0d6776feb5dd@huawei.com>
 <CAADnVQJYhtpEcvvYfozxiPdUJqcZiJxbmT2KuOC6uQdC1VWZVw@mail.gmail.com>
From:   "luwei (O)" <luwei32@huawei.com>
Message-ID: <6b659192-5133-981e-0c43-7ca1120edd9c@huawei.com>
Date:   Thu, 15 Jul 2021 09:44:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQJYhtpEcvvYfozxiPdUJqcZiJxbmT2KuOC6uQdC1VWZVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.171]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii and Toke inspired me. You are right, the libbpf version should be included in -V output
, but not mine. I searched google and found this page: https://www.spinics.net/lists/netdev/msg700482.html
, according which I re-compiled iproute2 and it works.

Previously, I downloaded iproute2(5.13) and excuted "cd iproute2; make && make install". Libbpf which supports
btf-defined map is not included.


在 2021/7/14 10:48 PM, Alexei Starovoitov 写道:
> On Wed, Jul 14, 2021 at 1:24 AM luwei (O) <luwei32@huawei.com> wrote:
>> Hi Andrii and toke,
>>
>>       I have sovled this issue. The reason is that my iproute2 does not
>> support libbpf, once I compile iproute2 with libbpf, it works. Thanks
>> for reply!
> How did you figure that out?
> I thought iproute folks should have included that info as part of -V output.
> Since this exact concern was hotly debated in the past.
> Non-vendoring clearly causes this annoying user experience.
> .

-- 
Best Regards,
Lu Wei

