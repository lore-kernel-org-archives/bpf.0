Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180EAC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 20:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D819C20850
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 20:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDKUX3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:23:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:52004 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKUX3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 16:23:29 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEgEF-000859-JF; Thu, 11 Apr 2019 22:23:23 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEgEF-000N2Y-AV; Thu, 11 Apr 2019 22:23:23 +0200
Subject: Re: [PATCH bpf v2 2/2] libbpf: remove dependency on barrier.h in
 xsk.h
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Y Song <ys114321@gmail.com>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        bruce.richardson@intel.com, ciara.loftus@intel.com,
        ilias.apalodimas@linaro.org, Ye Xiaolong <xiaolong.ye@intel.com>,
        ferruh.yigit@intel.com, "Zhang, Qi Z" <qi.z.zhang@intel.com>,
        georgmueller@gmx.net
References: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com>
 <1554880154-30791-3-git-send-email-magnus.karlsson@intel.com>
 <CAH3MdRX64deNto0avW3XfexMLhNS+r75x3yea6ko+hmHrOE3aw@mail.gmail.com>
 <CAJ8uoz0suybHMmTGvRRU==L09j3h-dBAE5QeRuzqCqnTrYwK8A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9c517998-ee4e-cf22-8dd4-c0808a1f2d47@iogearbox.net>
Date:   Thu, 11 Apr 2019 22:23:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAJ8uoz0suybHMmTGvRRU==L09j3h-dBAE5QeRuzqCqnTrYwK8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/11/2019 09:54 AM, Magnus Karlsson wrote:
> On Wed, Apr 10, 2019 at 9:08 PM Y Song <ys114321@gmail.com> wrote:
>> On Wed, Apr 10, 2019 at 12:21 AM Magnus Karlsson
>> <magnus.karlsson@intel.com> wrote:
>>>
>>> The use of smp_rmb() and smp_wmb() creates a Linux header dependency
>>> on barrier.h that is uneccessary in most parts. This patch implements
>>> the two small defines that are needed from barrier.h. As a bonus, the
>>> new implementations are faster than the default ones as they default
>>> to sfence and lfence for x86, while we only need a compiler barrier in
>>> our case. Just as it is when the same ring access code is compiled in
>>> the kernel.
>>>
>>> Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
>>> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>>> ---
>>>  tools/lib/bpf/xsk.h | 20 ++++++++++++++++++--
>>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
>>> index 3638147..69136d9 100644
>>> --- a/tools/lib/bpf/xsk.h
>>> +++ b/tools/lib/bpf/xsk.h
>>> @@ -39,6 +39,22 @@ DEFINE_XSK_RING(xsk_ring_cons);
>>>  struct xsk_umem;
>>>  struct xsk_socket;
>>>
>>> +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
>>
>> Maybe add some comments to explain the different between bpf_smp_{r,w}mb
>> and smp_{r,w}mb so later users will have a better idea which to pick?
> 
> Ouch, that is a hard one. I would just recommend people to read
> Documentation/memory-barriers.txt. My attempt at explaining all this
> would not be pretty and likely sprinkled with errors ;-).

I think Yonghong meant here place a comment wrt when to use the below versus
when to use smp_{r,w}mb(). Both are essentially the same just that the main
difference here would be that this header needs to be installed in the system
so users need to have it. I think it indeed makes sense to add a comment about
this specific fact otherwise we might forget about it in few months.

>>> +# if defined(__i386__) || defined(__x86_64__)
>>> +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
>>> +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
>>> +# elif defined(__aarch64__)
>>> +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
>>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>>> +# elif defined(__arm__)
>>> +/* These are only valid for armv7 and above */
>>> +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
>>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>>> +# else
>>> +#  error Architecture not supported by the XDP socket code in libbpf.
>>> +# endif
>>> +#endif
>>
>> Since this is generic enough and could be used by other files as well,
>> maybe put it into libbpf_util.h?

Hmm, maybe a good point. We could place it into libbpf.h as there is already
various misc helpers and xsk.h includes it anyway. But: if we do that, then
the above 'else' part would need some generic fallback (__sync_synchronize()
plus a warning?) as otherwise compilation would break for everyone with 'error'.
Ideally this should then cover as much as possible from mainstream archs though.

> Good question. Do not know. Daniel suggested introducing [0] and
> perhaps that can be used by the broader libbpf code base? The
> important part for this patch set is that these operations match the
> ones in the kernel on the other end of the ring.

Yeah, it can be used generally except for headers that are going to be
installed where these are present in inline helper functions.

> [0] https://lore.kernel.org/netdev/20181017144156.16639-2-daniel@iogearbox.net/
> 
>>> +
>>>  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fill,
>>>                                               __u32 idx)
>>>  {
>>> @@ -119,7 +135,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
>>>         /* Make sure everything has been written to the ring before signalling
>>>          * this to the kernel.
>>>          */
>>> -       smp_wmb();
>>> +       bpf_smp_wmb();
>>>
>>>         *prod->producer += nb;
>>>  }
>>> @@ -133,7 +149,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
>>>                 /* Make sure we do not speculatively read the data before
>>>                  * we have received the packet buffers from the ring.
>>>                  */
>>> -               smp_rmb();
>>> +               bpf_smp_rmb();
>>
>> Could you explain why a compiler barrier is good enough here on x86? Note that
>> the load cons->cached_cons could be reordered with earlier
>> non-overlapping stores
>> at runtime.
> 
> The bpf_smp_rmb() is there to protect the data in the ring itself to
> be read by the consumer before the producer has signaled that it has
> finished “producing” them by updating the producer (head) pointer. As
> stores are not reordered with other stores on x86 (nor loads with
> other loads), the update of the producer pointer will always be
> observed after the writing of the data in the ring, as that is done
> before the update of the producer pointer in xsk_ring_prod__submit().
> One side only updates and the other side only reads. cached_cons is a
> local variable and only for operations done by another core can we
> observe loads being reordered with older stores to different
> locations. Since no one else is touching cached_cons, this will not
> happen.

From perf RB side, I found this one kernel/events/ring_buffer.c +72 to
be very helpful. It's independent of this series, but I would appreciate
if you could make similar scheme / comment somewhere in the AF_XDP code
such that all barriers in there can be more easily followed wrt how they
pair to user space.

Thanks,
Daniel

> /Magnus
> 
>>>
>>>                 *idx = cons->cached_cons;
>>>                 cons->cached_cons += entries;
>>> --
>>> 2.7.4
>>>

