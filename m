Return-Path: <SRS0=6FCD=XT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67023C432C1
	for <bpf@archiver.kernel.org>; Tue, 24 Sep 2019 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24216214AF
	for <bpf@archiver.kernel.org>; Tue, 24 Sep 2019 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569340118;
	bh=DzVXKACqkprHQWD4SKzvVKFWE/eQ8RMyPTQBmpbMVw0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cVqxeEeGKLtrkbm0te9F/RPkZFLr8hFijhx3gM3RpWiElmZbYzaaX7a6Nop04XJco
	 1bB3SN9azn4Wh/TmDayC9FPMGTh6/bcJ/QLPBpUNpNTYM4OVy6ksgduGSsZPl4reR9
	 hOwJxf5c4z2ugF5fbxznSZkRKLAn93g5wq38kbKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390389AbfIXPsh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:48:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38169 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbfIXPsh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Sep 2019 11:48:37 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so5616410iom.5
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2019 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDYzvV0W071U3u50oUnN1wJFiJYibfk2VvG8KWdulNo=;
        b=AzBNMPLi3pY0pVkOyFZu0GXJfXGkKHyxAmlRG3KC0H567lWYQMTWgROJks9hyQgBS8
         mUR+1pEcE5LmsWNrPxYYEbmFWrimyDWAP40CxNFFT8SuPz8BNUAWRbqU+POjyzLHHL10
         WiftNWnECVQtVNbQi8RzvkpkjhMdFtYJqws20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDYzvV0W071U3u50oUnN1wJFiJYibfk2VvG8KWdulNo=;
        b=Kxd7n1aam1nb9QQvR31R4UtKIiPeGvDW0QX+QkSJYcZfc7HmF/KI9T0QedKfUufRNJ
         5lhxrYDP70G/bR5da4wb7dj0frpPcC5ew+MXCUw3BSz9rtwbU3nvuJVlLbDDLXXSXdTK
         KEzXXUC1RQKwh+RZPiO5tt3t8e4F2ESMci7RMN/AbX5p0xbmm+vU0RrVWJeDVQ77G19U
         ZTmhcLGVWYXu9lAjvIu6hJzzPIvadVdsB52dA6QaVZNwWs61NljiS+EFjtmPraP9PXpl
         5jtT1sINqEGfp32pNdYRBhUy5h+DFhHip8dF2yDsRiYxyoncrviqtlh2ERXqrFfq32SJ
         8FEw==
X-Gm-Message-State: APjAAAXkvHaN0vQ6QMh2f+nhuxK1VolxeSa24sE/w5ZDEJolPbV62wtq
        HEGamfnmwVFY3HoTTviEXOV7hw==
X-Google-Smtp-Source: APXvYqw17sJ9rR3xgZewWkEtBIUvt5oZy4433d8pg9IcSwvHVncow1VyHGQd5+pwEWsNdoFa0gLFGQ==
X-Received: by 2002:a6b:6514:: with SMTP id z20mr2573139iob.50.1569340116858;
        Tue, 24 Sep 2019 08:48:36 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r138sm2375156iod.59.2019.09.24.08.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:48:36 -0700 (PDT)
Subject: Re: Linux 5.4 - bpf test build fails
To:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <742ecabe-45ce-cf6e-2540-25d6dc23c45f@linuxfoundation.org>
 <0a5bf608-bb15-c116-8e58-7224b6c3b62f@fb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <05b7830c-1fa8-b613-0535-1f5f5a40a25a@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 09:48:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0a5bf608-bb15-c116-8e58-7224b6c3b62f@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/24/19 9:43 AM, Yonghong Song wrote:
> 
> 
> On 9/24/19 8:26 AM, Shuah Khan wrote:
>> Hi Alexei and Daniel,
>>
>> bpf test doesn't build on Linux 5.4 mainline. Do you know what's
>> happening here.
>>
>>
>> make -C tools/testing/selftests/bpf/
>>
>> -c progs/test_core_reloc_ptr_as_arr.c -o - || echo "clang failed") | \
>> llc -march=bpf -mcpu=generic  -filetype=obj -o
>> /mnt/data/lkml/linux_5.4/tools/testing/selftests/bpf/test_core_reloc_ptr_as_arr.o
>>
>> progs/test_core_reloc_ptr_as_arr.c:25:6: error: use of unknown builtin
>>         '__builtin_preserve_access_index' [-Wimplicit-function-declaration]
>>           if (BPF_CORE_READ(&out->a, &in[2].a))
>>               ^
>> ./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
>>                          __builtin_preserve_access_index(src))
>>                          ^
>> progs/test_core_reloc_ptr_as_arr.c:25:6: warning: incompatible integer to
>>         pointer conversion passing 'int' to parameter of type 'const void *'
>>         [-Wint-conversion]
>>           if (BPF_CORE_READ(&out->a, &in[2].a))
>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
>>                          __builtin_preserve_access_index(src))
>>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 1 warning and 1 error generated.
>> llc: error: llc: <stdin>:1:1: error: expected top-level entity
>> clang failed
>>
>> Also
>>
>> make TARGETS=bpf kselftest fails as well. Dependency between
>> tools/lib/bpf and the test. How can we avoid this type of
>> dependency or resolve it in a way it doesn't result in build
>> failures?
> 
> Thanks, Shuah.
> 
> The clang __builtin_preserve_access_index() intrinsic is
> introduced in LLVM9 (which just released last week) and
> the builtin and other CO-RE features are only supported
> in LLVM10 (current development branch) with more bug fixes
> and added features.
> 
> I think we should do a feature test for llvm version and only
> enable these tests when llvm version >= 10.

Yes. If new tests depend on a particular llvm revision, the failing
the build is a regression. I would like to see older tests that don't
have dependency build and run.

thanks,
-- Shuah
