Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0A1F938
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784358990; cv=none; b=dBB//BQr9hgQzY5rUHkHFY5MphzTsyRkS66+jltDurxG6pIf7iHiSra4VKyXPt7F8mD9i8jq3xEPv2q/LFhTW2STIdsSLme5XgE6tlalSFCWfpraGjOrzu+CHzBQIW0pZY0yjptxXDZtjFQyrKOhSnAsEMGBSv4al3fpAfmHMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784358990; c=relaxed/simple;
	bh=j0sKNsEiZ5IWClk6MuxNEOruBhLWU3Lx+JlxGKTz9cA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gMnIn5qYNUCSeiwO3jAjFwQfRarJaqzueXKclP20zTnsX7mGlmOeDcMqK9PhnvufwXcuc7CkHlp3W2iL12qoOhh8WKXXNGUnppC75QN4liVQwyWGsu4j2rO+yWMhQ2ygIirPbyA4Q5hwsoUvJjFm6PiJ+zVcRlORF/XCUYyvijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp2J+JyH; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp2J+JyH"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1916515f8f.0
        for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784358986; x=1784963786; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fl4aKug68tRSQQajO04Rgp3fva/Tsm5uZ0ANZn5nlwE=;
        b=gp2J+JyHzjzbNw+F372gJvuoZG4IOxbslX8/swyVLrKSkclUIIfqmWMyQ5A2GTWntp
         XJsFEOVCxpOhIv6IpDtoqW9PwqLEDlZ7nSOASF3UHheg4XmAedNSiiynO/OoWXPbKSi0
         0NTfQASX1WBhk1XIQDetYdV+ggAFwymrZ6DkiFilNtCsn1micLTGBeUQog6of2U476Iv
         xfGwVXnWDi+6hMvH2UYx0M77o0oeE4HaFvlaN37xMAm7J3FFwh/EINTnaVZgEPGECELC
         xHYCUlL4wMgVyyfooioRRoB76b/gxMjjF9FNH6E90kbWBVGs/PV5JKrCJdRRXO+7ORgt
         QLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784358986; x=1784963786;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fl4aKug68tRSQQajO04Rgp3fva/Tsm5uZ0ANZn5nlwE=;
        b=p96lKRZvfDM2NpKSl/YcQ1KsPKgeKjDj3OHMJBzcwbEdhYbzSqCJ4MF5Wzks4gI6Z0
         KOPHwz1ZHFX8/CH0+OioOEL/4K/fUHsmFog8ohr24CJ/6vaLXdGcRfB/Tireq5rqgkV9
         DLfkYTB72rqlaAGPfJaxBdbf9s/Uz4F3Va8zuHst89ufXRGU2uw8Ws1soVj+lq95v8Hs
         RXncxmJU5diXlyX7vJYCIyzKXtNErWiiepxdqniPUArKJ318B1UQen4Gq07VUaNEspZW
         dU8FEwbprFKw6x497A8VGfX4275LS6h64N9/mmNUeckGf+TJnUx4Vjt+IEPkG8WguNNV
         i6hQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVjkyJtRjn+BdkVm2z/V9x7Nw/I0YT6FQ1opMp0BWxO3l2+8s5af6Z00YhSLRI/48TFZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvSUtP1WtwR4wXlwQl4H86svLAENYnJeMA16/qEQVMYNiIufV
	0vphcOkMnenPK+hv99436mY27fBi8FIOpR9OyFeQ2HNbsTvcTlvThyy3
X-Gm-Gg: AfdE7clWQ6A8X7F9rhd1BrOVUeMP1K5t0RQDmv1QYN5tznKCk7ZNpX+Vo1jD69nEeZk
	c56wy9RO9RbZif8SvLH9kFKSAG3tDIjhcDqbjcSqvYlnNLDyn9tv2enRoj9sCuMo5aJh5vhkOsx
	VUplREDmsQtE2/obOduQJIT9vqMbGWufuq/mcwDj32FWjw/yrH53dDEX8Wb6BssamYUGpAP7hQH
	LbrWFoHHfDyObGpJDprwA0iLQI8EUqXk4VDN6oRFfjWWcEdCGRoA9SE7hdpOpvz5B+wphR7/Gw3
	YUyJxsidrHZPI2o1CZccI94+ELpoZaqptXX9rTloo7FOpUTSwj8ZNMHN/f0TwgL8BhsmxfrXAkq
	szkdiH9oliEysCy83VZRJ0R4wsdZOsHWCbjT1n03mhGMwWt6bZmRs1wtlXjYz+92D16RPiZIRb9
	E8lr3B1gZhDmOP7sA4SXIB4LINA3iymNOtDPyYUpqnniC3rhIgWBUHJlVSqk1LINOV5N27PvTID
	VU0GYjvyjjalFsztavtfB3XlXITthJtIWPWuUXWDAnx
