Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656CC10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 22:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2563320820
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 22:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfDIWrD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:47:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:37650 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDIWrD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 18:47:03 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDzW7-00088v-Rr; Wed, 10 Apr 2019 00:46:59 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDzW7-0005da-Hq; Wed, 10 Apr 2019 00:46:59 +0200
Subject: Re: [PATCH bpf 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>,
        Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        Ye Xiaolong <xiaolong.ye@intel.com>, ferruh.yigit@intel.com,
        "Zhang, Qi Z" <qi.z.zhang@intel.com>, will.deacon@arm.com
References: <1554792253-27081-1-git-send-email-magnus.karlsson@intel.com>
 <1554792253-27081-3-git-send-email-magnus.karlsson@intel.com>
 <621a9d70-5397-da90-a68c-6f12f5cbd3b2@iogearbox.net>
 <CAJ8uoz2Cxkfv++znzzjZJ2=D0YbTJkf+BOH=y2nBEByiW8stdA@mail.gmail.com>
 <3d30cbdc-23d6-8305-4089-0a3eacfa55cc@gmx.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <563ad58c-25cd-eab3-3a18-97c0b53f080d@iogearbox.net>
Date:   Wed, 10 Apr 2019 00:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <3d30cbdc-23d6-8305-4089-0a3eacfa55cc@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/10/2019 12:28 AM, Georg Müller wrote:
> Am 09.04.19 um 13:29 schrieb Magnus Karlsson:
>> On Tue, Apr 9, 2019 at 11:11 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 04/09/2019 08:44 AM, Magnus Karlsson wrote:
>>>> The use of smp_rmb() and smp_wmb() creates a Linux header dependency
>>>> on barrier.h that is uneccessary in most parts. This patch implements
>>>> the two small defines that are needed from barrier.h. As a bonus, the
>>>> new implementations are faster than the default ones as they default
>>>> to sfence and lfence for x86, while we only need a compiler barrier in
>>>> our case. Just as it is when the same ring access code is compiled in
>>>> the kernel.
>>>>
>>>> Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
>>>> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>>>> ---
>>>>  tools/lib/bpf/xsk.h | 19 +++++++++++++++++--
>>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
>>>> index 3638147..317b44f 100644
>>>> --- a/tools/lib/bpf/xsk.h
>>>> +++ b/tools/lib/bpf/xsk.h
>>>> @@ -39,6 +39,21 @@ DEFINE_XSK_RING(xsk_ring_cons);
>>>>  struct xsk_umem;
>>>>  struct xsk_socket;
>>>>
>>>> +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
>>>> +# if defined(__i386__) || defined(__x86_64__)
>>>> +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
>>>> +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
>>>> +# elif defined(__aarch64__)
>>>> +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
>>>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>>>> +# elif defined(__arm__)
>>>> +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
>>>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>>>> +# else
>>>> +#  error Architecture not supported by the XDP socket code in libbpf.
>>>> +# endif
>>>> +#endif
>>>
>>> Hmm, bit unfortunate, but I can see why it's needed inside the header here
>>> as it's installed into the system and needs to be included by applications.
>>> Fine with me. In any case, I still think we should also fix it for tooling
>>> infra to avoid others running into the same issue, lemme resurrect [0] from
>>> back in the days.
>>>
>>> One question though regarding above arm32 implementation. You match these
>>> barriers against the ones from af_xdp in kernel. So smp_* variants from the
>>> arch/arm/include/asm/barrier.h header need to be matched. This selects the
>>> dmb(ish) and dmb(ishst) variant. The implementation of dmb() however is
>>> quite CPU dependent, the above assumes to match with __LINUX_ARM_ARCH__ >= 7.
>>> Perhaps this assumption needs at minimum a comment to make it clear for
>>> developers.
>>
>> Good idea. I will put a comment in there to clarify this.
> 
> Since this is a userspace library, what about using the C11 atomic_thread_fence()
> from stdatomic.h - wouldn't that be sufficient?

These are paired with smp_{w,r}mb() in AF_XDP's kernel code, therefore they
would need the exact same counterpart in user space. We had similar discussion
earlier wrt perf ring buffer, conclusion was: the C11 memory model doesn't
generally align with the kernel's, but even if it would emit the same code,
it's still implementation dependent from compiler side, so one would need to
have a guarantee that the mapping from supported compilers must be compatible
at all times to the kernels for the various supported archs.

>>>   [0] https://lore.kernel.org/netdev/20181017144156.16639-2-daniel@iogearbox.net/
>>>
>>>>  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fill,
>>>>                                             __u32 idx)
>>>>  {
>>>> @@ -119,7 +134,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
>>>>       /* Make sure everything has been written to the ring before signalling
>>>>        * this to the kernel.
>>>>        */
>>>> -     smp_wmb();
>>>> +     bpf_smp_wmb();
>>>>
>>>>       *prod->producer += nb;
>>>>  }
>>>> @@ -133,7 +148,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
>>>>               /* Make sure we do not speculatively read the data before
>>>>                * we have received the packet buffers from the ring.
>>>>                */
>>>> -             smp_rmb();
>>>> +             bpf_smp_rmb();
>>>>
>>>>               *idx = cons->cached_cons;
>>>>               cons->cached_cons += entries;
>>>>
>>>

