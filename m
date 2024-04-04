Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DB129A99
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247529; cv=none; b=DaH6Cfqd7RZxIuJ5wh/GJbCVYVYAMd9sZaY+n8TlOSkMgKG7LRDcmpYzO/syjwgye2InpjzKHciyKa5AP3I1+2VlNku3V2upuco8apVO7i4c474PM842MSYppoJ15OCM7ysku4lar14EqXTcYSlBx2DzoetcsPvubwKfG2G8g8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247529; c=relaxed/simple;
	bh=tsN48wNxAGfgFVm4XgxYFTSg6aCxtWT1LbvNWVL4B9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjmZyxGwlcyEDeavdaWNYwHQUfaKmiE1jJqCoxxG3yrzScXC/bGlPtuUOuBOQgu0kZQdmdAk2Nq4iHsqOpYxg/6voBVWALZzJ8tm6ph4MDjWFQXsFu0xdgkxmjYyVvRhdJ0hJfiBjiBpnWwARmuBdM2S9uQpOBy7HDBHXELiOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H99gDk+R; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H99gDk+R"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecc9f0bdaaso877399b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247527; x=1712852327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaOTCU/M0fDdFTZ/TbTXmq6HtJvh8uIdKwnzdoNhtIA=;
        b=H99gDk+RrLRLi99IiRem4ARftSpcBhD+9JsZ65tBGAb7+NoeXiPyH1nkHvoIOKlvUk
         C8BDK2/sRmYYr5dziJxLRRfa6lM6GLnGrrTi1hdErNM18PRIQXTm81DisC7WWb3I3lQK
         gp4sFYj3D57pr5EGLPGL755OKx8oyMGP1DC9BJIfZp4/XEUWfQK/SWZjTTTTUJWhH+jT
         enuTdo7zkM1cFdLU0D0ohAiJrkYrCUgWlA147TI1UaDuHVZrh7LRHSLzOTfoBpWzbPua
         nmp0lqyG+uP0JHTFRRn8zZAfrCD+eo8uIayfAhE7vrFoRFZFkrEzThw6zNBv7P3DWe83
         3UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247527; x=1712852327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaOTCU/M0fDdFTZ/TbTXmq6HtJvh8uIdKwnzdoNhtIA=;
        b=VuKCvbPQTV2YvqEEEgQszpKx18DiYCNNL9PLBhwoVS+ijmbsR3jodnSacC11pFBmpI
         Kdo1TMDp7+9jBOE6bsmVjKr2qpzROPIq3lbbXR9hLaevgEoKE4SkxEj6xRDhRfEzSv6g
         cSLH0dae79sPEXCfP9lKTGysUnSejEf61FNMVGQv5QrZ/2/JteGLBTej1wvo88UkRd9l
         q3o8d1qBGQY9Hiuc+4NG+Kyti5rhse1d109h+CIbQEuqwfdW+vzvlHWFUKQNs20kcL7Y
         Z1BRlFkFz70UC7lF9P2v6MB+Sw7Qyfh4uJ1C3/Jzjbp9Lu2zHjADxerdhAEsYR/jtfgb
         L0MA==
X-Forwarded-Encrypted: i=1; AJvYcCU1jUSeNgSeZV70mA+CEA/akbt6w7q4G7v0P2RB64yshQzZUa1FKK/W05qdhm6zDK9jsgrMbQjLRqD1AV5+2XMJq3IW
X-Gm-Message-State: AOJu0YwGd3uhzylLMEWCPhn6kClSDFHpE6ZGLeee2DmS8Xq4CYX+LJub
	yY7kC1+7TYmHvbT8cORQ6gfc3ZITp9eCSXDMrpgdXvhq6SUlK82iXJXgzs+eOXrDpGnlcB2icvL
	flrn5NRQ8jBCy3hAm5cgQpcGrWvQ=
X-Google-Smtp-Source: AGHT+IECK35IHap5TUDfWnrqaYFNKEJbev/SaausVWsox6i0vMaN3M84amD7hwDbAQN/EcEOY+iQY14NSLBTiTsWA4E=
X-Received: by 2002:a05:6300:808d:b0:1a3:409f:b9a3 with SMTP id
 ap13-20020a056300808d00b001a3409fb9a3mr297340pzc.23.1712247527215; Thu, 04
 Apr 2024 09:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
 <CANk7y0irLCvngsPtwR007DPoTjgT0BQfmkPW4AOY0hTRkWV8Xw@mail.gmail.com>
