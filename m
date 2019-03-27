Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E7C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761762075C
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="QuHHktmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfC0RG7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:06:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45167 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfC0RG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 13:06:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so19465925wra.12
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2019 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0ODLMJG25PVWuaafdsk3bnN9UY90wZ7xdEdk4JKpneo=;
        b=QuHHktmzAYyn3rlrhj9enxtQ40iCXTV5TJzuxISSCNJo+7mr8olBJVTTdD9b6mJj6l
         RJAlrR+lyLM5hXzP/wmx3xRmfbRzCzz5AuyssuurNEz2zNcQYzHC5t8uKr2ZgQQ7ZMX0
         znDC0CjuxVytyVvi0N+ne1ba2Tglkm758mGh/H9ttM/zDZ2eVrIspo7os/og0gLotILU
         I3+CFr3gMDyYRMNf2/AdTJdrwhSPCY6ctiHdiuivsJX347Q8y+oXAwOboLWWxqVKALt7
         C3fZ+4bhcfPL0vWC9L6h1uDF7YOdRQwCAGb8vPjjuCEZUQxN2F7WGL7Uwl9jChPRgLYB
         X9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0ODLMJG25PVWuaafdsk3bnN9UY90wZ7xdEdk4JKpneo=;
        b=EKwAIcxDb/r8E7bHiWE2t0d4XYIOT+eOSIUVVFSHvALhJNfDgRZS8A8luWjFLkRRmu
         QmX6/KoVj2s7h72luwXeHqSm3TcgOTgkh6bQcGv0K5CgCSdIm98guLGPYq2BZB4E/swD
         m5gLIGW/ewAACeix0aNMUonBUMZtrdNnVuP0oPPlyNVKNElOIesmeq5ZWCfHHefr2J9s
         oPFohOVrTown3ZvkDETUqAZTSjA2oJ+071tHDeiMomeov2GBMx8YD89gMchYg+1/BclN
         zLJDS2ss0JQriDpB2Fx/Gf8Cc3z2Sgk6FPjHasYr7ZzbeSE6tDg9wzc0q3MQE5XY1VvY
         K6wg==
X-Gm-Message-State: APjAAAVmmKNqELjQy4sEMA5LTKnnv/5Ug8IxFxub4sT4O81maOIpc001
        M6IkTSdAyxep7sEC29B2QRexvA==
X-Google-Smtp-Source: APXvYqwrr6qf4e54DE8iU4b+5I9vz5Ve31ZvDktXiJfQc/Yg0ZEBTHBVipMuZFLsT3fOXMQKG5tEMQ==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr1671191wru.34.1553706417200;
        Wed, 27 Mar 2019 10:06:57 -0700 (PDT)
Received: from [172.20.1.229] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id d17sm21461871wrw.88.2019.03.27.10.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:06:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that
 really need zero extension to high bits
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190327165057.mzk52t5wedtyf7fl@ast-mbp>
Date:   Wed, 27 Mar 2019 17:06:55 +0000
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECBABE12-F76E-4239-B9B6-DB02805DBE0D@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
 <20190327165057.mzk52t5wedtyf7fl@ast-mbp>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 27 Mar 2019, at 16:50, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Tue, Mar 26, 2019 at 06:05:27PM +0000, Jiong Wang wrote:
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
>> +	s32 subreg_def[MAX_BPF_REG];
>=20
> Same comment as Ed and another question: why it's not part of =
bpf_reg_state ?

Thanks for spotting this, indeed, it looks perfect to be merged into =
bpf_reg_state.

Regards,
Jiong=
