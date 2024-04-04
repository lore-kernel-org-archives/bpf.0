Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9CF13A25E
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265707; cv=none; b=GM9dKBdCogI1hCnZ/h3tu2VzvGjqcfTQNXUIYnJB0guBkUVwcDEzmHeQsyGyS7mjLU0NcR+Z9L9Qe3aBh0sGhmWoNjjcjS3ZB3Kai6TfoBjWV27NABw0yawx+BpMYuTajP3Gsn/3jD/rhRd81nxv+lXk8IYVen12Og2dUeauyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265707; c=relaxed/simple;
	bh=qoRhv9m2ra5YsnRikCS05dVEhrC+yEoGGsTy7LYY9TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4OpuxAURp9ruhNmGTACWxwghaQBSbkuAJG+OobQ1sEML++lclT9BZqhPLg9L4Csd7fd92btm/vUA+vrZCDVw8VgeiO6X3fOage824ukwTgRFcE815Xvhmhl4vIvgPiY5MtczZpAwe1wPu065HvH0mpdcH/Jd6OWFiK8vsNM3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLN/Xlt9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLN/Xlt9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1161581a12.2
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712265706; x=1712870506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBvZMA+HVroSLFG5ErGuiISZ4ykfO9Alqpvgdxg9wOc=;
        b=JLN/Xlt9e1wwvq7gqsN4J0XPhYw5aQzxdlZ7feDK7+XBO4aJ4f8RaHcuJkL/ucs6Em
         /cMk9y5ADAO+Si/4FpqQvvPtdS/x+OvqBTUcesSKEXFfOnE23iT192UzAMfyCoFj/Sgr
         ruuGIavPn2CGGm3Gd1dNa6WDZVuizmGBclpRuSdCZGkdePucIq/o2eOZMCzEMrVuGUzy
         S/wezi4PhC6j2bySgZXz4/EA6J0iWdzS8FD4UFh5j+ZzA6qCgnMoZaUVYLMYWmQRS7sT
         wFLJ//jR5bE2QxC1FPPf5RYsx/BaYaXkVyT9onc1qUjKnnbrT5I9D71CX4bHDRyOAubU
         GrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265706; x=1712870506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBvZMA+HVroSLFG5ErGuiISZ4ykfO9Alqpvgdxg9wOc=;
        b=J40DHku/1NPbKIvWf6NJvNh/ulT9ZX8JhqxNk1HTIx6F+3Z5+14vAwnSp8ZpVjcJO5
         EfOtoaRktpUojXvg3MBRoXMAKuNlL66d7yvoGhfoI6sIBQDG08bVBSeHzIrEcTBODbOZ
         cGErKzw1+Bi05ywtCpm2bjkzRrKhaH8n6CWt95WBcdfqDCfFq0EQHgewh4Df4TeVnj8L
         zLTWpfiSVXCIc/8VeNYnd2csaKJsZ1e1omzy3lASiSEflRjgXQYNxCcsNgTfCxOjq8A7
         ZamX0NjqVOSe4U6RhBaWhZjDElgSaUGaorhzQ4x5YdZt7CH5O/TgfKWCiTZgA0cmjL8Y
         8A8g==
X-Forwarded-Encrypted: i=1; AJvYcCWHVdFwFdl1LxHPoqJ2OG+wG52OK1+/SkSk6NNcQ6n/eiolbsscGqRMzmqbwpu+zqaEMvjPiY7c59r7qVAKjBBDrzR3
X-Gm-Message-State: AOJu0Yw20VRDZ6MuAWik2kH4o756PHLyAXGQuR/+B2M/M6VPYx/m9rrG
	8Rqv8lVEs5xUydUeRsl6XLxS/Ap7jFWFbyUSuYPj1F5ajEFDIvD2cYtcTFbMb9mSJAl7nC7Ri1J
	nuZ0lhi7ngtKhff1668zYySYIQ2k=
X-Google-Smtp-Source: AGHT+IGMZDw4envF2NQ0rxLzTn4DGkFhFyCBNHNYhyvJE6OFmxKu4HFYwPQm75xsOHo7fiyED9Ip/0ydVsni0pMfjvg=
X-Received: by 2002:a17:90b:1201:b0:2a2:e10e:1594 with SMTP id
 gl1-20020a17090b120100b002a2e10e1594mr2386256pjb.37.1712265705787; Thu, 04
 Apr 2024 14:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
 <CANk7y0jpJuLsnD1fmK5-oqD5CWvrGkzaYU1+Yya_7VuYtzPpMQ@mail.gmail.com>
In-Reply-To: <CANk7y0jpJuLsnD1fmK5-oqD5CWvrGkzaYU1+Yya_7VuYtzPpMQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 14:21:33 -0700
Message-ID: <CAEf4BzYC5j=zYOov+hDaugh5_nJO6z=wAq_f5SxSQUiWXH6ZaQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:03=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> Hi Andrii,
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
>
> Can you share the code for these benchmarks? I want to use the same to
> compare the performance
> on ARM64.
>

Sure, see [0]. You can run:

$ ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc

from tools/testing/selftest/bpf directory to get something like

$ ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc
glob-arr-inc   :  243.196 =C2=B1 7.879M/s
arr-inc        :  218.139 =C2=B1 4.407M/s
hash-inc       :   97.727 =C2=B1 3.643M/s

  [0] https://github.com/anakryiko/linux/commit/8dec900975ef1a0308a78621547=
35549d6b66f64

> Thanks,
> Puranjay
