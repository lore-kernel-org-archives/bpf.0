Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB037DE8B
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256412; cv=pass; b=J4SD0UU4S8p/KDgOwt1YjlXvcs3zSbiEXdOgv/ha/0YZgT3Fy4rh8smfiIu5Bqyha9/2+JmkLLTKgJZhav35gsK4ffTkjWgAEQP+Gv27eRS8hwh0aE+JcOWwbq/DJ9whfRyqIIZhwaLobRrQRmmgrT5qeq/ke7zxdtz7XcIrCj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256412; c=relaxed/simple;
	bh=BwfqZD4DTyN3rQrmq6CGBm59V05ztP968MLEzM3r3qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8Uoz08bo7aZ3S6eEZ7xmkfkzt/rbcgVIBcvCMIJ9saeeynDNtTnaxIRkGDb6RGSzzCXEx8GmwQh4t16crdcc1ACcz/mHiKcZWOTVsy6B6ZL7RCDLL/r66mooyv/hQ3CYvxLPfptItYKbXHvra9veWfU7iaPQJL8hi8d4Z5QSaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAEYs9G1; arc=pass smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAEYs9G1"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso58815e9.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 09:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256409; cv=none;
        d=google.com; s=arc-20260327;
        b=K3neCOWfcLjt6CBHuEuyGJ4mslQEMXyDBmACOU+l04qoVkt+whXIUDQEW/El1T59BK
         +EqUYE32+WFdaDCor0bSRxmWq2Ti5hHHjMcnNj98tDb9Hbqm0tMl7GiiGpNfkJ7a11BM
         iR9BKArsTqh6LWt4svG3ajtrJ7HPv6l3UMxCZH7U716AqN8CfKqeVvuzblRhSfJmh4c5
         pzxAe//Lud4IvRpG2/RuHKJQhLhLyeoRtMUj1a7bu0/A1+Z9wA4L8YWUOUXkIwm54/gz
         IZfQwQNjxa0uYcmmvMBwAtfjocqXsVSZZt5aKYgNGYt7zZzcuqWFRfGPnpNs7vlHY32t
         BRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=56z/MKZ4OWOERXAM1HgOr993UY7BxATy5B5JMp1aKhk=;
        fh=87loOwcQ6RqKKMQsqYtNvsPKSjXi8CdjTbciSle5NKQ=;
        b=XbaRiL50Lpu/z8tfzOJqUNmBA6HQNK8YZ6y6PK9ufwwqNQV9sdchBEOlPmz67+O+Ck
         3jxPh/OC6akmRAyf1saqsEBkHNJ9aO2CJ1yiOZBEMtwhS+HBi2Xk0ptPeoD2HDc1lVsR
         JL7iyzF8zvwRfupB3tlkoOu7RjHY654u/ppuXWElhoh3oSpkQD08jHMUsWmYKR7uqhOy
         zCfiEzy1sLwQWDrXm8Nsq4f12P5CJ/LviDwNtJkRxCz1IJW8H/SYQR1rOkuKoOMxRGNg
         m8GGNLY3uCKf41kMLWFkRI7NBoAj+KG12dyAVGvwMm/bbNi+tzs5N9wKJROQbAUDsY27
         npLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256409; x=1785861209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56z/MKZ4OWOERXAM1HgOr993UY7BxATy5B5JMp1aKhk=;
        b=fAEYs9G1y8VJZgv013wanTdy84hqB37AoFF/7oMrbH1XAjhlxKDmC6upkkqrzST1W3
         FOC4/SkDTdDHbFW98aKHnxIihvC5HsBKqkGunZSQ8wWpzVh8JqyrTIbKG1lxfcVWxH1T
         LONlxKuKoNlwr1pu6UlalCwrl3H6CXNeSy6we1f5Hn+/iCDaoxI86uioQyibtiveLHh+
         OVJZpqpE+8FfsELfpOjJVI4iqHT0VeleOxuecYsayVwF94Xb85SPvPtQVONnoR5AMh2c
         f3PnehRZAD0ZyWxdc8GXrIyXdnI+96fZD4LxkoBjYy7gvGJBJbp9Uhx0WksV5kDVGhak
         x5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256409; x=1785861209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56z/MKZ4OWOERXAM1HgOr993UY7BxATy5B5JMp1aKhk=;
        b=D6r76+fRGtqZuUGlLS8/jgEciSivmaV2ARiyrWrp8FH6InUEBsp02kxIibCmr30U2s
         +KIOw6faEQp6ziS4tGbGa2ZAKbfunTsTISA3hPBbtYRR3RBkPM9zdT1WrccKMaUrk1De
         9EZ52GqNMVCYxSkppUv50/GXSdBk2pMOf/yu7oJkIX7bekcQCBIcp4swYnyO6l0iN8pS
         5rRs8oub3hIOnlX4maPqhfoUldYM2dJaeBdtvxvpr0cSZJDLqCwl1Dm+WBSrbm6D6Qsq
         BnndPvO1aXTwxG/B7Tx6Hl7nHSFu7QhetYFQNzHT7T/iuS4X0yWto6+kAQHopb6Zr6B4
         uAmg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9Xkx9U3rhGhk+ee092RrYGyI1EyNXD7CjOxEQAT//BzDiH5khJ0K7v46aHgazHIz34Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpCGWeKZ/CMeZvCOgNUwzkClDRGPdzvSzG0LkktK3lnN34GLhz
	wqNTTXfQ6rEoBxzJ0YSKAbocSz1pVGGqOg93FNVszzwVIXA+Yj2mBSMf0ooRMZVhdWpvlAqa6Uz
	XMhVpfuHSPKZliAognCiB1IXNet5DWaU=
