Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22489155A32
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174969; cv=none; b=lMTtrTGVy2evO7xFHAxHBigJMVdzPcPJJnfnFzu8sAH3LHkBfa6OhZBTCG96+Ik9gB3PBWjPZQoYie0ypoqcqwCHTE71Y6+I230/wBsbtMWh61di3xFcPFuTf4RE0azCOP1EOZOWQSOXiwfjr/YQk9slh0OAt8BmZiEaasXiqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174969; c=relaxed/simple;
	bh=jAhTMnavr1/dQPVNh1efFzR1e9Bc9KH2ixvHqT+JRto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ao8SRX51PBmGioju764NbzJmDl6jjQg9RcJOWt0q8N8nVD4rEe20xj7//8Mn5ju/oQPJT3joGTeli5ay47TkziQu+vbclflguLNMDeyv1VL47Ue2ElDZn6XGtwt4pSUgWNAzQFtIKLvrh1byXVLIdaP3/CjMRjv+S+PS46zfdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polarsignals.com; spf=pass smtp.mailfrom=polarsignals.com; dkim=pass (2048-bit key) header.d=polarsignals.com header.i=@polarsignals.com header.b=VG0+DJr4; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polarsignals.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polarsignals.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polarsignals.com header.i=@polarsignals.com header.b="VG0+DJr4"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e675181ceaso166693a34.2
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=polarsignals.com; s=google; t=1712174967; x=1712779767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wiFa75/1RCLjDFXJq4yNlFfeCVOco365AD5pJROc9Y=;
        b=VG0+DJr4LivxEWyWDucbDPWUiO8DBaPHCuVr22qs3yfpYLrHJ+qa83AB4kYUmCQXvE
         8zDvEbuMspM4VLsTFwTFRB9d+VbF0LQwnXgbZOxqIuu2ZgUwoMOIFYmUyDtGFci+3RYh
         PhPtxLOrvV/6wplNTkcjWi/xASHcQHcHEhtYEsaNTbvb3YL+qJGSE7sMxj7RXXMGJzrg
         i42jsm7PT++CNFDv/6xlZnAYZYT0/VcHEdRvczwZ/heHHIQhCEYxzqaoj+R+nMmTQJtW
         wkh8kX8TKE8c34HZUHmWAOifSMrvNfdONHh4U3KKsdiMH0i1j8HhQ+jSwViKhO97ukp8
         Yd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174967; x=1712779767;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wiFa75/1RCLjDFXJq4yNlFfeCVOco365AD5pJROc9Y=;
        b=GMqLts/eR8hH3fKO47rzwz106jdawMRx2BEr9sv8MaQT/udzmvW/TFtrlE2l8juZH6
         by6oGEG68gtEhZs7Zm47t446QM8X7KE2pUbNtCnsDs2HBLDSJFa4yMx7+CP5TN7DbHx/
         XqaIUE8h2AfP2CuD5NXpg9UivFDcQ7AEA2nCYwsUZ65CMF2WQlT6FXuyGGErVS/AYb9N
         JkzAoBT+JnNQarQK6yK4IXawYYrzFtOSyNTyF0GHRag2srjYUPfLX142qnAj6uNuJQ/O
         HHYdJ9qznqJ/KdN9HTIQjt96gU/E7+i8ODKPkhYHECkdx8EDMaMagmEycP3K5BokaJgy
         43Qg==
X-Gm-Message-State: AOJu0YzeoUn0Nxl4f7Fzq3dEKDvHna9MvMP+D5C7fG2c2otyGn82Jpyt
	ChjJgG47P5f5I5ZQRhaPYlp36oshsI6oBQqHwhnvYPHXKWhOoxW2la05y12Wdl8=
X-Google-Smtp-Source: AGHT+IGCrdXXpvjSjF/B38i6HuwSjWt1NhgpeUzYPeIczoruW1Q7r82fz5DPkigBHxLg/o5vsL9dxg==
X-Received: by 2002:a05:6830:44a:b0:6e8:9b1a:6bc2 with SMTP id d10-20020a056830044a00b006e89b1a6bc2mr336569otc.20.1712174967075;
        Wed, 03 Apr 2024 13:09:27 -0700 (PDT)
Received: from localhost (pool-173-56-0-190.nycmny.fios.verizon.net. [173.56.0.190])
        by smtp.gmail.com with ESMTPSA id f9-20020a0562141d2900b0069904ba6522sm3718900qvd.136.2024.04.03.13.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:09:26 -0700 (PDT)
From: "Brennan Vincent" <brennan.vincent@polarsignals.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: 10x regression in processed instructions after recent verifier
 change
In-Reply-To: <CAEf4BzYN-seVkwb0ddGce0EAMWs3kYq1LtpUMmRz6cBtvOXLrw@mail.gmail.com>
References: <874jci5l3f.fsf@taipei.mail-host-address-is-not-set>
 <CAEf4BzYN-seVkwb0ddGce0EAMWs3kYq1LtpUMmRz6cBtvOXLrw@mail.gmail.com>
