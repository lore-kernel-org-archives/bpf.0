Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0943793BF
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256521; cv=pass; b=eP5l0IomW9o4+Y9C4MmGGnzJY0zCRqACYGUYK04CBJFtyPHtFbw/O/2ESdu3Rb47Z4OS8PPirdTitmPs39SwIcK8DS/H/s/I56dyxBGK+4wJANoRUXu9IYOYi59/90FCQZd2wXGdf5UzAgvAU6a0DC7D5WX6LA1MhenrfWlXd2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256521; c=relaxed/simple;
	bh=r7vu9KaOr1UDmH5BMlyCBD68emY4pWXfVsDE6fwfafA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRCE/CyZe/tsAFwqyX3sVTmgQQRB3ylRtaw18+c6oPUzJT+0wcDXVkOpgqDDQcHer+P1aZK8CGZdKM01BYHDDMHR0BM29ZzUB08MlMdEJ1yWULRBikGpiks9fJcDvfzornRr3YhlwdHneL78wPMbHaHx/h2cSKGXCWcxdUi+v+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMoO34Ne; arc=pass smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMoO34Ne"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4955674321eso70215e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 09:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256518; cv=none;
        d=google.com; s=arc-20260327;
        b=KZrQEVcQ3j63hLZKz4F4xedeIWPIH0NGkNT6d3krRCMXOeFGlDdtLiwPJwlxwAzgaB
         p9MzI7W/e1VcT+1aCF0zCX0mytrHD24ZUlX0MhmO5ITQtmCDaeZoKnhCQMdPa/S3crTX
         9hZAxNETLPq5m0Q1n8OzaW07VOnPkpg+VPFFPC2Tjb3aAFwZwB0piuiVE3xzQW8d/0Co
         Nv6Qx+6lCG5LAj3+bRl+q7LFOOwZorauFH1B8r3JzZzwiKz2JBSdq9+Bns5FxTabZQ2A
         JnLxnvnxsBRCm3ClnWmuU31w4epyaz/lZpvT3H0KtwDKir3lSxmF2oWWNM4KLrn+Zjk7
         PSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=91SXdvBwwRg9mXoNbh924nxnzcg/KPhpDWjvhLpasl0=;
        fh=LtugxjIuFdFxg3pFKRkHlGuDIxqsPPmV42XYVpdD8Ms=;
        b=eOItxzx7ToznH/y9goRGhhpGIrDySeFPSvv5pJLEhHgJ024rkkRMaKuBoKFUXpbg6X
         K3uwoSjW9rri3hVaV6rfr9Ydal5sikTBMk8AkRAuTUeYay8y0jXio6OOdjMtPvwigKEy
         fIqHeEh9NJ/yx6PBU4JT7GjoefyGZCPxTLKt58+ERI0abAClURdRjN+LBdiAPo/VC9Hc
         Lh23P1+KI2clpphAcbaeS0Cuhb4CpNi3xzMxOk2KN0/IYuW3DQkzRVMQ2sqNeKOWMGye
         8+BO1keoq5w0TwNwQdq0Lxf/Sf2K8VMAnll3WEgEHIX2s+xgTvggkPhjwEEE7uVxoTvs
         AsEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256518; x=1785861318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=91SXdvBwwRg9mXoNbh924nxnzcg/KPhpDWjvhLpasl0=;
        b=nMoO34NekI6oxAcKpFKRLYRaBnqhy+KJmWQRjIQkOh3ZmRumd0ulv0M9Cqlcar113a
         BsCzFwefYsoaGJB1uPdLQ3tQyU5af0XG3l0Xcm+1nRm4n5bUptNKoTizIYUGda23cfQE
         Z0ywwzGVvIuvcFDph80NoDQurXDODqY7W7o0x5T9JdT2RigDd0X8prc3h+uR+j65eMN1
         umI1VozpoAkvgts8JTRK+uVrUYGeV/7nQlUqwwT58DfcphGQVftaZLaXYtI8X30GJFTM
         XWkWVvNIIq5UDj55WR37wBrEVcnqsE2AeqfHTXfsKSlbwgQsBvMjijPtsiMu/zCS1X1B
         S/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256518; x=1785861318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=91SXdvBwwRg9mXoNbh924nxnzcg/KPhpDWjvhLpasl0=;
        b=kCqgMpunAod/0JO/lTBtMulLv6wIBNTbdDS2u76/xBlu5WBzlKadV3grZoEG2rlzdq
         KrIm3+bENSwfOzhzf9zHOsNOqZaQYBp2WhbN8lSkVk+Yg567sJQVelw2qNRbo1zwurp5
         0USnpSi5qjAA4JJc/KXSpDqxkzb7t2xzx8Ja+v7CPEzQyulsQfU62EKf70/dxTQSofp1
         5ALgZ63a75rgZ3k/NHxzcLgI4brUn90789RCbVBPuOteXFR4j9BS7ZHsYksbWOxD15Qm
         WXq/8mRE0DSqLuZxXkND0yZc4dpncENCH/H5iYoxKOQAmGx3nL9M0GCHJuUUWqsv4Twz
         aS5g==