X-Gm-Gg: AR+sD117lfuAjQya2rvmTnic+0uV98ryEToRz/BwCMG6AwmXDK2OUTdXrgmBhW2wTBD
	239OOOqDu2jpw1Gh96/2UitycFA04C8XVVfoBIjvieHX1K9lNGkVSNynQu5BF5vv0BJjknStbih
	uvRzU+7Jdwmx0b5zt89qRAv1gB+u3ayZOTdCzaiEfNJneMKCOzQhAuyMDAargw9xUCq+ix8s8tr
	q8TPViK8xhK2SmCQarZFuO72XZcuLWmd7wQ1IpHCettOQ+DMvbv1uV6/F/Ir17db8pVy3J9NpPt
	pyDbgjuljJDnqqC/K4Qu023gPtyMwZcIiBs1G72qIMI2L+gDpMZo0T/oxiHv2HZ9WHN+J2EIWrS
	j8eqarzUq/ZHwMIXpvgLkfPFlW78fUoSJo8hWSA==
X-Received: by 2002:a05:600c:a016:b0:495:472c:208d with SMTP id
 5b1f17b1804b1-496c659ff4cmr33802765e9.38.1785256409376; Tue, 28 Jul 2026
 09:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <CAEf4BzZkJrOZX8AWmk4AmGZvo1Dd7F6UraU1DFa16SiEEQiPFA@mail.gmail.com>
 <CANk7y0gekFOEO2WffS1Ms8_n7G73QxRmykVVxp903bCkT0N-iQ@mail.gmail.com>
 <DKABWUUIQ4RA.JP5SHXL2VMXA@gmail.com> <CAEf4BzYL1NykSg1-A8+EAKVmn-MGwvstLaSmguCxP_AHtx8thQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYL1NykSg1-A8+EAKVmn-MGwvstLaSmguCxP_AHtx8thQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 28 Jul 2026 18:32:52 +0200
X-Gm-Features: AUfX_mxjPR3kGUuPsnnasFEhST1YZMhH4oo4rdTy6SEfShJi9I8ICZ0pZ83VZbQ
Message-ID: <CAP01T762eHApzPZwnBCKNfBQxhdumcD68Bozc5W07Hx4j2GO8g@mail.gmail.com>
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

On Tue, 28 Jul 2026 at 18:29, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Tue, Jul 28, 2026 at 9:02=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue Jul 28, 2026 at 5:59 PM CEST, Puranjay Mohan wrote:
> > > On Tue, Jul 28, 2026 at 4:56=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > >>
> > >> On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@ker=
nel.org> wrote:
> > >> >
> > >> > The bpf_for(i, start, end) macro is BPF's open-coded numeric itera=
tor. It
> > >> > expands into calls to three kfuncs: bpf_iter_num_new() to set the =
iterator
> > >> > up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destr=
oy() to
> > >> > tear it down. The verifier emits these as ordinary kfunc calls, so=
 a
> > >> > bpf_for() loop pays function-call overhead on setup, teardown, and=
 =E2=80=94 most
> > >> > importantly =E2=80=94 on every single iteration via bpf_iter_num_n=
ext().
> > >> >
> > >> > All three kfuncs are tiny and only touch the 8-byte on-stack itera=
tor state
> > >> > (struct bpf_iter_num_kern { int cur; int end; }). That makes them =
good
> > >> > candidates for inlining, the same way several other special kfuncs=
 are
> > >> > already open-coded in bpf_fixup_kfunc_call(). This series replaces=
 each of
