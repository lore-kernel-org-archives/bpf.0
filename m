Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CCC433EF
	for <bpf@archiver.kernel.org>; Tue,  1 Mar 2022 02:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiCACWI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiCACWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 21:22:07 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67526AEB
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 18:21:23 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K71Cm6ygNz9swS;
        Tue,  1 Mar 2022 10:19:32 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 10:21:20 +0800
Message-ID: <206d3ec1-70e2-7d93-8f0d-597c7980ff5f@huawei.com>
Date:   Tue, 1 Mar 2022 10:21:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Update btf_dump case for
 conflicting type names
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20220224101444.1169015-1-xukuohai@huawei.com>
 <20220224101444.1169015-3-xukuohai@huawei.com>
 <CAEf4BzbZr_VrJVJ+b9U9dxtQG0eF98sv+_VjQmqf5guGUC+5xA@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAEf4BzbZr_VrJVJ+b9U9dxtQG0eF98sv+_VjQmqf5guGUC+5xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/3/1 9:28, Andrii Nakryiko wrote:
> On Thu, Feb 24, 2022 at 2:04 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>>
>> Update btf_dump case for conflicting names caused by forward declaration.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> Acked-by: Song Liu <songliubraving@fb.com>
>> ---
> 
> Please make sure that all tests are passing. Currently there are failures:
> 
>    [0] https://github.com/kernel-patches/bpf/runs/5367548029?check_suite_focus=true
> 
>>   .../selftests/bpf/prog_tests/btf_dump.c       | 54 ++++++++++++++-----
>>   1 file changed, 41 insertions(+), 13 deletions(-)
>>
> 
> [...]
> .
> 
OOPS, didn't notice this failure,  will fix it.
