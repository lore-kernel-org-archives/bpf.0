Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86235330650
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254390; cv=pass; b=D+GvDPDgK4R03fLP7fLHBWUz+1H56jTbDuxLcPQUxb0BbllNO4pS2DTfDTfsuhHT8mziMfJudatazFM58hBdhvd12RY5jOCh0Q788raH74d1I4q99oicrmWfWVkDG8Clp43KzDGGioJF6MMW+JZiVtb1b5uNud80F2fu/s9+ySc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254390; c=relaxed/simple;
	bh=dEjDwyEVkwsE1xoJMOAGWZRJEBNCQG+1qD+VCWHiP6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3oP2vX+0bvTW3EubwRAl1dXq0gN1vPLa1W9kAIPBaImOo2GYIfKtWIaGg1DpszGey5WLcJjUdXuJJ4VPxwORMEucAm8ZwExA8swIBo5Uq+UpGBIthb6l8/aimlANR5jxsWIJy4IwOMES+7FyxLRluLi0NcaSQiOwb26vwgA/JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFhD7ih4; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFhD7ih4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso570578766b.3
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 08:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254385; cv=none;
        d=google.com; s=arc-20260327;
        b=Zl/PapuooXFCf6wbSEKhkk95H8qvGRyIyfFxacR75xEhQWB4yxJfy3k4IdFXEMPA1l
         GKEVRMZ+rRv9vkHSmjDl3wx6CUKWgXUTW+SaKULB6AeqWBEOtd5TpXSUcsMfiXUvjjn+
         8bRgF98UkL53jMI4Anmx0oNEOxhrt+8gxKoB6kerYCEPBeHyUVObLXYwYm/GIPUNmbKH
         Sbq8qGtTTKDp4nMyRCeK+JsLQsteVDKbWLv4Od7uDTWZiXECUd1aXOY7g39QA79H198z
         PsL/fINolcL9T7t3ANqZMNF7N3OMUXMs+4Wgpvdu5Y3RjYf4kLs7HlD8Gnw1sE/pXzj0
         myoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kshsBf+tEtih6jmfRLVjate30fn0hjOdEB3K2dHTDVQ=;
        fh=24LX0EBZi1fjEmmAr1OVyU5k434fGyDRzFwwZ9IIh/I=;
        b=VkVp7rQPVk2NFeCf+w9J5O8kgCXGGkHQfze7eCNU1rOHaU3KcN6ccyPIjXyZ9Zd1UZ
         5cyp+QujxMego1c317/ofQ7+AgCWIHTGN9m5nFpxoRJWcp1uWp3sFJcJYR4UAOdLEYqS
         m6O/Cz2YfGDtsLPeCH9XS7t5YHsnNk6p63TtDpzEJaLQc36OLs+ypV78lEf4lchxpo4M
         YelptGhzhvqUGP23DjZDjeW3TQM+WKxu85PWxPsjm6b4VIR71irZVX3vRbdl1qv4Vyrw
         vLt/YIjMtl5NpcYMEMTzl4CGmOzpq0crT8APHV3FcpcczFfiES6FZrrMutfw8WijAvt6
         FlJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785254385; x=1785859185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kshsBf+tEtih6jmfRLVjate30fn0hjOdEB3K2dHTDVQ=;
        b=SFhD7ih4UTyovR4JZreqpmf90JEoAu1cUJbn9QbzeMbXav+su2KIwDAxifDnKXeD9q
         iMxRqamZHnQ6GebOv9TkEQZp6HVmIFCyK6htBWXyH/XiWPck690EGyYqLrz0ePjB6Pwx
         DzpNYjExkxbSHYu7RIdJsov+i8SFppof75WSUJxTAcO7Dk+UuhYGBdaXQ1cxG0yik5xZ
         UYwMhdXG4FM9K2ZNW/235Guq4RPw0WomSwZJDs1qN5uyQnxb9D/URo9jxgZZrLf8+XQh
         UnrAd7jXeSyim31a53iUhmiOmgHAcuRgt8nlgkkPyFEhxlrZpZwunC7iIeSvxR2Nn/gm
         dsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254385; x=1785859185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kshsBf+tEtih6jmfRLVjate30fn0hjOdEB3K2dHTDVQ=;
        b=iARBAU53T8DMycFrLiZabQ1f6Ubw5iC40ZHndxChOopPsZKYHX0If9xGqTbTT6FdPW
         Nz3epeeBPp2QrTNSZbc+YI+lV4yY1dn7VIgzJzzn2OEU20AjoejmG7BIYMhUs/lssKIR
         HBF2c/IiS8XdCWDhxM+ZWnMiUdp/pd4EI6JNyWAdgKo7r9PMe0BQFlUAqNdFnohXMNVb
         7uE4Q1hCiKGE9ThEKtgyf7zv9QGRhMJ87LRxrgSNplJtLrVSie/9vh/uZWB4iMJ5SOu0
         lbwMgfSqvq6EevID/prXZmQRt+a6rxOA7bsf2TOCudFXZyr1S7tcLJbEuJI5lj73YPvl
         GB6w==
X-Gm-Message-State: AOJu0Yw6vPExi70ZaQGv7DVBaOk28MRRtcsPrhoBwMlSTb1T+Gx8uIkp
	+IhJgkXW6LpOAB64q9LyuQMk+RYHShTUvKd8XnjQrw0HTZrGIVCe2empnscsEpEw16anrtwzVXw
	UKmfWeC+FPdZY4yHxMAL3ffZaxl6Io+0=
