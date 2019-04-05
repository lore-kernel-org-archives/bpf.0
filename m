Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99310C282DC
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCE42186A
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jkqn9od7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDEUox (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:44:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53001 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEUow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Apr 2019 16:44:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so8018192wma.2
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2019 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KaBvcYRf9aRj1HDS5Zg8RJoCJ2VRhOw9/Hc7NEVjceA=;
        b=jkqn9od7Zqpza4ySIaWHttmySxTJOpM8LVDzCsppaEl840f0C7cIKmiLJ3bFWjTN3h
         EqxdbuyDHGM3zhAgNRgm4mxB2Yo6ShbcubNsQO1lf0uqB5m1qbFtCVYXpCfQaIH5zyCU
         BxKpNvVKTeY00CBrrpQqhw0VCFNuZh5q4ItxOiTUzuIMzYUSnUnMqlzTZBKUSamKi7/l
         tvFRwqwpx3v7FF/E2DRWkJU7HZ5qNMLdVX2Vcjg3HMWgc/4t4347VdNs9t+p1HXPIBVA
         nwWrhknC94aCjBYbK9jARWtvBT8/91nsjNRZKi2Nl6VGdyS5N3/sG/VJPQpPUcCZ7WTS
         Axhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KaBvcYRf9aRj1HDS5Zg8RJoCJ2VRhOw9/Hc7NEVjceA=;
        b=ixNn3/gNXzzQJh86NlefatgH/m0WkQpBHmOiUum510JN16Wn/HszWokQC8ReAI5Z6U
         3zSkQpe/a37T0+omBvNGWfV3GrCh8bR1h6HvlAKGKFv25phKAFnVgeuZb8TEV2B7WhKK
         m4nvlIDOOJhcOP0wUjBYGkgSJqvEJUuufXdbD2S/HgzodNVeM8g4teC5A8fsaqRSPvdY
         ku1V73XWNXzPn4Jf3TMk8ECLC1IoR/vU+ovr2VtnmBkhiFiK5RVT+aMrjOdvw9WuDHFE
         n8oBHiregSBGw+TxBukWEXsQkjry/GMnUQO4TXHVxshpFb1C/gb58ezOBFvXzUKik40R
         YMMg==
X-Gm-Message-State: APjAAAX1bYHpQLlLBNPNiEraBuled+Uac/oPwcIxoDJlIkUFprLfBHkB
        Gr+3ecQg2wBXKGIJ+mHJCOcGT+NIM0M=
X-Google-Smtp-Source: APXvYqzMTfNIA4WhWZ7Djz+Hsd7CUszveaPR+h5upJmyD10WjfNO3aOmqxGK2EUZdHpdYh+OsJjFIQ==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr1850581wmf.13.1554497091148;
        Fri, 05 Apr 2019 13:44:51 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id e1sm39122114wrw.66.2019.04.05.13.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 13:44:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that
 really need zero extension to high bits
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <4a397d16-2ee4-e58e-0091-9df7a20b07b9@solarflare.com>
Date:   Fri, 5 Apr 2019 21:44:49 +0100
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF673672-983B-4848-B97C-1344309C1E8D@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
 <4a397d16-2ee4-e58e-0091-9df7a20b07b9@solarflare.com>
To:     Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 26 Mar 2019, at 18:44, Edward Cree <ecree@solarflare.com> wrote:
>=20
> On 26/03/2019 18:05, Jiong Wang wrote:
>> eBPF ISA specification requires high 32-bit cleared when low 32-bit
>> sub-register is written. This applies to destination register of =
ALU32 etc.
>> JIT back-ends must guarantee this semantic when doing code-gen.
>>=20
>> x86-64 and arm64 ISA has the same semantic, so the corresponding JIT
>> back-end doesn't need to do extra work. However, 32-bit arches (arm, =
nfp
>> etc.) and some other 64-bit arches (powerpc, sparc etc), need =
explicit zero
>> extension sequence to meet such semantic.
>>=20
>> This is important, because for code the following:
>>=20
>>  u64_value =3D (u64) u32_value
>>  ... other uses of u64_value
>>=20
>> compiler could exploit the semantic described above and save those =
zero
>> extensions for extending u32_value to u64_value. Hardware, runtime, =
or BPF
>> JIT back-ends, are responsible for guaranteeing this. Some benchmarks =
show
>> ~40% sub-register writes out of total insns, meaning ~40% extra =
code-gen (
>> could go up to more for some arches which requires two shifts for =
zero
>> extension) because JIT back-end needs to do extra code-gen for all =
such
>> instructions.
>>=20
>> However this is not always necessary in case u32_value is never cast =
into
>> a u64, which is quite normal in real life program. So, it would be =
really
>> good if we could identify those places where such type cast happened, =
and
>> only do zero extensions for them, not for the others. This could save =
a lot
>> of BPF code-gen.
>>=20
>> Algo:
>> - Record indices of instructions that do sub-register def (write). =
And
>>   these indices need to stay with function state so path pruning and =
bpf
>>   to bpf function call could be handled properly.
>>=20
>>   These indices are kept up to date while doing insn walk.
>>=20
>> - A full register read on an active sub-register def marks the def =
insn as
>>   needing zero extension on dst register.
>>=20
>> - A new sub-register write overrides the old one.
>>=20
>>   A new full register write makes the register free of zero extension =
on
>>   dst register.
>>=20
>> - When propagating register read64 during path pruning, it also marks =
def
>>   insns whose defs are hanging active sub-register, if there is any =
read64
>>   from shown from the equal state.
>>=20
>> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> ---
>> include/linux/bpf_verifier.h |  4 +++
>> kernel/bpf/verifier.c        | 85 =
+++++++++++++++++++++++++++++++++++++++++---
>> 2 files changed, 84 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/include/linux/bpf_verifier.h =
b/include/linux/bpf_verifier.h
>> index 27761ab..0ae9a3f 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -181,6 +181,9 @@ struct bpf_func_state {
>> 	 */
>> 	u32 subprogno;
>>=20
>> +	/* tracks subreg definition. */
> Ideally this comment should mention that the stored value is the =
insn_idx
>  of the writing insn.  Perhaps also that this is safe because patching
>  (bpf_patch_insn_data()) only happens after main verification =
completes.

During full x86_64 host tests, found one new issue.                      =
             =20
                                                                         =
               =20
=E2=80=9Cconvert_ctx_accesses=E2=80=9D will change load size, A BPF_W =
load could be transformed         =20
into BPF_DW or kept as BPF_W depending on the underlying ctx field size. =
And            =20
=E2=80=9Cconvert_ctx_accesses=E2=80=9D happens after zero extension =
insertion.                          =20
                                                                         =
               =20
So, a BPF_W load could have been marked and zero extensions inserted =
after              =20
it, however, the later happened =E2=80=9Cconvert_ctx_accesses=E2=80=9D =
then figured out it=E2=80=99s            =20
transformed load size is actually BPF_DW then re-write to that. But the  =
               =20
previously inserted zero extensions then break things, the high 32 bits =
are             =20
wrongly cleared. For example:

1: r2 =3D *(u32 *)(r1 + 80)                                              =
                 =20
2: r1 =3D *(u32 *)(r1 + 76)                                              =
                 =20
3: r3 =3D r1                                                             =
                 =20
4: r3 +=3D 14                                                            =
                 =20
5: if r3 > r2 goto +35                                                   =
               =20
                                                                         =
               =20
insn 1 and 2 could be turned into BPF_DW load if they are loading xdp =
=E2=80=9Cdata"
and =E2=80=9Cdata_end". There shouldn=E2=80=99t be zero-extension =
inserted after them will
will destroy the pointer. However they are treated as 32-bit load =
initially,
and later due to 64-bit use at insn 3 and 5, they are marked as needing =
zero
extension.                                                               =
        =20
                                                                         =
               =20
I am thinking normally the field sizes in *_md inside uapi/linux/bpf.h =
are
the same those in real underlying context, only when one field is =
pointer
type, then it could be possible be a u32 to u64 conversion. So, I guess
we just need to mark the dst register as a full 64-bit register write=20
inside check_mem_access when for PTR_TO_CTX, the reg type of the dust =
reg
returned by check_ctx_access is ptr type.

Please let me know if I am thinking wrong.                               =
                               =20
                                                                         =
       =20
Thanks.
                                                    =20
Regards,                                                                 =
       =20
Jiong                      =20=
