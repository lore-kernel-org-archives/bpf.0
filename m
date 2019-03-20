Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C2CC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 23:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F723218A5
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 23:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCTXIX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:08:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:51732 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXIX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 19:08:23 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6kJk-0001Ml-Cx; Thu, 21 Mar 2019 00:08:16 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6kJk-000Aup-64; Thu, 21 Mar 2019 00:08:16 +0100
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
To:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
 <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
 <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
 <55387960-b50a-2f5f-1083-da2377558c2b@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8ab21b4e-885d-e91e-1614-f1b15660ce4c@iogearbox.net>
Date:   Thu, 21 Mar 2019 00:08:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <55387960-b50a-2f5f-1083-da2377558c2b@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25394/Wed Mar 20 08:52:02 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/20/2019 11:45 PM, Yonghong Song wrote:
> On 3/20/19 3:27 PM, Stanislav Fomichev wrote:
>> On 03/20, Yonghong Song wrote:
>>> On 3/20/19 10:13 AM, Stanislav Fomichev wrote:
>>>> On 03/20, Sergey Senozhatsky wrote:
>>>>> Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
>>>>> thus not all compilers are able to compile the following code:
>>>>>
>>>>>           (__builtin_constant_p(x) ? \
>>>>>                   ___constant_swab16(x) : __builtin_bswap16(x))
>>>>>
>>>>> That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
>>>>> instance:
>>>>>
>>>>>           error: implicit declaration of function '__builtin_bswap16'
>>>>>
>>>>> We can use __builtin_bswap16() only if compiler has this built-in,
>>>>> that is, only if __HAVE_BUILTIN_BSWAP16__ is defined. Standard UAPI
>>>>> __swab16()/__swab32() take care of that, and, additionally, handle
>>>>> __builtin_constant_p() cases as well:
>>>>>
>>>>>    #ifdef __HAVE_BUILTIN_BSWAP16__
>>>>>    #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>>>>>    #else
>>>>>    #define __swab16(x)                             \
>>>>>            (__builtin_constant_p((__u16)(x)) ?     \
>>>>>            ___constant_swab16(x) :                 \
>>>>>            __fswab16(x))
>>>>>    #endif
>>>>>
>>>>> So we can tweak selftests/bpf/bpf_endian.h and use UAPI
>>>>> __swab16()/__swab32().
>>>>>
>>>>> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>>>> ---
>>>>>
>>>>> v2: fixed build error, reshuffled patches (Stanislav Fomichev)
>>>> Tested them locally with the compiler I saw the initial issues with - all
>>>> fine, I don't see any errors with the older gcc.
>>>>
>>>> One last question I have is: what happens in the llvm+bpf case? Have
>>>> you tested that? I think LLVM has all the builtins required, but since
>>>> we are relying on the swab.h now (and it relies on
>>>> __HAVE_BUILTIN_BSWAP16__), I wonder whether this detection works
>>>> correctly on the llvm when targeting bpf. (sidenote: bpf_endian.h can be
>>>> used from both userspace and bpf programs).
>>>
>>> Inside kernel clang compiler header (linux/compiler-clang.h) does not
>>> define __HAVE_BUILTIN_BSWAP16__. So it will go to the "else" branch in
>>> the above. So I think it should work with clang + bpf.
>> Hm, isn't it the opposite of what we want then? I think for llvm+bpf we always
>> want to use the builtins to make it properly generate
>> BPF_TO_BE/BPF_TO_LE instructions.
> 
> Okay, I see. Then this patch will not achieve that.
> The following are two common ways to compile a bpf program:
>    - "clang -target bpf ...", maybe add macro __BPF__ somewhere
>      to indicate builtin_bswap16 always available?
>    - "clang <host target> ..." and then "llc -march=bpf ..."
>      in this case, __BPF__ macro is not available and
>      we will not be able to use builtin swap for bpf program.
> 
> Maybe use __clang__ macro (or gcc macro) to distinguish between clang 
> and gcc. If it is gcc we will check builtin availability, otherwise,
> we assume builtin always available? This not pretty though.

I think the way this should be fixed is the following: In case
of LLVM (aka compiling BPF prog), we want the code to be as-is,
in case if gcc is compiling the hostprog, we either want to keep
using __builtin_bswap16() or fall-back to something else. Thus,
I would suggest, we add a new feature test for tooling infra under
tools/build/feature/ that compiles a dummy prog with __builtin_bswap16().
And in the bpf_endian.h we define __bpf_ntohs(x) to __bpf_swab16(x)
which either resolves to __builtin_bswap16() or some fallback
implementation if not available. I don't think there should be much
of an issue and it would follow the standard way to do it.

>>>>>    tools/testing/selftests/bpf/bpf_endian.h | 8 ++++----
>>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
>>>>> index b25595ea4a78..1ed268b2002b 100644
>>>>> --- a/tools/testing/selftests/bpf/bpf_endian.h
>>>>> +++ b/tools/testing/selftests/bpf/bpf_endian.h
>>>>> @@ -20,12 +20,12 @@
>>>>>     * use different targets.
>>>>>     */
>>>>>    #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>>>> -# define __bpf_ntohs(x)			__builtin_bswap16(x)
>>>>> -# define __bpf_htons(x)			__builtin_bswap16(x)
>>>>> +# define __bpf_ntohs(x)			__swab16(x)
>>>>> +# define __bpf_htons(x)			__swab16(x)
>>>>>    # define __bpf_constant_ntohs(x)	___constant_swab16(x)
>>>>>    # define __bpf_constant_htons(x)	___constant_swab16(x)
>>>>> -# define __bpf_ntohl(x)			__builtin_bswap32(x)
>>>>> -# define __bpf_htonl(x)			__builtin_bswap32(x)
>>>>> +# define __bpf_ntohl(x)			__swab32(x)
>>>>> +# define __bpf_htonl(x)			__swab32(x)
>>>>>    # define __bpf_constant_ntohl(x)	___constant_swab32(x)
>>>>>    # define __bpf_constant_htonl(x)	___constant_swab32(x)
>>>>>    #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>>>>> -- 
>>>>> 2.21.0
>>>>>