X-Forwarded-Encrypted: i=1; AHgh+RpixNQpEl0R29ouiLCQUJLaXBwe2yrFb+TyT+XKfOsUp26I3odl1T/kO+x0ww0SDHNE8/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0m7UHhG0Vqz4d9mZIaRAzvv3fsx/FwzzDzjBwUtHfXdIGETE
	KP8UuxLVg3Txll63NnuYasgNW3ERMWGoX9DWn7hjMdYR5eSjVoH8zjvg2OxbBBxfsILrzvpiGKx
	3EimDdjw+xgXTOA2Kh4oXi0l77n1BNbs=
X-Gm-Gg: AR+sD10WBL4mHf1WTxcl8rUxzRJH6CnjjauwY1Jc69dSA4w3RZIMXjtDUnDiv0O1gFD
	u5An7wB+MEkHexjmR+/0+l3rnPVJ25u8NzbDTYtIQMhKn9OKmfEHZC47INgydjH5duIflFDNlBm
	0V+IYe7sqc0w2YNuvuKXpYjo0X/IeOwt024iFmtgkz0Xd9rmOZlK2YRRGvkRE2gv6++yFgOF1ES
	jMewTHS4HU4IBGjwuj2G0m2TTLQaKgHsfTG8YwOQ5t/8rIZn7vqsa3kl2mJl6G1rX0UvhTqsVBp
	BD5wZMaouckJ4/ugWJinKg8bVOaTXOujlUM+dAlTioYXkjIpI1EjfplHUtslCoPOJ584xInb9AP
	Z01rmXLaDd11w/sGKUooEvpVJfunU3MSyUxzlgdfdwIN/YnfH
X-Received: by 2002:a05:600c:3103:b0:495:7287:293d with SMTP id
 5b1f17b1804b1-496c657801cmr34232595e9.27.1785256518207; Tue, 28 Jul 2026
 09:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
 <CANk7y0gekFOEO2WffS1Ms8_n7G73QxRmykVVxp903bCkT0N-iQ@mail.gmail.com>
 <DKABWUUIQ4RA.JP5SHXL2VMXA@gmail.com> <CAEf4BzYL1NykSg1-A8+EAKVmn-MGwvstLaSmguCxP_AHtx8thQ@mail.gmail.com>
 <CAP01T762eHApzPZwnBCKNfBQxhdumcD68Bozc5W07Hx4j2GO8g@mail.gmail.com>
In-Reply-To: <CAP01T762eHApzPZwnBCKNfBQxhdumcD68Bozc5W07Hx4j2GO8g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 28 Jul 2026 18:34:41 +0200
X-Gm-Features: AUfX_mxNYhOKij2sb4oDc-0PcrEojyczg1VnrNaqWfe-03ljvfSzd2dY-H1ZOYE
Message-ID: <CAP01T77XGB4BSVfLB99B9nAJrSMHgq+54EQ=zcHvjonXW8q0RA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Inline the numeric open-coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 at 18:32, Kumar Kartikeya Dwivedi <memxor@gmail.com> wr=
ote:
>
> On Tue, 28 Jul 2026 at 18:29, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Tue, Jul 28, 2026 at 9:02=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue Jul 28, 2026 at 5:59 PM CEST, Puranjay Mohan wrote:
> > > > On Tue, Jul 28, 2026 at 4:56=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > >>
> > > >> On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@k=
ernel.org> wrote:
> > > >> >
> > > >> > The bpf_for(i, start, end) macro is BPF's open-coded numeric ite=
rator. It
> > > >> > expands into calls to three kfuncs: bpf_iter_num_new() to set th=
e iterator
> > > >> > up, bpf_iter_num_next() once per iteration, and bpf_iter_num_des=
troy() to
> > > >> > tear it down. The verifier emits these as ordinary kfunc calls, =
so a
> > > >> > bpf_for() loop pays function-call overhead on setup, teardown, a=
nd =E2=80=94 most
> > > >> > importantly =E2=80=94 on every single iteration via bpf_iter_num=
_next().
> > > >> >
> > > >> > All three kfuncs are tiny and only touch the 8-byte on-stack ite=
rator state
> > > >> > (struct bpf_iter_num_kern { int cur; int end; }). That makes the=
m good
> > > >> > candidates for inlining, the same way several other special kfun=
cs are
> > > >> > already open-coded in bpf_fixup_kfunc_call(). This series replac=
es each of
> > > >> > the three calls with an equivalent inline BPF instruction sequen=
ce:
> > > >> >
> > > >> >   - bpf_iter_num_new(): the (s64)end - (s64)start overflow check=
 is done