X-Received: by 2002:a5d:5f92:0:b0:473:66e2:37d4 with SMTP id ffacd0b85a97d-47f5a66523dmr13070017f8f.27.1784358986246;
        Sat, 18 Jul 2026 00:16:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm10798405f8f.10.2026.07.18.00.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 09:16:25 +0200
Message-Id: <DK1IGXGCR7R7.2ZVCIOYH3JAPL@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 3/9] bpf, x86: JIT __arena kfunc argument
 rebasing
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260715220052.1590783-1-memxor@gmail.com>
 <20260715220052.1590783-4-memxor@gmail.com>
 <bbf82d80eb0dc307d09a6c7cc33c23063a55a90f.camel@gmail.com>
In-Reply-To: <bbf82d80eb0dc307d09a6c7cc33c23063a55a90f.camel@gmail.com>

On Sat Jul 18, 2026 at 3:33 AM CEST, Eduard Zingerman wrote:
> On Thu, 2026-07-16 at 00:00 +0200, Kumar Kartikeya Dwivedi wrote:
>> From: Tejun Heo <tj@kernel.org>
>>
>> Implement arena argument rebasing for kfunc calls on x86. R12 already
>> holds kern_vm_start whenever the prog has an arena, so each tagged
>> argument costs two instructions emitted right before the call:
>>
>>   movl %eN, %eN         /* truncate, clear the upper 32 bits */
>>   addq %r12, %rN
>>
>> A nullable argument tests the truncated value and jumps over the add:
>>
>>   movl  %eN, %eN
>>   testl %eN, %eN
>>   jz    1f
>>   addq  %r12, %rN
>> 1:
>>
>> addq carries a REX prefix for every argument register and is always
>> three bytes, so the jz displacement is constant. The sequence is native
>> code generated after constant blinding has run on the BPF instruction
>> stream, so blinding never sees the rebase and needs no special handling.
>>
>> bpf_jit_supports_arena_args() is not flipped yet; that happens when the
>> struct_ops trampoline side is in place as well.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 49 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>
> Hi Kumar, Tejun,
>
> Sorry for the delayed response.
>
> I'd like to push back on the JIT based approach.
> As far as I understand, it saves a 64-immediate move per callsite,
> for jits that have dedicated arena registers (all but s390),
> but it puts implementation burden on each jit.
>
> There is an easy workaround regarding 64-immediate move:
> use R0 as in the original patch-set by default,
> add a jit_has_dedicated_arena_register() predicate +
> and encoding to address this register from __internal__
> bpf instruction, say BPF_REG_12.
>
> I'd prefer to keep the bulk of the implementation in one place instead
> of verifier.c + 6 jits.
>

I considered some of these options.

I think this is reasonable for kfuncs. We can retain move to R0 for JITs wi=
thout
that predicate. But what do we do for struct_ops? Earlier prototype had to =
reload,
translate the arg, and store it back into ctx. IMO that's way uglier than j=
ust
translating while storing into the ctx during save_args().

At that point, the argument for avoiding JIT-specific code in favor of gene=
ric
sequences becomes a lot weaker.

Now we can argue for having some way to inject generic bytecode sequence in=
 the
trampoline before BPF program is called, but that requires more conversatio=
n.
This case would be the only user. If we have more, it is probably worth a
consideration.

> =3D=3D=3D
>
> Tangential to this, I think that __arena vs __arena_nullable is a footgun=
.
> Is it really so performance critical to avoid this null check?
>

Just imagine multiple arena arguments. Let's think beyond the immediate use=
 case
for a moment (in scx). With the test+branch, that's way too many instructio=
ns
before each function call to translate each argument. In scx I think one of=
 the
kfunc / struct_ops callback already did not need __nullable. In general it =
also
stays more consistent with us opting into __nullable for arguments, than ha=
ving
it by default.

Yes, __arena means different things in different places, the meaning is now
context-dependent. In the program, it just indicates global function takes =
arena
pointer. NULL-ness or not distinction is erased, just like for PTR_TO_ARENA=
. For
kfuncs, the translation happens from program to kernel, for struct_ops, fro=
m
kernel to program. Better naming can probably avoid some of the overloading=
, but
anything else seems uglier to spell out.

> =3D=3D=3D
>
> On more tangential, these flags would represent a third way to encode
> arena arguments we already have:
> - KF_ARENA_ARG{1,2} for kfuncs
> - ARG_TAG_ARENA for global functions.
>
> Any ideas on how to unify these?

We can gate this new one behind type tag support in GCC, and begin using th=
ose
instead. That still won't allow unification with KF_ARENA_* ones.