> > >> > the three calls with an equivalent inline BPF instruction sequence=
:
> > >> >
> > >> >   - bpf_iter_num_new(): the (s64)end - (s64)start overflow check i=
s done
> > >> >     with 32-bit arithmetic (start <=3D end is checked first, so th=
e range
> > >> >     fits in a u32), avoiding cpuv4 sign-extension insns that some =
JITs do
> > >> >     not implement. Returns the same -EINVAL / -E2BIG / 0 as the kf=
unc.
> > >> >
> > >> >   - bpf_iter_num_next(): the hot path. Since cur and end are int, =
the
> > >> >     kfunc's (s64)(s->cur + 1) >=3D s->end test reduces to a signed=
 32-bit
> > >> >     comparison of (s->cur + 1) against s->end, so the inlined code=
 uses a
> > >> >     32-bit compare with no sign extension.
> > >> >
> > >> >   - bpf_iter_num_destroy(): a single 8-byte store zeroing the stat=
e.
> > >>
> > >> tbh, I don't think we need to do *anything* in bpf_iter_num_destroy(=
),
> > >> not sure why I added that zeroing out there. that stack slot will no=
t
> > >> be treated as iterator state after destroy() is called, so what is
> > >> stored there doesn't matter, we can simplify (unless I'm missing
> > >> something non-obvious, but I can't see it)
> > >>
> > >> >
> > >> > bpf_for() is frequently used with constant bounds; in that case th=
e range
> > >> > checks in bpf_iter_num_new() are decidable at verification time, s=
o a
> > >> > follow-up patch elides them and emits only the iterator init (or t=
he error
> > >> > result). The inlined shapes are pinned by new __xlated selftests, =
and a
> > >> > bench_bpf_for benchmark (modeled on the existing bpf_loop benchmar=
k) runs a
> > >> > bpf_for() loop with an empty body to measure the per-iteration cos=
t.
> > >> >
> > >> > The emitted instructions are plain BPF and remain valid for the
> > >> > interpreter, so interpreter fallback stays correct and no jit_requ=
ired
> > >> > marking is needed.
> > >> >
> > >> > Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):
> > >> >
> > >> >     +--------+---------------------+---------------------+--------=
-------------+
> > >> >     |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf_f=
or inlined   |
> > >> >     +--------+---------------------+---------------------+--------=
-------------+
> > >> >     | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 M/=
s (0.111 ns) |
> > >> >     +--------+---------------------+---------------------+--------=
-------------+
> > >> >     | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 M/=
s (1.858 ns) |
> > >> >     +--------+---------------------+---------------------+--------=
-------------+
> > >> >
> > >> > On x86-64, removing the per-iteration call to bpf_iter_num_next() =
roughly
> > >> > doubles bpf_for() throughput. On arm64 it is neutral: the loop is =
bound by
> > >> > the load/store dependency chain on the on-stack iterator state rat=
her than
> > >> > by call overhead, so inlining neither helps nor hurts there. It st=
ill
> > >> > removes the calls.
> > >>
> > >> exactly, and those removed calls should be noticeable in such
> > >> microbenchmark... also, bpf_loop being faster than bpf_for() is a bi=
g
> > >> surprise. let's dive deeper into this, this makes no sense
> > >
> > > Yes, I will do more perf testing before posting the next version.
> > >
> > >> > bpf_loop() is shown for reference only; it is a different construc=
t (a
> > >> > callback invoked per iteration), so the comparison is structural r=
ather
> > >> > than a measure of the inlining: on x86-64 bpf_for() is faster than
> > >> > bpf_loop() even before inlining, while on arm64 bpf_loop() is fast=
er
> > >> > because bpf_for()'s per-iteration cost is dominated by the stack r=
ound-trip
> > >> > through the iterator state.
> > >>
> > >> hm, again, I'm not sure I'm buying this. bpf_loop() does indirect
> > >> function call, stack access can't be more expensive than that, can
> > >> it?..
> > >
> > > No, the above explanation given by me is not accurate, it was my
> > > theory but it didn't hold up when I looked into perf reports. So, I
> > > need to dive deeper into this.
> >
> > It might also be worth comparing cases where verifier does inline and d=
oes not
> > inline bpf_loop, the latter can often be the common case for some progr=
ams, and
> > may help appreciate the improvement more.
>
> we actively discourage bpf_loop() in favor of bpf_for() or may_goto
> approach, so let's not invest in (complicating verifier for the
> benefit of) optimizing bpf_loop()

It's not complicating the verifier, just comparing against bpf_loop in
the benchmark where the loop count is not known to the verifier
(probably 20 more lines in the BPF side to serve as a comparison
point).
