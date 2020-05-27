Return-Path: <SRS0=ObQj=7J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DFCC433DF
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 18:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9031B2088E
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590603763;
	bh=QgnyO9bO47K1KuGB9/HzGeaaehRlpBpp5cf2TayhSoc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ph5Jze7MiJ6cbxsVrAlvqq5OZqiOrQayhA/z33m8T0lzO69PPDi/Jbs1VuaN8WGEN
	 966UKRVfZYirj26ZBlHgFYXd1n/yM8J9MdEN6CR13fP6P/He17+Mc8LqKv3p3thqA+
	 oSfIu9rJ6e7+3AV7B0PWSC+JkPT9WD3pus/sAcXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgE0SWl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 May 2020 14:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgE0SWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 14:22:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0E32088E;
        Wed, 27 May 2020 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590603758;
        bh=QgnyO9bO47K1KuGB9/HzGeaaehRlpBpp5cf2TayhSoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zhTTiLwMU1JIdSy/JNxlCnOyDqsEDzeuy5MzMnEJS6O2Pub8aJI3Z23JR0u8YpP+v
         +dI+xfamvhOrC6+rkoyRNjmZnxNJK0EMkWO2LsZAVcZpshEiNNMTLj5zQerSBgAcFP
         7tAvC7IaZ1L/8NBlWR8lV2BXmE7JpK4lEIKa8yQg=
Subject: Re: kselftest OOT run_tests
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <xunyblmcqfuu.fsf@redhat.com>
 <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
 <xunytv01omwj.fsf@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <07bb723f-8174-5373-6715-65b61942080c@kernel.org>
Date:   Wed, 27 May 2020 12:22:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xunytv01omwj.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/27/20 1:30 AM, Yauheni Kaliuta wrote:
> Hi, shuah!
> 
>>>>>> On Tue, 26 May 2020 11:13:29 -0600, shuah   wrote:
> 
>   > On 5/25/20 7:55 AM, Yauheni Kaliuta wrote:
>   >> Hi!
>   >>
>   >> I'm wondering how out of tree check is supposed to work for make
>   >> O=dir run_tests from selftests (or make -C ...) directory?
>   >>
>   >> (both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
>   >> boolean building_out_of_srctree") and without)
>   >>
>   >> make M= ... does not work with run_tests.
>   >>
> 
>   > Kselftests run_tests target isn't intended for building and
>   > running tests OOT.
> 
> But there is code there trying to handle it. All that OUTPUT
> related things must be removed if it's broken, right? Can I post
> a patch?
> 
>   > Also make M= doesn't make sense for them.
> 
> Well, M=... at least includes all the makefiles.
> 
>   > There is no support to build OOT at the moment. I would like
>   > to get a better understanding of your use-case. Can you
>   > elaborate?
> 
> I care about make install actually. But fixing it I had to deal
> with OUTPUT. Looking a proper for that I found that it's a bit
> broken.
> 
> 

kselftest supports install of all all tests and a sub-set of tests
both native and cross-builds.

Simple case:
If you want to build all tests and install to $HOME/install/
This has a dependency on kernel being built in the source repo
you are running the following install command from:

In Kernel source root dir run:
make kselftest-install O=$HOME/install

You will find installed tests with run script to run them all
under $HOME/install/kselftest/kselftest_install/

If you run run_kselftest.sh under kselftest_install, it will run
all the tests.

You can use TARGETS var to build a sub-set of tests.

In Kernel source root dir run:
make kselftest-install TARGETS=bpf O=$HOME/install


Native or cross-build case when you are doing relocatable
builds.

arm64 cross-build:
# first do a relocatable kernel build in $HOME/arm64_build
make O=$HOME/arm64_build/ ARCH=arm64 HOSTCC=gcc \
             CROSS_COMPILE=aarch64-linux-gnu- defconfig

make O=$HOME/arm64_build/ ARCH=arm64 HOSTCC=gcc \
             CROSS_COMPILE=aarch64-linux-gnu- all

# install selftests (all)
make kselftest-install O=$HOME/arm64_build ARCH=arm64 \
             HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu-

# install selftests (just bpf)
make kselftest-install TARGETS=bpf O=$HOME/arm64_build ARCH=arm64 \
             HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu-


You will find kselftest installed under

$HOME/arm64_build/kselftest/kselftest_install

You can use the same procedure for native builds as well
assuming your native env. is x86_64

# first do a relocatable kernel build in $HOME/x86_64_build

make kselftest-install TARGETS=bpf O=$HOME/x86_64_build

You will find kselftest installed under

$HOME/x86_64_build/kselftest/kselftest_install

It is on todo to update the documentation. :(

thanks,
-- Shuah

