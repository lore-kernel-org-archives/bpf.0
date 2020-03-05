Return-Path: <SRS0=ocPE=4W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B06C3F2CE
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 00:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293D52084E
	for <bpf@archiver.kernel.org>; Thu,  5 Mar 2020 00:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IqJJGxF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgCEAWF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:22:05 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388407AbgCEAWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 19:22:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48XrzF0lkwz9sNg;
        Thu,  5 Mar 2020 11:22:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1583367722;
        bh=qi76xv8ccVXEeoat1qNh1dA4+AkLuJNPY3Guxujis9g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IqJJGxF7mEDiG9F4/XeoviM4ueCPiP7CtWoxAa29XXiFicndrCXpEAK+5cMuP9PF9
         7AW/uSFcGG4T86lqfht0KwGeAilXiA5eIGnVP9pxRdkMlMwAphI+vo8sZKy5GkZVz7
         mB51fcaBDZ6KgM7Yp3AieXNxJjRvh7JH0SODhE9HxVrsYRnqfWp8w7n5knxl8WwGje
         JwFxtpyOqe4pMqlYoKlkxb84G9LpwOvnKbN3u6T6TntpdL2pGnuiVKavRLF+UOn3eY
         lMtduIhdWwYFeyCO+I9ddq4SJsz52s8I7rtET6+39Tr0sWEqF6JiQ+8iapAamP54et
         ZKoWFt6y592Zw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        daniel@iogearbox.net, kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 2/4] selftests: Fix seccomp to support relocatable build (O=objdir)
In-Reply-To: <11ffe43f-f777-7881-623d-c93196a44cb6@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org> <11967e5f164f0cd717921bd382ff9c13ef740146.1583358715.git.skhan@linuxfoundation.org> <202003041442.A46000C@keescook> <11ffe43f-f777-7881-623d-c93196a44cb6@linuxfoundation.org>
Date:   Thu, 05 Mar 2020 11:22:00 +1100
Message-ID: <87eeu7r6qf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:
> On 3/4/20 3:42 PM, Kees Cook wrote:
>> On Wed, Mar 04, 2020 at 03:13:33PM -0700, Shuah Khan wrote:
>>> Fix seccomp relocatable builds. This is a simple fix to use the
>>> right lib.mk variable TEST_GEN_PROGS for objects to leverage
>>> lib.mk common framework for relocatable builds.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> ---
>>>   tools/testing/selftests/seccomp/Makefile | 16 +++-------------
>>>   1 file changed, 3 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
>>> index 1760b3e39730..a8a9717fc1be 100644
>>> --- a/tools/testing/selftests/seccomp/Makefile
>>> +++ b/tools/testing/selftests/seccomp/Makefile
>>> @@ -1,17 +1,7 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>> -all:
>>> -
>>> -include ../lib.mk
>>> -
>>> -.PHONY: all clean
>>> -
>>> -BINARIES := seccomp_bpf seccomp_benchmark
>>>   CFLAGS += -Wl,-no-as-needed -Wall
>>> +LDFLAGS += -lpthread
>>>   
>>> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
>> 
>> How is the ../kselftest_harness.h dependency detected in the resulting
>> build rules?
>> 
>> Otherwise, looks good.
>
> Didn't see any problems. I will look into adding the dependency.

Before:

  $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
  make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
          ARCH=powerpc -C ../../.. headers_install
    INSTALL /home/michael/build/adhoc/kselftest/usr/include
  gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
  gcc -Wl,-no-as-needed -Wall    seccomp_benchmark.c   -o seccomp_benchmark
  
  $ touch tools/testing/selftests/kselftest_harness.h
  
  $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
  make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
          ARCH=powerpc -C ../../.. headers_install
    INSTALL /home/michael/build/adhoc/kselftest/usr/include
  gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
  $

Note that touching the header causes it to rebuild seccomp_bpf.

With this patch applied:

  $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
  make -s --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
          ARCH=powerpc -C ../../.. headers_install
  gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c  -o /home/michael/build/adhoc/kselftest/seccomp/seccomp_bpf
  gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c  -o /home/michael/build/adhoc/kselftest/seccomp/seccomp_benchmark
  
  $ touch tools/testing/selftests/kselftest_harness.h
  
  $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
  make -s --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
          ARCH=powerpc -C ../../.. headers_install
  make[1]: Nothing to be done for 'all'.
  $


So yeah it still needs:

seccomp_bpf: ../kselftest_harness.h


cheers
