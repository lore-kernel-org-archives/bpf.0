Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B24C43217
	for <bpf@archiver.kernel.org>; Tue,  8 Feb 2022 01:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiBHBr4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243166AbiBHBgy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 20:36:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607EC061355;
        Mon,  7 Feb 2022 17:36:53 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jt5F30ckXzccp1;
        Tue,  8 Feb 2022 09:35:51 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 09:36:50 +0800
Subject: Re: [PATCH bpf-next v4 1/2] selftests/bpf: do not export subtest as
 standalone test
To:     Yonghong Song <yhs@fb.com>, Hou Tao <hotforest@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20220206043107.18549-1-houtao1@huawei.com>
 <20220206043107.18549-2-houtao1@huawei.com>
 <bc45d372-91cf-a909-aa8b-4daa755e758f@fb.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <e1300ed8-8118-6463-551d-59f6c5f10086@huawei.com>
Date:   Tue, 8 Feb 2022 09:36:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bc45d372-91cf-a909-aa8b-4daa755e758f@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2/8/2022 2:17 AM, Yonghong Song wrote:
>
>
> On 2/5/22 8:31 PM, Hou Tao wrote:
>> Two subtests in ksyms_module.c are not qualified as static, so these
>> subtests are exported as standalone tests in tests.h and lead to
>> confusion for the output of "./test_progs -t ksyms_module".
>>
>> By using the following command:
>>
>>    grep "^void \(serial_\)\?test_[a-zA-Z0-9_]\+(\(void\)\?)" \
>>        tools/testing/selftests/bpf/prog_tests/*.c | \
>>     awk -F : '{print $1}' | sort | uniq -c | awk '$1 != 1'
>>
>> Find out that other tests also have the similar problem, so fix
>> these tests by marking subtests in these tests as static. For
>> xdp_adjust_frags.c, there is just one subtest, so just export
>> the subtest directly.
[...]
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
>> b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
>> index 134d0ac32f59..fc2d8fa8dac5 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
>> @@ -102,9 +102,3 @@ void test_xdp_update_frags(void)
>>   out:
>>       bpf_object__close(obj);
>>   }
>> -
>> -void test_xdp_adjust_frags(void)
>> -{
>> -    if (test__start_subtest("xdp_adjust_frags"))
>> -        test_xdp_update_frags();
>> -}
>
> I suggest keep test_xdp_adjust_frags and mark
> test_xdp_update_frags as static function, and
> this is also good for future extension.
> It is confusing that test_xdp_update_frags
> test in file xdp_adjust_frags.c. Typical
> prog_tests/ test has {test,serial_test}_<TEST> test
> with file name <TEST>.c file.
>
Will do and thanks for your suggestion.

Regards,
Tao
> [...]
> .