> > > >> >     with 32-bit arithmetic (start <=3D end is checked first, so =
the range
> > > >> >     fits in a u32), avoiding cpuv4 sign-extension insns that som=
e JITs do
> > > >> >     not implement. Returns the same -EINVAL / -E2BIG / 0 as the =
kfunc.
> > > >> >
> > > >> >   - bpf_iter_num_next(): the hot path. Since cur and end are int=
, the
> > > >> >     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a sign=
ed 32-bit
> > > >> >     comparison of (s->cur + 1) against s->end, so the inlined co=
de uses a
> > > >> >     32-bit compare with no sign extension.
> > > >> >
> > > >> >   - bpf_iter_num_destroy(): a single 8-byte store zeroing the st=
ate.
> > > >>
> > > >> tbh, I don't think we need to do *anything* in bpf_iter_num_destro=
y(),
> > > >> not sure why I added that zeroing out there. that stack slot will =
not
> > > >> be treated as iterator state after destroy() is called, so what is
> > > >> stored there doesn't matter, we can simplify (unless I'm missing
> > > >> something non-obvious, but I can't see it)
> > > >>
> > > >> >
> > > >> > bpf_for() is frequently used with constant bounds; in that case =
the range
> > > >> > checks in bpf_iter_num_new() are decidable at verification time,=
 so a
> > > >> > follow-up patch elides them and emits only the iterator init (or=
 the error
> > > >> > result). The inlined shapes are pinned by new __xlated selftests=
, and a
> > > >> > bench_bpf_for benchmark (modeled on the existing bpf_loop benchm=
ark) runs a
> > > >> > bpf_for() loop with an empty body to measure the per-iteration c=
ost.
> > > >> >
> > > >> > The emitted instructions are plain BPF and remain valid for the
> > > >> > interpreter, so interpreter fallback stays correct and no jit_re=
quired
> > > >> > marking is needed.
> > > >> >
> > > >> > Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):
> > > >> >
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >     |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf=
_for inlined   |
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >     | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 =
M/s (0.111 ns) |
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >     | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 =
M/s (1.858 ns) |
> > > >> >     +--------+---------------------+---------------------+------=
---------------+
> > > >> >
> > > >> > On x86-64, removing the per-iteration call to bpf_iter_num_next(=
) roughly
> > > >> > doubles bpf_for() throughput. On arm64 it is neutral: the loop i=
s bound by
> > > >> > the load/store dependency chain on the on-stack iterator state r=
ather than
> > > >> > by call overhead, so inlining neither helps nor hurts there. It =
still
> > > >> > removes the calls.
> > > >>
> > > >> exactly, and those removed calls should be noticeable in such
> > > >> microbenchmark... also, bpf_loop being faster than bpf_for() is a =
big
> > > >> surprise. let's dive deeper into this, this makes no sense
> > > >
> > > > Yes, I will do more perf testing before posting the next version.
> > > >
> > > >> > bpf_loop() is shown for reference only; it is a different constr=
uct (a
> > > >> > callback invoked per iteration), so the comparison is structural=
 rather
> > > >> > than a measure of the inlining: on x86-64 bpf_for() is faster th=
an
> > > >> > bpf_loop() even before inlining, while on arm64 bpf_loop() is fa=
ster
> > > >> > because bpf_for()'s per-iteration cost is dominated by the stack=
 round-trip
> > > >> > through the iterator state.
> > > >>
> > > >> hm, again, I'm not sure I'm buying this. bpf_loop() does indirect
> > > >> function call, stack access can't be more expensive than that, can
> > > >> it?..
> > > >
> > > > No, the above explanation given by me is not accurate, it was my
> > > > theory but it didn't hold up when I looked into perf reports. So, I
> > > > need to dive deeper into this.
> > >
> > > It might also be worth comparing cases where verifier does inline and=
 does not
> > > inline bpf_loop, the latter can often be the common case for some pro=
grams, and
> > > may help appreciate the improvement more.
> >
> > we actively discourage bpf_loop() in favor of bpf_for() or may_goto
> > approach, so let's not invest in (complicating verifier for the
> > benefit of) optimizing bpf_loop()
>
> It's not complicating the verifier, just comparing against bpf_loop in
> the benchmark where the loop count is not known to the verifier
> (probably 20 more lines in the BPF side to serve as a comparison
> point).

... and I meant loop flag, not loop count. See update_loop_inline_state().
