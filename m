Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83FC127
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293590; cv=none; b=d+7gSDxuqd4Ti24w9AHkif3ntkqNLCfUchwbkfN5bCpUSeg7YxG+iHY4sL0+xyHCLTzYoj5X7WULWkgtwAckCNZRNAc89J6V34ntYz5sDQZ99mYbL7QnGJaW1pSAlyfd1MVRZ2kghJb3I2paBoOWmXrWBJ7cneCn6JA6FBgj/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293590; c=relaxed/simple;
	bh=TUhrngyF35bK9aFEGdkT6KVO/mm5dHOTf/FCD5oUXc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiQDyoJx+KgHxPmz3tyXiCzwAzi52Ni9uFfY1XKB4AJ3ulBaZ3Oj3AjsDiMMEEYJGPrVJc9irlmSOe0sXxAEQvzxOsR+0RzCGhtv4fqeGeHz0veIzspG+o7xSJEkVepNkn4wu9bn2wGsd+REe676A7aAA45Z8Av9sUuPBBnvgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZO//9Se; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZO//9Se"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5684073ab38so710182a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710293587; x=1710898387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKArfJka0uRLJKTwVEtDQQx+NlA52TVkIBj5QrXObdw=;
        b=cZO//9SeOgIBc4t5PIii0dv2Rkogup9XYu6POEpcStl1PMROROYuL0LUrSFYUKc5Nu
         O3HD3YRFv1S8fx0fZXLBa+hVwgxOvu7tsdW2NlaKI7gg5MNKMfPOy6BYFB0PMswCMMAB
         JauL17WvlL299gmC8qUui82uCMgCNXrbrAtrPw5f+KDgDvgkCfju/TYzYCrxRxNPeLiE
         poK1LoM1aJv2RFwY/YNzi/0kBpS4McgGy4IxLmJdePpECRg/f5//iYVf/u4pqQ0VcLrN
         2XVC01hrdnVkoIKvQG4X4ABEoIwPOQM6HO9oTPvdy6GB33Zdj6MwTev3grEIB/+WrCUV
         x97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293587; x=1710898387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKArfJka0uRLJKTwVEtDQQx+NlA52TVkIBj5QrXObdw=;
        b=GyKoI07hKY8Ir9YflgKtzGFcelXPeF/SQSM7ouMZWMcCBW8WeRuF/Bec5HTZueK3lA
         N4s3vWMLRfT2Ct71foNBgDkkbKCLm6BR4d7Era2tzhcd77diDBLm1a2RxIVb2FIO8I7N
         AsPK3pjNfwzh3ve2bxNp01dYPpt8xCqLNP3bRLOqfZnQEWWriCRtC10Pu7+kv2Bbuy9v
         5BnUstDRluXlH0iJRUAxUfTkbSS8lKnVSfH7Ziyj02TlUlIT1N39yowPqiD5ef+loh+g
         us40jROlZV92lH0G0L2jDH5l8vqNyYrI6wFfvi3HNCfWQh/YHulVrXMKT1NoEK/1k5X/
         dBfA==
X-Forwarded-Encrypted: i=1; AJvYcCVoXO6XfIIlUZP78rDF/4bEkCP+7cX7BM0vHajsf7dkhgdUMuJO6L54c9k22mF595+HaWIYZLNXm8eKdGw4wkcKMoJe
X-Gm-Message-State: AOJu0YxFB+Kpx2qVY5FYZyco/C6e3QWi1nk+ovbykUOzbTaeJ2mNciZB
	Br0vp8NJfPgegLTlpPOkf355rh8vP+ZNsD9z3EL1In+S53rk9KtV4bMQUjRTnbfwPTFgV5RZSfX
	Q/RUySibazGVELSWZHdB3g5dB/4E=
X-Google-Smtp-Source: AGHT+IGvpb7HcopnrlxEp/7SzTm72GU2xfIxCK1gy/WXhW8S+YDv/ffrDfKo6SsxLkDTTtNCEnU30O+Ittd61pi3/wk=
X-Received: by 2002:a50:ccd6:0:b0:565:cf:2566 with SMTP id b22-20020a50ccd6000000b0056500cf2566mr1046286edj.12.1710293586907;
 Tue, 12 Mar 2024 18:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com>
 <ZedT8S-GjNOry5LZ@krava> <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
 <412c987b-b1c4-4761-83e4-d46c78a255be@gmail.com> <CABWLsevYANVb8TmOF69qtXeEjk6=NVQmsObrFG8r+oqSRMBxpw@mail.gmail.com>
 <097cc830-7a73-4fb8-9c97-b3b337a25f99@gmail.com>
