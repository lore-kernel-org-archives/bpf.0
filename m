Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8771754
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386116; cv=none; b=rNrrjO/b2d9U95PNMOglfUMVil903wch6iZb2GR6zOYldGaE4Mq1W2jZRyIaucArXVy2MEw6cketByKfUrjng3b9JPMMAi1EPHUkKUaU37Bmhp3XfcC/nKJNHmrWR6eJ+CIJkjW4lRu5sRWES2wrU+lJvelzY7nONtavPWH882Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386116; c=relaxed/simple;
	bh=y5MEHxddCukMOZXeR+j6rnt/Ss6st3+UNRGO+I1r5n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhrab9+aUFjTYI10TynWzMR0Lwj71y+buN1NZkQRT0kqjCb8NmjgZkjWUjnVfPCSBN8ooZ/4OJicR/CzuhKw9ai3tpabYN5LmKBoDbuYVmWEEflCId0i+4HlpFYdNyatnoFohbxP/akv5fkvrav78Hcou/bMVyqSx0+ehj2v4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOlSbcvZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOlSbcvZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0b213efa3so10423305ad.0
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386114; x=1711990914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG/ALs0MFtadAywsrLsrgz2JTIiLWXV1CV9d1MmRXTQ=;
        b=HOlSbcvZECvqeGqROFAZT7HF1eS9mlhKqjsX0awamPxJAKQiBFmHIbIYs9TK8Ib9DC
         Ktvpn7a97gFHUP/cqlfgq3AvhMqCfPcbITzZJeicB5kE6Y3GJ1CIETCpiVPDoaECLLCT
         C15BeQhIxtfuXxWBUpxFATSeugI607A6F9a+Aopis7B1GypkYBN1C/6uhfi/gNiG+oRl
         X9SKhHfuM52chGFNrfGvCiRl5gpkKFmD7wI2/JrudVMJTZkYWMos3B68umrGvPZVEe8N
         UVMWz4cFOzVOju1ReFxf/U/wBKvSZw/4MXUF3/u92jzlOEAua3wILxjd5IN6td21NoVm
         5m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386114; x=1711990914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG/ALs0MFtadAywsrLsrgz2JTIiLWXV1CV9d1MmRXTQ=;
        b=mYHlVLVf/svbkjfD+1C1ZaT094eZFrOBO2H6cahntuiYC/pTaRLY2yLzsiHO6EW1Jd
         COa/AU1j044xsi5DqzWIhsU/7S9khxUBRr5pWY3ciIrJu/SguVahHaldUZFxGNzhGU24
         klp18BCOlWyeQvdha4ldznFm/42sZ7LBlEiMR4mLIDhQDTyIMYE/mlxroH77XfUeb8UN
         lwt/+X348TztPiI+nvQ4yXaqK0a7UoA8mnjVezCCwbFqz8G6y10Kbe2LOPMk18SNV7+q
         QdAEDn8zTHmdZqWvtwjbnYAL1mG+AQcmqsOKGsyEQeAFw1BgTJcKYTAzMYQ090dREdFB
         QMdg==
X-Forwarded-Encrypted: i=1; AJvYcCVhhuyQyjWR2nZcdvTSjKlo/I4s92JCrf+I6nerPm0ldLIYowfuAY3jDziRkqgv6sD5wU7gHkGOznGyRVWdc3Yd2CQk
X-Gm-Message-State: AOJu0Yz6+Xwtnncl4h9amo2QdmOXvbP07C4SkSS+QZ52Hg/nBKtLh+3X
	Wc6DNdNcF58Ors2qhf/KIzNOXkoeQaeywgYvI4gvmMtTQAdZGzA77C9V8u0tcS7je7ncqQQDBLN
	MCbIOda5za5imRO4TWUAseLNpmzM=
X-Google-Smtp-Source: AGHT+IEsKJ1agx5RgXIkKOGONcEP5k3eLR9z7I+q7cMARgB/hZhk1A3hdc+5KzRKTW5GnTE6bTripMmgIO/37sJE6k4=
X-Received: by 2002:a17:902:dacd:b0:1de:ecb4:79ca with SMTP id
 q13-20020a170902dacd00b001deecb479camr9998425plx.25.1711386114194; Mon, 25
 Mar 2024 10:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <20240321180501.734779-4-andrii@kernel.org>
 <CAADnVQLWv4eeKiEEZB1QjorFvNpmPLreBr3TPscf9kry8n25Cg@mail.gmail.com>
 <CAEf4BzYUZPULju9pnk3hoEb1uGROqSxM9tren9a5VqT7xCTOCw@mail.gmail.com> <CAADnVQKkgSQk2jxgYjLgOAHvSoSqB-2HUO2G-0PwEinaBgyJzw@mail.gmail.com>
In-Reply-To: <CAADnVQKkgSQk2jxgYjLgOAHvSoSqB-2HUO2G-0PwEinaBgyJzw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 10:01:42 -0700
Message-ID: <CAEf4Bza4hcyxE7YQLGWPPtuamLMxc6+DPXDSHz+LD_cxaO+SeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 8:28=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Designing and adding new instruction also sounds fine, but it's a
> > separate feature and is more involved and will require careful
> > considerations. E.g., we'll need to think through whether all JITs
> > will be able to implement it in native code (i.e., whether they will
> > have enough free registers to implement this efficiently; x86-64 is
> > lucky to not need any extra registers, I believe ARM64 needs one extra
> > register, though; other architectures I have no idea). Safety
> > considerations as well (do we accept any random offset, or only ones
> > coming from per-CPU BTF variables, etc). I don't know if there are any
> > differences, but per-CPU access for module per-CPU variables is
> > something to look into (I have no clue).
>
> I didn't mean to add an insn that is exposed all the way to
> bpf prog and requires verification, addr checks, etc.
> But a pseudo insn that the verifier can emit when it inlines
> various helpers.
> It's ok to add them iteratively and revise as we go, since it
> won't be an api.

Ah, ok, so an instruction that JIT will know about, but the verifier
will reject if provided by the user? Ok, I can do that.

> Like per_cpu_ptr() equivalent insn doesn't need to be added right away.
> this_cpu_ptr(offset) will be good enough to start.
> JIT-ing that single insn will be trivial and
> you implemented it already:
>      EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset); else ...
>
> The verifier will emit BPF_THIS_CPU_PTR pseudo insn with
> pcpu_hot.cpu_number offset when it inlines bpf_get_smp_processor_id().
>
> At the same time it can inline bpf_this_cpu_ptr() with the same insn.
>

sounds good, we'll need to guard all that with arch-specific check
whether JIT supports this instruction, but that's ok (eventually we
should be able to make this insn support mandatory and clean up those
checks)

> And we can finally implement map_ops->map_gen_lookup for
> per-cpu array and hash map using the same pseudo insn.
> Those lookups are often used in critical path and
> the inlining will give a noticeable performance boost.

yep, I'll look into that as well

>
> > As an interim compromise and solution, would you like me to implement
> > a similar inlining for bpf_this_cpu_ptr() as well? It's just as
> > trivial to do as for bpf_get_smp_processor_id(), and would benefit all
> > existing users of bpf_this_cpu_ptr() as well, while relying on
> > existing BTF information and surrounding infrastructure?
>
> yes via pseudo insn.
>
> after per-cpu maps, various bpf_*redirect*() helpers
> can be inlined and XDP folks will enjoy extra performance,
> and likely other cases where we used different solutions
> instead of emitting per-cpu accesses in the verifier.

that part I'll leave up to XDP folks :)
