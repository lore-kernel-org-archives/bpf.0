Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713453AC
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124990; cv=none; b=HCvkSh71MsiMugDe4JYsyuoqmR6WDOmrKcLhTreaFyIlHSYk0fyfPO6uY5S6C2mWUCNQNdtCBIx6mrkJFB6WAWC4NQyPByiLXeH4x36mUw1yi0OLb00yyDQw1L1nVKcGyTdf/O1YrSq+C/i2QkdTd9C55XaOg5W+cKamLh5BwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124990; c=relaxed/simple;
	bh=OKTSETOaIf+cDllksWoXnbkZa2TuIPIonIMCuioza3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKH1T7ZgsqqsGoeX0GtJ4Foq+u4ss2psDoc6FmTejwxhxUzplDY1S5z1Moq377TEGM5CuP0hJZzR8PJdVttla9u2VX/HDEX0TKDJJfS1y79S4eOyySYGmt2VHMsEOZiWBT047GdQkp0twp9jm/+sALr90SWLVW5c37lT1/sI7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy/hDVU6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy/hDVU6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e94c12cfaso591947f8f.3
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 19:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710124988; x=1710729788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kszp2/sHdBYHQM3bCGYoHt7aaVrOE/U3KZlolmgyyrM=;
        b=Gy/hDVU6WLZRSLWV6w+1WHKKIdt/bHHsBja6dacH5sVls+okZ6CgzBq3VhbHCnrOjb
         jX/tCqre6DtevBMxTFK3ekb64iQ4YnlwXdKxu60Xa9WxUFvdk8jct41RkMcLBNY0yUq8
         kI2jXxydG5WfCAA12i9K862RCD3dnj0iU/sJ5jXhOR/krQoD7zhH6/AgSOBcMyR7JOQO
         gDc9QqifYMuuZFFjMJH34swNIe+wjHG1Y0u57fKjPfLUer5ke8MT5hGm52xMH+GnzJKw
         Jrpauhude9DsmFiJLFfoOXGAkYoWmmpAqipR0m0NDEOwsz/+p8TBK7Twd5rN/C3LbPkJ
         nzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710124988; x=1710729788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kszp2/sHdBYHQM3bCGYoHt7aaVrOE/U3KZlolmgyyrM=;
        b=k6KJAEyvKU4bQ1BFRY/HYW/3EgBAgPN+QKQIH6J1tn/Jd06YsYTa1LP9igY7kSJI8Z
         fBeL5yKbnhnemZEYWWtzAGNaK8ZzJO4r+r6h0E4gLWs7nv7BX13aNwu21FD4h2DGA8q5
         4z6450vZLNUqqPJ+qEaKSCk/2Sc4rZuf9XceJRsuyZCdDxLpt3iLbSat7QLMalBWQOgm
         vzEylIQIUZVdiY6ru+9jKQW6DzVIgTuzdUjHkIhf+XsuFGDWCoRsACuPEUyv3xnSEvf0
         8imXQKokXC656XkQ1lWMAxY3Vf7rB9HSwemml7WnurnkSFn7oZCZMsuXCdVavTYFmj3+
         jMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvq+HjpXsexVnu8/Zf05YV0AtfxU/vXI/iTTKmRZ5QdPo6bAcDKvJWzNdUEsvwKSs7KdP7J9y7fgnUWJ2OCph0veOy
X-Gm-Message-State: AOJu0YyvB6SsLNDFZs2OOfVpLyaOLMqnbU22ZSSkheNTQjcTEjrUYKxn
	WbkWPlWvYAbreAP6vUdClcvA5OAp2nHUc3Eb+8vKOU57oWLdeySPII7FotN5q2OTzB9bVq8FQyo
	vn/rtsmrAHCAKXoOUthdl8442gfI=
X-Google-Smtp-Source: AGHT+IHB1HlCfT26qC9N0aUQ9OmjLBXn3TJesDmw3rjbXRDqU54RdYkSuC4D1f4Y0dJ2cnaEulbkjOI2HJX3V+Jo2e0=
X-Received: by 2002:adf:e40b:0:b0:33e:733b:cd11 with SMTP id
 g11-20020adfe40b000000b0033e733bcd11mr3432241wrm.53.1710124987487; Sun, 10
 Mar 2024 19:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403092219.dhgcuz2G-lkp@intel.com> <CAADnVQJ+6mFs56fu+KEvumQ5uqM-oLpYx0hGxLJfE9XUCtEWEA@mail.gmail.com>
 <CANk7y0gT8bvKuhJvxG1yLTxdRycMKNEBtgEv_PsCA56Nv74cDg@mail.gmail.com>
In-Reply-To: <CANk7y0gT8bvKuhJvxG1yLTxdRycMKNEBtgEv_PsCA56Nv74cDg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 10 Mar 2024 19:42:56 -0700
Message-ID: <CAADnVQLXFWDDV8xGLVRNd9JXaqOMfCO3ZGtuQUg8CZjrwLjxrA@mail.gmail.com>
Subject: Re: [bpf-next:master 5/7] kernel/bpf/core.c:900:5: warning:
 '__pte_index_size' is not defined, evaluates to 0
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>, Song Liu <song@kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, oe-kbuild-all@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 3:05=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Hi Alexei,
>
> On Sat, Mar 9, 2024 at 5:38=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Puranjay,
> >
> > Looks like I have to drop this patch for now,
> > since PMD_SIZE is not a constant on all archs
> > that can be evaluated by a preprocessor.
> >
> > We need to find a different way.
> >
>
> How about we define it like:
> -#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
> +/*
> + * PMD_SIZE is really big for some archs. It doesn't make sense to
> + * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE to
> + * 2MiB * num_possible_nodes().
> + */
> +#define BPF_PROG_PACK_SIZE ((PMD_SIZE <=3D (1 << 21)) ? (PMD_SIZE *
> num_possible_nodes())  \
> +
>                              : ((1 << 21) * num_possible_nodes()))
>
> So, it will be computed at runtime. This adds more performance
> overhead but this is called very infrequently
> so shouldn't matter.
>
> Or we can hardcode it as `2MB * num_possible_nodes()` because
> PMD size in most architectures will be 2MB or larger but never smaller.

I think hard coding is cleaner and less surprising.
I'd like to hear what Song thinks about it.