X-Gm-Gg: AR+sD10GbyF7LDX/kzfVcScKdBQWLMh+cszUhhILUqvAEsucwRwov7TpP0MCFfO2pVA
	OD+iLh20PF4GmpjXKGnwEB9plvxoFdwQ2B1pTqZwwbEn7QskWXQjlYVzwp6EFc+v37Yk0x99Dcy
	go86l7SJ6/K+IC73cMNLa3bSqaOLY2nY3IU/mfhA9fjVy2Mzf7rvS/ObP+LZWoqMg9s4s7d2HBf
	vyliLDIwuFn0qZc4j3Oakaizs26D7w7OtHcnqN4plHAvsbeodaKm7aY4lgsBXcF8/N0FzWj4Nx0
	UvwYTWmV7Y9L
X-Received: by 2002:a17:906:fd8a:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-c1f7215e03bmr146608766b.5.1785254384849; Tue, 28 Jul 2026
 08:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
In-Reply-To: <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 28 Jul 2026 16:59:31 +0100
X-Gm-Features: AUfX_mzVGSGNiBC3oDOQPbk2h2orAWn9GFQKebfzLkE69Gnzch_GZqJt4FRYKhM
Message-ID: <CANk7y0gekFOEO2WffS1Ms8_n7G73QxRmykVVxp903bCkT0N-iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Inline the numeric open-coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator. =
It
> > expands into calls to three kfuncs: bpf_iter_num_new() to set the itera=
tor
> > up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy() =
to
> > tear it down. The verifier emits these as ordinary kfunc calls, so a
> > bpf_for() loop pays function-call overhead on setup, teardown, and =E2=
=80=94 most
> > importantly =E2=80=94 on every single iteration via bpf_iter_num_next()=
.
> >
> > All three kfuncs are tiny and only touch the 8-byte on-stack iterator s=
tate
> > (struct bpf_iter_num_kern { int cur; int end; }). That makes them good
> > candidates for inlining, the same way several other special kfuncs are
> > already open-coded in bpf_fixup_kfunc_call(). This series replaces each=
 of
> > the three calls with an equivalent inline BPF instruction sequence:
> >
> >   - bpf_iter_num_new(): the (s64)end - (s64)start overflow check is don=
e
> >     with 32-bit arithmetic (start <=3D end is checked first, so the ran=
ge
> >     fits in a u32), avoiding cpuv4 sign-extension insns that some JITs =
do
> >     not implement. Returns the same -EINVAL / -E2BIG / 0 as the kfunc.
> >
> >   - bpf_iter_num_next(): the hot path. Since cur and end are int, the
> >     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a signed 32-b=
it
> >     comparison of (s->cur + 1) against s->end, so the inlined code uses=
 a
> >     32-bit compare with no sign extension.
> >
> >   - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.
>
> tbh, I don't think we need to do *anything* in bpf_iter_num_destroy(),
> not sure why I added that zeroing out there. that stack slot will not
> be treated as iterator state after destroy() is called, so what is
> stored there doesn't matter, we can simplify (unless I'm missing
> something non-obvious, but I can't see it)
>
> >
> > bpf_for() is frequently used with constant bounds; in that case the ran=
ge
> > checks in bpf_iter_num_new() are decidable at verification time, so a
> > follow-up patch elides them and emits only the iterator init (or the er=
ror
> > result). The inlined shapes are pinned by new __xlated selftests, and a
> > bench_bpf_for benchmark (modeled on the existing bpf_loop benchmark) ru=
ns a
> > bpf_for() loop with an empty body to measure the per-iteration cost.
> >
> > The emitted instructions are plain BPF and remain valid for the
> > interpreter, so interpreter fallback stays correct and no jit_required
> > marking is needed.
> >
> > Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):
> >
> >     +--------+---------------------+---------------------+-------------=
--------+
> >     |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf_for in=
lined   |
> >     +--------+---------------------+---------------------+-------------=
--------+
> >     | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 M/s (0.=
111 ns) |
> >     +--------+---------------------+---------------------+-------------=
--------+
> >     | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 M/s (1.=
858 ns) |
> >     +--------+---------------------+---------------------+-------------=
--------+
> >
> > On x86-64, removing the per-iteration call to bpf_iter_num_next() rough=
ly
> > doubles bpf_for() throughput. On arm64 it is neutral: the loop is bound=
 by
> > the load/store dependency chain on the on-stack iterator state rather t=
han
> > by call overhead, so inlining neither helps nor hurts there. It still
> > removes the calls.
>
> exactly, and those removed calls should be noticeable in such
> microbenchmark... also, bpf_loop being faster than bpf_for() is a big
> surprise. let's dive deeper into this, this makes no sense

Yes, I will do more perf testing before posting the next version.

> > bpf_loop() is shown for reference only; it is a different construct (a
> > callback invoked per iteration), so the comparison is structural rather
> > than a measure of the inlining: on x86-64 bpf_for() is faster than
> > bpf_loop() even before inlining, while on arm64 bpf_loop() is faster
> > because bpf_for()'s per-iteration cost is dominated by the stack round-=
trip
> > through the iterator state.
>
> hm, again, I'm not sure I'm buying this. bpf_loop() does indirect
> function call, stack access can't be more expensive than that, can
> it?..

No, the above explanation given by me is not accurate, it was my
theory but it didn't hold up when I looked into perf reports. So, I
need to dive deeper into this.