In-Reply-To: <097cc830-7a73-4fb8-9c97-b3b337a25f99@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Tue, 12 Mar 2024 21:32:54 -0400
Message-ID: <CABWLses3HSLcYYHp64nb4CLxq9t7tifh9VzpSAnjnDDAGvr1UQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 1:16=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 3/8/24 07:43, Andrei Matei wrote:
> > On Thu, Mar 7, 2024 at 6:02=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.co=
m> wrote:
> >>
> >>
> >>
> >> On 3/5/24 15:53, Song Liu wrote:
> >>> On Tue, Mar 5, 2024 at 9:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> >>>>
> >>>> On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2/29/24 06:39, Jiri Olsa wrote:
> >>>>>> One of uprobe pain points is having slow execution that involves
> >>>>>> two traps in worst case scenario or single trap if the original
> >>>>>> instruction can be emulated. For return uprobes there's one extra
> >>>>>> trap on top of that.
> >>>>>>
> >>>>>> My current idea on how to make this faster is to follow the optimi=
zed
> >>>>>> kprobes and replace the normal uprobe trap instruction with jump t=
o
> >>>>>> user space trampoline that:
> >>>>>>
> >>>>>>      - executes syscall to call uprobe consumers callbacks
> >>>>>>      - executes original instructions
> >>>>>>      - jumps back to continue with the original code
> >>>>>>
> >>>>>> There are of course corner cases where above will have trouble or
> >>>>>> won't work completely, like:
> >>>>>>
> >>>>>>      - executing original instructions in the trampoline is tricky=
 wrt
> >>>>>>        rip relative addressing
> >>>>>>
> >>>>>>      - some instructions we can't move to trampoline at all
> >>>>>>
> >>>>>>      - the uprobe address is on page boundary so the jump instruct=
ion to
> >>>>>>        trampoline would span across 2 pages, hence the page replac=
e won't
> >>>>>>        be atomic, which might cause issues
> >>>>>>
> >>>>>>      - ... ? many others I'm sure
> >>>>>>
> >>>>>> Still with all the limitations I think we could be able to speed u=
p
> >>>>>> some amount of the uprobes, which seems worth doing.
> >>>>>
> >>>>> Just a random idea related to this.
> >>>>> Could we also run jit code of bpf programs in the user space to col=
lect
> >>>>> information instead of going back to the kernel every time?
> >>>
> >>> I was thinking about a similar idea. I guess these user space BPF
> >>> programs will have limited features that we can probably use them
> >>> update bpf maps. For this limited scope, we still need bpf_arena.
> >>> Otherwise, the user space bpf program will need to update the bpf
> >>> maps with sys_bpf(), which adds the same overhead as triggering
> >>
> >> That is true. However, even without bpf_arena, it still works with
> >> some workarounds without going through sys_bpf().
> >
> > Anything making uprobes faster would be very welcomed for my project.  =
The
> > biggest performance problem for us is the cost of bpf_probe_read_user()
> > relative to raw memory access. Every call to this helper walks the proc=
ess'
>
> "raw memory access"? Do you mean not going through any helper function,
> reading from a pointer directly?

Right.
I recognize that, as long as bpf runs "in the kernel", one cannot simply
dereference a user-space pointer since the kernel is a different virtual me=
mory
space (*). Still, I wish there bpf_probe_read_user() were faster.

(*) Or, is it indeed a different memory space or is the kernel's virtual
address space mapped into every process? Did this change through KPTI? I wo=
uld
be curious to read a good resource on what exactly it means to switch from
user-space to the kernel and back, if such a thing exists.

>
> > page table to check that the access would not cause a fault (I think); =
this is
> > very slow. I wonder if there's some other option that would keep the sa=
fety
> > requirement for the memory access -- I'm imagining an optimistic mode w=
here the
> > raw access is performed (in the target process' memory space) and, in t=
he rare
> > case when a fault happens, the kernel would somehow recover from the fa=
ult and
>
> I am not very familiar with this part. I read the implementation of
> bpf_probe_read_user() a little bit. It does what you mentioned here. It
> would cause page faults, however, the handler will skip the instruction
> leaving the counter non-zero. By checking the counter, it knows the
> instruction is not completed, and returns an error.
>
> I am curious about what your access pattern looks like. Does it access a
> large number of small chunks of data? Or, does it access a small number
> of big chunks of data?

My access pattern looks like a lot of small reads. Some of these reads coul=
d be
done at the same time if we had a vectorized API (i.e. some of the pointers=
 are
known in advance); for others there are data dependencies (i.e. we need to
dereference a pointer to know what we'll want to read next). Specifically, =
the
use case is a debugger of sorts which uses BPF uprobes for poking around in=
 the
target process' memory, rather than the more traditional ptrace-based
techniques (ptrace being very slow). This debugger needs to walk a lot of
thread stacks by following stack pointers or by using DWARF unwind informat=
ion,
and then it further reads data structures from the target process' stacks a=
nd
heaps, chasing pointers recursively.


>
> > fail the bpf_probe_read_user() helper. Would something like that be tec=
hnically
> > feasible / has there been any prior interest in faster access to user m=
emory
> >
> > A more limited option that might be helpful would be a vectorized versi=
on of
> > bpf_probe_read_user() that verifies many pointers at once.
> >
> >
> >>
> >>> the program with a syscall.
> >>>
> >>>>
> >>>> sorry for late reply, do you mean like ubpf? the scope of this chang=
e
> >>>> is to speed up the generic uprobe, ebpf is just one of the consumers
> >>>
> >>> I guess this means we need a new syscall?
> >>>
> >>> Thanks,
> >>> Song
> >>
