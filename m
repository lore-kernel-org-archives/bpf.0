Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623E4399CC
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510861; cv=pass; b=MTxFvOYeHFZbz70nRQtkEOr8gqTe/gT2WGBj0kJKhmTYCSwbjyBvDnALIt1K1QsxgzyNsbqKcsBv1rwZsVczY9nDyxuTv4lZc3Hf7yHRMF19RnC9+ofYbFurExeNdAn4nJJjZtinms8yQJBEy2k/VNhG3obiHqmlH9itWj05PJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510861; c=relaxed/simple;
	bh=MElQyXgokZn7ulK/t7XKKrr2pKgxpqMphjjQVDXna7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyczqzKkXdIO8B4WnN64N2Ub+xdHZ1xmUEVP1x2fOrL3VmTz2hIipLpVRv7PbyMMgrGL7DIk7R6vrTbsJPPeHta8aiR+GoZ9VFhXSoFCtjqiVUED0A8nzD0nKEWiKlBwZXaBJkPu2tP6ML3/u/hsBVYcP8bS5c8LcxIsIivm8AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogilUWB4; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogilUWB4"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso894124b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785510856; cv=none;
        d=google.com; s=arc-20260327;
        b=gFBeC9Ne1QePUEP+Ois90ntyzsYqO20B3/L/FHahYfLwWlrvVSmZ/moujMkXarMe4Q
         hw6qj1PdCdjPyiqvQXK2ypnFcbIY62xqT60JqldQpS+qagGXMsFf8oEY/x0s9o5/uKkQ
         z46CvClB6UcKixDV9BxWbMGotjLI9GYFD1TgRFLAj7kzoaOcwTq1mcR/2nLqf3ymuKnf
         zzINqabU+s99zotjpqTj5RNb1RxkXk+9Q5royGa+vHC6oBaesMUNPACCOVFdSSZFvQup
         vXItQjoQ9++BXKnnm+j3IqwbGVI3RntMj0sOktuGWdLHrI/kt9FmPff2lRy7h29gXhpl
         WqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l2WWni0U39jai1IXQf762/lHs5on0cKHTgaiLKgMoZU=;
        fh=dIc1PR1EJk2H+/rJyln2MPlWxjFFctiCE6/JmkJqXpQ=;
        b=DwZXUp4Np93q/PqXbgeR2mTmyGLl7fLddkAJA8rh/VppmqtHbg3oJ0K1YsswfrTEAm
         rRjgiDKVL1cWDmx4ehm/VbHCbmGeTfFqs4ulbideDVs3rM28UNsdJX7zpXq7ixU79Dhp
         iQkHuiXXMwoBpcXaU2aTFIcdbgiBJYgtkZPgKQGwnoLb7Nc/+wQ2egow2M7iaKEwH0eT
         HCu+2y+ou0UkpQfAdViLhs0pV2DGXhZw4Z7eRKafcG4eAlrAS5BGXkbYNc5PKKUmGoZG
         K4TFnixRfLJrnsmDVdR4neCXBHrSOY6VZ3xyV8PPw8Nbx6C/1C984D+slKQUgeNMwC2C
         O7Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785510856; x=1786115656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l2WWni0U39jai1IXQf762/lHs5on0cKHTgaiLKgMoZU=;
        b=ogilUWB46MB68Q6+BlosKLgRQoesvFUf3xN9Vq3Lq/4r3jrv44FQDSGYBihE7fZkCa
         M2GTd4jDfoOWi1TBXUQQb/DnEJ0/x0EbE9E7LDIap1iZDlMtRNyZ/YGCeFob9i/qJAyj
         /8sXmIwecADRfFODCmW+p1pI7QXCvhcD6IVVKMmWqrd8JeYB8aWgjAOLY8SoGUYr6qrA
         ebgWBK4Q2yj93CQSimYnOamjRhVUHXiJm0Z2EuEy8Br8piWAJkfxLzgR7PH1IfVOdl6p
         Iy87O4sKpKBJaRJIm+y/zLow8RpYvU/f+TCSAHz7dYJQjlSo9TpNCbTD0epEtPTEpovD
         nIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510856; x=1786115656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l2WWni0U39jai1IXQf762/lHs5on0cKHTgaiLKgMoZU=;
        b=A5P9Ci9joPeaUNj522vHhSut42Fl73n2I71Cag1JIjVMPi8c4yi5l2HnCZEXiKuLSQ
         VRJ+umKMEKDv7Af6s20+A2jZvHo2H9qqY2/ihjtatPv4ubLQWuaWlBAIZzsLkd8YCC80
         bha1yZqE/5vKGDsENX9meFnl1krS+byuRuC1dzkRAbClpstcbyUwLDCCHXUlH3S3WsMV
         3VBkABO9koCDlEJ91PPhqP1j03Hdehi6+vMprKkOTbqNTfk7SF9HLOnwu/g8dpImrXiV
         tBKSY0nzJnRkwbnsaLHync1bTaXAiYpMhef53iSU+Pn3JkZeNQj9T8B/QHHGw05qXp0l
         KBqA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9s1/YkbeovE5K7qrnuZ1wrMB0FRn92D5lvSBhoEPpoH4i2pqcmZGKIh7kW5kz6G5OZlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/1g231PHb+kvbQoVvyYfz2tyl4p44BPJ3iSL5PM1IEJXIot5
	5Kb1ND1kENOSdIcd3coHyHkOT6fWqhJfl4NM+2OeuFm3FfzwjruYByEzv+ayO96eNBt3o85KTyX
	W+OXudgD/475yAxNWJMAoczBQ5xLVcGA=