Date: Wed, 03 Apr 2024 16:09:26 -0400
Message-ID: <871q7m5hu1.fsf@taipei.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Apr 3, 2024 at 11:59=E2=80=AFAM Brennan Vincent
> <brennan.vincent@polarsignals.com> wrote:
>>
>> Hello,
>>
>> I am working on Parca, a continuous CPU time profiler which works by
>> doing DWARF-based stack unwinding in an eBPF program. In 6.8 series
>> kernels, our unwinder can no longer be loaded, as it exceeds the
>> verifier's limit of 1M instructions processed.
>>
>> I was eventually able to get it working, so this is not exactly a
>> support request, but rather a report of an issue that might affect other
>> people.
>>
>> The issue is 100% reproducible and bisects to
>> 67420501e8681ae18f9f0ea0a69cd2f432100e70. Hacking the kernel a bit to
>> increase the instructions processed limit, I found that it successfully
>> verifies after ~3M instructions, whereas previously it took ~250k, so
>> more than a 10x regression.
>>
>> In case it matters, I'm on arm64.
>>
>> I am not an expert on the internal details of the verifier, but I have a
>> vague theory on what can be causing this behavior. Our unwinder has a
>> few places where it needs to do binary search on an array, which look
>> similar to this:
>>
>> #define MAX_UNWIND_INFO_BINARY_SEARCH_DEPTH 19
>> #define MAX_UNWIND_TABLE_SIZE 250 * 1000
>>
>> static u64 find_offset_for_pc(stack_unwind_table_t *table, u64 pc, u64 l=
eft, u64 right) {
>>     u64 found =3D BINARY_SEARCH_DEFAULT;
>>
>>     for (int i =3D 0; i < MAX_UNWIND_INFO_BINARY_SEARCH_DEPTH; i++) {
>>         if (left >=3D right) {
>>             LOG("\t.done");
>>             return found;
>>         }
>>
>>         u32 mid =3D (left + right) / 2;
>>
>>         // Appease the verifier.
>>         if (mid < 0 || mid >=3D MAX_UNWIND_TABLE_SIZE) {
>>             bump_unwind_error_should_never_happen();
>>             return BINARY_SEARCH_SHOULD_NEVER_HAPPEN;
>>         }
>>
>>         if (table->rows[mid].pc <=3D pc) {
>>             found =3D mid;
>>             left =3D mid + 1;
>>         } else {
>>             right =3D mid;
>>         }
>>     }
>>     return BINARY_SEARCH_EXHAUSTED_ITERATIONS;
>> }
>>
>> (For more examples see
>> https://github.com/parca-dev/parca-agent/blob/main/bpf/unwinders/native.=
bpf.c
>> .)
>>
>> Note that as I said, I'm not an expert on the verifier, so my theory
>> could be totally wrong. Please assume I put qualifiers like "I
>> think...", "I suspect...", etc. in the proper places in what
>> follows.
>>
>> The commit in question made the verifier track the bounds of variables
>> more precisely, which might allow it to verify more programs. This,
>> however, has a downside which is that it causes an explosion in the
>> state space. In previous versions of the kernel, we could just verify
>> this snippet once because the verifier did not precisely track the
>> bounds of `mid`. In the new version, we have different bounds for `mid`
>> in the different branches of the main `if` statement, and the set of
>> different bounds multiplies in size by 2 each time through the loop,
>> causing this huge explosion.
>>
>> Now, if I intentionally confuse the verifier and prevent it from knowing
>> the bounds of `mid`, e.g.:
>>
>> static u32 __attribute__((optnone)) scramble(u32 val) {
>>         return val ^ 0xFFFFFFFF;
>> }
>>
>> then, in the main binary search loop:
>>
>>         u32 mid =3D (left + right) / 2;
>>         mid =3D scramble(scramble(mid));
>>
>> then the program verifies fine, as it did before the commit in question.
>
> Yep, I think your analysis is correct, and your obfuscation workaround
> is "sane" :)
>
> Having said that, I think it would benefit your BPF programs from
> thinking a bit more carefully about scaling your BPF verification
> process by using various features and techniques that keep
> verification complexity more bounded.
>
> Specifically, I think you can benefit from making find_offset_for_pc a
> global function, in which case it will be validated just once,
> separately, and then not re-validated.
>
> Also, if you can rely on that, using bpf_for() loops (based on
> open-coded iterators) or bpf_loop() helper would also help minimize
> verification complexity of your loops.

Thanks. I'll look into all those suggestions.

>>
>> I am not sure what, if anything, should be done about this in the kernel,
>> as it seems there's a fundamental tradeoff between precision of the
>> verifier and performance in terms of instructions processed.
>>
>> --
>> Brennan (he/him)
>> Staff Software Engineer | Polar Signals Inc.
>> E: brennan.vincent@polarsignals.com
>> W: umanwizard.com
>> TZ: America/New_York
--=20
Brennan (he/him)
Staff Software Engineer | Polar Signals Inc.
E: brennan.vincent@polarsignals.com
W: www.umanwizard.com
TZ: America/New_York
