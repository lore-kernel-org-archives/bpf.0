Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D574C10F05
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F76218D4
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="TsrdLzHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCUADN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:03:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40231 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCUADM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 20:03:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so2947410pgo.7
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v4BtjpfJbO6gNMqHIipAkUB/MOhgl1tTQ8tnCWq1LVg=;
        b=TsrdLzHSRUS6UwZIUjQRDQn1GKfLTSS6q4jwNO2D+ghu2m6iNvqVegqvEzu+PNXbCd
         2RC1mDqpplTThcdUzeiWiyK9EqXucc5pIjio/2ggcXRowiJzvmva+iWqQC7zE1tRneOy
         NCF1eRX22q9Yept60Yc5Y/4uPQMAIHX/Tm76PMA+5IBJhVJo7kM8qG174sjwdbdsAUNX
         WdkeRuODfMbPphDH7G82ZNbUI76jbsXkT+hBP/iLFwC4qmXxOreuRPf4om7BRasalULK
         low1b4kTVH/aKUnYsFZRddImecvmuLe+2RzgelGR7APH/FwluLkH+yVRsPkp0PoEj/Z6
         dUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v4BtjpfJbO6gNMqHIipAkUB/MOhgl1tTQ8tnCWq1LVg=;
        b=TE/cQ1rMGZkkUe5eMBoN5iLyxsZ+PIgsEdXb6vFBbtjV1lc3oTSmPbGQtTE/9/E2Am
         gzfqcQfdeLEX/TtlA0Wy8FM8dbp0XEZZ6VipFg04c03DuAh7AYxIcJTZ2mPPi0xHnwiY
         ALt5NjazHtq+zHoeyZecQ/2ZS5Ss1FznJKztz4K7mk0NRnS8QCZvzQsKrAA07MRDCWEj
         GGVVhwmWQ7IkxfcLtJ5PZWVyu/6BZEHhoKLLExZgoZCU3QuzQzu5QruoZQ9MBz7h4/cK
         0LdbrV8FggrCGwsW9abSHrtnyqD06Qn+0SVVMBKsXpEsh7qR6L0zoznSBlVaN3b719Xa
         +ylA==
X-Gm-Message-State: APjAAAVrC7oZthYBeazoKV4zELpeX32bkzcYD7jAA29U6eW0gTaZx0FU
        3PBteSsgFlleCqY3ckFSU3HSlg==
X-Google-Smtp-Source: APXvYqyUlCu7TMsrwcxgIZzLZKYOSeMFQJ+KeDuEBI/oherkNnZfqNpRuSrbICH/545dmMrc2sF3Pw==
X-Received: by 2002:a63:f541:: with SMTP id e1mr660666pgk.388.1553126590892;
        Wed, 20 Mar 2019 17:03:10 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id s79sm6292014pfa.61.2019.03.20.17.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 17:03:10 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:03:09 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190321000309.GR7431@mini-arch.hsd1.ca.comcast.net>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
 <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
 <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
 <55387960-b50a-2f5f-1083-da2377558c2b@fb.com>
 <8ab21b4e-885d-e91e-1614-f1b15660ce4c@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab21b4e-885d-e91e-1614-f1b15660ce4c@iogearbox.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/21, Daniel Borkmann wrote:
> On 03/20/2019 11:45 PM, Yonghong Song wrote:
> > On 3/20/19 3:27 PM, Stanislav Fomichev wrote:
> >> On 03/20, Yonghong Song wrote:
> >>> On 3/20/19 10:13 AM, Stanislav Fomichev wrote:
> >>>> On 03/20, Sergey Senozhatsky wrote:
> >>>>> Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> >>>>> thus not all compilers are able to compile the following code:
> >>>>>
> >>>>>           (__builtin_constant_p(x) ? \
> >>>>>                   ___constant_swab16(x) : __builtin_bswap16(x))
> >>>>>
> >>>>> That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> >>>>> instance:
> >>>>>
> >>>>>           error: implicit declaration of function '__builtin_bswap16'
> >>>>>
> >>>>> We can use __builtin_bswap16() only if compiler has this built-in,
> >>>>> that is, only if __HAVE_BUILTIN_BSWAP16__ is defined. Standard UAPI
> >>>>> __swab16()/__swab32() take care of that, and, additionally, handle
> >>>>> __builtin_constant_p() cases as well:
> >>>>>
> >>>>>    #ifdef __HAVE_BUILTIN_BSWAP16__
> >>>>>    #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> >>>>>    #else
> >>>>>    #define __swab16(x)                             \
> >>>>>            (__builtin_constant_p((__u16)(x)) ?     \
> >>>>>            ___constant_swab16(x) :                 \
> >>>>>            __fswab16(x))
> >>>>>    #endif
> >>>>>
> >>>>> So we can tweak selftests/bpf/bpf_endian.h and use UAPI
> >>>>> __swab16()/__swab32().
> >>>>>
> >>>>> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> >>>>> ---
> >>>>>
> >>>>> v2: fixed build error, reshuffled patches (Stanislav Fomichev)
> >>>> Tested them locally with the compiler I saw the initial issues with - all
> >>>> fine, I don't see any errors with the older gcc.
> >>>>
> >>>> One last question I have is: what happens in the llvm+bpf case? Have
> >>>> you tested that? I think LLVM has all the builtins required, but since
> >>>> we are relying on the swab.h now (and it relies on
> >>>> __HAVE_BUILTIN_BSWAP16__), I wonder whether this detection works
> >>>> correctly on the llvm when targeting bpf. (sidenote: bpf_endian.h can be
> >>>> used from both userspace and bpf programs).
> >>>
> >>> Inside kernel clang compiler header (linux/compiler-clang.h) does not
> >>> define __HAVE_BUILTIN_BSWAP16__. So it will go to the "else" branch in
> >>> the above. So I think it should work with clang + bpf.
> >> Hm, isn't it the opposite of what we want then? I think for llvm+bpf we always
> >> want to use the builtins to make it properly generate
> >> BPF_TO_BE/BPF_TO_LE instructions.
> > 
> > Okay, I see. Then this patch will not achieve that.
> > The following are two common ways to compile a bpf program:
> >    - "clang -target bpf ...", maybe add macro __BPF__ somewhere
> >      to indicate builtin_bswap16 always available?
> >    - "clang <host target> ..." and then "llc -march=bpf ..."
> >      in this case, __BPF__ macro is not available and
> >      we will not be able to use builtin swap for bpf program.
> > 
> > Maybe use __clang__ macro (or gcc macro) to distinguish between clang 
> > and gcc. If it is gcc we will check builtin availability, otherwise,
> > we assume builtin always available? This not pretty though.
> 
> I think the way this should be fixed is the following: In case
> of LLVM (aka compiling BPF prog), we want the code to be as-is,
> in case if gcc is compiling the hostprog, we either want to keep
> using __builtin_bswap16() or fall-back to something else. Thus,
> I would suggest, we add a new feature test for tooling infra under
> tools/build/feature/ that compiles a dummy prog with __builtin_bswap16().
> And in the bpf_endian.h we define __bpf_ntohs(x) to __bpf_swab16(x)
> which either resolves to __builtin_bswap16() or some fallback
> implementation if not available. I don't think there should be much
> of an issue and it would follow the standard way to do it.
It's not as easy as llvm vs gcc. We can compile userland tests with
llvm/clang as well. We really need to distinguish between the target: bfp vs
non-bpf: always use builtins in bpf case and fallback to swab.h for
userland (or use feature detection, but swab.h should be enough in
theory).

Can we rely on __bpf__ define?

$ cat tmp.c
#ifdef __bpf__
#error a
#else
#error b
#endif
$ clang -c -target bpf tmp.c 
tmp.c:2:2: error: a
#error a
 ^
 1 error generated.

> 
> >>>>>    tools/testing/selftests/bpf/bpf_endian.h | 8 ++++----
> >>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
> >>>>> index b25595ea4a78..1ed268b2002b 100644
> >>>>> --- a/tools/testing/selftests/bpf/bpf_endian.h
> >>>>> +++ b/tools/testing/selftests/bpf/bpf_endian.h
> >>>>> @@ -20,12 +20,12 @@
> >>>>>     * use different targets.
> >>>>>     */
> >>>>>    #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> >>>>> -# define __bpf_ntohs(x)			__builtin_bswap16(x)
> >>>>> -# define __bpf_htons(x)			__builtin_bswap16(x)
> >>>>> +# define __bpf_ntohs(x)			__swab16(x)
> >>>>> +# define __bpf_htons(x)			__swab16(x)
> >>>>>    # define __bpf_constant_ntohs(x)	___constant_swab16(x)
> >>>>>    # define __bpf_constant_htons(x)	___constant_swab16(x)
> >>>>> -# define __bpf_ntohl(x)			__builtin_bswap32(x)
> >>>>> -# define __bpf_htonl(x)			__builtin_bswap32(x)
> >>>>> +# define __bpf_ntohl(x)			__swab32(x)
> >>>>> +# define __bpf_htonl(x)			__swab32(x)
> >>>>>    # define __bpf_constant_ntohl(x)	___constant_swab32(x)
> >>>>>    # define __bpf_constant_htonl(x)	___constant_swab32(x)
> >>>>>    #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> >>>>> -- 
> >>>>> 2.21.0
> >>>>>
> 
