Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9AFC10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 22:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4875C2084F
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 22:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XNqGKs3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDIW3O (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:29:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:45647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfDIW3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 18:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554848916;
        bh=WFPiKN4PU8tvFS5gv68QeS8lhIbwFrXrizzdbkdy4/Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XNqGKs3ZeOXwFOIQKD8+UN6tZR6alLvccOdLoDe23o6yNOJ7nfMUT7o3HEO/Riy/x
         tOX/Id3pOB1cjnJtDv2mTXwOyfQSgkrGfTeFLhyiMNfn2SwUoN62YvPXRNrOdk552h
         GVvuhdAjP6+F/HCuM9ihsas0QASq4wcv/qwsg6f4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.15.55] ([109.104.43.213]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOBOi-1hHGTo2alo-005WqN; Wed, 10
 Apr 2019 00:28:36 +0200
Subject: Re: [PATCH bpf 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
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
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
Openpgp: preference=signencrypt
Autocrypt: addr=georgmueller@gmx.net; prefer-encrypt=mutual; keydata=
 xsDiBD1O6uYRBADzyVXlOCHhmtVG0ttc5ryyNkmTL1xkhuFxygpnAnGA3T1Me0xZ1792b5/l
 1SkeB8VREGtxkpyjikmjPMlKVwDUAHAyNmVdUPUprNzxF/5YwFGyBADPlPoA0jjR7FJ8cSI+
 1zPbRGRvXVcGeRkcabv30EjzL1IVrZaTBk4KBWDeewCg5SPnVc81nzfneYTvyCrIS0MCuNMD
 /1/FEQZa/O4YiPVGUGcumi3A26Albp9nTp4k4OcmRZSL9g6PT/YPKWOxj0ugJeSpVQ7opIct
 LcnHRXeakh0x6T7nrG03CBdK/M+EIKXdolX2dtyW380QT8fwzLjBVO0RefwygSu5Ha6XXRhg
 /K4rXvDCciI5T/cQnK5HQe0dVKGRBADd57A59PzxALhOyF7AgC4wq5m/9KbVgci2Yo4MeMFE
 uuESLYjPSSvHY/zBG6onevyYxuriSdbEgfXD10Gwvr8Exho8cX0Kg/AEDIj1zLBk3JxuTHQa
 7Rxp565Ck6cHEwIAYoWek0LzEZdMtS8BStHABFMJtlCyWMVKGXqG7Vlkdc0uR2VvcmcgTcO8
 bGxlciAoR01YLUtleSkgPGdlb3JnbXVlbGxlckBnbXgubmV0PsJaBBMRAgAaBQsHCgMEAxUD
 AgMWAgECF4AFAlU07wACGQEACgkQh5n2wOj8m8tXgACbB0On074qXrS3eWfhutFlH+6KmYIA
 oMgeY4C4cDk1/GbMBUlP2qo50EUpzsBNBD1O6ucQBAD1Jah6AjT25zOL2HdzIx0f2Uyi9f+5
 rI2FmIq4v2GCuWzpapRMEGtvr23RXjV7HJsQs7jBVFi2Xda+WmZDlviPD/T/se0Htyq09qUD
 CI+/lTnSOruyIvSlR4hKML16m7MvKwKOdU2NOkk/iCbTEoOQXM8sNKSkA14EpL7EhUCVnwAD
 BQQAtDPJPZ6prjwEtbmFaz8Me3tPfpQItg7wveW+WLtqdsvIo0qmp0hWp47t1YEVXpQVmTnx
 kBgh+8RAhlHcB7cU2MnqLDmvTh0OIn4DdusWIOfAxzv442hbFBrAA1r4xlnV2zq59E8w4hhB
 A8Tur4rfL69LfwEasPqugoI9v28ERvbCRgQYEQIABgUCPU7q5wAKCRCHmfbA6Pyby3sEAJ9H
 M3QGgjcPSRh8c7j8SN0auYvNmgCg3TiiOylY6CaDzF8iI0M6ejP5dPc=
Message-ID: <3d30cbdc-23d6-8305-4089-0a3eacfa55cc@gmx.net>
Date:   Wed, 10 Apr 2019 00:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJ8uoz2Cxkfv++znzzjZJ2=D0YbTJkf+BOH=y2nBEByiW8stdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZofFMYnu5fLIf5UEpjSV+b7Wo2YuaQV5eBYr2SDS+zmi/9x6jB
 qPBboBte5HaPeTOfqI0muyb5DAWCrb4ifHMA6lRUSAwsKzmmOJ3Pg3KVA494cOFUcw5+1Xy
 oJQ74IMKW2B+7aFU6Of2PSU78b/zSBKw1c50K+dI0Rme7Ay4tXXVjm8xpPBix71FT+cM9Za
 Za3L1zxIQuk2Ikx16nOTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N+XU9gw/yZ0=:8zOAmqkK0JbwA44HcLYOjT
 9/Mk9k0+DtXLd6eWHhCU68Y9Vj68HcSus5OyPs4CtLxN0I6hIJ8c9XuWFT2u9ATZga0PLwXfX
 EFvCdZMxfgTILl/hwFoEA5bEIOKt4sHisbNkohGiLymqEFpluIWk+3Fn/V2l2stv6iPfLeUP6
 EoMoIjxqa1wQwxiXk8LHZZ9ESItskbgk2fy10T8QEYp6HuGJL49bt97GCMdE7UHkecRSMa/iy
 Pb50Lg3DNMJuidHWVE0iTjC8LEy7wxxk9D1uGChc25QR33ibkr++U941RobRVdhGm3GkIYpb1
 UJmJxYcTzaM6ucHM4FqU13bd2czTOOlwWFUk/C4xQ1yr+6ocIldH/c9GGWhjLR4I3O7y+Kdrt
 Ue0WhCUeSjoTWiPImvAWsas4FPtL8ype938hea5vCQXDN9RE60wQFquOOhW/MDacvDYLasLos
 q3TJuSIcIbJ2o5SLCVGh3UO4eBQj1ideHQRJTDoPBUe2xyrSuMr+4hNhaKM4YgzB67G57i7+P
 QUs1+I+2DMUmitbcxH9iXX0/lXKpP0o5XkB2aN4O2WfiAanNAJ0QhP76FiR6uPxP3TN3ja0xs
 zvLEez5FE0/W7Iaq1dbz01gR9QlkJ8kpK7vPhf9teMckCU9jMcKg4pScAKoLKw/Knb1qC0YTW
 LXjcQxb9Hq+rOcwanfEObaQ/qq03goi7Pe3WI4Os8IwqccNvrKfFiDF2LglERhcoh/2Sg8Sfm
 cY7TbKIM7NmIYHyNYM3JTve18rVkwgoD76i67a9On4Nsmzt9/y+ZcTtNZu7Yzc9URzgNAxKto
 7rYyCV4Yt5rttOKZmaUy5mD+/UtTq97yf6nbbZ0reu8MiPbrTH3gbEMMcznLlCBNMfdjOLsWB
 fO/1sNYSBLI2d2pOEh6FL20B1wdWsUs+sKjp1R2gzIIcqWWsYju/+hHfQW/y2VVmmZ05zXm3Z
 RjLQ6heIS3A==
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Am 09.04.19 um 13:29 schrieb Magnus Karlsson:
> On Tue, Apr 9, 2019 at 11:11 AM Daniel Borkmann <daniel@iogearbox.net> w=
rote:
>>
>> On 04/09/2019 08:44 AM, Magnus Karlsson wrote:
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
>>>  tools/lib/bpf/xsk.h | 19 +++++++++++++++++--
>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
>>> index 3638147..317b44f 100644
>>> --- a/tools/lib/bpf/xsk.h
>>> +++ b/tools/lib/bpf/xsk.h
>>> @@ -39,6 +39,21 @@ DEFINE_XSK_RING(xsk_ring_cons);
>>>  struct xsk_umem;
>>>  struct xsk_socket;
>>>
>>> +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
>>> +# if defined(__i386__) || defined(__x86_64__)
>>> +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
>>> +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
>>> +# elif defined(__aarch64__)
>>> +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
>>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>>> +# elif defined(__arm__)
>>> +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
>>> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
>>> +# else
>>> +#  error Architecture not supported by the XDP socket code in libbpf.
>>> +# endif
>>> +#endif
>>
>> Hmm, bit unfortunate, but I can see why it's needed inside the header h=
ere
>> as it's installed into the system and needs to be included by applicati=
ons.
>> Fine with me. In any case, I still think we should also fix it for tool=
ing
>> infra to avoid others running into the same issue, lemme resurrect [0] =
from
>> back in the days.
>>
>> One question though regarding above arm32 implementation. You match the=
se
>> barriers against the ones from af_xdp in kernel. So smp_* variants from=
 the
>> arch/arm/include/asm/barrier.h header need to be matched. This selects =
the
>> dmb(ish) and dmb(ishst) variant. The implementation of dmb() however is
>> quite CPU dependent, the above assumes to match with __LINUX_ARM_ARCH__=
 >=3D 7.
>> Perhaps this assumption needs at minimum a comment to make it clear for
>> developers.
>
> Good idea. I will put a comment in there to clarify this.
>
> /Magnus


Since this is a userspace library, what about using the C11 atomic_thread_=
fence()
from stdatomic.h - wouldn't that be sufficient?


>>   [0] https://lore.kernel.org/netdev/20181017144156.16639-2-daniel@ioge=
arbox.net/
>>
>>>  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *f=
ill,
>>>                                             __u32 idx)
>>>  {
>>> @@ -119,7 +134,7 @@ static inline void xsk_ring_prod__submit(struct xs=
k_ring_prod *prod, size_t nb)
>>>       /* Make sure everything has been written to the ring before sign=
alling
>>>        * this to the kernel.
>>>        */
>>> -     smp_wmb();
>>> +     bpf_smp_wmb();
>>>
>>>       *prod->producer +=3D nb;
>>>  }
>>> @@ -133,7 +148,7 @@ static inline size_t xsk_ring_cons__peek(struct xs=
k_ring_cons *cons,
>>>               /* Make sure we do not speculatively read the data befor=
e
>>>                * we have received the packet buffers from the ring.
>>>                */
>>> -             smp_rmb();
>>> +             bpf_smp_rmb();
>>>
>>>               *idx =3D cons->cached_cons;
>>>               cons->cached_cons +=3D entries;
>>>
>>