X-Gm-Gg: AR+sD111cvcESnwzAwYEJBbUnqVo0NtD1O9U8+offaXn6ztrkKzbRm5F+yTWI0bDeRK
	Vu56DkskkwBy/fXmi+SLTBO74I2EYJvV+aIuh+RbIXUTp3k6hFXAxTsQjgOCizi50e4L8AuOBIj
	zY9dST8IU++dxvSliyKCgOv9lKupTjEPg5mirF3+k7cJ68e8KWgRAYCPxyp1yn7FUPzKRENDLhG
	lHuuqyFWjnKdVCVRCH7oIyovrYEJPMFD2TZZGC/TzEXOm3k3Hfc3Vos5Xxgfi3QE4GPz9PvJMiZ
	wIlib1dVu/VDJcar6r7uqjg24dpOZR1A41v7Lnexoiov2jQ0kT03/OYUAnvim+x0Ba5fvqFfg5g
	y44t5LuGWIvaaV8dBGO2ZxRwsmQ==
X-Received: by 2002:a05:6a00:12c9:b0:848:536f:4236 with SMTP id
 d2e1a72fcca58-84ee4929338mr59168b3a.22.1785510856334; Fri, 31 Jul 2026
 08:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-10-jolsa@kernel.org>
 <CAEf4BzYRzFH+n7Cj2jKpcG6LOZJMh7O38=R7MnoH2jFKxSG1Tg@mail.gmail.com> <amykPmjhfVJlAevL@krava>
In-Reply-To: <amykPmjhfVJlAevL@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 Jul 2026 08:14:03 -0700
X-Gm-Features: AUfX_mwEVtzdT5qpKayTkm8mhDY04kLiqqVrEFmNAwd7oqwFY3KSh3xRmdDNDfw
Message-ID: <CAEf4BzaWoB-RnBqa62X4pzM0PBvn21ZA_Fh3P9pWZ6s5_Hjoeg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 09/11] bpf: Remove trace_in argument from __bpf_get_stack
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 30, 2026 at 04:06:14PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > >  BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> > >            void *, buf, u32, size, u64, flags)
> > >  {
> > > @@ -947,7 +970,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_even=
t_data_kern *, ctx,
> > >         int err =3D -EINVAL;
> > >
> > >         if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> > > -               return __bpf_get_stack(regs, NULL, NULL, buf, size, f=
lags, false /* !may_fault */);
> > > +               return __bpf_get_stack(regs, NULL, buf, size, flags, =
false /* !may_fault */);
> > >
> > >         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STA=
CK |
> > >                                BPF_F_USER_BUILD_ID)))
> > > @@ -966,7 +989,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_even=
t_data_kern *, ctx,
> > >
> > >         if (kernel) {
> > >                 trace->nr =3D nr_kernel;
> >
> > this whole count_kernel_ip() logic above, why do we have it? I don't
> > think we can have combined user and kernel stack trace, so how can we
> > end up with PERF_CONTEXT_USER "ip" at all? I might be missing
>
> the callchain comes from perf event's callchain and that can
> have both kernel and user part

in general, but bpf_get_stack and bpf_get_stackid never request both
kernel and user stack trace in one go and we set add_mark to false, so
we can't have PERF_CONTEXT_USER, which is why I am asking what's the
deal with this nr_kernel calculation.

If it's unnecessary, we should just drop that part and not have that
extra unnecessary complication

>
> > something subtle here, but can you please check again if this whole
> > trace->nr calculation/override is even necessary.
>
> as I wrote in the other reply I don't think we need to change
> trace->nr directly, just pass the needed nr/count as argument
>
> jirka
>
> >
> > > -               err =3D __bpf_get_stack(regs, NULL, trace, buf, size,=
 flags, false /* !may_fault */);
> > > +               err =3D __bpf_get_stack_pe(trace, buf, size, flags);
> > >
> > >         } else { /* user */
> > >                 u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> > > @@ -974,9 +997,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_even=
t_data_kern *, ctx,
> > >                 skip +=3D nr_kernel;
> > >                 if (skip > BPF_F_SKIP_FIELD_MASK)
> > >                         goto clear;
> > > -
> > >                 flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> > > -               err =3D __bpf_get_stack(regs, NULL, trace, buf, size,=
 flags, false /* !may_fault */);
> > > +               err =3D __bpf_get_stack_pe(trace, buf, size, flags);
> > >         }
> > >
> > >         /* restore nr */
> > > --
> > > 2.54.0
> > >