In-Reply-To: <CANk7y0irLCvngsPtwR007DPoTjgT0BQfmkPW4AOY0hTRkWV8Xw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 09:18:35 -0700
Message-ID: <CAEf4Bzb10H2R=UAAGj1THtU68DiT2waLq-VOHVxrvMaPb71Jtg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:16=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On Thu, Apr 4, 2024 at 6:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Apr 1, 2024 at 7:13=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > Add a new BPF instruction for resolving per-CPU memory addresses.
> > >
> > > New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, wi=
th
> > > insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided p=
er-CPU offset
> > > to an absolute address where per-CPU data resides for "this" CPU.
> > >
> > > This patch set implements support for it in x86-64 BPF JIT only.
> > >
> > > Using the new instruction, we also implement inlining for three cases=
:
> > >   - bpf_get_smp_processor_id(), which allows to avoid unnecessary tri=
vial
> > >     function call, saving a bit of performance and also not polluting=
 LBR
> > >     records with unnecessary function call/return records;
> > >   - PERCPU_ARRAY's bpf_map_lookup_elem() is completely inlined, bring=
ing its
> > >     performance to implementing per-CPU data structures using global =
variables
> > >     in BPF (which is an awesome improvement, see benchmarks below);
> > >   - PERCPU_HASH's bpf_map_lookup_elem() is partially inlined, just li=
ke the
> > >     same for non-PERCPU HASH map; this still saves a bit of overhead.
> > >
> > > To validate performance benefits, I hacked together a tiny benchmark =
doing
> > > only bpf_map_lookup_elem() and incrementing the value by 1 for PERCPU=
_ARRAY
> > > (arr-inc benchmark below) and PERCPU_HASH (hash-inc benchmark below) =
maps. To
> > > establish a baseline, I also implemented logic similar to PERCPU_ARRA=
Y based
> > > on global variable array using bpf_get_smp_processor_id() to index ar=
ray for
> > > current CPU (glob-arr-inc benchmark below).
> > >
> > > BEFORE
> > > =3D=3D=3D=3D=3D=3D
> > > glob-arr-inc   :  163.685 =C2=B1 0.092M/s
> > > arr-inc        :  138.096 =C2=B1 0.160M/s
> > > hash-inc       :   66.855 =C2=B1 0.123M/s
> > >
> > > AFTER
> > > =3D=3D=3D=3D=3D
> > > glob-arr-inc   :  173.921 =C2=B1 0.039M/s (+6%)
> > > arr-inc        :  170.729 =C2=B1 0.210M/s (+23.7%)
> > > hash-inc       :   68.673 =C2=B1 0.070M/s (+2.7%)
> > >
> > > As can be seen, PERCPU_HASH gets a modest +2.7% improvement, while gl=
obal
> > > array-based gets a nice +6% due to inlining of bpf_get_smp_processor_=
id().
> > >
> > > But what's really important is that arr-inc benchmark basically catch=
es up
> > > with glob-arr-inc, resulting in +23.7% improvement. This means that i=
n
> > > practice it won't be necessary to avoid PERCPU_ARRAY anymore if perfo=
rmance is
> > > critical (e.g., high-frequent stats collection, which is often a prac=
tical use
> > > for PERCPU_ARRAY today).
> > >
> > > v1->v2:
> > >   - use BPF_ALU64 | BPF_MOV instruction instead of LDX (Alexei);
> > >   - dropped the direct per-CPU memory read instruction, it can always=
 be added
> > >     back, if necessary;
> > >   - guarded bpf_get_smp_processor_id() behind x86-64 check (Alexei);
> > >   - switched all per-cpu addr casts to (unsigned long) to avoid spars=
e
> > >     warnings.
> > >
> > > Andrii Nakryiko (4):
> > >   bpf: add special internal-only MOV instruction to resolve per-CPU
> > >     addrs
> > >   bpf: inline bpf_get_smp_processor_id() helper
> > >   bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
> > >   bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
> > >
> > >  arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
> > >  include/linux/filter.h      | 20 ++++++++++++++++++++
> > >  kernel/bpf/arraymap.c       | 33 +++++++++++++++++++++++++++++++++
> > >  kernel/bpf/core.c           |  5 +++++
> > >  kernel/bpf/disasm.c         | 14 ++++++++++++++
> > >  kernel/bpf/hashtab.c        | 21 +++++++++++++++++++++
> > >  kernel/bpf/verifier.c       | 24 ++++++++++++++++++++++++
> > >  7 files changed, 133 insertions(+)
> > >
> > > --
> > > 2.43.0
> > >
> >
> > Puranjay, Pu,
> >
> > Is this something you guys can help implement for ARM64 and RISC-V
> > architectures as well? I'm lacking the knowledge of the specifics of
> > this architecture to be able to do this by myself, but it is a nice
> > improvement for BPF applications, so it would be nice to get wide
> > architecture support.
> >
> > Thank you!
>
> I have already started implementing this on ARM64,

Awesome, thanks!

>
> Pu, can you do it for RISC-V? If you don't have cycles then I could do it=
 after
> finishing ARM64.
>
> Thanks,
> Puranjay
