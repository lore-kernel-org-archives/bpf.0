Return-Path: <SRS0=cKI0=5E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE10C4332D
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 03:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAFC20768
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 03:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lChQmtD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCSDPO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:15:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCSDPO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Mar 2020 23:15:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48jX8X5w3qz9sPF;
        Thu, 19 Mar 2020 14:15:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584587710;
        bh=rG0ZNtXeOAIDv6nCRsCIvY7aiOa2R5AcTzVNUoyUCUM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lChQmtD0utfONPyZbRLEW+i1FS865SHM6yI7oEJ/I8vHdalR5I4FhRBQZUxh0tpel
         VTqIUg9j2ZcNdmOXQixeNcm3twMifZ/pCiiBMaeZANmLR5oR8BVyd4B5G33uc+9oHl
         zFjnoSM69uY4a1dP7ITQnF+3ia32Rka50mwbyLDP9PRdYuyt2q1jezDPjp06F/JgRd
         brwMOdZp3XLIl1Dakg+h5s6KcVCvuld1AmsobLfc4d86CpMcgL566CN6mhmQQDKNf6
         0EP65bsu2Q2+wS4MyeZqZk3uZAh9rKi4FvefRqmIEqJbtw4gWiex8mLMjUiRHn6yDy
         UXukKabLCJuEQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        luto@amacapital.net, wad@chromium.org, daniel@iogearbox.net,
        kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3] selftests: Fix seccomp to support relocatable build (O=objdir)
In-Reply-To: <202003161404.934CCE0@keescook>
References: <20200313212404.24552-1-skhan@linuxfoundation.org> <8736a8qz06.fsf@mpe.ellerman.id.au> <202003161404.934CCE0@keescook>
Date:   Thu, 19 Mar 2020 14:15:11 +1100
Message-ID: <87h7yldohs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Mon, Mar 16, 2020 at 11:12:57PM +1100, Michael Ellerman wrote:
>> Shuah Khan <skhan@linuxfoundation.org> writes:
>> > Fix seccomp relocatable builds. This is a simple fix to use the right
>> > lib.mk variable TEST_GEN_PROGS with dependency on kselftest_harness.h
>> > header, and defining LDFLAGS for pthread lib.
>> >
>> > Removes custom clean rule which is no longer necessary with the use of
>> > TEST_GEN_PROGS. 
>> >
>> > Uses $(OUTPUT) defined in lib.mk to handle build relocation.
>> >
>> > The following use-cases work with this change:
>> >
>> > In seccomp directory:
>> > make all and make clean
>> >
>> > From top level from main Makefile:
>> > make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
>> >  CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp
>> >
>> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> > ---
>> >
>> > Changes since v2:
>> > -- Using TEST_GEN_PROGS is sufficient to generate objects.
>> >    Addresses review comments from Kees Cook.
>> >
>> >  tools/testing/selftests/seccomp/Makefile | 18 ++++++++----------
>> >  1 file changed, 8 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
>> > index 1760b3e39730..a0388fd2c3f2 100644
>> > --- a/tools/testing/selftests/seccomp/Makefile
>> > +++ b/tools/testing/selftests/seccomp/Makefile
>> > @@ -1,17 +1,15 @@
>> >  # SPDX-License-Identifier: GPL-2.0
>> > -all:
>> > -
>> > -include ../lib.mk
>> > +CFLAGS += -Wl,-no-as-needed -Wall
>> > +LDFLAGS += -lpthread
>> >  
>> >  .PHONY: all clean
>> >  
>> > -BINARIES := seccomp_bpf seccomp_benchmark
>> > -CFLAGS += -Wl,-no-as-needed -Wall
>> > +include ../lib.mk
>> > +
>> > +# OUTPUT set by lib.mk
>> > +TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
>> >  
>> > -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
>> > -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
>> > +$(TEST_GEN_PROGS): ../kselftest_harness.h
>> >  
>> > -TEST_PROGS += $(BINARIES)
>> > -EXTRA_CLEAN := $(BINARIES)
>> > +all: $(TEST_GEN_PROGS)
>> >  
>> > -all: $(BINARIES)
>> 
>> 
>> It shouldn't be that complicated. We just need to define TEST_GEN_PROGS
>> before including lib.mk, and then add the dependency on the harness
>> after we include lib.mk (so that TEST_GEN_PROGS has been updated to
>> prefix $(OUTPUT)).
>> 
>> eg:
>> 
>>   # SPDX-License-Identifier: GPL-2.0
>>   CFLAGS += -Wl,-no-as-needed -Wall
>>   LDFLAGS += -lpthread
>>   
>>   TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
>>   
>>   include ../lib.mk
>>   
>>   $(TEST_GEN_PROGS): ../kselftest_harness.h
>
> Exactly. This (with an extra comment) is precisely what I suggested during
> v2 review:
> https://lore.kernel.org/lkml/202003041815.B8C73DEC@keescook/

Oh sorry, I missed that.

OK so I think we know what the right solution is.

cheers
